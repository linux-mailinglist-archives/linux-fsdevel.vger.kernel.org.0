Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87FE3B184D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 12:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFWLCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:02:06 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:33379 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhFWLCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:05 -0400
Received: by mail-wr1-f50.google.com with SMTP id d11so2200147wrm.0;
        Wed, 23 Jun 2021 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DPuzTQf5i//60Egy7t0JK45QLGYkeuhTcZ4qyrJF2Q=;
        b=QHh6nSjmKLtSs3xhgnYvjIHKfRKDeNjmDys3VQCHHHUc1SdDUF6O1dhaJH2knCAUKF
         +kas3sSPMd3swkfrQJjiA+N6dlPcQtFBux2bXDL23xOg1Q4+37MHT7ENJJ8KLD+lTjx4
         8ZfEdG0blK61M5yZMc6+1XNqmB1jjUeBYlztBiezHN8OXZdH0or5pnVtC8YplCauvowF
         MoTLZdVJqzBH8u2L90XH4sKPjxBUnnsh5wlTQ4OG13dU2HAqCPR30WyYWGTbCRKqeruN
         61BtCe+h9tjy4GgzwwFmmm7pXualj50HSd6EzD2FXzgXshuYExOo3jblT/texcNVmQLD
         ioqw==
X-Gm-Message-State: AOAM533Fy4FBTAUD79PHRaCPGxlZtrziH0AvefSt26iccUcE/gSLNPkd
        cLoBcbW3Rj1eiCKnQtgqTR6XUoZ6ZLEI1Q==
X-Google-Smtp-Source: ABdhPJwPvauXSCj+gS+SHMy12LE2IiuMDMEOc9jf+z6vkeE9bJ0CDWIYXAOMvF1JZ0m4GGYQE0W3yg==
X-Received: by 2002:a05:6000:1245:: with SMTP id j5mr10683561wrx.371.1624445987343;
        Wed, 23 Jun 2021 03:59:47 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:46 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
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
Subject: [PATCH v3 1/6] block: add disk sequence number
Date:   Wed, 23 Jun 2021 12:58:53 +0200
Message-Id: <20210623105858.6978-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
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
index 9f8cb7beaad1..c96b667136ee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1129,8 +1129,17 @@ static void disk_release(struct device *dev)
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
@@ -1304,6 +1313,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
+	inc_diskseq(disk);
+
 	return disk;
 
 out_destroy_part_tbl:
@@ -1854,3 +1865,11 @@ static void disk_release_events(struct gendisk *disk)
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
index 6fc26f7bdf71..a0d04250a2db 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -167,6 +167,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u64 diskseq;
 };
 
 /*
@@ -306,6 +307,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 }
 #endif /* CONFIG_SYSFS */
 
+void inc_diskseq(struct gendisk *disk);
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
-- 
2.31.1

