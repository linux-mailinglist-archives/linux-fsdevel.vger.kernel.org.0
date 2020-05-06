Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115881C742B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgEFPVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 11:21:31 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58877 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729264AbgEFPVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TxkpwMS_1588778487;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TxkpwMS_1588778487)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 May 2020 23:21:27 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     virtio-fs@redhat.com, miklos@szeredi.hu,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH RFC] fuse: invalidate inode attr in writeback cache mode
Date:   Wed,  6 May 2020 23:20:44 +0800
Message-Id: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Under writeback mode, inode->i_blocks is not updated, making utils like
du read st.blocks as 0.

For example, when using virtiofs (cache=always & nondax mode) with
writeback_cache enabled, writing a new file and check its disk usage
with du, du reports 0 usage.

  # uname -r
  5.6.0-rc6+
  # mount -t virtiofs virtiofs /mnt/virtiofs
  # rm -f /mnt/virtiofs/testfile

  # create new file and do extend write
  # xfs_io -fc "pwrite 0 4k" /mnt/virtiofs/testfile
  wrote 4096/4096 bytes at offset 0
  4 KiB, 1 ops; 0.0001 sec (28.103 MiB/sec and 7194.2446 ops/sec)
  # stat -c %s,%b /mnt/virtiofs/testfile
  4096,0	  <==== i_size is correct, but block usage is 0

Fix it by invalidating attr in fuse_write_end(), like other write paths.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d67b830fb7a..3c875104ca11 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2228,6 +2228,7 @@ static int fuse_write_end(struct file *file, struct address_space *mapping,
 	}
 
 	fuse_write_update_size(inode, pos + copied);
+	fuse_invalidate_attr(inode);
 	set_page_dirty(page);
 
 unlock:
-- 
1.8.3.1

