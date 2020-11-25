Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C982C3562
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 01:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgKYAYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 19:24:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgKYAYq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:24:46 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E27A21527;
        Wed, 25 Nov 2020 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606263886;
        bh=kpsbU6nvcysiI9/MmbON23qqvHm2MWi7u1vlzska8vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3OE/takovt2yDXfnek5hfdpeePr6vwUSGTHUpP7IDS3ZkqY6FAGheOuo7Yjxb7DP
         nN15RjbMCAvWsymNtQqS3XE6yjq8XBjtiiK8BPKivoiGjhF6bd6qLlBVjov0wyf33A
         ldOVssWJJoNEU8DHoQc21MglO+vKlXsUcQloLo/A=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] f2fs: remove f2fs_dir_open()
Date:   Tue, 24 Nov 2020 16:23:29 -0800
Message-Id: <20201125002336.274045-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125002336.274045-1-ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since encrypted directories can be opened without their encryption key
being available, and each readdir tries to set up the key, trying to set
up the key in ->open() too isn't really useful.

Just remove it so that directories don't need an ->open() method
anymore, and so that we eliminate a use of fscrypt_get_encryption_info()
(which I'd like to stop exporting to filesystems).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/f2fs/dir.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 4b9ef8bbfa4a..47bee953fc8d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -1081,19 +1081,11 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 	return err < 0 ? err : 0;
 }
 
-static int f2fs_dir_open(struct inode *inode, struct file *filp)
-{
-	if (IS_ENCRYPTED(inode))
-		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
-	return 0;
-}
-
 const struct file_operations f2fs_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= f2fs_readdir,
 	.fsync		= f2fs_sync_file,
-	.open		= f2fs_dir_open,
 	.unlocked_ioctl	= f2fs_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = f2fs_compat_ioctl,
-- 
2.29.2

