Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA577471F15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 02:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhLMBMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Dec 2021 20:12:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhLMBMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Dec 2021 20:12:32 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7DF821F3B8;
        Mon, 13 Dec 2021 01:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639357951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aEfkT3YyffLHcGgn+XxZ+KUIbYAzu+mVMkclU5WoOqQ=;
        b=CARn/7WbleWPNt81u7ubzgY4Tx9CDmN1QG/Jc9+lXaY2m4zLR/RFTcFQ6f82J2jqDEvt6F
        x6enSQKA1PpJFitDOa/ZZ5lhzsYUdR3hER4RgzcCara3iNbRwYq1V7prIP0K/9n+YV+j6U
        WfdT1P8vCOaLUZ7OwFwEZOg8e15aw8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639357951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aEfkT3YyffLHcGgn+XxZ+KUIbYAzu+mVMkclU5WoOqQ=;
        b=DiuFOcYogA4gJFq886uIZkKD8DgW5UuAXV575dFJHBf8c++wJQwDtxUJOv6IMuPx9QpSzx
        QCXbsKT/lfyTXeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2A7013425;
        Mon, 13 Dec 2021 01:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FmqHHv2dtmHGFQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Dec 2021 01:12:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH - regression] devtmpfs: reconfigure on each mount
Date:   Mon, 13 Dec 2021 12:12:26 +1100
Message-id: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
mount options as "remount" options, updating the configuration of the
single super_block on each mount.
Since that was changed, the mount options used for devtmpfs are ignored.
This is a regression which affects systemd - which mounts devtmpfs
with "-o mode=3D755,size=3D4m,nr_inodes=3D1m".

This patch restores the "remount" effect by calling reconfigure_single()

Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mou=
nt_single()")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/base/devtmpfs.c    | 7 +++++++
 fs/super.c                 | 4 ++--
 include/linux/fs_context.h | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 8be352ab4ddb..fa13ad49d211 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -59,8 +59,15 @@ static struct dentry *public_dev_mount(struct file_system_=
type *fs_type, int fla
 		      const char *dev_name, void *data)
 {
 	struct super_block *s =3D mnt->mnt_sb;
+	int err;
+
 	atomic_inc(&s->s_active);
 	down_write(&s->s_umount);
+	err =3D reconfigure_single(s, flags, data);
+	if (err < 0) {
+		deactivate_locked_super(s);
+		return ERR_PTR(err);
+	}
 	return dget(s->s_root);
 }
=20
diff --git a/fs/super.c b/fs/super.c
index 3bfc0f8fbd5b..a6405d44d4ca 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1423,8 +1423,8 @@ struct dentry *mount_nodev(struct file_system_type *fs_=
type,
 }
 EXPORT_SYMBOL(mount_nodev);
=20
-static int reconfigure_single(struct super_block *s,
-			      int flags, void *data)
+int reconfigure_single(struct super_block *s,
+		       int flags, void *data)
 {
 	struct fs_context *fc;
 	int ret;
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 6b54982fc5f3..13fa6f3df8e4 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -142,6 +142,8 @@ extern void put_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param_source(struct fs_context *fc,
 				     struct fs_parameter *param);
 extern void fc_drop_locked(struct fs_context *fc);
+int reconfigure_single(struct super_block *s,
+		       int flags, void *data);
=20
 /*
  * sget() wrappers to be called from the ->get_tree() op.
--=20
2.34.1

