Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D78538B0B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhETOBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:15 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:39595 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbhETN7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:59:53 -0400
Received: by mail-ed1-f52.google.com with SMTP id h16so19511966edr.6;
        Thu, 20 May 2021 06:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwhc0ld/Y5lpNE82ePg9vTLlPV/oOdevCYAnWYhtGwQ=;
        b=Hy0V/eZUwh43I65xoHtHhlU6twPrWIeMd77EmANNOqmkhUwbkcosjt0rSACZQQiDZJ
         LPqFKLHSkGt2NSH6EHfPQBEORJP26p9dhe7N3qhagW6roFGfY7bigGD0kuTj7S29kfWy
         xZ+hft38x6K8YWYU3Q2+lYTEszpd+CUtUnpKX/JZ+iaTZVNrrMeAF6RChnAmy4kH6nlK
         BA4AfgVYVXxiMLfhWctGM5RP+N5fQSSauYjTtDscLVxXDNKjmRQWYzC1bLeTvraBKmE/
         phmBhnq2GwrXOikKksKavK64bAw4tosb95J17AwARyNOfTknCUv+SFF+VbCLxlj9cqaa
         BKog==
X-Gm-Message-State: AOAM531ftPhH7a2sbo8xP4BLdT9sXHsBqSYgEwwJkUIraeKMyDAZFiSm
        RNQEcuCbhiEqFTwe+Pg8bQ2A17reW8wYF2yh
X-Google-Smtp-Source: ABdhPJwRU5hToocffR1A+90qphzYej+eT6IPLmmzZgUUSwC7IqHZQ/d9AO9knzv2r7BI3mAx80kJZA==
X-Received: by 2002:a50:9e63:: with SMTP id z90mr5201754ede.342.1621519109374;
        Thu, 20 May 2021 06:58:29 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:58:28 -0700 (PDT)
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
Subject: [PATCH v2 3/6] block: refactor sysfs code
Date:   Thu, 20 May 2021 15:56:19 +0200
Message-Id: <20210520135622.44625-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Move the sysfs register code from a function named disk_add_events() to
a new function named disk_add_sysfs(). Also, rename the attribute list
with a more generic name than disk_events_attrs.

This is a prerequisite patch to export diskseq in sysfs later.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2c7e148fa944..417dd5666be5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -41,6 +41,7 @@ static void disk_alloc_events(struct gendisk *disk);
 static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
+static void disk_add_sysfs(struct gendisk *disk);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
@@ -562,6 +563,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
 
+	disk_add_sysfs(disk);
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
@@ -1763,7 +1765,7 @@ static const DEVICE_ATTR(events_poll_msecs, 0644,
 			 disk_events_poll_msecs_show,
 			 disk_events_poll_msecs_store);
 
-static const struct attribute *disk_events_attrs[] = {
+static const struct attribute *disk_sysfs_attrs[] = {
 	&dev_attr_events.attr,
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
@@ -1834,13 +1836,16 @@ static void disk_alloc_events(struct gendisk *disk)
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
 
@@ -1865,7 +1870,7 @@ static void disk_del_events(struct gendisk *disk)
 		mutex_unlock(&disk_events_mutex);
 	}
 
-	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs);
 }
 
 static void disk_release_events(struct gendisk *disk)
-- 
2.31.1

