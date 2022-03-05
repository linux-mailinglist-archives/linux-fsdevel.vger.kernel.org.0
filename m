Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53C74CE194
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 01:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiCEAiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 19:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCEAiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 19:38:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D930259F5E;
        Fri,  4 Mar 2022 16:37:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224K2vYL011976;
        Sat, 5 Mar 2022 00:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2021-07-09;
 bh=Ihk0tYTdTEWYxhZWaIlpMX9jo6hpzAbF6yZWs0jNw74=;
 b=jHpVF6yNZ+7HV0T9vQvlDnLBC0FwyuQ0oMKX/GDcUc6pETubXRn895+Gh0giHy+oHBdG
 kHK8aitVvRJ548hW8S6gOMH2cVZGNFdLX/u/zqUEVK+4h961hAuTrCjGcTVHcrFVJ7ag
 bIh4BxhZkLIGMBTTT9UkUSivmho2l/MarmloJsVhJ8ZFZJWc2XQZlDR1q9/7dbvi3zhI
 2iCNr970OZ8QmTauUc9LeGVPd9Umis9AT7ddhOmQ+ArqbMAoGZ02RaChTPmnXGpCbxLt
 +KygFDnARQlIAwCAuQLFphDb3wpTfvtONKKxChJHLG8UetJMzjdRzr2Z9OVmkP1wPe/n BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hvk5en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2250Piea146437;
        Sat, 5 Mar 2022 00:37:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Mar 2022 00:37:21 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 2250bJaH161402;
        Sat, 5 Mar 2022 00:37:20 GMT
Received: from ca-common-hq.us.oracle.com (ca-common-hq.us.oracle.com [10.211.9.209])
        by aserp3030.oracle.com with ESMTP id 3ek4jh9bfb-3;
        Sat, 05 Mar 2022 00:37:20 +0000
From:   Dai Ngo <dai.ngo@oracle.com>
To:     chuck.lever@oracle.com, bfields@fieldses.org
Cc:     jlayton@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v15 02/11] NFSD: Add client flags, macro and spinlock to support courteous server
Date:   Fri,  4 Mar 2022 16:37:04 -0800
Message-Id: <1646440633-3542-3-git-send-email-dai.ngo@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
X-Proofpoint-ORIG-GUID: g1xwsbmmfvwdGXZd_t0NID9GjDgICqN4
X-Proofpoint-GUID: g1xwsbmmfvwdGXZd_t0NID9GjDgICqN4
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add flags to track a client's lease state after the client fails to
renew its lease. Add macro for courtesy client expire time. Add spinlock
to synchronize access to these flags. Modify alloc_client to initialize
these fields.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
---
 fs/nfsd/nfs4state.c | 2 ++
 fs/nfsd/nfsd.h      | 1 +
 fs/nfsd/state.h     | 6 ++++++
 3 files changed, 9 insertions(+)

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
index 95457cfd37fc..8cbd3b69a584 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -343,6 +343,9 @@ struct nfs4_client {
 #define NFSD4_CLIENT_RECLAIM_COMPLETE	(3)	/* reclaim_complete done */
 #define NFSD4_CLIENT_CONFIRMED		(4)	/* client is confirmed */
 #define NFSD4_CLIENT_UPCALL_LOCK	(5)	/* upcall serialization */
+#define	NFSD4_CLIENT_COURTESY		(6)
+#define	NFSD4_CLIENT_EXPIRED		(7)
+#define	NFSD4_CLIENT_RECONNECTED	(8)
 #define NFSD4_CLIENT_CB_FLAG_MASK	(1 << NFSD4_CLIENT_CB_UPDATE | \
 					 1 << NFSD4_CLIENT_CB_KILL)
 	unsigned long		cl_flags;
@@ -385,6 +388,9 @@ struct nfs4_client {
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
 	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
+
+	spinlock_t		cl_cs_lock;
+	struct list_head	cl_cs_list;
 };
 
 /* struct nfs4_client_reset
-- 
2.9.5

