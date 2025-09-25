Return-Path: <linux-fsdevel+bounces-62771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D84BA039E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084F21B241EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E70305957;
	Thu, 25 Sep 2025 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDLKL8/Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3C2E2665;
	Thu, 25 Sep 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813103; cv=none; b=P5A0yLXYgN/sCtWcZQhSWfIXGvEiPHEjn4foESJ2MKQzfm3EI3myiS+XjThNzKZ7pKIBd+FAjDq0f2kaqlMzH5+mavsrMoZ2uTX+KVwKA33WArfN3UPmRgWKpKYh5MSYjaAdJx4fvv/j5CGozE5i8ykf3KG9ZKclc9e98mqjDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813103; c=relaxed/simple;
	bh=Umyfp7Cz0bjSndzsCHElLy4MOPUmYAH6cd4OMZd0puU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePT8coUpEBclqYsfAgU4siM8NUG4pt9+7F183s3h46pJC6s/wO/Ar2nOZ0JTkTHaGf7S1d8/B6/NEbohcZB3xvWpfYImB30NwE8HvBoyiEJPUEO5159v3JpHH6cdV2A1Kd56Y9CGUIen04IBbJKiDBBzHMElrmT4iWHQWz/8/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDLKL8/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ECCC4CEF0;
	Thu, 25 Sep 2025 15:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758813102;
	bh=Umyfp7Cz0bjSndzsCHElLy4MOPUmYAH6cd4OMZd0puU=;
	h=From:To:Cc:Subject:Date:From;
	b=vDLKL8/QdNL65/6RtGkOOax16dlSNVp4OGqEy2gsMGDvVotLip/ThUM5Y0CNTEmyq
	 DHfsYFMX7cq+i10pijizL/kdOi2VvF5vWNtspp7hpQwXyGVpOwdqTgyTCLxPSNDqaq
	 ersUsSR6H5JXxdmW1DQRgeRFCmVheba7fXQGDG4kx0JKnBhnzA6EKh/1a4QuAZA84M
	 Bgt5zUjIPOx35dSn3Lylt7I/a8tPUnX3EcZtk57uHzVkDUayvcUvBdO2noER3OUQn5
	 +9mbGKcda8YiqpDF7iMzNjUCqe8w4iYDCOIumTOOyavJv05Kf4JV/w7lAZTTN/u8Dm
	 ywGvASHljGWcg==
From: Chuck Lever <cel@kernel.org>
To: <linux-fsdevel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Volker Lendecke <Volker.Lendecke@sernet.de>
Subject: [RFC PATCH] fs: Plumb case sensitivity bits into statx
Date: Thu, 25 Sep 2025 11:11:40 -0400
Message-ID: <20250925151140.57548-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Both the NFSv3 and NFSv4 protocols enable NFS clients to query NFS
servers about the case sensitivity and case preservation behaviors
of shared file systems. Today, the Linux NFSD implementation
unconditionally returns "the export is case sensitive and case
preserving".

However, a few Linux in-tree file system types appear to have some
ability to handle case-folded filenames. Some of our users would
like to exploit that functionality from their non-POSIX NFS clients.

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding a statx API for this
purpose. Introduce a sample producer and a sample consumer for this
information.

If this mechanism seems sensible, a future patch might add a similar
field to the user-space-visible statx structure. User-space file
servers already use a variety of APIs to acquire this information.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Cc: Volker Lendecke <Volker.Lendecke@sernet.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fat/file.c             |  5 +++++
 fs/nfsd/nfs3proc.c        | 35 +++++++++++++++++++++++++++--------
 include/linux/stat.h      |  1 +
 include/uapi/linux/stat.h | 15 +++++++++++++++
 4 files changed, 48 insertions(+), 8 deletions(-)

I'm certain this RFC patch has a number of problems, but it should
serve as a discussion point.


diff --git a/fs/fat/file.c b/fs/fat/file.c
index 4fc49a614fb8..8572e36d8f27 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -413,6 +413,11 @@ int fat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->result_mask |= STATX_BTIME;
 		stat->btime = MSDOS_I(inode)->i_crtime;
 	}
+	if (request_mask & STATX_CASE_INFO) {
+		stat->result_mask |= STATX_CASE_INFO;
+		/* STATX_CASE_PRESERVING is cleared */
+		stat->case_info = statx_case_ascii;
+	}
 
 	return 0;
 }
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7..b319d1c4385c 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -697,6 +697,31 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+static __be32
+nfsd3_proc_case(struct svc_fh *fhp, struct nfsd3_pathconfres *resp)
+{
+	struct path p = {
+		.mnt		= fhp->fh_export->ex_path.mnt,
+		.dentry		= fhp->fh_dentry,
+	};
+	u32 request_mask = STATX_CASE_INFO;
+	struct kstat stat;
+	__be32 nfserr;
+
+	nfserr = nfserrno(vfs_getattr(&p, &stat, request_mask,
+				      AT_STATX_SYNC_AS_STAT));
+	if (nfserr != nfs_ok)
+		return nfserr;
+	if (!(stat.result_mask & STATX_CASE_INFO))
+		return nfs_ok;
+
+	resp->p_case_insensitive =
+		stat.case_info & STATX_CASE_FOLDING_TYPE ? 0 : 1;
+	resp->p_case_preserving =
+		stat.case_info & STATX_CASE_PRESERVING ? 1 : 0;
+	return nfs_ok;
+}
+
 /*
  * Get pathconf info for the specified file
  */
@@ -722,17 +747,11 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
 
-		/* Note that we don't care for remote fs's here */
-		switch (sb->s_magic) {
-		case EXT2_SUPER_MAGIC:
+		if (sb->s_magic == EXT2_SUPER_MAGIC) {
 			resp->p_link_max = EXT2_LINK_MAX;
 			resp->p_name_max = EXT2_NAME_LEN;
-			break;
-		case MSDOS_SUPER_MAGIC:
-			resp->p_case_insensitive = 1;
-			resp->p_case_preserving  = 0;
-			break;
 		}
+		resp->status = nfsd3_proc_case(&argp->fh, resp);
 	}
 
 	fh_put(&argp->fh);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index e3d00e7bb26d..abb47cbb233a 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -59,6 +59,7 @@ struct kstat {
 	u32		atomic_write_unit_max;
 	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
+	u32		case_info;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1686861aae20..e929b30d64b6 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -219,6 +219,7 @@ struct statx {
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_CASE_INFO		0x00040000U	/* Want/got case folding info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -257,4 +258,18 @@ struct statx {
 #define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
+/*
+ * File system support for case folding is available via a bitmap.
+ */
+#define STATX_CASE_PRESERVING		0x80000000 /* File name case is preserved */
+
+/* Values stored in the low-order byte of .case_info */
+enum {
+	statx_case_sensitive = 0,
+	statx_case_ascii,
+	statx_case_utf8,
+	statx_case_utf16,
+};
+#define STATX_CASE_FOLDING_TYPE		0x000000ff
+
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.51.0


