Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1448FF69
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jan 2022 23:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiAPWHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 17:07:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57870 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAPWHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 17:07:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E2F71F37B;
        Sun, 16 Jan 2022 22:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642370858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ux+cjqDfKM9y7l7EW+chWJOdcxq8/Set71C0Gfwhnk=;
        b=F9LbMxiu7IaXElzxJ33nkgmsNBeSOpWABZ5swO1HBZMQ+e0L+iohMBTICPAdzEegTdytWe
        dtSIeMfyFBmf/3sMeZbyE99ufIRAXVEHvt7PYdU6B509PMrPPUUleJWkPOmJ6cMHZPfjZQ
        ynFdWLT22eD/bpUa89HxmP2Jv/W4ubM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642370858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ux+cjqDfKM9y7l7EW+chWJOdcxq8/Set71C0Gfwhnk=;
        b=+pDW7mEqfW5TbqRYHhSF+HDd6t14DSpM5uNAhXFZEmfiWm5blHuUnfm77guyYn47KXWVFD
        IfETWWwEGHH5kaAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F350132D4;
        Sun, 16 Jan 2022 22:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KI2WDieX5GGDZgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 16 Jan 2022 22:07:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org
cc:     "Christian Brauner" <christian.brauner@ubuntu.com>,
        Anthony Iliopoulos <ailiop@suse.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH - resend] devtmpfs regression fix: reconfigure on each mount
In-reply-to: <20211214141824.fvmtwvp57pqg7ost@wittgenstein>
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>,
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein>, <YbexPXpuI8RdOb8q@technoir>,
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein>, <Ybik5dWF2w06JQM6@technoir>,
 <20211214141824.fvmtwvp57pqg7ost@wittgenstein>
Date:   Mon, 17 Jan 2022 09:07:26 +1100
Message-id: <164237084692.24166.3761469608708322913@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Prior to Linux v5.4 devtmpfs used mount_single() which treats the given
mount options as "remount" options, so it updates the configuration of the
single super_block on each mount.
Since that was changed, the mount options used for devtmpfs are ignored.
This is a regression which affect systemd - which mounts devtmpfs
with "-o mode=3D755,size=3D4m,nr_inodes=3D1m".

This patch restores the "remount" effect by calling reconfigure_single()

Fixes: d401727ea0d7 ("devtmpfs: don't mix {ramfs,shmem}_fill_super() with mou=
nt_single()")
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/base/devtmpfs.c    | 7 +++++++
 fs/super.c                 | 4 ++--
 include/linux/fs_context.h | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 1e2c2d3882e2..f41063ac1aee 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -65,8 +65,15 @@ static struct dentry *public_dev_mount(struct file_system_=
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

