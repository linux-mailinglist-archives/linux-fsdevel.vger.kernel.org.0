Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464D73C66B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhGLXKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:10:32 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39901 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbhGLXKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:10:32 -0400
Received: by mail-ed1-f44.google.com with SMTP id v1so30439901edt.6;
        Mon, 12 Jul 2021 16:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWKRBp3AChwDUw/Y1iiOPEb3yfZHMHAFp5fo3Bbvlxw=;
        b=uiFLVBKVC6AuAiVljPf3WoK2Oe5OJ54g0h8o4kkbfPy76BfDjqxR2k/rUAO8HtDvLu
         tcqLhr54Tzo09y7uSQkdgO9Kt++0O/ut34Ts6YM228k8I1KobbPJmq9ASIph+WncrzJZ
         B9OCJ2/BbfC0NUznx5wuslZD9jTVqlr4TWPBFxYDNalT1B27p+B5mmE7+YXjfc8i99iD
         /IFn8pNxM4LbnHWtJC/D7fnkbD6Ne+iSNUr2zMyDgnznM5CNKyrbK6DBMKdWXNd1eUNr
         +d6Jb4xVwTBuLk1o0LCvhXno91KEFrMcrSq1hu6sLpnsCZ8P4lewJSVC4W1Y7MkvM4vL
         Fo2Q==
X-Gm-Message-State: AOAM5326ivdwZ8najb67YZdclfupOU5eCLv9WFpjJ9HfnPSfJ5LXDpfF
        XFcmRqX0ZiUhvW4H57HppdqfzNILv3c3PQ==
X-Google-Smtp-Source: ABdhPJymSzPj+Az1K63HfDN4fcrNSw5JyvoykWC+eG/BdMBuhVKvQumZLxfBdQqx0D3ct1cde4ePpA==
X-Received: by 2002:a05:6402:2044:: with SMTP id bc4mr1568620edb.307.1626131260968;
        Mon, 12 Jul 2021 16:07:40 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id h3sm5494111ejf.53.2021.07.12.16.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:07:40 -0700 (PDT)
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
Subject: [PATCH v5 2/6] block: export the diskseq in uevents
Date:   Tue, 13 Jul 2021 01:05:26 +0200
Message-Id: <20210712230530.29323-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Export the newly introduced diskseq in uevents:

    $ udevadm info /sys/class/block/* |grep -e DEVNAME -e DISKSEQ
    E: DEVNAME=/dev/loop0
    E: DISKSEQ=1
    E: DEVNAME=/dev/loop1
    E: DISKSEQ=2
    E: DEVNAME=/dev/loop2
    E: DISKSEQ=3
    E: DEVNAME=/dev/loop3
    E: DISKSEQ=4
    E: DEVNAME=/dev/loop4
    E: DISKSEQ=5
    E: DEVNAME=/dev/loop5
    E: DISKSEQ=6
    E: DEVNAME=/dev/loop6
    E: DISKSEQ=7
    E: DEVNAME=/dev/loop7
    E: DISKSEQ=8
    E: DEVNAME=/dev/nvme0n1
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p1
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p2
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p3
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p4
    E: DISKSEQ=9
    E: DEVNAME=/dev/nvme0n1p5
    E: DISKSEQ=9
    E: DEVNAME=/dev/sda
    E: DISKSEQ=10
    E: DEVNAME=/dev/sda1
    E: DISKSEQ=10
    E: DEVNAME=/dev/sda2
    E: DISKSEQ=10

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 0be32dbe97bb..3126f8afe3b8 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1101,8 +1101,17 @@ static void disk_release(struct device *dev)
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
-- 
2.31.1

