Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DE63C66BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhGLXKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:10:37 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33614 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhGLXKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:10:36 -0400
Received: by mail-ed1-f47.google.com with SMTP id dj21so10585481edb.0;
        Mon, 12 Jul 2021 16:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML00JtYVZe2p5B4UKUBPuWY2pChVUASw+imUnUQ2KK0=;
        b=EsIY/wXXWxiHnRUDSwGxSYUvW9DtOJphpy/RoiVBplRnCmZg4JPhF23rOO6thkSHQL
         QeDLQWIPJ4swgWj/IYqhyrdW7Dppv7I9i0cgK3stM99EADJoQMwDyfXbH1jyV7+PVBNF
         Ndgqos9ot7iP/VZ19xp0BOLjg2GXA2ZILx+cvHc4tnby2QQuTVj82g+vk1YTzlObnKqG
         NVH/Ob5AMselD50b6+oofuXICXg7SEXak7i7KPrxyPH1gkeeN68XgHzYYvw0dRXswcFE
         QAmVxJ+UboX6kFXOJWnPNWkTOPHWvh4RTW++08mXJ+EesXs2sZtAwUfTr5nYmWABWwjf
         avIA==
X-Gm-Message-State: AOAM5310tUoXdtyl5Rg7HFP3dWrDDdJQxCmPgYQWGEEAhPU1Owqjz+X/
        ASG+Kgo3JNa1QoNZH5YrwRcnPihyudHsZw==
X-Google-Smtp-Source: ABdhPJww3SzAjyJFWMF5nuYDt8E0J6plzstysO66PJdByEdsTKphpgwbCfxRtBfp/K4GEbFnf4yKJw==
X-Received: by 2002:aa7:cd5a:: with SMTP id v26mr1512917edw.287.1626131266117;
        Mon, 12 Jul 2021 16:07:46 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id h3sm5494111ejf.53.2021.07.12.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:07:45 -0700 (PDT)
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
Subject: [PATCH v5 5/6] block: add a helper to raise a media changed event
Date:   Tue, 13 Jul 2021 01:05:29 +0200
Message-Id: <20210712230530.29323-6-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Refactor disk_check_events() and move some code into disk_event_uevent().
Then add disk_force_media_change(), a helper which will be used by
devices to force issuing a DISK_EVENT_MEDIA_CHANGE event.

Co-developed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/disk-events.c   | 61 ++++++++++++++++++++++++++++++++-----------
 include/linux/genhd.h |  1 +
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index 04c52f3992ed..7445b8ff2775 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -163,15 +163,31 @@ void disk_flush_events(struct gendisk *disk, unsigned int mask)
 	spin_unlock_irq(&ev->lock);
 }
 
+/*
+ * Tell userland about new events.  Only the events listed in @disk->events are
+ * reported, and only if DISK_EVENT_FLAG_UEVENT is set.  Otherwise, events are
+ * processed internally but never get reported to userland.
+ */
+static void disk_event_uevent(struct gendisk *disk, unsigned int events)
+{
+	char *envp[ARRAY_SIZE(disk_uevents) + 1] = { };
+	int nr_events = 0, i;
+
+	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
+		if (events & disk->events & (1 << i))
+			envp[nr_events++] = disk_uevents[i];
+
+	if (nr_events)
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+}
+
 static void disk_check_events(struct disk_events *ev,
 			      unsigned int *clearing_ptr)
 {
 	struct gendisk *disk = ev->disk;
-	char *envp[ARRAY_SIZE(disk_uevents) + 1] = { };
 	unsigned int clearing = *clearing_ptr;
 	unsigned int events;
 	unsigned long intv;
-	int nr_events = 0, i;
 
 	/* check events */
 	events = disk->fops->check_events(disk, clearing);
@@ -193,19 +209,8 @@ static void disk_check_events(struct disk_events *ev,
 	if (events & DISK_EVENT_MEDIA_CHANGE)
 		inc_diskseq(disk);
 
-	/*
-	 * Tell userland about new events.  Only the events listed in
-	 * @disk->events are reported, and only if DISK_EVENT_FLAG_UEVENT
-	 * is set. Otherwise, events are processed internally but never
-	 * get reported to userland.
-	 */
-	for (i = 0; i < ARRAY_SIZE(disk_uevents); i++)
-		if ((events & disk->events & (1 << i)) &&
-		    (disk->event_flags & DISK_EVENT_FLAG_UEVENT))
-			envp[nr_events++] = disk_uevents[i];
-
-	if (nr_events)
-		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	if (disk->event_flags & DISK_EVENT_FLAG_UEVENT)
+		disk_event_uevent(disk, events);
 }
 
 /**
@@ -284,6 +289,32 @@ bool bdev_check_media_change(struct block_device *bdev)
 }
 EXPORT_SYMBOL(bdev_check_media_change);
 
+/**
+ * disk_force_media_change - force a media change event
+ * @disk: the disk which will raise the event
+ * @events: the events to raise
+ *
+ * Generate uevents for the disk. If DISK_EVENT_MEDIA_CHANGE is present,
+ * attempt to free all dentries and inodes and invalidates all block
+ * device page cache entries in that case.
+ *
+ * Returns %true if DISK_EVENT_MEDIA_CHANGE was raised, or %false if not.
+ */
+bool disk_force_media_change(struct gendisk *disk, unsigned int events)
+{
+	disk_event_uevent(disk, events);
+
+	if (!(events & DISK_EVENT_MEDIA_CHANGE))
+		return false;
+
+	if (__invalidate_device(disk->part0, true))
+		pr_warn("VFS: busy inodes on changed media %s\n",
+			disk->disk_name);
+	set_bit(GD_NEED_PART_SCAN, &disk->state);
+	return true;
+}
+EXPORT_SYMBOL_GPL(disk_force_media_change);
+
 /*
  * Separate this part out so that a different pointer for clearing_ptr can be
  * passed in for disk_clear_events.
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 140c028845af..849486de81c6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -237,6 +237,7 @@ extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
 bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
+bool disk_force_media_change(struct gendisk *disk, unsigned int events);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-- 
2.31.1

