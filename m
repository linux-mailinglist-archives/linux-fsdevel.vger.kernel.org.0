Return-Path: <linux-fsdevel+bounces-14625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDFF87DECC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305A7B20BC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21A1CD3F;
	Sun, 17 Mar 2024 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubziP04Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7E1CD21;
	Sun, 17 Mar 2024 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693356; cv=none; b=V8BRem4zR38sh48GbwuV18yIRztRIGsufIr6WX8RtPUV1xto6ttOS/RErkNsd2Gi6ZMS9q2itSbOC3Qcjt2av3e8lqkDvQSwkZQIJrskbAHH9Kag7Tlg5e7Pr/wD/rz8dlxzxHJjYJDBY5nS71SkqBM3fMIikEgeEtg547MGwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693356; c=relaxed/simple;
	bh=XIY1Z9jhLjL9S2HQLE7A1RwuN2dPMKfHfNscD64WfCI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUZk8+TaY182lH07Ylwey9Pjx1qCK9384WiLzedI5Kv+vy3L9QQBfTxvdGrJ1/pwSQJsvbwXjpO0zqeY4UYttsPO6KI1U+MajbzwCCsOGQBEgPEu3eAVekbeYr75jW0Dl/7L6/8ehdkCmebgKxD5lxo3kv+CQlk9bgcel1nKMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubziP04Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60430C43601;
	Sun, 17 Mar 2024 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710693355;
	bh=XIY1Z9jhLjL9S2HQLE7A1RwuN2dPMKfHfNscD64WfCI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ubziP04YZW75Foz8PR5JaTNj5dId2E22SoGnYiIy906lyAVTUr+3DL0rQVNsckNNc
	 WqVJzZV3pz7b7BB3KtXIu38iE4n/SPrGUCo1fbbntYtUdZR2oykFsREU1dKjBMuBg2
	 rlI4QhrQsSVUj9XtmlM+e5QIiPiwJMkDGqGVwAk3VA1BII0eUT36uVW5OV+v5TXwUR
	 jdC8FUJGAleoovaZNonz1vYLSLpWFgdy8VxniX65S6YL/v+EVMGAdcEYLJAET4G7hV
	 iEI76FwJNY7DMp4FMYFICmskUiwtUb2kjak1XWFJzIcv7xVu6TRMeoev8Yl3bTA6VY
	 s4hCIZLdpBzAg==
Date: Sun, 17 Mar 2024 09:35:54 -0700
Subject: [PATCH 08/20] xfs: add fs-verity support
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, djwong@kernel.org, cem@kernel.org,
 ebiggers@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171069247785.2685643.2517312697309625579.stgit@frogsfrogsfrogs>
In-Reply-To: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
References: <171069247657.2685643.11583844772215446491.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

Add integration with fs-verity. The XFS store fs-verity metadata in
the extended file attributes. The metadata consist of verity
descriptor and Merkle tree blocks.

The descriptor is stored under "vdesc" extended attribute. The
Merkle tree blocks are stored under binary indexes which are offsets
into the Merkle tree.

When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
flag is set meaning that the Merkle tree is being build. The
initialization ends with storing of verity descriptor and setting
inode on-disk flag (XFS_DIFLAG2_VERITY).

The verification on read is done in read path of iomap.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: replace caching implementation with an xarray, other cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 libxfs/xfs_attr.c      |   12 ++++++++++++
 libxfs/xfs_da_format.h |   32 ++++++++++++++++++++++++++++++++
 libxfs/xfs_ondisk.h    |    4 ++++
 3 files changed, 48 insertions(+)


diff --git a/libxfs/xfs_attr.c b/libxfs/xfs_attr.c
index a9241d18..30cf3688 100644
--- a/libxfs/xfs_attr.c
+++ b/libxfs/xfs_attr.c
@@ -1565,6 +1565,18 @@ xfs_attr_namecheck(
 		return xfs_verify_pptr(mp, (struct xfs_parent_name_rec *)name);
 	}
 
+	if (flags & XFS_ATTR_VERITY) {
+		/* Merkle tree pages are stored under u64 indexes */
+		if (length == sizeof(struct xfs_verity_merkle_key))
+			return true;
+
+		/* Verity descriptor blocks are held in a named attribute. */
+		if (length == XFS_VERITY_DESCRIPTOR_NAME_LEN)
+			return true;
+
+		return false;
+	}
+
 	return xfs_str_attr_namecheck(name, length);
 }
 
diff --git a/libxfs/xfs_da_format.h b/libxfs/xfs_da_format.h
index 3a35ba58..2d2314a5 100644
--- a/libxfs/xfs_da_format.h
+++ b/libxfs/xfs_da_format.h
@@ -919,4 +919,36 @@ struct xfs_parent_name_irec {
 	uint8_t			p_namelen;
 };
 
+/*
+ * fs-verity attribute name format
+ *
+ * Merkle tree blocks are stored under extended attributes of the inode. The
+ * name of the attributes are byte offsets into merkle tree.
+ */
+struct xfs_verity_merkle_key {
+	__be64	vi_merkleoff;
+};
+
+static inline void
+xfs_verity_merkle_key_to_disk(
+	struct xfs_verity_merkle_key	*key,
+	uint64_t			offset)
+{
+	key->vi_merkleoff = cpu_to_be64(offset);
+}
+
+static inline uint64_t
+xfs_verity_merkle_key_from_disk(
+	const void			*attr_name)
+{
+	const struct xfs_verity_merkle_key *key = attr_name;
+
+	return be64_to_cpu(key->vi_merkleoff);
+}
+
+
+/* ondisk xattr name used for the fsverity descriptor */
+#define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
+#define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
+
 #endif /* __XFS_DA_FORMAT_H__ */
diff --git a/libxfs/xfs_ondisk.h b/libxfs/xfs_ondisk.h
index 81885a6a..16f4ef2f 100644
--- a/libxfs/xfs_ondisk.h
+++ b/libxfs/xfs_ondisk.h
@@ -194,6 +194,10 @@ xfs_check_ondisk_structs(void)
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MIN << XFS_DQ_BIGTIME_SHIFT, 4);
 	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
 			16299260424LL);
+
+	/* fs-verity xattrs */
+	XFS_CHECK_STRUCT_SIZE(struct xfs_verity_merkle_key,	8);
+	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME),	6);
 }
 
 #endif /* __XFS_ONDISK_H */


