Return-Path: <linux-fsdevel+bounces-27736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A196377E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A3CB251FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90272146A96;
	Thu, 29 Aug 2024 01:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg1LY727"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED02112FB34;
	Thu, 29 Aug 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893497; cv=none; b=pnUid8DB8Ugs4kxzMFIDxVngrc8zQQ/X5kSt00TLzzzK5gc+f/tXjOjz0s8JeHXOK3q0Rdc0IuPTYwdqYJcZf/ztBpcatGzBK1U14guqdXUifPJjz624WeLqqNdXXbtVfPIZ5jLZa/ZhZLCuM3IR6Glsbw2FufTH0GlFfmDZSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893497; c=relaxed/simple;
	bh=At7UeJPLJbhI/3DkQvxLQ39vZJVV4tHYrDtj9nRMDHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRfJQdUuQla30+kjvHs1mk8tfyvCxbPnq0qddGkosLjF/n5EnzvxbReLB0P0o259Fh9fqwGSjBZnhE0ar6Pq/ElDXeYjkm0JAKPkTH/+Ft8MLre8dE38SlaaGjDhZwbL4wXK8JwsCmpPCdPOm7yIEoJhYr/+WJRLpIwmabHumYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg1LY727; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93960C4CEC0;
	Thu, 29 Aug 2024 01:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893496;
	bh=At7UeJPLJbhI/3DkQvxLQ39vZJVV4tHYrDtj9nRMDHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fg1LY727+VdmYKgsVVAMCHr9sFS7XXaA3/d7Sf6eYiHF9cvU0CvMLEjg1YMzj2Pd+
	 ABWSTotY818dQA7BHchoCaie0zhq8zeDfVcPAz0DQtjWPkfPLXY6Fm0lEAaGpoaeid
	 G86jTpgs+yw7wRSpfZUYLuVeEWAYcZvsqmkI3HIEEfxwOfp0f/g77vrFOHEnXO4Ei0
	 ZnvhQ8BXhidJs61CZTESwoOI1WHjv9EohfVucr6cqyx5vlYggHsafxcxL4eO3L46Xs
	 JegeKP9m3GMDw8k4cbUDOmi7AekoOzZG0oti5vlE3MpbGgYaUO87vRD32SF2nnesW5
	 djds1cKhIpjsA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 23/25] nfs: implement client support for NFS_LOCALIO_PROGRAM
Date: Wed, 28 Aug 2024 21:04:18 -0400
Message-ID: <20240829010424.83693-24-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240829010424.83693-1-snitzer@kernel.org>
References: <20240829010424.83693-1-snitzer@kernel.org>
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
 fs/nfs/client.c  |   6 ++-
 fs/nfs/localio.c | 136 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index b981c519a12d..6a4b605cc943 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -434,8 +434,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
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
index fa598b99941a..40521da422f7 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -50,18 +50,77 @@ static void nfs_local_fsync_work(struct work_struct *work);
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
 	spin_lock(&clp->cl_localio_lock);
 
@@ -103,11 +162,77 @@ void nfs_local_disable(struct nfs_client *clp)
 	spin_unlock(&clp->cl_localio_lock);
 }
 
+/*
+ * nfs_init_localioclient - Initialise an NFS localio client connection
+ */
+static struct rpc_clnt *nfs_init_localioclient(struct nfs_client *clp)
+{
+	struct rpc_clnt *rpcclient_localio;
+
+	rpcclient_localio = rpc_bind_new_program(clp->cl_rpcclient,
+						 &nfslocalio_program, 1);
+
+	dprintk_rcu("%s: server (%s) %s NFS LOCALIO.\n",
+		__func__, rpc_peeraddr2str(clp->cl_rpcclient, RPC_DISPLAY_ADDR),
+		(IS_ERR(rpcclient_localio) ? "does not support" : "supports"));
+
+	return rpcclient_localio;
+}
+
+static bool nfs_server_uuid_is_local(struct nfs_client *clp,
+				     nfs_uuid_t *nfs_uuid)
+{
+	u8 uuid[UUID_SIZE];
+	struct rpc_message msg = {
+		.rpc_argp = &uuid,
+	};
+	struct rpc_clnt *rpcclient_localio;
+	int status;
+
+	rpcclient_localio = nfs_init_localioclient(clp);
+	if (IS_ERR(rpcclient_localio))
+		return false;
+
+	export_uuid(uuid, &nfs_uuid->uuid);
+
+	msg.rpc_proc = &nfs_localio_procedures[LOCALIOPROC_UUID_IS_LOCAL];
+	status = rpc_call_sync(rpcclient_localio, &msg, 0);
+	dprintk("%s: NFS reply UUID_IS_LOCAL: status=%d\n",
+		__func__, status);
+	rpc_shutdown_client(rpcclient_localio);
+
+	/* Server is only local if it initialized required struct members */
+	if (status || !nfs_uuid->net || !nfs_uuid->dom)
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
 
@@ -146,7 +271,8 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		case -ENOMEM:
 		case -ENXIO:
 		case -ENOENT:
-			nfs_local_disable(clp);
+			/* Revalidate localio, will disable if unsupported */
+			nfs_local_probe(clp);
 		}
 		return NULL;
 	}
-- 
2.44.0


