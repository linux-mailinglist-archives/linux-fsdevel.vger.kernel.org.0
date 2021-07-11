Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EA93C3E9D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbhGKR50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:57:26 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:40935 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbhGKR5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:57:23 -0400
Received: by mail-wr1-f53.google.com with SMTP id l7so20477192wrv.7;
        Sun, 11 Jul 2021 10:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrlTFAH0C/xNxlpM9mhI5GLrVPci93g3pcmgXyE6rhA=;
        b=IhAj/uiceL7IjhThDpNcjjok1BjsAnLCBlcsQNk8wQJAI+K803iaj0VavzlErhpzYt
         1/wc3aN8+l7NEIhU10AtnIleBhZqLQKzxVcliX6u0/61M26tt3Qx747BGaAtWe2fgvG0
         e1iDyhyPoNZ/Er7JoTmy68RN9NBlrEjRg4gRu/VZ7T5AgoO6FvkHmNMtMaljmI4LWOHq
         k9bVdjd6o3yzYiVuj9MUZMhBfJbv6Ez2M1N25q4/dnrJDsGLOVsHlBUt761/aCdA1krE
         BwOdthc5qXwwa7woSZsx7YxCt5Mq5OyAm677OvSSzHr70WagsGIkoYmHD1W3VIm7BR+V
         z2HA==
X-Gm-Message-State: AOAM533959vgitkPveAHfEYY0J0CsqdV4hL42VedBgsyqKm0o05+//mc
        S47tZzLEEcHnwBXTwHoqP6/NZdPsxACOiQ==
X-Google-Smtp-Source: ABdhPJzpzdgg3Oi8ZDxu/OTKyc8emWdMxyy9xx6RBDkRTAvhgz6Eii5wizYWGalgcpcS/xAULUbNAw==
X-Received: by 2002:adf:d088:: with SMTP id y8mr6370887wrh.69.1626026074435;
        Sun, 11 Jul 2021 10:54:34 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-44-206-93.cust.vodafonedsl.it. [2.44.206.93])
        by smtp.gmail.com with ESMTPSA id f5sm12741376wrg.67.2021.07.11.10.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:54:34 -0700 (PDT)
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
Subject: [PATCH v4 5/5] loop: raise media_change event
Date:   Sun, 11 Jul 2021 19:54:15 +0200
Message-Id: <20210711175415.80173-6-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711175415.80173-1-mcroce@linux.microsoft.com>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Make the loop device raise a DISK_MEDIA_CHANGE event on attach or detach.

	# udevadm monitor -up |grep -e DISK_MEDIA_CHANGE -e DEVNAME &

	# losetup -f zero
	[    7.454235] loop0: detected capacity change from 0 to 16384
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop0
	DEVNAME=/dev/loop0
	DEVNAME=/dev/loop0

	# losetup -f zero
	[   10.205245] loop1: detected capacity change from 0 to 16384
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop1
	DEVNAME=/dev/loop1
	DEVNAME=/dev/loop1

	# losetup -f zero2
	[   13.532368] loop2: detected capacity change from 0 to 40960
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop2
	DEVNAME=/dev/loop2

	# losetup -D
	DEVNAME=/dev/loop1
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop1
	DEVNAME=/dev/loop2
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop2
	DEVNAME=/dev/loop0
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop0

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/block/loop.c | 20 ++++++++++++++++++++
 drivers/block/loop.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f37b9e3d833c..c632f9bd33ba 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -731,6 +731,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
+	lo->changed = true;
+	bdev_check_media_change(bdev);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
@@ -1205,6 +1207,9 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		goto out_unlock;
 	}
 
+	lo->changed = true;
+	bdev_check_media_change(bdev);
+
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
@@ -1349,6 +1354,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
+	lo->changed = true;
+	bdev_check_media_change(bdev);
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
@@ -2016,11 +2023,22 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static unsigned int lo_check_events(struct gendisk *disk, unsigned int clearing)
+{
+	struct loop_device *lo = disk->private_data;
+	bool changed = lo->changed;
+
+	lo->changed = false;
+
+	return changed ? DISK_EVENT_MEDIA_CHANGE : 0;
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
 	.release =	lo_release,
 	.ioctl =	lo_ioctl,
+	.check_events = lo_check_events,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
 #endif
@@ -2325,6 +2343,8 @@ static int loop_add(int i)
 	disk->fops		= &lo_fops;
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
+	disk->events		= DISK_EVENT_MEDIA_CHANGE;
+	disk->event_flags	= DISK_EVENT_FLAG_UEVENT;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
 	mutex_unlock(&loop_ctl_mutex);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 1988899db63a..a2fdfd27e6a7 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -63,6 +63,7 @@ struct loop_device {
 	struct timer_list       timer;
 	bool			use_dio;
 	bool			sysfs_inited;
+	bool 			changed;
 
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
-- 
2.31.1

