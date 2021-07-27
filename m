Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD983D8357
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhG0WoC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:44:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54076 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbhG0WoB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:44:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 081221FF31;
        Tue, 27 Jul 2021 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntRRi13JXohfoyWNEcO4yHLJ45b2xCCxuE7qaQ+92/E=;
        b=Hxy1O7u+LTSY6GoBkPm7LXbB7iLSjjClEujaOyLoZXpN/ExHkqOCbQHQ8VyqbnXUuqFHN9
        yb1FBXLlMNr1fR7R9DC30bIvL7mvr29C4rXWKMfm5ZhKSPhcUohhc6rHRjwnaElep0VaLb
        8MrEdoCt/lzApwO5Qg1AIr3jsOwfU/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425840;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntRRi13JXohfoyWNEcO4yHLJ45b2xCCxuE7qaQ+92/E=;
        b=pt3KKB2X11OwJt+bibSzY0h1UBVxh5Ns7JJ8zpKrIlGhr0DvOQjHUZ+KvKLff/y6J42U/r
        QLvTt62r8wtKwVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 095A013A5D;
        Tue, 27 Jul 2021 22:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mlVXLiyMAGHyVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:56 +0000
Subject: [PATCH 11/11] btrfs: use automount to bind-mount all subvol roots.
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546558.32498.1901201501617899416.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All subvol roots are now marked as automounts.  If the d_automount()
function determines that the dentry is not the root of the vfsmount, it
creates a simple loop-back mount of the dentry onto itself.  If it
determines that it IS the root of the vfsmount, it returns -EISDIR so
that no further automounting is attempted.

btrfs_getattr pays special attention to these automount dentries.
If it is NOT the root of the vfsmount:
 - the ->dev is reported as that for the rest of the vfsmount
 - the ->ino is reported as the subvol objectid, suitable transformed
   to avoid collision.

This way the same inode appear to be different depending on which mount
it is in.

automounted vfsmounts are kept on a list and timeout after 500 to 1000
seconds of last use.  This is configurable via a module parameter.
The tracking and timeout of automounts is copied from NFS.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/btrfs_inode.h |    2 +
 fs/btrfs/inode.c       |  108 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/super.c       |    1 
 3 files changed, 111 insertions(+)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a4b5f38196e6..f03056cacc4a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -387,4 +387,6 @@ static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
 			mirror_num);
 }
 
+void btrfs_release_automount_timer(void);
+
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 02537c1a9763..a5f46545fb38 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -31,6 +31,7 @@
 #include <linux/migrate.h>
 #include <linux/sched/mm.h>
 #include <linux/iomap.h>
+#include <linux/fs_context.h>
 #include <asm/unaligned.h>
 #include "misc.h"
 #include "ctree.h"
@@ -5782,6 +5783,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	struct btrfs_iget_args *args = p;
 
 	inode->i_ino = args->ino;
+	if (args->ino == BTRFS_FIRST_FREE_OBJECTID)
+		inode->i_flags |= S_AUTOMOUNT;
 	BTRFS_I(inode)->location.objectid = args->ino;
 	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
 	BTRFS_I(inode)->location.offset = 0;
@@ -5985,6 +5988,101 @@ static int btrfs_dentry_delete(const struct dentry *dentry)
 	return 0;
 }
 
+static void btrfs_expire_automounts(struct work_struct *work);
+static LIST_HEAD(btrfs_automount_list);
+static DECLARE_DELAYED_WORK(btrfs_automount_task, btrfs_expire_automounts);
+int btrfs_mountpoint_expiry_timeout = 500 * HZ;
+static void btrfs_expire_automounts(struct work_struct *work)
+{
+	struct list_head *list = &btrfs_automount_list;
+	int timeout = READ_ONCE(btrfs_mountpoint_expiry_timeout);
+
+	mark_mounts_for_expiry(list);
+	if (!list_empty(list) && timeout > 0)
+		schedule_delayed_work(&btrfs_automount_task, timeout);
+}
+
+void btrfs_release_automount_timer(void)
+{
+	if (list_empty(&btrfs_automount_list))
+		cancel_delayed_work(&btrfs_automount_task);
+}
+
+static struct vfsmount *btrfs_automount(struct path *path)
+{
+	struct fs_context fc;
+	struct vfsmount *mnt;
+	int timeout = READ_ONCE(btrfs_mountpoint_expiry_timeout);
+
+	if (path->dentry == path->mnt->mnt_root)
+		/* dentry is root of the vfsmount,
+		 * so skip automount processing
+		 */
+		return ERR_PTR(-EISDIR);
+	/* Create a bind-mount to expose the subvol in the mount table */
+	fc.root = path->dentry;
+	fc.sb_flags = 0;
+	fc.source = "btrfs-automount";
+	mnt = vfs_create_mount(&fc);
+	if (IS_ERR(mnt))
+		return mnt;
+	mntget(mnt);
+	mnt_set_expiry(mnt, &btrfs_automount_list);
+	if (timeout > 0)
+		schedule_delayed_work(&btrfs_automount_task, timeout);
+	return mnt;
+}
+
+static int param_set_btrfs_timeout(const char *val, const struct kernel_param *kp)
+{
+	long num;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+	ret = kstrtol(val, 0, &num);
+	if (ret)
+		return -EINVAL;
+	if (num > 0) {
+		if (num >= INT_MAX / HZ)
+			num = INT_MAX;
+		else
+			num *= HZ;
+		*((int *)kp->arg) = num;
+		if (!list_empty(&btrfs_automount_list))
+			mod_delayed_work(system_wq, &btrfs_automount_task, num);
+	} else {
+		*((int *)kp->arg) = -1*HZ;
+		cancel_delayed_work(&btrfs_automount_task);
+	}
+	return 0;
+}
+
+static int param_get_btrfs_timeout(char *buffer, const struct kernel_param *kp)
+{
+	long num = *((int *)kp->arg);
+
+	if (num > 0) {
+		if (num >= INT_MAX - (HZ - 1))
+			num = INT_MAX / HZ;
+		else
+			num = (num + (HZ - 1)) / HZ;
+	} else
+		num = -1;
+	return scnprintf(buffer, PAGE_SIZE, "%li\n", num);
+}
+
+static const struct kernel_param_ops param_ops_btrfs_timeout = {
+	.set = param_set_btrfs_timeout,
+	.get = param_get_btrfs_timeout,
+};
+#define param_check_btrfs_timeout(name, p) __param_check(name, p, int)
+
+module_param(btrfs_mountpoint_expiry_timeout, btrfs_timeout, 0644);
+MODULE_PARM_DESC(btrfs_mountpoint_expiry_timeout,
+		"Set the btrfs automounted mountpoint timeout value (seconds). "
+		"Values <= 0 turn expiration off.");
+
 static struct dentry *btrfs_lookup(struct inode *dir, struct dentry *dentry,
 				   unsigned int flags)
 {
@@ -9195,6 +9293,15 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->dev = BTRFS_I(inode)->root->anon_dev;
+	if ((inode->i_flags & S_AUTOMOUNT) &&
+	    path->dentry != path->mnt->mnt_root) {
+		/* This is the mounted-on side of the automount,
+		 * so we show the inode number from the ROOT_ITEM key
+		 * and the dev of the mountpoint.
+		 */
+		stat->ino = btrfs_location_to_ino(&BTRFS_I(inode)->root->root_key);
+		stat->dev = BTRFS_I(d_inode(path->mnt->mnt_root))->root->anon_dev;
+	}
 
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
@@ -10844,4 +10951,5 @@ static const struct inode_operations btrfs_symlink_inode_operations = {
 
 const struct dentry_operations btrfs_dentry_operations = {
 	.d_delete	= btrfs_dentry_delete,
+	.d_automount	= btrfs_automount,
 };
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..33008e432a15 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -338,6 +338,7 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 static void btrfs_put_super(struct super_block *sb)
 {
 	close_ctree(btrfs_sb(sb));
+	btrfs_release_automount_timer();
 }
 
 enum {


