Return-Path: <linux-fsdevel+bounces-27714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06D963750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96AA281D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BF617740;
	Thu, 29 Aug 2024 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKF/E0wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254879F3;
	Thu, 29 Aug 2024 01:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893467; cv=none; b=c18+ehRruiZgK0N7nsIv+0NtAE/sElBF/dbpP84TsUHhQgbLQqcsZalXNnA66Wj7CSptUR/HSmI3SrKyJE6GdAD8OXx5uybqn7LK8+Bn8qTJjTW8x4kCLW96MXExecAgjG/n7EzLc+2627akFTdJEgkBX0dUhMo7YkGSM2lbMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893467; c=relaxed/simple;
	bh=ccJiW4DuhKNnOdiRFGXGLE+maD/kYxEQO1hVWL2sDvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyxwjXXusYQlyhxUka82Acf7o+rBayGh87+jaVsfXkt4cqeOU2+PdCA2shjwEYZG3HvWy3ksfhv/3eiYteDBzS2z/SbmlfSn2XqyLwHhqzR/203VjV2k3ZORtaKoMh8o33L8LsUHzCjWpRuGFr2BEQ/6P9FE9SOPUHgi8xKZftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKF/E0wE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879DEC4CED9;
	Thu, 29 Aug 2024 01:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893466;
	bh=ccJiW4DuhKNnOdiRFGXGLE+maD/kYxEQO1hVWL2sDvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKF/E0wE36R+zRCEMY9fNcW3mV++jHLsr2TIdGNbP09Eo1v1PaMFeLNIT4YXVcRtN
	 a49UpxgIiHVZ11jbs/Eizicl4QugWz0cZ0sncTcNYTRFs2lTECnVnx5qMQaTcwRSt+
	 0regvDQmVZ/AC/zU9eLrOaU6kmJXvuj3zqx3+Z7MHHK+/eTpWKMkHoX3FmsYKlRhlm
	 mV4+lrS5IGBk4ee3421rIKw8zCmol0B7EcZubXKjZLZbDNtx/+glKNiiFklq8e695+
	 4V2jyxyPwbRyC5sb2oK5m5zobsLP65a45FvUQDqbQfRaXvKvW0+7qfDzBHf6Y9bp1g
	 46TlHXAffLUjA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 01/25] nfs_common: factor out nfs_errtbl and nfs_stat_to_errno
Date: Wed, 28 Aug 2024 21:03:56 -0400
Message-ID: <20240829010424.83693-2-snitzer@kernel.org>
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

Common nfs_stat_to_errno() is used by both fs/nfs/nfs2xdr.c and
fs/nfs/nfs3xdr.c

Will also be used by fs/nfsd/localio.c

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/Kconfig             |   1 +
 fs/nfs/nfs2xdr.c           |  70 +-----------------------
 fs/nfs/nfs3xdr.c           | 108 +++++++------------------------------
 fs/nfs/nfs4xdr.c           |   4 +-
 fs/nfs_common/Makefile     |   2 +
 fs/nfs_common/common.c     |  67 +++++++++++++++++++++++
 fs/nfsd/Kconfig            |   1 +
 include/linux/nfs_common.h |  16 ++++++
 8 files changed, 109 insertions(+), 160 deletions(-)
 create mode 100644 fs/nfs_common/common.c
 create mode 100644 include/linux/nfs_common.h

diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 57249f040dfc..0eb20012792f 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -4,6 +4,7 @@ config NFS_FS
 	depends on INET && FILE_LOCKING && MULTIUSER
 	select LOCKD
 	select SUNRPC
+	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFS_V3_ACL
 	help
 	  Choose Y here if you want to access files residing on other
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index c19093814296..6e75c6c2d234 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -22,14 +22,12 @@
 #include <linux/nfs.h>
 #include <linux/nfs2.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_common.h>
 #include "nfstrace.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-/* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO		EIO
-
 /*
  * Declare the space requirements for NFS arguments and replies as
  * number of 32bit-words
@@ -64,8 +62,6 @@
 #define NFS_readdirres_sz	(1+NFS_pagepad_sz)
 #define NFS_statfsres_sz	(1+NFS_info_sz)
 
-static int nfs_stat_to_errno(enum nfs_stat);
-
 /*
  * Encode/decode NFSv2 basic data types
  *
@@ -1054,70 +1050,6 @@ static int nfs2_xdr_dec_statfsres(struct rpc_rqst *req, struct xdr_stream *xdr,
 	return nfs_stat_to_errno(status);
 }
 
-
-/*
- * We need to translate between nfs status return values and
- * the local errno values which may not be the same.
- */
-static const struct {
-	int stat;
-	int errno;
-} nfs_errtbl[] = {
-	{ NFS_OK,		0		},
-	{ NFSERR_PERM,		-EPERM		},
-	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
-	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
-	{ NFSERR_ACCES,		-EACCES		},
-	{ NFSERR_EXIST,		-EEXIST		},
-	{ NFSERR_XDEV,		-EXDEV		},
-	{ NFSERR_NODEV,		-ENODEV		},
-	{ NFSERR_NOTDIR,	-ENOTDIR	},
-	{ NFSERR_ISDIR,		-EISDIR		},
-	{ NFSERR_INVAL,		-EINVAL		},
-	{ NFSERR_FBIG,		-EFBIG		},
-	{ NFSERR_NOSPC,		-ENOSPC		},
-	{ NFSERR_ROFS,		-EROFS		},
-	{ NFSERR_MLINK,		-EMLINK		},
-	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
-	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
-	{ NFSERR_DQUOT,		-EDQUOT		},
-	{ NFSERR_STALE,		-ESTALE		},
-	{ NFSERR_REMOTE,	-EREMOTE	},
-#ifdef EWFLUSH
-	{ NFSERR_WFLUSH,	-EWFLUSH	},
-#endif
-	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
-	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
-	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
-	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
-	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
-	{ NFSERR_BADTYPE,	-EBADTYPE	},
-	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
-};
-
-/**
- * nfs_stat_to_errno - convert an NFS status code to a local errno
- * @status: NFS status code to convert
- *
- * Returns a local errno value, or -EIO if the NFS status code is
- * not recognized.  This function is used jointly by NFSv2 and NFSv3.
- */
-static int nfs_stat_to_errno(enum nfs_stat status)
-{
-	int i;
-
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
-		if (nfs_errtbl[i].stat == (int)status)
-			return nfs_errtbl[i].errno;
-	}
-	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
-	return nfs_errtbl[i].errno;
-}
-
 #define PROC(proc, argtype, restype, timer)				\
 [NFSPROC_##proc] = {							\
 	.p_proc	    =  NFSPROC_##proc,					\
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 60f032be805a..4ae01c10b7e2 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -21,14 +21,13 @@
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfsacl.h>
+#include <linux/nfs_common.h>
+
 #include "nfstrace.h"
 #include "internal.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-/* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO		EIO
-
 /*
  * Declare the space requirements for NFS arguments and replies as
  * number of 32bit-words
@@ -91,8 +90,6 @@
 				NFS3_pagepad_sz)
 #define ACL3_setaclres_sz	(1+NFS3_post_op_attr_sz)
 
-static int nfs3_stat_to_errno(enum nfs_stat);
-
 /*
  * Map file type to S_IFMT bits
  */
@@ -1406,7 +1403,7 @@ static int nfs3_xdr_dec_getattr3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1445,7 +1442,7 @@ static int nfs3_xdr_dec_setattr3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1495,7 +1492,7 @@ static int nfs3_xdr_dec_lookup3res(struct rpc_rqst *req,
 	error = decode_post_op_attr(xdr, result->dir_attr, userns);
 	if (unlikely(error))
 		goto out;
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1537,7 +1534,7 @@ static int nfs3_xdr_dec_access3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1578,7 +1575,7 @@ static int nfs3_xdr_dec_readlink3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1658,7 +1655,7 @@ static int nfs3_xdr_dec_read3res(struct rpc_rqst *req, struct xdr_stream *xdr,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1728,7 +1725,7 @@ static int nfs3_xdr_dec_write3res(struct rpc_rqst *req, struct xdr_stream *xdr,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1795,7 +1792,7 @@ static int nfs3_xdr_dec_create3res(struct rpc_rqst *req,
 	error = decode_wcc_data(xdr, result->dir_attr, userns);
 	if (unlikely(error))
 		goto out;
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1835,7 +1832,7 @@ static int nfs3_xdr_dec_remove3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1881,7 +1878,7 @@ static int nfs3_xdr_dec_rename3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -1926,7 +1923,7 @@ static int nfs3_xdr_dec_link3res(struct rpc_rqst *req, struct xdr_stream *xdr,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /**
@@ -2101,7 +2098,7 @@ static int nfs3_xdr_dec_readdir3res(struct rpc_rqst *req,
 	error = decode_post_op_attr(xdr, result->dir_attr, rpc_rqst_userns(req));
 	if (unlikely(error))
 		goto out;
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2167,7 +2164,7 @@ static int nfs3_xdr_dec_fsstat3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2243,7 +2240,7 @@ static int nfs3_xdr_dec_fsinfo3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2304,7 +2301,7 @@ static int nfs3_xdr_dec_pathconf3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 /*
@@ -2350,7 +2347,7 @@ static int nfs3_xdr_dec_commit3res(struct rpc_rqst *req,
 out:
 	return error;
 out_status:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 #ifdef CONFIG_NFS_V3_ACL
@@ -2416,7 +2413,7 @@ static int nfs3_xdr_dec_getacl3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 static int nfs3_xdr_dec_setacl3res(struct rpc_rqst *req,
@@ -2435,76 +2432,11 @@ static int nfs3_xdr_dec_setacl3res(struct rpc_rqst *req,
 out:
 	return error;
 out_default:
-	return nfs3_stat_to_errno(status);
+	return nfs_stat_to_errno(status);
 }
 
 #endif  /* CONFIG_NFS_V3_ACL */
 
-
-/*
- * We need to translate between nfs status return values and
- * the local errno values which may not be the same.
- */
-static const struct {
-	int stat;
-	int errno;
-} nfs_errtbl[] = {
-	{ NFS_OK,		0		},
-	{ NFSERR_PERM,		-EPERM		},
-	{ NFSERR_NOENT,		-ENOENT		},
-	{ NFSERR_IO,		-errno_NFSERR_IO},
-	{ NFSERR_NXIO,		-ENXIO		},
-/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
-	{ NFSERR_ACCES,		-EACCES		},
-	{ NFSERR_EXIST,		-EEXIST		},
-	{ NFSERR_XDEV,		-EXDEV		},
-	{ NFSERR_NODEV,		-ENODEV		},
-	{ NFSERR_NOTDIR,	-ENOTDIR	},
-	{ NFSERR_ISDIR,		-EISDIR		},
-	{ NFSERR_INVAL,		-EINVAL		},
-	{ NFSERR_FBIG,		-EFBIG		},
-	{ NFSERR_NOSPC,		-ENOSPC		},
-	{ NFSERR_ROFS,		-EROFS		},
-	{ NFSERR_MLINK,		-EMLINK		},
-	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
-	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
-	{ NFSERR_DQUOT,		-EDQUOT		},
-	{ NFSERR_STALE,		-ESTALE		},
-	{ NFSERR_REMOTE,	-EREMOTE	},
-#ifdef EWFLUSH
-	{ NFSERR_WFLUSH,	-EWFLUSH	},
-#endif
-	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
-	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
-	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
-	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
-	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
-	{ NFSERR_BADTYPE,	-EBADTYPE	},
-	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
-	{ -1,			-EIO		}
-};
-
-/**
- * nfs3_stat_to_errno - convert an NFS status code to a local errno
- * @status: NFS status code to convert
- *
- * Returns a local errno value, or -EIO if the NFS status code is
- * not recognized.  This function is used jointly by NFSv2 and NFSv3.
- */
-static int nfs3_stat_to_errno(enum nfs_stat status)
-{
-	int i;
-
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
-		if (nfs_errtbl[i].stat == (int)status)
-			return nfs_errtbl[i].errno;
-	}
-	dprintk("NFS: Unrecognized nfs status value: %u\n", status);
-	return nfs_errtbl[i].errno;
-}
-
-
 #define PROC(proc, argtype, restype, timer)				\
 [NFS3PROC_##proc] = {							\
 	.p_proc      = NFS3PROC_##proc,					\
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 7704a4509676..b4091af1a60d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -52,6 +52,7 @@
 #include <linux/nfs.h>
 #include <linux/nfs4.h>
 #include <linux/nfs_fs.h>
+#include <linux/nfs_common.h>
 
 #include "nfs4_fs.h"
 #include "nfs4trace.h"
@@ -63,9 +64,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-/* Mapping from NFS error code to "errno" error code. */
-#define errno_NFSERR_IO		EIO
-
 struct compound_hdr;
 static int nfs4_stat_to_errno(int);
 static void encode_layoutget(struct xdr_stream *xdr,
diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
index 119c75ab9fd0..e58b01bb8dda 100644
--- a/fs/nfs_common/Makefile
+++ b/fs/nfs_common/Makefile
@@ -8,3 +8,5 @@ nfs_acl-objs := nfsacl.o
 
 obj-$(CONFIG_GRACE_PERIOD) += grace.o
 obj-$(CONFIG_NFS_V4_2_SSC_HELPER) += nfs_ssc.o
+
+obj-$(CONFIG_NFS_COMMON) += common.o
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
new file mode 100644
index 000000000000..a4ee95da2174
--- /dev/null
+++ b/fs/nfs_common/common.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/nfs_common.h>
+
+/*
+ * We need to translate between nfs status return values and
+ * the local errno values which may not be the same.
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs_errtbl[] = {
+	{ NFS_OK,		0		},
+	{ NFSERR_PERM,		-EPERM		},
+	{ NFSERR_NOENT,		-ENOENT		},
+	{ NFSERR_IO,		-errno_NFSERR_IO},
+	{ NFSERR_NXIO,		-ENXIO		},
+/*	{ NFSERR_EAGAIN,	-EAGAIN		}, */
+	{ NFSERR_ACCES,		-EACCES		},
+	{ NFSERR_EXIST,		-EEXIST		},
+	{ NFSERR_XDEV,		-EXDEV		},
+	{ NFSERR_NODEV,		-ENODEV		},
+	{ NFSERR_NOTDIR,	-ENOTDIR	},
+	{ NFSERR_ISDIR,		-EISDIR		},
+	{ NFSERR_INVAL,		-EINVAL		},
+	{ NFSERR_FBIG,		-EFBIG		},
+	{ NFSERR_NOSPC,		-ENOSPC		},
+	{ NFSERR_ROFS,		-EROFS		},
+	{ NFSERR_MLINK,		-EMLINK		},
+	{ NFSERR_NAMETOOLONG,	-ENAMETOOLONG	},
+	{ NFSERR_NOTEMPTY,	-ENOTEMPTY	},
+	{ NFSERR_DQUOT,		-EDQUOT		},
+	{ NFSERR_STALE,		-ESTALE		},
+	{ NFSERR_REMOTE,	-EREMOTE	},
+#ifdef EWFLUSH
+	{ NFSERR_WFLUSH,	-EWFLUSH	},
+#endif
+	{ NFSERR_BADHANDLE,	-EBADHANDLE	},
+	{ NFSERR_NOT_SYNC,	-ENOTSYNC	},
+	{ NFSERR_BAD_COOKIE,	-EBADCOOKIE	},
+	{ NFSERR_NOTSUPP,	-ENOTSUPP	},
+	{ NFSERR_TOOSMALL,	-ETOOSMALL	},
+	{ NFSERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFSERR_BADTYPE,	-EBADTYPE	},
+	{ NFSERR_JUKEBOX,	-EJUKEBOX	},
+	{ -1,			-EIO		}
+};
+
+/**
+ * nfs_stat_to_errno - convert an NFS status code to a local errno
+ * @status: NFS status code to convert
+ *
+ * Returns a local errno value, or -EIO if the NFS status code is
+ * not recognized.  This function is used jointly by NFSv2 and NFSv3.
+ */
+int nfs_stat_to_errno(enum nfs_stat status)
+{
+	int i;
+
+	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
+		if (nfs_errtbl[i].stat == (int)status)
+			return nfs_errtbl[i].errno;
+	}
+	return nfs_errtbl[i].errno;
+}
+EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index ec2ab6429e00..c0bd1509ccd4 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -7,6 +7,7 @@ config NFSD
 	select LOCKD
 	select SUNRPC
 	select EXPORTFS
+	select NFS_COMMON
 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
 	select NFS_ACL_SUPPORT if NFSD_V3_ACL
 	depends on MULTIUSER
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
new file mode 100644
index 000000000000..3395c4a4d372
--- /dev/null
+++ b/include/linux/nfs_common.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file contains constants and methods used by both NFS client and server.
+ */
+#ifndef _LINUX_NFS_COMMON_H
+#define _LINUX_NFS_COMMON_H
+
+#include <linux/errno.h>
+#include <uapi/linux/nfs.h>
+
+/* Mapping from NFS error code to "errno" error code. */
+#define errno_NFSERR_IO EIO
+
+int nfs_stat_to_errno(enum nfs_stat status);
+
+#endif /* _LINUX_NFS_COMMON_H */
-- 
2.44.0


