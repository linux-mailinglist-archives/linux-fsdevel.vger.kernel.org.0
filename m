Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF49B1392
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387625AbfILR2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:28:55 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:50455 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbfILR2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309333; x=1599845333;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=X6pjsZ1DUM9WQsJBlFU42duzqbYXDrhxtlqUbntlemU=;
  b=qOIhTcpVlsCW2W7B5AgKUr1apD5xuRnQ6hsQil/CUKuICIl4Hlg9pYiC
   g61B2axlQ1tVRKzc+wjhMXnZgrMFfDqomeozf/VYFufnTjakVHPx6g0s9
   7JcYt4uB5hRTPoL9TZyODwZ9zQk6atsf/4h2Hzp6ZTNXzVeLWUb5om0ff
   4=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="420869456"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id DB77DA17EE;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D29UWC002.ant.amazon.com (10.43.162.254) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D29UWC002.ant.amazon.com (10.43.162.254) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E21C5C052C; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <792e90e6afd5fb2104ce9ed56c5e6c6f26eee6cc.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Tue, 27 Aug 2019 22:51:41 +0000
Subject: [RFC PATCH 13/35] nfs: modify update_changeattr to deal with regular
 files
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Until now, change attributes in change_info form were only returned by
directory operations. However, they are also used for the RFC 8276
extended attribute operations, which work on both directories
and regular files.  Modify update_changeattr to deal:

* Rename it to nfs4_update_changeattr and make it non-static.
* Don't always use INO_INVALID_DATA, this isn't needed for a
  directory that only had its extended attributes changed by us.
* Existing callers now always pass in INO_INVALID_DATA.

For the current callers of this function, behavior is unchanged.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/nfs4_fs.h  |  5 ++++
 fs/nfs/nfs4proc.c | 70 +++++++++++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 3564da1ba8a1..f684dcdc38bd 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -314,6 +314,11 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 
 extern int nfs4_proc_get_lease_time(struct nfs_client *clp,
 		struct nfs_fsinfo *fsinfo);
+extern void nfs4_update_changeattr(struct inode *dir,
+				   struct nfs4_change_info *cinfo,
+				   unsigned long timestamp,
+				   unsigned long cache_validity);
+
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
 extern int nfs4_proc_create_session(struct nfs_client *, const struct cred *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 029b07fef37f..a8a6ddb34ad7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1130,37 +1130,48 @@ nfs4_dec_nlink_locked(struct inode *inode)
 }
 
 static void
-update_changeattr_locked(struct inode *dir, struct nfs4_change_info *cinfo,
+nfs4_update_changeattr_locked(struct inode *inode,
+		struct nfs4_change_info *cinfo,
 		unsigned long timestamp, unsigned long cache_validity)
 {
-	struct nfs_inode *nfsi = NFS_I(dir);
+	struct nfs_inode *nfsi = NFS_I(inode);
 
 	nfsi->cache_validity |= NFS_INO_INVALID_CTIME
 		| NFS_INO_INVALID_MTIME
-		| NFS_INO_INVALID_DATA
 		| cache_validity;
-	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(dir)) {
+
+	if (cinfo->atomic && cinfo->before == inode_peek_iversion_raw(inode)) {
 		nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo_timestamp = jiffies;
 	} else {
-		nfs_force_lookup_revalidate(dir);
-		if (cinfo->before != inode_peek_iversion_raw(dir))
+		if (S_ISDIR(inode->i_mode)) {
+			nfsi->cache_validity |= NFS_INO_INVALID_DATA;
+			nfs_force_lookup_revalidate(inode);
+		} else {
+			if (!NFS_PROTO(inode)->have_delegation(inode,
+							       FMODE_READ))
+				nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE;
+		}
+
+		if (cinfo->before != inode_peek_iversion_raw(inode))
 			nfsi->cache_validity |= NFS_INO_INVALID_ACCESS |
-				NFS_INO_INVALID_ACL;
+						NFS_INO_INVALID_ACL;
 	}
-	inode_set_iversion_raw(dir, cinfo->after);
+	inode_set_iversion_raw(inode, cinfo->after);
 	nfsi->read_cache_jiffies = timestamp;
 	nfsi->attr_gencount = nfs_inc_attr_generation_counter();
 	nfsi->cache_validity &= ~NFS_INO_INVALID_CHANGE;
-	nfs_fscache_invalidate(dir);
+
+	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
+		nfs_fscache_invalidate(inode);
 }
 
-static void
-update_changeattr(struct inode *dir, struct nfs4_change_info *cinfo,
+void
+nfs4_update_changeattr(struct inode *dir, struct nfs4_change_info *cinfo,
 		unsigned long timestamp, unsigned long cache_validity)
 {
 	spin_lock(&dir->i_lock);
-	update_changeattr_locked(dir, cinfo, timestamp, cache_validity);
+	nfs4_update_changeattr_locked(dir, cinfo, timestamp, cache_validity);
 	spin_unlock(&dir->i_lock);
 }
 
@@ -2620,8 +2631,9 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
 			data->file_created = true;
 		if (data->file_created ||
 		    inode_peek_iversion_raw(dir) != o_res->cinfo.after)
-			update_changeattr(dir, &o_res->cinfo,
-					o_res->f_attr->time_start, 0);
+			nfs4_update_changeattr(dir, &o_res->cinfo,
+					o_res->f_attr->time_start,
+					NFS_INO_INVALID_DATA);
 	}
 	if ((o_res->rflags & NFS4_OPEN_RESULT_LOCKTYPE_POSIX) == 0)
 		server->caps &= ~NFS_CAP_POSIX_LOCK;
@@ -4440,7 +4452,8 @@ _nfs4_proc_remove(struct inode *dir, const struct qstr *name, u32 ftype)
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		update_changeattr_locked(dir, &res.cinfo, timestamp, 0);
+		nfs4_update_changeattr_locked(dir, &res.cinfo, timestamp,
+					      NFS_INO_INVALID_DATA);
 		/* Removing a directory decrements nlink in the parent */
 		if (ftype == NF4DIR && dir->i_nlink > 2)
 			nfs4_dec_nlink_locked(dir);
@@ -4524,8 +4537,9 @@ static int nfs4_proc_unlink_done(struct rpc_task *task, struct inode *dir)
 				    &data->timeout) == -EAGAIN)
 		return 0;
 	if (task->tk_status == 0)
-		update_changeattr(dir, &res->cinfo,
-				res->dir_attr->time_start, 0);
+		nfs4_update_changeattr(dir, &res->cinfo,
+				res->dir_attr->time_start,
+				NFS_INO_INVALID_DATA);
 	return 1;
 }
 
@@ -4569,16 +4583,18 @@ static int nfs4_proc_rename_done(struct rpc_task *task, struct inode *old_dir,
 	if (task->tk_status == 0) {
 		if (new_dir != old_dir) {
 			/* Note: If we moved a directory, nlink will change */
-			update_changeattr(old_dir, &res->old_cinfo,
+			nfs4_update_changeattr(old_dir, &res->old_cinfo,
 					res->old_fattr->time_start,
-					NFS_INO_INVALID_OTHER);
-			update_changeattr(new_dir, &res->new_cinfo,
+					NFS_INO_INVALID_OTHER |
+					    NFS_INO_INVALID_DATA);
+			nfs4_update_changeattr(new_dir, &res->new_cinfo,
 					res->new_fattr->time_start,
-					NFS_INO_INVALID_OTHER);
+					NFS_INO_INVALID_OTHER |
+					    NFS_INO_INVALID_DATA);
 		} else
-			update_changeattr(old_dir, &res->old_cinfo,
+			nfs4_update_changeattr(old_dir, &res->old_cinfo,
 					res->old_fattr->time_start,
-					0);
+					NFS_INO_INVALID_DATA);
 	}
 	return 1;
 }
@@ -4619,7 +4635,8 @@ static int _nfs4_proc_link(struct inode *inode, struct inode *dir, const struct
 
 	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
 	if (!status) {
-		update_changeattr(dir, &res.cinfo, res.fattr->time_start, 0);
+		nfs4_update_changeattr(dir, &res.cinfo, res.fattr->time_start,
+				       NFS_INO_INVALID_DATA);
 		status = nfs_post_op_update_inode(inode, res.fattr);
 		if (!status)
 			nfs_setsecurity(inode, res.fattr, res.label);
@@ -4697,8 +4714,9 @@ static int nfs4_do_create(struct inode *dir, struct dentry *dentry, struct nfs4_
 				    &data->arg.seq_args, &data->res.seq_res, 1);
 	if (status == 0) {
 		spin_lock(&dir->i_lock);
-		update_changeattr_locked(dir, &data->res.dir_cinfo,
-				data->res.fattr->time_start, 0);
+		nfs4_update_changeattr_locked(dir, &data->res.dir_cinfo,
+				data->res.fattr->time_start,
+				NFS_INO_INVALID_DATA);
 		/* Creating a directory bumps nlink in the parent */
 		if (data->arg.ftype == NF4DIR)
 			nfs4_inc_nlink_locked(dir);
-- 
2.17.2

