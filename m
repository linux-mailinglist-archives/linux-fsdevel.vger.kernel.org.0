Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320D231196A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 04:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhBFDE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 22:04:59 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:38269 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhBFDBS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:01:18 -0500
Received: by mail-wm1-f50.google.com with SMTP id y187so7471403wmd.3;
        Fri, 05 Feb 2021 19:01:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bexfxdD7y04/NN1BW/2LR9HyyA70oxPcF36yfxCxKpg=;
        b=WtqVklhFNAKxH/D+PWJIM65mryGk/rDijSCe9RK3Gc5XhCTEjZkXXKSdEHyEwSSW9q
         iwaBwv9337oh38Q0XF3sjqQe913FCpjJ6UTYQBEvUNbXvfq9EWuUuUo/B1PE4opyw0uY
         +rzjFbBiybNOBVar7y9V5RdK+F+CMRHTyOJdK5qCN3wad16ZAa38rmMbQ7s2w0lQ3w9f
         8LrBtkof2HDSBAKHYjtA10ZAqps06PlHAO/gevVpXN7QBTTmxO3lE5cUO5TMOnSfYXdV
         GbTwpOEncI3LUS8MMfniKwMhQdK4qR/sSWbiKhewr6e5frD+8XX50FK70dMzvqywAoDq
         fe1g==
X-Gm-Message-State: AOAM533PY1glDbZHsCoi0bIJVasUn4JmsqdDf/1nmVLOLkmkJHvLCdRJ
        qie1M98A+c2duRn5q3GCql+D/ZZzBuA=
X-Google-Smtp-Source: ABdhPJw+KDHxxnP1/yl3ky5khDln+lFM6/pjtRM5lgi82AtvgGV0nU+5ibW4yldcAcq8uOrdqw9EaQ==
X-Received: by 2002:a1c:acc9:: with SMTP id v192mr5436823wme.22.1612570320604;
        Fri, 05 Feb 2021 16:12:00 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id d3sm14566390wrp.79.2021.02.05.16.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:12:00 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 2/5] block: add ioctl to read the disk sequence number
Date:   Sat,  6 Feb 2021 01:09:00 +0100
Message-Id: <20210206000903.215028-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

Add a new BLKGETDISKSEQ ioctl which retrieves the disk sequence number
from the genhd structure.

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 block/ioctl.c           | 2 ++
 include/uapi/linux/fs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index d61d652078f4..037fec888098 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -460,6 +460,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 				BLKDEV_DISCARD_SECURE);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
+	case BLKGETDISKSEQ:
+		return put_u64(argp, bdev->bd_disk->diskseq);
 	case BLKREPORTZONE:
 		return blkdev_report_zones_ioctl(bdev, mode, cmd, arg);
 	case BLKRESETZONE:
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..5dc72bbdd9b7 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -184,6 +184,7 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKGETDISKSEQ _IOR(0x12,128,__u64)
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
-- 
2.29.2

