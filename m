Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C163839D0C3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFFTNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFFTMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:52 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA18C061789;
        Sun,  6 Jun 2021 12:11:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAh-0056cl-Rp; Sun, 06 Jun 2021 19:10:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 34/37] iov_iter: clean csum_and_copy_...() primitives up a bit
Date:   Sun,  6 Jun 2021 19:10:48 +0000
Message-Id: <20210606191051.1216821-34-viro@zeniv.linux.org.uk>
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

1) kmap_atomic() is not needed here, kmap_local_page() is enough.
2) No need to make sum = csum_block_add(sum, next, off); conditional
upon next != 0 - adding 0 is a no-op as far as csum_block_add()
is concerned.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0a9e246178c1..56d2606a47e4 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -611,9 +611,9 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 		return 0;
 	do {
 		size_t chunk = min_t(size_t, n, PAGE_SIZE - r);
-		char *p = kmap_atomic(pipe->bufs[i_head & p_mask].page);
+		char *p = kmap_local_page(pipe->bufs[i_head & p_mask].page);
 		sum = csum_and_memcpy(p + r, addr, chunk, sum, off);
-		kunmap_atomic(p);
+		kunmap_local(p);
 		i->head = i_head;
 		i->iov_offset = r + chunk;
 		n -= chunk;
@@ -1678,8 +1678,7 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 	}
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_from_user(base, addr + off, len);
-		if (next)
-			sum = csum_block_add(sum, next, off);
+		sum = csum_block_add(sum, next, off);
 		next ? 0 : len;
 	}), ({
 		sum = csum_and_memcpy(addr + off, base, len, sum, off);
@@ -1706,8 +1705,7 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	}
 	iterate_and_advance(i, bytes, base, len, off, ({
 		next = csum_and_copy_to_user(addr + off, base, len);
-		if (next)
-			sum = csum_block_add(sum, next, off);
+		sum = csum_block_add(sum, next, off);
 		next ? 0 : len;
 	}), ({
 		sum = csum_and_memcpy(base, addr + off, len, sum, off);
-- 
2.11.0

