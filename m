Return-Path: <linux-fsdevel+bounces-26970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62A95D507
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35818284AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4D819340A;
	Fri, 23 Aug 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNjh81NG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752219309E;
	Fri, 23 Aug 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436880; cv=none; b=lKxzkvBThwoh2ovxq8UVrZtPtE1eHxyjd+IvGZxCeJPzqG+OkxFD/HOchAbihBOh8P9o+v8bBhWBbpyCMrvSW5G4qcFMBsycciAIE+Y4d9gYJm3/ZuJC9i2nOg+YE4usL1RvrTnoIspg7/XQBfWJWZqVnDqjbbJBHWHUq9dj1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436880; c=relaxed/simple;
	bh=FWrZ7xyDhV/e9oreu3svOZad5u9rRo8I1clugx+nikA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6pzzUTQ5U8gnknnvjiPLnbcrz+I9vPCLZbLvv1GqkOh2/DbWAMuVDS3dlI0xyAvFdbWeUS1GUBvvBk2R7Mk3t1OCv9/e1dAHCx0wPY0yQcvprOfL07se4Ts17tfycbxF4X8c0LxcREft5QkEY9k4EMafQfzgDSqPmAkJ6HH+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNjh81NG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD1FC4AF0C;
	Fri, 23 Aug 2024 18:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436880;
	bh=FWrZ7xyDhV/e9oreu3svOZad5u9rRo8I1clugx+nikA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TNjh81NG+LkQr+ruw3kSoeXyaoqj46UMVKWXE23J58/5jVKaBMBifLr35HuTNqHph
	 Y/Tc2tMq1VffZ8OGv3GHEaJGZL3mbMX9b6GRlpORBBYv1Qcgb4SyUIW2pY324HbEW7
	 8fXeWBDTEXnZhbWT0KHCx6wgi2cw419ImIhx8EXSKsUNw8njLBCHwj7o/zLT/g+Y+y
	 DtucVWym1aXpdJTLqv638h3UG7ifPz5SP6gpNBINUWpTiZab637fgun0Sa8ZfJBC6M
	 9IVKxcqxQK7qVHzyECgBOa/V2YkNaiQDA1iq/804yuj0BUYzLH50Qd3+CC2zQLRyFM
	 vbTTT3EeAHp0g==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 11/19] nfsd: implement server support for NFS_LOCALIO_PROGRAM
Date: Fri, 23 Aug 2024 14:14:09 -0400
Message-ID: <20240823181423.20458-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240823181423.20458-1-snitzer@kernel.org>
References: <20240823181423.20458-1-snitzer@kernel.org>
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
made available in nfs_common.  This protocol isn't part of an IETF
standard, nor does it need to be considering it is Linux-to-Linux
auxiliary RPC protocol that amounts to an implementation detail.

The UUID_IS_LOCAL method encodes the client generated uuid_t in terms of
the fixed UUID_SIZE (16 bytes).  The fixed size opaque encode and decode
XDR methods are used instead of the less efficient variable sized
methods.

The RPC program number for the NFS_LOCALIO_PROGRAM is 400122 (as assigned
by IANA, see https://www.iana.org/assignments/rpc-program-numbers/ ):
Linux Kernel Organization       400122  nfslocalio

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
[neilb: factored out and simplified single localio protocol]
Co-developed-by: NeilBrown <neil@brown.name>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/localio.c   | 75 +++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h      |  4 +++
 fs/nfsd/nfssvc.c    | 23 +++++++++++++-
 include/linux/nfs.h |  7 +++++
 4 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 8e0cce835f81..2ceab49f3cb6 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -13,12 +13,15 @@
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
 
 /**
  * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to @file
@@ -106,3 +109,75 @@ EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
 
 /* Compile time type checking, not used by anything */
 static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
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
+
+	(void) nfs_uuid_is_local(&argp->uuid, SVC_NET(rqstp),
+				 rqstp->rq_client);
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
index b0d3e82d6dcd..232a873dc53a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -146,6 +146,10 @@ extern const struct svc_version nfsd_acl_version3;
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+extern const struct svc_version localio_version1;
+#endif
+
 struct nfsd_net;
 
 enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c639fbe4d8c2..5f8680ab1013 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -79,6 +79,15 @@ DEFINE_SPINLOCK(nfsd_drc_lock);
 unsigned long	nfsd_drc_max_mem;
 unsigned long	nfsd_drc_mem_used;
 
+#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
+static const struct svc_version *localio_versions[] = {
+	[1] = &localio_version1,
+};
+
+#define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
+
+#endif /* CONFIG_NFSD_LOCALIO */
+
 #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
 static const struct svc_version *nfsd_acl_version[] = {
 # if defined(CONFIG_NFSD_V2_ACL)
@@ -127,6 +136,18 @@ struct svc_program		nfsd_programs[] = {
 	.pg_rpcbind_set		= nfsd_acl_rpcbind_set,
 	},
 #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
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
@@ -944,7 +965,7 @@ nfsd(void *vrqstp)
 }
 
 /**
- * nfsd_dispatch - Process an NFS or NFSACL Request
+ * nfsd_dispatch - Process an NFS or NFSACL or LOCALIO Request
  * @rqstp: incoming request
  *
  * This RPC dispatcher integrates the NFS server's duplicate reply cache.
diff --git a/include/linux/nfs.h b/include/linux/nfs.h
index ceb70a926b95..5ff1a5b3b00c 100644
--- a/include/linux/nfs.h
+++ b/include/linux/nfs.h
@@ -13,6 +13,13 @@
 #include <linux/crc32.h>
 #include <uapi/linux/nfs.h>
 
+/* The localio program is entirely private to Linux and is
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


