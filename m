Return-Path: <linux-fsdevel+bounces-73296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ADFD148A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 18:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA7C9301A4EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C02338171D;
	Mon, 12 Jan 2026 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvJTVLHx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569137F8A4;
	Mon, 12 Jan 2026 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240030; cv=none; b=CrNLbtlFQ7mjxXuRQbfnrQz3u5q/sMbDYN10KwLT4h1dIgtWbCP6R3BHQiAae+yw9QKz4PD7c2DuD+GDwfLEdBM9nbG3jDRSlsuwhnUu1/ND7UTeI+w0+LtwaGAkHKzhU1Rp8/mFLVGhYAqw8uHLopz0jgKkFL6Mw7AWBYZX4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240030; c=relaxed/simple;
	bh=q6kHQb/sJzXKx0Up0ATDcFUCwgxZAGk1F4yu/JZhQtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzd+rPiDdVXlCoFt2ySbhK0ITSFW7saUahWMz9oqp3H5YLLhSFh/yeGsbwnbRlTaXnSq38sP0kKCZ5+DYAo6f3PDZsZUs8ND9k1S3Lv0ZJSGgCZoxCFfW+eB+sy60wDSySL49Co/5riqWExlappzcYI/XMj/qA+pV+qlHEhJfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvJTVLHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1FFC2BC87;
	Mon, 12 Jan 2026 17:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240029;
	bh=q6kHQb/sJzXKx0Up0ATDcFUCwgxZAGk1F4yu/JZhQtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvJTVLHxPyJyyx/O2etEyMsukDeRV46zAjiiryP31Ndu8w7G6JMDP0649kvxozyKO
	 PFirLFjDkG/dbiirzhruI/XKwcM81wbhl/HcLRVjyN/4egAr3CdmRio1gJOomFrwfr
	 EVcXZL1JL8x2U1cJf6dy4ZLm/4IClxypRt416JHr75IQ+6oUSUVS/19nHG7PDdqgRg
	 WDF6wii3+FhxA9jrWYZM/sTtcpl+xQ8Kd5KC3rgc07Gnxp9lVaDx+mBvAvpz9160dh
	 3dUXdWx6J0sNRMik2OAu9acn0greSviSqjij5/Ht4UFEtHejIqghSswp5F3kPniOGJ
	 X9Cm70ztUm8Ww==
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
Subject: [PATCH v3 13/16] isofs: Implement fileattr_get for case sensitivity
Date: Mon, 12 Jan 2026 12:46:26 -0500
Message-ID: <20260112174629.3729358-14-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/isofs/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 09df40b612fb..717cdf726e83 100644
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
+	fa->case_insensitive = sbi->s_check == 'r';
+	fa->case_preserving = true;
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


