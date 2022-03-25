Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA34E6D44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 05:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358222AbiCYEgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 00:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358216AbiCYEge (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:36:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDB4C681A;
        Thu, 24 Mar 2022 21:35:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P00acX031973;
        Fri, 25 Mar 2022 04:34:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Z0U8Ct3qv1nLuhMlKjSqu0rZX+wTACY54EfZ8SXiveo=;
 b=fsiK33OuLbSO3Rjc5l2ZmeLAJgYVliyjXGxDNo8i30AywQzkE879DPYI0sis6C6gi73g
 yDGPiyZkILED9k9M7nwGt/gjZz+3RXBwTtpclIOD9aQ9vSEpVdfcmRuuRMNet1y2Y5i7
 cFcZrjz2NmXUdFD8J5d/5rKZet5UXRdmbQ47Fv9x+uQI+8PtD7gknZqwMtrrUhfZwjs8
 GmYo4MdTzqxl0gvk7fFAArGJSY8ia/G4EpGuGgtfLNdy8WFb2N1n4nlhNdrkMzDQ4PMJ
 6z3o6EcThzoGrsPMJymEj0FNVTzsxoFS1jQa954jVMmHic3A+xoWBBWomYAmc5h+L6D1 hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5y26b97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:34:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22P4WC2D020729;
        Fri, 25 Mar 2022 04:34:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 04:34:56 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 22P4YsCW040479;
        Fri, 25 Mar 2022 04:34:56 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ew6sc2bmt-3;
        Fri, 25 Mar 2022 04:34:56 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v18 02/11] NFSD: Add courtesy client state, macro and spinlock to support courteous server
Date:   Thu, 24 Mar 2022 21:34:42 -0700
Message-Id: <1648182891-32599-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
References: <1648182891-32599-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-GUID: UeDT6wtw0Wk9w8ahC1o8mhK4ZP2jr1pv
X-Proofpoint-ORIG-GUID: UeDT6wtw0Wk9w8ahC1o8mhK4ZP2jr1pv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update nfs4_client to add:
 . cl_cs_client_state: courtesy client state
 . cl_cs_lock: spinlock to synchronize access to cl_cs_client_state
 . cl_cs_list: list used by laundromat to process courtesy clients

Modify alloc_client to initialize these fields.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c |  2 ++
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..a65d59510681 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2009,12 +2009,14 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	INIT_LIST_HEAD(&clp->cl_delegations);
 	INIT_LIST_HEAD(&clp->cl_lru);
 	INIT_LIST_HEAD(&clp->cl_revoked);
+	INIT_LIST_HEAD(&clp->cl_cs_list);
 #ifdef CONFIG_NFSD_PNFS
 	INIT_LIST_HEAD(&clp->cl_lo_states);
 #endif
 	INIT_LIST_HEAD(&clp->async_copies);
 	spin_lock_init(&clp->async_lock);
 	spin_lock_init(&clp->cl_lock);
+	spin_lock_init(&clp->cl_cs_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
 err_no_hashtbl:
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 4fc1fd639527..23996c6ca75e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
 #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
 
 #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
 
 /*
  * The following attributes are currently not supported by the NFSv4 server:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc..40e390abc842 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -283,6 +283,35 @@ struct nfsd4_sessionid {
 #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
 
 /*
+ * CLIENT_  CLIENT_ CLIENT_
+ * COURTESY EXPIRED RECONNECTED      Meaning                  Where set
+ * -----------------------------------------------------------------------------
+ * | false | false | false | Confirmed, active    | Default                    |
+ * |---------------------------------------------------------------------------|
+ * | true  | false | false | Courtesy state.      | nfs4_get_client_reaplist   |
+ * |       |       |       | Lease/lock/share     |                            |
+ * |       |       |       | reservation conflict |                            |
+ * |       |       |       | can cause Courtesy   |                            |
+ * |       |       |       | client to be expired |                            |
+ * |---------------------------------------------------------------------------|
+ * | false | true  | false | Courtesy client to be| nfs4_laundromat            |
+ * |       |       |       | expired by Laundromat| nfsd4_lm_lock_expired      |
+ * |       |       |       | due to conflict     | nfsd4_discard_courtesy_clnt |
+ * |       |       |       |                      | nfsd4_expire_courtesy_clnt |
+ * |---------------------------------------------------------------------------|
+ * | false | false | true  | Courtesy client      | nfsd4_courtesy_clnt_expired|
+ * |       |       |       | reconnected,         |                            |
+ * |       |       |       | becoming active      |                            |
+ * -----------------------------------------------------------------------------
+ */
+
+enum courtesy_client_state {
+	NFSD4_CLIENT_COURTESY = 1,
+	NFSD4_CLIENT_EXPIRED,
+	NFSD4_CLIENT_RECONNECTED,
+};
+
+/*
  * struct nfs4_client - one per client.  Clientids live here.
  *
  * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
@@ -385,6 +414,10 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	enum courtesy_client_state	cl_cs_client_state;
+	spinlock_t		cl_cs_lock;
+	struct list_head	cl_cs_list;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

