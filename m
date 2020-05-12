Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CE1CEABF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgELC3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 22:29:15 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:38367 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbgELC3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 22:29:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TyInmMm_1589250552;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TyInmMm_1589250552)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 May 2020 10:29:13 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     virtio-fs@redhat.com, miklos@szeredi.hu,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Eryu Guan <eguan@linux.alibaba.com>
Subject: [PATCH v2] fuse: invalidate inode attr in writeback cache mode
Date:   Tue, 12 May 2020 10:29:04 +0800
Message-Id: <20200512022904.75689-1-eguan@linux.alibaba.com>
X-Mailer: git-send-email 2.26.1.107.gefe3874
In-Reply-To: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com>
References: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Under writeback mode, inode->i_blocks is not updated, making utils du
read st.blocks as 0.

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
  # du -k /mnt/virtiofs/testfile
  0               <==== disk usage is 0
  # stat -c %s,%b /mnt/virtiofs/testfile
  4096,0          <==== i_size is correct, but st_blocks is 0

Fix it by invalidating attr in fuse_flush(), so we get up-to-date attr
from server on next getattr.

Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
---
v2:
- do fuse_invalidate_attr() in fuse_flush() as Miklos suggested

 fs/fuse/file.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d67b830fb7a..4bb399caec01 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -445,8 +445,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (is_bad_inode(inode))
 		return -EIO;
 
+	err = 0;
 	if (fc->no_flush)
-		return 0;
+		goto inval_attr_out;
 
 	err = write_inode_now(inode, 1);
 	if (err)
@@ -475,6 +476,14 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 		fc->no_flush = 1;
 		err = 0;
 	}
+
+inval_attr_out:
+	/*
+	 * In memory i_blocks is not maintained by fuse, if writeback cache is
+	 * enabled, i_blocks from cached attr may not be accurate.
+	 */
+	if (!err && fc->writeback_cache)
+		fuse_invalidate_attr(inode);
 	return err;
 }
 
-- 
2.26.1.107.gefe3874

