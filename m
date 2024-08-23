Return-Path: <linux-fsdevel+bounces-26961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA9795D4F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1AB1284D0F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8621922F8;
	Fri, 23 Aug 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWkm63iC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA242A9F;
	Fri, 23 Aug 2024 18:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724436868; cv=none; b=B/IofrTLrLHKUGWddulTG3d0OGoEODpq4d3K/ewdbfBaYdve+4KHOsn6Y/0+OQkKyO44EMJzkGylosUPyEH/wkWHDrN1qwqVO3JsY2WZW5a7AmmtaOFbLlBLGq2qjUnVfDD6qQfjfJAcHPSGzJcd9XEmi/misAANAcBD8zNY+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724436868; c=relaxed/simple;
	bh=naa0+vU2hdij5+Oa6Z4mA9sWp5gwQRiL2MzywjCf7fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TydaxfN5GrPBeYOBtNnAjfJa15iLt/vzHT6e6LXUbPFwQK4Yql5lTh6RxkND73P8P67xNxUYBS5AmbMXEdTvPf8CllzRPa0tD6IoZSVWzueBTom98qmc0RuBbsKjI3ynKLpYZ5xtJ/AX/lkRviTJXnPiOAaT9MuYI6G/wmsRTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWkm63iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DD3C4AF09;
	Fri, 23 Aug 2024 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724436867;
	bh=naa0+vU2hdij5+Oa6Z4mA9sWp5gwQRiL2MzywjCf7fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWkm63iCF1fvqXRZs+UKU80hZh8foNtwCnGlpDOL9uPX+xIsKnfDFPKA0QgjaC67W
	 EvNzz6OmmiwIY+/ur/HDCyAUqdrodjQMxYV6KRaxakeA2FPwgmr520XZRCevRqX2fU
	 BRuyHAIMzT6DWXxUeixB3sMwhJsU4MZx0plnG5n2+DPqCnUQf2yO/fIcrObrhopMpL
	 8v3MyVtx+N/CLOxEuduqzkzMNwbeFJTEjNj9/6jNLEl2tcW1/xWoDrMvq9ynsvJNGR
	 s2j8ADdoebkhM5bwy2UNyK+OF/iosJ7Huq5uLvKBHr74Cajpi1QJyr6O9AxayMnx0y
	 bXD7PmswWzvjg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 02/19] nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
Date: Fri, 23 Aug 2024 14:14:00 -0400
Message-ID: <20240823181423.20458-3-snitzer@kernel.org>
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

Common nfs4_stat_to_errno() is used by fs/nfs/nfs4xdr.c and will be
used by fs/nfs/localio.c

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/nfs4xdr.c           | 67 --------------------------------------
 fs/nfs_common/common.c     | 67 ++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_common.h |  1 +
 3 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b4091af1a60d..971305bdaecb 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -65,7 +65,6 @@
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
 struct compound_hdr;
-static int nfs4_stat_to_errno(int);
 static void encode_layoutget(struct xdr_stream *xdr,
 			     const struct nfs4_layoutget_args *args,
 			     struct compound_hdr *hdr);
@@ -7619,72 +7618,6 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	return 0;
 }
 
-/*
- * We need to translate between nfs status return values and
- * the local errno values which may not be the same.
- */
-static struct {
-	int stat;
-	int errno;
-} nfs_errtbl[] = {
-	{ NFS4_OK,		0		},
-	{ NFS4ERR_PERM,		-EPERM		},
-	{ NFS4ERR_NOENT,	-ENOENT		},
-	{ NFS4ERR_IO,		-errno_NFSERR_IO},
-	{ NFS4ERR_NXIO,		-ENXIO		},
-	{ NFS4ERR_ACCESS,	-EACCES		},
-	{ NFS4ERR_EXIST,	-EEXIST		},
-	{ NFS4ERR_XDEV,		-EXDEV		},
-	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
-	{ NFS4ERR_ISDIR,	-EISDIR		},
-	{ NFS4ERR_INVAL,	-EINVAL		},
-	{ NFS4ERR_FBIG,		-EFBIG		},
-	{ NFS4ERR_NOSPC,	-ENOSPC		},
-	{ NFS4ERR_ROFS,		-EROFS		},
-	{ NFS4ERR_MLINK,	-EMLINK		},
-	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
-	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
-	{ NFS4ERR_DQUOT,	-EDQUOT		},
-	{ NFS4ERR_STALE,	-ESTALE		},
-	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
-	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
-	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
-	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
-	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
-	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
-	{ NFS4ERR_LOCKED,	-EAGAIN		},
-	{ NFS4ERR_SYMLINK,	-ELOOP		},
-	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
-	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
-	{ NFS4ERR_NOXATTR,	-ENODATA	},
-	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
-	{ -1,			-EIO		}
-};
-
-/*
- * Convert an NFS error code to a local one.
- * This one is used jointly by NFSv2 and NFSv3.
- */
-static int
-nfs4_stat_to_errno(int stat)
-{
-	int i;
-	for (i = 0; nfs_errtbl[i].stat != -1; i++) {
-		if (nfs_errtbl[i].stat == stat)
-			return nfs_errtbl[i].errno;
-	}
-	if (stat <= 10000 || stat > 10100) {
-		/* The server is looney tunes. */
-		return -EREMOTEIO;
-	}
-	/* If we cannot translate the error, the recovery routines should
-	 * handle it.
-	 * Note: remaining NFSv4 error codes have values > 10000, so should
-	 * not conflict with native Linux error codes.
-	 */
-	return -stat;
-}
-
 #ifdef CONFIG_NFS_V4_2
 #include "nfs42xdr.c"
 #endif /* CONFIG_NFS_V4_2 */
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index a4ee95da2174..34a115176f97 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/module.h>
 #include <linux/nfs_common.h>
+#include <linux/nfs4.h>
 
 /*
  * We need to translate between nfs status return values and
@@ -65,3 +66,69 @@ int nfs_stat_to_errno(enum nfs_stat status)
 	return nfs_errtbl[i].errno;
 }
 EXPORT_SYMBOL_GPL(nfs_stat_to_errno);
+
+/*
+ * We need to translate between nfs v4 status return values and
+ * the local errno values which may not be the same.
+ */
+static const struct {
+	int stat;
+	int errno;
+} nfs4_errtbl[] = {
+	{ NFS4_OK,		0		},
+	{ NFS4ERR_PERM,		-EPERM		},
+	{ NFS4ERR_NOENT,	-ENOENT		},
+	{ NFS4ERR_IO,		-errno_NFSERR_IO},
+	{ NFS4ERR_NXIO,		-ENXIO		},
+	{ NFS4ERR_ACCESS,	-EACCES		},
+	{ NFS4ERR_EXIST,	-EEXIST		},
+	{ NFS4ERR_XDEV,		-EXDEV		},
+	{ NFS4ERR_NOTDIR,	-ENOTDIR	},
+	{ NFS4ERR_ISDIR,	-EISDIR		},
+	{ NFS4ERR_INVAL,	-EINVAL		},
+	{ NFS4ERR_FBIG,		-EFBIG		},
+	{ NFS4ERR_NOSPC,	-ENOSPC		},
+	{ NFS4ERR_ROFS,		-EROFS		},
+	{ NFS4ERR_MLINK,	-EMLINK		},
+	{ NFS4ERR_NAMETOOLONG,	-ENAMETOOLONG	},
+	{ NFS4ERR_NOTEMPTY,	-ENOTEMPTY	},
+	{ NFS4ERR_DQUOT,	-EDQUOT		},
+	{ NFS4ERR_STALE,	-ESTALE		},
+	{ NFS4ERR_BADHANDLE,	-EBADHANDLE	},
+	{ NFS4ERR_BAD_COOKIE,	-EBADCOOKIE	},
+	{ NFS4ERR_NOTSUPP,	-ENOTSUPP	},
+	{ NFS4ERR_TOOSMALL,	-ETOOSMALL	},
+	{ NFS4ERR_SERVERFAULT,	-EREMOTEIO	},
+	{ NFS4ERR_BADTYPE,	-EBADTYPE	},
+	{ NFS4ERR_LOCKED,	-EAGAIN		},
+	{ NFS4ERR_SYMLINK,	-ELOOP		},
+	{ NFS4ERR_OP_ILLEGAL,	-EOPNOTSUPP	},
+	{ NFS4ERR_DEADLOCK,	-EDEADLK	},
+	{ NFS4ERR_NOXATTR,	-ENODATA	},
+	{ NFS4ERR_XATTR2BIG,	-E2BIG		},
+	{ -1,			-EIO		}
+};
+
+/*
+ * Convert an NFS error code to a local one.
+ * This one is used by NFSv4.
+ */
+int nfs4_stat_to_errno(int stat)
+{
+	int i;
+	for (i = 0; nfs4_errtbl[i].stat != -1; i++) {
+		if (nfs4_errtbl[i].stat == stat)
+			return nfs4_errtbl[i].errno;
+	}
+	if (stat <= 10000 || stat > 10100) {
+		/* The server is looney tunes. */
+		return -EREMOTEIO;
+	}
+	/* If we cannot translate the error, the recovery routines should
+	 * handle it.
+	 * Note: remaining NFSv4 error codes have values > 10000, so should
+	 * not conflict with native Linux error codes.
+	 */
+	return -stat;
+}
+EXPORT_SYMBOL_GPL(nfs4_stat_to_errno);
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
index 3395c4a4d372..5fc02df88252 100644
--- a/include/linux/nfs_common.h
+++ b/include/linux/nfs_common.h
@@ -12,5 +12,6 @@
 #define errno_NFSERR_IO EIO
 
 int nfs_stat_to_errno(enum nfs_stat status);
+int nfs4_stat_to_errno(int stat);
 
 #endif /* _LINUX_NFS_COMMON_H */
-- 
2.44.0


