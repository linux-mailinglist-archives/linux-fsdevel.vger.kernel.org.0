Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51E13B184F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWLCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:02:10 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33385 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhFWLCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:09 -0400
Received: by mail-wr1-f48.google.com with SMTP id d11so2200329wrm.0;
        Wed, 23 Jun 2021 03:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJu1+YCrkeg1VrMRtE/40B8yQYYhV/BJgPpoTp2RURs=;
        b=nFvMg7PVYmtnD+YGQLAR7G7X1h+cBy4317unAM44+D/o81afAofnKztFWqlW3FBNNH
         1HpDpKQ3fsG9jkEnuFy0pqfQt8uLs7xkRvxldHpss2Oa2Svd8XZDHwdVG+NHJFUZYhfQ
         9+kdvhRKaXLGE2WVtl8Qq7xS8cf4aZKe2QSLLvAe1tFquzSg7eYKNPyu6K4WVOKXfkvV
         n+xAVUcNkXapsLMMeeoDXIQ+1avx5YpNauJMRGeDNKx41QfvLIQC91UeRvEGx9vFvskO
         3t27lai2cqac34QrCsPjKdRTpzJkb1mI3eHGxc3zMjvVyI2yxW3JbwUe3x5pdqO/nrJJ
         /e9Q==
X-Gm-Message-State: AOAM532ZrWy78A0s4bjYvRLdRgLMP/6yrUx6PmvW6ePJFJyqEPsTjcFe
        tiHkGEtbBxHRA6h4CO0fL3+M9ZR+dhHaQQ==
X-Google-Smtp-Source: ABdhPJzPlLp3WHs6yTVEK2Y51Df5ofPOSUEgqWhrBhjrpHROc+LqUnoP+63NfjJzIfbcCZFzogB17A==
X-Received: by 2002:a05:6000:144b:: with SMTP id v11mr8805568wrx.421.1624445990205;
        Wed, 23 Jun 2021 03:59:50 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:49 -0700 (PDT)
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
Subject: [PATCH v3 2/6] block: add ioctl to read the disk sequence number
Date:   Wed, 23 Jun 2021 12:58:54 +0200
Message-Id: <20210623105858.6978-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
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
index 8ba1ed8defd0..32b339bbaf95 100644
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

