Return-Path: <linux-fsdevel+bounces-61497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD97B58930
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6747A3B69B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AE31A0712;
	Tue, 16 Sep 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi+Lii71"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42C72639;
	Tue, 16 Sep 2025 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982322; cv=none; b=Eura8r3yU/V5S642hnRAz7Up4NcW1WE4R66YDYZz+d6oj3zez2FVI9CPhOAJd7AwgAgW7vYdf8Pwe8M3yDm2iko6hObaClJghTa5kvhU5UQoAdhBbBpwcE9jRjSby+RGUeUA+kV7jG0Gha8s2o4smjLuT0AA1LGdIkwmFqhza3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982322; c=relaxed/simple;
	bh=X8h+o2p/zYxScUmxW2dKs1WqVA1sxeEa835Mv6UvNiw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdZZMLrtpSaSiCdo6FeqsdX9PkQ5FAlMYjuicuHR5mlMLFOIvNUbvkMxe8qDzDbj/T9W5P2plDDq10Up4E44WKFOS9NdY1otYh1LBAA+wkbuZYhBl/8q6u0xhhvzbQ3b9cIj0Qrd+8vCeF2H/lzGjYAlRhnSOSioCSC5qmqk6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi+Lii71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A181C4CEF5;
	Tue, 16 Sep 2025 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982322;
	bh=X8h+o2p/zYxScUmxW2dKs1WqVA1sxeEa835Mv6UvNiw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Fi+Lii71ivDN1ld5rR2kkVluaA+AvclYPW8H3ndkY/8H9TjfRn+6SOcDki47NXQtT
	 oxaujXMkpxW552EL3ZOFfJcywPpqaGdKsZ8eiF/2y/FPDef8Sn7CT/klfnPfOh3Xcf
	 nGAHF0QuAbV9GkRfEyAS0A1O/lYg/rdyRvC39nUMM2BZbjm5VKPmeNac+F944tFozd
	 MQtTcpZ//fixmSvH6IC6dQy2RArW/ctnu/kw5qo2QWI65PfrVjh7SKSPzNDs+ySSEx
	 +HWd1mYG8ZeloUfve+IKea7VT/T5cD+5pyy8Raze9t4hwnfV0fNdr65/a+n2wBlDF+
	 6tYRLBqASYGAg==
Date: Mon, 15 Sep 2025 17:25:19 -0700
Subject: [PATCH 5/8] fuse: implement file attributes mask for statx
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, linux-xfs@vger.kernel.org,
 John@groves.net, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
 joannelkoong@gmail.com
Message-ID: <175798150135.381990.13601554069647977877.stgit@frogsfrogsfrogs>
In-Reply-To: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
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
 fs/fuse/inode.c  |    3 +++
 3 files changed, 44 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e13e8270f4f58d..52776b77efc0e4 100644
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
@@ -1221,6 +1225,39 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
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
+static inline u64 fuse_statx_attributes_mask(const struct fuse_conn *fc,
+					     const struct fuse_statx *sx)
+{
+	if (fc->local_fs)
+		return sx->attributes_mask & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					       FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes_mask & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
+static inline u64 fuse_statx_attributes(const struct fuse_conn *fc,
+					const struct fuse_statx *sx)
+{
+	if (fc->local_fs)
+		return sx->attributes & ~(FUSE_STATX_VFS_ATTRIBUTES |
+					  FUSE_STATX_LOCAL_VFS_ATTRIBUTES);
+	return sx->attributes & ~FUSE_STATX_VFS_ATTRIBUTES;
+}
+
 u32 fuse_get_cache_mask(struct inode *inode);
 
 /**
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f3d..a7f47e43692f1c 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1278,6 +1278,8 @@ static int fuse_do_statx(struct mnt_idmap *idmap, struct inode *inode,
 		stat->result_mask = sx->mask & (STATX_BASIC_STATS | STATX_BTIME);
 		stat->btime.tv_sec = sx->btime.tv_sec;
 		stat->btime.tv_nsec = min_t(u32, sx->btime.tv_nsec, NSEC_PER_SEC - 1);
+		stat->attributes |= fuse_statx_attributes(fm->fc, sx);
+		stat->attributes_mask |= fuse_statx_attributes_mask(fm->fc, sx);
 		fuse_fillattr(idmap, inode, &attr, stat);
 		stat->result_mask |= STATX_TYPE;
 	}
@@ -1382,6 +1384,8 @@ static int fuse_update_get_attr(struct mnt_idmap *idmap, struct inode *inode,
 			stat->btime = fi->i_btime;
 			stat->result_mask |= STATX_BTIME;
 		}
+		stat->attributes = fi->statx_attributes;
+		stat->attributes_mask = fi->statx_attributes_mask;
 	}
 
 	return err;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c8dd0bcb7e6f9f..55db991bb6b8c1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -287,6 +287,9 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
 			fi->i_btime.tv_sec = sx->btime.tv_sec;
 			fi->i_btime.tv_nsec = sx->btime.tv_nsec;
 		}
+
+		fi->statx_attributes = fuse_statx_attributes(fc, sx);
+		fi->statx_attributes_mask = fuse_statx_attributes_mask(fc, sx);
 	}
 
 	if (attr->blksize)


