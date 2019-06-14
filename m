Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2246759
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFNSRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:17:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfFNSRU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:17:20 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5EF177F87281E159457A;
        Sat, 15 Jun 2019 02:17:18 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 15 Jun
 2019 02:17:10 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <chao@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [RFC PATCH 5/8] staging: erofs: introduce generic decompression backend
Date:   Sat, 15 Jun 2019 02:16:16 +0800
Message-ID: <20190614181619.64905-6-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614181619.64905-1-gaoxiang25@huawei.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a new generic decompression framework
in order to replace the old LZ4-specific decompression code.

Even though LZ4 is still the only supported algorithm, yet
it is more cleaner and easy to integrate new algorithm than
the old almost hard-coded decompression backend.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Makefile       |   2 +-
 drivers/staging/erofs/compress.h     |  21 ++
 drivers/staging/erofs/decompressor.c | 306 +++++++++++++++++++++++++++
 3 files changed, 328 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/erofs/decompressor.c

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index 84b412c7a991..adeb5d6e2668 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_EROFS_FS) += erofs.o
 ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o unzip_vle_lz4.o zmap.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o unzip_vle_lz4.o zmap.o decompressor.o
 
diff --git a/drivers/staging/erofs/compress.h b/drivers/staging/erofs/compress.h
index 1dcfc3b35118..ebeccb1f4eae 100644
--- a/drivers/staging/erofs/compress.h
+++ b/drivers/staging/erofs/compress.h
@@ -9,6 +9,24 @@
 #ifndef __EROFS_FS_COMPRESS_H
 #define __EROFS_FS_COMPRESS_H
 
+#include "internal.h"
+
+enum {
+	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_RUNTIME_MAX
+};
+
+struct z_erofs_decompress_req {
+	struct page **in, **out;
+
+	unsigned short pageofs_out;
+	unsigned int inputsize, outputsize;
+
+	/* indicate the algorithm will be used for decompression */
+	unsigned int alg;
+	bool inplace_io, partial_decoding;
+};
+
 /*
  * - 0x5A110C8D ('sallocated', Z_EROFS_MAPPING_STAGING) -
  * used to mark temporary allocated pages from other
@@ -36,5 +54,8 @@ static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
 	return true;
 }
 
+int z_erofs_decompress(struct z_erofs_decompress_req *rq,
+		       struct list_head *pagepool);
+
 #endif
 
diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
new file mode 100644
index 000000000000..4f644bdea0bc
--- /dev/null
+++ b/drivers/staging/erofs/decompressor.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/drivers/staging/erofs/decompressor.c
+ *
+ * Copyright (C) 2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "compress.h"
+#include <linux/lz4.h>
+
+#ifndef LZ4_DISTANCE_MAX	/* history window size */
+#define LZ4_DISTANCE_MAX 65535	/* set to maximum value by default */
+#endif
+
+#define LZ4_MAX_DISTANCE_PAGES	DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE)
+
+struct z_erofs_decompressor {
+	/*
+	 * if destpages have sparsed pages, fill them with bounce pages.
+	 * it also check whether destpages indicate continuous physical memory.
+	 */
+	int (*prepare_destpages)(struct z_erofs_decompress_req *rq,
+				 struct list_head *pagepool);
+	int (*decompress)(struct z_erofs_decompress_req *rq, u8 *out);
+	char *name;
+};
+
+static int lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
+				 struct list_head *pagepool)
+{
+	const unsigned int nr =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
+	unsigned long unused[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
+					  BITS_PER_LONG)] = { 0 };
+	void *kaddr = NULL;
+	unsigned int i, j, k;
+
+	for (i = 0; i < nr; ++i) {
+		struct page *const page = rq->out[i];
+
+		j = i & (LZ4_MAX_DISTANCE_PAGES - 1);
+		if (availables[j])
+			__set_bit(j, unused);
+
+		if (page) {
+			if (kaddr) {
+				if (kaddr + PAGE_SIZE == page_address(page))
+					kaddr += PAGE_SIZE;
+				else
+					kaddr = NULL;
+			} else if (!i) {
+				kaddr = page_address(page);
+			}
+			continue;
+		}
+		kaddr = NULL;
+
+		k = find_first_bit(unused, LZ4_MAX_DISTANCE_PAGES);
+		if (k < LZ4_MAX_DISTANCE_PAGES) {
+			j = k;
+			get_page(availables[j]);
+		} else {
+			DBG_BUGON(availables[j]);
+
+			if (!list_empty(pagepool)) {
+				availables[j] = lru_to_page(pagepool);
+				list_del(&availables[j]->lru);
+			} else {
+				availables[j] = alloc_pages(GFP_KERNEL, 0);
+				if (!availables[j])
+					return -ENOMEM;
+			}
+			availables[j]->mapping = Z_EROFS_MAPPING_STAGING;
+		}
+		rq->out[i] = availables[j];
+		__clear_bit(j, unused);
+	}
+	return kaddr ? 1 : 0;
+}
+
+static void *generic_copy_inplace_data(struct z_erofs_decompress_req *rq,
+				       u8 *src, unsigned int pageofs_in)
+{
+	/*
+	 * if in-place decompression is ongoing, those decompressed
+	 * pages should be copied in order to avoid being overlapped.
+	 */
+	struct page **in = rq->in;
+	void *const tmp = erofs_get_pcpubuf(0);
+	u8 *tmpp = tmp;
+	unsigned int inlen = rq->inputsize - pageofs_in;
+	unsigned int count = min_t(uint, inlen, PAGE_SIZE - pageofs_in);
+
+	while (inlen) {
+		if (!src)
+			src = kmap_atomic(*in++);
+		memcpy(tmpp, src + pageofs_in, count);
+		kunmap_atomic(src);
+		src = NULL;
+		inlen -= count;
+		tmpp += count;
+		pageofs_in = 0;
+		count = PAGE_SIZE;
+	}
+	return tmp;
+}
+
+static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+{
+	unsigned int inputmargin, inlen;
+	u8 *src;
+	bool copied;
+	int ret;
+
+	if (rq->inputsize > PAGE_SIZE)
+		return -ENOTSUPP;
+
+	src = kmap_atomic(*rq->in);
+	inputmargin = 0;
+	while (!src[inputmargin & ~PAGE_MASK])
+		if (!(++inputmargin & ~PAGE_MASK))
+			break;
+
+	if (inputmargin >= rq->inputsize) {
+		kunmap_atomic(src);
+		return -EIO;
+	}
+
+	copied = false;
+	inlen = rq->inputsize - inputmargin;
+	if (rq->inplace_io) {
+		src = generic_copy_inplace_data(rq, src, inputmargin);
+		inputmargin = 0;
+		copied = true;
+	}
+
+	ret = LZ4_decompress_safe_partial(src + inputmargin, out,
+					  inlen, rq->outputsize,
+					  rq->outputsize);
+	if (ret < 0) {
+		errln("%s, failed to decompress, in[%p, %u, %u] out[%p, %u]",
+		      __func__, src + inputmargin, inlen, inputmargin,
+		      out, rq->outputsize);
+		WARN_ON(1);
+		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
+			       16, 1, src + inputmargin, inlen, true);
+		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
+			       16, 1, out, rq->outputsize, true);
+		ret = -EIO;
+	}
+
+	if (copied)
+		erofs_put_pcpubuf(src);
+	else
+		kunmap_atomic(src);
+	return ret;
+}
+
+static struct z_erofs_decompressor decompressors[] = {
+	[Z_EROFS_COMPRESSION_SHIFTED] = {
+		.name = "shifted"
+	},
+	[Z_EROFS_COMPRESSION_LZ4] = {
+		.prepare_destpages = lz4_prepare_destpages,
+		.decompress = lz4_decompress,
+		.name = "lz4"
+	},
+};
+
+static void copy_from_pcpubuf(struct page **out, const char *dst,
+			      unsigned short pageofs_out,
+			      unsigned int outputsize)
+{
+	const char *end = dst + outputsize;
+	const unsigned int righthalf = PAGE_SIZE - pageofs_out;
+	const char *cur = dst - pageofs_out;
+
+	while (cur < end) {
+		struct page *const page = *out++;
+
+		if (page) {
+			char *buf = kmap_atomic(page);
+
+			if (cur >= dst) {
+				memcpy(buf, cur, min_t(uint, PAGE_SIZE,
+						       end - cur));
+			} else {
+				memcpy(buf + pageofs_out, cur + pageofs_out,
+				       min_t(uint, righthalf, end - cur));
+			}
+			kunmap_atomic(buf);
+		}
+		cur += PAGE_SIZE;
+	}
+}
+
+static int decompress_generic(struct z_erofs_decompress_req *rq,
+			      struct list_head *pagepool)
+{
+	const unsigned int nrpages_out =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	const struct z_erofs_decompressor *alg = decompressors + rq->alg;
+	unsigned int dst_maptype;
+	void *dst;
+	int ret;
+
+	if (nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
+	}
+
+	/*
+	 * For the case of small output size (especially much less
+	 * than PAGE_SIZE), memcpy the decompressed data rather than
+	 * compressed data is preferred.
+	 */
+	if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
+		dst = erofs_get_pcpubuf(0);
+
+		rq->inplace_io = false;
+		ret = alg->decompress(rq, dst);
+		if (!ret)
+			copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
+					  rq->outputsize);
+
+		erofs_put_pcpubuf(dst);
+		return ret;
+	}
+
+	ret = alg->prepare_destpages(rq, pagepool);
+	if (ret < 0) {
+		return ret;
+	} else if (ret) {
+		dst = page_address(*rq->out);
+		dst_maptype = 1;
+		goto dstmap_out;
+	}
+
+	dst = erofs_vmap(rq->out, nrpages_out);
+	if (!dst)
+		return -ENOMEM;
+	dst_maptype = 2;
+
+dstmap_out:
+	ret = alg->decompress(rq, dst + rq->pageofs_out);
+
+	if (!dst_maptype)
+		kunmap_atomic(dst);
+	else if (dst_maptype == 2)
+		erofs_vunmap(dst, nrpages_out);
+	return ret;
+}
+
+static int shifted_decompress(const struct z_erofs_decompress_req *rq,
+			      struct list_head *pagepool)
+{
+	const unsigned int nrpages_out =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	const unsigned int righthalf = PAGE_SIZE - rq->pageofs_out;
+	unsigned char *src, *dst;
+
+	if (nrpages_out > 2) {
+		DBG_BUGON(1);
+		return -EIO;
+	}
+
+	if (rq->out[0] == *rq->in) {
+		DBG_BUGON(nrpages_out != 1);
+		return 0;
+	}
+
+	src = kmap_atomic(*rq->in);
+	if (!rq->out[0]) {
+		dst = NULL;
+	} else {
+		dst = kmap_atomic(rq->out[0]);
+		memcpy(dst + rq->pageofs_out, src, righthalf);
+	}
+
+	if (rq->out[1] == *rq->in) {
+		memmove(src, src + righthalf, rq->pageofs_out);
+	} else if (nrpages_out == 2) {
+		if (dst)
+			kunmap_atomic(dst);
+		DBG_BUGON(!rq->out[1]);
+		dst = kmap_atomic(rq->out[1]);
+		memcpy(dst, src + righthalf, rq->pageofs_out);
+	}
+	if (dst)
+		kunmap_atomic(dst);
+	kunmap_atomic(src);
+	return 0;
+}
+
+int z_erofs_decompress(struct z_erofs_decompress_req *rq,
+		       struct list_head *pagepool)
+{
+	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
+		return shifted_decompress(rq, pagepool);
+	return decompress_generic(rq, pagepool);
+}
+
-- 
2.17.1

