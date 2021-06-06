Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424CC39D0BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFFTNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFFTMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:48 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A9C06121D;
        Sun,  6 Jun 2021 12:10:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAi-0056dN-8v; Sun, 06 Jun 2021 19:10:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 36/37] clean up copy_mc_pipe_to_iter()
Date:   Sun,  6 Jun 2021 19:10:50 +0000
Message-Id: <20210606191051.1216821-36-viro@zeniv.linux.org.uk>
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

... and we don't need kmap_atomic() there - kmap_local_page() is fine.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7471fb181643..0ee359b62afc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -653,19 +653,6 @@ static int copyout_mc(void __user *to, const void *from, size_t n)
 	return n;
 }
 
-static unsigned long copy_mc_to_page(struct page *page, size_t offset,
-		const char *from, size_t len)
-{
-	unsigned long ret;
-	char *to;
-
-	to = kmap_atomic(page);
-	ret = copy_mc_to_kernel(to + offset, from, len);
-	kunmap_atomic(to);
-
-	return ret;
-}
-
 static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
@@ -677,25 +664,23 @@ static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 	if (!sanity(i))
 		return 0;
 
-	bytes = n = push_pipe(i, bytes, &i_head, &off);
-	if (unlikely(!n))
-		return 0;
-	do {
+	n = push_pipe(i, bytes, &i_head, &off);
+	while (n) {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - off);
+		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
 		unsigned long rem;
-
-		rem = copy_mc_to_page(pipe->bufs[i_head & p_mask].page,
-					    off, addr, chunk);
+		rem = copy_mc_to_kernel(p + off, addr + xfer, chunk);
+		chunk -= rem;
+		kunmap_local(p);
 		i->head = i_head;
-		i->iov_offset = off + chunk - rem;
-		xfer += chunk - rem;
+		i->iov_offset = off + chunk;
+		xfer += chunk;
 		if (rem)
 			break;
 		n -= chunk;
-		addr += chunk;
 		off = 0;
 		i_head++;
-	} while (n);
+	}
 	i->count -= xfer;
 	return xfer;
 }
-- 
2.11.0

