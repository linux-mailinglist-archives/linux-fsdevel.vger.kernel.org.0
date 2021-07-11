Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00913C3E9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhGKR5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:57:24 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35552 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhGKR5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:57:21 -0400
Received: by mail-wr1-f51.google.com with SMTP id m2so10377499wrq.2;
        Sun, 11 Jul 2021 10:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gA2NrPBHWqmV7CuYNl2bPQgHZVzrHyeQuRtsWBkE9oQ=;
        b=R+MbgiTDyCaAtZzqq6ooWg4p8nt47nFptADr7DMh+3zB6VD9iw6kT4hfwQKweKmpzg
         NdbQ6feywn93fKkAzg7yzc44gtLlVLhSYd0VJn5zvsHA7HHGA/xtzEnjUWfnQN9xgcgl
         vVcxMILD2HKzJ+0Rh9DTN/RmSg/tzpr3ucbEz99TkVW2G2pPQeemAe6gfGH8yUonDHPx
         da89+53l1nV8X10ZFhD0ksPKDvQLp35AtVlxKKnS4IT6QOYap4ZCxWoOkBFEYHj/23Pf
         2YrZODNmGodgRltuRrRVKLJ7duqmBdrbsCTx37yGRf461u1hQ9X3q+pwJaAe5vMPrpcP
         bmhw==
X-Gm-Message-State: AOAM533f2BsUt5PVtLwiZHqPkNSnF0NJyTK9IW5HEX85zUiWwS3Fua2V
        y+mHQ2g407IKGJSA2xcI8OUVQJDT3zJzgw==
X-Google-Smtp-Source: ABdhPJzpxG3p/CdRYWj//Y0fxcYW2oGVQUeXcWW3ExK7nCw4kngDly6GSOPBE0kSQOgIs61zsBnBAA==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr54877422wru.380.1626026073472;
        Sun, 11 Jul 2021 10:54:33 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-44-206-93.cust.vodafonedsl.it. [2.44.206.93])
        by smtp.gmail.com with ESMTPSA id f5sm12741376wrg.67.2021.07.11.10.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:54:33 -0700 (PDT)
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
Subject: [PATCH v4 4/5] block: export diskseq in sysfs
Date:   Sun, 11 Jul 2021 19:54:14 +0200
Message-Id: <20210711175415.80173-5-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711175415.80173-1-mcroce@linux.microsoft.com>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
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
index 3d9c9d189ff7..422c0dbc6ce2 100644
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

