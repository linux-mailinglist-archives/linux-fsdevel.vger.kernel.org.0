Return-Path: <linux-fsdevel+bounces-50439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B31CACC3AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AAF3A38E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057D28368C;
	Tue,  3 Jun 2025 09:53:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7C28137C;
	Tue,  3 Jun 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944434; cv=none; b=gARgs5RlXsXDkQZXcFQuqjtdwhlu3TeePc3p+8tjyXuFkhnc/cp8Z3ag25awHGT8nCrEs2VNWsWFIJimNSYyJRdRbXrWQbOeF0cm5bNiGRTcMRcUS+DNaEZ37PhqxS5gSIqc0YdnNPYo22RiOTc11aTujgzHOqDP2nrNz/HZ0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944434; c=relaxed/simple;
	bh=EivE7ISi+0WG5ukbJcn5823I3TbKyL4AilNB3tIDUZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQUEOglEC/ID70o1LbOhbREsLBfslpHQlscxifEG2g1VQklZqXRzQ2P9Di1WVru2fD6c9PCs4iK8u6e1uLFog5quUJWDftGpK6dcfhREfnEIJwiCpsBMWI2GtdxZRBST5MWC3RVcEnhpGRxTKpJdlUl4nKsqFLhdvXC7/mDJkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4bBQwN2MZ8zYlSxZ;
	Tue,  3 Jun 2025 17:51:48 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 17:53:50 +0800
Received: from localhost.localdomain (10.144.18.117) by a010.hihonor.com
 (10.68.16.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 17:53:50 +0800
From: wangtao <tao.wangtao@honor.com>
To: <sumit.semwal@linaro.org>, <christian.koenig@amd.com>,
	<kraxel@redhat.com>, <vivek.kasireddy@intel.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <hughd@google.com>, <akpm@linux-foundation.org>,
	<amir73il@gmail.com>
CC: <benjamin.gaignard@collabora.com>, <Brian.Starkey@arm.com>,
	<jstultz@google.com>, <tjmercier@google.com>, <jack@suse.cz>,
	<baolin.wang@linux.alibaba.com>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <bintian.wang@honor.com>, <yipengxiang@honor.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, wangtao <tao.wangtao@honor.com>
Subject: [PATCH v4 2/4] dmabuf: Implement copy_file_range callback for dmabuf direct I/O prep
Date: Tue, 3 Jun 2025 17:52:43 +0800
Message-ID: <20250603095245.17478-3-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250603095245.17478-1-tao.wangtao@honor.com>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a010.hihonor.com
 (10.68.16.52)

First determine if dmabuf reads from or writes to the file.
Then call exporter's rw_file callback function.

Signed-off-by: wangtao <tao.wangtao@honor.com>
---
 drivers/dma-buf/dma-buf.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 16 ++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 5baa83b85515..fc9bf54c921a 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -523,7 +523,38 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 	spin_unlock(&dmabuf->name_lock);
 }
 
+static ssize_t dma_buf_rw_file(struct dma_buf *dmabuf, loff_t my_pos,
+	struct file *file, loff_t pos, size_t count, bool is_write)
+{
+	if (!dmabuf->ops->rw_file)
+		return -EINVAL;
+
+	if (my_pos >= dmabuf->size)
+		count = 0;
+	else
+		count = min_t(size_t, count, dmabuf->size - my_pos);
+	if (!count)
+		return 0;
+
+	return dmabuf->ops->rw_file(dmabuf, my_pos, file, pos, count, is_write);
+}
+
+static ssize_t dma_buf_copy_file_range(struct file *file_in, loff_t pos_in,
+	struct file *file_out, loff_t pos_out,
+	size_t count, unsigned int flags)
+{
+	if (is_dma_buf_file(file_in) && file_out->f_op->write_iter)
+		return dma_buf_rw_file(file_in->private_data, pos_in,
+				file_out, pos_out, count, true);
+	else if (is_dma_buf_file(file_out) && file_in->f_op->read_iter)
+		return dma_buf_rw_file(file_out->private_data, pos_out,
+				file_in, pos_in, count, false);
+	else
+		return -EINVAL;
+}
+
 static const struct file_operations dma_buf_fops = {
+	.fop_flags = FOP_MEMORY_FILE,
 	.release	= dma_buf_file_release,
 	.mmap		= dma_buf_mmap_internal,
 	.llseek		= dma_buf_llseek,
@@ -531,6 +562,7 @@ static const struct file_operations dma_buf_fops = {
 	.unlocked_ioctl	= dma_buf_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.show_fdinfo	= dma_buf_show_fdinfo,
+	.copy_file_range = dma_buf_copy_file_range,
 };
 
 /*
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 36216d28d8bd..d3636e985399 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/dma-fence.h>
 #include <linux/wait.h>
+#include <uapi/linux/dma-buf.h>
 
 struct device;
 struct dma_buf;
@@ -285,6 +286,21 @@ struct dma_buf_ops {
 
 	int (*vmap)(struct dma_buf *dmabuf, struct iosys_map *map);
 	void (*vunmap)(struct dma_buf *dmabuf, struct iosys_map *map);
+
+	/**
+	 * @rw_file:
+	 *
+	 * If an Exporter needs to support Direct I/O file operations, it can
+	 * implement this optional callback. The exporter must verify that no
+	 * other objects hold the sg_table, ensure exclusive access to the
+	 * dmabuf's sg_table, and only then proceed with the I/O operation.
+	 *
+	 * Returns:
+	 *
+	 * 0 on success or a negative error code on failure.
+	 */
+	ssize_t (*rw_file)(struct dma_buf *dmabuf, loff_t my_pos,
+		struct file *file, loff_t pos, size_t count, bool is_write);
 };
 
 /**
-- 
2.17.1


