Return-Path: <linux-fsdevel+bounces-73292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B6D14866
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E63FD302DCA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAE73816E7;
	Mon, 12 Jan 2026 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAdfgj/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175C937E312;
	Mon, 12 Jan 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240020; cv=none; b=Uefjxd8+bahJz7iFTDHjT309fKxuUosjAaEw6gHNShV7W6zbn8M0iQ3ZlStCbbZHjNG2wBJb8obtPRJk4fQU2HnxspmOQbicklOMo01fpwElHAxaASsIua7gAaqbI4G7g3vFAz4SZPf0+h9eKcnyO8GnGA4JDCpL15QQEEkLONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240020; c=relaxed/simple;
	bh=At0fQCc3FQ3zKNDHqidvloik5FrnQ4NzzfoSuAvgNIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIgZ3pHhh2Dji9uGUG0eAwEzzUsptulFA132zcs35zFny17reR2xkwmivRBQNdA9QxXqfuDjreVUOQ9qrGdrJXdDXX9pdOI1Tphf57y2LIVOZyGFVyT/Eh1e3Ca1jL2oa5O+f0AXKZLP5ac12dyfDpjwkjsu33UZ1s7Q7IYXGkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAdfgj/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A99CC19422;
	Mon, 12 Jan 2026 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240019;
	bh=At0fQCc3FQ3zKNDHqidvloik5FrnQ4NzzfoSuAvgNIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAdfgj/yAUCl9caiUT16MzbxiGTHUBrmOwV1L/HdFQI6NvlS9sQha3Fg0KoIYcE5s
	 eTSiENNe7Iy3Av6ixqojz26FEZ9wNtCZVf6oWhzwd9s97UYKC5mgUUuv9mdG/Vzj8w
	 2XrHWORQCdTbIRevKlNiiBkQjmkbBs7LEgajxbcGh7dhoiM7QOrA9fCFL7364fqogH
	 fAqwnKZN7gwEw8mgPk81zex34j1C10eyxAP4vnBcqvMJcOa6drVM3ZJv0Ljr63fy6n
	 XtFfv5PtJOLM/cgmg+2JBRvPUFLTuyB2Zb2l1pKV8UmE/p0NAIS/995S5G5Jgnqj5n
	 A5DLnquShCjPw==
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
Subject: [PATCH v3 09/16] cifs: Implement fileattr_get for case sensitivity
Date: Mon, 12 Jan 2026 12:46:22 -0500
Message-ID: <20260112174629.3729358-10-cel@kernel.org>
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
 fs/smb/client/cifsfs.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d9664634144d..407afe60ee6c 100644
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
@@ -1193,6 +1194,21 @@ struct file_system_type smb3_fs_type = {
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
 
+static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+
+	/*
+	 * CIFS/SMB servers are typically case-insensitive but
+	 * case-preserving. The nocase mount option reflects what
+	 * the client expects from the server.
+	 */
+	fa->case_insensitive = tcon->nocase;
+	fa->case_preserving = true;
+	return 0;
+}
+
 const struct inode_operations cifs_dir_inode_ops = {
 	.create = cifs_create,
 	.atomic_open = cifs_atomic_open,
@@ -1210,6 +1226,7 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1220,6 +1237,7 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
@@ -1254,6 +1272,7 @@ const struct inode_operations cifs_symlink_inode_ops = {
 	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
+	.fileattr_get = cifs_fileattr_get,
 };
 
 /*
-- 
2.52.0


