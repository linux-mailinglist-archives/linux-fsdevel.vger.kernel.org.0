Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7B512C56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbiD1HKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244948AbiD1HKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:10:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32E996A5;
        Thu, 28 Apr 2022 00:06:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S61ume032133;
        Thu, 28 Apr 2022 07:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=ZhdYQBL7zu8CTFRmgR6OmXO/7Gx0vZnBdujqMS38ScA=;
 b=Za339CKvzxxDA96xdc5nQFKMuRLYGUpem/OZheqksQ0x+OnwPmgklo0uKcLK2vSSgrcY
 BIotkbAqRwK+rfwAI/WYzx8cLMT45ZyKRGs4/0dewmdq5B4cG2DWInW8xpzOvKeFuFDE
 6i/nEfaJW8MR1BHR663/6UVR2RhW6LA1KT0wLrJW5ZmDM5bNIEUXlELduRL95hXPLNVC
 zynnWb6qtYuukQXrbPL+qCyj8cjHFbabgcSwqGJATxlLcdE7n+QUUnkY6EzeVvy0FVbH
 iLMVC+wSFhe+FoFuD6DqpnhdaUvGmkCfw0b/1gu6RRhaZ03jbJqCOPoBYnyibAqDSVg4 HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb102ngy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S70DKU019617;
        Thu, 28 Apr 2022 07:06:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 07:06:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 23S76cAm007862;
        Thu, 28 Apr 2022 07:06:45 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w634qj-7;
        Thu, 28 Apr 2022 07:06:45 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v23 6/7] NFSD: add support for lock conflict to courteous server
Date:   Thu, 28 Apr 2022 00:06:34 -0700
Message-Id: <1651129595-6904-7-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: zQPvg_Q6p8-EhGTaXSe2E6MGnjJwByR_
X-Proofpoint-GUID: zQPvg_Q6p8-EhGTaXSe2E6MGnjJwByR_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch allows expired client with lock state to be in COURTESY
state. Lock conflict with COURTESY client is resolved by the fs/lock
code using the lm_lock_expirable and lm_expire_lock callback in the
struct lock_manager_operations.

If conflict client is in COURTESY state, set it to EXPIRABLE and
schedule the laundromat to run immediately to expire the client. The
callback lm_expire_lock waits for the laundromat to flush its work
queue before returning to caller.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 86 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5b0777a24017..cf6d5ebea17a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5705,11 +5705,31 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/* Check if any lock belonging to this lockowner has any blockers */
 static bool
-nfs4_has_any_locks(struct nfs4_client *clp)
+nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
+{
+	struct file_lock_context *ctx;
+	struct nfs4_ol_stateid *stp;
+	struct nfs4_file *nf;
+
+	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
+		nf = stp->st_stid.sc_file;
+		ctx = nf->fi_inode->i_flctx;
+		if (!ctx)
+			continue;
+		if (locks_owner_has_blockers(ctx, lo))
+			return true;
+	}
+	return false;
+}
+
+static bool
+nfs4_anylock_blockers(struct nfs4_client *clp)
 {
 	int i;
 	struct nfs4_stateowner *so;
+	struct nfs4_lockowner *lo;
 
 	spin_lock(&clp->cl_lock);
 	for (i = 0; i < OWNER_HASH_SIZE; i++) {
@@ -5717,40 +5737,17 @@ nfs4_has_any_locks(struct nfs4_client *clp)
 				so_strhash) {
 			if (so->so_is_open_owner)
 				continue;
-			spin_unlock(&clp->cl_lock);
-			return true;
+			lo = lockowner(so);
+			if (nfs4_lockowner_has_blockers(lo)) {
+				spin_unlock(&clp->cl_lock);
+				return true;
+			}
 		}
 	}
 	spin_unlock(&clp->cl_lock);
 	return false;
 }
 
-/*
- * place holder for now, no check for lock blockers yet
- */
-static bool
-nfs4_anylock_blockers(struct nfs4_client *clp)
-{
-	/* not allow locks yet */
-	if (nfs4_has_any_locks(clp))
-		return true;
-	/*
-	 * don't want to check for delegation conflict here since
-	 * we need the state_lock for it. The laundromat willexpire
-	 * COURTESY later when checking for delegation recall timeout.
-	 */
-	return false;
-}
-
-static bool client_has_state_tmp(struct nfs4_client *clp)
-{
-	if (((!list_empty(&clp->cl_delegations)) ||
-			client_has_openowners(clp)) &&
-			list_empty(&clp->async_copies))
-		return true;
-	return false;
-}
-
 static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
@@ -5766,8 +5763,9 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 			goto exp_client;
 		if (!state_expired(lt, clp->cl_time))
 			break;
-		clp->cl_state = NFSD4_COURTESY;
-		if (!client_has_state_tmp(clp) ||
+		if (!atomic_read(&clp->cl_rpc_users))
+			clp->cl_state = NFSD4_COURTESY;
+		if (!client_has_state(clp) ||
 				ktime_get_boottime_seconds() >=
 				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
 			goto exp_client;
@@ -6715,6 +6713,29 @@ nfsd4_lm_put_owner(fl_owner_t owner)
 		nfs4_put_stateowner(&lo->lo_owner);
 }
 
+/* return pointer to struct nfs4_client if client is expirable */
+static bool
+nfsd4_lm_lock_expirable(struct file_lock *cfl)
+{
+	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
+	struct nfs4_client *clp = lo->lo_owner.so_client;
+	struct nfsd_net *nn;
+
+	if (try_to_expire_client(clp)) {
+		nn = net_generic(clp->net, nfsd_net_id);
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+		return true;
+	}
+	return false;
+}
+
+/* schedule laundromat to run immediately and wait for it to complete */
+static void
+nfsd4_lm_expire_lock(void)
+{
+	flush_workqueue(laundry_wq);
+}
+
 static void
 nfsd4_lm_notify(struct file_lock *fl)
 {
@@ -6741,9 +6762,12 @@ nfsd4_lm_notify(struct file_lock *fl)
 }
 
 static const struct lock_manager_operations nfsd_posix_mng_ops  = {
+	.lm_mod_owner = THIS_MODULE,
 	.lm_notify = nfsd4_lm_notify,
 	.lm_get_owner = nfsd4_lm_get_owner,
 	.lm_put_owner = nfsd4_lm_put_owner,
+	.lm_lock_expirable = nfsd4_lm_lock_expirable,
+	.lm_expire_lock = nfsd4_lm_expire_lock,
 };
 
 static inline void
-- 
2.9.5

