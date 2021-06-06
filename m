Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634FD39D0A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFFTMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFFTMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977CBC061283;
        Sun,  6 Jun 2021 12:10:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAe-0056Zr-Fu; Sun, 06 Jun 2021 19:10:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 16/37] iov_iter_gap_alignment(): get rid of iterate_all_kinds()
Date:   Sun,  6 Jun 2021 19:10:30 +0000
Message-Id: <20210606191051.1216821-16-viro@zeniv.linux.org.uk>
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

For one thing, it's only used for iovec (and makes sense only for those).
For another, here we don't care about iov_offset, since the beginning of
the first segment and the end of the last one are ignored.  So it makes
a lot more sense to just walk through the iovec array...

We need to deal with the case of truncated iov_iter, but unlike the
situation with iov_iter_alignment() we don't care where the last
segment ends - just which segment is the last one.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bb7089cd0cf7..a6947301b9a0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1409,23 +1409,26 @@ EXPORT_SYMBOL(iov_iter_alignment);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 {
 	unsigned long res = 0;
+	unsigned long v = 0;
 	size_t size = i->count;
+	unsigned k;
 
-	if (unlikely(iov_iter_is_pipe(i) || iov_iter_is_discard(i))) {
+	if (unlikely(iter_is_iovec(i))) {
 		WARN_ON(1);
 		return ~0U;
 	}
 
-	iterate_all_kinds(i, size, v,
-		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0), 0),
-		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
-			(size != v.bv_len ? size : 0)),
-		(res |= (!res ? 0 : (unsigned long)v.iov_base) |
-			(size != v.iov_len ? size : 0)),
-		(res |= (!res ? 0 : (unsigned long)v.bv_offset) |
-			(size != v.bv_len ? size : 0))
-		);
+	for (k = 0; k < i->nr_segs; k++) {
+		if (i->iov[k].iov_len) {
+			unsigned long base = (unsigned long)i->iov[k].iov_base;
+			if (v) // if not the first one
+				res |= base | v; // this start | previous end
+			v = base + i->iov[k].iov_len;
+			if (size <= i->iov[k].iov_len)
+				break;
+			size -= i->iov[k].iov_len;
+		}
+	}
 	return res;
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
-- 
2.11.0

