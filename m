Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEE591901
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 08:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiHMGNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 02:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiHMGNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 02:13:19 -0400
X-Greylist: delayed 970 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 23:13:17 PDT
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8396174CD8
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Aug 2022 23:13:17 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4M4VCD265QzlTMj;
        Sat, 13 Aug 2022 13:55:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgCn3rovPfdiVMknAQ--.6446S4;
        Sat, 13 Aug 2022 13:57:05 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, hch@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] fs: fix possible inconsistent mount device
Date:   Sat, 13 Aug 2022 14:08:48 +0800
Message-Id: <20220813060848.1457301-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgCn3rovPfdiVMknAQ--.6446S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4fury8Zw4ruF43CF4kWFg_yoW5Xr4UpF
        W8Casakr4xGr43G3ySvFy5Ga4fX34xAay8J348Xr9FyFWqqF1xWFsxtF45uryxCFWrZFyf
        Za18trWIkry7C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

If device support rename, for example dm, following concurrent scenario
is possible:

t1: mount		t2: rename

mount_bdev
 blkdev_get_by_path
  lookup_bdev(path, &dev);
			dm_rename
			// change device name
   blkdev_get_by_dev
...
vfs_create_mount
 alloc_vfsmnt
  // mnt->mnt_devname is set to old name

Test cmd:
dmsetup create test1 --table "0 100000 linear /dev/sda 0"
mkfs.ext2 -F /dev/mapper/test1
mount /dev/mapper/test1 /mnt/test &
dmsetup rename test1 test2

Test result(If the above scenario triggers):
mount will show test1 is mounted:
[root@localhost ~]# mount | grep test
/dev/mapper/test1 on /mnt/test type ext2 (rw,relatime,errors=continue,user_xattr,acl)

while lsblk show test2 is mounted:
[root@localhost ~]# lsblk /dev/sda
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda       8:0    0  100G  0 disk
└─test2 252:0    0 48.8M  0 dm   /mnt/test

Furthermore, if a new device with name test1 is created, lsblk will show
that it's mounted:
[root@localhost ~]# dmsetup create test1 --table "0 100000 linear /dev/sdb 0" && lsblk /dev/sdb
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sdb       8:16   0   10G  0 disk
└─test1 252:1    0 48.8M  0 dm   /mnt/test

Fix the problem by checking dev_name again after bdev if found by
blkdev_get_by_path() in mount_bdev().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
changes in v2: rebase to latest version
 fs/super.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 734ed584a946..c738da299fc1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1341,6 +1341,20 @@ static int test_bdev_super(struct super_block *s, void *data)
 	return !(s->s_iflags & SB_I_RETIRED) && (void *)s->s_bdev == data;
 }
 
+static int check_dev_name(struct block_device *bdev, const char *dev_name)
+{
+	dev_t dev;
+	int error = lookup_bdev(dev_name, &dev);
+
+	if (error)
+		return error;
+
+	if (dev != bdev->bd_dev)
+		return -EBUSY;
+
+	return 0;
+}
+
 struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int))
@@ -1357,6 +1371,15 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
+	/*
+	 * Some drivers support device rename, for example dm, make sure the
+	 * right bdev is found, otherwise inconsistent device and mountpoint
+	 * will be shown in /proc/mounts.
+	 */
+	error = check_dev_name(bdev, dev_name);
+	if (error)
+		goto error_bdev;
+
 	/*
 	 * once the super is inserted into the list by sget, s_umount
 	 * will protect the lockfs code from trying to start a snapshot
-- 
2.31.1

