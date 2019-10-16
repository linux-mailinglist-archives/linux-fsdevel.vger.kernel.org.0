Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9828ADA0BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405569AbfJPWOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 18:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393379AbfJPWOq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 18:14:46 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A4621A49;
        Wed, 16 Oct 2019 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571264085;
        bh=YAF7UWWvcUDpvW5NZx+f1x+H79EjBWHrBCJ+KdfKhiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfkBwowy1MwHQ9thoyK0yXfDbsuzwnCfOtWTBb1tn2s89VlOfIheKAtvpSgu/TM0B
         G1+56SNHo+hPiExGZnYkxl7WGAAsMATX3XSD3DiPBmcF4S8b6aqPFEyXqwcDPBOxP8
         VqfpCeNljIV+SOcMhQvoPUNd40RmUezxl1ikZMhk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: [PATCH 2/2] ext4: Enable encryption for subpage-sized blocks
Date:   Wed, 16 Oct 2019 15:11:42 -0700
Message-Id: <20191016221142.298754-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016221142.298754-1-ebiggers@kernel.org>
References: <20191016221142.298754-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chandan Rajendra <chandan@linux.ibm.com>

Now that we have the code to support encryption for subpage-sized
blocks, this commit removes the conditional check in filesystem mount
code.

The commit also changes the support statement in
Documentation/filesystems/fscrypt.rst to reflect the fact that
encryption on filesystems with blocksize less than page size now works.

[EB: Tested with 'gce-xfstests -c ext4/encrypt_1k -g auto', using the
new "encrypt_1k" config I created.  All tests pass except for those that
already fail or are excluded with the encrypt or 1k configs, and 2 tests
that try to create 1023-byte symlinks which fails since encrypted
symlinks are limited to blocksize-3 bytes.  Also ran the dedicated
encryption tests using 'kvm-xfstests -c ext4/1k -g encrypt'; all pass,
including the on-disk ciphertext verification tests.]

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 4 ++--
 fs/ext4/super.c                       | 7 -------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 8a0700af9596..b0d015a8cdc3 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -331,8 +331,8 @@ Contents encryption
 -------------------
 
 For file contents, each filesystem block is encrypted independently.
-Currently, only the case where the filesystem block size is equal to
-the system's page size (usually 4096 bytes) is supported.
+Starting from Linux kernel 5.5, encryption of filesystems with block
+size less than system's page size is supported.
 
 Each block's IV is set to the logical block number within the file as
 a little endian number, except that:
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dd654e53ba3d..369f852bef20 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4439,13 +4439,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	if ((DUMMY_ENCRYPTION_ENABLED(sbi) || ext4_has_feature_encrypt(sb)) &&
-	    (blocksize != PAGE_SIZE)) {
-		ext4_msg(sb, KERN_ERR,
-			 "Unsupported blocksize for fs encryption");
-		goto failed_mount_wq;
-	}
-
 	if (ext4_has_feature_verity(sb) && blocksize != PAGE_SIZE) {
 		ext4_msg(sb, KERN_ERR, "Unsupported blocksize for fs-verity");
 		goto failed_mount_wq;
-- 
2.23.0

