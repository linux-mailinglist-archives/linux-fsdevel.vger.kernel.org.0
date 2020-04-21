Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A578C1B28BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgDUN57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 09:57:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46735 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728916AbgDUN54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587477473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IIEigFH4euYLZFcVPE/gY3sCMVw531UeBsz7uQYoxI=;
        b=NYM8tDWknsMJRrWdifI6iEPQeC/DPssjz8iuFh7zww3si0jP7JjWqPQSvIFfLhLwOQi0aD
        yiAmAMy2UQ0u+UKDKop68m51u1wyxEiY1HtfCRmabPs3WnKx5GwRIFojogE7npDbNBulRr
        MAtxKGM4WPh8t9p3gs0NUTMdcxX1YnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-r1TxCWD9NJSxP4Q1g_w5Kw-1; Tue, 21 Apr 2020 09:57:52 -0400
X-MC-Unique: r1TxCWD9NJSxP4Q1g_w5Kw-1
Received: by mail-wm1-f72.google.com with SMTP id u11so1399799wmc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2020 06:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IIEigFH4euYLZFcVPE/gY3sCMVw531UeBsz7uQYoxI=;
        b=jd3miC60CSF0J1NrBe1YXsG1rQw2JAFnTCqEjibN/CHFfLe9VbSXZOftP+Hnhktpdn
         lDZOlZIysR4br4vT8QCtHIOgy2Tt9RHG2KUMu5ws1EG/XxcoXv0ucBwnev7J3lDzpZn0
         Or5i9+llkDXsiKDUiUrnU643CCJmNj9kTjys7R4wgY7OMZR90nzFdb0LroT0lFejyMMa
         3OEycExLM3wr7xStVKlIJryTV9p5XN06VI+WibOMynUUclrK50gOVkmVJW71zfUrgF06
         6z4dviwG9ddJwRHdHdTtLpLKl5zEaZe+i6qbG25TIzm1Zgw6YtuXB9hQJIZ/KcxLI1BF
         8ajg==
X-Gm-Message-State: AGi0PuamYlUBPOI1dhstD0X1cLux5t/hwHFpdHBQ2EzwPfL+xH8I0OAF
        ebiY7MVP6fBaumo+OZKnirIZlWtH9zidWMOU2NBhLu5QfPPsmKeZN1B4RJv95UzUI8qKZLsFWeU
        PXmIhW5TZkf93XXskNWM49vqIWw==
X-Received: by 2002:a5d:4381:: with SMTP id i1mr23602745wrq.194.1587477470581;
        Tue, 21 Apr 2020 06:57:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypLt+rusb9oWs62pfY+dvFUY9ArCxclByAUD1+dJnv6mqI25nq4oBzy1Rmpsj/zgn97n7WVQFg==
X-Received: by 2002:a5d:4381:: with SMTP id i1mr23602701wrq.194.1587477470222;
        Tue, 21 Apr 2020 06:57:50 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.194])
        by smtp.gmail.com with ESMTPSA id f23sm3562989wml.4.2020.04.21.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:57:49 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Manoj N. Kumar" <manoj@linux.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.ibm.com>,
        Uma Krishnan <ukrishn@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v2 5/7] libfs: add file creation functions
Date:   Tue, 21 Apr 2020 15:57:39 +0200
Message-Id: <20200421135741.30657-3-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200421135119.30007-1-eesposit@redhat.com>
References: <20200421135119.30007-1-eesposit@redhat.com>
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

