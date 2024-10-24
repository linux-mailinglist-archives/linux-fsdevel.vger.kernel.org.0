Return-Path: <linux-fsdevel+bounces-32753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991299AE66E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCB62868F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A361EF928;
	Thu, 24 Oct 2024 13:25:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8191FBF65;
	Thu, 24 Oct 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776328; cv=none; b=Gto/EAe8Mz/XQTJVh2YKxYkNbqBXT41kRaNkE+cFR6CCsHj9GKNYZ7zJabhK4DMpvKvQrMphpWk10KH1JZa2kde4IjtRC09tpaTrVaIB8vf0hxcAhKk68JWCfII+lywTpwUcsElMFHA5/dbVqgsbnnotMieCZRVFHvcHA0WWfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776328; c=relaxed/simple;
	bh=L+5WXtZxBV8aVRPEepS/zadXDDL+1k5ePjI582nYTyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKiUDYuOGuU6Zuo2w7n0b7jO/EP6Db8y4d9quw79avKRDf2izjDIK916qanF3wpRYv1em9x1vwWI06Qy28aCd6rKu0ZZelmAzAYr3Wd/jrhWrF/ISpgvaqsNy9/Tmp68ycj8mexnWuo7G9tmoQ9J10TWK/r0qyHt6ugkNYg1Npg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ68w1Bfvz4f3nbY;
	Thu, 24 Oct 2024 21:25:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E78A1A0197;
	Thu, 24 Oct 2024 21:25:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S15;
	Thu, 24 Oct 2024 21:25:21 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
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
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 27/28] libfs: fix infinite directory reads for offset dir
Date: Thu, 24 Oct 2024 21:22:24 +0800
Message-Id: <20241024132225.2271667-12-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132225.2271667-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
 <20241024132225.2271667-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S15
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4DCw48XFykAF4fGryrtFb_yoWrKF1fpF
	ZxG3Z3tr1fW34jgr4vvF1DZryF93Z3Kw4rX3s5Ww15try2qws8Kas2yr1Y9a48tr95Cr13
	ZF45Ka43Xr4UCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE3s
	1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2
	KfnxnUUI43ZEXa7sR_3ku7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: yangerkun <yangerkun@huawei.com>

commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a upstream.

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
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/libfs.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 98731178a3c1..fd5d30c798de 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -405,6 +405,14 @@ void simple_offset_destroy(struct offset_ctx *octx)
 	mtree_destroy(&octx->mt);
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
@@ -418,6 +426,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
  */
 static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 {
+	struct inode *inode = file->f_inode;
+	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
+
 	switch (whence) {
 	case SEEK_CUR:
 		offset += file->f_pos;
@@ -431,7 +442,8 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 	}
 
 	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
+	if (!offset)
+		file->private_data = (void *)ctx->next_offset;
 	return vfs_setpos(file, offset, LONG_MAX);
 }
 
@@ -462,7 +474,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -470,17 +482,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
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
 
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
-	return NULL;
 }
 
 /**
@@ -507,22 +523,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
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
2.39.2


