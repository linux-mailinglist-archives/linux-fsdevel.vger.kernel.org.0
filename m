Return-Path: <linux-fsdevel+bounces-73734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A19D1F736
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 15:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EAB930341A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05AB346AC2;
	Wed, 14 Jan 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md86zwaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB3286416;
	Wed, 14 Jan 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400952; cv=none; b=U7BnkB8mdDvUYhId27jTSib6ozDNCWtOdYjQgCnLXlsf1ODGJP2Bm3RnFgM+7NkZQZhui9u6MHhFKQ1TOyxaf95bu2I+zsB0kxe784S8Kz4VclNvprfPnm3Nnnxs1Xc2zBeuxCH8rLRYGl2mkuurWZB0QCHuLTkBzbO2kgKa+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400952; c=relaxed/simple;
	bh=gPtw3ZLLZZRSLI07iJFdMb2S84stsgAkduqBQvCkNcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tjsz8o5akzTq4R9B0RluOMgSDiQtmuCJyHGk+hkOfivsB0RFGoSQJILRVqn4XbmCYGI/OE56FzgftwoE3i80vLgiOnsWzY/YQCojnVhbS/9hLYwy57h4KMwRdB5de4LtpWZP6dFviIaULoOWFFmfmAOKuiX1qWm0in+TBIrTORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md86zwaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C836CC4CEF7;
	Wed, 14 Jan 2026 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768400952;
	bh=gPtw3ZLLZZRSLI07iJFdMb2S84stsgAkduqBQvCkNcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=md86zwaHexGEH9VNF9A+QmZyd+jK75QPue6FL9OvZ1T6lqK4mJMzNn4oV4vSJ7DNr
	 A+YpHTlt9kwLylU6ft5eYAL5yl5yUVX+lK/rTmc4Anj0+poG+ocZAF4bz0LVs571D2
	 UhpTF96ypIXqapYmwj1oqxKblANt3QBTXDWMN34eub1Jy62MrepOBe7qfTNGQvjDvY
	 vCLygQoGdF5whCBKm3of6klTJd3id5a8kIY97uYsooKsSP4wZqUyArTRgMDLBknDI9
	 kco8EYknGa4KtSwzY+7FOQZvCKM8zapTTaJQNjC3KgAGc4JZdsG4b3arHS0A7MpbTm
	 edOJXhFrLd8DQ==
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
Subject: [PATCH v4 03/16] exfat: Implement fileattr_get for case sensitivity
Date: Wed, 14 Jan 2026 09:28:46 -0500
Message-ID: <20260114142900.3945054-4-cel@kernel.org>
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


