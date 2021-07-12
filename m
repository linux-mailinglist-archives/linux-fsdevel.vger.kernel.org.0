Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562303C4D42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbhGLHMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243738AbhGLHFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:05:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA9EC014C6A;
        Sun, 11 Jul 2021 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eP4vUSHmDd/tjsFpgsdSEd4RiF7bQpsRGva+93GUr/E=; b=MmuHUA8D5MmRqXEem8+t09vsuO
        GI2iJfYJXGFwJhZnPzCoY8yutenWdM8c6CqQdbFszKWvOUfU0qj1MzqOLsrpQa2QtMs4/hVuiN4hy
        ZmNAq2xO1JqltjJwDQbFGhb1PtfwG04yV7AzGlBjfPE5sQMAmy6fghyx0zTuMQ5DaJgKVtSq/8Zng
        seP7+fRLX1ZRMASyMK1NUpv4w9mg1J+2/MinWvs25svRwHi9b7tkh/OV6fKWxWk/Ml8PF3VhkXZiu
        YKEBBnNqb/t0SV3scZ6ewLGT00b+sxzv5RVsGXnM0E/imlgEndReDM3t945tHmLxvgSoR9bSRHe+c
        BwPxHNLw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2pq0-00H1SV-0u; Mon, 12 Jul 2021 06:55:04 +0000
Date:   Mon, 12 Jul 2021 07:54:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v4 5/5] loop: raise media_change event
Message-ID: <YOvnNE6AVNwEh8uE@infradead.org>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
 <20210711175415.80173-6-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711175415.80173-6-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So when I said plug into the disk events I did not mean that you need
to use all the polling stuff - we can just do the parts required
which are the uevents and invalidation with a new little helper
like this (needs the actual prototype and kerneldoc of course):

diff --git a/block/disk-events.c b/block/disk-events.c
index a75931ff5da4..0023ab1559b6 100644
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
@@ -190,19 +206,8 @@ static void disk_check_events(struct disk_events *ev,
 
 	spin_unlock_irq(&ev->lock);
 
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
@@ -281,6 +286,21 @@ bool bdev_check_media_change(struct block_device *bdev)
 }
 EXPORT_SYMBOL(bdev_check_media_change);
 
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
