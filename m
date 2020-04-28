Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2675B1BBD00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 14:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD1ME7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 08:04:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgD1ME6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:04:58 -0400
Received: by ozlabs.org (Postfix, from userid 1023)
        id 49BL1M6wGwz9sSX; Tue, 28 Apr 2020 22:04:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1588075495; bh=mQaL0dNlw7pvZD2irMmg/vOkZrvHKgvORLsAa9jZbwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXiAX4v3r2OpdzAIA7yqGju8GgordMTliwZOsaVy1nYlxsLovY8BF8soLE2xtEQmo
         ixPXs14E9V7/bf+dQgUOviu/YR5M0zSvZiDvj2upRTsmS/mNLk8SGfWql+mzK2YoVv
         W59U/nxFeKHoXidJsYTbNv17pkjU1qM0Du1TibEtyj359VpHFqoh/eF1ZtyuRhwvhX
         gDOwH7VYh2WrEtT5vKHPNdbb8UhrsptCSjXNOb3qUxecO4Orzchqdlw58z09vl8CQC
         oh0feGG52IB6RSAs5uW8vy0ICvSOK19DyGc4WJLcBKf2h/JEAC/dQeiXfdojWH6oGX
         Qq6bOiifFbCkA==
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
Date:   Tue, 28 Apr 2020 20:02:07 +0800
Message-Id: <20200428120207.15728-1-jk@ozlabs.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427200626.1622060-2-hch@lst.de>
References: <20200427200626.1622060-2-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, we may perform a copy_to_user (through
simple_read_from_buffer()) while holding a context's register_lock,
while accessing the context save area.

This change uses a temporary buffers for the context save area data,
which we then pass to simple_read_from_buffer.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

Christoph - this fixes the copy_to_user while atomic, hopefully with
only minimal distruption to your series.

---
 arch/powerpc/platforms/cell/spufs/file.c | 110 +++++++++++++++--------
 1 file changed, 74 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index c0f950a3f4e1..c62d77ddaf7d 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1978,8 +1978,9 @@ static ssize_t __spufs_mbox_info_read(struct spu_context *ctx,
 static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
-	int ret;
 	struct spu_context *ctx = file->private_data;
+	u32 stat, data;
+	int ret;
 
 	if (!access_ok(buf, len))
 		return -EFAULT;
@@ -1988,11 +1989,16 @@ static ssize_t spufs_mbox_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_mbox_info_read(ctx, buf, len, pos);
+	stat = ctx->csa.prob.mb_stat_R;
+	data = ctx->csa.prob.pu_mb_R;
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return ret;
+	/* EOF if there's no entry in the mbox */
+	if (!(stat & 0x0000ff))
+		return 0;
+
+	return simple_read_from_buffer(buf, len, pos, &data, sizeof(data));
 }
 
 static const struct file_operations spufs_mbox_info_fops = {
@@ -2019,6 +2025,7 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
+	u32 stat, data;
 	int ret;
 
 	if (!access_ok(buf, len))
@@ -2028,11 +2035,16 @@ static ssize_t spufs_ibox_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_ibox_info_read(ctx, buf, len, pos);
+	stat = ctx->csa.prob.mb_stat_R;
+	data = ctx->csa.priv2.puint_mb_R;
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return ret;
+	/* EOF if there's no entry in the ibox */
+	if (!(stat & 0xff0000))
+		return 0;
+
+	return simple_read_from_buffer(buf, len, pos, &data, sizeof(data));
 }
 
 static const struct file_operations spufs_ibox_info_fops = {
@@ -2041,6 +2053,11 @@ static const struct file_operations spufs_ibox_info_fops = {
 	.llseek  = generic_file_llseek,
 };
 
+static size_t spufs_wbox_info_cnt(struct spu_context *ctx)
+{
+	return (4 - ((ctx->csa.prob.mb_stat_R & 0x00ff00) >> 8)) * sizeof(u32);
+}
+
 static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
 			char __user *buf, size_t len, loff_t *pos)
 {
@@ -2049,7 +2066,7 @@ static ssize_t __spufs_wbox_info_read(struct spu_context *ctx,
 	u32 wbox_stat;
 
 	wbox_stat = ctx->csa.prob.mb_stat_R;
-	cnt = 4 - ((wbox_stat & 0x00ff00) >> 8);
+	cnt = spufs_wbox_info_cnt(ctx);
 	for (i = 0; i < cnt; i++) {
 		data[i] = ctx->csa.spu_mailbox_data[i];
 	}
@@ -2062,7 +2079,8 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
-	int ret;
+	u32 data[ARRAY_SIZE(ctx->csa.spu_mailbox_data)];
+	int ret, count;
 
 	if (!access_ok(buf, len))
 		return -EFAULT;
@@ -2071,11 +2089,13 @@ static ssize_t spufs_wbox_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_wbox_info_read(ctx, buf, len, pos);
+	count = spufs_wbox_info_cnt(ctx);
+	memcpy(&data, &ctx->csa.spu_mailbox_data, sizeof(data));
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return ret;
+	return simple_read_from_buffer(buf, len, pos, &data,
+				count * sizeof(u32));
 }
 
 static const struct file_operations spufs_wbox_info_fops = {
@@ -2084,20 +2104,19 @@ static const struct file_operations spufs_wbox_info_fops = {
 	.llseek  = generic_file_llseek,
 };
 
-static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
-			char __user *buf, size_t len, loff_t *pos)
+static void ___spufs_dma_info_read(struct spu_context *ctx,
+		struct spu_dma_info *info)
 {
-	struct spu_dma_info info;
 	struct mfc_cq_sr *qp, *spuqp;
 	int i;
 
-	info.dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
-	info.dma_info_mask = ctx->csa.lscsa->tag_mask.slot[0];
-	info.dma_info_status = ctx->csa.spu_chnldata_RW[24];
-	info.dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
-	info.dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
+	info->dma_info_type = ctx->csa.priv2.spu_tag_status_query_RW;
+	info->dma_info_mask = ctx->csa.lscsa->tag_mask.slot[0];
+	info->dma_info_status = ctx->csa.spu_chnldata_RW[24];
+	info->dma_info_stall_and_notify = ctx->csa.spu_chnldata_RW[25];
+	info->dma_info_atomic_command_status = ctx->csa.spu_chnldata_RW[27];
 	for (i = 0; i < 16; i++) {
-		qp = &info.dma_info_command_data[i];
+		qp = &info->dma_info_command_data[i];
 		spuqp = &ctx->csa.priv2.spuq[i];
 
 		qp->mfc_cq_data0_RW = spuqp->mfc_cq_data0_RW;
@@ -2105,6 +2124,14 @@ static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
 		qp->mfc_cq_data2_RW = spuqp->mfc_cq_data2_RW;
 		qp->mfc_cq_data3_RW = spuqp->mfc_cq_data3_RW;
 	}
+}
+
+static ssize_t __spufs_dma_info_read(struct spu_context *ctx,
+			char __user *buf, size_t len, loff_t *pos)
+{
+	struct spu_dma_info info;
+
+	___spufs_dma_info_read(ctx, &info);
 
 	return simple_read_from_buffer(buf, len, pos, &info,
 				sizeof info);
@@ -2114,6 +2141,7 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 			      size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
+	struct spu_dma_info info;
 	int ret;
 
 	if (!access_ok(buf, len))
@@ -2123,11 +2151,12 @@ static ssize_t spufs_dma_info_read(struct file *file, char __user *buf,
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_dma_info_read(ctx, buf, len, pos);
+	___spufs_dma_info_read(ctx, &info);
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return ret;
+	return simple_read_from_buffer(buf, len, pos, &info,
+				sizeof(info));
 }
 
 static const struct file_operations spufs_dma_info_fops = {
@@ -2136,13 +2165,31 @@ static const struct file_operations spufs_dma_info_fops = {
 	.llseek = no_llseek,
 };
 
+static void ___spufs_proxydma_info_read(struct spu_context *ctx,
+	struct spu_proxydma_info *info)
+{
+	int i;
+
+	info->proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
+	info->proxydma_info_mask = ctx->csa.prob.dma_querymask_RW;
+	info->proxydma_info_status = ctx->csa.prob.dma_tagstatus_R;
+
+	for (i = 0; i < 8; i++) {
+		struct mfc_cq_sr *qp = &info->proxydma_info_command_data[i];
+		struct mfc_cq_sr *puqp = &ctx->csa.priv2.puq[i];
+
+		qp->mfc_cq_data0_RW = puqp->mfc_cq_data0_RW;
+		qp->mfc_cq_data1_RW = puqp->mfc_cq_data1_RW;
+		qp->mfc_cq_data2_RW = puqp->mfc_cq_data2_RW;
+		qp->mfc_cq_data3_RW = puqp->mfc_cq_data3_RW;
+	}
+}
+
 static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
 			char __user *buf, size_t len, loff_t *pos)
 {
 	struct spu_proxydma_info info;
-	struct mfc_cq_sr *qp, *puqp;
 	int ret = sizeof info;
-	int i;
 
 	if (len < ret)
 		return -EINVAL;
@@ -2150,18 +2197,7 @@ static ssize_t __spufs_proxydma_info_read(struct spu_context *ctx,
 	if (!access_ok(buf, len))
 		return -EFAULT;
 
-	info.proxydma_info_type = ctx->csa.prob.dma_querytype_RW;
-	info.proxydma_info_mask = ctx->csa.prob.dma_querymask_RW;
-	info.proxydma_info_status = ctx->csa.prob.dma_tagstatus_R;
-	for (i = 0; i < 8; i++) {
-		qp = &info.proxydma_info_command_data[i];
-		puqp = &ctx->csa.priv2.puq[i];
-
-		qp->mfc_cq_data0_RW = puqp->mfc_cq_data0_RW;
-		qp->mfc_cq_data1_RW = puqp->mfc_cq_data1_RW;
-		qp->mfc_cq_data2_RW = puqp->mfc_cq_data2_RW;
-		qp->mfc_cq_data3_RW = puqp->mfc_cq_data3_RW;
-	}
+	___spufs_proxydma_info_read(ctx, &info);
 
 	return simple_read_from_buffer(buf, len, pos, &info,
 				sizeof info);
@@ -2171,17 +2207,19 @@ static ssize_t spufs_proxydma_info_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *pos)
 {
 	struct spu_context *ctx = file->private_data;
+	struct spu_proxydma_info info;
 	int ret;
 
 	ret = spu_acquire_saved(ctx);
 	if (ret)
 		return ret;
 	spin_lock(&ctx->csa.register_lock);
-	ret = __spufs_proxydma_info_read(ctx, buf, len, pos);
+	___spufs_proxydma_info_read(ctx, &info);
 	spin_unlock(&ctx->csa.register_lock);
 	spu_release_saved(ctx);
 
-	return ret;
+	return simple_read_from_buffer(buf, len, pos, &info,
+				sizeof(info));
 }
 
 static const struct file_operations spufs_proxydma_info_fops = {
-- 
2.17.1

