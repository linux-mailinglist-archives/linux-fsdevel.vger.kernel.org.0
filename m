Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE914665627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjAKIcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 03:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjAKIcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:32:14 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69443AE66;
        Wed, 11 Jan 2023 00:32:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZMSm9k_1673425924;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZMSm9k_1673425924)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 16:32:05 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 6/7] erofs: add helper checking if page cache sharing shall be enabled
Date:   Wed, 11 Jan 2023 16:31:57 +0800
Message-Id: <20230111083158.23462-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
References: <20230111083158.23462-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Erofs supports chunk deduplication to reduce disk usage.  Furthermore we
can make inodes share page cache of these deduplicated chunks to reduce
the memory usage.  This shall be much usable in container scenarios as
deduplication is requisite for container image.

This can be achieved by managing page cache of deduplicated chunks in
blob's address space.  In this way, all inodes sharing the deduplicated
chunk will refer to and share the page cache in the blob's address
space.

So far there are some restrictions for enabling this feature.

The page cache sharing feature also supports .mmap().  The reverse
mapping requires that one vma can not be shared among inodes and can
be linked to only one inode.  As the vma will be finally linked to the
blob's address space when page cache sharing enabled, the restriction of
the reverse mapping actually requires that the mapped file area can not
be mapped to multiple blobs.  Thus page cache sharing can only be
enabled for those files mapped to one blob.

The chunk based data layout guarantees that a chunk will not cross the
device (blob) boundary.  Thus in chunk based data layout, those files
smaller than the chunk size shall be guaranteed to be mapped to one
blob.  As chunk size is tunable at a per-file basis, this restriction
can be relaxed at image building phase.  As long as we ensure that the
file can not be deduplicated, the file's chunk size can be set to a
reasonable value larger than the file size, so that the page cache
sharing feature can be enabled on this file later.

The second restriction is that EROFS_BLKSIZ mus be multiples of
PAGE_SIZE to avoid data leakage.  Otherwise unrelated data may be
exposed at the end of the last page, since file's data is arranged in
unit of EROFS_BLKSIZ in the image.

Considering all these restrictions, add a helper checking if page cache
sharing shall be enabled for specific file.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7c6a7a2d9acf..adf6be08b47c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -368,6 +368,29 @@ static inline unsigned int erofs_inode_datalayout(unsigned int value)
 			      EROFS_I_DATALAYOUT_BITS);
 }
 
+static inline bool erofs_can_share_page(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
+
+	/* enable page cache sharing only in share domain mode */
+	if (!erofs_is_fscache_mode(inode->i_sb) || !sbi->domain_id)
+		return false;
+
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
+		return false;
+
+	/* avoid crossing multi devicces/blobs */
+	if (inode->i_size > 1UL << vi->chunkbits)
+		return false;
+
+	/* avoid data leakage in mmap routine */
+	if (EROFS_BLKSIZ % PAGE_SIZE)
+		return false;
+
+	return true;
+}
+
 /*
  * Different from grab_cache_page_nowait(), reclaiming is never triggered
  * when allocating new pages.
-- 
2.19.1.6.gb485710b

