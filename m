Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82108512C4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiD1HKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 03:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244931AbiD1HKC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:10:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30F9AE42;
        Thu, 28 Apr 2022 00:06:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S76bLG025802;
        Thu, 28 Apr 2022 07:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=NeKPsnhXbhyGXUPn63ldrVck0gLA2yHIl8F7zspoBSg=;
 b=QHuPCaCldQZgOzEw6XSG1EmHfLTYUmg7E4jeUNMcf0yb7mwpQNscGiwmN4JVdotNh8jW
 gCXakPS1hDY0b4bvweEe5egm4TzCSx9hNiW+VjEqzSMkVuZrZTPR2bzXwe6eJeTpTLwT
 owatQcuZtyoKBZxcsE+58ojc8VFjOBu7pI3TSPF1R/aStvP8YoKuzJMGZON6L0rffE1v
 WdCGesSzOVqGy+rKeE0pTz9QHjUP5qsib9GrNpHHxozA7SACgECrcWVQKRhH5Hy/nQxN
 OoQdaVBqsUVi6hRPiNwF+2AdJ/FSVh9PeP440L1yASfDaf6TrujXQNHGBDjj570ZQvqN Eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mu6kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S70D81019599;
        Thu, 28 Apr 2022 07:06:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:41 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23S76cAe007862;
        Thu, 28 Apr 2022 07:06:41 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634qj-3;
        Thu, 28 Apr 2022 07:06:41 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v23 2/7] NFSD: add support for share reservation conflict to courteous server
Date:   Thu, 28 Apr 2022 00:06:30 -0700
Message-Id: <1651129595-6904-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: fkZ4xNu_ktxiTnpCHY_sIgZr1SlLaXKX
X-Proofpoint-ORIG-GUID: fkZ4xNu_ktxiTnpCHY_sIgZr1SlLaXKX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfsd/nfs4state.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b84ba19c856b..d2cb820de0ab 100644
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
+	bool conflict = true;
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
+		conflict = false;
+		break;
+	}
+	if (conflict) {
+		clp = stp->st_stid.sc_client;
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+	return conflict;
+}
+
 static void
 __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 {
@@ -4959,7 +5010,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -4975,6 +5026,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
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
@@ -4982,6 +5040,13 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
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
@@ -5028,21 +5093,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
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
 
@@ -5383,7 +5456,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
-		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
@@ -5617,12 +5690,35 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
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
 static bool
 nfs4_anylock_blockers(struct nfs4_client *clp)
 {
+	/* not allow locks yet */
+	if (nfs4_has_any_locks(clp))
+		return true;
 	/*
 	 * don't want to check for delegation conflict here since
 	 * we need the state_lock for it. The laundromat willexpire
@@ -5633,8 +5729,8 @@ nfs4_anylock_blockers(struct nfs4_client *clp)
 
 static bool client_has_state_tmp(struct nfs4_client *clp)
 {
-	if (!list_empty(&clp->cl_delegations) &&
-			!client_has_openowners(clp) &&
+	if (((!list_empty(&clp->cl_delegations)) ||
+			client_has_openowners(clp)) &&
 			list_empty(&clp->async_copies))
 		return true;
 	return false;
-- 
2.9.5

