Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135ED48300B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jan 2022 11:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiACKt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jan 2022 05:49:29 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52656 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiACKt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:49:28 -0500
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 203AnN5b094507;
        Mon, 3 Jan 2022 19:49:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Mon, 03 Jan 2022 19:49:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 203AnG8t094290
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Jan 2022 19:49:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3392d41c-5477-118a-677f-5780f9cedf95@I-love.SAKURA.ne.jp>
Date:   Mon, 3 Jan 2022 19:49:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: [PATCH] block: add filemap_invalidate_lock_killable()
Content-Language: en-US
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
References: <0000000000007305e805d4a9e7f9@google.com>
Cc:     linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000007305e805d4a9e7f9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting hung task at blkdev_fallocate() [1], for it can take
minutes with mapping->invalidate_lock held. Since fallocate() has to accept
size > MAX_RW_COUNT bytes, we can't predict how long it will take. Thus,
mitigate this problem by using killable wait where possible.

  ----------
  #define _GNU_SOURCE
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>
  #include <unistd.h>

  int main(int argc, char *argv[])
  {
    fork();
    fallocate(open("/dev/nullb0", O_RDWR), 0x11ul, 0ul, 0x7ffffffffffffffful);
    return 0;
  }
  ----------

Link: https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc [1]
Reported-by: syzbot <syzbot+39b75c02b8be0a061bfc@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/fops.c       | 4 +++-
 include/linux/fs.h | 5 +++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 0da147edbd18..a87050db4670 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -622,7 +622,9 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	filemap_invalidate_lock(inode->i_mapping);
+	/* fallocate() might take minutes with lock held. */
+	if (filemap_invalidate_lock_killable(inode->i_mapping))
+		return -EINTR;
 
 	/* Invalidate the page cache, including dirty pages. */
 	error = truncate_bdev_range(bdev, file->f_mode, start, end);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..27b3d36bb73c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -828,6 +828,11 @@ static inline void filemap_invalidate_lock(struct address_space *mapping)
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


