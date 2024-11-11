Return-Path: <linux-fsdevel+bounces-34174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0649C35A7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 01:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E129F1F224B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 00:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7111494BB;
	Mon, 11 Nov 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS71cagn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43D1474CC;
	Mon, 11 Nov 2024 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286401; cv=none; b=jwLQ99ogL+/90XTNrhp/U09/FA73I4JxxYknCgPdtgt9+q5bxyMqWaPJiqmqVKjdIuFfoUz50PAmRubJaQWvfXrCzHIB5UUcRWytJdMEUhgry4dZOwrMYFS501XqVAJB7RwpYj3yEi0QX+ahWTa54Zb/aS3tNhtWnXkZkmoU5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286401; c=relaxed/simple;
	bh=FdkkHjJkV4S0+kVcTYwQw7JAo4gJep4aQ3vPEJrklpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPJ3ccxisQEa4P2zlDNJiO5ApXYiWx/G/WoZzjBL/UeIa65J5uqCqPfyg+KjbauW9FQPoeSrEUeC/BZClflXJo/dHvf/XJT9ZHPGiZwrK+eDkK5MoKaR1TWuARdQRaJjLM1LwIJXduHV6K/RMhWXfAOK9n54BgiQtFZL+lGM2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS71cagn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381A7C4CEDF;
	Mon, 11 Nov 2024 00:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731286400;
	bh=FdkkHjJkV4S0+kVcTYwQw7JAo4gJep4aQ3vPEJrklpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SS71cagn0Y7k0khmPTRSNE2WIHD+UznGHwyeGjN6di6DA1sirkflrguuVTZfxJuMc
	 /G9xzd1SKB6D9RdV9mg/kKdTh3Fb8Uw0YfA3G5UjeH1P9ZO52x1CzgadU77Vyy7HgZ
	 FnPM9QJ6/Fd2xvc9b3aTmANUab2ekRv5H7VCSTVNS+VumwqsVLVOWs39LyhE+bh+4h
	 e1ygJE+h9xbhHDwrinkdWVXPXG1QA19rUN38dxI6I8sqZEE74fYpYwrkIBq7TR74w7
	 Rn6PjpDnyEgXK2ddOoeB3QHYdnXmUkLTtda17feUFfBEaG5aHTbfsQgcZVzOpWvud7
	 +nuLxfO5dEEMg==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: yukuai1@huaweicloud.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	<linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for offset dir
Date: Sun, 10 Nov 2024 19:52:42 -0500
Message-ID: <20241111005242.34654-7-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111005242.34654-1-cel@kernel.org>
References: <20241111005242.34654-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: yangerkun <yangerkun@huawei.com>

[ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]

After we switch tmpfs dir operations from simple_dir_operations to
simple_offset_dir_operations, every rename happened will fill new dentry
to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
key starting with octx->newx_offset, and then set newx_offset equals to
free key + 1. This will lead to infinite readdir combine with rename
happened at the same time, which fail generic/736 in xfstests(detail show
as below).

1. create 5000 files(1 2 3...) under one dir
2. call readdir(man 3 readdir) once, and get one entry
3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
4. loop 2~3, until readdir return nothing or we loop too many
   times(tmpfs break test with the second condition)

We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
directory reads") to fix it, record the last_index when we open dir, and
do not emit the entry which index >= last_index. The file->private_data
now used in offset dir can use directly to do this, and we also update
the last_index when we llseek the dir file.

Fixes: a2e459555c5f ("shmem: stable directory offsets")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
[brauner: only update last_index after seek when offset is zero like Jan suggested]
Signed-off-by: Christian Brauner <brauner@kernel.org>
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-46701
[ cel: adjusted to apply to origin/linux-6.6.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index a87005c89534..b59ff0dfea1f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -449,6 +449,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	xa_destroy(&octx->xa);
 }
 
+static int offset_dir_open(struct inode *inode, struct file *file)
+{
+	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
+
+	file->private_data = (void *)ctx->next_offset;
+	return 0;
+}
+
 /**
  * offset_dir_llseek - Advance the read position of a directory descriptor
  * @file: an open directory whose position is to be updated
@@ -462,6 +470,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
+	struct inode *inode = file->f_inode;
+	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
+
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -475,8 +486,9 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
-	return vfs_setpos(file, offset, U32_MAX);
+	if (!offset)
+		file->private_data = (void *)ctx->next_offset;
+	return vfs_setpos(file, offset, LONG_MAX);
 }
 
 static struct dentry *offset_find_next(struct xa_state *xas)
@@ -505,7 +517,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
 {
 	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
 	XA_STATE(xas, &so_ctx->xa, ctx->pos);
@@ -514,17 +526,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(&xas);
 		if (!dentry)
-			return ERR_PTR(-ENOENT);
+			return;
+
+		if (dentry2offset(dentry) >= last_index) {
+			dput(dentry);
+			return;
+		}
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
-			break;
+			return;
 		}
 
 		dput(dentry);
 		ctx->pos = xas.xa_index + 1;
 	}
-	return NULL;
 }
 
 /**
@@ -551,22 +567,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 static int offset_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dir = file->f_path.dentry;
+	long last_index = (long)file->private_data;
 
 	lockdep_assert_held(&d_inode(dir)->i_rwsem);
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == DIR_OFFSET_MIN)
-		file->private_data = NULL;
-	else if (file->private_data == ERR_PTR(-ENOENT))
-		return 0;
-	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
+	offset_iterate_dir(d_inode(dir), ctx, last_index);
 	return 0;
 }
 
 const struct file_operations simple_offset_dir_operations = {
+	.open		= offset_dir_open,
 	.llseek		= offset_dir_llseek,
 	.iterate_shared	= offset_readdir,
 	.read		= generic_read_dir,
-- 
2.47.0


