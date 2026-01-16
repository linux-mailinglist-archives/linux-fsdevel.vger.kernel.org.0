Return-Path: <linux-fsdevel+bounces-74135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD95D32FDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D5B5320FD26
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60ED397ABB;
	Fri, 16 Jan 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqIJkbkk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F218338906;
	Fri, 16 Jan 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574788; cv=none; b=K6qWNhMrftjA7j1dkHK6rpMZ/N72pFgbOQ5BQZ4YaYwxqFqCNZTcx1oGkofuI2EgGL8bBgEJUxYyB9/r88n39w5SJKgrGvs60f5+x2ynX1RlRazYEm4aGYpAw8BFZUbStSlEtqnfmY9EB+aLXAHmgIEsGGzLb7gYXojYX9LoHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574788; c=relaxed/simple;
	bh=gPtw3ZLLZZRSLI07iJFdMb2S84stsgAkduqBQvCkNcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5T3pfaoAhpFx1G8r3xXPpH8bxrP3TFNUr+IgxFvnUw52gJjo3joRcimC2WwQ5Wg3g8ujL5ZgMccaq3PijCszDf4JtXGjSAVbUinEMOJrluUs5DUDrwdiOr32uxixvbgGvlJCnZaZOn5DT9EdPCSDJTEyozSUqvFLzstubHU2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqIJkbkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AB3C16AAE;
	Fri, 16 Jan 2026 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574787;
	bh=gPtw3ZLLZZRSLI07iJFdMb2S84stsgAkduqBQvCkNcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hqIJkbkk8k4d3OCFOC3CpD1TuaLcp90SQYhwZnnDOI9qTFK466sSk639IKM9mQlGe
	 TEPdRDYseHAXtWaIwmG6hu+++oVPgLeAgfj6WRAri9LHrUeSKDmdy4XqkUEQyvPnjh
	 PoP5ZLI1Es/vksY8MNWhrdiFA6xVIDWiVOttlRftB+O6TLmAUfbZINLYbsu3DSJDhQ
	 b8irrEiogwSL8DRtlO7T/TKZhsYZhXJ46Odu/6NRgaZNMPI6PuN0PcuXUD0PMFYuxJ
	 IsqSFAvQcpHZGnrZ90PF2yV6/4P2Syo7gNpbC+U79/dRO3cSA9vUrH8yJ3BA3IquB+
	 lbybpPmKPEqMg==
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
Subject: [PATCH v5 03/16] exfat: Implement fileattr_get for case sensitivity
Date: Fri, 16 Jan 2026 09:46:02 -0500
Message-ID: <20260116144616.2098618-4-cel@kernel.org>
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

Report exFAT's case sensitivity behavior via the file_kattr boolean
fields. exFAT is always case-insensitive (using an upcase table for
comparison) and always preserves case at rest.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 16 ++++++++++++++--
 fs/exfat/namei.c    |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 176fef62574c..11c782a28843 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -468,6 +468,8 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, unsigned int request_mask,
 		  unsigned int query_flags);
+struct file_kattr;
+int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f0c1..79938072e1cb 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -12,6 +12,7 @@
 #include <linux/security.h>
 #include <linux/msdos_fs.h>
 #include <linux/writeback.h>
+#include <linux/fileattr.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -281,6 +282,16 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+int exfat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
+{
+	/*
+	 * exFAT is always case-insensitive (using upcase table).
+	 * Case is preserved at rest (the default).
+	 */
+	fa->case_insensitive = true;
+	return 0;
+}
+
 int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		  struct iattr *attr)
 {
@@ -775,6 +786,7 @@ const struct file_operations exfat_file_operations = {
 };
 
 const struct inode_operations exfat_file_inode_operations = {
-	.setattr     = exfat_setattr,
-	.getattr     = exfat_getattr,
+	.setattr	= exfat_setattr,
+	.getattr	= exfat_getattr,
+	.fileattr_get	= exfat_fileattr_get,
 };
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index dfe957493d49..a3a854ddc83a 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1323,4 +1323,5 @@ const struct inode_operations exfat_dir_inode_operations = {
 	.rename		= exfat_rename,
 	.setattr	= exfat_setattr,
 	.getattr	= exfat_getattr,
+	.fileattr_get	= exfat_fileattr_get,
 };
-- 
2.52.0


