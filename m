Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599B5166B6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353513AbiEARlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 May 2022 13:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349508AbiEARlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 May 2022 13:41:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB53112754;
        Sun,  1 May 2022 10:38:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2418N8eo032436;
        Sun, 1 May 2022 17:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=KSwdy7k4AbCtdvxlg4g15CmAPWuged6FqyEtqqkZ7fM=;
 b=zp3TtOl/eIfUzMpMWKLAuNbp7cxyFqENbqy1b324RQPEyMZjj5CLIrYw5U+geebFebz1
 6IapR12aEcS1yPO94MXrkHPlb04W2H3DSEEk9Vm48MvkX1Lz/jx2HmTleqDHwnagbuxJ
 gizismWVQHwxil7LYcnUd4dpbon3SvU60mJdms3buT9Z3FQD6b2WQxXiFdn63cACrGol
 jJ7fobK5zvEZzu9TGvQpNY1/24iSYIeBpiBu4x2p01vuobTsHPJVFATj46qUjOjLIcus
 1BU9uREuRfj1aOcaveul0ixUZ9Ez/gkDgPbm/8yVbOeXVsjEzq+rduh8i2K3vmAam7UX kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0aht9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 241HZDwq033356;
        Sun, 1 May 2022 17:38:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 01 May 2022 17:38:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 241HauVd034841;
        Sun, 1 May 2022 17:38:20 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a37w5x-3;
        Sun, 01 May 2022 17:38:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v24 2/7] NFSD: add support for share reservation conflict to courteous server
Date:   Sun,  1 May 2022 10:38:11 -0700
Message-Id: <1651426696-15509-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
References: <1651426696-15509-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: xxIyohcNeROgTBZRqCUhYSsX_5otRXZw
X-Proofpoint-ORIG-GUID: xxIyohcNeROgTBZRqCUhYSsX_5otRXZw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch allows expired client with open state to be in COURTESY
state. Share/access conflict with COURTESY client is resolved by
setting COURTESY client to EXPIRABLE state, schedule laundromat
to run and returning nfserr_jukebox to the request client.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 917eaab45999..0e98e9c16e3e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -694,6 +694,57 @@ static unsigned int file_hashval(struct svc_fh *fh)
 
 static struct hlist_head file_hashtbl[FILE_HASH_SIZE];
 
+/*
+ * Check if courtesy clients have conflicting access and resolve it if possible
+ *
+ * access:  is op_share_access if share_access is true.
+ *	    Check if access mode, op_share_access, would conflict with
+ *	    the current deny mode of the file 'fp'.
+ * access:  is op_share_deny if share_access is false.
+ *	    Check if the deny mode, op_share_deny, would conflict with
+ *	    current access of the file 'fp'.
+ * stp:     skip checking this entry.
+ * new_stp: normal open, not open upgrade.
+ *
+ * Function returns:
+ *	false - access/deny mode conflict with normal client.
+ *	true  - no conflict or conflict with courtesy client(s) is resolved.
+ */
+static bool
+nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
+{
+	struct nfs4_ol_stateid *st;
+	bool resolvable = true;
+	unsigned char bmap;
+	struct nfsd_net *nn;
+	struct nfs4_client *clp;
+
+	lockdep_assert_held(&fp->fi_lock);
+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
+		/* ignore lock stateid */
+		if (st->st_openstp)
+			continue;
+		if (st == stp && new_stp)
+			continue;
+		/* check file access against deny mode or vice versa */
+		bmap = share_access ? st->st_deny_bmap : st->st_access_bmap;
+		if (!(access & bmap_to_share_mode(bmap)))
+			continue;
+		clp = st->st_stid.sc_client;
+		if (try_to_expire_client(clp))
+			continue;
+		resolvable = false;
+		break;
+	}
+	if (resolvable) {
+		clp = stp->st_stid.sc_client;
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+	return resolvable;
+}
+
 static void
 __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 {
@@ -4969,7 +5020,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -4985,6 +5036,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	 */
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, open->op_share_deny, false))
+			status = nfserr_jukebox;
 		spin_unlock(&fp->fi_lock);
 		goto out;
 	}
@@ -4992,6 +5050,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	/* set access to the file */
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, open->op_share_access, true))
+			status = nfserr_jukebox;
 		spin_unlock(&fp->fi_lock);
 		goto out;
 	}
@@ -5038,21 +5103,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 }
 
 static __be32
-nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp, struct nfsd4_open *open)
+nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp,
+		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
+		struct nfsd4_open *open)
 {
 	__be32 status;
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status == nfs_ok) {
-		set_deny(open->op_share_deny, stp);
-		fp->fi_share_deny |=
+		if (status != nfserr_share_denied) {
+			set_deny(open->op_share_deny, stp);
+			fp->fi_share_deny |=
 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
+		} else {
+			if (nfs4_resolve_deny_conflicts_locked(fp, false,
+					stp, open->op_share_deny, false))
+				status = nfserr_jukebox;
+		}
 	}
 	spin_unlock(&fp->fi_lock);
 
@@ -5393,7 +5466,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
-		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
@@ -5627,6 +5700,26 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+static bool
+nfs4_has_any_locks(struct nfs4_client *clp)
+{
+	int i;
+	struct nfs4_stateowner *so;
+
+	spin_lock(&clp->cl_lock);
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
+				so_strhash) {
+			if (so->so_is_open_owner)
+				continue;
+			spin_unlock(&clp->cl_lock);
+			return true;
+		}
+	}
+	spin_unlock(&clp->cl_lock);
+	return false;
+}
+
 /*
  * place holder for now, no check for lock blockers yet
  */
@@ -5634,8 +5727,8 @@ static bool
 nfs4_anylock_blockers(struct nfs4_client *clp)
 {
 	if (atomic_read(&clp->cl_delegs_in_recall) ||
-			client_has_openowners(clp)  ||
-			!list_empty(&clp->async_copies))
+			!list_empty(&clp->async_copies) ||
+			nfs4_has_any_locks(clp))
 		return true;
 	return false;
 }
-- 
2.9.5

