Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644BB8B3A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfHMJOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 05:14:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728522AbfHMJOm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:14:42 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 19E2C830EBA6408DDB83;
        Tue, 13 Aug 2019 17:14:40 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 13 Aug
 2019 17:14:31 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        "Dave Chinner" <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v7 21/24] erofs: introduce LZ4 decompression inplace
Date:   Tue, 13 Aug 2019 17:13:23 +0800
Message-ID: <20190813091326.84652-22-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813091326.84652-1-gaoxiang25@huawei.com>
References: <20190813091326.84652-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

compressed data will be usually loaded into last pages of
the extent (the last page for 4k) for in-place decompression
(more specifically, in-place IO), as ilustration below,

         start of compressed logical extent
           |                          end of this logical extent
           |                           |
     ______v___________________________v________
... |  page 6  |  page 7  |  page 8  |  page 9  | ...
    |__________|__________|__________|__________|
           .                         ^ .        ^
           .                         |compressed|
           .                         |   data   |
           .                           .        .
           |<          dstsize        >|<margin>|
                                       oend     iend
           op                        ip

Therefore, it's possible to do decompression inplace (thus no
memcpy at all) if the margin is sufficient and safe enough [1],
and it can be implemented only for fixed-size output compression
compared with fixed-size input compression.

No memcpy for most of in-place IO (about 99% of enwik9) after
decompression inplace is implemented and sequential read will
be improved of course (see the following patches for test results).

[1] https://github.com/lz4/lz4/commit/b17f578a919b7e6b078cede2d52be29dd48c8e8c
    https://github.com/lz4/lz4/commit/5997e139f53169fa3a1c1b4418d2452a90b01602

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/decompressor.c | 36 ++++++++++++++++++++++++++++++++----
 fs/erofs/erofs_fs.h     |  2 +-
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 244afb29907d..1e9e1359e40c 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -15,6 +15,9 @@
 #endif
 
 #define LZ4_MAX_DISTANCE_PAGES	(DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE) + 1)
+#ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
+#define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
+#endif
 
 struct z_erofs_decompressor {
 	/*
@@ -117,7 +120,7 @@ static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 {
 	unsigned int inputmargin, inlen;
 	u8 *src;
-	bool copied;
+	bool copied, support_0padding;
 	int ret;
 
 	if (rq->inputsize > PAGE_SIZE)
@@ -125,13 +128,38 @@ static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 
 	src = kmap_atomic(*rq->in);
 	inputmargin = 0;
+	support_0padding = false;
+
+	/* decompression inplace is only safe when 0padding is enabled */
+	if (EROFS_SB(rq->sb)->requirements & EROFS_REQUIREMENT_LZ4_0PADDING) {
+		support_0padding = true;
+
+		while (!src[inputmargin & ~PAGE_MASK])
+			if (!(++inputmargin & ~PAGE_MASK))
+				break;
+
+		if (inputmargin >= rq->inputsize) {
+			kunmap_atomic(src);
+			return -EIO;
+		}
+	}
 
 	copied = false;
 	inlen = rq->inputsize - inputmargin;
 	if (rq->inplace_io) {
-		src = generic_copy_inplace_data(rq, src, inputmargin);
-		inputmargin = 0;
-		copied = true;
+		const uint oend = (rq->pageofs_out +
+				   rq->outputsize) & ~PAGE_MASK;
+		const uint nr = PAGE_ALIGN(rq->pageofs_out +
+					   rq->outputsize) >> PAGE_SHIFT;
+
+		if (rq->partial_decoding || !support_0padding ||
+		    rq->out[nr - 1] != rq->in[0] ||
+		    rq->inputsize - oend <
+		      LZ4_DECOMPRESS_INPLACE_MARGIN(inlen)) {
+			src = generic_copy_inplace_data(rq, src, inputmargin);
+			inputmargin = 0;
+			copied = true;
+		}
 	}
 
 	ret = LZ4_decompress_safe_partial(src + inputmargin, out,
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 230fcba1099d..c0fb7d6ebfcb 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -17,7 +17,7 @@
  * incompatible with this kernel version.
  */
 #define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
-#define EROFS_ALL_REQUIREMENTS		0
+#define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
 struct erofs_super_block {
 /*  0 */__le32 magic;           /* in the little endian */
-- 
2.17.1

