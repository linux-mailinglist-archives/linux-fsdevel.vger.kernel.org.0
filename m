Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D833C761
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhCOUDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:03:40 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:33453 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbhCOUDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:03:24 -0400
Received: by mail-ed1-f49.google.com with SMTP id w18so18833519edc.0;
        Mon, 15 Mar 2021 13:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unr0lspPbExoMGaeory8crjBzhS6zdKvWVCk960aOU8=;
        b=tHGuTWArVlnyWL96Q2qsOFW3yVRN6lP8hVWhh82OCtrYJ7KHsbrfwbYXpLHDs+mt8o
         uHN6V4WL0Vs23l1xsBxB3g9pscXIBJhoeqHkYU1KBydaYfg3OrtfHyVm/AsFEW46dwUh
         bGExCzkkcxMndbqOA9zrrCb78p9V+MJDeg/ZiEPSW3EZfBOwxlLlc6GSOXwI9tOZpiv1
         LhYOkyiTsQtf33454f2flWelWsdarlrwjZZEE1iL4iRSBENubaEPiWEnsCkUr+FHZAXd
         I2Znj19xwfq9DbCu8ZGWpqUP350Au/nBo6v56leVhcHBf6AfgJgy9gjxU7fhGb6WeCHx
         gUcg==
X-Gm-Message-State: AOAM5317WgsWDdvQHfHzIu9a4cHDoOb20/F6OmLSDCQ1ux2e5dRoiRTP
        DUib/onmhaD1mU9JquWqwDU0NoYbDc9GaA==
X-Google-Smtp-Source: ABdhPJw0N/kDWEh6kOqJlt94kMa0MzE7BuOPpXhECb38QCm2ntvmtWHsfe7q1B138tAx+Xg1wutazA==
X-Received: by 2002:a05:6402:5189:: with SMTP id q9mr31635414edd.168.1615838602881;
        Mon, 15 Mar 2021 13:03:22 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-188-216-41-250.cust.vodafonedsl.it. [188.216.41.250])
        by smtp.gmail.com with ESMTPSA id x21sm8551210eds.53.2021.03.15.13.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:03:22 -0700 (PDT)
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
Subject: [PATCH -next 3/5] block: refactor sysfs code
Date:   Mon, 15 Mar 2021 21:02:40 +0100
Message-Id: <20210315200242.67355-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315200242.67355-1-mcroce@linux.microsoft.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Move the sysfs register code from a function named disk_add_events() to
a new function named disk_add_sysfs(). Also, rename the attribute list
with a more generic name than disk_events_attrs.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 92debcb9e061..57d92ea7ae05 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -41,6 +41,7 @@ static void disk_alloc_events(struct gendisk *disk);
 static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
+static void disk_add_sysfs(struct gendisk *disk);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
@@ -628,6 +629,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
 
+	disk_add_sysfs(disk);
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
@@ -1838,7 +1840,7 @@ static const DEVICE_ATTR(events_poll_msecs, 0644,
 			 disk_events_poll_msecs_show,
 			 disk_events_poll_msecs_store);
 
-static const struct attribute *disk_events_attrs[] = {
+static const struct attribute *disk_sysfs_attrs[] = {
 	&dev_attr_events.attr,
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
@@ -1909,13 +1911,16 @@ static void disk_alloc_events(struct gendisk *disk)
 	disk->ev = ev;
 }
 
-static void disk_add_events(struct gendisk *disk)
+static void disk_add_sysfs(struct gendisk *disk)
 {
 	/* FIXME: error handling */
-	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
+	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs) < 0)
 		pr_warn("%s: failed to create sysfs files for events\n",
 			disk->disk_name);
+}
 
+static void disk_add_events(struct gendisk *disk)
+{
 	if (!disk->ev)
 		return;
 
@@ -1940,7 +1945,7 @@ static void disk_del_events(struct gendisk *disk)
 		mutex_unlock(&disk_events_mutex);
 	}
 
-	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs);
 }
 
 static void disk_release_events(struct gendisk *disk)
-- 
2.30.2

