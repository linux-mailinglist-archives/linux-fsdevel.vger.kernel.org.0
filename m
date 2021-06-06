Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5639D0A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFFTMz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhFFTMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:44 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97709C061280;
        Sun,  6 Jun 2021 12:10:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAe-0056Zn-CN; Sun, 06 Jun 2021 19:10:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 15/37] iov_iter_alignment(): don't bother with iterate_all_kinds()
Date:   Sun,  6 Jun 2021 19:10:29 +0000
Message-Id: <20210606191051.1216821-15-viro@zeniv.linux.org.uk>
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

It's easier to go over the array manually.  We need to watch out
for truncated iov_iter, though - iovec array might cover more
than i->count.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 21b3e253b766..bb7089cd0cf7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1339,27 +1339,70 @@ void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
 
-unsigned long iov_iter_alignment(const struct iov_iter *i)
+static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	unsigned long res = 0;
 	size_t size = i->count;
+	size_t skip = i->iov_offset;
+	unsigned k;
+
+	for (k = 0; k < i->nr_segs; k++, skip = 0) {
+		size_t len = i->iov[k].iov_len - skip;
+		if (len) {
+			res |= (unsigned long)i->iov[k].iov_base + skip;
+			if (len > size)
+				len = size;
+			res |= len;
+			size -= len;
+			if (!size)
+				break;
+		}
+	}
+	return res;
+}
 
-	if (unlikely(iov_iter_is_pipe(i))) {
+static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
+{
+	unsigned res = 0;
+	size_t size = i->count;
+	unsigned skip = i->iov_offset;
+	unsigned k;
+
+	for (k = 0; k < i->nr_segs; k++, skip = 0) {
+		size_t len = i->bvec[k].bv_len - skip;
+		res |= (unsigned long)i->bvec[k].bv_offset + skip;
+		if (len > size)
+			len = size;
+		res |= len;
+		size -= len;
+		if (!size)
+			break;
+	}
+	return res;
+}
+
+unsigned long iov_iter_alignment(const struct iov_iter *i)
+{
+	/* iovec and kvec have identical layouts */
+	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
+		return iov_iter_alignment_iovec(i);
+
+	if (iov_iter_is_bvec(i))
+		return iov_iter_alignment_bvec(i);
+
+	if (iov_iter_is_pipe(i)) {
 		unsigned int p_mask = i->pipe->ring_size - 1;
+		size_t size = i->count;
 
 		if (size && i->iov_offset && allocated(&i->pipe->bufs[i->head & p_mask]))
 			return size | i->iov_offset;
 		return size;
 	}
-	if (unlikely(iov_iter_is_xarray(i)))
+
+	if (iov_iter_is_xarray(i))
 		return (i->xarray_start + i->iov_offset) | i->count;
-	iterate_all_kinds(i, size, v,
-		(res |= (unsigned long)v.iov_base | v.iov_len, 0),
-		res |= v.bv_offset | v.bv_len,
-		res |= (unsigned long)v.iov_base | v.iov_len,
-		res |= v.bv_offset | v.bv_len
-	)
-	return res;
+
+	return 0;
 }
 EXPORT_SYMBOL(iov_iter_alignment);
 
-- 
2.11.0

