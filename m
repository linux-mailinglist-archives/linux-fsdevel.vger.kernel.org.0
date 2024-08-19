Return-Path: <linux-fsdevel+bounces-26304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5F9572EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961391C23800
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D3218951A;
	Mon, 19 Aug 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdIuloAj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB24A1891AA;
	Mon, 19 Aug 2024 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091496; cv=none; b=O6W7hOpXyWDxsltNjGLprxsFfx/xKA6Sl1RhRs4MVMSd0cvV/ilrh3z7FjNMq0r/NDArKgD0fx9dHacqJlrWpfSNnYUVlrIGAsMh+9jKLcqgqjxSMEeGJsXNq/zhyhMYV/0XgQCrDfw0qAcq3/aH6gknYyedpDgfPmUdhpGBUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091496; c=relaxed/simple;
	bh=/LG+TpnVRcF6fC5u5Yfvpk8uvSQHIdBNkEEBnydrU2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAOK8IUcw0jsQSa4TuRcXL1xaTB+NsrrOiArN5kZcH0lRjhX+pfqQ7oyh8zxnzXpF2TbQvfj720B6NmbVdOiZOL+/SUDkBWuY/i247s9ydi22g2ENAZh8A2KNd1/xjAgAFL37WGSHt22ZyEKbZ19T6ERnHLyrqg+qc1PFQ+ky3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdIuloAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759A4C4AF0F;
	Mon, 19 Aug 2024 18:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091496;
	bh=/LG+TpnVRcF6fC5u5Yfvpk8uvSQHIdBNkEEBnydrU2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdIuloAjjom0bkC7BS7RoaTf6sKmgybMTRVjYjRAclAJJoRjV5vOftKM4hVR2Ijcn
	 KtewRMwZZHXutj4puh72q1OtfHaT+atTgR6JbDlihJkUCdvSnsb2cotNpsDx7ZcoRK
	 tvVxo4rhp+GwLMMC/B1myd1LX/5ehS23ZSOY1x5dJefb7UIZE0MQL/52EjigURIgLq
	 1ja5GN96jk1BIJ/4gmHI6GyPGA37WMKb4n10VUM+E2LFXKDw58lk6Uv7tHyjzYFp3C
	 RZJpM8oHGe0dftxK3Tznp/kAHWEK9kdowuZpaP0uItvhbwbvNMc9pWQIRN8SrZglqG
	 CtrtcAJYH5vsw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 18/24] nfs: implement client support for NFS_LOCALIO_PROGRAM
Date: Mon, 19 Aug 2024 14:17:23 -0400
Message-ID: <20240819181750.70570-19-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819181750.70570-1-snitzer@kernel.org>
References: <20240819181750.70570-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LOCALIO auxiliary RPC protocol consists of a single "UUID_IS_LOCAL"
RPC method that allows the Linux NFS client to verify the local Linux
NFS server can see the nonce (single-use UUID) the client generated and
made available in nfs_common for subsequent lookup and verification
by the NFS server.  If matched, the NFS server populates members in the
nfs_uuid_t struct.  The NFS client then transfers these nfs_uuid_t
struct member pointers to the nfs_client struct and cleans up the
nfs_uuid_t struct.  See: fs/nfs/localio.c:nfs_local_probe()

This protocol isn't part of an IETF standard, nor does it need to be
considering it is Linux-to-Linux auxiliary RPC protocol that amounts
to an implementation detail.

Localio is only supported when UNIX-style authentication (AUTH_UNIX, aka
AUTH_SYS) is used (enforced by fs/nfs/localio.c:nfs_local_probe()).

The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
XDR methods are used instead of the less efficient variable sized
methods.

Having a nonce (single-use uuid) is better than using the same uuid
for the life of the server, and sending it proactively by client
rather than reactively by the server is also safer.

[NeilBrown factored out and simplified a single localio protocol and
proposed making the uuid short-lived]

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/client.c  |   6 +-
 fs/nfs/localio.c | 148 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index bf327ddbdd25..23fe1611cc9f 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -435,8 +435,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
 			list_add_tail(&new->cl_share_link,
 					&nn->nfs_client_list);
 			spin_unlock(&nn->nfs_client_lock);
-			nfs_local_probe(new);
-			return rpc_ops->init_client(new, cl_init);
+			new = rpc_ops->init_client(new, cl_init);
+			if (!IS_ERR(new))
+				 nfs_local_probe(new);
+			return new;
 		}
 
 		spin_unlock(&nn->nfs_client_lock);
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2d3118005afc..f5ecbd9fefb6 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -49,18 +49,77 @@ static void nfs_local_fsync_work(struct work_struct *work);
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static inline bool nfs_client_is_local(const struct nfs_client *clp)
+{
+	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
+}
+
 bool nfs_server_is_local(const struct nfs_client *clp)
 {
-	return test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags) != 0 &&
-		localio_enabled;
+	return nfs_client_is_local(clp) && localio_enabled;
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+/*
+ * UUID_IS_LOCAL XDR functions
+ */
+
+static void localio_xdr_enc_uuidargs(struct rpc_rqst *req,
+				     struct xdr_stream *xdr,
+				     const void *data)
+{
+	const u8 *uuid = data;
+
+	encode_opaque_fixed(xdr, uuid, UUID_SIZE);
+}
+
+static int localio_xdr_dec_uuidres(struct rpc_rqst *req,
+				   struct xdr_stream *xdr,
+				   void *result)
+{
+	/* void return */
+	return 0;
+}
+
+static const struct rpc_procinfo nfs_localio_procedures[] = {
+	[LOCALIOPROC_UUID_IS_LOCAL] = {
+		.p_proc = LOCALIOPROC_UUID_IS_LOCAL,
+		.p_encode = localio_xdr_enc_uuidargs,
+		.p_decode = localio_xdr_dec_uuidres,
+		.p_arglen = XDR_QUADLEN(UUID_SIZE),
+		.p_replen = 0,
+		.p_statidx = LOCALIOPROC_UUID_IS_LOCAL,
+		.p_name = "UUID_IS_LOCAL",
+	},
+};
+
+static unsigned int nfs_localio_counts[ARRAY_SIZE(nfs_localio_procedures)];
+static const struct rpc_version nfslocalio_version1 = {
+	.number			= 1,
+	.nrprocs		= ARRAY_SIZE(nfs_localio_procedures),
+	.procs			= nfs_localio_procedures,
+	.counts			= nfs_localio_counts,
+};
+
+static const struct rpc_version *nfslocalio_version[] = {
+       [1]			= &nfslocalio_version1,
+};
+
+extern const struct rpc_program nfslocalio_program;
+static struct rpc_stat		nfslocalio_rpcstat = { &nfslocalio_program };
+
+const struct rpc_program nfslocalio_program = {
+	.name			= "nfslocalio",
+	.number			= NFS_LOCALIO_PROGRAM,
+	.nrvers			= ARRAY_SIZE(nfslocalio_version),
+	.version		= nfslocalio_version,
+	.stats			= &nfslocalio_rpcstat,
+};
+
 /*
  * nfs_local_enable - enable local i/o for an nfs_client
  */
-static __maybe_unused void nfs_local_enable(struct nfs_client *clp,
-					    nfs_uuid_t *nfs_uuid)
+static void nfs_local_enable(struct nfs_client *clp, nfs_uuid_t *nfs_uuid)
 {
 	if (READ_ONCE(clp->nfsd_open_local_fh)) {
 		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
@@ -77,6 +136,12 @@ void nfs_local_disable(struct nfs_client *clp)
 {
 	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
 		trace_nfs_local_disable(clp);
+		put_nfsd_open_local_fh();
+		clp->nfsd_open_local_fh = NULL;
+		if (!IS_ERR(clp->cl_rpcclient_localio)) {
+			rpc_shutdown_client(clp->cl_rpcclient_localio);
+			clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+		}
 		clp->cl_nfssvc_net = NULL;
 		if (clp->cl_nfssvc_dom) {
 			auth_domain_put(clp->cl_nfssvc_dom);
@@ -85,11 +150,83 @@ void nfs_local_disable(struct nfs_client *clp)
 	}
 }
 
+/*
+ * nfs_init_localioclient - Initialise an NFS localio client connection
+ */
+static void nfs_init_localioclient(struct nfs_client *clp)
+{
+	if (unlikely(!IS_ERR(clp->cl_rpcclient_localio)))
+		goto out;
+	clp->cl_rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
+							 &nfslocalio_program, 1);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		goto out;
+	/* No errors! Assume that localio is supported */
+	clp->nfsd_open_local_fh = get_nfsd_open_local_fh();
+	if (!clp->nfsd_open_local_fh) {
+		rpc_shutdown_client(clp->cl_rpcclient_localio);
+		clp->cl_rpcclient_localio = ERR_PTR(-EINVAL);
+	}
+out:
+	dprintk_rcu("%s: server (%s) %s NFS LOCALIO, nfsd_open_local_fh is %s.\n",
+		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
+		(IS_ERR(clp->cl_rpcclient_localio) ? "does not support" : "supports"),
+		(clp->nfsd_open_local_fh ? "set" : "not set"));
+}
+
+static bool nfs_server_uuid_is_local(struct nfs_client *clp, nfs_uuid_t *nfs_uuid)
+{
+	u8 uuid[UUID_SIZE];
+	struct rpc_message msg = {
+		.rpc_argp = &uuid,
+	};
+	int status;
+
+	nfs_init_localioclient(clp);
+	if (IS_ERR(clp->cl_rpcclient_localio))
+		return false;
+
+	export_uuid(uuid, &nfs_uuid->uuid);
+
+	msg.rpc_proc = &nfs_localio_procedures[LOCALIOPROC_UUID_IS_LOCAL];
+	status = rpc_call_sync(clp->cl_rpcclient_localio, &msg, 0);
+	dprintk("%s: NFS reply UUID_IS_LOCAL: status=%d\n",
+		__func__, status);
+	if (status)
+		return false;
+
+	/* Server is only local if it initialized required struct members */
+	if (!nfs_uuid->net || !nfs_uuid->dom)
+		return false;
+
+	return true;
+}
+
 /*
  * nfs_local_probe - probe local i/o support for an nfs_server and nfs_client
+ * - called after alloc_client and init_client (so cl_rpcclient exists)
+ * - this function is idempotent, it can be called for old or new clients
  */
 void nfs_local_probe(struct nfs_client *clp)
 {
+	nfs_uuid_t nfs_uuid;
+
+	/* Disallow localio if disabled via sysfs or AUTH_SYS isn't used */
+	if (!localio_enabled ||
+	    clp->cl_rpcclient->cl_auth->au_flavor != RPC_AUTH_UNIX) {
+		nfs_local_disable(clp);
+		return;
+	}
+
+	if (nfs_client_is_local(clp)) {
+		/* If already enabled, disable and re-enable */
+		nfs_local_disable(clp);
+	}
+
+	nfs_uuid_begin(&nfs_uuid);
+	if (nfs_server_uuid_is_local(clp, &nfs_uuid))
+		nfs_local_enable(clp, &nfs_uuid);
+	nfs_uuid_end(&nfs_uuid);
 }
 EXPORT_SYMBOL_GPL(nfs_local_probe);
 
@@ -115,7 +252,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		switch (status) {
 		case -ENXIO:
 		case -ENOENT:
-			nfs_local_disable(clp);
+			/* Revalidate localio, will disable if unsupported */
+			nfs_local_probe(clp);
 			fallthrough;
 		case -ETIMEDOUT:
 			status = -EAGAIN;
-- 
2.44.0


