Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46312C355D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 01:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKYAYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 19:24:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbgKYAYr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:24:47 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E01321534;
        Wed, 25 Nov 2020 00:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606263886;
        bh=fQf+fnaZQ02pcMEuBF1tBcPKD9HF9tGTFk+IDwiZp4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNLet1ZGE/CSRBfltP6K7lEGDh8V0fPQXQop96Z8CQDltO+ttQbkZUgKcBixSINvf
         268ymGtXK8m+tNIEqeWpmji485xYf22gcpI6X8MVK/vwxmVcLcMHogHu8lwh9N1/O3
         dgVXB719889w/ATW8gPyfytv/NMQO/Fv+FNOUBsU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] ubifs: remove ubifs_dir_open()
Date:   Tue, 24 Nov 2020 16:23:30 -0800
Message-Id: <20201125002336.274045-4-ebiggers@kernel.org>
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
 fs/ubifs/dir.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 08fde777c324..009fbf844d3e 100644
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

