Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2945B3E3E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 05:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHID6w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 23:58:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58002 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhHID6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:58:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAD0E1FD81;
        Mon,  9 Aug 2021 03:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628481507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBKlJwh6qPUtRQ+E2HqkVTJHsO/u/MDxgQK6gIYa7VU=;
        b=vZK3Xk4amyGrprNAMoKyqaNBQzWd0n3dO2fy7u6Ty7bxFbLqsVr5jVN7al279PJNVKtVYD
        A1VUXF/FZpn3y8DwXwlsYvR+30GAt9Qt6M9zGwbPmqBK8F4kj4R8avCu47bn4HfrkAooH6
        wCeJwSKyW52qtp1vJRZn3+txeaTJDP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628481507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBKlJwh6qPUtRQ+E2HqkVTJHsO/u/MDxgQK6gIYa7VU=;
        b=IA3WdHiugszLWTzSvxTOl2R9nYP3665i6nmXfjW9/ASLm4hoedmQSOY4zLWqMiF6werPtp
        hUr+B305+yTYLeDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAE8F13A9F;
        Mon,  9 Aug 2021 03:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHv9IeGnEGHPBgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 03:58:25 +0000
Subject: [PATCH 2/4] btrfs: add numdevs= mount option.
From:   NeilBrown <neilb@suse.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 09 Aug 2021 13:55:27 +1000
Message-ID: <162848132773.25823.8504921416553051353.stgit@noble.brown>
In-Reply-To: <162848123483.25823.15844774651164477866.stgit@noble.brown>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs currently allocates multiple anonymous bdev numbers to hide the
fact that inode numbers are not unique across "subvolumes".
Each subvol gets a different device number.

As described in a previous patch, this is incomplete, doesn't scale, and
should be deprecated.  This patch is another step to deprecation.

With mount option "-o numdevs=many", which is the default, the current
behaviour is preserved.

With mount option "-o numdevs=1", the st_dev reported by stat() is
exactly the number that appears in /proc/$PID/mountinfo (i.e.
sb->s_dev).  This will prevent "du -x", "find -xdev" and similar tools
from keeping within a subvol, but is otherwise quite functional.

If numdevs=1 and inumbits=0, then there will often be inode number
reuse, so that combination is forbidden and the default fo inumbits
changes to BITS_PER_LONG*7/8.  With larger inumbits (close to
BITS_PER_LONG), inode number reuse is still possible, but only with
large or old filesystems.

With mount option "-o numdevs=2", precisely two anon device numbers are
allocated.  Each subvol gets the number that its parent isn't using.
When subvols are moved, the device number reported will change if needed
to differentiate from its parent.
If a subvol with dependent subvols is moved and the device numbers need
to change, the numbers in dependent subvols that are currently in cache
will NOT change.  Fixing this is a stretch goal.

Using numdevs=2 removes any problems with exhausting the number of
available anon devs, and preserves the functionality of "du -x" and
similar.  It may be a useful option for sites that experience exhaustion
problems.

numdevs=1 is, at this stage, most useful for exploring the consequences
of fully deprecating the use of multiple device numbers.  It may also be
useful for site that find they have no dependency on multiple device
numbers.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/ctree.h   |   17 +++++++++++++++--
 fs/btrfs/disk-io.c |   24 +++++++++++++++++++++---
 fs/btrfs/inode.c   |   29 ++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.c   |    6 ++++--
 fs/btrfs/super.c   |   30 ++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0ef557db3a8b..2caedb8c8c6d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -988,6 +988,14 @@ struct btrfs_fs_info {
 	u32 stripesize;
 
 	unsigned short inumbits;
+	/* num_devs can be:
+	 * 1 - all files in all trees use sb->s_dev
+	 * 2 - file trees alternate between using sb->s_dev and
+	 *     secondary_anon_dev.
+	 * 3 (BTTSF_MANY_DEVS) - Each subtree uses a unique ->anon_dev
+	 */
+	unsigned short num_devs;
+	dev_t secondary_anon_dev;
 
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
@@ -1035,6 +1043,8 @@ struct btrfs_fs_info {
 #endif
 };
 
+#define BTRFS_MANY_DEVS	(3)
+
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -1176,10 +1186,13 @@ struct btrfs_root {
 	 */
 	struct radix_tree_root delayed_nodes_tree;
 	/*
-	 * right now this just gets used so that a root has its own devid
-	 * for stat.  It may be used for more later
+	 * If fs_info->num_devs == 3 (BTRFS_MANY_DEVS) anon_dev holds a device
+	 * number to be reported by ->getattr().
+	 * If fs_info->num_devs == 2, anon_dev is 0 and use_secondary_dev
+	 * is true when this root uses the secondary, not primary, dev.
 	 */
 	dev_t anon_dev;
+	bool use_secondary_dev;
 
 	spinlock_t root_item_lock;
 	refcount_t refs;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7f3bfa042d66..5127e2689756 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1516,7 +1516,8 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 	 * userspace, the id pool is limited to 1M
 	 */
 	if (is_fstree(root->root_key.objectid) &&
-	    btrfs_root_refs(&root->root_item) > 0) {
+	    btrfs_root_refs(&root->root_item) > 0 &&
+	    root->fs_info->num_devs == BTRFS_MANY_DEVS) {
 		if (!anon_dev) {
 			ret = get_anon_bdev(&root->anon_dev);
 			if (ret)
@@ -3332,8 +3333,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 * "-o inumbits" can over-ride this default.
 	 * BITS_PER_LONG * 7 / 8 is a good value to use
 	 */
-	if (fs_info->inumbits > BITS_PER_LONG)
-		fs_info->inumbits = 0;
+	if (fs_info->inumbits > BITS_PER_LONG) {
+		if (fs_info->num_devs == 1)
+			fs_info->inumbits = BITS_PER_LONG * 7 / 8;
+		else
+			fs_info->inumbits = 0;
+	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
 		~BTRFS_FEATURE_INCOMPAT_SUPP;
@@ -3379,6 +3384,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
+	if (fs_info->num_devs == 0)
+		/* set default value */
+		fs_info->num_devs = BTRFS_MANY_DEVS;
+
+	if (fs_info->num_devs == 2) {
+		err = get_anon_bdev(&fs_info->secondary_anon_dev);
+		if (err)
+			goto fail_alloc;
+	}
 	/*
 	 * mixed block groups end up with duplicate but slightly offset
 	 * extent buffers for the same range.  It leads to corruptions
@@ -4446,6 +4460,10 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 	btrfs_close_devices(fs_info->fs_devices);
+
+	if (fs_info->secondary_anon_dev)
+		free_anon_bdev(fs_info->secondary_anon_dev);
+	fs_info->secondary_anon_dev = 0;
 }
 
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 860cb5045123..30fa64cbe6dc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5966,6 +5966,8 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 			iput(inode);
 			inode = ERR_PTR(ret);
 		}
+		if (fs_info->num_devs == 2)
+			sub_root->use_secondary_dev = !root->use_secondary_dev;
 	}
 
 	return inode;
@@ -9204,7 +9206,15 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(&init_user_ns, inode, stat);
-	stat->dev = BTRFS_I(inode)->root->anon_dev;
+	/* If we don't set stat->dev here, sb->s_dev will be used */
+	switch (btrfs_sb(inode->i_sb)->num_devs) {
+	case 2:
+		if (BTRFS_I(inode)->root->use_secondary_dev)
+			stat->dev = btrfs_sb(inode->i_sb)->secondary_anon_dev;
+		break;
+	case BTRFS_MANY_DEVS:
+		stat->dev = BTRFS_I(inode)->root->anon_dev;
+	}
 
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
@@ -9390,6 +9400,15 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	if (new_inode->i_nlink == 1)
 		BTRFS_I(new_inode)->dir_index = new_idx;
 
+	if (fs_info->num_devs == 2 &&
+	    root->use_secondary_dev != dest->use_secondary_dev) {
+		BTRFS_I(old_inode)->root->use_secondary_dev =
+				!dest->use_secondary_dev;
+		BTRFS_I(new_inode)->root->use_secondary_dev =
+				!root->use_secondary_dev;
+		// FIXME any subvols beneeath 'old_inode' or 'new_inode'
+		// that are in cache are now wrong.
+	}
 	if (root_log_pinned) {
 		btrfs_log_new_name(trans, BTRFS_I(old_inode), BTRFS_I(old_dir),
 				   new_dentry->d_parent);
@@ -9656,6 +9675,14 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		goto out_fail;
 	}
 
+	if (fs_info->num_devs == 2 &&
+	    root->use_secondary_dev != dest->use_secondary_dev) {
+		BTRFS_I(old_inode)->root->use_secondary_dev =
+				!dest->use_secondary_dev;
+		// FIXME any subvols beneeath 'old_inode' that are
+		// in cache are now wrong.
+	}
+
 	if (old_inode->i_nlink == 1)
 		BTRFS_I(old_inode)->dir_index = index;
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e008a9ceb827..a246f91b4df4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -522,7 +522,8 @@ static noinline int create_subvol(struct inode *dir,
 	if (ret)
 		goto fail_free;
 
-	ret = get_anon_bdev(&anon_dev);
+	if (fs_info->num_devs == BTRFS_MANY_DEVS)
+		ret = get_anon_bdev(&anon_dev);
 	if (ret < 0)
 		goto fail_free;
 
@@ -729,7 +730,8 @@ static int create_snapshot(struct btrfs_root *root, struct inode *dir,
 	if (!pending_snapshot)
 		return -ENOMEM;
 
-	ret = get_anon_bdev(&pending_snapshot->anon_dev);
+	if (fs_info->num_devs == BTRFS_MANY_DEVS)
+		ret = get_anon_bdev(&pending_snapshot->anon_dev);
 	if (ret < 0)
 		goto free_pending;
 	pending_snapshot->root_item = kzalloc(sizeof(struct btrfs_root_item),
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5f3350e2f7ec..b1aecb834234 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -361,6 +361,7 @@ enum {
 	Opt_discard_mode,
 	Opt_inumbits,
 	Opt_norecovery,
+	Opt_numdevs,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
 	Opt_skip_balance,
@@ -431,6 +432,7 @@ static const match_table_t tokens = {
 	{Opt_inumbits, "inumbits=%u"},
 	{Opt_nodiscard, "nodiscard"},
 	{Opt_norecovery, "norecovery"},
+	{Opt_numdevs, "numdevs=%s"},
 	{Opt_ratio, "metadata_ratio=%u"},
 	{Opt_rescan_uuid_tree, "rescan_uuid_tree"},
 	{Opt_skip_balance, "skip_balance"},
@@ -849,8 +851,35 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 				ret = -EINVAL;
 				goto out;
 			}
+			if (intarg == 0 && info->num_devs == 1) {
+				btrfs_err(info,
+					  "inumbits=0 not permitted when numdevs=1");
+				ret = -EINVAL;
+				goto out;
+			}
 			info->inumbits = intarg;
 			break;
+		case Opt_numdevs:
+			if (info->num_devs) {
+				; /* silently ignore attempts to change this */
+			} else if (strcmp(args[0].from, "many") == 0) {
+				info->num_devs = BTRFS_MANY_DEVS;
+			} else if (strcmp(args[0].from, "1") == 0) {
+				if (info->inumbits == 0) {
+					btrfs_err(info,
+"numdevs=1 not permitted with inumbits=0");
+					ret = -EINVAL;
+				}
+				info->num_devs = 1;
+			} else if (strcmp(args[0].from, "2") == 0) {
+				info->num_devs = 2;
+			} else {
+				btrfs_err(info,
+					  "numdevs must be \"1\", \"2\", or \"many\".");
+				ret = -EINVAL;
+				goto out;
+			}
+			break;
 		case Opt_ratio:
 			ret = match_int(&args[0], &intarg);
 			if (ret)
@@ -1559,6 +1588,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
 	seq_printf(seq, ",inumbits=%u", info->inumbits);
+	seq_printf(seq, ",numdevs=%u", info->num_devs);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,


