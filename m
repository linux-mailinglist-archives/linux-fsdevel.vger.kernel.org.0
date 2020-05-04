Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7D1C3530
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgEDJAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgEDJAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IIEigFH4euYLZFcVPE/gY3sCMVw531UeBsz7uQYoxI=;
        b=BE5JFqPPvmZ6exmo4pyf8cwY9MRQ5TzB1s08pK39MK0F8BdJDo2nebU2ip9Sfi9JXFkAw1
        E1N9iZYZ88y5/ZCAhXnr3L2IAbmAc5FZxLE340kFForwFbvYk7uRmilcfZIbhZKQByi0Xs
        A7hpd0r9bnHTgHpJ9/TbltWAvEvXha4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-lSPpa4qkN02M2dT5hds4cQ-1; Mon, 04 May 2020 05:00:45 -0400
X-MC-Unique: lSPpa4qkN02M2dT5hds4cQ-1
Received: by mail-wm1-f72.google.com with SMTP id h22so4534103wml.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IIEigFH4euYLZFcVPE/gY3sCMVw531UeBsz7uQYoxI=;
        b=fbQ1nPi6/kJsV335iWCq+9dQ436ObxBKh73RPvQ1rJFWAt+uuSZ/yiBnpXhac95XOv
         3Nms9liqt+parbiRpSJPgc/36WagWkPNG6DzU4qxrFqZTvIxxIEFPMRNaXRvh0AsoHTs
         wHRzjtIQnnN/3sve3JhmNU4VjhH1ACH/6CIUFPPT90RDiohmYlPBAy2h54eKIlRewkP7
         r6CohoKRe0USoSnF0qSrDyJqVQ2QdOhHLVghVHNRONfQvSNf8gJmI20RIL0H3lCs4+5A
         K6PwSQ9YGIRSwHnJ13WgBMTfr0wz9mf3Is2OxcIIkNmhryLhOIEmS+//OwhERgcHrFJ3
         EbWA==
X-Gm-Message-State: AGi0Pub6jv54ex6XaKSbigVs36div8q66jvIYwsLEd1uYhC87Y5aZhBX
        QCE20YEtdOZp3297MZBaJ7bIM77BsZa4aBv5HY45JV4rT5NOSnOi6z8WLLOKMHgPDeD/BYrcEnP
        gqJivpWLzel8bBH5j81B2EifsUg==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr13190318wme.0.1588582844038;
        Mon, 04 May 2020 02:00:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7cTfFgvNNGrMEitRciGBgC/FMKXF2hdIb6eT2wnu6p2bAkNVK/QrF1BuJrSQF9koo5AfklA==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr13190289wme.0.1588582843669;
        Mon, 04 May 2020 02:00:43 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:43 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 5/7] libfs: add file creation functions
Date:   Mon,  4 May 2020 11:00:30 +0200
Message-Id: <20200504090032.10367-6-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A bunch of code is duplicated between debugfs and tracefs, unify it to the
libfs library.

The code is very similar, except that dentry and inode creation are unified
into a single function (unlike start_creating in debugfs and tracefs, which
only takes care of dentries).  This adds an output parameter to the
creation functions, but pushes all error recovery into fs/libfs.c.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/libfs.c         | 226 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  18 ++++
 2 files changed, 244 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5c76e4c648dc..90b0c221d9a2 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -751,6 +751,232 @@ struct inode *simple_alloc_anon_inode(struct simple_fs *fs)
 }
 EXPORT_SYMBOL(simple_alloc_anon_inode);
 
+static struct dentry *failed_creating(struct simple_fs *fs, struct dentry *dentry)
+{
+	inode_unlock(d_inode(dentry->d_parent));
+	dput(dentry);
+	simple_release_fs(fs);
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * simplefs_create_dentry - creates a new dentry and inode
+ * @fs: a pointer to a struct simple_fs containing the reference counter
+ *      and vfs_mount pointer
+ * @type: the fs type
+ * @name: dentry name
+ * @parent: parent dentry. If this parameter is NULL,
+ *          then the dentry will be created in the root of the
+ *          filesystem.
+ * @inode: pointer that will contain a newly created inode
+ *
+ * This function returns a new dentry, or NULL on error.  On success, a
+ * new inode is created and stored into @inode.  Also note that the inode
+ * for the parent directory is locked by simplefs_create_dentry(),
+ * and will be unlocked by simple_finish_dentry().
+ **/
+struct dentry *simplefs_create_dentry(struct simple_fs *fs, struct file_system_type *type,
+				      const char *name, struct dentry *parent,
+				      struct inode **inode)
+{
+	struct dentry *dentry;
+	int error;
+
+	pr_debug("creating file '%s'\n", name);
+
+	if (IS_ERR(parent))
+		return parent;
+
+	error = simple_pin_fs(fs, type);
+	if (error) {
+		pr_err("Unable to pin filesystem for file '%s'\n", name);
+		return ERR_PTR(error);
+	}
+
+	/* If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = fs->mount->mnt_root;
+
+	inode_lock(d_inode(parent));
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
+		if (d_is_dir(dentry))
+			pr_err("Directory '%s' with parent '%s' already present!\n",
+			       name, parent->d_name.name);
+		else
+			pr_err("File '%s' in directory '%s' already present!\n",
+			       name, parent->d_name.name);
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+	}
+
+	if (IS_ERR(dentry)) {
+		inode_unlock(d_inode(parent));
+		simple_release_fs(fs);
+	}
+
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	*inode = new_inode_current_time(fs->mount->mnt_sb);
+	if (unlikely(!(*inode))) {
+		pr_err("out of free inodes, can not create file '%s'\n",
+		       name);
+		return failed_creating(fs, dentry);
+	}
+
+	return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_dentry);
+
+/**
+ * simplefs_create_file - creates a new file dentry and inode
+ * @fs: a pointer to a struct simple_fs containing the reference counter
+ *      and vfs_mount pointer
+ * @type: the fs type
+ * @name: file name
+ * @mode: file mode
+ * @parent: parent dentry. If this parameter is NULL,
+ *          then the file will be created in the root of the
+ *          filesystem.
+ * @data: what will the file contain
+ * @inode: pointer that will contain a newly created inode
+ *
+ * This function returns a new dentry, or NULL on error.  On success, a
+ * new inode is created and stored into @inode.  Also note that the inode
+ * for the parent directory is locked by simplefs_create_dentry(),
+ * and will be unlocked by simple_finish_dentry().
+ **/
+struct dentry *simplefs_create_file(struct simple_fs *fs, struct file_system_type *type,
+				    const char *name, umode_t mode,
+				    struct dentry *parent, void *data,
+				    struct inode **inode)
+{
+	struct dentry *dentry;
+
+	WARN_ON((mode & S_IFMT) && !S_ISREG(mode));
+	mode |= S_IFREG;
+
+	dentry = simplefs_create_dentry(fs, type, name, parent, inode);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	(*inode)->i_mode = mode;
+	(*inode)->i_private = data;
+
+	return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_file);
+
+
+/**
+ * simplefs_finish_dentry- complete creation of a new dentry
+ * @dentry: the dentry being created
+ * @inode: the inode associated to the dentry
+ *
+ * This function completes the creation of a dentry.
+ * This includes associating @inode with the dentry, ensuring the link
+ * counts are consistent and informing fsnotify.
+ **/
+struct dentry *simplefs_finish_dentry(struct dentry *dentry, struct inode *inode)
+{
+	d_instantiate(dentry, inode);
+	if (S_ISDIR(inode->i_mode)) {
+		inc_nlink(d_inode(dentry->d_parent));
+		fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
+	} else {
+		fsnotify_create(d_inode(dentry->d_parent), dentry);
+	}
+	inode_unlock(d_inode(dentry->d_parent));
+	return dentry;
+}
+EXPORT_SYMBOL(simplefs_finish_dentry);
+
+/**
+ * simplefs_create_dir - creates a new directory dentry and inode
+ * @fs: a pointer to a struct simple_fs containing the reference counter
+ *      and vfs_mount pointer
+ * @type: the fs type
+ * @name: dir name
+ * @mode: dir mode
+ * @parent: parent dentry. If this parameter is NULL,
+ *          then the directory will be created in the root of the
+ *          filesystem.
+ * @inode: pointer that will contain a newly created inode
+ *
+ * This function returns a new dentry, or NULL on error.  On success, a
+ * new inode is created and stored into @inode.  Also note that the inode
+ * for the parent directory is locked by simplefs_create_dentry(),
+ * and will be unlocked by simple_finish_dentry().
+ **/
+struct dentry *simplefs_create_dir(struct simple_fs *fs, struct file_system_type *type,
+				   const char *name, umode_t mode, struct dentry *parent,
+				   struct inode **inode)
+{
+	struct dentry *dentry;
+
+	WARN_ON((mode & S_IFMT) && !S_ISDIR(mode));
+	mode |= S_IFDIR;
+
+	dentry = simplefs_create_dentry(fs, type, name, parent, inode);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	(*inode)->i_mode = mode;
+	(*inode)->i_op = &simple_dir_inode_operations;
+	(*inode)->i_fop = &simple_dir_operations;
+
+	/* directory inodes start off with i_nlink == 2 (for "." entry) */
+	inc_nlink(*inode);
+	return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_dir);
+
+/**
+ * simplefs_create_symlink - creates a new symlink dentry and inode
+ * @fs: a pointer to a struct simple_fs containing the reference counter
+ *      and vfs_mount pointer
+ * @type: the fs type
+ * @name: symlink name
+ * @parent: parent dentry. If this parameter is NULL,
+ *          then the symbolic link will be created in the root of the
+ *          filesystem.
+ * @inode: pointer that will contain a newly created inode
+ *
+ * This function returns a new dentry, or NULL on error.  On success, a
+ * new inode is created and stored into @inode.  Also note that the inode
+ * for the parent directory is locked by simplefs_create_dentry(),
+ * and will be unlocked by simple_finish_dentry().
+ **/
+struct dentry *simplefs_create_symlink(struct simple_fs *fs, struct file_system_type *type,
+				       const char *name, struct dentry *parent,
+				       const char *target, struct inode **inode)
+{
+	struct dentry *dentry;
+	char *link = kstrdup(target, GFP_KERNEL);
+
+	if (!link)
+		return ERR_PTR(-ENOMEM);
+
+	dentry = simplefs_create_dentry(fs, type, name, parent, inode);
+	if (IS_ERR(dentry)) {
+		kfree_link(link);
+		return dentry;
+	}
+
+	(*inode)->i_mode = S_IFLNK | S_IRWXUGO;
+	(*inode)->i_link = link;
+	(*inode)->i_op = &simple_symlink_inode_operations;
+	return dentry;
+}
+EXPORT_SYMBOL(simplefs_create_symlink);
+
 /**
  * simple_read_from_buffer - copy data from the buffer to user space
  * @to: the user space buffer to read to
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5e93de72118b..0569540fbe61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3375,6 +3375,24 @@ extern void simple_release_fs(struct simple_fs *);
 
 extern struct inode *simple_alloc_anon_inode(struct simple_fs *fs);
 
+extern struct dentry *simplefs_create_dentry(struct simple_fs *fs,
+					     struct file_system_type *type,
+					     const char *name, struct dentry *parent,
+					     struct inode **inode);
+struct dentry *simplefs_finish_dentry(struct dentry *dentry, struct inode *inode);
+
+extern struct dentry *simplefs_create_file(struct simple_fs *fs,
+					   struct file_system_type *type,
+					   const char *name, umode_t mode,
+					   struct dentry *parent, void *data,
+					   struct inode **inode);
+extern struct dentry *simplefs_create_dir(struct simple_fs *fs, struct file_system_type *type,
+					  const char *name, umode_t mode, struct dentry *parent,
+					  struct inode **inode);
+extern struct dentry *simplefs_create_symlink(struct simple_fs *fs, struct file_system_type *type,
+					      const char *name, struct dentry *parent,
+					      const char *target, struct inode **inode);
+
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
 extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
-- 
2.25.2

