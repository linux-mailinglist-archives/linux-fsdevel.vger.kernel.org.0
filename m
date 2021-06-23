Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2EA3B1853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFWLCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:02:12 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37432 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhFWLCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:11 -0400
Received: by mail-wm1-f46.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso3712395wmg.2;
        Wed, 23 Jun 2021 03:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJGFJi2SWlwPX3gSxotAaJdmgPvABu9igSaT3WLpCGg=;
        b=XXnX7uVTNeUCm7fU8JJk5RB8k/eRheauKRIs6JDVvrKFJj94CYVdtIa7BdVnIhGGt5
         sHH3hNHwhhpSClRi6dadag5YNqpRajKIenHCFYnfXP9QDIG+Vbc6z0aKOxiDecCgiLuo
         MkNKH1h/hygZCT5bO2IBLfve2yJs84Jjn8aJUM0db4b1ZaDmKd+UtaOWIx2wePVIjpqN
         Ap2rFKd1LJ73mfFDloLfmH76uAPI2HdQq8+k4JHl6mKvFButLr3un3mEmFDy35FnIxgv
         wSTFkZXEtSTjfWmA96eQCpMVZQ5cTdL0mJ0iZFWaPEsT2iAmcxCKuCLealGsLrMgdoiK
         Af+w==
X-Gm-Message-State: AOAM531HTlNwT5BGyKwep3PrIBK8/kLgkDOaR7vcPGlDAFfTFq0frAPU
        xQOTY5eb7DButFW7DcKJskNI+89rVyP8+A==
X-Google-Smtp-Source: ABdhPJxXAM0wmpLWavin8GYnUa25ByXouTBeczdOFAg+LMqLZ4X874wCN+/F6t9F5NrOmR3x8FaKXQ==
X-Received: by 2002:a1c:de8a:: with SMTP id v132mr9834645wmg.27.1624445992655;
        Wed, 23 Jun 2021 03:59:52 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:52 -0700 (PDT)
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
Subject: [PATCH v3 3/6] block: refactor sysfs code
Date:   Wed, 23 Jun 2021 12:58:55 +0200
Message-Id: <20210623105858.6978-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
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
index c96b667136ee..610dd86fd4b6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -39,6 +39,7 @@ static void disk_alloc_events(struct gendisk *disk);
 static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
+static void disk_add_sysfs(struct gendisk *disk);
 
 void set_capacity(struct gendisk *disk, sector_t sectors)
 {
@@ -560,6 +561,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
 
+	disk_add_sysfs(disk);
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
@@ -1754,7 +1756,7 @@ static const DEVICE_ATTR(events_poll_msecs, 0644,
 			 disk_events_poll_msecs_show,
 			 disk_events_poll_msecs_store);
 
-static const struct attribute *disk_events_attrs[] = {
+static const struct attribute *disk_sysfs_attrs[] = {
 	&dev_attr_events.attr,
 	&dev_attr_events_async.attr,
 	&dev_attr_events_poll_msecs.attr,
@@ -1825,13 +1827,16 @@ static void disk_alloc_events(struct gendisk *disk)
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
 
@@ -1856,7 +1861,7 @@ static void disk_del_events(struct gendisk *disk)
 		mutex_unlock(&disk_events_mutex);
 	}
 
-	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
+	sysfs_remove_files(&disk_to_dev(disk)->kobj, disk_sysfs_attrs);
 }
 
 static void disk_release_events(struct gendisk *disk)
-- 
2.31.1

