Return-Path: <linux-fsdevel+bounces-74145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22FD32FA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF45131640F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FD3A1A3A;
	Fri, 16 Jan 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quxKbuXH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580D1E0E08;
	Fri, 16 Jan 2026 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574812; cv=none; b=hnoQsFoq5FsqeIuY3G8wsUqIkpVd+ra7MYnSmppjbpTaMTbIOPUuA6A/d5XfQNvgnGGp06kj4KOuGxs4euafF+AFmJOMPBlwyV2jqdOtTmJMgop2xztRob4pwBIq3p4dt6Nl6gqFgP2RaHGaJ+c6vytq4xegYR7b3tqa7ts0eIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574812; c=relaxed/simple;
	bh=ybvM1kaY1V4Mcy01w16uCg2E273b09cBL9S5NnTYbjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBbB63hO1XLydAVhvYUh0Bi1SMrUEyBUqUMJgv20OQoju65R/6WFUcpyDJcxSHSgGEsFADrsgXeuqMOt4nRXfEjgrpBpiymYPi/3AzrkXwaEKirpMQkRwUhxZj7VSpe+AB1k3UMlEaHYyppvfUm6daNAZGPzGDzSrvfdSj746jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quxKbuXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DADC116C6;
	Fri, 16 Jan 2026 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574812;
	bh=ybvM1kaY1V4Mcy01w16uCg2E273b09cBL9S5NnTYbjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quxKbuXH4ltSxHIOiG68eNXOIVEKsO70Kmy7Rc8y1HnfCWWjculMS2agyfiRCQ/sf
	 8tZZAILjFJCnOAa+oYmde45XeZwAI7Is3pB+A5X+0SH+vUAe4j705LqTMgceGboz5t
	 R4R0Kr2W06WhLSVDvcnFbB+gyi2Qg/xUCJPn3iP0eRDiy6qKIM68lTWRwQVwMgsS9k
	 7AUTHWgsUoKzN7o7e1UIQr4nGq6f/jkQ/1p0Vos6Qlxvjw/oRtbd24iay+puVsILd3
	 d5aVRgYdPolkzFBWm3hI0jsWSGxL2cULIfP3heDQzUyJt/iypKvNhAxXi+cnn6b/qH
	 7C00AwrcO2TiA==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: [PATCH v5 13/16] isofs: Implement fileattr_get for case sensitivity
Date: Fri, 16 Jan 2026 09:46:12 -0500
Message-ID: <20260116144616.2098618-14-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116144616.2098618-1-cel@kernel.org>
References: <20260116144616.2098618-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need a way to query whether a
filesystem handles filenames in a case-sensitive manner so
they can provide correct semantics to remote clients. Without
this information, NFS exports of ISO 9660 filesystems cannot
properly advertise their filename case behavior.

Implement isofs_fileattr_get() to report ISO 9660 case
handling behavior. The 'check=r' (relaxed) mount option
enables case-insensitive lookups, and this setting determines
the value reported through the file_kattr structure. By
default, Joliet extensions operate in relaxed mode while plain
ISO 9660 uses strict (case-sensitive) mode. All ISO 9660
variants are case-preserving, meaning filenames are stored
exactly as they appear on the disc.

The callback is registered only on isofs_dir_inode_operations
because isofs has no custom inode_operations for regular
files, and symlinks use the generic page_symlink_inode_operations.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 09df40b612fb..7f95ddeb5991 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -12,6 +12,7 @@
  *  isofs directory handling functions
  */
 #include <linux/gfp.h>
+#include <linux/fileattr.h>
 #include "isofs.h"
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
@@ -266,6 +267,15 @@ static int isofs_readdir(struct file *file, struct dir_context *ctx)
 	return result;
 }
 
+static int isofs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	struct isofs_sb_info *sbi = ISOFS_SB(dentry->d_sb);
+
+	/* ISO 9660 preserves case (the default). */
+	fa->case_insensitive = sbi->s_check == 'r';
+	return 0;
+}
+
 const struct file_operations isofs_dir_operations =
 {
 	.llseek = generic_file_llseek,
@@ -279,6 +289,7 @@ const struct file_operations isofs_dir_operations =
 const struct inode_operations isofs_dir_inode_operations =
 {
 	.lookup = isofs_lookup,
+	.fileattr_get = isofs_fileattr_get,
 };
 
 
-- 
2.52.0


