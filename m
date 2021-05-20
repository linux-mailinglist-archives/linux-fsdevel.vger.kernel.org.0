Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6B838B0CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbhETOBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 10:01:20 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:44920 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbhETOAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 10:00:12 -0400
Received: by mail-ej1-f50.google.com with SMTP id lz27so25432235ejb.11;
        Thu, 20 May 2021 06:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BNRMBQhQwN37AuO48S7OAEO5Yl+NBlyK6oGX4b7ciAc=;
        b=b7fEJLE7R0Bd/TMm92ytFzbAdIm4qbz+ezMtV0V9XKOlFx/SJwhGfc9cXAXIFVFb6T
         8Xd99a6xhpe+bcqxT8X+uuX60P2hGvhm8seXZOg4lPLBhRerKF1J8JueezubJuY4FOMV
         bAI9TUi+YpQNsBzx4kKFDTn9ud1seJ6ElmVGgsrhR2dasm2c/r7oEFvcXAhBPmrG3yPP
         IY73jevTfN/cnOqF142QmlKyjkwnLyBQaHGg+58CkqsR6ueT4XKYAM1vX2XQdLj1FZGn
         MsrH7Ji5q1PFnheYiaMbUjQvvyKIFxNs+7flgAv/zEMMEVMDoDrEElvvuWvxQBElu51F
         Ei7Q==
X-Gm-Message-State: AOAM530dvHdmmCSdMdDZJA2Sz4d8+siXs5RJzivDpqJRVQ1DGV71nvtb
        2Kbx1mQOhra1UwKDl4wu19SOTYLziiwReEWa
X-Google-Smtp-Source: ABdhPJyHzut9drb/H7h7imcrAFp+JKTXdyjp0T1z+Zo0T0i9bbSpZ6R1X/0cCZTynG1TOiJvS3kEYg==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr4721513ejm.487.1621519130267;
        Thu, 20 May 2021 06:58:50 -0700 (PDT)
Received: from msft-t490s.teknoraver.net (net-5-94-253-60.cust.vodafonedsl.it. [5.94.253.60])
        by smtp.gmail.com with ESMTPSA id 9sm1434492ejv.73.2021.05.20.06.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 06:58:49 -0700 (PDT)
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
Subject: [PATCH v2 6/6] loop: increment sequence number
Date:   Thu, 20 May 2021 15:56:22 +0200
Message-Id: <20210520135622.44625-7-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520135622.44625-1-mcroce@linux.microsoft.com>
References: <20210520135622.44625-1-mcroce@linux.microsoft.com>
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
index d58d68f3c7cd..b187fe48d2ef 100644
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

