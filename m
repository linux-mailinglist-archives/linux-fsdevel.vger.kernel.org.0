Return-Path: <linux-fsdevel+bounces-34170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557D9C359B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 01:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A963282A26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 00:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A44E749A;
	Mon, 11 Nov 2024 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrf5VPIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7F4B5C1;
	Mon, 11 Nov 2024 00:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286389; cv=none; b=NNqXSw9ZMPiYyHLoEsxF3IRc2yK+NJFOd3xZnNI4kRPpsYkDHtZixzhZIrgHnVxLQuVOF7vl+4OYtHziiHKvrsYzICL+QRUETfimgxSQuMyv12ezEQF01SYsDkDbA+ZINJ+5weLG8yOG+TiE4dJnaTZjqtw9EDBj2pQqccHGRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286389; c=relaxed/simple;
	bh=Z1QVcRNEajq+vvtRp+aYnLkCErRyzdCuKYY5Gom358E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKfe77+Tif6swQKXfLTFc59j/NoS1/U6in/jp2Ca0Pz7gw4nPnr5WlVw0NnyH4z9YV+7jHNrxVBVmWzgdvM62qZ6XyW7P0ge7HwEwvCFaCSPh04RgrHW0uBapxBghkMSf7r9pPOPq2JpR+zsBn2ZLqM5ucAUGjV1y0UqZ5j1iXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrf5VPIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB9AC4CED6;
	Mon, 11 Nov 2024 00:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731286389;
	bh=Z1QVcRNEajq+vvtRp+aYnLkCErRyzdCuKYY5Gom358E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrf5VPIUItWcKVtrlMjZyA9tq+5oyRSxI+GpQOE4It5Fkefwo9OvtC99jBNEAmCVO
	 /jB3FJ1h0OrzKq6rZO3CvgotIAATbQ1c7zaXUesKHVANqRnZE9aExWhcKF+HJdRfqq
	 MNH2HDC3jfuxXoHT70TnTXw+m5EgHdVIBRTGI7dExUKfhaJ05nDo6wczsw8sN1zN14
	 TUhUQr6YbDOedUUN5JyHBYo9kG/GVPCJxeamWdtcbATWWySK/aYoAEpy4N2wB0dL0k
	 OXj7FNKqa1bAF+RgA2Jbro7kxneUAYLDi/Yrho3dK67Th8fBM5ZuogzGch/WAvDoeC
	 vlrZ/CgdO2Wjw==
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
	Chuck Lever <chuck.lever@oracle.com>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH 2/6 6.6] libfs: Add simple_offset_empty()
Date: Sun, 10 Nov 2024 19:52:38 -0500
Message-ID: <20241111005242.34654-3-cel@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ecba88a3b32d733d41e27973e25b2bc580f64281 ]

For simple filesystems that use directory offset mapping, rely
strictly on the directory offset map to tell when a directory has
no children.

After this patch is applied, the emptiness test holds only the RCU
read lock when the directory being tested has no children.

In addition, this adds another layer of confirmation that
simple_offset_add/remove() are working as expected.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/170820143463.6328.7872919188371286951.stgit@91.116.238.104.host.secureserver.net
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 5a1a25be995e ("libfs: Add simple_offset_rename() API")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/libfs.c         | 32 ++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 mm/shmem.c         |  4 ++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4a2205afcc88..66b428f3fc41 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -312,6 +312,38 @@ void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry)
 	offset_set(dentry, 0);
 }
 
+/**
+ * simple_offset_empty - Check if a dentry can be unlinked
+ * @dentry: dentry to be tested
+ *
+ * Returns 0 if @dentry is a non-empty directory; otherwise returns 1.
+ */
+int simple_offset_empty(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct offset_ctx *octx;
+	struct dentry *child;
+	unsigned long index;
+	int ret = 1;
+
+	if (!inode || !S_ISDIR(inode->i_mode))
+		return ret;
+
+	index = DIR_OFFSET_MIN;
+	octx = inode->i_op->get_offset_ctx(inode);
+	xa_for_each(&octx->xa, index, child) {
+		spin_lock(&child->d_lock);
+		if (simple_positive(child)) {
+			spin_unlock(&child->d_lock);
+			ret = 0;
+			break;
+		}
+		spin_unlock(&child->d_lock);
+	}
+
+	return ret;
+}
+
 /**
  * simple_offset_rename_exchange - exchange rename with directory offsets
  * @old_dir: parent of dentry being moved
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c3d86532e3f..5104405ce3e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3197,6 +3197,7 @@ struct offset_ctx {
 void simple_offset_init(struct offset_ctx *octx);
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry);
 void simple_offset_remove(struct offset_ctx *octx, struct dentry *dentry);
+int simple_offset_empty(struct dentry *dentry);
 int simple_offset_rename_exchange(struct inode *old_dir,
 				  struct dentry *old_dentry,
 				  struct inode *new_dir,
diff --git a/mm/shmem.c b/mm/shmem.c
index 5d076022da24..e0d014eaaf73 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3373,7 +3373,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 
 static int shmem_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	if (!simple_empty(dentry))
+	if (!simple_offset_empty(dentry))
 		return -ENOTEMPTY;
 
 	drop_nlink(d_inode(dentry));
@@ -3430,7 +3430,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		return simple_offset_rename_exchange(old_dir, old_dentry,
 						     new_dir, new_dentry);
 
-	if (!simple_empty(new_dentry))
+	if (!simple_offset_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-- 
2.47.0


