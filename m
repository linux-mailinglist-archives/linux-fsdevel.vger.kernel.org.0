Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0097839D0B6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFFTNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFFTMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC3C061226;
        Sun,  6 Jun 2021 12:10:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAi-0056dY-CA; Sun, 06 Jun 2021 19:10:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 37/37] csum_and_copy_to_pipe_iter(): leave handling of csum_state to caller
Date:   Sun,  6 Jun 2021 19:10:51 +0000
Message-Id: <20210606191051.1216821-37-viro@zeniv.linux.org.uk>
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

... since all the logics is already there for use by iovec/kvec/etc.
cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0ee359b62afc..11b39bd1d1ab 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -593,39 +593,34 @@ static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
 }
 
 static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
-					 struct csum_state *csstate,
-					 struct iov_iter *i)
+					 struct iov_iter *i, __wsum *sump)
 {
 	struct pipe_inode_info *pipe = i->pipe;
 	unsigned int p_mask = pipe->ring_size - 1;
-	__wsum sum = csstate->csum;
-	size_t off = csstate->off;
+	__wsum sum = *sump;
+	size_t off = 0;
 	unsigned int i_head;
-	size_t n, r;
+	size_t r;
 
 	if (!sanity(i))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &i_head, &r);
-	if (unlikely(!n))
-		return 0;
-	do {
-		size_t chunk = min_t(size_t, n, PAGE_SIZE - r);
+	bytes = push_pipe(i, bytes, &i_head, &r);
+	while (bytes) {
+		size_t chunk = min_t(size_t, bytes, PAGE_SIZE - r);
 		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
-		sum = csum_and_memcpy(p + r, addr, chunk, sum, off);
+		sum = csum_and_memcpy(p + r, addr + off, chunk, sum, off);
 		kunmap_local(p);
 		i->head = i_head;
 		i->iov_offset = r + chunk;
-		n -= chunk;
+		bytes -= chunk;
 		off += chunk;
-		addr += chunk;
 		r = 0;
 		i_head++;
-	} while (n);
-	i->count -= bytes;
-	csstate->csum = sum;
-	csstate->off = off;
-	return bytes;
+	}
+	*sump = sum;
+	i->count -= off;
+	return off;
 }
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
@@ -1682,15 +1677,15 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	struct csum_state *csstate = _csstate;
 	__wsum sum, next;
 
-	if (unlikely(iov_iter_is_pipe(i)))
-		return csum_and_copy_to_pipe_iter(addr, bytes, _csstate, i);
-
-	sum = csum_shift(csstate->csum, csstate->off);
 	if (unlikely(iov_iter_is_discard(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
 	}
-	iterate_and_advance(i, bytes, base, len, off, ({
+
+	sum = csum_shift(csstate->csum, csstate->off);
+	if (unlikely(iov_iter_is_pipe(i)))
+		bytes = csum_and_copy_to_pipe_iter(addr, bytes, i, &sum);
+	else iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_to_user(addr + off, base, len);
 		sum = csum_block_add(sum, next, off);
 		next ? 0 : len;
-- 
2.11.0

