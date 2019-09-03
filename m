Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5AAA6778
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfICLgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:36:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17113 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfICLgr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:47 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0E7E83F42
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:36:46 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id n11so2722549wmc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+R6u9BwnxHtMmSw8yzvUPcyLZu2IYokosGRavDc1YJk=;
        b=ADGHCBBvGZLXEV32dPYGv1KlO3hRUSTc9zyeMRvM0TcOK1OPdNJGWTiKKMt5iezIYa
         XHoCNPhR4lF/ffbFIBsqtwL41p0uOmzP5+e24W3qQkkCYvIn2goOlZI7DYaF42gQ9GZy
         ggLjq7AprHeujNq2760bpSjjvDyBjPZtWZB6uXe7QqZ2vb7PNajhjkfaKgy6pd8NwUIt
         ca6hHNTx0XsOYhGU3AJDSUO0C0aHbck0dFYV6RA6IOBkomiouDTnuk9zo3POjCaRivtu
         iBq1tky9uf0Za84ehKVOQnE6YMdv6kx3z3AbUThTjTxwIhqAnM+3wOIxVtrv+YdC8cej
         qfSA==
X-Gm-Message-State: APjAAAXaO4K1mua9cda2fcZYT+jMSJyf46J8ce7tXFctxSpmlTcsVix+
        zTlQKZdvAzIE5xBmNaF9DyIdS2YeXCAkgLI/5eIFu9ben1mVkahzNv0PricXOEy69S4ihgyjeRp
        4ogcFPIkhOgjccwp0TNgPkFiBkQ==
X-Received: by 2002:a05:600c:24d0:: with SMTP id 16mr40897759wmu.83.1567510605637;
        Tue, 03 Sep 2019 04:36:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNzoTb5kcCzSeUblWBr3WZS6gFDMXCvybTGTUc/KXpnyf6okjLS075SUWlCDpw2Sh6TqadCg==
X-Received: by 2002:a05:600c:24d0:: with SMTP id 16mr40897738wmu.83.1567510605375;
        Tue, 03 Sep 2019 04:36:45 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v186sm40446906wmb.5.2019.09.03.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:44 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v4 01/16] vfs: Create fs_context-aware mount_bdev() replacement
Date:   Tue,  3 Sep 2019 13:36:25 +0200
Message-Id: <20190903113640.7984-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903113640.7984-1-mszeredi@redhat.com>
References: <20190903113640.7984-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Create a function, vfs_get_block_super(), that is fs_context-aware and a
replacement for mount_bdev().  It caches the block device pointer and file
open mode in the fs_context struct so that this information can be passed
into sget_fc()'s test and set functions.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>
cc: linux-block@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fs_context.c            |   2 +
 fs/super.c                 | 111 ++++++++++++++++++++++++++++++++++++-
 include/linux/fs_context.h |   9 +++
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 103643c68e3f..270ecae32216 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -501,6 +501,8 @@ void put_fs_context(struct fs_context *fc)
 
 	if (fc->need_free && fc->ops && fc->ops->free)
 		fc->ops->free(fc);
+	if (fc->dev_destructor)
+		fc->dev_destructor(fc);
 
 	security_free_mnt_opts(&fc->security);
 	put_net(fc->net_ns);
diff --git a/fs/super.c b/fs/super.c
index 5960578a4076..80b56bc7d2db 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1212,6 +1212,110 @@ int get_tree_single(struct fs_context *fc,
 EXPORT_SYMBOL(get_tree_single);
 
 #ifdef CONFIG_BLOCK
+static void fc_bdev_destructor(struct fs_context *fc)
+{
+	if (fc->bdev) {
+		blkdev_put(fc->bdev, fc->bdev_mode);
+		fc->bdev = NULL;
+	}
+}
+
+static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
+{
+	s->s_mode = fc->bdev_mode;
+	s->s_bdev = fc->bdev;
+	s->s_dev = s->s_bdev->bd_dev;
+	s->s_bdi = bdi_get(s->s_bdev->bd_bdi);
+	fc->bdev = NULL;
+	return 0;
+}
+
+static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
+{
+	return s->s_bdev == fc->bdev;
+}
+
+/**
+ * vfs_get_block_super - Get a superblock based on a single block device
+ * @fc: The filesystem context holding the parameters
+ * @keying: How to distinguish superblocks
+ * @fill_super: Helper to initialise a new superblock
+ */
+int vfs_get_block_super(struct fs_context *fc,
+			int (*fill_super)(struct super_block *,
+					  struct fs_context *))
+{
+	struct block_device *bdev;
+	struct super_block *s;
+	int error = 0;
+
+	fc->bdev_mode = FMODE_READ | FMODE_EXCL;
+	if (!(fc->sb_flags & SB_RDONLY))
+		fc->bdev_mode |= FMODE_WRITE;
+
+	if (!fc->source)
+		return invalf(fc, "No source specified");
+
+	bdev = blkdev_get_by_path(fc->source, fc->bdev_mode, fc->fs_type);
+	if (IS_ERR(bdev)) {
+		errorf(fc, "%s: Can't open blockdev", fc->source);
+		return PTR_ERR(bdev);
+	}
+
+	fc->dev_destructor = fc_bdev_destructor;
+	fc->bdev = bdev;
+
+	/* Once the superblock is inserted into the list by sget_fc(), s_umount
+	 * will protect the lockfs code from trying to start a snapshot while
+	 * we are mounting
+	 */
+	mutex_lock(&bdev->bd_fsfreeze_mutex);
+	if (bdev->bd_fsfreeze_count > 0) {
+		mutex_unlock(&bdev->bd_fsfreeze_mutex);
+		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
+		return -EBUSY;
+	}
+
+	fc->sb_flags |= SB_NOSEC;
+	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
+	mutex_unlock(&bdev->bd_fsfreeze_mutex);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	if (s->s_root) {
+		/* Don't summarily change the RO/RW state. */
+		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY) {
+			warnf(fc, "%pg: Can't mount, would change RO state", bdev);
+			error = -EBUSY;
+			goto error_sb;
+		}
+
+		/* Leave fc->bdev to fc_bdev_destructor() to clean up to avoid
+		 * locking conflicts.
+		 */
+	} else {
+		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		sb_set_blocksize(s, block_size(bdev));
+		error = fill_super(s, fc);
+		if (error)
+			goto error_sb;
+
+		s->s_flags |= SB_ACTIVE;
+		bdev->bd_super = s;
+	}
+
+	BUG_ON(fc->root);
+	fc->root = dget(s->s_root);
+	return 0;
+
+error_sb:
+	deactivate_locked_super(s);
+	/* Leave fc->bdev to fc_bdev_destructor() to clean up */
+	return error;
+}
+EXPORT_SYMBOL(vfs_get_block_super);
+
+
 static int set_bdev_super(struct super_block *s, void *data)
 {
 	s->s_bdev = data;
@@ -1411,8 +1515,13 @@ int vfs_get_tree(struct fs_context *fc)
 	 * on the superblock.
 	 */
 	error = fc->ops->get_tree(fc);
-	if (error < 0)
+	if (error < 0) {
+		if (fc->dev_destructor) {
+			fc->dev_destructor(fc);
+			fc->dev_destructor = NULL;
+		}
 		return error;
+	}
 
 	if (!fc->root) {
 		pr_err("Filesystem %s get_tree() didn't set fc->root\n",
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 7c6fe3d47fa6..ed5b4349671e 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -88,6 +88,9 @@ struct fs_context {
 	struct mutex		uapi_mutex;	/* Userspace access mutex */
 	struct file_system_type	*fs_type;
 	void			*fs_private;	/* The filesystem's context */
+	union {
+		struct block_device *bdev;	/* The backing blockdev (if applicable) */
+	};
 	struct dentry		*root;		/* The root and superblock */
 	struct user_namespace	*user_ns;	/* The user namespace for this mount */
 	struct net		*net_ns;	/* The network namespace for this mount */
@@ -97,6 +100,7 @@ struct fs_context {
 	const char		*subtype;	/* The subtype to set on the superblock */
 	void			*security;	/* Linux S&M options */
 	void			*s_fs_info;	/* Proposed s_fs_info */
+	fmode_t			bdev_mode;	/* File open mode for bdev */
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
 	unsigned int		s_iflags;	/* OR'd with sb->s_iflags */
@@ -105,6 +109,7 @@ struct fs_context {
 	enum fs_context_phase	phase:8;	/* The phase the context is in */
 	bool			need_free:1;	/* Need to call ops->free() */
 	bool			global:1;	/* Goes into &init_user_ns */
+	void (*dev_destructor)(struct fs_context *fc); /* For block or mtd */
 };
 
 struct fs_context_operations {
@@ -154,6 +159,10 @@ extern int get_tree_single(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
 
+extern int vfs_get_block_super(struct fs_context *fc,
+			       int (*fill_super)(struct super_block *sb,
+						 struct fs_context *fc));
+
 extern const struct file_operations fscontext_fops;
 
 /*
-- 
2.21.0

