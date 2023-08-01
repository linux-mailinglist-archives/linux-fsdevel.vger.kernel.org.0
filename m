Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B3376AA86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHAIHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHAIHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:07:07 -0400
Received: from out-64.mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7404CCF
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 01:07:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690877224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ModtEnc9LaTnhOubIf6LKOM/uNvB9XEMQr3k9O1RjEE=;
        b=wAH4wJt8jzt21BD+f7EMz/7PD+d/1qrl0+HUjoFgMmxPZmg/5vW2s5io2VQuqxAzmk3oKs
        2plu7Ow6K7S8x5aZ0O0NLVldmY+tVvrLT6UjSN8QqyuIQJhNvPIdmt9LxyuiiJqzEWo2pf
        12tzH54D7izXQ+yxLxBsRIHaFNtI4hM=
From:   Hao Xu <hao.xu@linux.dev>
To:     fuse-devel@lists.sourceforge.net, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Wanpeng Li <wanpengli@tencent.com>, cgxu519@mykernel.net
Subject: [PATCH 1/3] fuse: invalidate page cache pages before direct write
Date:   Tue,  1 Aug 2023 16:06:45 +0800
Message-Id: <20230801080647.357381-2-hao.xu@linux.dev>
In-Reply-To: <20230801080647.357381-1-hao.xu@linux.dev>
References: <20230801080647.357381-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

In FOPEN_DIRECT_IO, page cache may still be there for a file since
private mmap is allowed. Direct write should respect that and invalidate
the corresponding pages so that page cache readers don't get stale data.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/fuse/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index bc4115288eec..3d320fc99859 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1465,7 +1465,8 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	int write = flags & FUSE_DIO_WRITE;
 	int cuse = flags & FUSE_DIO_CUSE;
 	struct file *file = io->iocb->ki_filp;
-	struct inode *inode = file->f_mapping->host;
+	struct address_space *mapping = file->f_mapping;
+	struct inode *inode = mapping->host;
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
 	size_t nmax = write ? fc->max_write : fc->max_read;
@@ -1477,6 +1478,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	int err = 0;
 	struct fuse_io_args *ia;
 	unsigned int max_pages;
+	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
 
 	max_pages = iov_iter_npages(iter, fc->max_pages);
 	ia = fuse_io_alloc(io, max_pages);
@@ -1491,6 +1493,14 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			inode_unlock(inode);
 	}
 
+	if (fopen_direct_io && write) {
+		res = invalidate_inode_pages2_range(mapping, idx_from, idx_to);
+		if (res) {
+			fuse_io_free(ia);
+			return res;
+		}
+	}
+
 	io->should_dirty = !write && user_backed_iter(iter);
 	while (count) {
 		ssize_t nres;
-- 
2.25.1

