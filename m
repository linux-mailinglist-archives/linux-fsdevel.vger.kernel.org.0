Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40202E9598
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbhADNH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 08:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbhADNH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:07:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A12C061793;
        Mon,  4 Jan 2021 05:07:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so10834867pjv.5;
        Mon, 04 Jan 2021 05:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9PNlghCID7xrnKnwIfUPaFpK7qetO1X+HLObjsAt+90=;
        b=qiM4ZvQIlGU8LxHTSAGBUjLDpQK6qX0EHqg2P/ZAEmmxM1597/Dx+e1ZfFfadopgSm
         HaSvLTKQPmSxsOQ/JFySGO2PlxyNAZKMHDU8iiMgu0z7LbwP+V5NDueqp/o2nV2OjXsL
         diztaKNmASzxiIeU0/2awnWdfC0cQBVYmUsB+Lt3DQNULdacMbFbRNLU6kkAGbeRGGI5
         7/cfm7Zn9X+NtkOYNbOCcrhPlDqFVdE8p9QNZ3lPpivQu7Y/mpOfs+vANmo75jUHSiXF
         UTTDrcvhOZM8h5HGGldl3VkP8KF9/eyBRI3Rhl4wGc9MNfr9CB4Pk1M8BS7y6IJDwe7c
         a5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9PNlghCID7xrnKnwIfUPaFpK7qetO1X+HLObjsAt+90=;
        b=RdpTgx0902ubGeWxiGhGVLwl4uk2j5ocw5DdRk9Gi3v3UIB7hq4EzFo8buuiZqOAih
         uffYbMGKHXmmxiNs5e/ucJBfyr7c+yvxn/rF2pb7cJ8wiMM3a0IswcSnZ7L7O4w01wmw
         a9QDyLYdhSJMNrK+2QyLZLi/P+KrkGRBJT0jzo46ZavZDSHQya8ZJBJrJAHCJTSCTJ1i
         qrBQiN+4IKN/HAlijsiUlg674L+9bXBq2Glem0+FXek3lBlLzV5vQqiot1NNS6mSr3HR
         RILf+DbzPZc3bVzOjRjqeb8oc9lOpjDiEH5kBN+73VEXb2qQjUe6g3lUbaCYo9HYC1hH
         +HkQ==
X-Gm-Message-State: AOAM532TpyHGuSXhMALY/pVdD12v42VXDDCIh1ODs2gxn0KjmYRKCLpL
        iQr/uFRdTFyKs9q/7Jqc0TmqDckGk+o=
X-Google-Smtp-Source: ABdhPJwFpCCSk9iPiI/abagLvBnoU6q4dGZEJQr80z9xU5rUEwYMGrjSFyXuTsxYw4Upgu1cgO0sNQ==
X-Received: by 2002:a17:902:ed11:b029:da:3137:2695 with SMTP id b17-20020a170902ed11b02900da31372695mr73239869pld.1.1609765634935;
        Mon, 04 Jan 2021 05:07:14 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id b189sm55303786pfb.194.2021.01.04.05.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:07:14 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [RFC PATCH V3 0/1] block: fix I/O errors in BLKRRPART
Date:   Mon,  4 Jan 2021 22:06:58 +0900
Message-Id: <20210104130659.22511-1-minwoo.im.dev@gmail.com>
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
block layer with setting a flag to gendisk until the file descriptor
re-opened to be updated by __blkdev_get().  This is based on the previous
discussion [1].

Since V2:
  - Cover letter with testcase and error logs attached. Removed un-related
    changes: empty line. (Chaitanya, [2])
  - Put blkdev with blkdev_put_no_open().

Since V1:
  - Updated patch to reject I/O rather than updating i_blkbits of the
    block device's inode directly from driver. (Christoph, [1])

[1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t
[2] https://lore.kernel.org/linux-nvme/20201230140504.GB7917@localhost.localdomain/T/#t

Thanks,

Minwoo Im (1):
  block: reject I/O for same fd if block size changed

 block/blk-settings.c    |  8 ++++++++
 block/partitions/core.c | 11 +++++++++++
 fs/block_dev.c          |  6 ++++++
 include/linux/genhd.h   |  1 +
 4 files changed, 26 insertions(+)

-- 
2.17.1

