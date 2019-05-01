Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35BD010F33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 00:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfEAWqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 18:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfEAWqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 18:46:08 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7DF21783;
        Wed,  1 May 2019 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556750768;
        bh=GhZSvQyKOd1yPn+J9hQUgu8RrjDo5ilzVAueJc2+4tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDbvwal9PolgHXpCoAoua0qXNJaAJ6DPhdeN1dZ73Ppw2vNEodhMnoiJZdUPJVKkY
         hwbRysc9P7QBAYm9nmpgkgIiz5O914cPMaPaE7j7zOzNhwjhi1b2t7SmKTIhJFRLk0
         ziH7IFz0puhY3fyDHjhOmVvLq8PhrBafibd2Yzrg=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 10/13] ext4: clear BH_Uptodate flag on decryption error
Date:   Wed,  1 May 2019 15:45:12 -0700
Message-Id: <20190501224515.43059-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190501224515.43059-1-ebiggers@kernel.org>
References: <20190501224515.43059-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chandan Rajendra <chandan@linux.ibm.com>

If decryption fails, ext4_block_write_begin() can return with the page's
buffer_head marked with the BH_Uptodate flag.  This commit clears the
BH_Uptodate flag in such cases.

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1ef5d791834fc..9382e1bcefe49 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1225,10 +1225,14 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		if (!buffer_uptodate(*wait_bh))
 			err = -EIO;
 	}
-	if (unlikely(err))
+	if (unlikely(err)) {
 		page_zero_new_buffers(page, from, to);
-	else if (decrypt)
+	} else if (decrypt) {
 		err = fscrypt_decrypt_pagecache_blocks(page, PAGE_SIZE, 0);
+		if (err)
+			clear_buffer_uptodate(*wait_bh);
+	}
+
 	return err;
 }
 #endif
-- 
2.21.0.593.g511ec345e18-goog

