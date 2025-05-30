Return-Path: <linux-fsdevel+bounces-50212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1BAC8C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D157B2BC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC8229B3D;
	Fri, 30 May 2025 10:41:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B0F2248B9;
	Fri, 30 May 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601662; cv=none; b=FAeXmepk0t9qqU3DiDobXbm5TFk9aghRkQJhQWJ21xP5lM/vxaVF3RqFUKWBkafLpvi2myQiRCHsPAFcxEGBXY2f7Bk0wswo3soQ82RJRgZy6blTq5V5dQ+pKSkMkGU+1nzYKI+4w2eXJ84xRDupk7dJ4SGFrLyLNQ3XtWw/cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601662; c=relaxed/simple;
	bh=EivE7ISi+0WG5ukbJcn5823I3TbKyL4AilNB3tIDUZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLrt4bIbMPnfgbTBlM1CJzs4yHzH0HsLo9WdvSi1F4VW14zREjUQ5fCwUom/IoRwkwk8n49gUYGnORE1BYfwRxPHvBcXER12ZbLC1Gfh8WgENGjBkJUuDhUsMkeg6YN2UueB9rHHmLRxqr7CKWzYEPXpEnOLeLvRJiKq6aj7GP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4b808G1VlSzYl3c7;
	Fri, 30 May 2025 18:38:38 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 18:40:52 +0800
Received: from localhost.localdomain (10.144.18.117) by a010.hihonor.com
 (10.68.16.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 18:40:52 +0800
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
Subject: [PATCH v3 2/4] dmabuf: Implement copy_file_range for dmabuf
Date: Fri, 30 May 2025 18:39:39 +0800
Message-ID: <20250530103941.11092-3-tao.wangtao@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250530103941.11092-1-tao.wangtao@honor.com>
References: <20250530103941.11092-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w011.hihonor.com (10.68.20.122) To a010.hihonor.com
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


