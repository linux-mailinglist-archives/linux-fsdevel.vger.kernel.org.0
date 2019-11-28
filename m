Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61510CC12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfK1PtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:49:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38590 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1PtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:49:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so31786939wro.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4hC+LRiVyIClNdIO+JGB06W5l46xZBcbPf5TtnyOs3k=;
        b=Y83fiho+HOKJL4Mkz9r4NFZdzSl2Wu8gfjXU3dzQ9zHdSao1nUjS6UvGneRm6vJDoy
         UJAJv8c9CRQduVzmlh7m0ACS4+oXHbT9kl9etEcURpJo81gF5bNW1+bSGdliFbw0uAja
         EHq4xloLdALJsj0zvbaEl3Oaipgc3dygupHGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4hC+LRiVyIClNdIO+JGB06W5l46xZBcbPf5TtnyOs3k=;
        b=d05tkKvoYbuzitkkUCeEPLD8OECVKAMxT/mxtwZih7HkueKR5UYfilnPwtfQDV7aK/
         HZkTmsmggstMzxfknJOcZWX/G1WS28dlqyG/cHLsklXdWYklt6ALJ3Ntl2WSTjYSqOWN
         YV8h64Lxok6qZqp/RL01IpgxD/yBNMUrbt6GtTOGHGy4MLdS72OJKId5WZfVqoM8va45
         eZWUtZaLZFSKU+2tLRXYSPqkE4BHME5USV8PhDvfUIRoztjqlXG2s0zkB/pm+HWJHpQL
         C1xcj4S8iF1ZPSxxQQHfUcdYenfq/8RVJivyDFcEHczS8s/+2EceLZJcwP6lXNyRX15n
         Dw9A==
X-Gm-Message-State: APjAAAVi0ogDI3jvrEw8JSAuGIFltMzeyB+TMHaaSKZGuiqcY/c2kMOr
        cHiHOeuHsckRjhO7MMDy0mO2FEIW/Uo=
X-Google-Smtp-Source: APXvYqzJUfZwE0hE7coDzQt0SKqtL7whjhRHgm6m0+yjXtktWYUZQ2Hw4bMfj20VZrL9brtV0rnQ3Q==
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr31691989wrn.128.1574956146123;
        Thu, 28 Nov 2019 07:49:06 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t8sm1015355wrp.69.2019.11.28.07.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:49:05 -0800 (PST)
Date:   Thu, 28 Nov 2019 16:48:58 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] vfs: make rename_lock per-sb
Message-ID: <20191128154858.GA16668@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs uses rename to atomically move copied up files into place.  This
can result in heavier than usual rename load, which in turn might result in
cross-filesystem serialization of tree walking and rename operations.

One notable case where this seems to have been manifesting itself is
shrink_dcache_for_umount(), where otherwise there would be no contention at
all.

Turning rename_lock into a per-sb lock mitigates the above issues.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/autofs/waitq.c      |    6 ++---
 fs/ceph/mds_client.c   |    4 +--
 fs/cifs/dir.c          |    8 ++++---
 fs/d_path.c            |   14 +++++++-----
 fs/dcache.c            |   55 +++++++++++++++++++++++++++----------------------
 fs/nfs/namespace.c     |    7 +++---
 fs/super.c             |    1 
 include/linux/dcache.h |    2 -
 include/linux/fs.h     |    2 +
 kernel/auditsc.c       |    5 ++--
 10 files changed, 59 insertions(+), 45 deletions(-)

--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -189,7 +189,7 @@ static int autofs_getpath(struct autofs_
 	buf = name;
 	len = 0;
 
-	seq = read_seqbegin(&rename_lock);
+	seq = read_seqbegin(&sbi->sb->rename_lock);
 	rcu_read_lock();
 	spin_lock(&sbi->fs_lock);
 	for (tmp = dentry ; tmp != root ; tmp = tmp->d_parent)
@@ -198,7 +198,7 @@ static int autofs_getpath(struct autofs_
 	if (!len || --len > NAME_MAX) {
 		spin_unlock(&sbi->fs_lock);
 		rcu_read_unlock();
-		if (read_seqretry(&rename_lock, seq))
+		if (read_seqretry(&sbi->sb->rename_lock, seq))
 			goto rename_retry;
 		return 0;
 	}
@@ -214,7 +214,7 @@ static int autofs_getpath(struct autofs_
 	}
 	spin_unlock(&sbi->fs_lock);
 	rcu_read_unlock();
-	if (read_seqretry(&rename_lock, seq))
+	if (read_seqretry(&sbi->sb->rename_lock, seq))
 		goto rename_retry;
 
 	return len;
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2143,7 +2143,7 @@ char *ceph_mdsc_build_path(struct dentry
 	pos = PATH_MAX - 1;
 	path[pos] = '\0';
 
-	seq = read_seqbegin(&rename_lock);
+	seq = read_seqbegin(&dentry->d_sb->rename_lock);
 	rcu_read_lock();
 	temp = dentry;
 	for (;;) {
@@ -2182,7 +2182,7 @@ char *ceph_mdsc_build_path(struct dentry
 	}
 	base = ceph_ino(d_inode(temp));
 	rcu_read_unlock();
-	if (pos < 0 || read_seqretry(&rename_lock, seq)) {
+	if (pos < 0 || read_seqretry(&dentry->d_sb->rename_lock, seq)) {
 		pr_err("build_path did not end path lookup where "
 		       "expected, pos is %d\n", pos);
 		/* presumably this is only possible if racing with a
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -97,7 +97,8 @@ build_path_from_dentry_optional_prefix(s
 	int pplen = 0;
 	char *full_path;
 	char dirsep;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
+	struct super_block *sb = direntry->d_sb;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 	unsigned seq;
 
@@ -112,7 +113,7 @@ build_path_from_dentry_optional_prefix(s
 
 cifs_bp_rename_retry:
 	namelen = dfsplen + pplen;
-	seq = read_seqbegin(&rename_lock);
+	seq = read_seqbegin(&sb->rename_lock);
 	rcu_read_lock();
 	for (temp = direntry; !IS_ROOT(temp);) {
 		namelen += (1 + temp->d_name.len);
@@ -152,7 +153,8 @@ build_path_from_dentry_optional_prefix(s
 		}
 	}
 	rcu_read_unlock();
-	if (namelen != dfsplen + pplen || read_seqretry(&rename_lock, seq)) {
+	if (namelen != dfsplen + pplen ||
+	    read_seqretry(&sb->rename_lock, seq)) {
 		cifs_dbg(FYI, "did not end path lookup where expected. namelen=%ddfsplen=%d\n",
 			 namelen, dfsplen);
 		/* presumably this is only possible if racing with a rename
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -76,6 +76,7 @@ static int prepend_path(const struct pat
 			const struct path *root,
 			char **buffer, int *buflen)
 {
+	struct super_block *sb = root->mnt->mnt_sb;
 	struct dentry *dentry;
 	struct vfsmount *vfsmnt;
 	struct mount *mnt;
@@ -96,7 +97,7 @@ static int prepend_path(const struct pat
 	dentry = path->dentry;
 	vfsmnt = path->mnt;
 	mnt = real_mount(vfsmnt);
-	read_seqbegin_or_lock(&rename_lock, &seq);
+	read_seqbegin_or_lock(&sb->rename_lock, &seq);
 	while (dentry != root->dentry || vfsmnt != root->mnt) {
 		struct dentry * parent;
 
@@ -132,11 +133,11 @@ static int prepend_path(const struct pat
 	}
 	if (!(seq & 1))
 		rcu_read_unlock();
-	if (need_seqretry(&rename_lock, seq)) {
+	if (need_seqretry(&sb->rename_lock, seq)) {
 		seq = 1;
 		goto restart;
 	}
-	done_seqretry(&rename_lock, seq);
+	done_seqretry(&sb->rename_lock, seq);
 
 	if (!(m_seq & 1))
 		rcu_read_unlock();
@@ -324,6 +325,7 @@ char *simple_dname(struct dentry *dentry
  */
 static char *__dentry_path(struct dentry *d, char *buf, int buflen)
 {
+	struct super_block *sb = d->d_sb;
 	struct dentry *dentry;
 	char *end, *retval;
 	int len, seq = 0;
@@ -341,7 +343,7 @@ static char *__dentry_path(struct dentry
 	/* Get '/' right */
 	retval = end-1;
 	*retval = '/';
-	read_seqbegin_or_lock(&rename_lock, &seq);
+	read_seqbegin_or_lock(&sb->rename_lock, &seq);
 	while (!IS_ROOT(dentry)) {
 		struct dentry *parent = dentry->d_parent;
 
@@ -355,11 +357,11 @@ static char *__dentry_path(struct dentry
 	}
 	if (!(seq & 1))
 		rcu_read_unlock();
-	if (need_seqretry(&rename_lock, seq)) {
+	if (need_seqretry(&sb->rename_lock, seq)) {
 		seq = 1;
 		goto restart;
 	}
-	done_seqretry(&rename_lock, seq);
+	done_seqretry(&sb->rename_lock, seq);
 	if (error)
 		goto Elong;
 	return retval;
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -74,10 +74,6 @@
 int sysctl_vfs_cache_pressure __read_mostly = 100;
 EXPORT_SYMBOL_GPL(sysctl_vfs_cache_pressure);
 
-__cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
-
-EXPORT_SYMBOL(rename_lock);
-
 static struct kmem_cache *dentry_cache __read_mostly;
 
 const struct qstr empty_name = QSTR_INIT("", 0);
@@ -1267,6 +1263,7 @@ enum d_walk_ret {
 static void d_walk(struct dentry *parent, void *data,
 		   enum d_walk_ret (*enter)(void *, struct dentry *))
 {
+	struct super_block *sb = parent->d_sb;
 	struct dentry *this_parent;
 	struct list_head *next;
 	unsigned seq = 0;
@@ -1274,7 +1271,7 @@ static void d_walk(struct dentry *parent
 	bool retry = true;
 
 again:
-	read_seqbegin_or_lock(&rename_lock, &seq);
+	read_seqbegin_or_lock(&sb->rename_lock, &seq);
 	this_parent = parent;
 	spin_lock(&this_parent->d_lock);
 
@@ -1339,7 +1336,7 @@ static void d_walk(struct dentry *parent
 		spin_lock(&this_parent->d_lock);
 
 		/* might go back up the wrong parent if we have had a rename. */
-		if (need_seqretry(&rename_lock, seq))
+		if (need_seqretry(&sb->rename_lock, seq))
 			goto rename_retry;
 		/* go into the first sibling still alive */
 		do {
@@ -1351,13 +1348,13 @@ static void d_walk(struct dentry *parent
 		rcu_read_unlock();
 		goto resume;
 	}
-	if (need_seqretry(&rename_lock, seq))
+	if (need_seqretry(&sb->rename_lock, seq))
 		goto rename_retry;
 	rcu_read_unlock();
 
 out_unlock:
 	spin_unlock(&this_parent->d_lock);
-	done_seqretry(&rename_lock, seq);
+	done_seqretry(&sb->rename_lock, seq);
 	return;
 
 rename_retry:
@@ -1419,9 +1416,10 @@ EXPORT_SYMBOL(path_has_submounts);
  */
 int d_set_mounted(struct dentry *dentry)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct dentry *p;
 	int ret = -ENOENT;
-	write_seqlock(&rename_lock);
+	write_seqlock(&sb->rename_lock);
 	for (p = dentry->d_parent; !IS_ROOT(p); p = p->d_parent) {
 		/* Need exclusion wrt. d_invalidate() */
 		spin_lock(&p->d_lock);
@@ -1441,7 +1439,7 @@ int d_set_mounted(struct dentry *dentry)
 	}
  	spin_unlock(&dentry->d_lock);
 out:
-	write_sequnlock(&rename_lock);
+	write_sequnlock(&sb->rename_lock);
 	return ret;
 }
 
@@ -2306,15 +2304,16 @@ struct dentry *__d_lookup_rcu(const stru
  */
 struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
 {
+	struct super_block *sb = parent->d_sb;
 	struct dentry *dentry;
 	unsigned seq;
 
 	do {
-		seq = read_seqbegin(&rename_lock);
+		seq = read_seqbegin(&sb->rename_lock);
 		dentry = __d_lookup(parent, name);
 		if (dentry)
 			break;
-	} while (read_seqretry(&rename_lock, seq));
+	} while (read_seqretry(&sb->rename_lock, seq));
 	return dentry;
 }
 EXPORT_SYMBOL(d_lookup);
@@ -2513,6 +2512,7 @@ struct dentry *d_alloc_parallel(struct d
 				const struct qstr *name,
 				wait_queue_head_t *wq)
 {
+	struct super_block *sb = parent->d_sb;
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
 	struct hlist_bl_node *node;
@@ -2526,7 +2526,7 @@ struct dentry *d_alloc_parallel(struct d
 retry:
 	rcu_read_lock();
 	seq = smp_load_acquire(&parent->d_inode->i_dir_seq);
-	r_seq = read_seqbegin(&rename_lock);
+	r_seq = read_seqbegin(&sb->rename_lock);
 	dentry = __d_lookup_rcu(parent, name, &d_seq);
 	if (unlikely(dentry)) {
 		if (!lockref_get_not_dead(&dentry->d_lockref)) {
@@ -2542,7 +2542,7 @@ struct dentry *d_alloc_parallel(struct d
 		dput(new);
 		return dentry;
 	}
-	if (unlikely(read_seqretry(&rename_lock, r_seq))) {
+	if (unlikely(read_seqretry(&sb->rename_lock, r_seq))) {
 		rcu_read_unlock();
 		goto retry;
 	}
@@ -2890,9 +2890,11 @@ static void __d_move(struct dentry *dent
  */
 void d_move(struct dentry *dentry, struct dentry *target)
 {
-	write_seqlock(&rename_lock);
+	struct super_block *sb = dentry->d_sb;
+
+	write_seqlock(&sb->rename_lock);
 	__d_move(dentry, target, false);
-	write_sequnlock(&rename_lock);
+	write_sequnlock(&sb->rename_lock);
 }
 EXPORT_SYMBOL(d_move);
 
@@ -2903,7 +2905,9 @@ EXPORT_SYMBOL(d_move);
  */
 void d_exchange(struct dentry *dentry1, struct dentry *dentry2)
 {
-	write_seqlock(&rename_lock);
+	struct super_block *sb = dentry1->d_sb;
+
+	write_seqlock(&sb->rename_lock);
 
 	WARN_ON(!dentry1->d_inode);
 	WARN_ON(!dentry2->d_inode);
@@ -2912,7 +2916,7 @@ void d_exchange(struct dentry *dentry1,
 
 	__d_move(dentry1, dentry2, true);
 
-	write_sequnlock(&rename_lock);
+	write_sequnlock(&sb->rename_lock);
 }
 
 /**
@@ -2997,6 +3001,8 @@ static int __d_unalias(struct inode *ino
  */
 struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 {
+	struct super_block *sb = dentry->d_sb;
+
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
@@ -3012,9 +3018,9 @@ struct dentry *d_splice_alias(struct ino
 		if (unlikely(new)) {
 			/* The reference to new ensures it remains an alias */
 			spin_unlock(&inode->i_lock);
-			write_seqlock(&rename_lock);
+			write_seqlock(&sb->rename_lock);
 			if (unlikely(d_ancestor(new, dentry))) {
-				write_sequnlock(&rename_lock);
+				write_sequnlock(&sb->rename_lock);
 				dput(new);
 				new = ERR_PTR(-ELOOP);
 				pr_warn_ratelimited(
@@ -3026,7 +3032,7 @@ struct dentry *d_splice_alias(struct ino
 			} else if (!IS_ROOT(new)) {
 				struct dentry *old_parent = dget(new->d_parent);
 				int err = __d_unalias(inode, dentry, new);
-				write_sequnlock(&rename_lock);
+				write_sequnlock(&sb->rename_lock);
 				if (err) {
 					dput(new);
 					new = ERR_PTR(err);
@@ -3034,7 +3040,7 @@ struct dentry *d_splice_alias(struct ino
 				dput(old_parent);
 			} else {
 				__d_move(new, dentry, false);
-				write_sequnlock(&rename_lock);
+				write_sequnlock(&sb->rename_lock);
 			}
 			iput(inode);
 			return new;
@@ -3064,6 +3070,7 @@ EXPORT_SYMBOL(d_splice_alias);
   
 bool is_subdir(struct dentry *new_dentry, struct dentry *old_dentry)
 {
+	struct super_block *sb = new_dentry->d_sb;
 	bool result;
 	unsigned seq;
 
@@ -3072,7 +3079,7 @@ bool is_subdir(struct dentry *new_dentry
 
 	do {
 		/* for restarting inner loop in case of seq retry */
-		seq = read_seqbegin(&rename_lock);
+		seq = read_seqbegin(&sb->rename_lock);
 		/*
 		 * Need rcu_readlock to protect against the d_parent trashing
 		 * due to d_move
@@ -3083,7 +3090,7 @@ bool is_subdir(struct dentry *new_dentry
 		else
 			result = false;
 		rcu_read_unlock();
-	} while (read_seqretry(&rename_lock, seq));
+	} while (read_seqretry(&sb->rename_lock, seq));
 
 	return result;
 }
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -51,6 +51,7 @@ int nfs_mountpoint_expiry_timeout = 500
 char *nfs_path(char **p, struct dentry *dentry, char *buffer, ssize_t buflen,
 	       unsigned flags)
 {
+	struct super_block *sb = dentry->d_sb;
 	char *end;
 	int namelen;
 	unsigned seq;
@@ -61,7 +62,7 @@ char *nfs_path(char **p, struct dentry *
 	*--end = '\0';
 	buflen--;
 
-	seq = read_seqbegin(&rename_lock);
+	seq = read_seqbegin(&sb->rename_lock);
 	rcu_read_lock();
 	while (1) {
 		spin_lock(&dentry->d_lock);
@@ -77,7 +78,7 @@ char *nfs_path(char **p, struct dentry *
 		spin_unlock(&dentry->d_lock);
 		dentry = dentry->d_parent;
 	}
-	if (read_seqretry(&rename_lock, seq)) {
+	if (read_seqretry(&sb->rename_lock, seq)) {
 		spin_unlock(&dentry->d_lock);
 		rcu_read_unlock();
 		goto rename_retry;
@@ -118,7 +119,7 @@ char *nfs_path(char **p, struct dentry *
 Elong_unlock:
 	spin_unlock(&dentry->d_lock);
 	rcu_read_unlock();
-	if (read_seqretry(&rename_lock, seq))
+	if (read_seqretry(&sb->rename_lock, seq))
 		goto rename_retry;
 Elong:
 	return ERR_PTR(-ENAMETOOLONG);
--- a/fs/super.c
+++ b/fs/super.c
@@ -249,6 +249,7 @@ static struct super_block *alloc_super(s
 	spin_lock_init(&s->s_inode_list_lock);
 	INIT_LIST_HEAD(&s->s_inodes_wb);
 	spin_lock_init(&s->s_inode_wblist_lock);
+	seqlock_init(&s->rename_lock);
 
 	s->s_count = 1;
 	atomic_set(&s->s_active, 1);
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -218,8 +218,6 @@ struct dentry_operations {
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
 
-extern seqlock_t rename_lock;
-
 /*
  * These are the low-level FS interfaces to the dcache..
  */
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1548,6 +1548,8 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	seqlock_t		rename_lock ____cacheline_aligned_in_smp;
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1763,6 +1763,7 @@ static inline void handle_one(const stru
 
 static void handle_path(const struct dentry *dentry)
 {
+	struct super_block *sb = dentry->d_sb;
 	struct audit_context *context;
 	struct audit_tree_refs *p;
 	const struct dentry *d, *parent;
@@ -1777,7 +1778,7 @@ static void handle_path(const struct den
 	drop = NULL;
 	d = dentry;
 	rcu_read_lock();
-	seq = read_seqbegin(&rename_lock);
+	seq = read_seqbegin(&sb->rename_lock);
 	for(;;) {
 		struct inode *inode = d_backing_inode(d);
 		if (inode && unlikely(inode->i_fsnotify_marks)) {
@@ -1795,7 +1796,7 @@ static void handle_path(const struct den
 			break;
 		d = parent;
 	}
-	if (unlikely(read_seqretry(&rename_lock, seq) || drop)) {  /* in this order */
+	if (unlikely(read_seqretry(&sb->rename_lock, seq) || drop)) {  /* in this order */
 		rcu_read_unlock();
 		if (!drop) {
 			/* just a race with rename */
