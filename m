Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361786600A5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 13:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjAFMx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 07:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjAFMxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:53:41 -0500
Received: from out199-3.us.a.mail.aliyun.com (out199-3.us.a.mail.aliyun.com [47.90.199.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B6B736E8;
        Fri,  6 Jan 2023 04:53:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VZ-Iakh_1673009615;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VZ-Iakh_1673009615)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 20:53:36 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 5/6] erofs: implement .mmap for page cache sharing
Date:   Fri,  6 Jan 2023 20:53:29 +0800
Message-Id: <20230106125330.55529-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
References: <20230106125330.55529-1-jefflexu@linux.alibaba.com>
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

In mmap(2), replace vma->vm_file with the anonymous file associated with
the blob, so that the vma will be linked to the address_space of the
blob.

One thing worth noting is that, we return error early in mmap(2) if
users attempt to map beyond the file size.  Normally filesystems won't
restrict this in mmap(2).  The checking is done in the fault handler,
and SIGBUS will be signaled to users if they actually attempt to access
the area beyond the end of the file.  However since vma->vm_file has
been changed to the anonymous file in mmap(2), we can no way derive the
file size of the original file.  As file size is immutable in ro
filesystem, let's fail early in mmap(2) in this case.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 1f2a42dd1590..98341d4d9c0d 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -379,9 +379,46 @@ static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
 	return already_read ? already_read : ret;
 }
 
+static const struct vm_operations_struct erofs_fscache_share_file_vm_ops = {
+	.fault = filemap_fault,
+};
+
+static int erofs_fscache_share_file_mmap(struct file *file,
+					 struct vm_area_struct *vma)
+{
+	struct inode *inode = file_inode(file);
+	/* since page cache sharing is enabled only when i_size <= chunk_size */
+	struct erofs_map_blocks map = {}; /* .m_la = 0 */
+	struct erofs_map_dev mdev;
+	int ret;
+
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
+		return -EINVAL;
+
+	ret = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (ret)
+		return ret;
+
+	mdev = (struct erofs_map_dev) {
+		.m_deviceid = map.m_deviceid,
+		.m_pa = map.m_pa,
+	};
+	ret = erofs_map_dev(inode->i_sb, &mdev);
+	if (ret)
+		return ret;
+
+	vma_set_file(vma, mdev.m_fscache->file);
+	vma->vm_pgoff = (mdev.m_pa >> PAGE_SHIFT) + vma->vm_pgoff;
+	vma->vm_ops = &erofs_fscache_share_file_vm_ops;
+
+	file_accessed(file);
+	return 0;
+}
+
 const struct file_operations erofs_fscache_share_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_fscache_share_file_read_iter,
+	.mmap		= erofs_fscache_share_file_mmap,
 };
 
 static void erofs_fscache_domain_put(struct erofs_domain *domain)
-- 
2.19.1.6.gb485710b

