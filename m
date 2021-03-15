Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B922033C53E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 19:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhCOSHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 14:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231444AbhCOSHV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:07:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 484BA64F2B;
        Mon, 15 Mar 2021 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615831640;
        bh=ExJkSDJZzOihB9xhPHG0ijWVccQ2cA9//wNyKOoa05w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jivERlwLriflGwUsD07KAhUqmc2S0A94JzIQ2zgpDff921o4h9SesZiyJpUVi5SIS
         5iKlLw5PvTkTHlvgxB3glc15m3PH5EXGCOxNXX8HaA2Z4eXtJro6xmkKUL2T+cEZah
         WGzVJMcs1CFXBiD6AuBmrehopRqPc0YIubWjZawS8nkuhC4d+C9+vbtUib9Wtd0CGl
         y/kCDYtLnA9HHj683DMDBVrhayLiw6vLsydgcXFBPv5Aiz4ubaCpOO6NN/Mdh4C47u
         K6meKM9+2EVJAruPWeXeX8dM0/kj90McvB0f/L9aIBAXaK5iFjwSTQNVPE/6goD757
         WjaF1zuk8WJRA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: [PATCH 2/2] ceph: don't use d_add in ceph_handle_snapdir
Date:   Mon, 15 Mar 2021 14:07:17 -0400
Message-Id: <20210315180717.266155-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315180717.266155-1-jlayton@kernel.org>
References: <20210315180717.266155-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's possible ceph_get_snapdir could end up finding a (disconnected)
inode that already exists in the cache. Change the prototype for
ceph_handle_snapdir to return a dentry pointer and have it use
d_splice_alias so we don't end up with an aliased dentry in the cache.

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c   | 30 ++++++++++++++++++------------
 fs/ceph/file.c  |  6 ++++--
 fs/ceph/super.h |  2 +-
 3 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 113f669d71dd..4b871b7017a0 100644
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
@@ -793,7 +795,11 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 	req->r_parent = dir;
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
-	err = ceph_handle_snapdir(req, dentry, err);
+	res = ceph_handle_snapdir(req, dentry, err);
+	if (IS_ERR(res))
+		err = PTR_ERR(res);
+	else
+		dentry = res;
 	dentry = ceph_finish_lookup(req, dentry, err);
 	ceph_mdsc_put_request(req);  /* will dput(dentry) */
 	dout("lookup result=%p\n", dentry);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 209535d5b8d3..847beb9f43dd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -739,9 +739,11 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
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

