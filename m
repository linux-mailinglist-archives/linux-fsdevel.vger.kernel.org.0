Return-Path: <linux-fsdevel+bounces-50441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D44FACC3AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4A53A5A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EAD283FDC;
	Tue,  3 Jun 2025 09:53:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7F2820CE;
	Tue,  3 Jun 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944436; cv=none; b=Mh4x6Lf8BagKM4omvJChBrk8fwkkemQC+GIcu/BVFKo1ECtDa8jypyAgBMYmWw9cZLUz43D0I5VhV2Kdey5JXma3U89ANWWpOKH79LE2FxWSCzlEZGHIem5bzacfZQwBHYzz9G2H4bTFXSCjEQZjrHBUW1UN2HIg1GQOc+U2eKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944436; c=relaxed/simple;
	bh=dbx+BVRt7GsCl5PL/AnfI2ytrlqI6ooWiB7QuFeZT5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DE2XwJE6Mmf7Me2l92bi0EaFhN7znhKKPaRrHaXG2c1ABXDP8w5IQ7r2eNGFRwA2zWvZjQkcaODpdRd8LJABJIjljacqA9VR+hH6pDT2YOuwH8s+yR2OQ07i3ww9SMXQox4uLakNs6tX+U9xDkZ7LOMd4SLIxh5LOL+SQ4uc2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4bBQwW0q9hzYl8XY;
	Tue,  3 Jun 2025 17:51:55 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Jun
 2025 17:53:51 +0800
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
Subject: [PATCH v4 4/4] dmabuf:system_heap Implement system_heap dmabuf direct I/O
Date: Tue, 3 Jun 2025 17:52:45 +0800
Message-ID: <20250603095245.17478-5-tao.wangtao@honor.com>
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
 drivers/dma-buf/heaps/system_heap.c | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 26d5dc89ea16..85ffff7ef855 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -20,6 +20,8 @@
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/bvec.h>
+#include <linux/uio.h>
 
 static struct dma_heap *sys_heap;
 
@@ -281,6 +283,70 @@ static void system_heap_vunmap(struct dma_buf *dmabuf, struct iosys_map *map)
 	iosys_map_clear(map);
 }
 
+static ssize_t system_heap_buffer_rw_other(struct system_heap_buffer *buffer,
+			loff_t my_pos, struct file *other, loff_t pos,
+			size_t count, bool is_write)
+{
+	struct sg_table *sgt = &buffer->sg_table;
+	struct scatterlist *sg;
+	loff_t my_end = my_pos + count, bv_beg, bv_end = 0;
+	size_t i, bv_off, bv_len, bv_idx = 0;
+	struct bio_vec *bvec;
+	struct kiocb kiocb;
+	struct iov_iter iter;
+	unsigned int direction = is_write ? ITER_SOURCE : ITER_DEST;
+	ssize_t ret = 0;
+
+	bvec = kvcalloc(sgt->orig_nents, sizeof(*bvec), GFP_KERNEL);
+	if (!bvec)
+		return -ENOMEM;
+
+	init_sync_kiocb(&kiocb, other);
+	kiocb.ki_pos = pos;
+
+	for_each_sgtable_sg(sgt, sg, i) {
+		bv_beg = bv_end;
+		if (bv_beg >= my_end)
+			break;
+		bv_end += sg->offset + sg->length;
+		if (bv_end <= my_pos)
+			continue;
+
+		bv_len = min(bv_end, my_end) - max(my_pos, bv_beg);
+		bv_off = sg->offset + (my_pos > bv_beg ? my_pos - bv_beg : 0);
+		bvec_set_page(&bvec[bv_idx], sg_page(sg), bv_len, bv_off);
+		++bv_idx;
+	}
+
+	if (bv_idx > 0) {
+		/* start R/W. */
+		iov_iter_bvec(&iter, direction, bvec, bv_idx, count);
+		if (is_write)
+			ret = other->f_op->write_iter(&kiocb, &iter);
+		else
+			ret = other->f_op->read_iter(&kiocb, &iter);
+	}
+	kvfree(bvec);
+
+	return ret;
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
@@ -308,6 +374,7 @@ static const struct dma_buf_ops system_heap_buf_ops = {
 	.mmap = system_heap_mmap,
 	.vmap = system_heap_vmap,
 	.vunmap = system_heap_vunmap,
+	.rw_file = system_heap_dma_buf_rw_file,
 	.release = system_heap_dma_buf_release,
 };
 
@@ -400,6 +467,8 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		ret = PTR_ERR(dmabuf);
 		goto free_pages;
 	}
+	/* Support direct I/O */
+	dmabuf->file->f_mode |= FMODE_CAN_ODIRECT;
 	return dmabuf;
 
 free_pages:
-- 
2.17.1


