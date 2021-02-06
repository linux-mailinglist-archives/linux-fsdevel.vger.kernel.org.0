Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA2C311912
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhBFCyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:54:19 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:38637 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhBFCk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:59 -0500
Received: by mail-wm1-f45.google.com with SMTP id y187so7445510wmd.3;
        Fri, 05 Feb 2021 18:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crp7AXUnob0dNe1RTlaAdYK5J2RKpyaUTwbxaLZLJdY=;
        b=rOXPkEooWjKH2/AOpnh5HoBndkOLmhLdwC+A0HSRCSFnROvbiHWH8rsiQSvNch/sJa
         xnTRfl9Bir0d2NXkC2Q6rGnuaVAyotbVHBWi1O0k+yuiVSBGcuApZvujUqLbP8fa8zch
         niBkIYDsULdR60RFAQF2/m6YFPbNJim0G2HnZ1wQZkw+scZGfjD+c3RzR06+kBvb9BH5
         H1vp7EOZZR5dbVucQ5mWz1FyAYBP75OlK7YsOYOK5QJ1DIYR3n8n3aoEQ5O01c0iHLwi
         bCuVAA2IqGL1Uoio6YKzHrqRaBPn6ALp1YpKdaLQFb96LcWUzUmQvE8vjCmA1mPLAVAc
         yjKQ==
X-Gm-Message-State: AOAM532RdTH5GGEbfgNfLLbBektSm0C6M9LrC/CAEf5e0+4a+Yltdezi
        oL3sYfhlZxSQAEW3kZrLqZCFRMZX6lQ=
X-Google-Smtp-Source: ABdhPJwGQ66skeYfY9kGR9UXMXYyL5qwHO1V0r5hQL55M80HyRceyEgT9G8HOp22Tc+hIswm6TbPcQ==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr5613002wmc.154.1612570265034;
        Fri, 05 Feb 2021 16:11:05 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id d3sm14566390wrp.79.2021.02.05.16.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:11:04 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/5] block: add disk sequence number
Date:   Sat,  6 Feb 2021 01:08:59 +0100
Message-Id: <20210206000903.215028-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a sequence number to the disk devices. This number is put in the
uevent so userspace can correlate events when a driver reuses a device,
like the loop one.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c         | 19 +++++++++++++++++++
 include/linux/genhd.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9e741a4f351b..4dbf589e1610 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1425,8 +1425,17 @@ static void disk_release(struct device *dev)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
+
+static int block_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	return add_uevent_var(env, "DISKSEQ=%llu", disk->diskseq);
+}
+
 struct class block_class = {
 	.name		= "block",
+	.dev_uevent	= block_uevent,
 };
 
 static char *block_devnode(struct device *dev, umode_t *mode,
@@ -1601,6 +1610,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
+	inc_diskseq(disk);
+
 	return disk;
 
 out_bdput:
@@ -2149,3 +2160,11 @@ static void disk_release_events(struct gendisk *disk)
 	WARN_ON_ONCE(disk->ev && disk->ev->block != 1);
 	kfree(disk->ev);
 }
+
+void inc_diskseq(struct gendisk *disk)
+{
+	static atomic64_t diskseq;
+
+	disk->diskseq = atomic64_inc_return(&diskseq);
+}
+EXPORT_SYMBOL_GPL(inc_diskseq);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 809aaa32d53c..2e5a0b8893db 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -177,6 +177,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u64 diskseq;
 };
 
 /*
@@ -335,6 +336,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 #endif /* CONFIG_SYSFS */
 
 extern struct rw_semaphore bdev_lookup_sem;
+extern void inc_diskseq(struct gendisk *disk);
 
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
-- 
2.29.2

