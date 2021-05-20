Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135FC38B0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbhETOBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:14 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45899 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbhETN7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:59:49 -0400
Received: by mail-ed1-f42.google.com with SMTP id a25so19487724edr.12;
        Thu, 20 May 2021 06:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJu1+YCrkeg1VrMRtE/40B8yQYYhV/BJgPpoTp2RURs=;
        b=GPe9f7qMOcG4F3dWVeOSdEuh7uawc7xSej5EBKHRHdYCVNIYwmT1lpEcGQTCFX9MmN
         B08+pxGLxPNrIPpB/JDTqSsen9SX49qci9LSOXyEsN3N0zXA9aSQb5S0QFk8vSdQOGl9
         zQXS2yur7ubxUKy9YD7NS5p3YMrVDC7clAFb9SSKkHEowXjdMo259zt5A5rus4hQtDbz
         asUu0z8MkX7HWd3SgpAexcUe5FUnNrWdwINwmHxj1/kfWNFlNJ1Y4X2KgRQY6a53xI5o
         o9wfuVSevLjVM2Y45a1TRiTendp1i//WLxKIRlF0dsd+cg1P2N4lO2P4+6Bd++xjZ5kV
         i3fw==
X-Gm-Message-State: AOAM532dNHfuna/LNo4Alz3dRM33meRiEIhH3/NbHqpDFTZp1ku1vFod
        LW6HQ3YL8bajzhIact5EzSeRbGfFED4BIt2Q
X-Google-Smtp-Source: ABdhPJxCY1xOrV4Ti2X0wSEBgusWXm8TrgBIxXsyRpVDxsMVDSdbwW2OmgmC+9XY5LhxS0DX4F7fNA==
X-Received: by 2002:a05:6402:4414:: with SMTP id y20mr5312263eda.41.1621519101911;
        Thu, 20 May 2021 06:58:21 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:58:21 -0700 (PDT)
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
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: [PATCH v2 2/6] block: add ioctl to read the disk sequence number
Date:   Thu, 20 May 2021 15:56:18 +0200
Message-Id: <20210520135622.44625-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
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

