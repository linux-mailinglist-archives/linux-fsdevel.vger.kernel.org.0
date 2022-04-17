Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B55046FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Apr 2022 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiDQHsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 03:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiDQHsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 03:48:47 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5C72B8;
        Sun, 17 Apr 2022 00:46:12 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23H7k87b062178;
        Sun, 17 Apr 2022 16:46:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Sun, 17 Apr 2022 16:46:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23H7k7Yh062171
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Apr 2022 16:46:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ff8f59e5-7699-0ccd-4da3-a34aa934a16b@I-love.SAKURA.ne.jp>
Date:   Sun, 17 Apr 2022 16:46:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] block: add filemap_invalidate_lock_killable()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting hung task at blkdev_fallocate() [1], for it can take
minutes with mapping->invalidate_lock held. Since fallocate() has to accept
64bits size, we can't predict how long it will take. Thus, mitigate this
problem by using killable wait where possible.

  ----------
  #define _GNU_SOURCE
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <unistd.h>

  int main(int argc, char *argv[])
  {
    fork();
    fallocate(open("/dev/nullb0", O_RDWR), 0x11, 0, ~0UL >> 1);
    return 0;
  }
  ----------

Note that, even after this patch, e.g. "cat /dev/nullb0" can be reported
as hung task at filemap_invalidate_lock_shared() when this reproducer is
running. We will need to also make fault-acceptable reads killable.

  __schedule+0x9a0/0xb20
  schedule+0xc1/0x120
  rwsem_down_read_slowpath+0x3b5/0x670
  __down_read_common+0x56/0x1f0
  page_cache_ra_unbounded+0x12d/0x400
  filemap_read+0x4bb/0x1280
  blkdev_read_iter+0x1d5/0x260
  vfs_read+0x5f8/0x690
  ksys_read+0xee/0x190
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Link: https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc [1]
Reported-by: syzbot <syzbot+39b75c02b8be0a061bfc@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Converted all users in block/ directory and fs/open.c file.
  I didn't convert remaining users because remaining users should be
  carefully converted by each filesystem's developers.

 block/blk-zoned.c  | 3 ++-
 block/fops.c       | 3 ++-
 block/ioctl.c      | 6 ++++--
 fs/open.c          | 3 ++-
 include/linux/fs.h | 5 +++++
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8838..07a8841f4724 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -422,7 +422,8 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		op = REQ_OP_ZONE_RESET;
 
 		/* Invalidate the page cache, including dirty pages. */
-		filemap_invalidate_lock(bdev->bd_inode->i_mapping);
+		if (filemap_invalidate_lock_killable(bdev->bd_inode->i_mapping))
+			return -EINTR;
 		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
 		if (ret)
 			goto fail;
diff --git a/block/fops.c b/block/fops.c
index ba5e7d5ff9a5..418fb1d789ff 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -656,7 +656,8 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	if (filemap_invalidate_lock_killable(inode->i_mapping))
+		return -EINTR;
 
 	/* Invalidate the page cache, including dirty pages. */
 	error = truncate_bdev_range(bdev, file->f_mode, start, end);
diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e4..13f863f79f68 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -111,7 +111,8 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	if (start + len > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	if (filemap_invalidate_lock_killable(inode->i_mapping))
+		return -EINTR;
 	err = truncate_bdev_range(bdev, mode, start, start + len - 1);
 	if (err)
 		goto fail;
@@ -152,7 +153,8 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		return -EINVAL;
 
 	/* Invalidate the page cache, including dirty pages */
-	filemap_invalidate_lock(inode->i_mapping);
+	if (filemap_invalidate_lock_killable(inode->i_mapping))
+		return -EINTR;
 	err = truncate_bdev_range(bdev, mode, start, end);
 	if (err)
 		goto fail;
diff --git a/fs/open.c b/fs/open.c
index 7b50d7a2f51d..adf62e1c186b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -859,7 +859,8 @@ static int do_dentry_open(struct file *f,
 		if (filemap_nr_thps(inode->i_mapping)) {
 			struct address_space *mapping = inode->i_mapping;
 
-			filemap_invalidate_lock(inode->i_mapping);
+			if (filemap_invalidate_lock_killable(inode->i_mapping))
+				return -EINTR;
 			/*
 			 * unmap_mapping_range just need to be called once
 			 * here, because the private pages is not need to be
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03f8d95bd4ef..e0134c372b6d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -797,6 +797,11 @@ static inline void filemap_invalidate_lock(struct address_space *mapping)
 	down_write(&mapping->invalidate_lock);
 }
 
+static inline int filemap_invalidate_lock_killable(struct address_space *mapping)
+{
+	return down_write_killable(&mapping->invalidate_lock);
+}
+
 static inline void filemap_invalidate_unlock(struct address_space *mapping)
 {
 	up_write(&mapping->invalidate_lock);
-- 
2.32.0
