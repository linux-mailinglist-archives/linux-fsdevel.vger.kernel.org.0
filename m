Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1A751291F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 03:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiD1Bzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiD1Bzt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:55:49 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF36A25C6F;
        Wed, 27 Apr 2022 18:52:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E45446801; Wed, 27 Apr 2022 21:52:34 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E45446801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1651110754;
        bh=qIgBDtQ0WL7+hpSZEtTpRAj3I83Jo0viOJs92A+fv0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgvIHdN8g4DKXe8nLipLQGj1F9m35SucFj9AO5abi75ILTtJtGow5ulF/H+1bU/VG
         eMFiuWtfEhUrCoveCA4pqQPRmL0vOAiQGWrNnzOajqiDwKpY1/YVD4DndYN8XZKNyu
         q9aZsyOsDuI3rgmDGM1R82ssuqLYyNrs//sq/9U4=
Date:   Wed, 27 Apr 2022 21:52:34 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v22 1/7] NFSD: add courteous server support for
 thread with only delegation
Message-ID: <20220428015234.GJ13471@fieldses.org>
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-2-git-send-email-dai.ngo@oracle.com>
 <20220427215614.GH13471@fieldses.org>
 <24607d8d-9a69-b139-ce1a-c0f70814de05@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24607d8d-9a69-b139-ce1a-c0f70814de05@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:52:37PM -0700, dai.ngo@oracle.com wrote:
> 
> On 4/27/22 2:56 PM, J. Bruce Fields wrote:
> >On Wed, Apr 27, 2022 at 01:52:47AM -0700, Dai Ngo wrote:
> >>This patch provides courteous server support for delegation only.
> >>Only expired client with delegation but no conflict and no open
> >>or lock state is allowed to be in COURTESY state.
> >>
> >>Delegation conflict with COURTESY/EXPIRABLE client is resolved by
> >>setting it to EXPIRABLE, queue work for the laundromat and return
> >>delay to the caller. Conflict is resolved when the laudromat runs
> >>and expires the EXIRABLE client while the NFS client retries the
> >>OPEN request. Local thread request that gets conflict is doing the
> >>retry in _break_lease.
> >>
> >>Client in COURTESY or EXPIRABLE state is allowed to reconnect and
> >>continues to have access to its state. Access to the nfs4_client by
> >>the reconnecting thread and the laundromat is serialized via the
> >>client_lock.
> >>
> >>Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> >>---
> >>  fs/nfsd/nfs4state.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--------
> >>  fs/nfsd/nfsd.h      |  1 +
> >>  fs/nfsd/state.h     | 32 ++++++++++++++++++++
> >>  3 files changed, 106 insertions(+), 13 deletions(-)
> >>
> >>diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>index 234e852fcdfa..216bd77a8764 100644
> >>--- a/fs/nfsd/nfs4state.c
> >>+++ b/fs/nfsd/nfs4state.c
> >>@@ -125,6 +125,8 @@ static void free_session(struct nfsd4_session *);
> >>  static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
> >>  static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
> >>+static struct workqueue_struct *laundry_wq;
> >>+
> >>  static bool is_session_dead(struct nfsd4_session *ses)
> >>  {
> >>  	return ses->se_flags & NFS4_SESSION_DEAD;
> >>@@ -152,6 +154,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
> >>  	if (is_client_expired(clp))
> >>  		return nfserr_expired;
> >>  	atomic_inc(&clp->cl_rpc_users);
> >>+	clp->cl_state = NFSD4_ACTIVE;
> >>  	return nfs_ok;
> >>  }
> >>@@ -172,6 +175,7 @@ renew_client_locked(struct nfs4_client *clp)
> >>  	list_move_tail(&clp->cl_lru, &nn->client_lru);
> >>  	clp->cl_time = ktime_get_boottime_seconds();
> >>+	clp->cl_state = NFSD4_ACTIVE;
> >>  }
> >>  static void put_client_renew_locked(struct nfs4_client *clp)
> >>@@ -2004,6 +2008,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
> >>  	idr_init(&clp->cl_stateids);
> >>  	atomic_set(&clp->cl_rpc_users, 0);
> >>  	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
> >>+	clp->cl_state = NFSD4_ACTIVE;
> >>  	INIT_LIST_HEAD(&clp->cl_idhash);
> >>  	INIT_LIST_HEAD(&clp->cl_openowners);
> >>  	INIT_LIST_HEAD(&clp->cl_delegations);
> >>@@ -4694,9 +4699,16 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> >>  	bool ret = false;
> >>  	struct nfs4_delegation *dp = (struct nfs4_delegation *)fl->fl_owner;
> >>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
> >>+	struct nfs4_client *clp = dp->dl_stid.sc_client;
> >>+	struct nfsd_net *nn;
> >>  	trace_nfsd_cb_recall(&dp->dl_stid);
> >>+	if (!try_to_expire_client(clp)) {
> >>+		nn = net_generic(clp->net, nfsd_net_id);
> >>+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> >>+	}
> >>+
> >>  	/*
> >>  	 * We don't want the locks code to timeout the lease for us;
> >>  	 * we'll remove it ourself if a delegation isn't returned
> >>@@ -5605,6 +5617,65 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
> >>  }
> >>  #endif
> >>+/*
> >>+ * place holder for now, no check for lock blockers yet
> >>+ */
> >>+static bool
> >>+nfs4_anylock_blockers(struct nfs4_client *clp)
> >>+{
> >>+	/*
> >>+	 * don't want to check for delegation conflict here since
> >>+	 * we need the state_lock for it. The laundromat willexpire
> >>+	 * COURTESY later when checking for delegation recall timeout.
> >>+	 */
> >>+	return false;
> >>+}
> >>+
> >>+static bool client_has_state_tmp(struct nfs4_client *clp)
> >>+{
> >>+	if (!list_empty(&clp->cl_delegations) &&
> >>+			!client_has_openowners(clp) &&
> >>+			list_empty(&clp->async_copies))
> >>+		return true;
> >>+	return false;
> >>+}
> >>+
> >>+static void
> >>+nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
> >>+				struct laundry_time *lt)
> >>+{
> >>+	struct list_head *pos, *next;
> >>+	struct nfs4_client *clp;
> >>+	bool cour;
> >>+
> >>+	INIT_LIST_HEAD(reaplist);
> >>+	spin_lock(&nn->client_lock);
> >>+	list_for_each_safe(pos, next, &nn->client_lru) {
> >>+		clp = list_entry(pos, struct nfs4_client, cl_lru);
> >>+		if (clp->cl_state == NFSD4_EXPIRABLE)
> >>+			goto exp_client;
> >>+		if (!state_expired(lt, clp->cl_time))
> >>+			break;
> >>+		if (!client_has_state_tmp(clp))
> >>+			goto exp_client;
> >>+		cour = (clp->cl_state == NFSD4_COURTESY);
> >>+		if (cour && ktime_get_boottime_seconds() >=
> >>+				(clp->cl_time + NFSD_COURTESY_CLIENT_TIMEOUT)) {
> >>+			goto exp_client;
> >>+		}
> >>+		if (nfs4_anylock_blockers(clp)) {
> >>+exp_client:
> >>+			if (mark_client_expired_locked(clp))
> >>+				continue;
> >>+			list_add(&clp->cl_lru, reaplist);
> >>+			continue;
> >>+		}
> >>+		if (!cour)
> >>+			cmpxchg(&clp->cl_state, NFSD4_ACTIVE, NFSD4_COURTESY);
> >I just noticed there's a small race here: a lock conflict (for example)
> >could intervene between checking nfs4_anylock_blockers and setting
> >COURTESY.
> 
> If there is lock conflict intervenes before setting COURTESY then that
> lock request is denied since the client is ACTIVE. Does NFSv4, NLM
> client retry the lock request? if it does then on next retry the
> COURTESY client will be expired.

I'm thinking of a local request for a blocking lock.  Yes, the request
will be denied, but then the process will block on the lock forever
(well, for 24 hours anyway).

> >I think what you want to do is set COURTESY first--right after you check
> >state_expired()--instead of doing it at the end.
> 
> Yes, I can make this change. I think this still has a tiny window
> where a lock conflict comes in after state_expired and before
> COURTESY is set?

No, I think it's OK.  A lock that comes before COURTESY is set will be
caught by nfs4_anylock_blockers().

--b.

> 
> -Dai
> 
> >
> >--b.
> >
> >>+	}
> >>+	spin_unlock(&nn->client_lock);
> >>+}
> >>+
> >>  static time64_t
> >>  nfs4_laundromat(struct nfsd_net *nn)
> >>  {
> >>@@ -5627,7 +5698,6 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>  		goto out;
> >>  	}
> >>  	nfsd4_end_grace(nn);
> >>-	INIT_LIST_HEAD(&reaplist);
> >>  	spin_lock(&nn->s2s_cp_lock);
> >>  	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> >>@@ -5637,17 +5707,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>  			_free_cpntf_state_locked(nn, cps);
> >>  	}
> >>  	spin_unlock(&nn->s2s_cp_lock);
> >>-
> >>-	spin_lock(&nn->client_lock);
> >>-	list_for_each_safe(pos, next, &nn->client_lru) {
> >>-		clp = list_entry(pos, struct nfs4_client, cl_lru);
> >>-		if (!state_expired(&lt, clp->cl_time))
> >>-			break;
> >>-		if (mark_client_expired_locked(clp))
> >>-			continue;
> >>-		list_add(&clp->cl_lru, &reaplist);
> >>-	}
> >>-	spin_unlock(&nn->client_lock);
> >>+	nfs4_get_client_reaplist(nn, &reaplist, &lt);
> >>  	list_for_each_safe(pos, next, &reaplist) {
> >>  		clp = list_entry(pos, struct nfs4_client, cl_lru);
> >>  		trace_nfsd_clid_purged(&clp->cl_clientid);
> >>@@ -5657,6 +5717,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>  	spin_lock(&state_lock);
> >>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> >>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> >>+		try_to_expire_client(dp->dl_stid.sc_client);
> >>  		if (!state_expired(&lt, dp->dl_time))
> >>  			break;
> >>  		WARN_ON(!unhash_delegation_locked(dp));
> >>@@ -5722,7 +5783,6 @@ nfs4_laundromat(struct nfsd_net *nn)
> >>  	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> >>  }
> >>-static struct workqueue_struct *laundry_wq;
> >>  static void laundromat_main(struct work_struct *);
> >>  static void
> >>diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> >>index 4fc1fd639527..23996c6ca75e 100644
> >>--- a/fs/nfsd/nfsd.h
> >>+++ b/fs/nfsd/nfsd.h
> >>@@ -336,6 +336,7 @@ void		nfsd_lockd_shutdown(void);
> >>  #define COMPOUND_ERR_SLACK_SPACE	16     /* OP_SETATTR */
> >>  #define NFSD_LAUNDROMAT_MINTIMEOUT      1   /* seconds */
> >>+#define	NFSD_COURTESY_CLIENT_TIMEOUT	(24 * 60 * 60)	/* seconds */
> >>  /*
> >>   * The following attributes are currently not supported by the NFSv4 server:
> >>diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> >>index 95457cfd37fc..6130376c438b 100644
> >>--- a/fs/nfsd/state.h
> >>+++ b/fs/nfsd/state.h
> >>@@ -283,6 +283,28 @@ struct nfsd4_sessionid {
> >>  #define HEXDIR_LEN     33 /* hex version of 16 byte md5 of cl_name plus '\0' */
> >>  /*
> >>+ *       State                Meaning                  Where set
> >>+ * --------------------------------------------------------------------------
> >>+ * | NFSD4_ACTIVE      | Confirmed, active    | Default                     |
> >>+ * |------------------- ----------------------------------------------------|
> >>+ * | NFSD4_COURTESY    | Courtesy state.      | nfs4_get_client_reaplist    |
> >>+ * |                   | Lease/lock/share     |                             |
> >>+ * |                   | reservation conflict |                             |
> >>+ * |                   | can cause Courtesy   |                             |
> >>+ * |                   | client to be expired |                             |
> >>+ * |------------------------------------------------------------------------|
> >>+ * | NFSD4_EXPIRABLE   | Courtesy client to be| nfs4_laundromat             |
> >>+ * |                   | expired by Laundromat| try_to_expire_client        |
> >>+ * |                   | due to conflict      |                             |
> >>+ * |------------------------------------------------------------------------|
> >>+ */
> >>+enum {
> >>+	NFSD4_ACTIVE = 0,
> >>+	NFSD4_COURTESY,
> >>+	NFSD4_EXPIRABLE,
> >>+};
> >>+
> >>+/*
> >>   * struct nfs4_client - one per client.  Clientids live here.
> >>   *
> >>   * The initial object created by an NFS client using SETCLIENTID (for NFSv4.0)
> >>@@ -385,6 +407,8 @@ struct nfs4_client {
> >>  	struct list_head	async_copies;	/* list of async copies */
> >>  	spinlock_t		async_lock;	/* lock for async copies */
> >>  	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
> >>+
> >>+	unsigned int		cl_state;
> >>  };
> >>  /* struct nfs4_client_reset
> >>@@ -702,4 +726,12 @@ extern void nfsd4_client_record_remove(struct nfs4_client *clp);
> >>  extern int nfsd4_client_record_check(struct nfs4_client *clp);
> >>  extern void nfsd4_record_grace_done(struct nfsd_net *nn);
> >>+static inline bool try_to_expire_client(struct nfs4_client *clp)
> >>+{
> >>+	bool ret;
> >>+
> >>+	ret = NFSD4_ACTIVE ==
> >>+		cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
> >>+	return ret;
> >>+}
> >>  #endif   /* NFSD4_STATE_H */
> >>-- 
> >>2.9.5
