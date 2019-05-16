Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 431701FD52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfEPBq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:26 -0400
Received: from fieldses.org ([173.255.197.46]:33074 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfEPBUY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:20:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 65D232632; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 02/12] nfsd: rename cl_refcount
Date:   Wed, 15 May 2019 21:20:09 -0400
Message-Id: <1557969619-17157-5-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Rename this to a more descriptive name.

Also, I'm going to want a second refcount with a slightly different use.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 26 +++++++++++++-------------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6a45fb00c5fc..9dab61bbd256 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -137,7 +137,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 
 	if (is_client_expired(clp))
 		return nfserr_expired;
-	atomic_inc(&clp->cl_refcount);
+	atomic_inc(&clp->cl_rpc_users);
 	return nfs_ok;
 }
 
@@ -169,7 +169,7 @@ static void put_client_renew_locked(struct nfs4_client *clp)
 
 	lockdep_assert_held(&nn->client_lock);
 
-	if (!atomic_dec_and_test(&clp->cl_refcount))
+	if (!atomic_dec_and_test(&clp->cl_rpc_users))
 		return;
 	if (!is_client_expired(clp))
 		renew_client_locked(clp);
@@ -179,7 +179,7 @@ static void put_client_renew(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (!atomic_dec_and_lock(&clp->cl_refcount, &nn->client_lock))
+	if (!atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock))
 		return;
 	if (!is_client_expired(clp))
 		renew_client_locked(clp);
@@ -1847,7 +1847,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	clp->cl_name.len = name.len;
 	INIT_LIST_HEAD(&clp->cl_sessions);
 	idr_init(&clp->cl_stateids);
-	atomic_set(&clp->cl_refcount, 0);
+	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
@@ -1926,7 +1926,7 @@ unhash_client(struct nfs4_client *clp)
 
 static __be32 mark_client_expired_locked(struct nfs4_client *clp)
 {
-	if (atomic_read(&clp->cl_refcount))
+	if (atomic_read(&clp->cl_rpc_users))
 		return nfserr_jukebox;
 	unhash_client_locked(clp);
 	return nfs_ok;
@@ -4066,7 +4066,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 		spin_unlock(&nn->client_lock);
 		return nfserr_expired;
 	}
-	atomic_inc(&found->cl_refcount);
+	atomic_inc(&found->cl_rpc_users);
 	spin_unlock(&nn->client_lock);
 
 	/* Cache the nfs4_client in cstate! */
@@ -6550,7 +6550,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
 static inline void
 put_client(struct nfs4_client *clp)
 {
-	atomic_dec(&clp->cl_refcount);
+	atomic_dec(&clp->cl_rpc_users);
 }
 
 static struct nfs4_client *
@@ -6668,7 +6668,7 @@ nfsd_inject_add_lock_to_list(struct nfs4_ol_stateid *lst,
 		return;
 
 	lockdep_assert_held(&nn->client_lock);
-	atomic_inc(&clp->cl_refcount);
+	atomic_inc(&clp->cl_rpc_users);
 	list_add(&lst->st_locks, collect);
 }
 
@@ -6697,7 +6697,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
 				 * Despite the fact that these functions deal
 				 * with 64-bit integers for "count", we must
 				 * ensure that it doesn't blow up the
-				 * clp->cl_refcount. Throw a warning if we
+				 * clp->cl_rpc_users. Throw a warning if we
 				 * start to approach INT_MAX here.
 				 */
 				WARN_ON_ONCE(count == (INT_MAX / 2));
@@ -6821,7 +6821,7 @@ nfsd_foreach_client_openowner(struct nfs4_client *clp, u64 max,
 		if (func) {
 			func(oop);
 			if (collect) {
-				atomic_inc(&clp->cl_refcount);
+				atomic_inc(&clp->cl_rpc_users);
 				list_add(&oop->oo_perclient, collect);
 			}
 		}
@@ -6829,7 +6829,7 @@ nfsd_foreach_client_openowner(struct nfs4_client *clp, u64 max,
 		/*
 		 * Despite the fact that these functions deal with
 		 * 64-bit integers for "count", we must ensure that
-		 * it doesn't blow up the clp->cl_refcount. Throw a
+		 * it doesn't blow up the clp->cl_rpc_users. Throw a
 		 * warning if we start to approach INT_MAX here.
 		 */
 		WARN_ON_ONCE(count == (INT_MAX / 2));
@@ -6959,7 +6959,7 @@ static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 max,
 			if (dp->dl_time != 0)
 				continue;
 
-			atomic_inc(&clp->cl_refcount);
+			atomic_inc(&clp->cl_rpc_users);
 			WARN_ON(!unhash_delegation_locked(dp));
 			list_add(&dp->dl_recall_lru, victims);
 		}
@@ -6967,7 +6967,7 @@ static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 max,
 		/*
 		 * Despite the fact that these functions deal with
 		 * 64-bit integers for "count", we must ensure that
-		 * it doesn't blow up the clp->cl_refcount. Throw a
+		 * it doesn't blow up the clp->cl_rpc_users. Throw a
 		 * warning if we start to approach INT_MAX here.
 		 */
 		WARN_ON_ONCE(count == (INT_MAX / 2));
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 396c76755b03..aa9f1676e88a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -346,7 +346,7 @@ struct nfs4_client {
 	struct nfsd4_clid_slot	cl_cs_slot;	/* create_session slot */
 	u32			cl_exchange_flags;
 	/* number of rpc's in progress over an associated session: */
-	atomic_t		cl_refcount;
+	atomic_t		cl_rpc_users;
 	struct nfs4_op_map      cl_spo_must_allow;
 
 	/* for nfs41 callbacks */
-- 
2.21.0

