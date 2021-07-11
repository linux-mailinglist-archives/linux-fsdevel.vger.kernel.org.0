Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290C83C3E97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jul 2021 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhGKR5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 13:57:23 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40931 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhGKR5V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 13:57:21 -0400
Received: by mail-wr1-f52.google.com with SMTP id l7so20477101wrv.7;
        Sun, 11 Jul 2021 10:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/nmB3CtujyxBQuc9imDrnD4qPywR3Zgc9UmKQvyvHxQ=;
        b=Oyfz3Cbeg18RcC00yZdcLiLL0BUx/r6xxBlbJwWmy1FLXKqf60KglmcEV9RRQYR/JD
         1bMsbji1OBqdrCXiLF2jP/Ed94uC8R1Q9dyxxWmn7u4MSGMAH4ekAVBIaJnrRqr66p7a
         nUBBOu13MjEhrsGGEhmkxaWKulawyQf+twra0MGIyVexPMsKaIVeKZ+bDIysreK32fiS
         DwHUwXL/nuONM4qGX1ZXmgmIp6tl/2dhbqtiztTvtlJzPSitao/7U90kFW/BWHTTtnQ2
         och0ZnYOVI4QPqHMp4405vutDSrHV+g7DzGWtuH8t6cI03Q1BKh6Q3A9Zded/x3YCDGl
         Tdfw==
X-Gm-Message-State: AOAM533BM+F0rdpzfEuSUvGuB1UVkmpDum+7tDtqR2DII+10fzC8VizY
        XPdoW85R5QW1OTaDkUNDUD2PgN3QuodpWQ==
X-Google-Smtp-Source: ABdhPJzCUoO4bPhNd2Rk6NWoIkOi6uEhpVU6EGyGk33sd4KpovFjiSpoS+NzsGLmt4mnyKZN+PRFYw==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr21191857wrn.117.1626026072338;
        Sun, 11 Jul 2021 10:54:32 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-2-44-206-93.cust.vodafonedsl.it. [2.44.206.93])
        by smtp.gmail.com with ESMTPSA id f5sm12741376wrg.67.2021.07.11.10.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 10:54:31 -0700 (PDT)
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
Subject: [PATCH v4 3/5] block: add ioctl to read the disk sequence number
Date:   Sun, 11 Jul 2021 19:54:13 +0200
Message-Id: <20210711175415.80173-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210711175415.80173-1-mcroce@linux.microsoft.com>
References: <20210711175415.80173-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a new BLKGETDISKSEQ ioctl which retrieves the disk sequence number
from the genhd structure.

    # ./getdiskseq /dev/loop*
    /dev/loop0:     13
    /dev/loop0p1:   13
    /dev/loop0p2:   13
    /dev/loop0p3:   13
    /dev/loop1:     14
    /dev/loop1p1:   14
    /dev/loop1p2:   14
    /dev/loop2:     5
    /dev/loop3:     6

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/ioctl.c           | 2 ++
 include/uapi/linux/fs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index 24beec9ca9c9..0c3a4a53fa11 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -469,6 +469,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 				BLKDEV_DISCARD_SECURE);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
+	case BLKGETDISKSEQ:
+		return put_u64(argp, bdev->bd_disk->diskseq);
 	case BLKREPORTZONE:
 		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
 	case BLKRESETZONE:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 4c32e97dcdf0..bdf7b404b3e7 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -184,6 +184,7 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKGETDISKSEQ _IOR(0x12,128,__u64)
 /*
  * A jump here: 130-136 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.31.1

