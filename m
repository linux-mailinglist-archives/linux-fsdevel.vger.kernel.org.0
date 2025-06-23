Return-Path: <linux-fsdevel+bounces-52503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A649AE394F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C852F1895AA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6523816B;
	Mon, 23 Jun 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmA5VqPF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FA23371A;
	Mon, 23 Jun 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669312; cv=none; b=cSopU4LPAwpLyakRdnACGJQ2qDWTHDby3lea/jWVSdbBP4aTToC9XN3vo1VhBmmciTg7Q+6JrD/QcKWYWdxMe7AGpI6YpUfuM5LJctZMEjyNcQ3RDD2yfIOMU7qMRbyZMbiv6t6s4+POFtys2MFUmiLugYmuPX+vDwS8BQGmaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669312; c=relaxed/simple;
	bh=CvxBZ7LMEusddaEnmi+qp2Gt0y7obk/qRay9Htbt5Ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hehpYNFMEIQW9tWqwq6sebTucTzqr7TyIxXVKyTcSSJJ987cG9RBqIdJgIOd2eH5I1o9RIlFs54KPsl1WL3eT5IwV/8zcXJ4Gxfug37L8UC0LjM7Z65C3rsDdesyfLU85KTGv9l96pHMcGlPgT7WApliFdg1wK9yHfEWV1v6R+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmA5VqPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA04C4CEEA;
	Mon, 23 Jun 2025 09:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669312;
	bh=CvxBZ7LMEusddaEnmi+qp2Gt0y7obk/qRay9Htbt5Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MmA5VqPFxyKgnsag/NbEQ/nYbHQGkjsyWthU0ai6iOfoDNsLuIPbOl4rji4a2hCCl
	 /IK+xwTPMsQkFT6DF4zB9Axe1UYPyNmRZHsRKlkbeDi0jfb2BhKODAzwPxUrKLbicF
	 8TuHlNw38/IDDRb6/d2Uj2Re54Zi20HVrM4on3+D0cGibgmw6OStONHYSrnZBcE754
	 WbHvfVkQqbbcDnOuAeJPgmXnON9lS5BBfnlz643MVVVauZ6C20iVnXREDAO+/TvJOK
	 wwaQvKgzKi5Db0ZJ8xW6MAbySFWNaZGZMQ9Gb81CHU+xo8izp1tS7H5fH9LX3sDjoy
	 NIkAe6DtHFPag==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:29 +0200
Subject: [PATCH 7/9] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-7-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CvxBZ7LMEusddaEnmi+qp2Gt0y7obk/qRay9Htbt5Ks=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir/+LeUrPE1Vg+2ijt+hqN/d1yNfeB69kcH5Ze1cn
 X8ejOulOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbScInhf8yfzKIWIa3lDJkf
 AwQc96x9f+LfbPOFOr32DDXTv97fIcLwzzBwWdmbpE9t89+u/vvCN9TcKmmZT1HvhFOzTP+LRHm
 KsgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow a filesystem to indicate that it supports encoding autonomous file
handles that can be decoded without having to pass a filesystem for the
filesystem. In other words, the file handle uniquely identifies the
filesystem.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c             | 7 ++++++-
 include/linux/exportfs.h | 4 +++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 22edced83e4c..ab4891925b52 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -23,12 +23,13 @@ static long do_sys_name_to_handle(const struct path *path,
 	struct file_handle f_handle;
 	int handle_dwords, handle_bytes;
 	struct file_handle *handle = NULL;
+	const struct export_operations *eops = path->dentry->d_sb->s_export_op;
 
 	/*
 	 * We need to make sure whether the file system support decoding of
 	 * the file handle if decodeable file handle was requested.
 	 */
-	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
+	if (!exportfs_can_encode_fh(eops, fh_flags))
 		return -EOPNOTSUPP;
 
 	/*
@@ -90,6 +91,10 @@ static long do_sys_name_to_handle(const struct path *path,
 			if (d_is_dir(path->dentry))
 				handle->handle_type |= FILEID_IS_DIR;
 		}
+
+		/* Filesystems supports autonomous file handles. */
+		if (eops->flags & EXPORT_OP_AUTONOMOUS_HANDLES)
+			handle->handle_type |= FILEID_IS_AUTONOMOUS;
 		retval = 0;
 	}
 	/* copy the mount id */
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 45b38a29643f..959a1f7d46d0 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -194,7 +194,8 @@ struct handle_to_path_ctx {
 /* Flags supported in encoded handle_type that is exported to user */
 #define FILEID_IS_CONNECTABLE	0x10000
 #define FILEID_IS_DIR		0x20000
-#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
+#define FILEID_IS_AUTONOMOUS	0x40000
+#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR | FILEID_IS_AUTONOMOUS)
 
 /**
  * struct export_operations - for nfsd to communicate with file systems
@@ -291,6 +292,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_AUTONOMOUS_HANDLES	(0x80) /* filesystem supports autonomous file handles */
 	unsigned long	flags;
 };
 

-- 
2.47.2


