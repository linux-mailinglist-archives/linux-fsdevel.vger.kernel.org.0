Return-Path: <linux-fsdevel+bounces-73740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA83D1F7BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6934D304CAD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5AB395248;
	Wed, 14 Jan 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF7jxiqy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0945F2DECDF;
	Wed, 14 Jan 2026 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400967; cv=none; b=MrVBpCkRALaXte84cPiDfjVboLKy8Lo2jvFkUd0ym05C9E89iul3WnwLq36VrpynaVcheXtRDqHsIUGQmfklfCllQfq1aUQDtTmQtxLqcTHuJGFQQ07FqK/9qb/sszlOJPrwoIoww2a4L7uKxo7PSOj+buSmTlX/2jp1TkARPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400967; c=relaxed/simple;
	bh=mRV56c9MAQ3HyUVZj75eGyg0E1dkWp35HLslkaK10es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuClnPe76BqwwwWTZZxYf1UOGXGX8d6nppE8lf97zhlwpXatYy1B8omdJZsM34bGsLLWy5CH6eItEHlHafK6DAQXqvbYiafkT5/TgwAbmuJGFzs4iKkxCzTYCIb9t+reR0Y7dVdQgs7rCYsP72QP9IZDjDbI1mbrEAuG7pFY7y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF7jxiqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74645C4CEF7;
	Wed, 14 Jan 2026 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400966;
	bh=mRV56c9MAQ3HyUVZj75eGyg0E1dkWp35HLslkaK10es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uF7jxiqyU5peWTlEMTMCtwSHJfHkq/KhdiFhmdWGa5ZWybfrw7M++mBZEH2Pa39H/
	 6HPItuDUcwpqiAmnb9XJI2AXKUt0pdbyWLLcGKYRSAv21laCz4+BacNfu4uLfRzux5
	 RJdqexVMleovKm+lnT7Ji+aeegLMYzktZBIhxtgnQVoG/UjB+kFuS+qbM++TsQZ59l
	 2N7BuegYeI0QllQrLAzvihNXd/UsMSVTUT+P0iurVDVrA6WHSun0U/aDcQRS2DOSKj
	 V/1JFhCkOzM7EBrp5eJopZRGORMKGM3HS6dgDbvklERhhAbD4f60Yxy2zE2fnAvSq6
	 vM9xLfOdBtgrA==
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
Subject: [PATCH v4 09/16] cifs: Implement fileattr_get for case sensitivity
Date: Wed, 14 Jan 2026 09:28:52 -0500
Message-ID: <20260114142900.3945054-10-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114142900.3945054-1-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a filesystem
handles filenames in a case-sensitive manner. The file_kattr
structure now provides case_insensitive and case_preserving fields
for this purpose, but CIFS does not yet report its case sensitivity
behavior through this interface.

Implement cifs_fileattr_get() to report CIFS/SMB case handling
behavior. CIFS servers (typically Windows or Samba) are usually
case-insensitive but case-preserving, meaning they ignore case
during lookups but store filenames exactly as provided.

The implementation reports case sensitivity based on the nocase
mount option, which reflects whether the client expects the server
to perform case-insensitive comparisons. When nocase is set, the
mount is reported as case-insensitive. The case_preserving field
is always set to true since SMB servers preserve filename case at
rest.

The callback is registered in all three inode_operations
structures (directory, file, and symlink) to ensure consistent
reporting across all inode types.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/smb/client/cifsfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d9664634144d..563eece79b13 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -30,6 +30,7 @@
 #include <linux/xattr.h>
 #include <linux/mm.h>
 #include <linux/key-type.h>
+#include <linux/fileattr.h>
 #include <uapi/linux/magic.h>
 #include <net/ipv6.h>
 #include "cifsfs.h"
@@ -1193,6 +1194,20 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+
+	/*
+	 * CIFS/SMB servers are typically case-insensitive and
+	 * case-preserving (the default). The nocase mount option
+	 * reflects what the client expects from the server.
+	 */
+	fa->case_insensitive = tcon->nocase;
+	return 0;
+}
+
 const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.atomic_open = cifs_atomic_open,
@@ -1210,6 +1225,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1220,6 +1236,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
@@ -1254,6 +1271,7 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 /*
-- 
2.52.0


