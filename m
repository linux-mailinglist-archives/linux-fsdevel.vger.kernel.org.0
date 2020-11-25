Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAE2C355A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 01:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgKYAYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 19:24:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgKYAYq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:24:46 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2DB02151B;
        Wed, 25 Nov 2020 00:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606263886;
        bh=rnYdUr37PtuJdOHsrO7sMu2HuLBhc/5UVpsjNmKp6y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJl8OkUGDWFwxrxlZqEpgv4PwMCU1rjl5L7p1rg/lZNBS90ofHleDkHoORna07IZH
         L4PwZP6J+7e4F/HrUuXir6oThE5TGXcT0nQplwrbj/sZESB+7UVh4fPV9Lswxl7DZb
         3Gx3DfYhqSUtcl/Z9Qd87ORSV1pWNXLhGd1ryKoM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] ext4: remove ext4_dir_open()
Date:   Tue, 24 Nov 2020 16:23:28 -0800
Message-Id: <20201125002336.274045-2-ebiggers@kernel.org>
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
 fs/ext4/dir.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ca50c90adc4c..16bfbdd5007c 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -616,13 +616,6 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
-static int ext4_dir_open(struct inode * inode, struct file * filp)
-{
-	if (IS_ENCRYPTED(inode))
-		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
-	return 0;
-}
-
 static int ext4_release_dir(struct inode *inode, struct file *filp)
 {
 	if (filp->private_data)
@@ -664,7 +657,6 @@ const struct file_operations ext4_dir_operations = {
 	.compat_ioctl	= ext4_compat_ioctl,
 #endif
 	.fsync		= ext4_sync_file,
-	.open		= ext4_dir_open,
 	.release	= ext4_release_dir,
 };
 
-- 
2.29.2

