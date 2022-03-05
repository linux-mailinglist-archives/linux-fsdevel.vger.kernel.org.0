Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFE4CE1A8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiCEAiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiCEAiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C351319;
        Fri,  4 Mar 2022 16:37:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224JoKJV020777;
        Sat, 5 Mar 2022 00:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=n/6suHMa+Md1/iEnSrtSJSHLZ0TtoygUiCImzxGwucc=;
 b=PI2Zj7xv9CytCWbCnrGHyxEuCYKXi5YvP/IbhILoVlTBoeLYe6DKXRZTmhd+SF9MNzVz
 jeF6IfWd4kKChqyWuxOSzSQo1+inXuTRO4eM9EKr3Ca9R2JghQS3cBx+O7Ma4fM/ZIeJ
 5IYs4zI6dh4NXH2wBKxG0Yherd+ucweucmQYyw7x2WPWhe3QlqVV9FINfvKr7Oy5+SQr
 7q0OMXFsIaEjXVyq0L9uy4wLkPXc++yPNEKQRJJ9trCHKVmo2ve9se8h8fjmJQgKbVBY
 5gAmBbYmK8cwf4FyUKmqmhyGqVwpOM8liqBmyZHnrnFvFb8X7+yVIEuhQF4XIpX+ZVAn Jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hw36jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250PjCL146449;
        Sat, 5 Mar 2022 00:37:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:26 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaX161402;
        Sat, 5 Mar 2022 00:37:26 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-11;
        Sat, 05 Mar 2022 00:37:26 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 10/11] NFSD: Update laundromat to handle courtesy clients
Date:   Fri,  4 Mar 2022 16:37:12 -0800
Message-Id: <1646440633-3542-11-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: Ukt9B3L70Tfj3zzPF54fcInclWC5FNs1
X-Proofpoint-GUID: Ukt9B3L70Tfj3zzPF54fcInclWC5FNs1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add nfs4_anylock_blocker and nfs4_lockowner_has_blockers to check
if an expired client has any lock blockers

Update nfs4_get_client_reaplist to:
 . add discarded courtesy client; client marked with CLIENT_EXPIRED,
   to reaplist.
 . detect if expired client still has state and no blockers then
   transit it to courtesy client by setting CLIENT_COURTESY flag
   and removing the client record.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9f58ad22d4c9..bced09014e6b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5806,24 +5806,116 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/* Check if any lock belongs to this lockowner has any blockers */
+static bool
+nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
+{
+	struct file_lock_context *ctx;
+	struct nfs4_ol_stateid *stp;
+	struct nfs4_file *nf;
+	struct file_lock *fl;
+
+	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
+		nf = stp->st_stid.sc_file;
+		ctx = nf->fi_inode->i_flctx;
+		if (!ctx)
+			continue;
+		spin_lock(&ctx->flc_lock);
+		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
+			if (fl->fl_owner != lo)
+				continue;
+			if (locks_has_blockers_locked(fl)) {
+				spin_unlock(&ctx->flc_lock);
+				return true;
+			}
+		}
+		spin_unlock(&ctx->flc_lock);
+	}
+	return false;
+}
+
+static bool
+nfs4_anylock_blockers(struct nfs4_client *clp)
+{
+	int i;
+	struct nfs4_stateowner *so;
+	struct nfs4_lockowner *lo;
+
+	spin_lock(&clp->cl_lock);
+	for (i = 0; i < OWNER_HASH_SIZE; i++) {
+		list_for_each_entry(so, &clp->cl_ownerstr_hashtbl[i],
+				so_strhash) {
+			if (so->so_is_open_owner)
+				continue;
+			lo = lockowner(so);
+			if (nfs4_lockowner_has_blockers(lo)) {
+				spin_unlock(&clp->cl_lock);
+				return true;
+			}
+		}
+	}
+	spin_unlock(&clp->cl_lock);
+	return false;
+}
+
 static void
 nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
 				struct laundry_time *lt)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	bool cour;
+	struct list_head cslist;
 
 	INIT_LIST_HEAD(reaplist);
+	INIT_LIST_HEAD(&cslist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
 		if (!state_expired(lt, clp->cl_time))
 			break;
-		if (mark_client_expired_locked(clp))
+
+		if (!client_has_state(clp))
+			goto exp_client;
+
+		if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
+			goto exp_client;
+		cour = test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+		if (cour && ktime_get_boottime_seconds() >=
+				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT))
+			goto exp_client;
+		if (nfs4_anylock_blockers(clp)) {
+exp_client:
+			if (mark_client_expired_locked(clp))
+				continue;
+			list_add(&clp->cl_lru, reaplist);
 			continue;
-		list_add(&clp->cl_lru, reaplist);
+		}
+		if (!cour) {
+			spin_lock(&clp->cl_cs_lock);
+			set_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags);
+			spin_unlock(&clp->cl_cs_lock);
+			list_add(&clp->cl_cs_list, &cslist);
+		}
 	}
 	spin_unlock(&nn->client_lock);
+
+	while (!list_empty(&cslist)) {
+		clp = list_first_entry(&cslist, struct nfs4_client, cl_cs_list);
+		list_del_init(&clp->cl_cs_list);
+		spin_lock(&clp->cl_cs_lock);
+		/*
+		 * Client might have re-connected. Make sure it's
+		 * still in courtesy state before removing its record.
+		 */
+		if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags) ||
+			!test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+			spin_unlock(&clp->cl_cs_lock);
+			continue;
+		}
+		spin_unlock(&clp->cl_cs_lock);
+		nfsd4_client_record_remove(clp);
+	}
 }
 
 static time64_t
@@ -5869,6 +5961,13 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
+		spin_lock(&clp->cl_cs_lock);
+		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
+			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
+			spin_unlock(&clp->cl_cs_lock);
+			continue;
+		}
+		spin_unlock(&clp->cl_cs_lock);
 		WARN_ON(!unhash_delegation_locked(dp));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-- 
2.9.5

