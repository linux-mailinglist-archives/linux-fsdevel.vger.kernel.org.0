Return-Path: <linux-fsdevel+bounces-52704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF0AE5F5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6804A37EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CB259CB5;
	Tue, 24 Jun 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9C5zSEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A53F25B66D;
	Tue, 24 Jun 2025 08:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753790; cv=none; b=bGIzgjZlBDNE5uKq3mTb6vKmg9CUJ+RmaS6rg0VmX2YdB2ihP5pO+r/56g59eyUIDUIwx+PLvM3jBoz3VyRi8MctOKdtllEXLbTRfQ3ryp6Rco5ibS08EHfFKQDe6uXyVUuYbVKgGLo2fhMk5lcDAOpxbd7y9OM7TlghZFZ+adA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753790; c=relaxed/simple;
	bh=qmspEgfAxHFZ2cBX+pQKWI9MACvwAWohC61hKRze250=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9ZxxJBZcgJwX6PEnHdQGskigdF+SAcJstFzOpej8Av+QnC55ZIZxPtUEexMX3qemODnZasf303yFDgzaues/0+Z9P2XncgKmOm/Bh++2Fh5HcjRJQsF25lNBYTNqeMzorfxnVmSassFNBW8q/Ss/74AaMGaBUShyMm6N2UMJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9C5zSEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8950C4CEF2;
	Tue, 24 Jun 2025 08:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753790;
	bh=qmspEgfAxHFZ2cBX+pQKWI9MACvwAWohC61hKRze250=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S9C5zSEWHZJC0MEZ8fZHMa+t6kxzYtHZ9gnYpS+AuH66ofHjAhUwiimT0YQQOQd1Q
	 jYaoPmBpL/azQCnRucSSH99GNifrN93hTHJa2188LB9jtQO+hvUmarwlPzCPafJHox
	 vzPDCCqBd5nUb+0XsihFnhy1TE0ojg/fXhnQTm3CtoNh7brlN+cdB0zXA7/iplg7Je
	 QFM4HIltXBAKCliJQ80TioRMC7zNn4gz7KyAhQXXM7zOxnEmNxwQbPM8HyjXN0aEC8
	 znEyV34EZncgweQwm7yU3KrEvKzXMWA3EJUHBmqk6IIsV4YWXPpVeewU5HMupfTv4j
	 c+Ehp8MiYxZ4g==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:12 +0200
Subject: [PATCH v2 09/11] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-9-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2484; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qmspEgfAxHFZ2cBX+pQKWI9MACvwAWohC61hKRze250=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb4IebNZeU7uIpWZt54V3NK8evHt9luL2WP6XCca3
 T246JGLYkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEblYxMnTYJn+xdNpX3HJz
 7ZStp3VKn/qucHcJ3eZ8d++EGcHXmmwY/oqEi3Jf/7N9Y6TsgdzKYj79r+yTpRIf+rq09eddOuz
 MxgwA
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
index 5bb757b51f5c..f7f9038b285e 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -188,7 +188,8 @@ struct handle_to_path_ctx {
 /* Flags supported in encoded handle_type that is exported to user */
 #define FILEID_IS_CONNECTABLE	0x10000
 #define FILEID_IS_DIR		0x20000
-#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
+#define FILEID_IS_AUTONOMOUS	0x40000
+#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR | FILEID_IS_AUTONOMOUS)
 
 /**
  * struct export_operations - for nfsd to communicate with file systems
@@ -285,6 +286,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_AUTONOMOUS_HANDLES	(0x80) /* filesystem supports autonomous file handles */
 	unsigned long	flags;
 };
 

-- 
2.47.2


