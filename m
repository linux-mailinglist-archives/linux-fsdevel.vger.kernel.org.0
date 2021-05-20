Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4427E38B0AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhETOBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:12 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:34639 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbhETN6w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:58:52 -0400
Received: by mail-ed1-f46.google.com with SMTP id w12so11764318edx.1;
        Thu, 20 May 2021 06:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQqRHdN+0c7ElbyCTxmJqH+JHoz0aWq7OJLTydC/kzE=;
        b=ovxUwqYrmAx7cjvm+xf0OHZEj04cuEUyxdxdaKiGbQKTFSEyHJfIVvoR7o4RHFYWtA
         lO7IAD7eltUuSQCOsqcGgGG02BxR4U2OLj/7OeHDCv7i0u+gdpz0OTAfxGpa80QrX6FB
         GGhQBAHuKKxqMQPTRBg2c83eY3eD9P+Zlem/5H8mfnsmpOaij3HVHJ+XhCDuilkDI9O7
         XGnxto1+Andv2fOiuBLhVGD4SHJpJH/rvTEKUJ3uYNGvhF2Coxxxr4cwBFiQBGLMuhBh
         rLSYz/fpi0aL+4DAKo2XGyuMmLUh0R7yOrGbM3dOz502M+zlZvCXVOT7ZTnHc8k7SxiY
         +l1g==
X-Gm-Message-State: AOAM531Wr64gdtNSvC8hqcqI3FJXshq4aQpwiw+/kzu3VKLIOMxBSFod
        n4rvuPsbhfAQh4PZVOddDahiczo4APGDFmhH
X-Google-Smtp-Source: ABdhPJzoj6FTTJt9HKupqD4mRwFqIf8csge354GCyewKcizvxvhSZw5Vy+jQjZaUrAz6w4hJu4ICJw==
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr5167523edj.178.1621519050008;
        Thu, 20 May 2021 06:57:30 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:57:29 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 1/6] block: add disk sequence number
Date:   Thu, 20 May 2021 15:56:17 +0200
Message-Id: <20210520135622.44625-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a monotonically increasing number to disk devices. This number is put
in the uevent so userspace can correlate events when a driver reuses a
device, like cdrom or loop.

    $ udevadm info /sys/class/block/* |grep -e DEVNAME -e DISKSEQ
    E: DEVNAME=/dev/loop0
    E: DISKSEQ=1
    E: DEVNAME=/dev/loop1
    E: DISKSEQ=2
    E: DEVNAME=/dev/loop2
    E: DISKSEQ=3
    E: DEVNAME=/dev/loop3
    E: DISKSEQ=4
    E: DEVNAME=/dev/loop4
    E: DISKSEQ=5
    E: DEVNAME=/dev/loop5
    E: DISKSEQ=6
    E: DEVNAME=/dev/loop6
    E: DISKSEQ=7
    E: DEVNAME=/dev/loop7
    E: DISKSEQ=8
    E: DEVNAME=/dev/nvme0n1
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p1
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p2
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p3
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p4
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p5
    E: DISKSEQ=9
    E: DEVNAME=/dev/sda
    E: DISKSEQ=10
    E: DEVNAME=/dev/sda1
    E: DISKSEQ=10
    E: DEVNAME=/dev/sda2
    E: DISKSEQ=10

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c         | 19 +++++++++++++++++++
 include/linux/genhd.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 39ca97b0edc6..2c7e148fa944 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1138,8 +1138,17 @@ static void disk_release(struct device *dev)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
+
+static int block_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return add_uevent_var(env, "DISKSEQ=%llu", disk->diskseq);
+}
+
 struct class block_class = {
 	.name		= "block",
+	.dev_uevent	= block_uevent,
 };
 
 static char *block_devnode(struct device *dev, umode_t *mode,
@@ -1313,6 +1322,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
+	inc_diskseq(disk);
+
 	return disk;
 
 out_destroy_part_tbl:
@@ -1863,3 +1874,11 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+void inc_diskseq(struct gendisk *disk)
+{
+	static atomic64_t diskseq;
+
+	disk->diskseq = atomic64_inc_return(&diskseq);
+}
+EXPORT_SYMBOL_GPL(inc_diskseq);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 7e9660ea967d..ec98b95c8279 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -167,6 +167,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u64 diskseq;
 };
 
 /*
@@ -307,6 +308,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 #endif /* CONFIG_SYSFS */
 
 extern struct rw_semaphore bdev_lookup_sem;
+extern void inc_diskseq(struct gendisk *disk);
 
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
-- 
2.31.1

