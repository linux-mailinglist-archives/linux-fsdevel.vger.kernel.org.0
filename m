Return-Path: <linux-fsdevel+bounces-27715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE93963753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 03:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A2A28283F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E62BAEB;
	Thu, 29 Aug 2024 01:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0d5BtnW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981729474;
	Thu, 29 Aug 2024 01:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893469; cv=none; b=fQQ5TQFDoOBBqQFK/xAX4l0VXPGDGEbLABdgGVpgEXTnhR7F0/brHsV3s+ssojr7Lv5T2RntCG06VjXATFgrcGS+SHQJYgJ5yei82HIMbi15eThjIKugkT7GQAydNocZKuupL3Sf1cT6woT6jiqE9m5bwARwWymjr1v60hkKcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893469; c=relaxed/simple;
	bh=naa0+vU2hdij5+Oa6Z4mA9sWp5gwQRiL2MzywjCf7fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxyLeWv0VaH8hM5xwWkepKH2/CTjEAk+a1eb30Utpew+vEf7nya5RvGXZmD2I9IuvX9zx2vgPi8eM8ey3Un7UXEneznfKKhrmycpu63Vmzx7T1dWqtDFu55BjRATi5F/fyhi0/2iFrkLdHhtLrCT/BexHF5U17X6GPHFInddIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0d5BtnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DB7C4CEC0;
	Thu, 29 Aug 2024 01:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724893468;
	bh=naa0+vU2hdij5+Oa6Z4mA9sWp5gwQRiL2MzywjCf7fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0d5BtnW+o0VU0szebc0+zqlZSC9R9R+7VDluNPDTgHPtdIiUJqYkr6SfPOyV2hXV
	 D+GhpD7JQZsMFceBX+ZGsLei/YI+Ptm3epptgFIul7Pka2hxm8Y4NdHe/OuDXp4JAy
	 kml7MW9CjyB4+6TBTMaDMcYcosaQsCa+LSa3DFQd8ASEEFhlkciRD1wHYPzMQjUxfW
	 jaPjFtf3+CzDyEvSaFNMraLcW9pYz4ZAkqahs/P1DVPDMhR/qHZLtZ5/8ZaCDyCT1k
	 orDKzQNO4fn+hdRGVRG7STucOJcHswJ4Cl+ba2d7Ih0eLST/Qgz9i6wRBkRfOCjL3s
	 reMhsxZd6vlPA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 02/25] nfs_common: factor out nfs4_errtbl and nfs4_stat_to_errno
Date: Wed, 28 Aug 2024 21:03:57 -0400
Message-ID: <20240829010424.83693-3-snitzer@kernel.org>
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


