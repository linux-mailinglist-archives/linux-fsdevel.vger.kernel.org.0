Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D9952967B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 03:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242949AbiEQBDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbiEQBDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 21:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F7AC47058
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652749410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qAw6FeFu6JnmGI8VDE4qqZD9GTKSB0yymuhWL2qbE2g=;
        b=MfidRdefInnd0wgDF9NqsJWbTHf7nNpRpR/v9SRpYT5WO1d6XQjnnznUatLYg62/ILNfzT
        RxRH2etVvbo4Qm/R5DDwiyQSVfM3s/yv+23qvqRheUFHcBCeWUUM0QdHeAwHR6NJESetfG
        87JvgAike9WDnVqi49HqA+R5nQoaF3U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-PbXdNgC5NceorKCmFsORUA-1; Mon, 16 May 2022 21:03:27 -0400
X-MC-Unique: PbXdNgC5NceorKCmFsORUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 141E51E02E26;
        Tue, 17 May 2022 01:03:27 +0000 (UTC)
Received: from localhost (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C22340CF8EA;
        Tue, 17 May 2022 01:03:25 +0000 (UTC)
From:   Xiubo Li <xiubli@redhat.com>
To:     jlayton@kernel.org, viro@zeniv.linux.org.uk
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de, mcgrof@kernel.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] ceph: wait the first reply of inflight unlink/rmdir
Date:   Tue, 17 May 2022 09:03:16 +0800
Message-Id: <20220517010316.81483-3-xiubli@redhat.com>
In-Reply-To: <20220517010316.81483-1-xiubli@redhat.com>
References: <20220517010316.81483-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In async unlink case the kclient won't wait for the first reply
from MDS and just drop all the links and unhash the dentry and then
succeeds immediately.

For any new create/link/rename,etc requests followed by using the
same file names we must wait for the first reply of the inflight
unlink request, or the MDS possibly will fail these following
requests with -EEXIST if the inflight async unlink request was
delayed for some reasons.

And the worst case is that for the none async openc request it will
successfully open the file if the CDentry hasn't been unlinked yet,
but later the previous delayed async unlink request will remove the
CDenty. That means the just created file is possiblly deleted later
by accident.

We need to wait for the inflight async unlink requests to finish
when creating new files/directories by using the same file names.

URL: https://tracker.ceph.com/issues/55332
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/dir.c        | 70 +++++++++++++++++++++++++++++++++++++++----
 fs/ceph/file.c       |  5 ++++
 fs/ceph/mds_client.c | 71 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.c      |  3 ++
 fs/ceph/super.h      | 19 ++++++++----
 6 files changed, 159 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index eae417d71136..88e0048d719e 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -856,6 +856,10 @@ static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	err = ceph_wait_on_conflict_unlink(dentry);
+	if (err)
+		return err;
+
 	if (ceph_quota_is_max_files_exceeded(dir)) {
 		err = -EDQUOT;
 		goto out;
@@ -918,6 +922,10 @@ static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
+	err = ceph_wait_on_conflict_unlink(dentry);
+	if (err)
+		return err;
+
 	if (ceph_quota_is_max_files_exceeded(dir)) {
 		err = -EDQUOT;
 		goto out;
@@ -968,9 +976,13 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
-	int err = -EROFS;
+	int err;
 	int op;
 
+	err = ceph_wait_on_conflict_unlink(dentry);
+	if (err)
+		return err;
+
 	if (ceph_snap(dir) == CEPH_SNAPDIR) {
 		/* mkdir .snap/foo is a MKSNAP */
 		op = CEPH_MDS_OP_MKSNAP;
@@ -980,6 +992,7 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 		dout("mkdir dir %p dn %p mode 0%ho\n", dir, dentry, mode);
 		op = CEPH_MDS_OP_MKDIR;
 	} else {
+		err = -EROFS;
 		goto out;
 	}
 
@@ -1037,6 +1050,10 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 	struct ceph_mds_request *req;
 	int err;
 
+	err = ceph_wait_on_conflict_unlink(dentry);
+	if (err)
+		return err;
+
 	if (ceph_snap(dir) != CEPH_NOSNAP)
 		return -EROFS;
 
@@ -1071,9 +1088,27 @@ static int ceph_link(struct dentry *old_dentry, struct inode *dir,
 static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 				 struct ceph_mds_request *req)
 {
+	struct dentry *dentry = req->r_dentry;
+	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int result = req->r_err ? req->r_err :
 			le32_to_cpu(req->r_reply_info.head->result);
 
+	if (test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags)) {
+		BUG_ON(req->r_op != CEPH_MDS_OP_UNLINK);
+
+		spin_lock(&fsc->async_unlink_conflict_lock);
+		hash_del_rcu(&di->hnode);
+		spin_unlock(&fsc->async_unlink_conflict_lock);
+
+		spin_lock(&dentry->d_lock);
+		di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
+		wake_up_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT);
+		spin_unlock(&dentry->d_lock);
+
+		synchronize_rcu();
+	}
+
 	if (result == -EJUKEBOX)
 		goto out;
 
@@ -1081,7 +1116,7 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 	if (result) {
 		int pathlen = 0;
 		u64 base = 0;
-		char *path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
+		char *path = ceph_mdsc_build_path(dentry, &pathlen,
 						  &base, 0);
 
 		/* mark error on parent + clear complete */
@@ -1089,13 +1124,13 @@ static void ceph_async_unlink_cb(struct ceph_mds_client *mdsc,
 		ceph_dir_clear_complete(req->r_parent);
 
 		/* drop the dentry -- we don't know its status */
-		if (!d_unhashed(req->r_dentry))
-			d_drop(req->r_dentry);
+		if (!d_unhashed(dentry))
+			d_drop(dentry);
 
 		/* mark inode itself for an error (since metadata is bogus) */
 		mapping_set_error(req->r_old_inode->i_mapping, result);
 
-		pr_warn("ceph: async unlink failure path=(%llx)%s result=%d!\n",
+		pr_warn("async unlink failure path=(%llx)%s result=%d!\n",
 			base, IS_ERR(path) ? "<<bad>>" : path, result);
 		ceph_mdsc_free_path(path, pathlen);
 	}
@@ -1180,6 +1215,8 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 
 	if (try_async && op == CEPH_MDS_OP_UNLINK &&
 	    (req->r_dir_caps = get_caps_for_async_unlink(dir, dentry))) {
+		struct ceph_dentry_info *di = ceph_dentry(dentry);
+
 		dout("async unlink on %llu/%.*s caps=%s", ceph_ino(dir),
 		     dentry->d_name.len, dentry->d_name.name,
 		     ceph_cap_string(req->r_dir_caps));
@@ -1187,6 +1224,16 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 		req->r_callback = ceph_async_unlink_cb;
 		req->r_old_inode = d_inode(dentry);
 		ihold(req->r_old_inode);
+
+		spin_lock(&dentry->d_lock);
+		di->flags |= CEPH_DENTRY_ASYNC_UNLINK;
+		spin_unlock(&dentry->d_lock);
+
+		spin_lock(&fsc->async_unlink_conflict_lock);
+		hash_add_rcu(fsc->async_unlink_conflict, &di->hnode,
+			     dentry->d_name.hash);
+		spin_unlock(&fsc->async_unlink_conflict_lock);
+
 		err = ceph_mdsc_submit_request(mdsc, dir, req);
 		if (!err) {
 			/*
@@ -1198,6 +1245,15 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 		} else if (err == -EJUKEBOX) {
 			try_async = false;
 			ceph_mdsc_put_request(req);
+
+			spin_lock(&dentry->d_lock);
+			di->flags &= ~CEPH_DENTRY_ASYNC_UNLINK;
+			spin_unlock(&dentry->d_lock);
+
+			spin_lock(&fsc->async_unlink_conflict_lock);
+			hash_del_rcu(&di->hnode);
+			spin_unlock(&fsc->async_unlink_conflict_lock);
+
 			goto retry;
 		}
 	} else {
@@ -1237,6 +1293,10 @@ static int ceph_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	    (!ceph_quota_is_same_realm(old_dir, new_dir)))
 		return -EXDEV;
 
+	err = ceph_wait_on_conflict_unlink(new_dentry);
+	if (err)
+		return err;
+
 	dout("rename dir %p dentry %p to dir %p dentry %p\n",
 	     old_dir, old_dentry, new_dir, new_dentry);
 	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 8c8226c0feac..47d068e6436a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -740,6 +740,10 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
+	err = ceph_wait_on_conflict_unlink(dentry);
+	if (err)
+		return err;
+
 	if (flags & O_CREAT) {
 		if (ceph_quota_is_max_files_exceeded(dir))
 			return -EDQUOT;
@@ -757,6 +761,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		/* If it's not being looked up, it's negative */
 		return -ENOENT;
 	}
+
 retry:
 	/* do the open */
 	req = prepare_open_request(dir->i_sb, flags, mode);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index e8c87dea0551..bb67f3d5a337 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -655,6 +655,77 @@ static void destroy_reply_info(struct ceph_mds_reply_info_parsed *info)
 	free_pages((unsigned long)info->dir_entries, get_order(info->dir_buf_size));
 }
 
+/*
+ * In async unlink case the kclient won't wait for the first reply
+ * from MDS and just drop all the links and unhash the dentry and then
+ * succeeds immediately.
+ *
+ * For any new create/link/rename,etc requests followed by using the
+ * same file names we must wait for the first reply of the inflight
+ * unlink request, or the MDS possibly will fail these following
+ * requests with -EEXIST if the inflight async unlink request was
+ * delayed for some reasons.
+ *
+ * And the worst case is that for the none async openc request it will
+ * successfully open the file if the CDentry hasn't been unlinked yet,
+ * but later the previous delayed async unlink request will remove the
+ * CDenty. That means the just created file is possiblly deleted later
+ * by accident.
+ *
+ * We need to wait for the inflight async unlink requests to finish
+ * when creating new files/directories by using the same file names.
+ */
+int ceph_wait_on_conflict_unlink(struct dentry *dentry)
+{
+	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct dentry *pdentry = dentry->d_parent;
+	struct dentry *udentry, *found = NULL;
+	struct ceph_dentry_info *di;
+	struct qstr dname;
+	u32 hash = dentry->d_name.hash;
+	int err;
+
+	dname.name = dentry->d_name.name;
+	dname.len = dentry->d_name.len;
+
+	rcu_read_lock();
+	hash_for_each_possible_rcu(fsc->async_unlink_conflict, di,
+				   hnode, hash) {
+		udentry = di->dentry;
+
+		spin_lock(&udentry->d_lock);
+		if (udentry->d_name.hash != hash)
+			goto next;
+		if (unlikely(udentry->d_parent != pdentry))
+			goto next;
+		if (!hash_hashed(&di->hnode))
+			goto next;
+
+		WARN_ON_ONCE(!test_bit(CEPH_DENTRY_ASYNC_UNLINK_BIT, &di->flags));
+
+		if (d_compare(pdentry, udentry, &dname))
+			goto next;
+
+		spin_unlock(&udentry->d_lock);
+		found = dget(udentry);
+		break;
+next:
+		spin_unlock(&udentry->d_lock);
+	}
+	rcu_read_unlock();
+
+	if (likely(!found))
+		return 0;
+
+	dout("%s dentry %p:%pd conflict with old %p:%pd\n", __func__,
+	     dentry, dentry, found, found);
+
+	err = wait_on_bit(&di->flags, CEPH_DENTRY_ASYNC_UNLINK_BIT,
+			  TASK_INTERRUPTIBLE);
+	dput(found);
+	return err;
+}
+
 
 /*
  * sessions
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 33497846e47e..d1ae679c52c3 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -582,6 +582,7 @@ static inline int ceph_wait_on_async_create(struct inode *inode)
 			   TASK_INTERRUPTIBLE);
 }
 
+extern int ceph_wait_on_conflict_unlink(struct dentry *dentry);
 extern u64 ceph_get_deleg_ino(struct ceph_mds_session *session);
 extern int ceph_restore_deleg_ino(struct ceph_mds_session *session, u64 ino);
 #endif
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index b73b4f75462c..6542b71f8627 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -816,6 +816,9 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	if (!fsc->cap_wq)
 		goto fail_inode_wq;
 
+	hash_init(fsc->async_unlink_conflict);
+	spin_lock_init(&fsc->async_unlink_conflict_lock);
+
 	spin_lock(&ceph_fsc_lock);
 	list_add_tail(&fsc->metric_wakeup, &ceph_fsc_list);
 	spin_unlock(&ceph_fsc_lock);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 506d52633627..c10adb7c1cde 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -19,6 +19,7 @@
 #include <linux/security.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
+#include <linux/hashtable.h>
 
 #include <linux/ceph/libceph.h>
 
@@ -99,6 +100,8 @@ struct ceph_mount_options {
 	char *mon_addr;
 };
 
+#define CEPH_ASYNC_CREATE_CONFLICT_BITS 12
+
 struct ceph_fs_client {
 	struct super_block *sb;
 
@@ -124,6 +127,9 @@ struct ceph_fs_client {
 	struct workqueue_struct *inode_wq;
 	struct workqueue_struct *cap_wq;
 
+	DECLARE_HASHTABLE(async_unlink_conflict, CEPH_ASYNC_CREATE_CONFLICT_BITS);
+	spinlock_t async_unlink_conflict_lock;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dentry_lru, *debugfs_caps;
 	struct dentry *debugfs_congestion_kb;
@@ -281,7 +287,8 @@ struct ceph_dentry_info {
 	struct dentry *dentry;
 	struct ceph_mds_session *lease_session;
 	struct list_head lease_list;
-	unsigned flags;
+	struct hlist_node hnode;
+	unsigned long flags;
 	int lease_shared_gen;
 	u32 lease_gen;
 	u32 lease_seq;
@@ -290,10 +297,12 @@ struct ceph_dentry_info {
 	u64 offset;
 };
 
-#define CEPH_DENTRY_REFERENCED		1
-#define CEPH_DENTRY_LEASE_LIST		2
-#define CEPH_DENTRY_SHRINK_LIST		4
-#define CEPH_DENTRY_PRIMARY_LINK	8
+#define CEPH_DENTRY_REFERENCED		(1 << 0)
+#define CEPH_DENTRY_LEASE_LIST		(1 << 1)
+#define CEPH_DENTRY_SHRINK_LIST		(1 << 2)
+#define CEPH_DENTRY_PRIMARY_LINK	(1 << 3)
+#define CEPH_DENTRY_ASYNC_UNLINK_BIT	(4)
+#define CEPH_DENTRY_ASYNC_UNLINK	(1 << CEPH_DENTRY_ASYNC_UNLINK_BIT)
 
 struct ceph_inode_xattrs_info {
 	/*
-- 
2.36.0.rc1

