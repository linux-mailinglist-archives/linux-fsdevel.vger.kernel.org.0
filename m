Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937B73C3E93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhGKR5S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:57:18 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38884 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhGKR5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:57:18 -0400
Received: by mail-wm1-f53.google.com with SMTP id b14-20020a1c1b0e0000b02901fc3a62af78so12639574wmb.3;
        Sun, 11 Jul 2021 10:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hK6m5fikCZZqcvmB9+AW5KVodpRIIZM8z9614k3UHyw=;
        b=tnbHgOArfIDZO/8NffgJNsRzTHTnncnIsZg4D+eYTN4YdnQER8RMl2MxWnq/SMFj+0
         12ZepwC1281ESsWFmHfmbiyvgxe/05juB+0Crl86YYnrOMnRYgUs2v/oQAIcX2s5Doz+
         eppL5p1BlMNq1PAUJSy0VZqtK91+2tYxu20DI35Cq0WAwu8kZC1LO61/AQv2mPPfKRvq
         cFVgVNliIkzgjgHO5LCRZrHw9aF/6Go9QKh/V45AT6P7Lwy3GCg0ShZ2o1GY3EdCy4Z1
         t8nz65YvNbN7TWpxK6sD3y4GUbOdPnm1+ko0qvZA0pvnK9nG3/+RRbaZ+5jDy4d2mgph
         j7tw==
X-Gm-Message-State: AOAM533TZ4n+KmrN8ojmFR4D32RBgBRalxwvtXlbQPqHt4hXwtyIKHjH
        V+fWTRixrws5R7F1mE+Od6Q5JdndI6I/dg==
X-Google-Smtp-Source: ABdhPJzp9p+xzR3qUd9Vw7TfBthN4/7XS5z4hsU0A4wdbkDImGWvhcSS/yJIb9hI0ehf/t+/e1E5mA==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr10181293wmo.91.1626026069955;
        Sun, 11 Jul 2021 10:54:29 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-44-206-93.cust.vodafonedsl.it. [2.44.206.93])
        by smtp.gmail.com with ESMTPSA id f5sm12741376wrg.67.2021.07.11.10.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:54:29 -0700 (PDT)
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
Subject: [PATCH v4 1/5] block: add disk sequence number
Date:   Sun, 11 Jul 2021 19:54:11 +0200
Message-Id: <20210711175415.80173-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711175415.80173-1-mcroce@linux.microsoft.com>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Associating uevents with block devices in userspace is difficult and racy:
the uevent netlink socket is lossy, and on slow and overloaded systems
has a very high latency.
Block devices do not have exclusive owners in userspace, any process can
set one up (e.g. loop devices). Moreover, device names can be reused
(e.g. loop0 can be reused again and again). A userspace process setting
up a block device and watching for its events cannot thus reliably tell
whether an event relates to the device it just set up or another earlier
instance with the same name.

Being able to set a UUID on a loop device would solve the race conditions.
But it does not allow to derive orderings from uevents: if you see a
uevent with a UUID that does not match the device you are waiting for,
you cannot tell whether it's because the right uevent has not arrived yet,
or it was already sent and you missed it. So you cannot tell whether you
should wait for it or not.

Associating a unique, monotonically increasing sequential number to the
lifetime of each block device, which can be retrieved with an ioctl
immediately upon setting it up, allows to solve the race conditions with
uevents, and also allows userspace processes to know whether they should
wait for the uevent they need or if it was dropped and thus they should
move on.

Additionally, increment the disk sequence number when the media change,
i.e. on DISK_EVENT_MEDIA_CHANGE event.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/disk-events.c   |  3 +++
 block/genhd.c         | 25 +++++++++++++++++++++++++
 include/linux/genhd.h |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/block/disk-events.c b/block/disk-events.c
index a75931ff5da4..04c52f3992ed 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -190,6 +190,9 @@ static void disk_check_events(struct disk_events *ev,
 
 	spin_unlock_irq(&ev->lock);
 
+	if (events & DISK_EVENT_MEDIA_CHANGE)
+		inc_diskseq(disk);
+
 	/*
 	 * Tell userland about new events.  Only the events listed in
 	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..b7fca2102aa3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -29,6 +29,23 @@
 
 static struct kobject *block_depr;
 
+/*
+ * Unique, monotonically increasing sequential number associated with block
+ * devices instances (i.e. incremented each time a device is attached).
+ * Associating uevents with block devices in userspace is difficult and racy:
+ * the uevent netlink socket is lossy, and on slow and overloaded systems has
+ * a very high latency.
+ * Block devices do not have exclusive owners in userspace, any process can set
+ * one up (e.g. loop devices). Moreover, device names can be reused (e.g. loop0
+ * can be reused again and again).
+ * A userspace process setting up a block device and watching for its events
+ * cannot thus reliably tell whether an event relates to the device it just set
+ * up or another earlier instance with the same name.
+ * This sequential number allows userspace processes to solve this problem, and
+ * uniquely associate an uevent to the lifetime to a device.
+ */
+static atomic64_t diskseq;
+
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
 static DEFINE_IDA(ext_devt_ida);
@@ -1263,6 +1280,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
+	inc_diskseq(disk);
+
 	return disk;
 
 out_destroy_part_tbl:
@@ -1363,3 +1382,9 @@ int bdev_read_only(struct block_device *bdev)
 	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
 }
 EXPORT_SYMBOL(bdev_read_only);
+
+void inc_diskseq(struct gendisk *disk)
+{
+	disk->diskseq = atomic64_inc_return(&diskseq);
+}
+EXPORT_SYMBOL_GPL(inc_diskseq);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13b34177cc85..140c028845af 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -172,6 +172,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u64 diskseq;
 };
 
 /*
@@ -332,6 +333,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 #endif /* CONFIG_SYSFS */
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
+void inc_diskseq(struct gendisk *disk);
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
 #ifdef CONFIG_BLOCK
-- 
2.31.1

