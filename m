Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273BE3B185C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFWLCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 07:02:25 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:36440 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhFWLCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:02:18 -0400
Received: by mail-wm1-f48.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so3711482wms.1;
        Wed, 23 Jun 2021 04:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lIaKl1OxDgMFf5G0f4ixWy1oghSZADo8i4vWnrvSFg8=;
        b=LcRYKQVSvYVc0icirqjWbpg325Cj/8kmUZmIsJP+CqzkwO8z3/m+oYcg2bRUukDw8x
         diFzNSYOF48l886Qy043DaHwzJO3o1jZyBrN//NWbB1Ajyf4H2RHP7SM3giOwP1V8Wmz
         NN8ClGltNHMhITLlxpVqTt/RwkaC6zYn/yVkQ2JO7ne8lB/skTPh9IplWY3lScBBcvsx
         botOvINEKQOT0XTE8u+TFUq6Vj/FkBWDdLZDdvLW0GLMjGd0iIjhsMKEYKE71GN9Bz4b
         YGMN+pnxDbMw6gxqvG+B5QmujDeUSonVbKyRKYgWPuSbtttSAvLJJKcS/L1JH7CkiLMR
         llgA==
X-Gm-Message-State: AOAM531f+ksIBuYB1GBgQwPPTDtB2YAT0Or5tG90cJbFGRsboK074kFm
        r/ZYS8UxTcO6SzOgiRtOcMXRprWaKmC28g==
X-Google-Smtp-Source: ABdhPJxWj9Nb+u4BTe2iujl/CcCTRNgLWbT5Kxb9Px4/vUMPtmzVRpUE28NaJcK84X4U2ey32Y1qzA==
X-Received: by 2002:a7b:c395:: with SMTP id s21mr10296924wmj.164.1624446000174;
        Wed, 23 Jun 2021 04:00:00 -0700 (PDT)
Received: from msft-t490s.. (mob-176-246-29-26.net.vodafone.it. [176.246.29.26])
        by smtp.gmail.com with ESMTPSA id r2sm2659458wrv.39.2021.06.23.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 03:59:59 -0700 (PDT)
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
Subject: [PATCH v3 6/6] loop: increment sequence number
Date:   Wed, 23 Jun 2021 12:58:58 +0200
Message-Id: <20210623105858.6978-7-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210623105858.6978-1-mcroce@linux.microsoft.com>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

On a very loaded system, if there are many events queued up from multiple
attach/detach cycles, it's impossible to match them up with the
LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the position
of our own association in the queue is[1].
Not even an empty uevent queue is a reliable indication that we already
received the uevent we were waiting for, since with multi-partition block
devices each partition's event is queued asynchronously and might be
delivered later.

Increment the disk sequence number when setting or changing the backing
file, so the userspace knows which backing file generated the event:

    # udevadm monitor -kp |grep -e ^DEVNAME -e ^DISKSEQ &
    [1] 263
    # losetup -fP 3part
    [   12.309974] loop0: detected capacity change from 0 to 2048
    DEVNAME=/dev/loop0
    DISKSEQ=8
    [   12.360252]  loop0: p1 p2 p3
    DEVNAME=/dev/loop0
    DISKSEQ=8
    DEVNAME=/dev/loop0p1
    DISKSEQ=8
    DEVNAME=/dev/loop0p2
    DISKSEQ=8
    DEVNAME=/dev/loop0p3
    DISKSEQ=8
    # losetup -D
    DEVNAME=/dev/loop0
    DISKSEQ=9
    DEVNAME=/dev/loop0p1
    DISKSEQ=9
    DEVNAME=/dev/loop0p2
    DISKSEQ=9
    DEVNAME=/dev/loop0p3
    DISKSEQ=9
    # losetup -fP 2part
    [   29.001344] loop0: detected capacity change from 0 to 2048
    DEVNAME=/dev/loop0
    DISKSEQ=10
    [   29.040226]  loop0: p1 p2
    DEVNAME=/dev/loop0
    DISKSEQ=10
    DEVNAME=/dev/loop0p1
    DISKSEQ=10
    DEVNAME=/dev/loop0p2
    DISKSEQ=10

[1] https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 76e12f3482a9..b1c638d23306 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -735,6 +735,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
+	inc_diskseq(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
@@ -1123,6 +1124,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_unlock;
 
+	inc_diskseq(lo->lo_disk);
+
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
@@ -1223,6 +1226,8 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
+	inc_diskseq(lo->lo_disk);
+
 	loop_release_xfer(lo);
 	lo->transfer = NULL;
 	lo->ioctl = NULL;
-- 
2.31.1

