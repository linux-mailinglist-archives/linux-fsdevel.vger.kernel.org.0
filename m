Return-Path: <linux-fsdevel+bounces-73744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D07C0D1F769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AB993019A4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C351399A58;
	Wed, 14 Jan 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srmKTD0Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A0280331;
	Wed, 14 Jan 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400976; cv=none; b=llUleHC3paBO11Zq+CRSrIE8VFHQm8RUvLhQQDpP/4inPiOZzZRVv1QAfgFbsF0XXQShOGeC/SHXAw7rxTNeKcuqZm12kZwYAVWRVxZuEabgJ9z5eDDOrga7vG64H3NG6ozQCtGZcpeBgzDf6/Vh9t7Qq7mwJ/hNdk56OAK6bcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400976; c=relaxed/simple;
	bh=ybvM1kaY1V4Mcy01w16uCg2E273b09cBL9S5NnTYbjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsttqX0QeyTCDrKvmcfzp9v1BGvv7BBT9koMkueCiem5L0MyJMeZD384EClBydhKrJtJh+GMyJCbPY0qE7I71JjZ7Fzdn/yevZ5yxfraGC/m1n5teZl8E/Qfw5RG1GoVXws4yfFozxdr1uQUNWcXrtkXNeX9jQJkwCR73JKDtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srmKTD0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45245C4CEF7;
	Wed, 14 Jan 2026 14:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400976;
	bh=ybvM1kaY1V4Mcy01w16uCg2E273b09cBL9S5NnTYbjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srmKTD0QtMAIoXojQGafdEDUElJSbxtqMqloz9Mx0GcoduChcl0eAXHJw0a0+e10O
	 U77kOjg5e4xVgxSXcxTG2pmKkAWitNvg5OGncIin1CtfawcIeMpNHEuxP3Qhw7iaKJ
	 Z6w0NMRlGK1GoulyNAY2+0UH51mTwakmIESBpk4MwattCRB0wIQwi4AuB+TPIvIXxO
	 SFSMwpCptdmoSXunk+vV/vzf7E7D2jG0+Jm9Qrt/+ESrpkLf1cb/bpg/e4aBQK3jvu
	 0hTVE72zWYT/6L/zATk24TOG0jG0wj+0ehlLpnnZzzWxGgkti3vcNOWhFufDnvCF31
	 d0szph0umN1gw==
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
Subject: [PATCH v4 13/16] isofs: Implement fileattr_get for case sensitivity
Date: Wed, 14 Jan 2026 09:28:56 -0500
Message-ID: <20260114142900.3945054-14-cel@kernel.org>
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


