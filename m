Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D324A33C764
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhCOUEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:04:09 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:37007 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhCOUDi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:03:38 -0400
Received: by mail-ej1-f50.google.com with SMTP id bm21so68386263ejb.4;
        Mon, 15 Mar 2021 13:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jj0zDPT2eMcpk7VXig4zM0b2an7HEf8fKRrEJVtcizM=;
        b=WLAI2MXGdCgxj+06DmtGszKUbEQg6GWtelcIXogBQrmK8QIYpBrhaQUP+dkez/dVlj
         /R53ldRNPs8Bvjp/EXdCY8g+0Wyk6aiIgb0F9FnnmIM4yiCCADqvrBgTBclhjr3FR4dm
         UFpdsYcFTr6ZZAQHtecAbv6kSqZklg+OwaPNB4KFxzFrx+6bZj5I8FQAbvAPuUEtokYn
         ytiLKJnAULWFc3MPuqqRs1+V3dxF56XeWX6Mc+MD7J7Abiz07ttFL52RmlovigkOqkxj
         p7dIBwgf9ABje8I16lDwapuo/p7K1TEMgNwZUzdlUaiV2qNLhSIb6zqpsdg+0J5ZBWGY
         ccHw==
X-Gm-Message-State: AOAM531vpS/v5t5mB0pNRtiEMbtNIPuP9884E5Bz8dq4xlPoyoWSfbNe
        fepBZfiLHnSLmapa5EGfPGnLBtGgtzeFgA==
X-Google-Smtp-Source: ABdhPJwHuxFC1/fxvXnG/nGf2cgzI69PNuS4CkzYFReqpiQTI2SRbo3Fu5bUBbama8j0gv9TbpUb+A==
X-Received: by 2002:a17:906:8a6e:: with SMTP id hy14mr26063470ejc.356.1615838616004;
        Mon, 15 Mar 2021 13:03:36 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-188-216-41-250.cust.vodafonedsl.it. [188.216.41.250])
        by smtp.gmail.com with ESMTPSA id x21sm8551210eds.53.2021.03.15.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:03:35 -0700 (PDT)
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
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH -next 4/5] block: export diskseq in sysfs
Date:   Mon, 15 Mar 2021 21:02:41 +0100
Message-Id: <20210315200242.67355-5-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315200242.67355-1-mcroce@linux.microsoft.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a new sysfs handle to export the new diskseq value.
Place it in <sysfs>/block/<disk>/diskseq and document it.

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
index 57d92ea7ae05..6a7ed426def0 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1764,6 +1764,7 @@ static void disk_check_events(struct disk_events *ev,
  * events_async		: list of events which can be detected w/o polling
  *			  (always empty, only for backwards compatibility)
  * events_poll_msecs	: polling interval, 0: disable, -1: system default
+ * diskseq		: disk sequence number, since boot
  */
 static ssize_t __disk_events_show(unsigned int events, char *buf)
 {
@@ -1834,16 +1835,26 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
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
2.30.2

