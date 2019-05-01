Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD0C10F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfEAWqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbfEAWqJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:09 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E92217D7;
        Wed,  1 May 2019 22:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750768;
        bh=xD7PqOfhddvE9okJKFAirf34SL4fz8KKEtN16Qy6Kso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gilxO/PqfpEGq5c0zQGIqQZrLC3gFUWqXtIObS+nLMp9ZEEI5orwUg2BzcJT9mUB0
         THM/ewxak22G9gQkbw7qJvZ7zyBtX1k20tFJtJctGjT8wJLhM8WiB18YU5BunF+PRW
         GFG0+lcuMb/OEg+KZIGOYNlpwWk/GuCg7qsQ78Zk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 13/13] ext4: encrypt only up to last block in ext4_bio_write_page()
Date:   Wed,  1 May 2019 15:45:15 -0700
Message-Id: <20190501224515.43059-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

As an optimization, don't encrypt blocks fully beyond i_size, since
those definitely won't need to be written out.  Also add a comment.

This is in preparation for allowing encryption on ext4 filesystems with
blocksize != PAGE_SIZE.

This is based on work by Chandan Rajendra.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/page-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 457ddf051608f..ab843ad89df2f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -468,11 +468,19 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 
 	bh = head = page_buffers(page);
 
+	/*
+	 * If any blocks are being written to an encrypted file, encrypt them
+	 * into a bounce page.  For simplicity, just encrypt until the last
+	 * block which might be needed.  This may cause some unneeded blocks
+	 * (e.g. holes) to be unnecessarily encrypted, but this is rare and
+	 * can't happen in the common case of blocksize == PAGE_SIZE.
+	 */
 	if (IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) && nr_to_submit) {
 		gfp_t gfp_flags = GFP_NOFS;
+		unsigned int enc_bytes = round_up(len, i_blocksize(inode));
 
 	retry_encrypt:
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page, PAGE_SIZE,
+		bounce_page = fscrypt_encrypt_pagecache_blocks(page, enc_bytes,
 							       0, gfp_flags);
 		if (IS_ERR(bounce_page)) {
 			ret = PTR_ERR(bounce_page);
-- 
2.21.0.593.g511ec345e18-goog

