Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E139D0BC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFFTNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFFTMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:52 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E8C061787;
        Sun,  6 Jun 2021 12:11:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAg-0056ax-5p; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 21/37] csum_and_copy_to_iter(): massage into form closer to csum_and_copy_from_iter()
Date:   Sun,  6 Jun 2021 19:10:35 +0000
Message-Id: <20210606191051.1216821-21-viro@zeniv.linux.org.uk>
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

Namely, have off counted starting from 0 rather than from csstate->off.
To compensate we need to shift the initial value (csstate->sum) (rotate
by 8 bits, as usual for csum) and do the same after we are finished adding
the pieces up.

What we get out of that is a bit more redundancy in our variables - from
is always equal to addr + off, which will be useful several commits down
the road.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 include/net/checksum.h | 14 ++++++++------
 lib/iov_iter.c         |  8 ++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/net/checksum.h b/include/net/checksum.h
index 0d05b9e8690b..5b96d5bd6e54 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -80,16 +80,18 @@ static inline __sum16 csum16_sub(__sum16 csum, __be16 addend)
 	return csum16_add(csum, ~addend);
 }
 
-static inline __wsum
-csum_block_add(__wsum csum, __wsum csum2, int offset)
+static inline __wsum csum_shift(__wsum sum, int offset)
 {
-	u32 sum = (__force u32)csum2;
-
 	/* rotate sum to align it with a 16b boundary */
 	if (offset & 1)
-		sum = ror32(sum, 8);
+		return (__force __wsum)ror32((__force u32)sum, 8);
+	return sum;
+}
 
-	return csum_add(csum, (__force __wsum)sum);
+static inline __wsum
+csum_block_add(__wsum csum, __wsum csum2, int offset)
+{
+	return csum_add(csum, csum_shift(csum2, offset));
 }
 
 static inline __wsum
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index dbd6b92f6200..906e9d49c487 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1794,8 +1794,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 	if (unlikely(iov_iter_is_pipe(i)))
 		return csum_and_copy_to_pipe_iter(addr, bytes, _csstate, i);
 
-	sum = csstate->csum;
-	off = csstate->off;
+	sum = csum_shift(csstate->csum, csstate->off);
+	off = 0;
 	if (unlikely(iov_iter_is_discard(i))) {
 		WARN_ON(1);	/* for now */
 		return 0;
@@ -1830,8 +1830,8 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *_csstate,
 		off += v.bv_len;
 	})
 	)
-	csstate->csum = sum;
-	csstate->off = off;
+	csstate->csum = csum_shift(sum, csstate->off);
+	csstate->off += bytes;
 	return bytes;
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
-- 
2.11.0

