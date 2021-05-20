Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F4738B0B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbhETOBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:17 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:35681 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243534AbhETOAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:00:02 -0400
Received: by mail-ej1-f48.google.com with SMTP id k14so21992470eji.2;
        Thu, 20 May 2021 06:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/6Asmzm9q2pjoZlswx9y5LN/G6/90yiJ/pdetWstA8=;
        b=V2LagRhlLpm95kxga/7nF3xvHwTZg769xIYp5tClrh4EtXQmCwl4e0/A23RFZrA21b
         1eQO1bcgqEkCfFfnImYNE7h4R9DnUANxJ4UF2ExBfGpDfQfFw3DJm3dohdhDb1oVJ9Mf
         qr45QObuEuYQighxPy9/R1UhtTUqdj4DRBKToeEccPjm3YvXkZLjz3s+MTFpa/qsfUE3
         4vhaebF7WPU5SUQobB7cdU/qtSTuVD3cwpkfhXYzA30hQFBYFWpVGj7Eo6/NrHfCiNMe
         rtE6te6twxAAyjMstL1dJLhd+9NmnKnQusLr4ufI1wxG0WaiQZlePYTOVeCr4+jmp0Uo
         WBFA==
X-Gm-Message-State: AOAM532wBHucOjZgePL6ItykRRi1YF6RuCDaO8cJmoR4y84FymT2Z0qS
        66tKncYnN711EAyjP++5HmYuw+vtGaT6ys9R
X-Google-Smtp-Source: ABdhPJzx5F7gA6ZA2KHXr4jS8GvRbkdKkiESzKxrBiX0r/JrBnJWKAmUs+Zmu7yYfnL4SOSpoNF8vQ==
X-Received: by 2002:a17:906:e096:: with SMTP id gh22mr4860444ejb.101.1621519118504;
        Thu, 20 May 2021 06:58:38 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:58:37 -0700 (PDT)
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
Subject: [PATCH v2 4/6] block: export diskseq in sysfs
Date:   Thu, 20 May 2021 15:56:20 +0200
Message-Id: <20210520135622.44625-5-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
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
index 417dd5666be5..67519c034f9f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1689,6 +1689,7 @@ static void disk_check_events(struct disk_events *ev,
  * events_async		: list of events which can be detected w/o polling
  *			  (always empty, only for backwards compatibility)
  * events_poll_msecs	: polling interval, 0: disable, -1: system default
+ * diskseq		: disk sequence number, since boot
  */
 static ssize_t __disk_events_show(unsigned int events, char *buf)
 {
@@ -1759,16 +1760,26 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
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

