Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714B4CE1A1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiCEAiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiCEAiQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:16 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26E518E;
        Fri,  4 Mar 2022 16:37:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224KKVsD009041;
        Sat, 5 Mar 2022 00:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=uzBNFvtHoRswa0M3uV1N7JPzWWcNssMEvYaFtrPvz0Q=;
 b=yVE8Ji67QZ5ngD4t4r/kIiMFv5Vm7IEv9Pva9jur6kPq4TGPHprCJLMhWMGwBt8MMDy1
 jt1M+CvWUhFgetI//d34qgwxyNFpzarLPXc5Cd2yEr9nTt/z4nC+WKZNsBZxaAq+dVOB
 BBbLVTkGCPnUoJ6vOv8qrk7EydZatcDat7NhXtB1pHmqYxebfSOntLJV8pBJWqzAVc8I
 zx+qVODktdIBmYDDBH3ydWB2mDBNDiEsvuQsWzgX7w0wv3tFnDWyE8rw2LJ06OoEkqXz
 SZzbZ0LGTVdDwogzO+FnJd6hAANaBNTJHyYy3jGAqvEamu5sueglCCnjY9RNXZn6bnLq BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hv32wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250PtDI146510;
        Sat, 5 Mar 2022 00:37:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:23 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaN161402;
        Sat, 5 Mar 2022 00:37:22 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-6;
        Sat, 05 Mar 2022 00:37:22 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 05/11] NFSD: Update nfs4_get_vfs_file() to handle courtesy clients
Date:   Fri,  4 Mar 2022 16:37:07 -0800
Message-Id: <1646440633-3542-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: oHQW3muM_3wimgHVIUppcYA8lghbslD2
X-Proofpoint-ORIG-GUID: oHQW3muM_3wimgHVIUppcYA8lghbslD2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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

If share/access check fails with share denied then check if the
the conflict was caused by courtesy clients. If that's the case
then set CLIENT_EXPIRED flag to expire the courtesy clients and
allow nfs4_get_vfs_file to continue. Client with CLIENT_EXPIRED
is expired by the laundromat.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 135 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 40a357fd1a14..b16f689f34c3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4713,21 +4713,9 @@ nfsd_break_deleg_cb(struct file_lock *fl)
 	return ret;
 }
 
-/**
- * nfsd_breaker_owns_lease - Check if lease conflict was resolved
- * @fl: Lock state to check
- *
- * Return values:
- *   %true: Lease conflict was resolved
- *   %false: Lease conflict was not resolved.
- */
-static bool nfsd_breaker_owns_lease(struct file_lock *fl)
+static bool
+nfs4_check_and_expire_courtesy_client(struct nfs4_client *clp)
 {
-	struct nfs4_delegation *dl = fl->fl_owner;
-	struct svc_rqst *rqst;
-	struct nfs4_client *clp;
-
-	clp = dl->dl_stid.sc_client;
 	/*
 	 * need to sync with courtesy client trying to reconnect using
 	 * the cl_cs_lock, nn->client_lock can not be used since this
@@ -4744,6 +4732,26 @@ static bool nfsd_breaker_owns_lease(struct file_lock *fl)
 		return true;
 	}
 	spin_unlock(&clp->cl_cs_lock);
+	return false;
+}
+
+/**
+ * nfsd_breaker_owns_lease - Check if lease conflict was resolved
+ * @fl: Lock state to check
+ *
+ * Return values:
+ *   %true: Lease conflict was resolved
+ *   %false: Lease conflict was not resolved.
+ */
+static bool nfsd_breaker_owns_lease(struct file_lock *fl)
+{
+	struct nfs4_delegation *dl = fl->fl_owner;
+	struct svc_rqst *rqst;
+	struct nfs4_client *clp;
+
+	clp = dl->dl_stid.sc_client;
+	if (nfs4_check_and_expire_courtesy_client(clp))
+		return true;
 
 	if (!i_am_nfsd())
 		return false;
@@ -4965,9 +4973,75 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
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
+		if (nfs4_check_and_expire_courtesy_client(clp))
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
@@ -4983,15 +5057,29 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
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
@@ -5042,7 +5130,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
@@ -5051,7 +5139,10 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
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
@@ -5391,7 +5482,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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

