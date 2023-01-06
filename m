Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0BB6600A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 13:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjAFMyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 07:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjAFMxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:53:44 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE268CA1;
        Fri,  6 Jan 2023 04:53:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-H5ZQ_1673009616;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-H5ZQ_1673009616)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:37 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 6/6] erofs: enable page cache sharing in fscache mode
Date:   Fri,  6 Jan 2023 20:53:30 +0800
Message-Id: <20230106125330.55529-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
References: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/inode.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d3b8736fa124..8fe9b29422b5 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -241,6 +241,29 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 	return 0;
 }
 
+static bool erofs_can_share_page_cache(struct inode *inode)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+
+	/* enable page cache sharing only in share domain mode */
+	if (!erofs_is_fscache_mode(inode->i_sb) ||
+	    !EROFS_SB(inode->i_sb)->domain_id)
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
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
@@ -262,6 +285,10 @@ static int erofs_fill_inode(struct inode *inode)
 		inode->i_op = &erofs_generic_iops;
 		if (erofs_inode_is_data_compressed(vi->datalayout))
 			inode->i_fop = &generic_ro_fops;
+#ifdef CONFIG_EROFS_FS_ONDEMAND
+		else if (erofs_can_share_page_cache(inode))
+			inode->i_fop = &erofs_fscache_share_file_fops;
+#endif
 		else
 			inode->i_fop = &erofs_file_fops;
 		break;
-- 
2.19.1.6.gb485710b

