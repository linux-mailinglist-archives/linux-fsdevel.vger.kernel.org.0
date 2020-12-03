Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF12CCC7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbgLCCXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbgLCCX3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:23:29 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH v2 4/9] ext4: don't call fscrypt_get_encryption_info() from dx_show_leaf()
Date:   Wed,  2 Dec 2020 18:20:36 -0800
Message-Id: <20201203022041.230976-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The call to fscrypt_get_encryption_info() in dx_show_leaf() is too low
in the call tree; fscrypt_get_encryption_info() should have already been
called when starting the directory operation.  And indeed, it already
is.  Moreover, the encryption key is guaranteed to already be available
because dx_show_leaf() is only called when adding a new directory entry.

And even if the key wasn't available, dx_show_leaf() uses
fscrypt_fname_disk_to_usr() which knows how to create a no-key name.

So for the above reasons, and because it would be desirable to stop
exporting fscrypt_get_encryption_info() directly to filesystems, remove
the call to fscrypt_get_encryption_info() from dx_show_leaf().

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/namei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 793fc7db9d28f..7b31aea3e0253 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -643,13 +643,7 @@ static struct stats dx_show_leaf(struct inode *dir,
 
 				name  = de->name;
 				len = de->name_len;
-				if (IS_ENCRYPTED(dir))
-					res = fscrypt_get_encryption_info(dir);
-				if (res) {
-					printk(KERN_WARNING "Error setting up"
-					       " fname crypto: %d\n", res);
-				}
-				if (!fscrypt_has_encryption_key(dir)) {
+				if (!IS_ENCRYPTED(dir)) {
 					/* Directory is not encrypted */
 					ext4fs_dirhash(dir, de->name,
 						de->name_len, &h);
-- 
2.29.2

