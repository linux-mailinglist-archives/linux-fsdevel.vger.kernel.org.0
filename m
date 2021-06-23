Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422033B1857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFWLCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:02:18 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35722 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFWLCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:14 -0400
Received: by mail-wr1-f46.google.com with SMTP id m18so2159729wrv.2;
        Wed, 23 Jun 2021 03:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BlKb/nN8ZAtxyPllpUsysxr5X0Gh4ewsJLKk2TVLQgg=;
        b=b4ZiE42tBgTTQbFpdBrnf6c1kLeydm/34NTulrKfTQt7xxAwMoz5E46UwuYb1Brwgh
         0ooto5QMHhPS1Q5d1PXePsJOwqDGjUJUCBji5QcX+NdPsD4A97WsCeTEk9COOPcCL1aB
         kaNw2jF+Kj/5BuZ/zeXoTCsx6D09Mv5JO4RR70thqx2iuHDKU0f0NM2aRQvnSsRbppwO
         EyJREblRGI7Uy5+zpua2/capfAr6LKfHB9A02dFUoTgFfR2zKsu1LbbqG9IbeCSc5o01
         g92OkIumMX8ZWGMlcEm2VHxw9FRnlo9/fBrYyD3eXJ5NvyTjWZCypbikgDMk2E6RCk9k
         s8pg==
X-Gm-Message-State: AOAM5307OtHm6Cm/VSoFBgC33Gd16nObRowUL1SeQxyOYDr48kByc6uy
        KUs4e1aVqSHxkDG0ctLQ9MA6sC/Qv+Rc5Q==
X-Google-Smtp-Source: ABdhPJzXuCLqP7tliLA63JKixyiAA9O5ocuKf/Ly6bU8IGr8jrDuSyCxWJwrjsk1f5pZE6HlP260dw==
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr10905377wrw.240.1624445995119;
        Wed, 23 Jun 2021 03:59:55 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:54 -0700 (PDT)
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
Subject: [PATCH v3 4/6] block: export diskseq in sysfs
Date:   Wed, 23 Jun 2021 12:58:56 +0200
Message-Id: <20210623105858.6978-5-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a new sysfs handle to export the new diskseq value.
Place it in <sysfs>/block/<disk>/diskseq and document it.

    $ grep . /sys/class/block/*/diskseq
    /sys/class/block/loop0/diskseq:13
    /sys/class/block/loop1/diskseq:14
    /sys/class/block/loop2/diskseq:5
    /sys/class/block/loop3/diskseq:6
    /sys/class/block/ram0/diskseq:1
    /sys/class/block/ram1/diskseq:2
    /sys/class/block/vda/diskseq:7

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 Documentation/ABI/testing/sysfs-block | 12 ++++++++++++
 block/genhd.c                         | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/testing/sysfs-block
index e34cdeeeb9d4..a0ed87386639 100644
--- a/Documentation/ABI/testing/sysfs-block
+++ b/Documentation/ABI/testing/sysfs-block
@@ -28,6 +28,18 @@ Description:
 		For more details refer Documentation/admin-guide/iostats.rst
 
 
+What:		/sys/block/<disk>/diskseq
+Date:		February 2021
+Contact:	Matteo Croce <mcroce@microsoft.com>
+Description:
+		The /sys/block/<disk>/diskseq files reports the disk
+		sequence number, which is a monotonically increasing
+		number assigned to every drive.
+		Some devices, like the loop device, refresh such number
+		every time the backing file is changed.
+		The value type is 64 bit unsigned.
+
+
 What:		/sys/block/<disk>/<part>/stat
 Date:		February 2008
 Contact:	Jerome Marchand <jmarchan@redhat.com>
diff --git a/block/genhd.c b/block/genhd.c
index 610dd86fd4b6..768d8d5d1eca 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1680,6 +1680,7 @@ static void disk_check_events(struct disk_events *ev,
  * events_async		: list of events which can be detected w/o polling
  *			  (always empty, only for backwards compatibility)
  * events_poll_msecs	: polling interval, 0: disable, -1: system default
+ * diskseq		: disk sequence number, since boot
  */
 static ssize_t __disk_events_show(unsigned int events, char *buf)
 {
@@ -1750,16 +1751,26 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
 	return count;
 }
 
+static ssize_t diskseq_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return sprintf(buf, "%llu\n", disk->diskseq);
+}
+
 static const DEVICE_ATTR(events, 0444, disk_events_show, NULL);
 static const DEVICE_ATTR(events_async, 0444, disk_events_async_show, NULL);
 static const DEVICE_ATTR(events_poll_msecs, 0644,
 			 disk_events_poll_msecs_show,
 			 disk_events_poll_msecs_store);
+static const DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 
 static const struct attribute *disk_sysfs_attrs[] = {
 	&dev_attr_events.attr,
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
+	&dev_attr_diskseq.attr,
 	NULL,
 };
 
-- 
2.31.1

