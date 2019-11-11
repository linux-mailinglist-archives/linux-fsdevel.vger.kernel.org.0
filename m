Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F2DF80E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfKKURK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:10 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35781 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKKURH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:07 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N9Mh8-1hrbux3uHE-015LNL; Mon, 11 Nov 2019 21:16:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 17/19] nfsd: use boottime for lease expiry alculation
Date:   Mon, 11 Nov 2019 21:16:37 +0100
Message-Id: <20191111201639.2240623-18-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jPdZ360zyY+5fgLUezOKUhaYVusjS3JiPnSGPwbGfHdxE8ChLyl
 QCxLepfo+Nh/rOuaNg5KTSFilvaLGm0cXqKCdEi50APYCi2fJMaDLusGbc079mnWU8ejCht
 aTKblR/tki2TmfYAqS4L09shHHFYPaVTBPER54BEdBsBStLhslI1ZNXBduyLJ97lLL1j0C6
 FTg+fYKU/cCBXKbYepnbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7UrD5xUtniU=:KU7tbX6EJjFUAHWv8yHM6z
 51R9Ejw9e2d3L/P0HTAzKenS60OGiTVvpfsVPVZHgTLNdUmNVe4D3TnuRWnkw/yE32hwD7R7/
 JzpJzqYiSZmlC5CEvHUFBmsAqm5UZjjCqQN+zTG85dy3pcwuFwoA3UXbOmComEsQydYhUlnRa
 Em5iBM+XAH3ujxQxEf18heWnUV+P4/h2KTEzw1+NVrjs1IlDyM9w/MEZglhlfOdQQWLifYoL0
 uDrniDCLXs7maMhFsigQnp59G1ixJXa2ISm3sMySLo2BMnUe/ywMZSD+CxWhuxagFROC8/3Jn
 fx+eHM6/KnIXH0bvALIfxney4fIKb5OOiKAZhUPTOLd5+8dvVLVR20CNlfjIfEsUttZIyW3fd
 gDdiqdkZQjcyHbMw1vA4O2xqF0O26rRFmSTUag2P59HepGA3MPwcFBtsbm6JmkAuzlkGarZ3f
 OjQQ1RLLLoN9zwNMP1nFyAHRKYr8e8gk4XoHIZk4FPR8XsF0kB6omBK9tHJA6E/FV8ni9Cm6B
 aHj8hJJyUvBHqUUqPatTga0ZTiDRybvzmD/o9+EBTHcxdYDTlI0inLfGcuJQoP4UdYBiEpmOr
 IHc8S74uSEdqqqrTHUH5240CULXOwJwo0KkCUxwYMBM8ndlMP9qZvFqmXHJ7pF835I1PqH+3j
 dEMRQYJ7tTSAg0yFapvPoQxIArux5afyj3sQyNTiTfNFwUirN0nOEIzDsZASPyV85h+z+SA/s
 K8xdnsULQMW4g4ElvxRQWgBf1XMqnD8wQr7wv6yIdaHT4xNChdMV3UswTsRviLK7WOGZ/fFa9
 /rMjHdjqvsDgkCe3hcmnUJl+mVyBAen4X5WQoYwHNSCVuBA5qR2DXmBLPKxmC78+y2GsfMTAu
 x8qcRzx73KyB2/a6U0Jw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A couple of time_t variables are only used to track the state of the
lease time and its expiration. The code correctly uses the 'time_after()'
macro to make this work on 32-bit architectures even beyond year 2038,
but the get_seconds() function and the time_t type itself are deprecated
as they behave inconsistently between 32-bit and 64-bit architectures
and often lead to code that is not y2038 safe.

As a minor issue, using get_seconds() leads to problems with concurrent
settimeofday() or clock_settime() calls, in the worst case timeout never
triggering after the time has been set backwards.

Change nfsd to use time64_t and ktime_get_boottime_seconds() here. This
is clearly excessive, as boottime by itself means we never go beyond 32
bits, but it does mean we handle this correctly and consistently without
having to worry about corner cases and should be no more expensive than
the previous implementation on 64-bit architectures.

The max_cb_time() function gets changed in order to avoid an expensive
64-bit division operation, but as the lease time is at most one hour,
there is no change in behavior.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/netns.h        |  4 ++--
 fs/nfsd/nfs4callback.c |  7 ++++++-
 fs/nfsd/nfs4state.c    | 41 +++++++++++++++++++----------------------
 fs/nfsd/nfsctl.c       |  6 +++---
 fs/nfsd/state.h        |  8 ++++----
 5 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 29bbe28eda53..2baf32311e00 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -92,8 +92,8 @@ struct nfsd_net {
 	bool in_grace;
 	const struct nfsd4_client_tracking_ops *client_tracking_ops;
 
-	time_t nfsd4_lease;
-	time_t nfsd4_grace;
+	time64_t nfsd4_lease;
+	time64_t nfsd4_grace;
 	bool somebody_reclaimed;
 
 	bool track_reclaim_completes;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 524111420b48..b03d6bf1b1bc 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -823,7 +823,12 @@ static const struct rpc_program cb_program = {
 static int max_cb_time(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-	return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
+
+	/* nfsd4_lease is set to at most one hour */
+	if (WARN_ON_ONCE(nn->nfsd4_lease > 3600))
+		return 360 * HZ;
+
+	return max(((u32)nn->nfsd4_lease)/10, 1u) * HZ;
 }
 
 static const struct cred *get_backchannel_cred(struct nfs4_client *clp, struct rpc_clnt *client, struct nfsd4_session *ses)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 551068f4b836..885a09b3a2c0 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -170,7 +170,7 @@ renew_client_locked(struct nfs4_client *clp)
 			clp->cl_clientid.cl_boot,
 			clp->cl_clientid.cl_id);
 	list_move_tail(&clp->cl_lru, &nn->client_lru);
-	clp->cl_time = get_seconds();
+	clp->cl_time = ktime_get_boottime_seconds();
 }
 
 static void put_client_renew_locked(struct nfs4_client *clp)
@@ -2612,7 +2612,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	gen_clid(clp, nn);
 	kref_init(&clp->cl_nfsdfs.cl_ref);
 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
-	clp->cl_time = get_seconds();
+	clp->cl_time = ktime_get_boottime_seconds();
 	clear_bit(0, &clp->cl_cb_slot_busy);
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
@@ -4277,7 +4277,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 	last = oo->oo_last_closed_stid;
 	oo->oo_last_closed_stid = s;
 	list_move_tail(&oo->oo_close_lru, &nn->close_lru);
-	oo->oo_time = get_seconds();
+	oo->oo_time = ktime_get_boottime_seconds();
 	spin_unlock(&nn->client_lock);
 	if (last)
 		nfs4_put_stid(&last->st_stid);
@@ -4372,7 +4372,7 @@ static void nfsd4_cb_recall_prepare(struct nfsd4_callback *cb)
 	 */
 	spin_lock(&state_lock);
 	if (dp->dl_time == 0) {
-		dp->dl_time = get_seconds();
+		dp->dl_time = ktime_get_boottime_seconds();
 		list_add_tail(&dp->dl_recall_lru, &nn->del_recall_lru);
 	}
 	spin_unlock(&state_lock);
@@ -5178,9 +5178,8 @@ nfsd4_end_grace(struct nfsd_net *nn)
  */
 static bool clients_still_reclaiming(struct nfsd_net *nn)
 {
-	unsigned long now = (unsigned long) ktime_get_real_seconds();
-	unsigned long double_grace_period_end = (unsigned long)nn->boot_time +
-					   2 * (unsigned long)nn->nfsd4_lease;
+	time64_t double_grace_period_end = nn->boot_time +
+					   2 * nn->nfsd4_lease;
 
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) ==
@@ -5193,12 +5192,12 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	 * If we've given them *two* lease times to reclaim, and they're
 	 * still not done, give up:
 	 */
-	if (time_after(now, double_grace_period_end))
+	if (ktime_get_boottime_seconds() > double_grace_period_end)
 		return false;
 	return true;
 }
 
-static time_t
+static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
 	struct nfs4_client *clp;
@@ -5207,8 +5206,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	struct nfs4_ol_stateid *stp;
 	struct nfsd4_blocked_lock *nbl;
 	struct list_head *pos, *next, reaplist;
-	time_t cutoff = get_seconds() - nn->nfsd4_lease;
-	time_t t, new_timeo = nn->nfsd4_lease;
+	time64_t cutoff = ktime_get_boottime_seconds() - nn->nfsd4_lease;
+	time64_t t, new_timeo = nn->nfsd4_lease;
 
 	dprintk("NFSD: laundromat service - starting\n");
 
@@ -5222,7 +5221,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-		if (time_after((unsigned long)clp->cl_time, (unsigned long)cutoff)) {
+		if (clp->cl_time > cutoff) {
 			t = clp->cl_time - cutoff;
 			new_timeo = min(new_timeo, t);
 			break;
@@ -5245,7 +5244,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		if (time_after((unsigned long)dp->dl_time, (unsigned long)cutoff)) {
+		if (dp->dl_time > cutoff) {
 			t = dp->dl_time - cutoff;
 			new_timeo = min(new_timeo, t);
 			break;
@@ -5265,8 +5264,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&nn->close_lru)) {
 		oo = list_first_entry(&nn->close_lru, struct nfs4_openowner,
 					oo_close_lru);
-		if (time_after((unsigned long)oo->oo_time,
-			       (unsigned long)cutoff)) {
+		if (oo->oo_time > cutoff) {
 			t = oo->oo_time - cutoff;
 			new_timeo = min(new_timeo, t);
 			break;
@@ -5296,8 +5294,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 	while (!list_empty(&nn->blocked_locks_lru)) {
 		nbl = list_first_entry(&nn->blocked_locks_lru,
 					struct nfsd4_blocked_lock, nbl_lru);
-		if (time_after((unsigned long)nbl->nbl_time,
-			       (unsigned long)cutoff)) {
+		if (nbl->nbl_time > cutoff) {
 			t = nbl->nbl_time - cutoff;
 			new_timeo = min(new_timeo, t);
 			break;
@@ -5314,7 +5311,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		free_blocked_lock(nbl);
 	}
 out:
-	new_timeo = max_t(time_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
+	new_timeo = max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
 	return new_timeo;
 }
 
@@ -5324,13 +5321,13 @@ static void laundromat_main(struct work_struct *);
 static void
 laundromat_main(struct work_struct *laundry)
 {
-	time_t t;
+	time64_t t;
 	struct delayed_work *dwork = to_delayed_work(laundry);
 	struct nfsd_net *nn = container_of(dwork, struct nfsd_net,
 					   laundromat_work);
 
 	t = nfs4_laundromat(nn);
-	dprintk("NFSD: laundromat_main - sleeping for %ld seconds\n", t);
+	dprintk("NFSD: laundromat_main - sleeping for %lld seconds\n", t);
 	queue_delayed_work(laundry_wq, &nn->laundromat_work, t*HZ);
 }
 
@@ -6544,7 +6541,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 
 	if (fl_flags & FL_SLEEP) {
-		nbl->nbl_time = get_seconds();
+		nbl->nbl_time = ktime_get_boottime_seconds();
 		spin_lock(&nn->blocked_locks_lock);
 		list_add_tail(&nbl->nbl_list, &lock_sop->lo_blocked);
 		list_add_tail(&nbl->nbl_lru, &nn->blocked_locks_lru);
@@ -7704,7 +7701,7 @@ nfs4_state_start_net(struct net *net)
 	nfsd4_client_tracking_init(net);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
 		goto skip_grace;
-	printk(KERN_INFO "NFSD: starting %ld-second grace period (net %x)\n",
+	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
 	       nn->nfsd4_grace, net->ns.inum);
 	queue_delayed_work(laundry_wq, &nn->laundromat_work, nn->nfsd4_grace * HZ);
 	return 0;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 11b42c523f04..aace740d5a92 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -956,7 +956,7 @@ static ssize_t write_maxconn(struct file *file, char *buf, size_t size)
 
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
-				  time_t *time, struct nfsd_net *nn)
+				  time64_t *time, struct nfsd_net *nn)
 {
 	char *mesg = buf;
 	int rv, i;
@@ -984,11 +984,11 @@ static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 		*time = i;
 	}
 
-	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%ld\n", *time);
+	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%lld\n", *time);
 }
 
 static ssize_t nfsd4_write_time(struct file *file, char *buf, size_t size,
-				time_t *time, struct nfsd_net *nn)
+				time64_t *time, struct nfsd_net *nn)
 {
 	ssize_t rv;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index c1bb6a5ecf57..e5795aad0404 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -132,7 +132,7 @@ struct nfs4_delegation {
 	struct list_head	dl_recall_lru;  /* delegation recalled */
 	struct nfs4_clnt_odstate *dl_clnt_odstate;
 	u32			dl_type;
-	time_t			dl_time;
+	time64_t		dl_time;
 /* For recall: */
 	int			dl_retries;
 	struct nfsd4_callback	dl_recall;
@@ -310,7 +310,7 @@ struct nfs4_client {
 #endif
 	struct xdr_netobj	cl_name; 	/* id generated by client */
 	nfs4_verifier		cl_verifier; 	/* generated by client */
-	time_t                  cl_time;        /* time of last lease renewal */
+	time64_t		cl_time;	/* time of last lease renewal */
 	struct sockaddr_storage	cl_addr; 	/* client ipaddress */
 	bool			cl_mach_cred;	/* SP4_MACH_CRED in force */
 	struct svc_cred		cl_cred; 	/* setclientid principal */
@@ -448,7 +448,7 @@ struct nfs4_openowner {
 	 */
 	struct list_head	oo_close_lru;
 	struct nfs4_ol_stateid *oo_last_closed_stid;
-	time_t			oo_time; /* time of placement on so_close_lru */
+	time64_t		oo_time; /* time of placement on so_close_lru */
 #define NFS4_OO_CONFIRMED   1
 	unsigned char		oo_flags;
 };
@@ -605,7 +605,7 @@ static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
 struct nfsd4_blocked_lock {
 	struct list_head	nbl_list;
 	struct list_head	nbl_lru;
-	time_t			nbl_time;
+	time64_t		nbl_time;
 	struct file_lock	nbl_lock;
 	struct knfsd_fh		nbl_fh;
 	struct nfsd4_callback	nbl_cb;
-- 
2.20.0

