Return-Path: <linux-fsdevel+bounces-28127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C576D9673BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 00:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D541F202CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 22:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCE318FDCD;
	Sat, 31 Aug 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxWWEKEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F818F2FA;
	Sat, 31 Aug 2024 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143899; cv=none; b=cGWhqovishBdsdoHplzuKy3sL1txs/UEieIyLaif4OYOl6nHeEL5eeS3PgEj/tzhQ60mKchWJ1dvygXYADoLRTK1hfHOmgZMKPZvyDxSpD/SqF/5cVemjkqiViK5rhZq6XeVssrzoyOQtdiEvIovPq5b+tgni3Da7HV1sVet3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143899; c=relaxed/simple;
	bh=/QDSVVBXdfEvOVJsPiz+Dw7w8eXYiezbvwX15wdDh1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6fmbg61xzGBk2QE4GLWs8jCONvDfpE8CnvYHTVafQ/vfmUEiWAVluHrET2zOlmlq8Iw8hM2Jmq38AMsV/9GWvJ9xM10K3WsCMiJJWUR/CxX4PPYJ5o5PjsZIHy7sNYxMLim2OxI4EOV+tc65pGeLmLf6djB7tmeP6XgebmH5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxWWEKEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2DAC4CEC7;
	Sat, 31 Aug 2024 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725143899;
	bh=/QDSVVBXdfEvOVJsPiz+Dw7w8eXYiezbvwX15wdDh1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxWWEKEB2JRkXCfS0jae8cOQvWeoAGqd4zBVOqKH6VX2yF74mkhYAR9XpOAFt8pR7
	 KBKnApyU/mZG+eav4aGlfzlDKfmJb4oaiPZPKJNyhuqOu0HqPOXjf4WFTx+qtYhWP9
	 m2EaXNJKNyL1N08xpHOZ+zKdPsg0fRixqR7gwy7dv34t0p7Us4DE89WiUvs6+bnWfb
	 dYudV16HEh1L40QmNTpgjZmd8ksox5NLHPV3xn9JNom4YcZ30U8tkDsyBMAbhuo24h
	 BsL7zvTdYNehMxco4jn0GpqW9wFAJriz97g2hSQj+LW6U6UoGBynjpZ7xKl84KkFYn
	 XXw7KxxKUKsTg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 17/26] nfsd: implement server support for NFS_LOCALIO_PROGRAM
Date: Sat, 31 Aug 2024 18:37:37 -0400
Message-ID: <20240831223755.8569-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240831223755.8569-1-snitzer@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
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
made available in nfs_common.  The server expects this protocol to use
the same transport as NFS and NFSACL for its RPCs.  This protocol
isn't part of an IETF standard, nor does it need to be considering it
is Linux-to-Linux auxiliary RPC protocol that amounts to an
implementation detail.

The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
XDR methods are used instead of the less efficient variable sized
methods.

The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
Linux Kernel Organization       400122  nfslocalio

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
[neilb: factored out and simplified single localio protocol]
Co-developed-by: NeilBrown <neilb@suse.de>
Signed-off-by: NeilBrown <neilb@suse.de>

Not-Acked-by: Chuck Lever <chuck.lever@oracle.com>
Not-Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/localio.c   | 77 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h      |  4 +++
 fs/nfsd/nfssvc.c    | 23 +++++++++++++-
 include/linux/nfs.h |  7 +++++
 4 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 75df709c6903..4f89bb3d0419 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -14,12 +14,15 @@
 #include <linux/nfs.h>
 #include <linux/nfs_common.h>
 #include <linux/nfslocalio.h>
+#include <linux/nfs_fs.h>
+#include <linux/nfs_xdr.h>
 #include <linux/string.h>
 
 #include "nfsd.h"
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "cache.h"
 
 static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_open_local_fh = nfsd_open_local_fh,
@@ -110,3 +113,77 @@ nfsd_open_local_fh(nfs_uuid_t *uuid,
 	return localio;
 }
 EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
+
+/*
+ * UUID_IS_LOCAL XDR functions
+ */
+
+static __be32 localio_proc_null(struct svc_rqst *rqstp)
+{
+	return rpc_success;
+}
+
+struct localio_uuidarg {
+	uuid_t			uuid;
+};
+
+static __be32 localio_proc_uuid_is_local(struct svc_rqst *rqstp)
+{
+	struct localio_uuidarg *argp = rqstp->rq_argp;
+	struct net *net = SVC_NET(rqstp);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
+			  net, rqstp->rq_client, THIS_MODULE);
+
+	return rpc_success;
+}
+
+static bool localio_decode_uuidarg(struct svc_rqst *rqstp,
+				   struct xdr_stream *xdr)
+{
+	struct localio_uuidarg *argp = rqstp->rq_argp;
+	u8 uuid[UUID_SIZE];
+
+	if (decode_opaque_fixed(xdr, uuid, UUID_SIZE))
+		return false;
+	import_uuid(&argp->uuid, uuid);
+
+	return true;
+}
+
+static const struct svc_procedure localio_procedures1[] = {
+	[LOCALIOPROC_NULL] = {
+		.pc_func = localio_proc_null,
+		.pc_decode = nfssvc_decode_voidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct nfsd_voidargs),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_xdrressize = 0,
+		.pc_name = "NULL",
+	},
+	[LOCALIOPROC_UUID_IS_LOCAL] = {
+		.pc_func = localio_proc_uuid_is_local,
+		.pc_decode = localio_decode_uuidarg,
+		.pc_encode = nfssvc_encode_voidres,
+		.pc_argsize = sizeof(struct localio_uuidarg),
+		.pc_argzero = sizeof(struct localio_uuidarg),
+		.pc_ressize = sizeof(struct nfsd_voidres),
+		.pc_cachetype = RC_NOCACHE,
+		.pc_name = "UUID_IS_LOCAL",
+	},
+};
+
+#define LOCALIO_NR_PROCEDURES ARRAY_SIZE(localio_procedures1)
+static DEFINE_PER_CPU_ALIGNED(unsigned long,
+			      localio_count[LOCALIO_NR_PROCEDURES]);
+const struct svc_version localio_version1 = {
+	.vs_vers	= 1,
+	.vs_nproc	= LOCALIO_NR_PROCEDURES,
+	.vs_proc	= localio_procedures1,
+	.vs_dispatch	= nfsd_dispatch,
+	.vs_count	= localio_count,
+	.vs_xdrsize	= XDR_QUADLEN(UUID_SIZE),
+	.vs_hidden	= true,
+};
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b0d3e82d6dcd..4b56ba1e8e48 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -146,6 +146,10 @@ extern const struct svc_version nfsd_acl_version3;
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+extern const struct svc_version localio_version1;
+#endif
+
 struct nfsd_net;
 
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 7b9119b8dd1b..e84db131ad5c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -80,6 +80,15 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+static const struct svc_version *localio_versions[] = {
+	[1] = &localio_version1,
+};
+
+#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
+
+#endif /* CONFIG_NFS_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -128,6 +137,18 @@ struct svc_program		nfsd_programs[] = {
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 	},
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
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
+#endif /* CONFIG_NFS_LOCALIO */
 };
 
 bool nfsd_support_version(int vers)
@@ -946,7 +967,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index ceb70a926b95..73da75908d95 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -13,6 +13,13 @@
 #include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
+/* The LOCALIO program is entirely private to Linux and is
+ * NOT part of the uapi.
+ */
+#define NFS_LOCALIO_PROGRAM		400122
+#define LOCALIOPROC_NULL		0
+#define LOCALIOPROC_UUID_IS_LOCAL	1
+
 /*
  * This is the kernel NFS client file handle representation
  */
-- 
2.44.0


