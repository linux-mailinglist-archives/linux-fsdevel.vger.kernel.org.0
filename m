Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699D933DF02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 21:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhCPUj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 16:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231573AbhCPUjW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:39:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E241164F80;
        Tue, 16 Mar 2021 20:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615927162;
        bh=HIIsnBAdpgzdRnHSnmLypxuABBOe8Oz+vrIslsi72Sg=;
        h=From:To:Cc:Subject:Date:From;
        b=WXNL5GVI5sQZ6xiZvd4Kp0znZ4knNMtvneJMnhtUlD7/g9rwmmOrq8GLe2qqtx7WW
         ZrlmWl3k3S+EKXr38uo3eJvaf4qyCnqYjGX15P7tvEY19cu9xKFKTYG9isNDVgSbZg
         J9kMVEhG6nyUY+NUNy1ndPyH4p9nfrP4poZ/fehbzLn72RdUrVYPZlEeaibfgtEn+N
         GMeUceY8QBBFeLIj2fu1MP+AxZh1XkDzfgAh/12FkSVLweBypsb57vgpX7W9wcGq4i
         lpTp6eV0AXQeGFelckKs7fvKHqXQq62f9MNQ5QuPcCmbHSwt2RiQf4Fq8WASJm3Q7B
         UCEWKQVOEGDlg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        pdonnell@redhat.com
Subject: [PATCH v2] ceph: don't use d_add in ceph_handle_snapdir
Date:   Tue, 16 Mar 2021 16:39:19 -0400
Message-Id: <20210316203919.102346-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's possible ceph_get_snapdir could end up finding a (disconnected)
inode that already exists in the cache. Change the prototype for
ceph_handle_snapdir to return a dentry pointer and have it use
d_splice_alias so we don't end up with an aliased dentry in the cache.

URL: https://tracker.ceph.com/issues/49843
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   | 32 ++++++++++++++++++++------------
 fs/ceph/file.c  |  7 +++++--
 fs/ceph/super.h |  2 +-
 3 files changed, 26 insertions(+), 15 deletions(-)

v2:
    zero out err var when ceph_handle_snapdir returns success

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 113f669d71dd..570662dec3fe 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -667,8 +667,8 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 /*
  * Handle lookups for the hidden .snap directory.
  */
-int ceph_handle_snapdir(struct ceph_mds_request *req,
-			struct dentry *dentry, int err)
+struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
+				   struct dentry *dentry, int err)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
 	struct inode *parent = d_inode(dentry->d_parent); /* we hold i_mutex */
@@ -676,18 +676,19 @@ int ceph_handle_snapdir(struct ceph_mds_request *req,
 	/* .snap dir? */
 	if (err == -ENOENT &&
 	    ceph_snap(parent) == CEPH_NOSNAP &&
-	    strcmp(dentry->d_name.name,
-		   fsc->mount_options->snapdir_name) == 0) {
+	    strcmp(dentry->d_name.name, fsc->mount_options->snapdir_name) == 0) {
+		struct dentry *res;
 		struct inode *inode = ceph_get_snapdir(parent);
+
 		if (IS_ERR(inode))
-			return PTR_ERR(inode);
-		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p\n",
-		     dentry, dentry, inode);
-		BUG_ON(!d_unhashed(dentry));
-		d_add(dentry, inode);
-		err = 0;
+			return ERR_CAST(inode);
+		res = d_splice_alias(inode, dentry);
+		dout("ENOENT on snapdir %p '%pd', linking to snapdir %p. Spliced dentry %p\n",
+		     dentry, dentry, inode, res);
+		if (res)
+			dentry = res;
 	}
-	return err;
+	return dentry;
 }
 
 /*
@@ -743,6 +744,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
+	struct dentry *res;
 	int op;
 	int mask;
 	int err;
@@ -793,7 +795,13 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	req->r_parent = dir;
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
-	err = ceph_handle_snapdir(req, dentry, err);
+	res = ceph_handle_snapdir(req, dentry, err);
+	if (IS_ERR(res)) {
+		err = PTR_ERR(res);
+	} else {
+		dentry = res;
+		err = 0;
+	}
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
 	dout("lookup result=%p\n", dentry);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 209535d5b8d3..a6ef1d143308 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -739,9 +739,12 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	err = ceph_mdsc_do_request(mdsc,
 				   (flags & (O_CREAT|O_TRUNC)) ? dir : NULL,
 				   req);
-	err = ceph_handle_snapdir(req, dentry, err);
-	if (err)
+	dentry = ceph_handle_snapdir(req, dentry, err);
+	if (IS_ERR(dentry)) {
+		err = PTR_ERR(dentry);
 		goto out_req;
+	}
+	err = 0;
 
 	if ((flags & O_CREAT) && !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 188565d806b2..07a3fb52ae30 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1193,7 +1193,7 @@ extern const struct dentry_operations ceph_dentry_ops;
 
 extern loff_t ceph_make_fpos(unsigned high, unsigned off, bool hash_order);
 extern int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry);
-extern int ceph_handle_snapdir(struct ceph_mds_request *req,
+extern struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 			       struct dentry *dentry, int err);
 extern struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 					 struct dentry *dentry, int err);
-- 
2.30.2

