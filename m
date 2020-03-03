Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3442C1784B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 22:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbgCCVPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 16:15:22 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33068 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732075AbgCCVPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:15:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TraCUot_1583270112;
Received: from localhost(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TraCUot_1583270112)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 05:15:20 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, virtio-fs@redhat.com
Subject: [PATCH] fuse: make written data persistent after writing
Date:   Wed,  4 Mar 2020 05:15:11 +0800
Message-Id: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If this is a DSYNC write, make sure we push it to stable storage now
that we've written data.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
This patch is based on 5.5-rc5.

 fs/fuse/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a63d779eac10..08e3df618d7f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1541,6 +1541,8 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (res > 0)
 		fuse_write_update_size(inode, iocb->ki_pos);
 	inode_unlock(inode);
+	if (res > 0)
+		res = generic_write_sync(iocb, res);
 
 	return res;
 }
-- 
1.8.3.1

