Return-Path: <linux-fsdevel+bounces-50211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E599EAC8C45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 12:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6413A7AD92F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0897224225;
	Fri, 30 May 2025 10:40:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27D1DA5F;
	Fri, 30 May 2025 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601657; cv=none; b=C9HuAJbI+fEgbhTXaVJa+uqyYrFnHiEIkUalcKwQe4jDIUsOO1o6UPZt9I7CtiQt4YPD0NqhfETBh87I+CRmcTKQeS4BGIld6sqxbOAhey1rOGPOLzImiLtSYt8HYspQCkJ8TZbxPr4+q/hBOUsyPsuw4PVGICD09ITIEGdlgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601657; c=relaxed/simple;
	bh=0CrEa+93oV3lNWDABrVddBk4IQRMdXd+GbD0mQaKIgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFyMYMhsnpqcJOPEd14YNlW3deBAqXUby2EYHTvyNB/nbVzmJ+fsI3JhmaYqmSmyRt9WwDgmpLJvNsG5buVnTf58i6Vg4RXa+yLT1fh3zlz08AAprQEZFJJIVkatWAYWYDo0EMHPfYfjT/nhCQ/T+G3trHf1Rl2E4U1uDweqj5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4b808Y0D6pzYl7rs;
	Fri, 30 May 2025 18:38:53 +0800 (CST)
Received: from a010.hihonor.com (10.68.16.52) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH v3 3/4] udmabuf: Implement udmabuf rw_file callback
Date: Fri, 30 May 2025 18:39:40 +0800
Message-ID: <20250530103941.11092-4-tao.wangtao@honor.com>
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

Construct bio_vec from folios, then call the other file's
r/w callbacks for IO operations.
Test data shows direct I/O copy_file_range improves performance by
over 50% vs direct I/O mmap&read (2557 vs 1534).

Test data:
|    32x32MB Read 1024MB  |Creat-ms|Close-ms|  I/O-ms|I/O-MB/s| I/O%
|-------------------------|--------|--------|--------|--------|-----
| 1)Beg udmabuf buffer R/W|    580 |    323 |   1238 |    867 | 100%
| 2)     dmabuf buffer R/W|     48 |      5 |   1149 |    934 | 107%
| 3) udma+memfd buffer R/W|    597 |    340 |   2157 |    497 |  57%
| 4) udma+memfd direct R/W|    573 |    340 |    700 |   1534 | 176%
| 5) u+mfd buffer sendfile|    577 |    340 |   1204 |    891 | 102%
| 6) u+mfd direct sendfile|    567 |    339 |   2272 |    472 |  54%
| 7)   u+mfd buffer splice|    570 |    337 |   1114 |    964 | 111%
| 8)   u+mfd direct splice|    564 |    335 |    793 |   1355 | 156%
| 9)  udmabuf buffer c_f_r|    577 |    323 |   1059 |   1014 | 116%
|10)  udmabuf direct c_f_r|    582 |    325 |    420 |   2557 | 294%
|11)End udmabuf buffer R/W|    586 |    323 |   1188 |    903 | 104%

Signed-off-by: wangtao <tao.wangtao@honor.com>
---
 drivers/dma-buf/udmabuf.c | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index e74e36a8ecda..573275a51674 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -284,6 +284,64 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
 	return 0;
 }
 
+static ssize_t udmabuf_rw_file(struct dma_buf *dmabuf, loff_t my_pos,
+			struct file *other, loff_t pos,
+			size_t count, bool is_write)
+{
+	struct udmabuf *ubuf = dmabuf->priv;
+	loff_t my_end = my_pos + count, bv_beg, bv_end = 0;
+	pgoff_t pg_idx = my_pos / PAGE_SIZE;
+	pgoff_t pg_end = DIV_ROUND_UP(my_end, PAGE_SIZE);
+	size_t i, bv_off, bv_len, bv_num, bv_idx = 0, bv_total = 0;
+	struct bio_vec *bvec;
+	struct kiocb kiocb;
+	struct iov_iter iter;
+	unsigned int direction = is_write ? ITER_SOURCE : ITER_DEST;
+	ssize_t ret = 0, rw_total = 0;
+	struct folio *folio;
+
+	bv_num = min_t(size_t, pg_end - pg_idx + 1, 1024);
+	bvec = kvcalloc(bv_num, sizeof(*bvec), GFP_KERNEL);
+	if (!bvec)
+		return -ENOMEM;
+
+	init_sync_kiocb(&kiocb, other);
+	kiocb.ki_pos = pos;
+
+	for (i = 0; i < ubuf->nr_pinned && my_pos < my_end; i++) {
+		folio = ubuf->pinned_folios[i];
+		bv_beg = bv_end;
+		bv_end += folio_size(folio);
+		if (bv_end <= my_pos)
+			continue;
+
+		bv_len = min(bv_end, my_end) - my_pos;
+		bv_off = my_pos - bv_beg;
+		my_pos += bv_len;
+		bv_total += bv_len;
+		bvec_set_page(&bvec[bv_idx], &folio->page, bv_len, bv_off);
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
 static const struct dma_buf_ops udmabuf_ops = {
 	.cache_sgt_mapping = true,
 	.map_dma_buf	   = map_udmabuf,
@@ -294,6 +352,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 	.vunmap		   = vunmap_udmabuf,
 	.begin_cpu_access  = begin_cpu_udmabuf,
 	.end_cpu_access    = end_cpu_udmabuf,
+	.rw_file = udmabuf_rw_file,
 };
 
 #define SEALS_WANTED (F_SEAL_SHRINK)
-- 
2.17.1


