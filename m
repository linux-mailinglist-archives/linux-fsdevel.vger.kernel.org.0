Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4A43C66BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhGLXKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:10:36 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:47068 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhGLXKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:10:35 -0400
Received: by mail-ej1-f49.google.com with SMTP id c17so37697566ejk.13;
        Mon, 12 Jul 2021 16:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EvP6Fne4aXdnLMlil8UuaLMPcQSUTlS5a68+UjZbj8g=;
        b=R1+Np6xeQIQCyf++wiome/TkCh59O6XyRW9kg+WTgqflJ2grjXSsJfnQ361CDWdFK2
         CMD7XyvKMfq+7no5Czlyhvb3OG9xsTCTKa9eX28LK8YWC9GrbEUioTjiokoS6UeaMGrw
         ye9LMPMTQh+SA/RzH03GEFLoAjeGEZ5jJx4xex8SwcIFcdn+KzsY7Q0CbdXg++oIU1nY
         GNliyvKV/G3hzt2XqaKLmuFsVwdta1eszBs4p9H9fe1hwjAosKgg3OP/DeZ+DiwP5V3b
         QqKCyarYLwDIo3CzpUYC8sBOzwqmrK8ZGc3bn9frEh40m8w8IaRX93akne5kBIMhBpOw
         nGwA==
X-Gm-Message-State: AOAM532xlfp3bmU+waQD1okxYUiVCsN3TZ6Y5Zvz46ehJfifZV3UP7tD
        GC0ST4CsdED/t28qnI2akjK3lVZ2zZvlGA==
X-Google-Smtp-Source: ABdhPJwQx8VJBFr6xyCr8gxRNQuBUZzI8SkiDSzg72KVBGzMjm06uqXR5ehYK7VlhmEFRh8ofZO9ig==
X-Received: by 2002:a17:906:a18b:: with SMTP id s11mr1783529ejy.8.1626131264326;
        Mon, 12 Jul 2021 16:07:44 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id h3sm5494111ejf.53.2021.07.12.16.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:07:43 -0700 (PDT)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
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
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: [PATCH v5 4/6] block: export diskseq in sysfs
Date:   Tue, 13 Jul 2021 01:05:28 +0200
Message-Id: <20210712230530.29323-5-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 Documentation/ABI/testing/sysfs-block | 12 ++++++++++++
 block/genhd.c                         | 10 ++++++++++
 2 files changed, 22 insertions(+)

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
index 3126f8afe3b8..9ac41500caf9 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -985,6 +985,14 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 	return sprintf(buf, "%d\n", queue_discard_alignment(disk->queue));
 }
 
+static ssize_t diskseq_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return sprintf(buf, "%llu\n", disk->diskseq);
+}
+
 static DEVICE_ATTR(range, 0444, disk_range_show, NULL);
 static DEVICE_ATTR(ext_range, 0444, disk_ext_range_show, NULL);
 static DEVICE_ATTR(removable, 0444, disk_removable_show, NULL);
@@ -997,6 +1005,7 @@ static DEVICE_ATTR(capability, 0444, disk_capability_show, NULL);
 static DEVICE_ATTR(stat, 0444, part_stat_show, NULL);
 static DEVICE_ATTR(inflight, 0444, part_inflight_show, NULL);
 static DEVICE_ATTR(badblocks, 0644, disk_badblocks_show, disk_badblocks_store);
+static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
 
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 ssize_t part_fail_show(struct device *dev,
@@ -1042,6 +1051,7 @@ static struct attribute *disk_attrs[] = {
 	&dev_attr_events.attr,
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
+	&dev_attr_diskseq.attr,
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	&dev_attr_fail.attr,
 #endif
-- 
2.31.1

