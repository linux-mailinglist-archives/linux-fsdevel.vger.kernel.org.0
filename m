Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009C033C759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 21:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhCOUDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 16:03:39 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:39838 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhCOUDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:03:22 -0400
Received: by mail-ed1-f43.google.com with SMTP id bf3so18797394edb.6;
        Mon, 15 Mar 2021 13:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PkEBTQQrAWt7QcNipJG5buCi2jRQQ6g6Fca4O51wY5Q=;
        b=fG3Vy5Siod/fTIZnl1KkrxS7Y/WkH2sixbBJprMjoT7CRCZNGq49awjcPx/i/x48KZ
         +4IwUGYM797ClgX0sB2ypracyR79R9w8vRf4P/7PVoInYlplTf4wemNtSr9ohBew33KW
         sPJrSNyfj/zS66rkT39V9PvraBHDlns8ZVtF8cGOPnvvthcMh5bj7sJ9XNqaUnEJZmTD
         BvUfZ0icTBE5Nvhb2wXYzVRqk3q5wpSBJMD/oOMeRarFKOUEyODfGDo29g+nU/yXk0hw
         05njmdnNfZK6w5mucmOyuere3xBxxGunNOucS02t/mOyX0FglQCkRafBdDb/n2SHbd+R
         YnHg==
X-Gm-Message-State: AOAM532/oWlnmmcokHx3D/cOOjgXI0Ep9WlxbXxBlNrnV3iXPGb7vXas
        qhQp3MPAjPISArAVYO6SMe3wbNPKS1uVjA==
X-Google-Smtp-Source: ABdhPJyNiNaYH6YrJrOURMkyP3WP5we/k2e2MFDLCnGL67kn/AFEzJYHBMztDjoMSyYxT/KPdK92Rw==
X-Received: by 2002:a05:6402:12cf:: with SMTP id k15mr31093245edx.192.1615838601126;
        Mon, 15 Mar 2021 13:03:21 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-188-216-41-250.cust.vodafonedsl.it. [188.216.41.250])
        by smtp.gmail.com with ESMTPSA id x21sm8551210eds.53.2021.03.15.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:03:20 -0700 (PDT)
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
Subject: [PATCH -next 2/5] block: add ioctl to read the disk sequence number
Date:   Mon, 15 Mar 2021 21:02:39 +0100
Message-Id: <20210315200242.67355-3-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315200242.67355-1-mcroce@linux.microsoft.com>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
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
index ff241e663c01..266315d00942 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -467,6 +467,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
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
2.30.2

