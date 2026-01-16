Return-Path: <linux-fsdevel+bounces-74133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4B4D32E19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FFB4320BE47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFD2395252;
	Fri, 16 Jan 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWRg71n+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE4123D2B2;
	Fri, 16 Jan 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574783; cv=none; b=hSpK0529vBHWtqd0R6pJb+tcl5RsudNEwlxlEXmDr7CbYo8oi/TZnoxDeTGcaHiYjUg7boAVSVm+LarJMKrUpYufxj+d/sduWBtCmLPfxWOx97AO5oAvMD1asqkT5nTlDmet2/G/SmU0flh94KY0B763KH3Ux81VzzTJLOKgSn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574783; c=relaxed/simple;
	bh=a661ni48mgSpevVv8uV64JVotuwrk9w+dgDbRx0EyxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0/wbKmMiO4Pesi+5p/PWfupbd23ZysSgL/5Kf0yuIOrd/isbxqtnM42LPE3Tw8skOATENynyVfV67LSbihDaFtNtjN650QfPpBiMOdmKh27lpDJJ7lCV1y+6BryVBeicYf9vThyTBkzQM+y9Ylq6uJnSRRVC0dYflMbSIC6nHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWRg71n+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E496EC19425;
	Fri, 16 Jan 2026 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768574783;
	bh=a661ni48mgSpevVv8uV64JVotuwrk9w+dgDbRx0EyxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWRg71n+tKCudxlH674opbuV6KLPb1NgCP1VNATBFwFTxONYJHuezZIz0+e4wdvMd
	 hbpQLm7xtSjuodkx6bEAr5wfTgYScpUyqMvxUX+mK2c/LMQB0mzpgiCkNRmFtk+rfZ
	 RL9nqWksOEn89ztZCnfOs1wvv5dsrIFa+V1iskdnClEpd+UrLwqIVEkP8k3WtrUe+l
	 OJy170J4hCG/zmYGp+LrODiUE0PX54luFgAVHx4u7ZMXln5WKxGMn/YVwHQfIP+NoE
	 Og+cw08Wc7hnCgQs8sPXHvUUYYFInHYeBUmeyqYmHh6f3itNkX1wAGbNpCwthsQavv
	 yM3aHwHkotPuA==
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
Subject: [PATCH v5 01/16] fs: Add case sensitivity info to file_kattr
Date: Fri, 16 Jan 2026 09:46:00 -0500
Message-ID: <20260116144616.2098618-2-cel@kernel.org>
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

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding case_insensitive and
case_nonpreserving boolean fields to struct file_kattr.

The case_insensitive and case_nonpreserving fields in struct
file_kattr default to false (POSIX semantics: case-sensitive and
case-preserving), allowing filesystems to set them only when
behavior differs from the default.

Case sensitivity information is exported to userspace via the
existing fa_xflags field using the new FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING flags.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 6 ++++++
 include/linux/fileattr.h | 6 +++++-
 include/uapi/linux/fs.h  | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..2f83f3c6a170 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -84,6 +84,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
+	memset(fa, 0, sizeof(*fa));
+
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
@@ -106,6 +108,10 @@ static void fileattr_to_file_attr(const struct file_kattr *fa,
 	fattr->fa_nextents = fa->fsx_nextents;
 	fattr->fa_projid = fa->fsx_projid;
 	fattr->fa_cowextsize = fa->fsx_cowextsize;
+	if (fa->case_insensitive)
+		fattr->fa_xflags |= FS_XFLAG_CASEFOLD;
+	if (fa->case_nonpreserving)
+		fattr->fa_xflags |= FS_XFLAG_CASENONPRESERVING;
 }
 
 /**
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f89dcfad3f8f..7f2e557255ce 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -16,7 +16,8 @@
 
 /* Read-only inode flags */
 #define FS_XFLAG_RDONLY_MASK \
-	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | \
+	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
 
 /* Flags to indicate valid value of fsx_ fields */
 #define FS_XFLAG_VALUES_MASK \
@@ -51,6 +52,9 @@ struct file_kattr {
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
+	/* case sensitivity behavior: */
+	bool	case_insensitive:1;
+	bool	case_nonpreserving:1;
 };
 
 int copy_fsxattr_to_user(const struct file_kattr *fa, struct fsxattr __user *ufa);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 66ca526cf786..919148beaa8c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -253,6 +253,8 @@ struct file_attr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_CASEFOLD	0x00020000	/* case-insensitive lookups */
+#define FS_XFLAG_CASENONPRESERVING 0x00040000	/* case not preserved */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.52.0


