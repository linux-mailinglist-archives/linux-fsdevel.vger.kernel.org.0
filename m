Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0437E33C75A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbhCOUDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:03:38 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:33712 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbhCOUDM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:03:12 -0400
Received: by mail-ej1-f46.google.com with SMTP id jt13so68452059ejb.0;
        Mon, 15 Mar 2021 13:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8g9BTEw5cXK8BEbWg9s2vlc3/G9KI2ob9t2ObMjWarw=;
        b=Fz8FFQxzAL9tX20K/L5eeJ5E1wD2HC/d/FB8OnbgEeg7CgaWcjQqPgX35YxZuM9MzX
         8Nhrivk0iD+CEr47tpwIHC9mrsRnbIIx3B3Mi0ieAd9KvOvjt+5Km7rmsBM/bV1d4PuI
         5vgIx3AoUAhQNw0nmk/wYHgg4eBVYsRfuuplBBmWQrmPLVIKQPKt9nB/niSaR46L17ui
         2dXFCiI2eFK++Lkewcn/Ys5vTr53YjFxJT2fh4jBLuMA+Qk0KELwTdmd5G980BacJD9j
         oIIDkRH59eomFDOsd+yFZthVPJlAu4oha1ArGUHypoHSmEEgYb2WcqT1EZorc5fFV8Fs
         /SfA==
X-Gm-Message-State: AOAM532P+yPmA/yfC59YQlaGqMYABZZhUOeVTMZvi9iwz5RzwYdiIg16
        0vvdpM9ALxYD8mVM99pPjrzL+fEZBlPflA==
X-Google-Smtp-Source: ABdhPJxlFVm09S5cvJx2HpIRxw1HVJAgESec3ReO0bsgBmooLvC4DyVbOu+jaLxI+QSFDfvllh5hcQ==
X-Received: by 2002:a17:907:9e6:: with SMTP id ce6mr25172779ejc.207.1615838590529;
        Mon, 15 Mar 2021 13:03:10 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-188-216-41-250.cust.vodafonedsl.it. [188.216.41.250])
        by smtp.gmail.com with ESMTPSA id x21sm8551210eds.53.2021.03.15.13.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:03:09 -0700 (PDT)
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
Subject: [PATCH -next 1/5] block: add disk sequence number
Date:   Mon, 15 Mar 2021 21:02:38 +0100
Message-Id: <20210315200242.67355-2-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315200242.67355-1-mcroce@linux.microsoft.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
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
index 8c8f543572e6..92debcb9e061 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1215,8 +1215,17 @@ static void disk_release(struct device *dev)
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
@@ -1388,6 +1397,8 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->class = &block_class;
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
+	inc_diskseq(disk);
+
 	return disk;
 
 out_destroy_part_tbl:
@@ -1938,3 +1949,11 @@ static void disk_release_events(struct gendisk *disk)
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
index f364619092cc..632141b360d2 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -167,6 +167,7 @@ struct gendisk {
 	int node_id;
 	struct badblocks *bb;
 	struct lockdep_map lockdep_map;
+	u64 diskseq;
 };
 
 /*
@@ -326,6 +327,7 @@ static inline void bd_unlink_disk_holder(struct block_device *bdev,
 #endif /* CONFIG_SYSFS */
 
 extern struct rw_semaphore bdev_lookup_sem;
+extern void inc_diskseq(struct gendisk *disk);
 
 dev_t blk_lookup_devt(const char *name, int partno);
 void blk_request_module(dev_t devt);
-- 
2.30.2

