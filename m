Return-Path: <linux-fsdevel+bounces-26298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761E29572E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8A88B23C15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 18:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591118A6BD;
	Mon, 19 Aug 2024 18:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/KxWCMV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B018A6B1;
	Mon, 19 Aug 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091488; cv=none; b=FM4eIriLrEof13O2cnKXQ7CzB+GpHGiPwxf2K1tY4YQz6s3a171GR9NcQ2YaiWImcbtDgeen9fuUfjcweKsr2lkU5pYe+8SJDuJRsx80dhyB/RnbQIoTyluI1BWn91v0BsigLG9u9ZvH0lxqSGCk/i5sOc/dJWAVllob1nZvC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091488; c=relaxed/simple;
	bh=fPNnu7rXiFKKBDYztnr9NYqJxRzJ8ba5+z98D9s97sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sarDuejDYqTKI7oYZ4ZIieXJ4MUcBHiwFEMxy3wqE/KqAHHfM4em/gqecIISSnkwIFphvsurw+PlsnYC7MA+RErs37PUjoVEJeqqnwvxuLPy+9+UAE0Fd0IBoKevHUkj3JEbmv/2eYYbLHHMoyLus8cPU9POozdGoC9M5rUsNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/KxWCMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42227C4AF0F;
	Mon, 19 Aug 2024 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724091488;
	bh=fPNnu7rXiFKKBDYztnr9NYqJxRzJ8ba5+z98D9s97sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/KxWCMVnbYyXzZLNBXtyHxz0UpsL3zjirSX3krSxtf0LS3jAGEnm3ejG2TZG9kfk
	 Z2/8sow+UcvtKZqY8IKALEo/CAclxAISHxzorIhx9kpCBTNdasQBEZV74XTdp0r/lL
	 oo7H5xrGIJc7PAuzs0TOwDxvAO9O1Csx8ABPSJ/e8XTa1zu0hyJaedqCF99NzMYjbg
	 G5g/ihssw4XZziLrh2BHu+7b9MBUtQLyG20Gyrk4sW4tmhqnlUFljhqEbZp9ddOgQu
	 kupHSdu69QmcpaqXdnIdcZFywS9bDuPVId3QEphaYXuuydLji4mrPys61vMnxM0heo
	 ytJWRy2laPJRA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 12/24] SUNRPC: replace program list with program array
Date: Mon, 19 Aug 2024 14:17:17 -0400
Message-ID: <20240819181750.70570-13-snitzer@kernel.org>
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

From: NeilBrown <neil@brown.name>

A service created with svc_create_pooled() can be given a linked list of
programs and all of these will be served.

Using a linked list makes it cumbersome when there are several programs
that can be optionally selected with CONFIG settings.

After this patch is applied, API consumers must use only
svc_create_pooled() when creating an RPC service that listens for more
than one RPC program.

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/nfsctl.c           |  2 +-
 fs/nfsd/nfsd.h             |  2 +-
 fs/nfsd/nfssvc.c           | 67 +++++++++++++++++--------------------
 include/linux/sunrpc/svc.h |  7 ++--
 net/sunrpc/svc.c           | 68 ++++++++++++++++++++++----------------
 net/sunrpc/svc_xprt.c      |  2 +-
 net/sunrpc/svcauth_unix.c  |  3 +-
 7 files changed, 79 insertions(+), 72 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1c9e5b4bcb0a..64c1b4d649bc 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2246,7 +2246,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	if (retval)
 		goto out_repcache_error;
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
-	nn->nfsd_svcstats.program = &nfsd_program;
+	nn->nfsd_svcstats.program = &nfsd_programs[0];
 	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
 		nn->nfsd_versions[i] = nfsd_support_version(i);
 	for (i = 0; i < sizeof(nn->nfsd4_minorversions); i++)
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index f87a359d968f..232a873dc53a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -85,7 +85,7 @@ struct nfsd_genl_rqstp {
 	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
 };
 
-extern struct svc_program	nfsd_program;
+extern struct svc_program	nfsd_programs[];
 extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
 extern struct mutex		nfsd_mutex;
 extern spinlock_t		nfsd_drc_lock;
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 1bec3a53e35f..5f8680ab1013 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -35,7 +35,6 @@
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
 atomic_t			nfsd_th_cnt = ATOMIC_INIT(0);
-extern struct svc_program	nfsd_program;
 static int			nfsd(void *vrqstp);
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static int			nfsd_acl_rpcbind_set(struct net *,
@@ -87,16 +86,6 @@ static const struct svc_version *localio_versions[] = {
 
 #define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
 
-static struct svc_program	nfsd_localio_program = {
-	.pg_prog		= NFS_LOCALIO_PROGRAM,
-	.pg_nvers		= NFSD_LOCALIO_NRVERS,
-	.pg_vers		= localio_versions,
-	.pg_name		= "nfslocalio",
-	.pg_class		= "nfsd",
-	.pg_authenticate	= &svc_set_client,
-	.pg_init_request	= svc_generic_init_request,
-	.pg_rpcbind_set		= svc_generic_rpcbind_set,
-};
 #endif /* CONFIG_NFSD_LOCALIO */
 
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
@@ -109,23 +98,9 @@ static const struct svc_version *nfsd_acl_version[] = {
 # endif
 };
 
-#define NFSD_ACL_MINVERS            2
+#define NFSD_ACL_MINVERS	2
 #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
 
-static struct svc_program	nfsd_acl_program = {
-#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
-	.pg_next		= &nfsd_localio_program,
-#endif /* CONFIG_NFSD_LOCALIO */
-	.pg_prog		= NFS_ACL_PROGRAM,
-	.pg_nvers		= NFSD_ACL_NRVERS,
-	.pg_vers		= nfsd_acl_version,
-	.pg_name		= "nfsacl",
-	.pg_class		= "nfsd",
-	.pg_authenticate	= &svc_set_client,
-	.pg_init_request	= nfsd_acl_init_request,
-	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
-};
-
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
 
 static const struct svc_version *nfsd_version[NFSD_MAXVERS+1] = {
@@ -138,22 +113,41 @@ static const struct svc_version *nfsd_version[NFSD_MAXVERS+1] = {
 #endif
 };
 
-struct svc_program		nfsd_program = {
-#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
-	.pg_next		= &nfsd_acl_program,
-#else
-#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
-	.pg_next		= &nfsd_localio_program,
-#endif /* CONFIG_NFSD_LOCALIO */
-#endif
+struct svc_program		nfsd_programs[] = {
+	{
 	.pg_prog		= NFS_PROGRAM,		/* program number */
 	.pg_nvers		= NFSD_MAXVERS+1,	/* nr of entries in nfsd_version */
 	.pg_vers		= nfsd_version,		/* version table */
 	.pg_name		= "nfsd",		/* program name */
 	.pg_class		= "nfsd",		/* authentication class */
-	.pg_authenticate	= &svc_set_client,	/* export authentication */
+	.pg_authenticate	= svc_set_client,	/* export authentication */
 	.pg_init_request	= nfsd_init_request,
 	.pg_rpcbind_set		= nfsd_rpcbind_set,
+	},
+#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
+	{
+	.pg_prog		= NFS_ACL_PROGRAM,
+	.pg_nvers		= NFSD_ACL_NRVERS,
+	.pg_vers		= nfsd_acl_version,
+	.pg_name		= "nfsacl",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= svc_set_client,
+	.pg_init_request	= nfsd_acl_init_request,
+	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
+	},
+#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+	{
+	.pg_prog		= NFS_LOCALIO_PROGRAM,
+	.pg_nvers		= NFSD_LOCALIO_NRVERS,
+	.pg_vers		= localio_versions,
+	.pg_name		= "nfslocalio",
+	.pg_class		= "nfsd",
+	.pg_authenticate	= svc_set_client,
+	.pg_init_request	= svc_generic_init_request,
+	.pg_rpcbind_set		= svc_generic_rpcbind_set,
+	}
+#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
 };
 
 bool nfsd_support_version(int vers)
@@ -663,7 +657,8 @@ int nfsd_create_serv(struct net *net)
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
-	serv = svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
+	serv = svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
+				 &nn->nfsd_svcstats,
 				 nfsd_max_blksize, nfsd);
 	if (serv == NULL)
 		return -ENOMEM;
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 437672bcaa22..c7ad2fb2a155 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -67,9 +67,10 @@ enum {
  * We currently do not support more than one RPC program per daemon.
  */
 struct svc_serv {
-	struct svc_program *	sv_program;	/* RPC program */
+	struct svc_program *	sv_programs;	/* RPC programs */
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
+	unsigned int		sv_nprogs;	/* Number of sv_programs */
 	unsigned int		sv_nrthreads;	/* # of server threads */
 	unsigned int		sv_maxconn;	/* max connections allowed or
 						 * '0' causing max to be based
@@ -357,10 +358,9 @@ struct svc_process_info {
 };
 
 /*
- * List of RPC programs on the same transport endpoint
+ * RPC program - an array of these can use the same transport endpoint
  */
 struct svc_program {
-	struct svc_program *	pg_next;	/* other programs (same xprt) */
 	u32			pg_prog;	/* program number */
 	unsigned int		pg_lovers;	/* lowest version */
 	unsigned int		pg_hivers;	/* highest version */
@@ -438,6 +438,7 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
 void		   svc_exit_thread(struct svc_rqst *);
 struct svc_serv *  svc_create_pooled(struct svc_program *prog,
+				     unsigned int nprog,
 				     struct svc_stat *stats,
 				     unsigned int bufsize,
 				     int (*threadfn)(void *data));
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ff6f3e35b36d..b33386d249c2 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -440,10 +440,11 @@ EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
 
 static int svc_uses_rpcbind(struct svc_serv *serv)
 {
-	struct svc_program	*progp;
-	unsigned int		i;
+	unsigned int		p, i;
+
+	for (p = 0; p < serv->sv_nprogs; p++) {
+		struct svc_program *progp = &serv->sv_programs[p];
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
 		for (i = 0; i < progp->pg_nvers; i++) {
 			if (progp->pg_vers[i] == NULL)
 				continue;
@@ -480,7 +481,7 @@ __svc_init_bc(struct svc_serv *serv)
  * Create an RPC service
  */
 static struct svc_serv *
-__svc_create(struct svc_program *prog, struct svc_stat *stats,
+__svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stats,
 	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
 {
 	struct svc_serv	*serv;
@@ -491,7 +492,8 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
 	if (!(serv = kzalloc(sizeof(*serv), GFP_KERNEL)))
 		return NULL;
 	serv->sv_name      = prog->pg_name;
-	serv->sv_program   = prog;
+	serv->sv_programs  = prog;
+	serv->sv_nprogs    = nprogs;
 	serv->sv_stats     = stats;
 	if (bufsize > RPCSVC_MAXPAYLOAD)
 		bufsize = RPCSVC_MAXPAYLOAD;
@@ -499,17 +501,18 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
 	serv->sv_max_mesg  = roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_SIZE);
 	serv->sv_threadfn = threadfn;
 	xdrsize = 0;
-	while (prog) {
-		prog->pg_lovers = prog->pg_nvers-1;
-		for (vers=0; vers<prog->pg_nvers ; vers++)
-			if (prog->pg_vers[vers]) {
-				prog->pg_hivers = vers;
-				if (prog->pg_lovers > vers)
-					prog->pg_lovers = vers;
-				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
-					xdrsize = prog->pg_vers[vers]->vs_xdrsize;
+	for (i = 0; i < nprogs; i++) {
+		struct svc_program *progp = &prog[i];
+
+		progp->pg_lovers = progp->pg_nvers-1;
+		for (vers = 0; vers < progp->pg_nvers ; vers++)
+			if (progp->pg_vers[vers]) {
+				progp->pg_hivers = vers;
+				if (progp->pg_lovers > vers)
+					progp->pg_lovers = vers;
+				if (progp->pg_vers[vers]->vs_xdrsize > xdrsize)
+					xdrsize = progp->pg_vers[vers]->vs_xdrsize;
 			}
-		prog = prog->pg_next;
 	}
 	serv->sv_xdrsize   = xdrsize;
 	INIT_LIST_HEAD(&serv->sv_tempsocks);
@@ -558,13 +561,14 @@ __svc_create(struct svc_program *prog, struct svc_stat *stats,
 struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsize,
 			    int (*threadfn)(void *data))
 {
-	return __svc_create(prog, NULL, bufsize, 1, threadfn);
+	return __svc_create(prog, 1, NULL, bufsize, 1, threadfn);
 }
 EXPORT_SYMBOL_GPL(svc_create);
 
 /**
  * svc_create_pooled - Create an RPC service with pooled threads
- * @prog: the RPC program the new service will handle
+ * @prog:  Array of RPC programs the new service will handle
+ * @nprogs: Number of programs in the array
  * @stats: the stats struct if desired
  * @bufsize: maximum message size for @prog
  * @threadfn: a function to service RPC requests for @prog
@@ -572,6 +576,7 @@ EXPORT_SYMBOL_GPL(svc_create);
  * Returns an instantiated struct svc_serv object or NULL.
  */
 struct svc_serv *svc_create_pooled(struct svc_program *prog,
+				   unsigned int nprogs,
 				   struct svc_stat *stats,
 				   unsigned int bufsize,
 				   int (*threadfn)(void *data))
@@ -579,7 +584,7 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
 	struct svc_serv *serv;
 	unsigned int npools = svc_pool_map_get();
 
-	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
+	serv = __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
 	serv->sv_is_pooled = true;
@@ -602,16 +607,16 @@ svc_destroy(struct svc_serv **servp)
 
 	*servp = NULL;
 
-	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
+	dprintk("svc: svc_destroy(%s)\n", serv->sv_programs->pg_name);
 	timer_shutdown_sync(&serv->sv_temptimer);
 
 	/*
 	 * Remaining transports at this point are not expected.
 	 */
 	WARN_ONCE(!list_empty(&serv->sv_permsocks),
-		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
+		  "SVC: permsocks remain for %s\n", serv->sv_programs->pg_name);
 	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
-		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
+		  "SVC: tempsocks remain for %s\n", serv->sv_programs->pg_name);
 
 	cache_clean_deferred(serv);
 
@@ -1149,15 +1154,16 @@ int svc_register(const struct svc_serv *serv, struct net *net,
 		 const int family, const unsigned short proto,
 		 const unsigned short port)
 {
-	struct svc_program	*progp;
-	unsigned int		i;
+	unsigned int		p, i;
 	int			error = 0;
 
 	WARN_ON_ONCE(proto == 0 && port == 0);
 	if (proto == 0 && port == 0)
 		return -EINVAL;
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
+	for (p = 0; p < serv->sv_nprogs; p++) {
+		struct svc_program *progp = &serv->sv_programs[p];
+
 		for (i = 0; i < progp->pg_nvers; i++) {
 
 			error = progp->pg_rpcbind_set(net, progp, i,
@@ -1209,13 +1215,14 @@ static void __svc_unregister(struct net *net, const u32 program, const u32 versi
 static void svc_unregister(const struct svc_serv *serv, struct net *net)
 {
 	struct sighand_struct *sighand;
-	struct svc_program *progp;
 	unsigned long flags;
-	unsigned int i;
+	unsigned int p, i;
 
 	clear_thread_flag(TIF_SIGPENDING);
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next) {
+	for (p = 0; p < serv->sv_nprogs; p++) {
+		struct svc_program *progp = &serv->sv_programs[p];
+
 		for (i = 0; i < progp->pg_nvers; i++) {
 			if (progp->pg_vers[i] == NULL)
 				continue;
@@ -1321,7 +1328,7 @@ svc_process_common(struct svc_rqst *rqstp)
 	struct svc_process_info process;
 	enum svc_auth_status	auth_res;
 	unsigned int		aoffset;
-	int			rc;
+	int			pr, rc;
 	__be32			*p;
 
 	/* Will be turned off only when NFSv4 Sessions are used */
@@ -1345,9 +1352,12 @@ svc_process_common(struct svc_rqst *rqstp)
 	rqstp->rq_vers = be32_to_cpup(p++);
 	rqstp->rq_proc = be32_to_cpup(p);
 
-	for (progp = serv->sv_program; progp; progp = progp->pg_next)
+	for (pr = 0; pr < serv->sv_nprogs; pr++) {
+		progp = &serv->sv_programs[pr];
+
 		if (rqstp->rq_prog == progp->pg_prog)
 			break;
+	}
 
 	/*
 	 * Decode auth data, and add verifier to reply buffer.
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 53ebc719ff5a..43c57124de52 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -268,7 +268,7 @@ static int _svc_xprt_create(struct svc_serv *serv, const char *xprt_name,
 		spin_unlock(&svc_xprt_class_lock);
 		newxprt = xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
 		if (IS_ERR(newxprt)) {
-			trace_svc_xprt_create_err(serv->sv_program->pg_name,
+			trace_svc_xprt_create_err(serv->sv_programs->pg_name,
 						  xcl->xcl_name, sap, len,
 						  newxprt);
 			module_put(xcl->xcl_owner);
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 04b45588ae6f..8ca98b146ec8 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -697,7 +697,8 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 	rqstp->rq_auth_stat = rpc_autherr_badcred;
 	ipm = ip_map_cached_get(xprt);
 	if (ipm == NULL)
-		ipm = __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program->pg_class,
+		ipm = __ip_map_lookup(sn->ip_map_cache,
+				      rqstp->rq_server->sv_programs->pg_class,
 				    &sin6->sin6_addr);
 
 	if (ipm == NULL)
-- 
2.44.0


