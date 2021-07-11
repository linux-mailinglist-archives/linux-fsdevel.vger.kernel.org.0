Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC173C3E96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhGKR5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:57:21 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35544 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhGKR5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:57:19 -0400
Received: by mail-wr1-f47.google.com with SMTP id m2so10377359wrq.2;
        Sun, 11 Jul 2021 10:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqLmQkmw5RV8BRwKTNiXKE6QNaaS+ZDW9DJd0jKgI/8=;
        b=Y+n9nD0Abm87WAg30DLt+gQsu/1D9h1AGPHIoUC3X29wQ/v2c2mb/9mVM5+bQ8oEze
         Ytr9eYfy9lsURS5X9StI9hItTl0HeNuAJlHG8yfjJmMO2Jx7SFUdxqT4F3FtkisDSK7E
         SYy2NXTH5ElY/mixs9/9ptjW2glruEdazai7qNCImKGX+vJ6Tdj5q5z3avF329xqV6LD
         ho1yBA4yXJAe22Eat2KLRwLkgqDmXTuQQKiNJRTWZ/2bmP3auU3Jpm9VBE1r/oSU0AG0
         f8MxTI9RexisL8bRFkrf0vCZTL5BsFoazLr4UaGtW+zM/vAcbHfAy1te+AyV7b7RD264
         Z/lg==
X-Gm-Message-State: AOAM532IzGOc3Jk2xWw7hjBN3cFV3CUfU3dov+o47ChOl62JzP+jTHsJ
        9DaguMU05PeG97NV8B8MfQ6xux05QHg2gw==
X-Google-Smtp-Source: ABdhPJz48hUDXVTh8Ye9bFrKm39f/BBg+39CT/+6UXvylJvLrq9xFq5FnPDgBaLgg9jFpMV5pJPjNg==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr2984479wrp.211.1626026071287;
        Sun, 11 Jul 2021 10:54:31 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-44-206-93.cust.vodafonedsl.it. [2.44.206.93])
        by smtp.gmail.com with ESMTPSA id f5sm12741376wrg.67.2021.07.11.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:54:30 -0700 (PDT)
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
Subject: [PATCH v4 2/5] block: export the diskseq in uevents
Date:   Sun, 11 Jul 2021 19:54:12 +0200
Message-Id: <20210711175415.80173-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711175415.80173-1-mcroce@linux.microsoft.com>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
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

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/genhd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index b7fca2102aa3..3d9c9d189ff7 100644
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

