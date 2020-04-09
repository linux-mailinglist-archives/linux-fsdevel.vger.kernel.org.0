Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66DA1A30EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 10:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgDII3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 04:29:52 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:59390 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgDII3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:29:52 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 93B3E2E15DA;
        Thu,  9 Apr 2020 11:29:48 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id GqCn8sLTpT-TmMCi06O;
        Thu, 09 Apr 2020 11:29:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1586420988; bh=Exr15ikUjhv97D7PAm2dEuR590U9lF7khQ0dEL6Pu5k=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=GP6qF0z79yovoZlVP6LS0eHceAXLjNn4ARPNQQOvYo5lATOC6LKGDCLqKkHimQHbz
         sLJe42tLgYOtpc25a2I749yIqkeW68L9ulr3EuNdk+pYub5v17YDVMtoqB1FWjtdtp
         gV18IN2v8wV453m0+tdIpgfTykfr5gYyAVFeOvYE=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8808::1:4])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id fpxAZ46gi9-TmWqv0ei;
        Thu, 09 Apr 2020 11:29:48 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] ovl: skip overlayfs superblocks at global sync
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Thu, 09 Apr 2020 11:29:47 +0300
Message-ID: <158642098777.5635.10501704178160375549.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stacked filesystems like overlayfs has no own writeback, but they have to
forward syncfs() requests to backend for keeping data integrity.

During global sync() each overlayfs instance calls method ->sync_fs()
for backend although it itself is in global list of superblocks too.
As a result one syscall sync() could write one superblock several times
and send multiple disk barriers.

This patch adds flag SB_I_SKIP_SYNC into sb->sb_iflags to avoid that.

Reported-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/overlayfs/super.c |    5 +++--
 fs/sync.c            |    3 ++-
 include/linux/fs.h   |    2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 732ad5495c92..59df13d16280 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -261,8 +261,8 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 		return 0;
 
 	/*
-	 * If this is a sync(2) call or an emergency sync, all the super blocks
-	 * will be iterated, including upper_sb, so no need to do anything.
+	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
+	 * All the super blocks will be iterated, including upper_sb.
 	 *
 	 * If this is a syncfs(2) call, then we do need to call
 	 * sync_filesystem() on upper_sb, but enough if we do it when being
@@ -1818,6 +1818,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = ovl_xattr_handlers;
 	sb->s_fs_info = ofs;
 	sb->s_flags |= SB_POSIXACL;
+	sb->s_iflags |= SB_I_SKIP_SYNC;
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..16c2630ee4bf 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -76,7 +76,8 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 
 static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
-	if (!sb_rdonly(sb) && sb->s_op->sync_fs)
+	if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_SKIP_SYNC) &&
+	    sb->s_op->sync_fs)
 		sb->s_op->sync_fs(sb, *(int *)arg);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f6f59b4f22a..f186a966a36c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1409,6 +1409,8 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
 
+#define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
+
 /* Possible states of 'frozen' field */
 enum {
 	SB_UNFROZEN = 0,		/* FS is unfrozen */

