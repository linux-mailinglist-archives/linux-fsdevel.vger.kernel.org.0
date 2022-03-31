Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE74EDE33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiCaQEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239490AbiCaQEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082618546B;
        Thu, 31 Mar 2022 09:02:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEVZNZ032352;
        Thu, 31 Mar 2022 16:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=7m5VLcqBEMVCYwIs+MEvIHvY/see9DZZ11OwFVzEYfM=;
 b=DV73wRxXsO33KVlezXxYCY0WmC9DerAUcvzWm1hkef9R+CnDpbrDMP0Rn7OO5n0cMnK7
 23xNNMzDejx/3gPbkTae0V05LfONZtDh448DlzeyE2X/HeY4eYianJc37Azm1/GObmax
 ucFfrKYM5pVtEz7v264aLtclLRfF+MqijG4Lm9le9h6tDhDFT08FSMmLBVcidXmgAopI
 1symR5EVE2JHGyX6cPXY32Btp0/OIGN9ZtSYepMP+AC+muaptPJ4apHLeKDe6nCMki5h
 ZlWFmuCUhv4STY2T0Y4KmwfGqy8GDQGL6DukrzZTLg7B1q6qK/uehUDSML6FCVAzTebn 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctw1hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvNG5029664;
        Thu, 31 Mar 2022 16:02:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:16 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10K5003132;
        Thu, 31 Mar 2022 16:02:16 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-6;
        Thu, 31 Mar 2022 16:02:15 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 05/11] NFSD: Update nfs4_get_vfs_file() to handle courtesy client
Date:   Thu, 31 Mar 2022 09:02:03 -0700
Message-Id: <1648742529-28551-6-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: nb4y-kyY7ATNffqaeHYOgIGKsEkijwLS
X-Proofpoint-GUID: nb4y-kyY7ATNffqaeHYOgIGKsEkijwLS
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
 fs/nfsd/nfs4state.c | 85 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 72 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f20c75890594..fe8969ba94b3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -701,9 +701,56 @@ __nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 		atomic_inc(&fp->fi_access[O_RDONLY]);
 }
 
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
+	struct nfs4_client *clp;
+	bool conflict = true;
+	unsigned char bmap;
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
+		if (nfsd4_expire_courtesy_clnt(clp))
+			continue;
+		conflict = false;
+		break;
+	}
+	return conflict;
+}
+
 static __be32
-nfs4_file_get_access(struct nfs4_file *fp, u32 access)
+nfs4_file_get_access(struct nfs4_file *fp, u32 access,
+		struct nfs4_ol_stateid *stp, bool new_stp)
 {
+
 	lockdep_assert_held(&fp->fi_lock);
 
 	/* Does this access mode make sense? */
@@ -711,15 +758,21 @@ nfs4_file_get_access(struct nfs4_file *fp, u32 access)
 		return nfserr_inval;
 
 	/* Does it conflict with a deny mode already set? */
-	if ((access & fp->fi_share_deny) != 0)
-		return nfserr_share_denied;
+	if ((access & fp->fi_share_deny) != 0) {
+		if (!nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+				stp, access, true))
+			return nfserr_share_denied;
+	}
 
 	__nfs4_file_get_access(fp, access);
 	return nfs_ok;
 }
 
-static __be32 nfs4_file_check_deny(struct nfs4_file *fp, u32 deny)
+static __be32 nfs4_file_check_deny(struct nfs4_file *fp, u32 deny,
+		struct nfs4_ol_stateid *stp, bool new_stp)
 {
+	__be32 rc = nfs_ok;
+
 	/* Common case is that there is no deny mode. */
 	if (deny) {
 		/* Does this deny mode make sense? */
@@ -728,13 +781,19 @@ static __be32 nfs4_file_check_deny(struct nfs4_file *fp, u32 deny)
 
 		if ((deny & NFS4_SHARE_DENY_READ) &&
 		    atomic_read(&fp->fi_access[O_RDONLY]))
-			return nfserr_share_denied;
+			rc = nfserr_share_denied;
 
 		if ((deny & NFS4_SHARE_DENY_WRITE) &&
 		    atomic_read(&fp->fi_access[O_WRONLY]))
-			return nfserr_share_denied;
+			rc = nfserr_share_denied;
+
+		if (rc == nfserr_share_denied) {
+			if (nfs4_resolve_deny_conflicts_locked(fp, new_stp,
+					stp, deny, false))
+				rc = nfs_ok;
+		}
 	}
-	return nfs_ok;
+	return rc;
 }
 
 static void __nfs4_file_put_access(struct nfs4_file *fp, int oflag)
@@ -4952,7 +5011,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh *fh,
 
 static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 		struct svc_fh *cur_fh, struct nfs4_ol_stateid *stp,
-		struct nfsd4_open *open)
+		struct nfsd4_open *open, bool new_stp)
 {
 	struct nfsd_file *nf = NULL;
 	__be32 status;
@@ -4966,14 +5025,14 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 	 * Are we trying to set a deny mode that would conflict with
 	 * current access?
 	 */
-	status = nfs4_file_check_deny(fp, open->op_share_deny);
+	status = nfs4_file_check_deny(fp, open->op_share_deny, stp, new_stp);
 	if (status != nfs_ok) {
 		spin_unlock(&fp->fi_lock);
 		goto out;
 	}
 
 	/* set access to the file */
-	status = nfs4_file_get_access(fp, open->op_share_access);
+	status = nfs4_file_get_access(fp, open->op_share_access, stp, new_stp);
 	if (status != nfs_ok) {
 		spin_unlock(&fp->fi_lock);
 		goto out;
@@ -5027,11 +5086,11 @@ nfs4_upgrade_open(struct svc_rqst *rqstp, struct nfs4_file *fp, struct svc_fh *c
 	unsigned char old_deny_bmap = stp->st_deny_bmap;
 
 	if (!test_access(open->op_share_access, stp))
-		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open);
+		return nfs4_get_vfs_file(rqstp, fp, cur_fh, stp, open, false);
 
 	/* test and set deny mode */
 	spin_lock(&fp->fi_lock);
-	status = nfs4_file_check_deny(fp, open->op_share_deny);
+	status = nfs4_file_check_deny(fp, open->op_share_deny, stp, false);
 	if (status == nfs_ok) {
 		set_deny(open->op_share_deny, stp);
 		fp->fi_share_deny |=
@@ -5376,7 +5435,7 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
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

