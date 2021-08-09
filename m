Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C983E3E91
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 05:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhHID6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 23:58:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58014 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbhHID6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:58:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF38E1FD81;
        Mon,  9 Aug 2021 03:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628481513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0ibLBgniy8dCGHqoQUyeVYBRb/qOQupZTOIJDvgt2g=;
        b=wk060BaOhIZOXaR0QlITcFG7NDUq3rpdEZmceRtUc2s0dQyTHZsNc/2/knOfoV02wFTHxq
        810lLyD7rnBbSoTrs7UnIJTXy/1W3DmHweCz0r8/v8mHHYUjmkjtKlQbije9IFgQ9X6Fc1
        mSGOI1ul62Vo/e/HyywTWmgrM7nBQjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628481513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0ibLBgniy8dCGHqoQUyeVYBRb/qOQupZTOIJDvgt2g=;
        b=YzxzSz0ZacRppfs06O0PP5e2MS9+UCD9f4binoggxaCxVjU7n5Uiq+U0aMnOTCHM8mSRnO
        b8OGCnPzWnPEaBBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 320BE13A9F;
        Mon,  9 Aug 2021 03:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wB06OOanEGHZBgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 03:58:30 +0000
Subject: [PATCH 3/4] VFS/btrfs: add STATX_TREE_ID
From:   NeilBrown <neilb@suse.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 09 Aug 2021 13:55:27 +1000
Message-ID: <162848132775.25823.2813836616908535300.stgit@noble.brown>
In-Reply-To: <162848123483.25823.15844774651164477866.stgit@noble.brown>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new 64bit field is added to the data that can be returned by statx() -
the "tree id".
The tree id serves two needs.
1/ it extends the available inode number space.  While a filesystem
   SHOULD ensure the inode number is unique across the filesystem,
   this is sometimes impractical.  In such situations, 'tree id'
   may be used to guarantee uniqueness.  It can identify a separate
   allocation domain.
   A particular case when separate allocation domains is useful
   is when a directory tree can be effectively "reflink"ed.
   Updating all inode numbers in such a tree is prohibitively expensive.
2/ it can identify a collection of objects that provide a coherent
   "tree" in some locally-defined sense.

This patch uses STATX_TREE_ID to export the subvol id for btrfs.

samples/vfs/test_statx.c is extended to report the treeid.

Also: a new superblock field is added: s_tree_id_bits.  This can store
  the number of significant bits in the reported treeid.  It is
  currently unused, but could be used by overlayfs to determine how
  to add a filesystem number to the treeid to differentiate files in
  different underlying filesystems.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/inode.c          |    4 ++++
 fs/btrfs/super.c          |    1 +
 fs/stat.c                 |    1 +
 include/linux/fs.h        |    2 +-
 include/linux/stat.h      |   13 +++++++++++++
 include/uapi/linux/stat.h |    3 ++-
 samples/vfs/test-statx.c  |    4 +++-
 7 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 30fa64cbe6dc..c878726d090c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9215,6 +9215,10 @@ static int btrfs_getattr(struct user_namespace *mnt_userns,
 	case BTRFS_MANY_DEVS:
 		stat->dev = BTRFS_I(inode)->root->anon_dev;
 	}
+	if (request_mask & STATX_TREE_ID) {
+		stat->tree_id = BTRFS_I(inode)->root->root_key.objectid;
+		stat->result_mask |= STATX_TREE_ID;
+	}
 
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b1aecb834234..e6d166150660 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1410,6 +1410,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_tree_id_bits = 48;
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/stat.c b/fs/stat.c
index 1fa38bdec1a6..2dd5d3d67793 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -580,6 +580,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_dev_major = MAJOR(stat->dev);
 	tmp.stx_dev_minor = MINOR(stat->dev);
 	tmp.stx_mnt_id = stat->mnt_id;
+	tmp.stx_tree_id = stat->tree_id;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..a777c1b1706a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1482,7 +1482,7 @@ struct super_block {
 
 	unsigned int		s_max_links;
 	fmode_t			s_mode;
-
+	short			s_tree_id_bits;
 	/*
 	 * The next field is for VFS *only*. No filesystems have any business
 	 * even looking at it. You had been warned.
diff --git a/include/linux/stat.h b/include/linux/stat.h
index fff27e603814..08ee409786b3 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -46,6 +46,19 @@ struct kstat {
 	struct timespec64 btime;			/* File creation time */
 	u64		blocks;
 	u64		mnt_id;
+	/* Treeid can be used to extend the inode number space.  Two inodes
+	 * with different 'tree_id' are different, even if 'ino' is the same
+	 * (though fs should make ino different as often as possible).
+	 * When tree_id is requested and STATX_TREE_ID is set in result_mask,
+	 * 'ino' MUST be unique across the filesystem.  Specifically, two
+	 * open files that report the same dev, ino, and tree_id MUST be
+	 * the same.
+	 * If a directory and an object in that directory have the same dev
+	 * and tree_id, they can be assumed to be in a meaningful tree, though
+	 * the meaning is subject to local interpretation.  The set of inodes
+	 * with a common tree_id is not required to be contiguous.
+	 */
+	u64		tree_id;
 };
 
 #endif
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1500a0f58041..725cf3f8e873 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -124,7 +124,7 @@ struct statx {
 	__u32	stx_dev_minor;
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u64	__spare2;
+	__u64	stx_tree_id;
 	/* 0xa0 */
 	__u64	__spare3[12];	/* Spare space for future expansion */
 	/* 0x100 */
@@ -152,6 +152,7 @@ struct statx {
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_TREE_ID		0x00002000U	/* Want/got stx_treeid and clean stX_ino */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..c1141764fa2e 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -118,6 +118,8 @@ static void dump_statx(struct statx *stx)
 			break;
 		}
 	}
+	if (stx->stx_mask & STATX_TREE_ID)
+		printf(" Tree: %-12llu", (unsigned long long) stx->stx_tree_id);
 	printf("\n");
 
 	if (stx->stx_mask & STATX_MODE)
@@ -218,7 +220,7 @@ int main(int argc, char **argv)
 	struct statx stx;
 	int ret, raw = 0, atflag = AT_SYMLINK_NOFOLLOW;
 
-	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME;
+	unsigned int mask = STATX_BASIC_STATS | STATX_BTIME | STATX_TREE_ID;
 
 	for (argv++; *argv; argv++) {
 		if (strcmp(*argv, "-F") == 0) {


