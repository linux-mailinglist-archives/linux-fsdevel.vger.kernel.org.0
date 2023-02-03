Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9089688DBA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjBCDC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 22:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjBCDCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:02:11 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78083929E;
        Thu,  2 Feb 2023 19:01:52 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Vamlo-T_1675393309;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vamlo-T_1675393309)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:50 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     huyue2@coolpad.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 7/9] erofs: implement .mmap for page cache sharing
Date:   Fri,  3 Feb 2023 11:01:41 +0800
Message-Id: <20230203030143.73105-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
References: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
 fs/erofs/fscache.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bdeb048b78b5..af6ba52bbe8b 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -432,9 +432,36 @@ static ssize_t erofs_fscache_share_file_read_iter(struct kiocb *iocb,
 	return res;
 }
 
+vm_fault_t erofs_fscache_share_fault(struct vm_fault *vmf)
+{
+	struct erofs_fscache_finfo *finfo = vmf->vma->vm_file->private_data;
+
+	if (unlikely(vmf->pgoff >= finfo->max_idx))
+		return VM_FAULT_SIGBUS;
+	return filemap_fault(vmf);
+}
+
+static const struct vm_operations_struct erofs_fscache_share_file_vm_ops = {
+	.fault = erofs_fscache_share_fault,
+};
+
+static int erofs_fscache_share_file_mmap(struct file *file,
+					 struct vm_area_struct *vma)
+{
+	struct file *realfile = file->private_data;
+	struct erofs_fscache_finfo *finfo = realfile->private_data;
+
+	vma_set_file(vma, realfile);
+	vma->vm_pgoff = (finfo->pa >> PAGE_SHIFT) + vma->vm_pgoff;
+	vma->vm_ops = &erofs_fscache_share_file_vm_ops;
+	file_accessed(file);
+	return 0;
+}
+
 const struct file_operations erofs_fscache_share_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_fscache_share_file_read_iter,
+	.mmap		= erofs_fscache_share_file_mmap,
 	.open		= erofs_fscache_share_file_open,
 	.release	= erofs_fscache_share_file_release,
 };
-- 
2.19.1.6.gb485710b

