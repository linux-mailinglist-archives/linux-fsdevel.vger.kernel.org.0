Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4432139D09F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFFTMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F05C0613A2;
        Sun,  6 Jun 2021 12:10:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAe-0056Zd-6o; Sun, 06 Jun 2021 19:10:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 13/37] iov_iter: optimize iov_iter_advance() for iovec and kvec
Date:   Sun,  6 Jun 2021 19:10:27 +0000
Message-Id: <20210606191051.1216821-13-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can do better than generic iterate_and_advance() for this one;
inspired by bvec_iter_advance() (and massaged into that form by
equivalent transformations).

[fixed a braino caught by kernel test robot <oliver.sang@intel.com>]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5a02c94a51ab..5621a3457118 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1107,28 +1107,42 @@ static void iov_iter_bvec_advance(struct iov_iter *i, size_t size)
 	i->iov_offset = bi.bi_bvec_done;
 }
 
+static void iov_iter_iovec_advance(struct iov_iter *i, size_t size)
+{
+	const struct iovec *iov, *end;
+
+	if (!i->count)
+		return;
+	i->count -= size;
+
+	size += i->iov_offset; // from beginning of current segment
+	for (iov = i->iov, end = iov + i->nr_segs; iov < end; iov++) {
+		if (likely(size < iov->iov_len))
+			break;
+		size -= iov->iov_len;
+	}
+	i->iov_offset = size;
+	i->nr_segs -= iov - i->iov;
+	i->iov = iov;
+}
+
 void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (unlikely(iov_iter_is_pipe(i))) {
+	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
+		/* iovec and kvec have identical layouts */
+		iov_iter_iovec_advance(i, size);
+	} else if (iov_iter_is_bvec(i)) {
+		iov_iter_bvec_advance(i, size);
+	} else if (iov_iter_is_pipe(i)) {
 		pipe_advance(i, size);
-		return;
-	}
-	if (unlikely(iov_iter_is_discard(i))) {
-		i->count -= size;
-		return;
-	}
-	if (unlikely(iov_iter_is_xarray(i))) {
+	} else if (unlikely(iov_iter_is_xarray(i))) {
 		i->iov_offset += size;
 		i->count -= size;
-		return;
-	}
-	if (iov_iter_is_bvec(i)) {
-		iov_iter_bvec_advance(i, size);
-		return;
+	} else if (iov_iter_is_discard(i)) {
+		i->count -= size;
 	}
-	iterate_and_advance(i, size, v, 0, 0, 0, 0)
 }
 EXPORT_SYMBOL(iov_iter_advance);
 
-- 
2.11.0

