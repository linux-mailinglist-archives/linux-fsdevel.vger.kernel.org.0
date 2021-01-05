Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AFF2EAAD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbhAEM3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbhAEM3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:29:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91014C061382;
        Tue,  5 Jan 2021 04:27:34 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 15so21181610pgx.7;
        Tue, 05 Jan 2021 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XqETI2dj6LLMBcSn8TTOy0ZVVdhDfBt9SMpfQ1dkImQ=;
        b=WQsow3O8vXyWtIbJBHbR3W4gOlVwK8Qd/A5nbSTl85GhpmUx4R2I2WPb91OFzDusKE
         i9ktAcKupz8zPLeLVmyNz5//2HjmCTqFfJF2fXJG3Fgxcs2halLHhw11qJ1gasv635qX
         mX3/v0Q/4fhISLcYCclxQLkA7BJNwSYjJ3lzxbiXcuHQZqbjN3pJc/SQTpahgW9FyCrD
         YWwf1zAKqFLucH+DeaV//cym6fMcZrihcxKVSwVQBNWswgn9/ZDJ2GI0eACemKu6usj2
         A+sx9UlNmn7BnkfrcKNfmBUB9+v8iDQKq19XGgQCPJR/H10bvARdcgJB/8924zxCY59I
         28LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XqETI2dj6LLMBcSn8TTOy0ZVVdhDfBt9SMpfQ1dkImQ=;
        b=LKH/61MBScCqNThhyieKoEqilLLWx7nbh9HRbO/9Bft1NQd6f8R3VL2teyobZVhkEq
         YEshie04dpL3SwcgKlavBhbUHOqrNeGlPXU47+rR/lPdwdQL1ymh+TIhXMSnQdYYdr4+
         e9K8UZB6lcBsM0Cbl7S7+LvzHufHENol5RPuvmuKkF0lGU/iq3TmYNRsN1awdr8hxwbA
         cvIVrfgHlsZJtkWmURX2xszbga9X1XwLBJTl6az4UE1QLBE5sLY77tqMZ+87ER/R+EAl
         +ce1pYdkuNyAvIRJZNbYujhXZ4tr4iT29tF6+/UNHUPxM9W8dK5kyplTJZoLTsF7Fy8x
         arGg==
X-Gm-Message-State: AOAM530WrK7AHTnP0U0A4H8znSKnDZ65wEIH3LnUARWx609uB+e3xCO0
        jCESWmrqpqvGm9R95Luif8MPPBDWD2calA==
X-Google-Smtp-Source: ABdhPJyQy0Jl0taKm2oXKaclq9kNLyhy6PSoq+ZrxVqR0efdgYnsNiNwszpgiWCRPsmgqf3hr6zucg==
X-Received: by 2002:aa7:9f97:0:b029:1a5:94d8:9cbf with SMTP id z23-20020aa79f970000b02901a594d89cbfmr68773148pfr.79.1609849653923;
        Tue, 05 Jan 2021 04:27:33 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id gw7sm2599647pjb.36.2021.01.05.04.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:33 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V4 0/1] block: fix I/O errors in BLKRRPART
Date:   Tue,  5 Jan 2021 21:27:16 +0900
Message-Id: <20210105122717.2568-1-minwoo.im.dev@gmail.com>
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

