Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C7A4DC05C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiCQHpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 03:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiCQHpS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:45:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B2C3373;
        Thu, 17 Mar 2022 00:44:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22H3X4pl001939;
        Thu, 17 Mar 2022 07:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=w0KzpJNqykCqRyJUIHFUQuG/jHs/AaHY45WzIx3gIE0=;
 b=byE9A6P/O8hpSs4OZeFop55f/ZCoHrKQqaoG5yAOZPPEDVJIDyHpRwiL3Ys7RYAp6jq/
 +sTpDnctkDGaZ6Ld1vHc/3qDrExLgpJWbp4F3zb8j7ti7CNxOiq4/Pffxz55ijr5Wq/P
 TvU9TYHKVTc9nYg12Kv6zv1KHoRHZQcq0BD17bY6tpzuqHPhBxdLWt6EIdL55Czvsnlh
 ZLbqWWOkK0xLNLpWnMf6JzMkCeGNHyasDydIgzd7dVFrzPY3O+GDgAR7oaVZst9yu+37
 6wsrg2Hur9R7VljENg/kW3pN8iityS1yT3yRffTsgehDsTNEq7fMVTt7mAjeO5jsUyBM IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwr5e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:43:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22H7fnFh035001;
        Thu, 17 Mar 2022 07:43:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3erhy2wqxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 07:43:56 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22H7hoGl038783;
        Thu, 17 Mar 2022 07:43:55 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3erhy2wqv5-6;
        Thu, 17 Mar 2022 07:43:55 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v17 05/11] NFSD: Update nfs4_get_vfs_file() to handle courtesy client
Date:   Thu, 17 Mar 2022 00:43:42 -0700
Message-Id: <1647503028-11966-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
References: <1647503028-11966-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: avO93WK59yuar-DhDMp-5UQ456BEgGsj
X-Proofpoint-ORIG-GUID: avO93WK59yuar-DhDMp-5UQ456BEgGsj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
reservation conflict with courtesy client.

Update nfs4_get_vfs_file and nfs4_upgrade_open to handle share
reservation conflict with courtesy client.

When we have deny/access conflict we walk the fi_stateids of the
file in question, looking for open stateid and check the deny/access
of that stateid against the one from the open request. If there is
a conflict then we check if the client that owns that stateid is
a courtesy client. If it is then we set the client state to
CLIENT_EXPIRED and allow the open request to continue. We have
to scan all the stateid's of the file since the conflict can be
caused by multiple open stateid's.

Client with CLIENT_EXPIRED is expired by the laundromat.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f20c75890594..c6b5e05c9c34 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4950,9 +4950,75 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 	return nfsd_setattr(rqstp, fh, &iattr, 0, (time64_t)0);
 }
 
+static bool
+nfs4_check_access_deny_bmap(struct nfs4_ol_stateid *stp, u32 access,
+			bool share_access)
+{
+	if (share_access) {
+		if (!stp->st_deny_bmap)
+			return false;
+
+		if ((stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_BOTH)) ||
+			(access & NFS4_SHARE_ACCESS_READ &&
+				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_READ)) ||
+			(access & NFS4_SHARE_ACCESS_WRITE &&
+				stp->st_deny_bmap & (1 << NFS4_SHARE_DENY_WRITE))) {
+			return true;
+		}
+		return false;
+	}
+	if ((access & NFS4_SHARE_DENY_BOTH) ||
+		(access & NFS4_SHARE_DENY_READ &&
+			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_READ)) ||
+		(access & NFS4_SHARE_DENY_WRITE &&
+			stp->st_access_bmap & (1 << NFS4_SHARE_ACCESS_WRITE))) {
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Check whether courtesy clients have conflicting access
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
+ *	true   - access/deny mode conflict with normal client.
+ *	false  - no conflict or conflict with courtesy client(s) is resolved.
+ */
+static bool
+nfs4_resolve_deny_conflicts_locked(struct nfs4_file *fp, bool new_stp,
+		struct nfs4_ol_stateid *stp, u32 access, bool share_access)
+{
+	struct nfs4_ol_stateid *st;
+	struct nfs4_client *clp;
+	bool conflict = false;
+
+	lockdep_assert_held(&fp->fi_lock);
+	list_for_each_entry(st, &fp->fi_stateids, st_perfile) {
+		if (st->st_openstp || (st == stp && new_stp) ||
+			(!nfs4_check_access_deny_bmap(st,
+					access, share_access)))
+			continue;
+		clp = st->st_stid.sc_client;
+		if (nfsd4_expire_courtesy_clnt(clp))
+			continue;
+		conflict = true;
+		break;
+	}
+	return conflict;
+}
+
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -4968,15 +5034,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	 */
 	status = nfs4_file_check_deny(fp, open->op_share_deny);
 	if (status != nfs_ok) {
-		spin_unlock(&fp->fi_lock);
-		goto out;
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, open->op_share_deny, false)) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
 	}
 
 	/* set access to the file */
 	status = nfs4_file_get_access(fp, open->op_share_access);
 	if (status != nfs_ok) {
-		spin_unlock(&fp->fi_lock);
-		goto out;
+		if (status != nfserr_share_denied) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
+		if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, open->op_share_access, true)) {
+			spin_unlock(&fp->fi_lock);
+			goto out;
+		}
 	}
 
 	/* Set access bits in stateid */
@@ -5027,7 +5107,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
@@ -5036,7 +5116,10 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 		set_deny(open->op_share_deny, stp);
 		fp->fi_share_deny |=
 				(open->op_share_deny & NFS4_SHARE_DENY_BOTH);
-	}
+	} else if (status == nfserr_share_denied &&
+		!nfs4_resolve_deny_conflicts_locked(fp, false, stp,
+			open->op_share_deny, false))
+		status = nfs_ok;
 	spin_unlock(&fp->fi_lock);
 
 	if (status != nfs_ok)
@@ -5376,7 +5459,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 			goto out;
 		}
 	} else {
-		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open);
+		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
 			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
-- 
2.9.5

