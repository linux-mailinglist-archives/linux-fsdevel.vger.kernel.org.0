Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234586FFC0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbjEKVnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 17:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbjEKVnn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 17:43:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92725FD8;
        Thu, 11 May 2023 14:43:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BKrUnP027656;
        Thu, 11 May 2023 21:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=dFsIgw3rTeOSF3vVMzLftK2VbEzWfz3DMmGHAmKgWio=;
 b=Rs6V6Uw9/P3iUGrapUQPSMsxqO0xSFbiIzJqzHRmi8Ii7NAtycV5zODeQBHgdzBoAglF
 +4nzC2vqEERVvB/NuiSJTEPEdwP8Qty4kF639QmIplyV/hUprPl5FCbQ80rAYM1rdHby
 lYweNouX9iTI09YDm/YW4g+KG5aD2QWO83vZPehP3x5EvLNoxCDDt33dzBE8rlnntSZI
 pPGjfBhcwvFoUPph2DyKIeDIdDsPzsqFHGO4/Vaj5WzkyxYbPdD5nsCruuFtR3PX4B4s
 4n36S/lbIuhtJ9Bsxrh7+RYfu98XjFg2Q2wl4KdUTiYPAh20kzhOXpujcUgW+RSWdAff Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7778a88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34BK5m4q018171;
        Thu, 11 May 2023 21:43:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf77kcm8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 21:43:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34BLhX1e028893;
        Thu, 11 May 2023 21:43:37 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3qf77kcm6r-5;
        Thu, 11 May 2023 21:43:37 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
Date:   Thu, 11 May 2023 14:43:03 -0700
Message-Id: <1683841383-21372-5-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
References: <1683841383-21372-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_17,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110184
X-Proofpoint-GUID: 4ME1igq0esmydZPTzkXWcF31hDcfT5Y1
X-Proofpoint-ORIG-GUID: 4ME1igq0esmydZPTzkXWcF31hDcfT5Y1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the GETATTR request on a file that has write delegation in effect
and the request attributes include the change info and size attribute
then the request is handled as below:

Server sends CB_GETATTR to client to get the latest change info and file
size. If these values are the same as the server's cached values then
the GETATTR proceeds as normal.

If either the change info or file size is different from the server's
cached value, or the file was already marked as modified, then:

   . update time_modify and time_metadata in the file's metadata
     with current time

   . encode GETATTR as normal except the file size is encoded with
     the value returned from the CB_GETATTR

   . mark the file as modified

If the CB_GETATTR fails for any reasons, the delegation is recalled
and NFS4ERR_DELAY is returned for the GETATTR.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 58 ++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfs4xdr.c   | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/state.h     |  7 +++++
 3 files changed, 148 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 09a9e16407f9..fb305b28a090 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -127,6 +127,7 @@ static void free_session(struct nfsd4_session *);
 
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1175,6 +1176,10 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	dp->dl_recalled = false;
 	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
 		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
+	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
+			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
+	dp->dl_cb_fattr.ncf_file_modified = false;
+	dp->dl_cb_fattr.ncf_cb_bmap[0] = FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
 	return dp;
@@ -2882,11 +2887,49 @@ nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
 	spin_unlock(&nn->client_lock);
 }
 
+static int
+nfsd4_cb_getattr_done(struct nfsd4_callback *cb, struct rpc_task *task)
+{
+	struct nfs4_cb_fattr *ncf =
+		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+
+	ncf->ncf_cb_status = task->tk_status;
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
+{
+	struct nfs4_cb_fattr *ncf =
+		container_of(cb, struct nfs4_cb_fattr, ncf_getattr);
+
+	clear_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags);
+	wake_up_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY);
+}
+
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
 	.done		= nfsd4_cb_recall_any_done,
 	.release	= nfsd4_cb_recall_any_release,
 };
 
+static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
+	.done		= nfsd4_cb_getattr_done,
+	.release	= nfsd4_cb_getattr_release,
+};
+
+void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
+{
+	if (test_and_set_bit(CB_GETATTR_BUSY, &ncf->ncf_cb_flags))
+		return;
+	nfsd4_run_cb(&ncf->ncf_getattr);
+}
+
 static struct nfs4_client *create_client(struct xdr_netobj name,
 		struct svc_rqst *rqstp, nfs4_verifier *verf)
 {
@@ -5591,6 +5634,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	int cb_up;
 	int status = 0;
 	u32 wdeleg = false;
+	struct kstat stat;
+	struct path path;
 
 	cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
 	open->op_recall = 0;
@@ -5626,6 +5671,19 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 	wdeleg = open->op_share_access & NFS4_SHARE_ACCESS_WRITE;
 	open->op_delegate_type = wdeleg ?
 			NFS4_OPEN_DELEGATE_WRITE : NFS4_OPEN_DELEGATE_READ;
+	if (wdeleg) {
+		path.mnt = currentfh->fh_export->ex_path.mnt;
+		path.dentry = currentfh->fh_dentry;
+		if (vfs_getattr(&path, &stat, STATX_BASIC_STATS,
+						AT_STATX_SYNC_AS_STAT)) {
+			nfs4_put_stid(&dp->dl_stid);
+			destroy_delegation(dp);
+			goto out_no_deleg;
+		}
+		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
+		dp->dl_cb_fattr.ncf_initial_cinfo = nfsd4_change_attribute(&stat,
+							d_inode(currentfh->fh_dentry));
+	}
 	nfs4_put_stid(&dp->dl_stid);
 	return;
 out_no_deleg:
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 76db2fe29624..52d51784509e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2920,6 +2920,77 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
 	return nfserr_resource;
 }
 
+static struct file_lock *
+nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	struct file_lock *fl;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return NULL;
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
+		if (fl->fl_type == F_WRLCK) {
+			spin_unlock(&ctx->flc_lock);
+			return fl;
+		}
+	}
+	spin_unlock(&ctx->flc_lock);
+	return NULL;
+}
+
+static int
+nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode,
+			bool *modified, u64 *size)
+{
+	__be32 status;
+	struct file_lock *fl;
+	struct nfs4_delegation *dp;
+	struct nfs4_cb_fattr *ncf;
+	struct iattr attrs;
+
+	*modified = false;
+	fl = nfs4_wrdeleg_filelock(rqstp, inode);
+	if (!fl)
+		return 0;
+	dp = fl->fl_owner;
+	ncf = &dp->dl_cb_fattr;
+	if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
+		return 0;
+
+	refcount_inc(&dp->dl_stid.sc_count);
+	nfs4_cb_getattr(&dp->dl_cb_fattr);
+	wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
+	if (ncf->ncf_cb_status) {
+		status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
+		nfs4_put_stid(&dp->dl_stid);
+		return status;
+	}
+	ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
+	if (!ncf->ncf_file_modified &&
+			(ncf->ncf_initial_cinfo != ncf->ncf_cb_cinfo ||
+			ncf->ncf_cur_fsize != ncf->ncf_cb_fsize)) {
+		ncf->ncf_file_modified = true;
+	}
+
+	if (ncf->ncf_file_modified) {
+		/*
+		 * The server would not update the file's metadata
+		 * with the client's modified size.
+		 * nfsd4 change attribute is constructed from ctime.
+		 */
+		attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
+		attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
+		setattr_copy(&nop_mnt_idmap, inode, &attrs);
+		mark_inode_dirty(inode);
+		*size = ncf->ncf_cur_fsize;
+		*modified = true;
+	}
+	nfs4_put_stid(&dp->dl_stid);
+	return 0;
+}
+
 /*
  * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  * ourselves.
@@ -2957,6 +3028,8 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		.dentry	= dentry,
 	};
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	bool file_modified;
+	u64 size = 0;
 
 	BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
 	BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
@@ -2966,6 +3039,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (status)
 			goto out;
 	}
+	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
+		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry),
+						&file_modified, &size);
+		if (status)
+			goto out;
+	}
 
 	err = vfs_getattr(&path, &stat,
 			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
@@ -3089,7 +3168,10 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
 			goto out_resource;
-		p = xdr_encode_hyper(p, stat.size);
+		if (file_modified)
+			p = xdr_encode_hyper(p, size);
+		else
+			p = xdr_encode_hyper(p, stat.size);
 	}
 	if (bmval0 & FATTR4_WORD0_LINK_SUPPORT) {
 		p = xdr_reserve_space(xdr, 4);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 92349375053a..cf49f26442e5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -121,6 +121,10 @@ struct nfs4_cb_fattr {
 	struct nfsd4_callback ncf_getattr;
 	u32 ncf_cb_status;
 	u32 ncf_cb_bmap[1];
+	unsigned long ncf_cb_flags;
+	bool ncf_file_modified;
+	u64 ncf_initial_cinfo;
+	u64 ncf_cur_fsize; 
 
 	/* from CB_GETATTR reply */
 	u64 ncf_cb_cinfo;
@@ -744,6 +748,9 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
 extern int nfsd4_client_record_check(struct nfs4_client *clp);
 extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
+/* CB_GETTTAR */
+extern void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf);
+
 static inline bool try_to_expire_client(struct nfs4_client *clp)
 {
 	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
-- 
2.9.5

