Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8562B34B4A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 07:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhC0Ggd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 02:36:33 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47124 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230238AbhC0GgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 02:36:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UTRdtN4_1616826973;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UTRdtN4_1616826973)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 27 Mar 2021 14:36:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     miklos@szeredi.hu
Cc:     tao.peng@linux.alibaba.com, baolin.wang@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] fuse: Remove unused parameter
Date:   Sat, 27 Mar 2021 14:36:06 +0800
Message-Id: <73eb8cf3a3703bfd68d8e9f118612ce652574815.1616826872.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
References: <807bb470f90bae5dcd80a29020d38f6b5dd6ef8e.1616826872.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since we move the fuse_wait_on_page_writeback() to fuse_fill_write_pages(),
thus remove the unused 'inode' parameter of fuse_send_write_pages().

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - New patch.
---
 fs/fuse/file.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9a30093..40e2902 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1091,7 +1091,7 @@ bool fuse_write_update_size(struct inode *inode, loff_t pos)
 }
 
 static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
-				     struct kiocb *iocb, struct inode *inode,
+				     struct kiocb *iocb,
 				     loff_t pos, size_t count)
 {
 	struct fuse_args_pages *ap = &ia->ap;
@@ -1238,8 +1238,7 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
 		if (count <= 0) {
 			err = count;
 		} else {
-			err = fuse_send_write_pages(&ia, iocb, inode,
-						    pos, count);
+			err = fuse_send_write_pages(&ia, iocb, pos, count);
 			if (!err) {
 				size_t num_written = ia.write.out.size;
 
-- 
1.8.3.1

