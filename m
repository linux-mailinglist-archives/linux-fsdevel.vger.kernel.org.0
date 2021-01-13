Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB52F4D33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 15:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAMOfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 09:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMOfc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:35:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA81CC061786;
        Wed, 13 Jan 2021 06:34:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h10so1317002pfo.9;
        Wed, 13 Jan 2021 06:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wuAPPQU+6X7mitOsqG1eiFMYozHtMEmetO9yEuL4FC0=;
        b=spHGxxzehb1XCEntTkAOMPbuWQEKAplQnBPaN6t1Ia3kDOUcWlbCT6q3Md8t2m1iAo
         clyDJfL0Y9CORWRnXl+LqXbr8VE6jvbOi23/jIKWOENQoVogaJW7qHaJOvbIPACDaLAE
         mDQz1o6lnuY5GgrcWkxJK5Uq//4gwPwEklHRQACTZEShXuKnzu2Fbc+AtD12sHKDocl0
         y/5wabM+bu5gRfmM9lps7OJhiwdfefToE5D1KhuYo9O9KCRfbo3/JbXF5rUJ30r5DLCo
         KG0vahtvADy7PRw2S9B7r+I88yEM5z5gH1EJYxt/Ih74WDNaKyBg+tlSZWp8yUHoAN9y
         bt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wuAPPQU+6X7mitOsqG1eiFMYozHtMEmetO9yEuL4FC0=;
        b=Cqwyx6uTSp5Elo7ROB1su3yudiAsdm7cfUGzugCAbwIc9Lzg+UdhV8ybNQcxiw9bOU
         HQWXers/VYPkf5euFH/u6Um6xvtuyYwBjFf9S5ELEtD+aHwo9h7j8jHUR5pv9f8Yztqp
         j6tnolC7IjLt6UlF0sYCMnShiaxQgvy+EXoFlz9OuSkhH461Oz2CQtf0ij186So86CgG
         oyW7ifLrQyRWYHj5EYJ2h9T8gTs7OS2S9KBcJPCVu8LYL8ujj8LXJBhIKJpoaaJHjZJl
         rID8Jf9YKk+ejfTqjKGsaSXJjVuVM22PAAA0cpk1tEuTLCeuvUWxbLIE/F3zNxUNe9DM
         s/2A==
X-Gm-Message-State: AOAM531W1QV0mZI4z/c5dRHd/pDjHoUDs3ibVA3CE6FpRAz2xQ80RpFM
        UTDXA3f+bbEJSSNE0e1tpcRsJWUFE6PDxA==
X-Google-Smtp-Source: ABdhPJwZLSbTDb+DnYUit6x3YH5fJ+SKF5iLK7fBcGoJ7NjP418/fl/X/bjQwvz1RVZdEmXLbVUOEQ==
X-Received: by 2002:a63:f010:: with SMTP id k16mr2366648pgh.28.1610548491261;
        Wed, 13 Jan 2021 06:34:51 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id c5sm3248265pjo.4.2021.01.13.06.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:34:50 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V5 0/1] block: fix I/O errors in BLKRRPART
Date:   Wed, 13 Jan 2021 23:34:31 +0900
Message-Id: <20210113143432.426-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

  This patch fixes I/O errors during BLKRRPART ioctl() behavior right
after format operation that changed logical block size of the block
device with a same file descriptor opened.

Testcase:

  The following testcase is a case of NVMe namespace with the following
conditions:

  - Current LBA format is lbaf=0 (512 bytes logical block size)
  - LBA Format(lbaf=1) has 4096 bytes logical block size

  # Format block device logical block size 512B to 4096B                                                                                                                                                                                                                                                                                                                                       
  nvme format /dev/nvme0n1 --lbaf=1 --force

  This will cause I/O errors because BLKRRPART ioctl() happened right after
the format command with same file descriptor opened in application
(e.g., nvme-cli) like:

  fd = open("/dev/nvme0n1", O_RDONLY);

  nvme_format(fd, ...);
  if (ioctl(fd, BLKRRPART) < 0)
        ...

Errors:

  We can see the Read command with Number of LBA(NLB) 0xffff(65535) which
was under-flowed because BLKRRPART operation requested request size based
on i_blkbits of the block device which is 9 via buffer_head.

  [dmesg-snip]
    [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
    [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read

  [event-snip]
    kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
     ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002

  The patch below fixes the I/O errors by rejecting I/O requests from the
block layer with setting a flag to request_queue until the file descriptor
re-opened to be updated by __blkdev_get().  This is based on the previous
discussion [1].

Since V4:
  - Rebased on block-5.11.
  - Added Reviewed-by Tag from Christoph.

Since V3(RFC):
  - Move flag from gendisk to request_queue for future clean-ups.
    (Christoph, [3])

Since V2(RFC):
  - Cover letter with testcase and error logs attached. Removed un-related
    changes: empty line. (Chaitanya, [2])
  - Put blkdev with blkdev_put_no_open().

Since V1(RFC):
  - Updated patch to reject I/O rather than updating i_blkbits of the
    block device's inode directly from driver. (Christoph, [1])

[1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t
[2] https://lore.kernel.org/linux-nvme/20201230140504.GB7917@localhost.localdomain/T/#t
[3] https://lore.kernel.org/linux-block/20210105101202.GA9970@localhost.localdomain/T/#u

Thanks,

Minwoo Im (1):
  block: reject I/O for same fd if block size changed

 block/blk-settings.c    |  3 +++
 block/partitions/core.c | 12 ++++++++++++
 fs/block_dev.c          |  8 ++++++++
 include/linux/blkdev.h  |  1 +
 4 files changed, 24 insertions(+)

-- 
2.17.1

