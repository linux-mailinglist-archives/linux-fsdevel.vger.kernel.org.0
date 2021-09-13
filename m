Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8BB4083FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Sep 2021 07:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbhIMFsE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Sep 2021 01:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhIMFsE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:48:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F203AC061574;
        Sun, 12 Sep 2021 22:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nZvqPG4+2NdzXFSLEHoLxGtJGnDe20+xSZBBnwc+cmw=; b=lID8utpB1KlZAn5OqOci6HE/BW
        dzeAsiQJYQTUsvnKKjFlK97MHPKB6l2eJALElSxQo/S4+7IXPVpvvPEe691o5OEQYO/3H3N8l5Fla
        ESl9ivt+4Vpzm9CQgi3NIX2dZy5e6wAlJBMIXc8fOx6di3ynd2YPJtcy4TL7ee8RRmK/CruFp2pyk
        PjdFra5fQUngq+BOW+lxGXZwBH7YoRa/OFb7XyssI7EAFa3RleD91Ix8UhlFsYRiBPvx4kZgK4BZd
        MvdYYBgkxeq8JVYGM/nVgMrCa9r8Ce5w/TXwKFYEEPqWgrsdAgTfJM2iRaNObG0pwID3I1G02cMmP
        /G921jBg==;
Received: from 089144214237.atnat0023.highway.a1.net ([89.144.214.237] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mPemN-00DCeb-FI; Mon, 13 Sep 2021 05:45:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] sysfs: split out binary attribute handling from sysfs_add_file_mode_ns
Date:   Mon, 13 Sep 2021 07:41:12 +0200
Message-Id: <20210913054121.616001-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210913054121.616001-1-hch@lst.de>
References: <20210913054121.616001-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split adding binary attributes into a separate handler instead of
overloading sysfs_add_file_mode_ns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/sysfs/file.c  | 120 ++++++++++++++++++++++++++---------------------
 fs/sysfs/group.c |  15 +++---
 fs/sysfs/sysfs.h |   8 ++--
 3 files changed, 78 insertions(+), 65 deletions(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d019d6ac6ad09..f737bd61f71bf 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -255,59 +255,73 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap = {
 };
 
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
-			   const struct attribute *attr, bool is_bin,
-			   umode_t mode, kuid_t uid, kgid_t gid, const void *ns)
+		const struct attribute *attr, umode_t mode, kuid_t uid,
+		kgid_t gid, const void *ns)
 {
+	struct kobject *kobj = parent->priv;
+	const struct sysfs_ops *sysfs_ops = kobj->ktype->sysfs_ops;
 	struct lock_class_key *key = NULL;
 	const struct kernfs_ops *ops;
 	struct kernfs_node *kn;
-	loff_t size;
-
-	if (!is_bin) {
-		struct kobject *kobj = parent->priv;
-		const struct sysfs_ops *sysfs_ops = kobj->ktype->sysfs_ops;
-
-		/* every kobject with an attribute needs a ktype assigned */
-		if (WARN(!sysfs_ops, KERN_ERR
-			 "missing sysfs attribute operations for kobject: %s\n",
-			 kobject_name(kobj)))
-			return -EINVAL;
-
-		if (sysfs_ops->show && sysfs_ops->store) {
-			if (mode & SYSFS_PREALLOC)
-				ops = &sysfs_prealloc_kfops_rw;
-			else
-				ops = &sysfs_file_kfops_rw;
-		} else if (sysfs_ops->show) {
-			if (mode & SYSFS_PREALLOC)
-				ops = &sysfs_prealloc_kfops_ro;
-			else
-				ops = &sysfs_file_kfops_ro;
-		} else if (sysfs_ops->store) {
-			if (mode & SYSFS_PREALLOC)
-				ops = &sysfs_prealloc_kfops_wo;
-			else
-				ops = &sysfs_file_kfops_wo;
-		} else
-			ops = &sysfs_file_kfops_empty;
-
-		size = PAGE_SIZE;
-	} else {
-		struct bin_attribute *battr = (void *)attr;
-
-		if (battr->mmap)
-			ops = &sysfs_bin_kfops_mmap;
-		else if (battr->read && battr->write)
-			ops = &sysfs_bin_kfops_rw;
-		else if (battr->read)
-			ops = &sysfs_bin_kfops_ro;
-		else if (battr->write)
-			ops = &sysfs_bin_kfops_wo;
+
+	/* every kobject with an attribute needs a ktype assigned */
+	if (WARN(!sysfs_ops, KERN_ERR
+			"missing sysfs attribute operations for kobject: %s\n",
+			kobject_name(kobj)))
+		return -EINVAL;
+
+	if (sysfs_ops->show && sysfs_ops->store) {
+		if (mode & SYSFS_PREALLOC)
+			ops = &sysfs_prealloc_kfops_rw;
 		else
-			ops = &sysfs_file_kfops_empty;
+			ops = &sysfs_file_kfops_rw;
+	} else if (sysfs_ops->show) {
+		if (mode & SYSFS_PREALLOC)
+			ops = &sysfs_prealloc_kfops_ro;
+		else
+			ops = &sysfs_file_kfops_ro;
+	} else if (sysfs_ops->store) {
+		if (mode & SYSFS_PREALLOC)
+			ops = &sysfs_prealloc_kfops_wo;
+		else
+			ops = &sysfs_file_kfops_wo;
+	} else
+		ops = &sysfs_file_kfops_empty;
 
-		size = battr->size;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	if (!attr->ignore_lockdep)
+		key = attr->key ?: (struct lock_class_key *)&attr->skey;
+#endif
+
+	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
+				  PAGE_SIZE, ops, (void *)attr, ns, key);
+	if (IS_ERR(kn)) {
+		if (PTR_ERR(kn) == -EEXIST)
+			sysfs_warn_dup(parent, attr->name);
+		return PTR_ERR(kn);
 	}
+	return 0;
+}
+
+int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
+		const struct bin_attribute *battr, umode_t mode,
+		kuid_t uid, kgid_t gid, const void *ns)
+{
+	const struct attribute *attr = &battr->attr;
+	struct lock_class_key *key = NULL;
+	const struct kernfs_ops *ops;
+	struct kernfs_node *kn;
+
+	if (battr->mmap)
+		ops = &sysfs_bin_kfops_mmap;
+	else if (battr->read && battr->write)
+		ops = &sysfs_bin_kfops_rw;
+	else if (battr->read)
+		ops = &sysfs_bin_kfops_ro;
+	else if (battr->write)
+		ops = &sysfs_bin_kfops_wo;
+	else
+		ops = &sysfs_file_kfops_empty;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	if (!attr->ignore_lockdep)
@@ -315,7 +329,7 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 #endif
 
 	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  size, ops, (void *)attr, ns, key);
+				  battr->size, ops, (void *)attr, ns, key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
@@ -340,9 +354,7 @@ int sysfs_create_file_ns(struct kobject *kobj, const struct attribute *attr,
 		return -EINVAL;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	return sysfs_add_file_mode_ns(kobj->sd, attr, false, attr->mode,
-				      uid, gid, ns);
-
+	return sysfs_add_file_mode_ns(kobj->sd, attr, attr->mode, uid, gid, ns);
 }
 EXPORT_SYMBOL_GPL(sysfs_create_file_ns);
 
@@ -385,8 +397,8 @@ int sysfs_add_file_to_group(struct kobject *kobj,
 		return -ENOENT;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	error = sysfs_add_file_mode_ns(parent, attr, false,
-				       attr->mode, uid, gid, NULL);
+	error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, gid,
+				       NULL);
 	kernfs_put(parent);
 
 	return error;
@@ -555,8 +567,8 @@ int sysfs_create_bin_file(struct kobject *kobj,
 		return -EINVAL;
 
 	kobject_get_ownership(kobj, &uid, &gid);
-	return sysfs_add_file_mode_ns(kobj->sd, &attr->attr, true,
-				      attr->attr.mode, uid, gid, NULL);
+	return sysfs_add_bin_file_mode_ns(kobj->sd, attr, attr->attr.mode, uid,
+					   gid, NULL);
 }
 EXPORT_SYMBOL_GPL(sysfs_create_bin_file);
 
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index f29d620045272..eeb0e30994215 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -61,8 +61,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			     (*attr)->name, mode);
 
 			mode &= SYSFS_PREALLOC | 0664;
-			error = sysfs_add_file_mode_ns(parent, *attr, false,
-						       mode, uid, gid, NULL);
+			error = sysfs_add_file_mode_ns(parent, *attr, mode, uid,
+						       gid, NULL);
 			if (unlikely(error))
 				break;
 		}
@@ -90,10 +90,9 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
 			     (*bin_attr)->attr.name, mode);
 
 			mode &= SYSFS_PREALLOC | 0664;
-			error = sysfs_add_file_mode_ns(parent,
-					&(*bin_attr)->attr, true,
-					mode,
-					uid, gid, NULL);
+			error = sysfs_add_bin_file_mode_ns(parent, *bin_attr,
+							   mode, uid, gid,
+							   NULL);
 			if (error)
 				break;
 		}
@@ -340,8 +339,8 @@ int sysfs_merge_group(struct kobject *kobj,
 	kobject_get_ownership(kobj, &uid, &gid);
 
 	for ((i = 0, attr = grp->attrs); *attr && !error; (++i, ++attr))
-		error = sysfs_add_file_mode_ns(parent, *attr, false,
-					       (*attr)->mode, uid, gid, NULL);
+		error = sysfs_add_file_mode_ns(parent, *attr, (*attr)->mode,
+					       uid, gid, NULL);
 	if (error) {
 		while (--i >= 0)
 			kernfs_remove_by_name(parent, (*--attr)->name);
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 0050cc0c0236d..3f28c9af57562 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -28,9 +28,11 @@ void sysfs_warn_dup(struct kernfs_node *parent, const char *name);
  * file.c
  */
 int sysfs_add_file_mode_ns(struct kernfs_node *parent,
-			   const struct attribute *attr, bool is_bin,
-			   umode_t amode, kuid_t uid, kgid_t gid,
-			   const void *ns);
+		const struct attribute *attr, umode_t amode, kuid_t uid,
+		kgid_t gid, const void *ns);
+int sysfs_add_bin_file_mode_ns(struct kernfs_node *parent,
+		const struct bin_attribute *battr, umode_t mode,
+		kuid_t uid, kgid_t gid, const void *ns);
 
 /*
  * symlink.c
-- 
2.30.2

