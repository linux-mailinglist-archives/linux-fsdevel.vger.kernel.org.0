Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AE3119B9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 04:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBFDRC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 22:17:02 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39342 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhBFCzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:55:33 -0500
Received: by mail-wm1-f49.google.com with SMTP id u14so7446042wmq.4;
        Fri, 05 Feb 2021 18:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aCJ5PaXDlTI4AjcUCXBQTCjHD7JcPX94ZBJxHdZFYJs=;
        b=q+EabVDft+zoeSQ23UoeV4vHAXE1pK811ECDaoNlarAnD4VrXeYHR1CPrxjYKVDF+J
         sW+ZD37+Vcecr2nLip5DtmNkLcCb9PYaRvmw2Irj9HXlAngFfuYfj+boBRMCV0+95pEB
         aqrjefR0PcHEqFEiuiOMAFIx6sqY8jptoJVijO7EOJr2Ls2kKB8k2SMWS879C2+jlWZ4
         1ER4QwE5IbmiWdUzBE7Etk/QBPYXTSd576bsm1LD82DpWyqdCxBabeXluhprmleh8M+x
         QjtrpefifQH92WslSISQqkh3Q8QZJ3Rkkz173LY0WlGwH3Wg5jDAhrCgoAxa7ySLL8Dg
         rVSQ==
X-Gm-Message-State: AOAM532bSE+ahezXE2yhxIzC6qRb/1k42w+KnHs3+LLqesqF3bNJ8mTi
        jZJ+iVCzJJjJ0E2FmwUiKi1X6T5IjoA=
X-Google-Smtp-Source: ABdhPJx7aqDZs1uXhcmo/ZfRQRW7gg++4yuzlD1SZ+jzLQ7pwK52YYcGgJWxOjbdbuPtsMr5bMSAow==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr5472818wmq.160.1612570388879;
        Fri, 05 Feb 2021 16:13:08 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id d3sm14566390wrp.79.2021.02.05.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:13:08 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4/5] block: export diskseq in sysfs
Date:   Sat,  6 Feb 2021 01:09:02 +0100
Message-Id: <20210206000903.215028-5-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
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
index a59a35cf452c..1aedd4fab6f3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1975,6 +1975,7 @@ static void disk_check_events(struct disk_events *ev,
  * events_async		: list of events which can be detected w/o polling
  *			  (always empty, only for backwards compatibility)
  * events_poll_msecs	: polling interval, 0: disable, -1: system default
+ * diskseq		: disk sequence number, since boot
  */
 static ssize_t __disk_events_show(unsigned int events, char *buf)
 {
@@ -2045,16 +2046,26 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
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
2.29.2

