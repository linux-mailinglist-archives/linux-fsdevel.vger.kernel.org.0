Return-Path: <linux-fsdevel+bounces-65997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E258C1799F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6E04015C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8427B34F;
	Wed, 29 Oct 2025 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b58waeWA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C862D2388;
	Wed, 29 Oct 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698620; cv=none; b=Eos56Sb99GGnzPhLm6wAmgwG6yDdsZImlEhHugiz3OZCCpwrF8m1Gq+g4g5zYBC4xDkELzhxFb4MrwngFB4kTZovoDMQb6K8jrb47qCMRXOCpsxjz8UJVWBGDJaEwgxCfLRlIldnCCx3/yiToghlA3GFXf3/eKmNnhaTDgrMOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698620; c=relaxed/simple;
	bh=OXpf+dR2fREEvyAApXEHNaiLTYLqbihu5K0F3+19zPI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZMkPFr/o6ZvXC32oM1lbx1VakygmX0Xz5sDyV9Wo8rldc0+TDmZtswA9JFhk6HirMrM3FaB7GUn2Ge+x8aQz8HJmUKiyiKHc/O/GGVpF37yx05zDHBiVxxNSIxs1FIdJ9p9Zmrr0XC2Qe4bdU1KUi3ZOwR+L6XqD2pg/UJCUTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b58waeWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55ECC4CEE7;
	Wed, 29 Oct 2025 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698619;
	bh=OXpf+dR2fREEvyAApXEHNaiLTYLqbihu5K0F3+19zPI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=b58waeWAXdnVobUVeqqzRJ8pdaxOw54Os4xFKck4XXerwEpj5huYuVZvjbHOO7M6J
	 6Ih9nf35w5PdyQ+HZk3uk9YJIXXeCn/sfnXVhQuoiJ70rjypqA/ta+EsGaCIDcpgwy
	 uNjulMxEmOzwa/7cjcp2WRo4BszVIJ+OdXvcWqH4mTPZy4DvzMipIsjOVSAHWz4Voi
	 3O/+38vt7xbxSOXf6+vQ1OSJt1g0I8sCUpWRSFLDJgESyMIMlMMFQrpu85Rf+bBMox
	 FPIqG7t+D2hdXYACFMjVFZq8vahAUBnXlqJRgmWEN5Uw5nsL29Midqtoxz7RICYFby
	 Plg1oSP9f2I3w==
Date: Tue, 28 Oct 2025 17:43:39 -0700
Subject: [PATCH 3/5] fuse: implement file attributes mask for statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809317.1424347.1031452366030061035.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Actually copy the attributes/attributes_mask from userspace.  Ignore
file attributes bits that the VFS sets (or doesn't set) on its own.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/fuse_i.h |   37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c    |    4 ++++
 fs/fuse/inode.c  |    4 ++++
 3 files changed, 45 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a8068bee90af57..8c47d103c8ffa6 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -140,6 +140,10 @@ struct fuse_inode {
 	/** Version of last attribute change */
 	u64 attr_version;
 
+	/** statx file attributes */
+	u64 statx_attributes;
+	u64 statx_attributes_mask;
+
 	union {
 		/* read/write io cache (regular file only) */
 		struct {
@@ -1235,6 +1239,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 				   u64 attr_valid, u32 cache_mask,
 				   u64 evict_ctr);
 
+/*
+ * These statx attribute flags are set by the VFS so mask them out of replies
+ * from the fuse server for local filesystems.  Nonlocal filesystems are
+ * responsible for enforcing and advertising these flags themselves.
+ */
+#define FUSE_STATX_LOCAL_VFS_ATTRIBUTES (STATX_ATTR_IMMUTABLE | \
+					 STATX_ATTR_APPEND)
+
+/*
+ * These statx attribute flags are set by the VFS so mask them out of replies
+ * from the fuse server.
+ */
+#define FUSE_STATX_VFS_ATTRIBUTES (STATX_ATTR_AUTOMOUNT | STATX_ATTR_DAX | \
+				   STATX_ATTR_MOUNT_ROOT)
+
+static inline u64 fuse_statx_attributes_mask(const struct inode *inode,
+					     const struct fuse_statx *sx)
+{
+	if (fuse_inode_is_exclusive(inode))
+		return sx->attributes_mask & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					       FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes_mask & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
+static inline u64 fuse_statx_attributes(const struct inode *inode,
+					const struct fuse_statx *sx)
+{
+	if (fuse_inode_is_exclusive(inode))
+		return sx->attributes & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					  FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
 u32 fuse_get_cache_mask(struct inode *inode);
 
 /**
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a132..636d47a5127ca1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1271,6 +1271,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+		stat->attributes |= fuse_statx_attributes(inode, sx);
+		stat->attributes_mask |= fuse_statx_attributes_mask(inode, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1375,6 +1377,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
 		}
+		stat->attributes = fi->statx_attributes;
+		stat->attributes_mask = fi->statx_attributes_mask;
 	}
 
 	return err;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d048d634ef46f5..76e5b7f5c980c2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -286,6 +286,10 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 			fi->i_btime.tv_sec = sx->btime.tv_sec;
 			fi->i_btime.tv_nsec = sx->btime.tv_nsec;
 		}
+
+		fi->statx_attributes = fuse_statx_attributes(inode, sx);
+		fi->statx_attributes_mask = fuse_statx_attributes_mask(inode,
+								       sx);
 	}
 
 	if (attr->blksize)


