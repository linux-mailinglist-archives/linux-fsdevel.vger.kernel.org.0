Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4C3C66C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhGLXKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:10:39 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:37559 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbhGLXKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:10:38 -0400
Received: by mail-ej1-f41.google.com with SMTP id i20so37789247ejw.4;
        Mon, 12 Jul 2021 16:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDu7kpWtoefW5J8ZIKzJkCaSnNc2E9IfezCix3rW6U0=;
        b=P6QAbFR5ecW3UgzPTh86y657LQzeb4DvEaO+z0iH9BWnvUElPHelfP0aZnMNU6hS0k
         +TpqaQm5tneQZoNXwW2qzk3zcicAnGW8P7GC0lcK2UazEkhGefv79JEQpgOj+kHSiET+
         pqmBacw3ma2+87JxzqS6XQZPhmSmyTRE4e0HOUG0TunQWZzpZQlIvfKzEjDOo8ExePkB
         pkIemog3s9O4cLLJf3nSm+VZVjhU32tMkUWsUhD0js4YCrRK3HE/rRjDcmDzYMK2jDbo
         05MEOS/OWdjFGb6dkSo0w2ck7tQE8Hd6L1QeiJwNp0F1DtZLRunc0bPvAn/tVYX+YXVi
         owuw==
X-Gm-Message-State: AOAM530a7Pn5VQ6yLBa30Iaqx9Ia7ABEM9jTVjv9rZsh9nH0W0nI8oOz
        Ze3UesvBU0KqiP0vnSXOoysdYG2rAr+mBA==
X-Google-Smtp-Source: ABdhPJzuwVlDk6fjItU6Bzwexmhey6CpWcb7GumzRR2SX43H76HUPpDoB99GJj1ZCYhtsLJ27mLTxg==
X-Received: by 2002:a17:907:d89:: with SMTP id go9mr1713628ejc.165.1626131267691;
        Mon, 12 Jul 2021 16:07:47 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id h3sm5494111ejf.53.2021.07.12.16.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:07:47 -0700 (PDT)
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
Subject: [PATCH v5 6/6] loop: raise media_change event
Date:   Tue, 13 Jul 2021 01:05:30 +0200
Message-Id: <20210712230530.29323-7-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Make the loop device raise a DISK_MEDIA_CHANGE event on attach or detach.

	# udevadm monitor -up |grep -e DISK_MEDIA_CHANGE -e DEVNAME &

	# losetup -f zero
	[    7.454235] loop0: detected capacity change from 0 to 16384
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop0
	DEVNAME=/dev/loop0
	DEVNAME=/dev/loop0

	# losetup -f zero
	[   10.205245] loop1: detected capacity change from 0 to 16384
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop1
	DEVNAME=/dev/loop1
	DEVNAME=/dev/loop1

	# losetup -f zero2
	[   13.532368] loop2: detected capacity change from 0 to 40960
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop2
	DEVNAME=/dev/loop2

	# losetup -D
	DEVNAME=/dev/loop1
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop1
	DEVNAME=/dev/loop2
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop2
	DEVNAME=/dev/loop0
	DISK_MEDIA_CHANGE=1
	DEVNAME=/dev/loop0

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f37b9e3d833c..f562609b6d53 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -731,6 +731,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
+	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
@@ -1205,6 +1206,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		goto out_unlock;
 	}
 
+	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
@@ -1349,6 +1351,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
+	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
@@ -2325,6 +2328,8 @@ static int loop_add(int i)
 	disk->fops		= &lo_fops;
 	disk->private_data	= lo;
 	disk->queue		= lo->lo_queue;
+	disk->events		= DISK_EVENT_MEDIA_CHANGE;
+	disk->event_flags	= DISK_EVENT_FLAG_UEVENT;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
 	mutex_unlock(&loop_ctl_mutex);
-- 
2.31.1

