Return-Path: <linux-fsdevel+bounces-50214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E15AC8C4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A241BA63B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02E22ACDA;
	Fri, 30 May 2025 10:41:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A901DA5F;
	Fri, 30 May 2025 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601662; cv=none; b=izmFJcEuhaz0dti9dFI3ji1InIE6Gy+B+djpp5xfZXEweBGjkF2/qsgF5bG3LlMwyeI2HIgVKd0l027QA95X+/gadQltfAqZGHon3Q2227sljfatRZQc5TSYc36Cvzgo4TnRwa9q2mFhTJd/5hOhaMx3GP972VW5WSH21LnJRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601662; c=relaxed/simple;
	bh=RzPnU0Bkpy/sjTHlR6rlb6bBzrtLK8bjYM4mKwg7rIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBt49K9oK4qty9vbdI6+UUi7tsrE7WZUa+boatyusRBD3groi0zEqi0gvGBFR/ls4ZfvqxLY6rmBlRO13ES+BrS5nsYdAtSd06yx8IAfqgnDEHHuqjs+XfGmISQ4gHDv96UH923OPCBiKWcDEPuXz4aH1DkTa2GSmOSj+REnz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4b808G4q3zzYl7DQ;
	Fri, 30 May 2025 18:38:38 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v3 4/4] dmabuf:system_heap Implement system_heap exporter's rw_file callback.
Date: Fri, 30 May 2025 18:39:41 +0800
Message-ID: <20250530103941.11092-5-tao.wangtao@honor.com>
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

First verify system_heap exporter has exclusive dmabuf access.
Build bio_vec from sgtable, then invoke target file's r/w callbacks for IO.
Outperforms buffer IO mmap/read by 250%, beats direct I/O udmabuf
copy_file_range by over 30% with initialization time significantly lower
than udmabuf.

Test data:
|    32x32MB Read 1024MB  |Creat-ms|Close-ms|  I/O-ms|I/O-MB/s| I/O%
|-------------------------|--------|--------|--------|--------|-----
| 1)Beg  dmabuf buffer R/W|     47 |      5 |   1125 |    954 | 100%
| 2)    udmabuf buffer R/W|    576 |    323 |   1228 |    874 |  91%
| 3) udma+memfd buffer R/W|    596 |    340 |   2166 |    495 |  51%
| 4) udma+memfd direct R/W|    570 |    338 |    711 |   1510 | 158%
| 5)  udmabuf buffer c_f_r|    578 |    329 |   1128 |    952 |  99%
| 6)  udmabuf direct c_f_r|    570 |    324 |    405 |   2651 | 277%
| 7)   dmabuf buffer c_f_r|     47 |      5 |   1035 |   1037 | 108%
| 8)   dmabuf direct c_f_r|     51 |      5 |    309 |   3480 | 364%
| 9)End  dmabuf buffer R/W|     48 |      5 |   1153 |    931 |  97%

|    32x32MB Write 1024MB |Creat-ms|Close-ms|  I/O-ms|I/O-MB/s| I/O%
|-------------------------|--------|--------|--------|--------|-----
| 1)Beg  dmabuf buffer R/W|     50 |      5 |   1405 |    764 | 100%
| 2)    udmabuf buffer R/W|    580 |    341 |   1337 |    803 | 105%
| 3) udma+memfd buffer R/W|    588 |    331 |   1820 |    590 |  77%
| 4) udma+memfd direct R/W|    585 |    333 |    662 |   1622 | 212%
| 5)  udmabuf buffer c_f_r|    577 |    329 |   1326 |    810 | 106%
| 6)  udmabuf direct c_f_r|    580 |    330 |    602 |   1784 | 233%
| 7)   dmabuf buffer c_f_r|     49 |      5 |   1330 |    807 | 105%
| 8)   dmabuf direct c_f_r|     49 |      5 |    344 |   3127 | 409%
| 9)End  dmabuf buffer R/W|     50 |      5 |   1442 |    745 |  97%

Signed-off-by: wangtao <tao.wangtao@honor.com>
---
 drivers/dma-buf/heaps/system_heap.c | 79 +++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 26d5dc89ea16..d3a1956ebad8 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -20,6 +20,9 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/bvec.h>
+#include <linux/bio.h>
+#include <linux/uio.h>
 
 static struct dma_heap *sys_heap;
 
@@ -281,6 +284,81 @@ static void system_heap_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
 	iosys_map_clear(map);
 }
 
+static ssize_t system_heap_buffer_rw_other(struct system_heap_buffer *buffer,
+			loff_t my_pos, struct file *other, loff_t pos,
+			size_t count, bool is_write)
+{
+	struct sg_table *sgt = &buffer->sg_table;
+	struct scatterlist *sg;
+	loff_t my_end = my_pos + count, bv_beg, bv_end = 0;
+	pgoff_t pg_idx = my_pos / PAGE_SIZE;
+	pgoff_t pg_end = DIV_ROUND_UP(my_end, PAGE_SIZE);
+	size_t i, bv_off, bv_len, bv_num, bv_idx = 0, bv_total = 0;
+	struct bio_vec *bvec;
+	struct kiocb kiocb;
+	struct iov_iter iter;
+	unsigned int direction = is_write ? ITER_SOURCE : ITER_DEST;
+	ssize_t ret = 0, rw_total = 0;
+
+	bv_num = min_t(size_t, pg_end - pg_idx + 1, 1024);
+	bvec = kvcalloc(bv_num, sizeof(*bvec), GFP_KERNEL);
+	if (!bvec)
+		return -ENOMEM;
+
+	init_sync_kiocb(&kiocb, other);
+	kiocb.ki_pos = pos;
+
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
+		if (my_pos >= my_end)
+			break;
+		bv_beg = bv_end;
+		bv_end += sg->length;
+		if (bv_end <= my_pos)
+			continue;
+
+		bv_len = min(bv_end, my_end) - my_pos;
+		bv_off = sg->offset + my_pos - bv_beg;
+		my_pos += bv_len;
+		bv_total += bv_len;
+		bvec_set_page(&bvec[bv_idx], sg_page(sg), bv_len, bv_off);
+		if (++bv_idx < bv_num && my_pos < my_end)
+			continue;
+
+		/* start R/W if bvec is full or count reaches zero. */
+		iov_iter_bvec(&iter, direction, bvec, bv_idx, bv_total);
+		if (is_write)
+			ret = other->f_op->write_iter(&kiocb, &iter);
+		else
+			ret = other->f_op->read_iter(&kiocb, &iter);
+		if (ret <= 0)
+			break;
+		rw_total += ret;
+		if (ret < bv_total || fatal_signal_pending(current))
+			break;
+
+		bv_idx = bv_total = 0;
+	}
+	kvfree(bvec);
+
+	return rw_total > 0 ? rw_total : ret;
+}
+
+static ssize_t system_heap_dma_buf_rw_file(struct dma_buf *dmabuf,
+			loff_t my_pos, struct file *file, loff_t pos,
+			size_t count, bool is_write)
+{
+	struct system_heap_buffer *buffer = dmabuf->priv;
+	ssize_t ret = -EBUSY;
+
+	mutex_lock(&buffer->lock);
+	if (list_empty(&buffer->attachments) && !buffer->vmap_cnt)
+		ret = system_heap_buffer_rw_other(buffer, my_pos,
+			file, pos, count, is_write);
+	mutex_unlock(&buffer->lock);
+
+	return ret;
+}
+
 static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 {
 	struct system_heap_buffer *buffer = dmabuf->priv;
@@ -308,6 +386,7 @@ static const struct dma_buf_ops system_heap_buf_ops = {
 	.mmap = system_heap_mmap,
 	.vmap = system_heap_vmap,
 	.vunmap = system_heap_vunmap,
+	.rw_file = system_heap_dma_buf_rw_file,
 	.release = system_heap_dma_buf_release,
 };
 
-- 
2.17.1


