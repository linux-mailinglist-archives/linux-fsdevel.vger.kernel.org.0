Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459F53E3E8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 05:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhHID6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 23:58:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbhHID6n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:58:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 956AD21E55;
        Mon,  9 Aug 2021 03:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628481502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SJIIFAGYYrXWu0yL4lrEb59SFTJAF7UUSPmCVWCYek=;
        b=b3rpNXxp5yA0jam+f21PdLlC2NAS6L/vRvVmrGdIWnEAj/ExkGMTRaaLjlDjGxzIte1CTm
        F3Wd5VXHNrEFiVaQa8rEDCNafjGObkY+zjrmeV4nRt9TTMoICzeDFFm0xk4mdtabVP+jb4
        Yvc60Ky+vxSClTxnKRIh72+ZUVfJvGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628481502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SJIIFAGYYrXWu0yL4lrEb59SFTJAF7UUSPmCVWCYek=;
        b=29bUcUYxaNzJ/EQw8ZfyhV9NKa9nCGCxJkGRvPGBEaPCOsDx9u1bWqx8BMR1RYVTJm7XvY
        ij2SZ6A29i/P/QDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 725D513A9F;
        Mon,  9 Aug 2021 03:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zSpkDNynEGHFBgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 03:58:20 +0000
Subject: [PATCH 1/4] btrfs: include subvol identifier in inode number if -o
 inumbits=...
From:   NeilBrown <neilb@suse.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 09 Aug 2021 13:55:27 +1000
Message-ID: <162848132771.25823.16399620921119050413.stgit@noble.brown>
In-Reply-To: <162848123483.25823.15844774651164477866.stgit@noble.brown>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A btrfs filesystem uses 112 bits to identify an object: 48 for the
object-id of the subvolume (really a 'subtree') and 64 for the object
within that tree.

It only exposes the 64bits in i_ino (and st_ino for stat()) and attempts
to hide the non-uniqueness by reporting a different st_dev in stat() for
each different subvol.

This is incomplete and doesn't scale.

It is incomplete because there are places other than 'stat()' where the
device number is visible to user-space, including /proc/$PID/mountinfo,
/proc/$PID/maps and /proc/locks.  These report the device-number for the
whole filesystem together with i_ino, and so do not match the
st_dev+st_ino reported by stat().

It is also incomplete because nfsd doesn't notice the st_dev value,
depending only of the existence of mount points to discover filesystem
changes.

It doesn't scale because there are a limited number of anon device
numbers that can be allocated, which is approximately 20 bits, much less
than the 48 bits worth of subvols which btrfs supports.

I believe that we *must* extend the user-space API to properly support
btrfs - trying to fit within it will always cause pain, at least in the
extremes.  I believe that the use of varying device numbers is not a
viable long-term solution and must be deprecated.

This patch is a first step towards deprecating the use of device numbers
to add uniqueness.  It changes the inode numbers reported so they are
unique across all subvols for modest sized filesystems.  It does this
by creating an 'overlay' from the subvol number and xor-ing that into
the file's object id.  This results in reported inode numbers being
completely unique within a subvol, and mostly unique between subvols.

The overlay is *not* xor-ed in when it exactly matches the objectid, as
that would produce zero.

A few placed in the code assume that ->i_ino is the objectid.  Those few
are changed to call btrfs_ino(), and ino now subtracts the overlay.

The "overlay" is created by byte-swapping the subvol identifier, then
optionally shifting down a few bits so there is unused space at the
top-end.  When the maximum objectid in use requires many fewer than 64
bits, and the maximum subvol id in use does not use all of the
remaining bits, complete uniqueness can be provided.  For larger
fileystems, complete uniqueness cannot be guaranteed.

The size of the shift can be set using the "inumbits" mount option.  A
value of 64 suppresses any shift and maximum uniqueness is provided.  A
value of 0 (the default) disables the overlay functionality.

A generally good value on 64bit systems which might use overlayfs with
btrdfs is 56, as this provides broad uniqueness, while leaving some bits
for overlayfs to differentiate between merged filesystems.

The only material improvement from this patch alone will come to
applications and tools which do not pay attention to st_dev (as that is
unchanged).  In particular, nfsd will, when "-o inumbits=56", report
(mostly) unique inode numbers to the NFS client, and some problems
caused by "find" and related tools detecting that the root of a subvol
has the name inode number as the root of its parent - both of which
appear to NFS to be in the same filesystem.

Subsequent patches will build on this base to allow the use of multiple
devices to be controlled, and then to allow complete uniqueness through
interface extensions.

ISSUE: In btrfs, inode numbers below the highest-currently-allocated are
   never reused.  This allows the highest inode number to be arbitrarily
   higher than the number of inodes.  This means that an "old"
   filesystem can trigger a risk of non-uniqueness just as a large
   filesystem can.

ISSUE: I don't understand the role of BTRFS_EMPTY_SUBVOL_DIR_OBJECTID
   so I don't know if I have to do anything when that value is assigned
   to i_ino.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/btrfs_inode.h |   22 ++++++++++++++--------
 fs/btrfs/ctree.h       |    4 ++++
 fs/btrfs/disk-io.c     |   15 +++++++++++++++
 fs/btrfs/inode.c       |   17 ++++++++++++++---
 fs/btrfs/ioctl.c       |    2 +-
 fs/btrfs/super.c       |   24 +++++++++++++++++++++++-
 6 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index c652e19ad74e..18e1b071bb69 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -246,13 +246,6 @@ static inline unsigned long btrfs_inode_hash(u64 objectid,
 	return (unsigned long)h;
 }
 
-static inline void btrfs_insert_inode_hash(struct inode *inode)
-{
-	unsigned long h = btrfs_inode_hash(inode->i_ino, BTRFS_I(inode)->root);
-
-	__insert_inode_hash(inode, h);
-}
-
 static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 {
 	u64 ino = inode->location.objectid;
@@ -261,11 +254,24 @@ static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 	 * !ino: btree_inode
 	 * type == BTRFS_ROOT_ITEM_KEY: subvol dir
 	 */
-	if (!ino || inode->location.type == BTRFS_ROOT_ITEM_KEY)
+	if (!ino || inode->location.type == BTRFS_ROOT_ITEM_KEY) {
+		/* vfs_inode.i_ino has inum_overlay merged in, when
+		 * that wouldn't produce zero. We need to remove it here.
+		 */
 		ino = inode->vfs_inode.i_ino;
+		if (ino != inode->root->inum_overlay)
+			ino ^= inode->root->inum_overlay;
+	}
 	return ino;
 }
 
+static inline void btrfs_insert_inode_hash(struct inode *inode)
+{
+	unsigned long h = btrfs_inode_hash(btrfs_ino(BTRFS_I(inode)), BTRFS_I(inode)->root);
+
+	__insert_inode_hash(inode, h);
+}
+
 static inline void btrfs_i_size_write(struct btrfs_inode *inode, u64 size)
 {
 	i_size_write(&inode->vfs_inode, size);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e5e53e592d4f..0ef557db3a8b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -987,6 +987,8 @@ struct btrfs_fs_info {
 	u32 csums_per_leaf;
 	u32 stripesize;
 
+	unsigned short inumbits;
+
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
@@ -1145,6 +1147,8 @@ struct btrfs_root {
 
 	u64 last_trans;
 
+	u64 inum_overlay;
+
 	u32 type;
 
 	u64 free_objectid;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a59ab7b9aea0..7f3bfa042d66 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1202,6 +1202,12 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
 	root->root_key.objectid = objectid;
 	root->anon_dev = 0;
+	if (fs_info->inumbits &&
+	    objectid != BTRFS_FS_TREE_OBJECTID &&
+	    is_fstree(objectid))
+		root->inum_overlay = swab64(objectid) >> (64 - fs_info->inumbits);
+	else
+		root->inum_overlay = 0;
 
 	spin_lock_init(&root->root_item_lock);
 	btrfs_qgroup_init_swapped_blocks(&root->swapped_blocks);
@@ -3314,12 +3320,21 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
 
+	fs_info->inumbits = BITS_PER_LONG + 1; /* impossible value */
+
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
 		goto fail_alloc;
 	}
 
+	/* By default, use inumbits=0 to avoid behaviour change.
+	 * "-o inumbits" can over-ride this default.
+	 * BITS_PER_LONG * 7 / 8 is a good value to use
+	 */
+	if (fs_info->inumbits > BITS_PER_LONG)
+		fs_info->inumbits = 0;
+
 	features = btrfs_super_incompat_flags(disk_super) &
 		~BTRFS_FEATURE_INCOMPAT_SUPP;
 	if (features) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 01099bf602fb..860cb5045123 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5782,6 +5782,11 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	struct btrfs_iget_args *args = p;
 
 	inode->i_ino = args->ino;
+	if (args->root && args->ino != args->root->inum_overlay)
+		/* This inode number will still be unique within this
+		 * 'root', and should be nearly unique across the filesystem.
+		 */
+		inode->i_ino ^= args->root->inum_overlay;
 	BTRFS_I(inode)->location.objectid = args->ino;
 	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
 	BTRFS_I(inode)->location.offset = 0;
@@ -6092,6 +6097,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 
 	while (1) {
 		struct dir_entry *entry;
+		u64 inum;
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
@@ -6136,7 +6142,10 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 		put_unaligned(fs_ftype_to_dtype(btrfs_dir_type(leaf, di)),
 				&entry->type);
 		btrfs_dir_item_key_to_cpu(leaf, di, &location);
-		put_unaligned(location.objectid, &entry->ino);
+		inum = location.objectid;
+		if (inum != root->inum_overlay)
+			inum ^= root->inum_overlay;
+		put_unaligned(inum, &entry->ino);
 		put_unaligned(found_key.offset, &entry->offset);
 		entries++;
 		addr += sizeof(struct dir_entry) + name_len;
@@ -6333,7 +6342,7 @@ static int btrfs_insert_inode_locked(struct inode *inode)
 	args.root = BTRFS_I(inode)->root;
 
 	return insert_inode_locked4(inode,
-		   btrfs_inode_hash(inode->i_ino, BTRFS_I(inode)->root),
+		   btrfs_inode_hash(btrfs_ino(BTRFS_I(inode)), BTRFS_I(inode)->root),
 		   btrfs_find_actor, &args);
 }
 
@@ -6412,6 +6421,8 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 * number if we fail afterwards in this function.
 	 */
 	inode->i_ino = objectid;
+	if (objectid != root->inum_overlay)
+		inode->i_ino ^= root->inum_overlay;
 
 	if (dir && name) {
 		trace_btrfs_inode_request(dir);
@@ -9515,7 +9526,7 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 
 	/* check for collisions, even if the  name isn't there */
-	ret = btrfs_check_dir_item_collision(dest, new_dir->i_ino,
+	ret = btrfs_check_dir_item_collision(dest, btrfs_ino(BTRFS_I(new_dir)),
 			     new_dentry->d_name.name,
 			     new_dentry->d_name.len);
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..e008a9ceb827 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -907,7 +907,7 @@ static noinline int btrfs_mksubvol(const struct path *parent,
 	 * check for them now when we can safely fail
 	 */
 	error = btrfs_check_dir_item_collision(BTRFS_I(dir)->root,
-					       dir->i_ino, name,
+					       btrfs_ino(BTRFS_I(dir)), name,
 					       namelen);
 	if (error)
 		goto out_dput;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..5f3350e2f7ec 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -359,6 +359,7 @@ enum {
 	Opt_defrag, Opt_nodefrag,
 	Opt_discard, Opt_nodiscard,
 	Opt_discard_mode,
+	Opt_inumbits,
 	Opt_norecovery,
 	Opt_ratio,
 	Opt_rescan_uuid_tree,
@@ -427,6 +428,7 @@ static const match_table_t tokens = {
 	{Opt_nodefrag, "noautodefrag"},
 	{Opt_discard, "discard"},
 	{Opt_discard_mode, "discard=%s"},
+	{Opt_inumbits, "inumbits=%u"},
 	{Opt_nodiscard, "nodiscard"},
 	{Opt_norecovery, "norecovery"},
 	{Opt_ratio, "metadata_ratio=%u"},
@@ -830,6 +832,25 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_clear_and_info(info, FLUSHONCOMMIT,
 					     "turning off flush-on-commit");
 			break;
+		case Opt_inumbits:
+			if (info->inumbits <= BITS_PER_LONG)
+				/* silently ignore subsequent change
+				 * e.g. on remount
+				 */
+				break;
+			ret = match_int(&args[0], &intarg);
+			if (ret)
+				goto out;
+			if (intarg > BITS_PER_LONG ||
+			    (intarg && intarg < BITS_PER_LONG / 2)) {
+				btrfs_err(info,
+					  "inumbits must be 0 or in range [%d..%d]",
+					  BITS_PER_LONG/2, BITS_PER_LONG);
+				ret = -EINVAL;
+				goto out;
+			}
+			info->inumbits = intarg;
+			break;
 		case Opt_ratio:
 			ret = match_int(&args[0], &intarg);
 			if (ret)
@@ -1537,6 +1558,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	seq_printf(seq, ",inumbits=%u", info->inumbits);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
@@ -1570,7 +1592,7 @@ static int btrfs_set_super(struct super_block *s, void *data)
  */
 static inline int is_subvolume_inode(struct inode *inode)
 {
-	if (inode && inode->i_ino == BTRFS_FIRST_FREE_OBJECTID)
+	if (inode && btrfs_ino(BTRFS_I(inode)) == BTRFS_FIRST_FREE_OBJECTID)
 		return 1;
 	return 0;
 }


