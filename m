Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2564D2CCC81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387879AbgLCCXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbgLCCX2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:23:28 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/9] ubifs: remove ubifs_dir_open()
Date:   Wed,  2 Dec 2020 18:20:35 -0800
Message-Id: <20201203022041.230976-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203022041.230976-1-ebiggers@kernel.org>
References: <20201203022041.230976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since encrypted directories can be opened and searched without their key
being available, and each readdir and ->lookup() tries to set up the
key, trying to set up the key in ->open() too isn't really useful.

Just remove it so that directories don't need an ->open() method
anymore, and so that we eliminate a use of fscrypt_get_encryption_info()
(which I'd like to stop exporting to filesystems).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/dir.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 08fde777c3247..009fbf844d3e6 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1619,14 +1619,6 @@ int ubifs_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-static int ubifs_dir_open(struct inode *dir, struct file *file)
-{
-	if (IS_ENCRYPTED(dir))
-		return fscrypt_get_encryption_info(dir) ? -EACCES : 0;
-
-	return 0;
-}
-
 const struct inode_operations ubifs_dir_inode_operations = {
 	.lookup      = ubifs_lookup,
 	.create      = ubifs_create,
@@ -1653,7 +1645,6 @@ const struct file_operations ubifs_dir_operations = {
 	.iterate_shared = ubifs_readdir,
 	.fsync          = ubifs_fsync,
 	.unlocked_ioctl = ubifs_ioctl,
-	.open		= ubifs_dir_open,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = ubifs_compat_ioctl,
 #endif
-- 
2.29.2

