Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70B63C66B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbhGLXKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 19:10:34 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:40750 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhGLXKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 19:10:34 -0400
Received: by mail-ej1-f52.google.com with SMTP id o5so37814174ejy.7;
        Mon, 12 Jul 2021 16:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y3koryDaOA6/9bcI8unsx1MLaBEFywHb4rwejNyG6tE=;
        b=odebTodqIjSudgZ0wWn8mRhvv5EVtcwMGyLnxA+BsQFqG8z+uyz+x7KJWGag9AAgpW
         qyZn+WaC9Hwvpb6pR7fCLaH++Q4Vv5mBIogvpVq+ol3DPLaWUajFlj0OgBc+DmlNI2VR
         2eizfAbjAs3J0K+IT7sc3ev9kX5fu26mGHPtbzcrWfe0Sq1063EQWvRCuAWR9uYKL5Mr
         uDo2OX2cpyMuIhNl272O5hIGLmBtHxU6mwV8e3oRwNqsGnfTAnvNg3t0CHXF6kdrnX2g
         OsDNyw+QNbkE5RAcAm11GZinZLs0xLlvRxlGlVodwBwmZiAAVQ464awq053fhfL9pctL
         6y3w==
X-Gm-Message-State: AOAM531JtsunR/NIcqWW7idFutKXHhx/9if4OCfDZ9XOzORhy32N20S7
        DLR71t9jD/LF/rE1AfYbRbgUsmrj40CvGg==
X-Google-Smtp-Source: ABdhPJy4+ONUDQ4nc4RpW8p+lt4JGKTRBN+97WTCckeOjf7aHhhjhSKQulegxLC/YoP1FRZxBqzTEA==
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr1714569ejc.143.1626131262696;
        Mon, 12 Jul 2021 16:07:42 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-95-250-115-52.retail.telecomitalia.it. [95.250.115.52])
        by smtp.gmail.com with ESMTPSA id h3sm5494111ejf.53.2021.07.12.16.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 16:07:42 -0700 (PDT)
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
Subject: [PATCH v5 3/6] block: add ioctl to read the disk sequence number
Date:   Tue, 13 Jul 2021 01:05:27 +0200
Message-Id: <20210712230530.29323-4-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712230530.29323-1-mcroce@linux.microsoft.com>
References: <20210712230530.29323-1-mcroce@linux.microsoft.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

