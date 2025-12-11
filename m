Return-Path: <linux-fsdevel+bounces-71131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C6CB6537
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA528304BE52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4011313E0D;
	Thu, 11 Dec 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaxXQ/lY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFED304BA8;
	Thu, 11 Dec 2025 15:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466517; cv=none; b=JOZGriuE9lkItZ57MJr+bsd+9kZG7RXVCDFqL0UfQXJd6eqCXWpaO3fb7kezdliHfXwUDEmUopeJGbWHCzW12j8BI3ktF6bsS5yihetavouOJywCMOCoBfyZaOgGMZtukIcbg222Vlr76DvQGpICMrZLv+Sf1EkFbI770L3FxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466517; c=relaxed/simple;
	bh=U7ryZOjkKzyCRiNm/3E/bSllYVtAQKU16z9oyKpwqt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6QTa/AnHsYwyU35FF4JKvr5PGXvKzDhruE3jDu0CYl5hsaTtHSNygTnUPtrgVx16Iyz1YzgO8JvCUVUEEhmpgvu3imzr4XdwNzBXRTsrK6ApqQqBPlUc3GvIvk8xLALlODWNzeg5w2toD20kAHe5ahMXHgBJUnHEF5dID2/+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaxXQ/lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597A6C4CEF7;
	Thu, 11 Dec 2025 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765466517;
	bh=U7ryZOjkKzyCRiNm/3E/bSllYVtAQKU16z9oyKpwqt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaxXQ/lYsBHNoq+e4Zte/y/Su97YYlGa6K5nufOfFMGHEOXmMa6H52+WVldbHLOM7
	 ToQDH8xKrtTFzq9tH9Xijd6xDHfLFY0eb+aqeBKKDFHZKehJ0UBUbf8LPniGYiTU1L
	 cHj9p/bPc9fG8mH9GTtW1QJ6hHSy51velk4Ketjf/yUQE0egPAUGyljUgue01qWAh3
	 Iqqz8xCJ01ulDZh/48Ghzwb+d7z3DrXP1LK8BuxN6KU7TDE4ZbVTXg0cdgsBzg35uz
	 XPfS92vu02T7PUKC/C06z2Ywb/SNdLl9tLy317QFy1cljb86CbYhfafhvNxxSsBlWx
	 9W9RWGRHQi4nQ==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	hirofumi@mail.parknet.co.jp,
	almaz.alexandrovich@paragon-software.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	Volker.Lendecke@sernet.de,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/6] nfsd: Report export case-folding via NFSv3 PATHCONF
Date: Thu, 11 Dec 2025 10:21:15 -0500
Message-ID: <20251211152116.480799-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211152116.480799-1-cel@kernel.org>
References: <20251211152116.480799-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Replace the hard-coded MSDOS_SUPER_MAGIC check in
nfsd3_proc_pathconf() with a real check of the export's case
behavior settings. Filesystems that implement ->fileattr_get can
then report their case sensitivity behavior to NFSv3 clients. For
filesystems without ->fileattr_get, the default POSIX behavior
(case-sensitive, case-preserving) is reported to NFSv3 clients.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 18 ++++++++++--------
 fs/nfsd/vfs.c      | 25 +++++++++++++++++++++++++
 fs/nfsd/vfs.h      |  2 ++
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7..c8c76819cfbc 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -721,17 +721,19 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 
 	if (resp->status == nfs_ok) {
 		struct super_block *sb = argp->fh.fh_dentry->d_sb;
+		bool case_insensitive, case_preserving;
 
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
+		}
+
+		resp->status = nfsd_get_case_info(&argp->fh,
+						  &case_insensitive,
+						  &case_preserving);
+		if (resp->status == nfs_ok) {
+			resp->p_case_insensitive = case_insensitive;
+			resp->p_case_preserving = case_preserving;
 		}
 	}
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9cb20d4aeab1..157ddf405a5d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -32,6 +32,7 @@
 #include <linux/writeback.h>
 #include <linux/security.h>
 #include <linux/sunrpc/xdr.h>
+#include <linux/fileattr.h>
 
 #include "xdr3.h"
 
@@ -2679,3 +2680,27 @@ nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 
 	return err? nfserrno(err) : 0;
 }
+
+/**
+ * nfsd_get_case_info - get case sensitivity info for a file handle
+ * @fhp: file handle that has already been verified
+ * @case_insensitive: output, true if the filesystem is case-insensitive
+ * @case_preserving: output, true if the filesystem preserves case
+ *
+ * Returns nfs_ok on success, or an nfserr on failure.
+ */
+__be32
+nfsd_get_case_info(struct svc_fh *fhp, bool *case_insensitive,
+		   bool *case_preserving)
+{
+	u32 case_info;
+	int err;
+
+	err = vfs_get_case_info(fhp->fh_dentry, &case_info);
+	if (err)
+		return nfserrno(err);
+
+	*case_insensitive = (case_info & FILEATTR_CASEFOLD_TYPE) != 0;
+	*case_preserving = (case_info & FILEATTR_CASE_PRESERVING) != 0;
+	return nfs_ok;
+}
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 0c0292611c6d..a80177744325 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -154,6 +154,8 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh *,
 			     loff_t *, struct readdir_cd *, nfsd_filldir_t);
 __be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
 				struct kstatfs *, int access);
+__be32		nfsd_get_case_info(struct svc_fh *fhp, bool *case_insensitive,
+				bool *case_preserving);
 
 __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
 				struct dentry *dentry, int acc);
-- 
2.52.0


