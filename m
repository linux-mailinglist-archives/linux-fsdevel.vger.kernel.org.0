Return-Path: <linux-fsdevel+bounces-62644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127FB9B567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84DC33A7BB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DF32B48D;
	Wed, 24 Sep 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipqpOk3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0932BBEC;
	Wed, 24 Sep 2025 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737265; cv=none; b=aq7VNkVDLAe5Awza8/6UJ9zqZDqtp8DxnzwFaYjywFnV4P/4zPmUm6fULQBreA50gdfDgwQKBuPeguYw/NYM/wzGcz7kvo5trWgfOnl4dII69Anl8mVd2bASU5EKFPLr6ExSBg24HtmkZ8b5lzfGYhOp6spFzRnWrHrAHjsdZTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737265; c=relaxed/simple;
	bh=4LbIjHiizIoCjXde5k1u0X78BN+3e7XWxxwSYd6ggUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iz0VIMgXdF/IEOxtHVgP/FknH9U4P37Nb7fInu+x49aehePs5lIqUtqPrY7RMKSakZ2pr7/4nxEYxoJXTVLxg+IRElgzu+zJpSXpHbzrUVDGT6LDLdi0kUBh2o2l3a1PIsqm0CWwFtMmtWqq4F0ai0rn+yAa9a2kTcrP7GB+ftY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipqpOk3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBEAC4CEE7;
	Wed, 24 Sep 2025 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737265;
	bh=4LbIjHiizIoCjXde5k1u0X78BN+3e7XWxxwSYd6ggUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ipqpOk3pMFdELv3GAMLdnZ85qMli9RuOKu/cZby4kPHx0OgnyA5UiNbHkx5JiZJCe
	 I4a+5IAPaD5vZiUwHRSDHCiBCltBicQSroj/VpoOxa+53njfzoA3ObUOXTuFZJ4LLm
	 XEXNFDv5n75O0JoyEppqEUFczqYbAN3pRDEHdsHNKAX1i7zZ0koPtJWc8lHQKhyHRt
	 Sdh0KB9jX4xlaRQnY3SyzzL4ceHIhneX1IVcI0A1p2Y/2qOQSZax43PnM+SvfaSQDq
	 GLD10nSFEd5078HKMVVVxOoULNmT+QJbJp3AGvDODMaMJe8a9PfmQOWoEzgfQx4RKx
	 52u0fZe4tF/ZQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:12 -0400
Subject: [PATCH v3 26/38] nfsd: add data structures for handling CB_NOTIFY
 to directory delegation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-26-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8673; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4LbIjHiizIoCjXde5k1u0X78BN+3e7XWxxwSYd6ggUQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMQy3ZA9SJmXZqe1a9W8F8mHfEDoNMHtRJZJ
 R86RvTKPd+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzEAAKCRAADmhBGVaC
 FYYeEACKG14Jff/pc33y6wFkdp5iUB5x6t4TlzU0mpvBiDt7ksXXWHnD6898MLGKECapN5+0bbt
 qz8HRbjzsjlLESpk/O9wNNuuPg9AEfnnHwLygfjixodru/sAxo3KaEGdXA2e3/WVc/RHm2dEg5a
 GbpImGdQZkVcy5Skv/6qMwAf6zBkuSBua0yCBp3tKlnOvid5eRV2n796HXsYEjw1RuKWU5Af0hQ
 f5l4cRvmHvWHvZwtm6n99lIx/AsuYDxXxdu0Fl1jK6/UriHldBXQQwADzs9fpR8W8ojODd2r4nP
 FvMvzRlU0VvmO1WrO0xjYRnaFayFo51bIMXCTw1+cF4lqLoi/oqExqJWr/jsbLJ5nI1jLEABBib
 5PVklzuBNFOTLiDG4vWf7xEJqUW5KIG1qqgXPI/roepJN+zXmpX6NZkj4ppeDHYoi6RUnFuYHV6
 W/1n+qqR1jxgipN1LP6VopLefxPYOABGVLBxZLEuqgHWYUBd2hh20y2SED9S+rh9Kl8foL7XiiN
 YXN4pLDctncKpmJuDsJW+ZOLm7KKB596hAAroaFmwu040vSSVFoSJg1pwnhVOAl56xSgDOHU0FS
 WDhrObMfCQxoUms6aPcc1azXZt9Veh07PGsmd1PSOPl5LHsWP0d03FjlWVlMnIuXShyOdkE1ajY
 EQGv3Lb6cqZhpPg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When a directory delegation is created, have it allocate the necessary
data structures to collect events and run a CB_NOTIFY callback. For now,
the callback_ops are still skeletal. They'll be fleshed out in a
subsequent patch.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 119 +++++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/state.h     |  46 +++++++++++++++++++-
 2 files changed, 149 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 517ba5595da3be5e130e1978ba30235496efbe01..5d3af33e70e26e59f8bc3d5b44c82beafb4f786b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -130,6 +130,7 @@ static void free_session(struct nfsd4_session *);
 static const struct nfsd4_callback_ops nfsd4_cb_recall_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_notify_lock_ops;
 static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops;
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops;
 
 static struct workqueue_struct *laundry_wq;
 
@@ -1127,29 +1128,31 @@ static void block_delegations(struct knfsd_fh *fh)
 }
 
 static struct nfs4_delegation *
-alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
-		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
+__alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
+		   struct nfs4_clnt_odstate *odstate, u32 dl_type,
+		   void (*sc_free)(struct nfs4_stid *))
 {
 	struct nfs4_delegation *dp;
 	struct nfs4_stid *stid;
 	long n;
 
-	dprintk("NFSD alloc_init_deleg\n");
+	if (delegation_blocked(&fp->fi_fhandle))
+		return NULL;
+
 	n = atomic_long_inc_return(&num_delegations);
 	if (n < 0 || n > max_delegations)
 		goto out_dec;
-	if (delegation_blocked(&fp->fi_fhandle))
-		goto out_dec;
-	stid = nfs4_alloc_stid(clp, deleg_slab, nfs4_free_deleg);
+
+	stid = nfs4_alloc_stid(clp, deleg_slab, sc_free);
 	if (stid == NULL)
 		goto out_dec;
-	dp = delegstateid(stid);
 
 	/*
 	 * delegation seqid's are never incremented.  The 4.1 special
 	 * meaning of seqid 0 isn't meaningful, really, but let's avoid
-	 * 0 anyway just for consistency and use 1:
+	 * 0 anyway just for consistency and use 1.
 	 */
+	dp = delegstateid(stid);
 	dp->dl_stid.sc_stateid.si_generation = 1;
 	INIT_LIST_HEAD(&dp->dl_perfile);
 	INIT_LIST_HEAD(&dp->dl_perclnt);
@@ -1159,19 +1162,77 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	dp->dl_type = dl_type;
 	dp->dl_retries = 1;
 	dp->dl_recalled = false;
-	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
-		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
-	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
-			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
-	dp->dl_cb_fattr.ncf_file_modified = false;
 	get_nfs4_file(fp);
 	dp->dl_stid.sc_file = fp;
+	nfsd4_init_cb(&dp->dl_recall, dp->dl_stid.sc_client,
+		      &nfsd4_cb_recall_ops, NFSPROC4_CLNT_CB_RECALL);
 	return dp;
 out_dec:
 	atomic_long_dec(&num_delegations);
 	return NULL;
 }
 
+static struct nfs4_delegation *
+alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
+		 struct nfs4_clnt_odstate *odstate, u32 dl_type)
+{
+	struct nfs4_delegation *dp;
+
+	dprintk("NFSD alloc_init_deleg\n");
+	dp = __alloc_init_deleg(clp, fp, odstate, dl_type, nfs4_free_deleg);
+	if (!dp)
+		return NULL;
+
+	nfsd4_init_cb(&dp->dl_cb_fattr.ncf_getattr, dp->dl_stid.sc_client,
+			&nfsd4_cb_getattr_ops, NFSPROC4_CLNT_CB_GETATTR);
+	dp->dl_cb_fattr.ncf_file_modified = false;
+	return dp;
+}
+
+static void nfs4_free_dir_deleg(struct nfs4_stid *stid)
+{
+	struct nfs4_delegation	*dp = delegstateid(stid);
+	struct nfsd4_cb_notify *ncn = &dp->dl_cb_notify;
+	int i;
+
+	for (i = 0; i < ncn->ncn_evt_cnt; ++i)
+		nfsd_notify_event_put(ncn->ncn_evt[i]);
+	release_pages(ncn->ncn_pages, NOTIFY4_PAGE_ARRAY_SIZE);
+	kfree(ncn->ncn_nf);
+	nfs4_free_deleg(stid);
+}
+
+static struct nfs4_delegation *
+alloc_init_dir_deleg(struct nfs4_client *clp, struct nfs4_file *fp)
+{
+	struct nfs4_delegation *dp;
+	struct nfsd4_cb_notify *ncn;
+	int npages;
+
+	dp = __alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ, nfs4_free_dir_deleg);
+	if (!dp)
+		return NULL;
+
+	ncn = &dp->dl_cb_notify;
+
+	npages = alloc_pages_bulk(GFP_KERNEL, NOTIFY4_PAGE_ARRAY_SIZE, ncn->ncn_pages);
+	if (npages != NOTIFY4_PAGE_ARRAY_SIZE) {
+		release_pages(ncn->ncn_pages, npages);
+		nfs4_free_dir_deleg(&dp->dl_stid);
+	}
+
+	ncn->ncn_nf = kcalloc(NOTIFY4_EVENT_QUEUE_SIZE, sizeof(*ncn->ncn_nf), GFP_KERNEL);
+	if (!ncn->ncn_nf) {
+		release_pages(ncn->ncn_pages, npages);
+		nfs4_free_dir_deleg(&dp->dl_stid);
+		return NULL;
+	}
+	spin_lock_init(&ncn->ncn_lock);
+	nfsd4_init_cb(&ncn->ncn_cb, dp->dl_stid.sc_client,
+			&nfsd4_cb_notify_ops, NFSPROC4_CLNT_CB_NOTIFY);
+	return dp;
+}
+
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
@@ -3272,6 +3333,30 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
+static int
+nfsd4_cb_notify_done(struct nfsd4_callback *cb,
+				struct rpc_task *task)
+{
+	switch (task->tk_status) {
+	case -NFS4ERR_DELAY:
+		rpc_delay(task, 2 * HZ);
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static void
+nfsd4_cb_notify_release(struct nfsd4_callback *cb)
+{
+	struct nfsd4_cb_notify *ncn =
+			container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp =
+			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
+	nfs4_put_stid(&dp->dl_stid);
+}
+
 static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
 	.done		= nfsd4_cb_recall_any_done,
 	.release	= nfsd4_cb_recall_any_release,
@@ -3284,6 +3369,12 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 	.opcode		= OP_CB_GETATTR,
 };
 
+static const struct nfsd4_callback_ops nfsd4_cb_notify_ops = {
+	.done		= nfsd4_cb_notify_done,
+	.release	= nfsd4_cb_notify_release,
+	.opcode		= OP_CB_NOTIFY,
+};
+
 static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 {
 	struct nfs4_delegation *dp =
@@ -9514,7 +9605,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	/* Try to set up the lease */
 	status = -ENOMEM;
-	dp = alloc_init_deleg(clp, fp, NULL, NFS4_OPEN_DELEGATE_READ);
+	dp = alloc_init_dir_deleg(clp, fp);
 	if (!dp)
 		goto out_delegees;
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 596d0bbf868c0ca2a31fa20f3ac61db66b60636d..507ce4c097c8b601eecb040876412fc2fe3033b2 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -196,6 +196,44 @@ struct nfs4_cb_fattr {
 #define NOTIFY4_EVENT_QUEUE_SIZE	3
 #define NOTIFY4_PAGE_ARRAY_SIZE		1
 
+struct nfsd_notify_event {
+	refcount_t	ne_ref;		// refcount
+	u32		ne_mask;	// FS_* mask from fsnotify callback
+	struct dentry	*ne_dentry;	// dentry reference to target
+	u32		ne_namelen;	// length of ne_name
+	char		ne_name[];	// name of dentry being changed
+};
+
+static inline struct nfsd_notify_event *nfsd_notify_event_get(struct nfsd_notify_event *ne)
+{
+	refcount_inc(&ne->ne_ref);
+	return ne;
+}
+
+static inline void nfsd_notify_event_put(struct nfsd_notify_event *ne)
+{
+	if (refcount_dec_and_test(&ne->ne_ref)) {
+		dput(ne->ne_dentry);
+		kfree(ne);
+	}
+}
+
+/*
+ * Represents a directory delegation. The callback is for handling CB_NOTIFYs.
+ * As notifications from fsnotify come in, allocate a new event, take the ncn_lock,
+ * and add it to the ncn_evt queue. The CB_NOTIFY prepare handler will take the
+ * lock, clean out the list and process it.
+ */
+struct nfsd4_cb_notify {
+	spinlock_t			ncn_lock;	// protects the evt queue and count
+	int				ncn_evt_cnt;	// count of events in ncn_evt
+	int				ncn_nf_cnt;	// count of valid entries in ncn_nf
+	struct nfsd_notify_event	*ncn_evt[NOTIFY4_EVENT_QUEUE_SIZE]; // list of events
+	struct page			*ncn_pages[NOTIFY4_PAGE_ARRAY_SIZE]; // for encoding
+	struct notify4			*ncn_nf;	// array of notify4's to be sent
+	struct nfsd4_callback		ncn_cb;		// notify4 callback
+};
+
 /*
  * Represents a delegation stateid. The nfs4_client holds references to these
  * and they are put when it is being destroyed or when the delegation is
@@ -232,8 +270,12 @@ struct nfs4_delegation {
 	bool			dl_written;
 	bool			dl_setattr;
 
-	/* for CB_GETATTR */
-	struct nfs4_cb_fattr    dl_cb_fattr;
+	union {
+		/* for CB_GETATTR */
+		struct nfs4_cb_fattr    dl_cb_fattr;
+		/* for CB_NOTIFY */
+		struct nfsd4_cb_notify	dl_cb_notify;
+	};
 
 	/* For delegated timestamps */
 	struct timespec64	dl_atime;

-- 
2.51.0


