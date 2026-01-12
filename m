Return-Path: <linux-fsdevel+bounces-73284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1C0D148B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841753114E2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFE337F758;
	Mon, 12 Jan 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVpUgMZe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E5137E2FE;
	Mon, 12 Jan 2026 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240001; cv=none; b=WgebAsnzYlvJ1U+4HUTiFh2oG/f/X2XvWlvFgZSFi91NpXFRiV0PQ/Vu0MSJE/C+t3hP8DOFmiU/DShxaUMnCALJgUWODz2EYz43oQCKCeAA9ROJy23WVg7WNwJMFZjWeVRm1UrLEblF9Pg4MWU2RV9KH7y2iw+NZBN86uq12Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240001; c=relaxed/simple;
	bh=ZdmolEf7aMS93qvpWlwlmeIbSixEvC9LnO2arPDBgRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDEynqBq8pbjXe1eRpSQh8BVrHS+OhAh0XjpNpRJ/3jI83Uv+NbNjMWzyToo0f4bVr5HaWXdHet6OOIHv5GYVv1IxCPS+RAQV7rjrlf2oDj4t3/XoHkTAG/BoAI+i7r8eTDsQWKJbkAfJwxS3WRdowg3gj4uYSHZEiWaCaxw/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVpUgMZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB17BC2BCB7;
	Mon, 12 Jan 2026 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768239999;
	bh=ZdmolEf7aMS93qvpWlwlmeIbSixEvC9LnO2arPDBgRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVpUgMZe8pjgAKS6qXuLuKdREdB1T1R6X6kgK2sCjR/n2VWHQJp1zSAKc8xAQp21l
	 VcGs6N8AemeD+dN85eQ4zb6ZPxzUDo7bJICPReQ8q/1M4vlTc6t8rqtPu9YDPBcJqV
	 EMGWJisvUomZMNzeYWNij/rHJnMZOQTX6cbz3WU8LmJlRC9TF3MbDZgNYhRMQTr/F7
	 v76Zysu70moFD3IY60Fzb3DmQnO80tshioDVBPd5atr7VmfIidBsbtao8BBJncmhOe
	 +bkEOJ6o0RRyX9rnuZd6B85m3NvCGxneufI5W/2cLCEJCe1lZL+48InwDnBg1N86wm
	 /52V56C+h1V8A==
From: Chuck Lever <cel@kernel.org>
To: vira@web.codeaurora.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: <linux-fsdevel@vger.kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	<linux-nfs@vger.kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 01/16] fs: Add case sensitivity info to file_kattr
Date: Mon, 12 Jan 2026 12:46:14 -0500
Message-ID: <20260112174629.3729358-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112174629.3729358-1-cel@kernel.org>
References: <20260112174629.3729358-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding case_insensitive and
case_preserving boolean fields to struct file_kattr.

The default POSIX behavior (case-sensitive, case-preserving) is
initialized in vfs_fileattr_get(), allowing filesystems to override
these values only when they differ from the default.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 10 ++++++++++
 include/linux/fileattr.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..a73de0e0ecac 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -21,6 +21,9 @@
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 {
 	memset(fa, 0, sizeof(*fa));
+	/* Default: POSIX semantics (case-sensitive, case-preserving) */
+	fa->case_insensitive = false;
+	fa->case_preserving = true;
 	fa->fsx_valid = true;
 	fa->fsx_xflags = xflags;
 	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
@@ -51,6 +54,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
 void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 {
 	memset(fa, 0, sizeof(*fa));
+	/* Default: POSIX semantics (case-sensitive, case-preserving) */
+	fa->case_insensitive = false;
+	fa->case_preserving = true;
 	fa->flags_valid = true;
 	fa->flags = flags;
 	if (fa->flags & FS_SYNC_FL)
@@ -84,6 +90,10 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
+	/* Default: POSIX semantics (case-sensitive, case-preserving) */
+	fa->case_insensitive = false;
+	fa->case_preserving = true;
+
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f89dcfad3f8f..cfd4d3973716 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -51,6 +51,9 @@ struct file_kattr {
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
+	/* case sensitivity behavior: */
+	bool	case_insensitive:1;
+	bool	case_preserving:1;
 };
 
 int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa);
-- 
2.52.0


