Return-Path: <linux-fsdevel+bounces-32752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3A9AE66B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D06C1C24169
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48D1EF926;
	Thu, 24 Oct 2024 13:25:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DD1FBF5E;
	Thu, 24 Oct 2024 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776327; cv=none; b=nQmcFq1CSB/q1MWbWopGwn2VB+L2FUX+EpLvDb3jSpOi+d0mD3rpokmiUycixd6VcqPLYS8/Ah8BMbnWlIRTcECkWqdCyCjAfz7w4QDwq9jzeren3CKujvrPhPnMETH/blPDKCMas1J/Kc8dj0JCgrh8jKrUs2SXBOKSy8gy6Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776327; c=relaxed/simple;
	bh=GW0wQcK/aeFjMIay+QgmAkmrzrnkkJUIUBk9Hz2PDQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8poQQuZtvBwicfyC5ifHC1o6uYmdsJIdCBQOt4JVr0QepI8j18Rmvisa23H5tYGroPNJG/Qczhj50dt65QlVQUt0hffgo/CHdjDOrLso4Lfzqkv+E/O+HZa62Q/nTddt/Cjb6dK/rNXyOg36X5cQbrjiNAcEpHtwf6VmM42I6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZ68v5tbDz4f3jdk;
	Thu, 24 Oct 2024 21:25:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 488CF1A018D;
	Thu, 24 Oct 2024 21:25:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMmxShpnmfz6Ew--.42902S14;
	Thu, 24 Oct 2024 21:25:19 +0800 (CST)
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
Subject: [PATCH 6.6 26/28] libfs: Convert simple directory offsets to use a Maple Tree
Date: Thu, 24 Oct 2024 21:22:23 +0800
Message-Id: <20241024132225.2271667-11-yukuai1@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgD3LMmxShpnmfz6Ew--.42902S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4UXF1xtry7Zr1UXw18Zrb_yoW3GF47pF
	9xJay5tr4fXw1UWF48XF4DZw1F9wn5Wr1UGFZYgw1fA3sFvr4kJanF9r45ua4UJrWkCrsx
	JFs8Kr1avF4UXrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVF
	xhVjvjDU0xZFpf9x0pRnYFAUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Chuck Lever <chuck.lever@oracle.com>

commit 0e4a862174f2a8d1653a8a9cf0815020e1d3af24 upstream.

Test robot reports:
> kernel test robot noticed a -19.0% regression of aim9.disk_src.ops_per_sec on:
>
> commit: a2e459555c5f9da3e619b7e47a63f98574dc75f1 ("shmem: stable directory offsets")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Feng Tang further clarifies that:
> ... the new simple_offset_add()
> called by shmem_mknod() brings extra cost related with slab,
> specifically the 'radix_tree_node', which cause the regression.

Willy's analysis is that, over time, the test workload causes
xa_alloc_cyclic() to fragment the underlying SLAB cache.

This patch replaces the offset_ctx's xarray with a Maple Tree in the
hope that Maple Tree's dense node mode will handle this scenario
more scalably.

In addition, we can widen the simple directory offset maximum to
signed long (as loff_t is also signed).

Suggested-by: Matthew Wilcox <willy@infradead.org>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202309081306.3ecb3734-oliver.sang@intel.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/170820145616.6328.12620992971699079156.stgit@91.116.238.104.host.secureserver.net
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 fs/libfs.c         | 47 +++++++++++++++++++++++-----------------------
 include/linux/fs.h |  5 +++--
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index d7b901cb9af4..98731178a3c1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -244,17 +244,17 @@ enum {
 	DIR_OFFSET_MIN	= 2,
 };
 
-static void offset_set(struct dentry *dentry, u32 offset)
+static void offset_set(struct dentry *dentry, long offset)
 {
-	dentry->d_fsdata = (void *)((uintptr_t)(offset));
+	dentry->d_fsdata = (void *)offset;
 }
 
-static u32 dentry2offset(struct dentry *dentry)
+static long dentry2offset(struct dentry *dentry)
 {
-	return (u32)((uintptr_t)(dentry->d_fsdata));
+	return (long)dentry->d_fsdata;
 }
 
-static struct lock_class_key simple_offset_xa_lock;
+static struct lock_class_key simple_offset_lock_class;
 
 /**
  * simple_offset_init - initialize an offset_ctx
@@ -263,8 +263,8 @@ static struct lock_class_key simple_offset_xa_lock;
  */
 void simple_offset_init(struct offset_ctx *octx)
 {
-	xa_init_flags(&octx->xa, XA_FLAGS_ALLOC1);
-	lockdep_set_class(&octx->xa.xa_lock, &simple_offset_xa_lock);
+	mt_init_flags(&octx->mt, MT_FLAGS_ALLOC_RANGE);
+	lockdep_set_class(&octx->mt.ma_lock, &simple_offset_lock_class);
 	octx->next_offset = DIR_OFFSET_MIN;
 }
 
@@ -273,20 +273,19 @@ void simple_offset_init(struct offset_ctx *octx)
  * @octx: directory offset ctx to be updated
  * @dentry: new dentry being added
  *
- * Returns zero on success. @so_ctx and the dentry offset are updated.
+ * Returns zero on success. @octx and the dentry's offset are updated.
  * Otherwise, a negative errno value is returned.
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
-	u32 offset;
+	unsigned long offset;
 	int ret;
 
 	if (dentry2offset(dentry) != 0)
 		return -EBUSY;
 
-	ret = xa_alloc_cyclic(&octx->xa, &offset, dentry, limit,
-			      &octx->next_offset, GFP_KERNEL);
+	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
+				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
 	if (ret < 0)
 		return ret;
 
@@ -302,13 +301,13 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
  */
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 {
-	u32 offset;
+	long offset;
 
 	offset = dentry2offset(dentry);
 	if (offset == 0)
 		return;
 
-	xa_erase(&octx->xa, offset);
+	mtree_erase(&octx->mt, offset);
 	offset_set(dentry, 0);
 }
 
@@ -331,7 +330,7 @@ int simple_offset_empty(struct dentry *dentry)
 
 	index = DIR_OFFSET_MIN;
 	octx = inode->i_op->get_offset_ctx(inode);
-	xa_for_each(&octx->xa, index, child) {
+	mt_for_each(&octx->mt, child, index, LONG_MAX) {
 		spin_lock(&child->d_lock);
 		if (simple_positive(child)) {
 			spin_unlock(&child->d_lock);
@@ -361,8 +360,8 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 {
 	struct offset_ctx *old_ctx = old_dir->i_op->get_offset_ctx(old_dir);
 	struct offset_ctx *new_ctx = new_dir->i_op->get_offset_ctx(new_dir);
-	u32 old_index = dentry2offset(old_dentry);
-	u32 new_index = dentry2offset(new_dentry);
+	long old_index = dentry2offset(old_dentry);
+	long new_index = dentry2offset(new_dentry);
 	int ret;
 
 	simple_offset_remove(old_ctx, old_dentry);
@@ -388,9 +387,9 @@ int simple_offset_rename_exchange(struct inode *old_dir,
 
 out_restore:
 	offset_set(old_dentry, old_index);
-	xa_store(&old_ctx->xa, old_index, old_dentry, GFP_KERNEL);
+	mtree_store(&old_ctx->mt, old_index, old_dentry, GFP_KERNEL);
 	offset_set(new_dentry, new_index);
-	xa_store(&new_ctx->xa, new_index, new_dentry, GFP_KERNEL);
+	mtree_store(&new_ctx->mt, new_index, new_dentry, GFP_KERNEL);
 	return ret;
 }
 
@@ -403,7 +402,7 @@ int simple_offset_rename_exchange(struct inode *old_dir,
  */
 void simple_offset_destroy(struct offset_ctx *octx)
 {
-	xa_destroy(&octx->xa);
+	mtree_destroy(&octx->mt);
 }
 
 /**
@@ -433,16 +432,16 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
 
 	/* In this case, ->private_data is protected by f_pos_lock */
 	file->private_data = NULL;
-	return vfs_setpos(file, offset, U32_MAX);
+	return vfs_setpos(file, offset, LONG_MAX);
 }
 
 static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 {
+	MA_STATE(mas, &octx->mt, offset, offset);
 	struct dentry *child, *found = NULL;
-	XA_STATE(xas, &octx->xa, offset);
 
 	rcu_read_lock();
-	child = xas_next_entry(&xas, U32_MAX);
+	child = mas_find(&mas, LONG_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -456,8 +455,8 @@ static struct dentry *offset_find_next(struct offset_ctx *octx, loff_t offset)
 
 static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
 {
-	u32 offset = dentry2offset(dentry);
 	struct inode *inode = d_inode(dentry);
+	long offset = dentry2offset(dentry);
 
 	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len, offset,
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5104405ce3e6..b9edab0ba46c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/maple_tree.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3190,8 +3191,8 @@ extern ssize_t simple_write_to_buffer(void *to, size_t available, loff_t *ppos,
 		const void __user *from, size_t count);
 
 struct offset_ctx {
-	struct xarray		xa;
-	u32			next_offset;
+	struct maple_tree	mt;
+	unsigned long		next_offset;
 };
 
 void simple_offset_init(struct offset_ctx *octx);
-- 
2.39.2


