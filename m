Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC41F4EDE37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239531AbiCaQEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiCaQEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:04:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F41DFDFB;
        Thu, 31 Mar 2022 09:02:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VFDBN0007018;
        Thu, 31 Mar 2022 16:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=0p4iGIYFmCFMjUeFBBxcS37qGunQWuC9Rb64G9mASbI=;
 b=WgkYeOiBec4Tg0vurcGWnG1EZBVqyuZ2VwAObGrmg3XqR85C3ZMkN4+8JbgFb0G68iYq
 wkE4ry9x0EAr6G1vBiOCMvOpBbKrDUif1BUl+9lMKDD8lz0xqFXMKiDav8IMIuoz0JdT
 +O4wXe/dYEp+pewtdvikl31K9XlGw5Yeanb/2jcQ90av5mgl9i+QAmb0q8OG6CMDiYN0
 xGAFiu+3sMOx21zttevaHH6ZOpQ7WNKf5CacdCPsTxmaE7PpWADOxvSoV7zYejuPHPMz
 bLhRFdkAiADBRK8qyuZIo4k6iUH2qjSHGiPNaVC2EFtlb5C07r8mgL85wGD1YKTOBfZP Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes4rda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFvM1Q029527;
        Thu, 31 Mar 2022 16:02:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 16:02:19 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22VG10KF003132;
        Thu, 31 Mar 2022 16:02:19 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95hxf8-11;
        Thu, 31 Mar 2022 16:02:19 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v19 10/11] NFSD: Update laundromat to handle courtesy clients
Date:   Thu, 31 Mar 2022 09:02:08 -0700
Message-Id: <1648742529-28551-11-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: HcrJPB_2LA6xyGsOcl70NoGClV2XqEAb
X-Proofpoint-ORIG-GUID: HcrJPB_2LA6xyGsOcl70NoGClV2XqEAb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
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
 . add courtesy client in CLIENT_EXPIRED state to reaplist.
 . detect if expired client still has state and no blockers then
   transit it to courtesy client by setting CLIENT_COURTESY state
   and removing the client record.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ed98bba82669..b56c23fb6ba1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5737,24 +5737,106 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 }
 #endif
 
+/* Check if any lock belonging to this lockowner has any blockers */
+static bool
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
+		if (clp->cl_cs_client_state == NFSD4_CLIENT_EXPIRED)
+			goto exp_client;
+		cour = (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY);
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
+			clp->cl_cs_client_state = NFSD4_CLIENT_COURTESY;
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
+		if (clp->cl_cs_client_state != NFSD4_CLIENT_COURTESY) {
+			spin_unlock(&clp->cl_cs_lock);
+			continue;
+		}
+		spin_unlock(&clp->cl_cs_lock);
+		nfsd4_client_record_remove(clp);
+	}
 }
 
 static time64_t
@@ -5800,6 +5882,13 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
+		spin_lock(&clp->cl_cs_lock);
+		if (clp->cl_cs_client_state == NFSD4_CLIENT_COURTESY) {
+			clp->cl_cs_client_state = NFSD4_CLIENT_EXPIRED;
+			spin_unlock(&clp->cl_cs_lock);
+			continue;
+		}
+		spin_unlock(&clp->cl_cs_lock);
 		WARN_ON(!unhash_delegation_locked(dp));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
-- 
2.9.5

