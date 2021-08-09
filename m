Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903643E3E94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 05:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhHID7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 23:59:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58028 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHID7A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 23:59:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 629D71FD81;
        Mon,  9 Aug 2021 03:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628481519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tq+jPyM+goLmgxw4liv9qhmUugdd+4Dbde/VvyuKNE=;
        b=vlMZ6D0KmLQnOJIEYKX+HN+1aMvHQnzr6DEEnhky1podQUy3UhqHiYiI20ikVYrAU7NB0I
        /yfEOb4DvnZd61TQXNrmu3GxeTDbN8RY16FHFlK8H5GblPNM/0vK1EICeZO2XjmoQ8whGQ
        ugPqZcDVOwBQB2smY9eqezBwFjznnUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628481519;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tq+jPyM+goLmgxw4liv9qhmUugdd+4Dbde/VvyuKNE=;
        b=h8QIDoFOLflmvPCnOPnaKVPgHRlsVjLePQXPxWlfxwajaWlN86JyQzFwlz+A3exnNfrESZ
        IVyrdN7tGuF9upAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49C8D13A9F;
        Mon,  9 Aug 2021 03:58:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fUNyAu2nEGHgBgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 03:58:37 +0000
Subject: [PATCH 4/4] Add "tree" number to "inode" number in various /proc
 files.
From:   NeilBrown <neilb@suse.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Mon, 09 Aug 2021 13:55:27 +1000
Message-ID: <162848132776.25823.928326716860337875.stgit@noble.brown>
In-Reply-To: <162848123483.25823.15844774651164477866.stgit@noble.brown>
References: <162848123483.25823.15844774651164477866.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Various /proc files reporting locks, inotify status, or memory mappings
currently report device number and inode node.

These are already "broken" for btrfs as the device number is not one
that is reported by "stat()" (though a program could find a way to map a
file to an entry in /proc/self/mountinfo, and get the device number that
way).

This patch changes all the inode number is those files to "tree:inode"
when the treeid is non-zero.  This it only affect btrfs (at this stage),
and then only when mounted with "-o numdevs=1", as in other cases there
is no value in changing the proc files.

As none of these call ->getattr() to get ino or dev, I have added i_tree
to struct inode so they can get it directly from there.  This isn't
ideal, but is consistent with current code.

Programs that looks for dev:ino based in information from stat(), and
which don't crash on "badly" formatted entries will continue to work as
well as they ever did.

Programs which crash when an entry looks wrong should be fixed anyway.

Programs which correlate a file with /proc/self/mountinfo to find the
"real" device number .... would make me sad.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/btrfs/inode.c     |    6 ++++++
 fs/inode.c           |    1 +
 fs/locks.c           |   12 +++++++++---
 fs/notify/fdinfo.c   |   19 ++++++++++++++-----
 fs/proc/nommu.c      |   11 ++++++++---
 fs/proc/task_mmu.c   |   17 ++++++++++++-----
 fs/proc/task_nommu.c |   11 ++++++++---
 fs/stat.c            |    1 +
 include/linux/fs.h   |    1 +
 9 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c878726d090c..98ba5f32a2b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5787,6 +5787,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 		 * 'root', and should be nearly unique across the filesystem.
 		 */
 		inode->i_ino ^= args->root->inum_overlay;
+	if (args->root && args->root->fs_info->num_devs == 1)
+		inode->i_tree = args->root->root_key.objectid;
 	BTRFS_I(inode)->location.objectid = args->ino;
 	BTRFS_I(inode)->location.type = BTRFS_INODE_ITEM_KEY;
 	BTRFS_I(inode)->location.offset = 0;
@@ -5876,6 +5878,8 @@ static struct inode *new_simple_dir(struct super_block *s,
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
 	inode->i_ino = BTRFS_EMPTY_SUBVOL_DIR_OBJECTID;
+	if (root->fs_info->num_devs == 1)
+		inode->i_tree = root->root_key.objectid;
 	/*
 	 * We only need lookup, the rest is read-only and there's no inode
 	 * associated with the dentry
@@ -6425,6 +6429,8 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	inode->i_ino = objectid;
 	if (objectid != root->inum_overlay)
 		inode->i_ino ^= root->inum_overlay;
+	if (root->fs_info->num_devs == 1)
+		inode->i_tree = root->root_key.objectid;
 
 	if (dir && name) {
 		trace_btrfs_inode_request(dir);
diff --git a/fs/inode.c b/fs/inode.c
index c93500d84264..7f62ac35de02 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -142,6 +142,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_op = &empty_iops;
 	inode->i_fop = &no_open_fops;
 	inode->i_ino = 0;
+	inode->i_tree = 0;
 	inode->__i_nlink = 1;
 	inode->i_opflags = 0;
 	if (sb->s_xattr)
diff --git a/fs/locks.c b/fs/locks.c
index 74b2a1dfe8d8..21b28c019052 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2893,9 +2893,15 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	}
 	if (inode) {
 		/* userspace relies on this representation of dev_t */
-		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
-				MAJOR(inode->i_sb->s_dev),
-				MINOR(inode->i_sb->s_dev), inode->i_ino);
+		if (inode->i_tree)
+			seq_printf(f, "%d %02x:%02x:%lu:%lu ", fl_pid,
+				   MAJOR(inode->i_sb->s_dev),
+				   MINOR(inode->i_sb->s_dev),
+				   inode->i_tree, inode->i_ino);
+		else
+			seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
+				   MAJOR(inode->i_sb->s_dev),
+				   MINOR(inode->i_sb->s_dev), inode->i_ino);
 	} else {
 		seq_printf(f, "%d <none>:0 ", fl_pid);
 	}
diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 57f0d5d9f934..4e8a363d171b 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -90,9 +90,13 @@ static void inotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		 * used only internally to the kernel.
 		 */
 		u32 mask = mark->mask & IN_ALL_EVENTS;
-		seq_printf(m, "inotify wd:%x ino:%lx sdev:%x mask:%x ignored_mask:%x ",
-			   inode_mark->wd, inode->i_ino, inode->i_sb->s_dev,
-			   mask, mark->ignored_mask);
+		seq_printf(m, "inotify wd:%x ", inode_mark->wd);
+		if (inode->i_tree)
+			seq_printf(m, "ino:%lx:%lx ", inode->i_tree, inode->i_ino);
+		else
+			seq_printf(m, "ino:%lx ", inode->i_ino);
+		seq_printf(m, "sdev:%x mask:%x ignored_mask:%x ",
+			   inode->i_sb->s_dev, mask, mark->ignored_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
 		iput(inode);
@@ -120,8 +124,13 @@ static void fanotify_fdinfo(struct seq_file *m, struct fsnotify_mark *mark)
 		inode = igrab(fsnotify_conn_inode(mark->connector));
 		if (!inode)
 			return;
-		seq_printf(m, "fanotify ino:%lx sdev:%x mflags:%x mask:%x ignored_mask:%x ",
-			   inode->i_ino, inode->i_sb->s_dev,
+		if (inode->i_tree)
+			seq_printf(m, "fanotify ino:%lx:%lx", inode->i_tree,
+				   inode->i_ino);
+		else
+			seq_printf(m, "fanotify ino:%lx", inode->i_ino);
+		seq_printf(m, " sdev:%x mflags:%x mask:%x ignored_mask:%x ",
+			   inode->i_sb->s_dev,
 			   mflags, mark->mask, mark->ignored_mask);
 		show_mark_fhandle(m, inode);
 		seq_putc(m, '\n');
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index 13452b32e2bd..371caf60d4a4 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -31,7 +31,7 @@
  */
 static int nommu_region_show(struct seq_file *m, struct vm_region *region)
 {
-	unsigned long ino = 0;
+	unsigned long ino = 0, tree = 0;
 	struct file *file;
 	dev_t dev = 0;
 	int flags;
@@ -43,11 +43,12 @@ static int nommu_region_show(struct seq_file *m, struct vm_region *region)
 		struct inode *inode = file_inode(region->vm_file);
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
+		tree = inode->i_tree;
 	}
 
 	seq_setwidth(m, 25 + sizeof(void *) * 6 - 1);
 	seq_printf(m,
-		   "%08lx-%08lx %c%c%c%c %08llx %02x:%02x %lu ",
+		   "%08lx-%08lx %c%c%c%c %08llx %02x:%02x ",
 		   region->vm_start,
 		   region->vm_end,
 		   flags & VM_READ ? 'r' : '-',
@@ -55,7 +56,11 @@ static int nommu_region_show(struct seq_file *m, struct vm_region *region)
 		   flags & VM_EXEC ? 'x' : '-',
 		   flags & VM_MAYSHARE ? flags & VM_SHARED ? 'S' : 's' : 'p',
 		   ((loff_t)region->vm_pgoff) << PAGE_SHIFT,
-		   MAJOR(dev), MINOR(dev), ino);
+		   MAJOR(dev), MINOR(dev));
+	if (tree)
+		seq_printf(m, "%lu:%lu ", tree, ino);
+	else
+		seq_printf(m, "%lu ", ino);
 
 	if (file) {
 		seq_pad(m, ' ');
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index eb97468dfe4c..9e6439d7939b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -250,7 +250,8 @@ static int is_stack(struct vm_area_struct *vma)
 static void show_vma_header_prefix(struct seq_file *m,
 				   unsigned long start, unsigned long end,
 				   vm_flags_t flags, unsigned long long pgoff,
-				   dev_t dev, unsigned long ino)
+				   dev_t dev, unsigned long ino,
+				   unsigned long tree)
 {
 	seq_setwidth(m, 25 + sizeof(void *) * 6 - 1);
 	seq_put_hex_ll(m, NULL, start, 8);
@@ -263,7 +264,12 @@ static void show_vma_header_prefix(struct seq_file *m,
 	seq_put_hex_ll(m, " ", pgoff, 8);
 	seq_put_hex_ll(m, " ", MAJOR(dev), 2);
 	seq_put_hex_ll(m, ":", MINOR(dev), 2);
-	seq_put_decimal_ull(m, " ", ino);
+	if (tree) {
+		seq_put_decimal_ull(m, " ", tree);
+		seq_put_decimal_ull(m, ":", ino);
+	} else {
+		seq_put_decimal_ull(m, " ", ino);
+	}
 	seq_putc(m, ' ');
 }
 
@@ -273,7 +279,7 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 	struct mm_struct *mm = vma->vm_mm;
 	struct file *file = vma->vm_file;
 	vm_flags_t flags = vma->vm_flags;
-	unsigned long ino = 0;
+	unsigned long ino = 0, tree = 0;
 	unsigned long long pgoff = 0;
 	unsigned long start, end;
 	dev_t dev = 0;
@@ -283,12 +289,13 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
 		struct inode *inode = file_inode(vma->vm_file);
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
+		tree = inode->i_tree;
 		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
 	}
 
 	start = vma->vm_start;
 	end = vma->vm_end;
-	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino);
+	show_vma_header_prefix(m, start, end, flags, pgoff, dev, ino, tree);
 
 	/*
 	 * Print the dentry name for named mappings, and a
@@ -934,7 +941,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	}
 
 	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+			       last_vma_end, 0, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..c33d7aad3927 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -145,7 +145,7 @@ static int is_stack(struct vm_area_struct *vma)
 static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long ino = 0;
+	unsigned long ino = 0, tree = 0;
 	struct file *file;
 	dev_t dev = 0;
 	int flags;
@@ -158,12 +158,13 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 		struct inode *inode = file_inode(vma->vm_file);
 		dev = inode->i_sb->s_dev;
 		ino = inode->i_ino;
+		tree = inode->i_tree;
 		pgoff = (loff_t)vma->vm_pgoff << PAGE_SHIFT;
 	}
 
 	seq_setwidth(m, 25 + sizeof(void *) * 6 - 1);
 	seq_printf(m,
-		   "%08lx-%08lx %c%c%c%c %08llx %02x:%02x %lu ",
+		   "%08lx-%08lx %c%c%c%c %08llx %02x:%02x ",
 		   vma->vm_start,
 		   vma->vm_end,
 		   flags & VM_READ ? 'r' : '-',
@@ -171,7 +172,11 @@ static int nommu_vma_show(struct seq_file *m, struct vm_area_struct *vma)
 		   flags & VM_EXEC ? 'x' : '-',
 		   flags & VM_MAYSHARE ? flags & VM_SHARED ? 'S' : 's' : 'p',
 		   pgoff,
-		   MAJOR(dev), MINOR(dev), ino);
+		   MAJOR(dev), MINOR(dev));
+	if (tree)
+		seq_printf(m, "%lu:%lu ", ino, tree);
+	else
+		seq_printf(m, "%lu ", ino);
 
 	if (file) {
 		seq_pad(m, ' ');
diff --git a/fs/stat.c b/fs/stat.c
index 2dd5d3d67793..4aa402858f64 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -45,6 +45,7 @@ void generic_fillattr(struct user_namespace *mnt_userns, struct inode *inode,
 {
 	stat->dev = inode->i_sb->s_dev;
 	stat->ino = inode->i_ino;
+	stat->tree_id = inode->i_tree;
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
 	stat->uid = i_uid_into_mnt(mnt_userns, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a777c1b1706a..86dc586c408b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -630,6 +630,7 @@ struct inode {
 
 	/* Stat data, not accessed from path walking */
 	unsigned long		i_ino;
+	unsigned long		i_tree;
 	/*
 	 * Filesystems may only read i_nlink directly.  They shall use the
 	 * following functions for modification:


