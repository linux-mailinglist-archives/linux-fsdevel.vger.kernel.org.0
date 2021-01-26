Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E930498D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbhAZF0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbhAZBuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:50:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16584C0617AA;
        Mon, 25 Jan 2021 16:29:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id o20so9409882pfu.0;
        Mon, 25 Jan 2021 16:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U5Xee1nWGWRf4U7sOGzZ/yhKEr2omkTib7NUJ1y8Lic=;
        b=N7hs8yqlQ0ARbi9YXeVbc50WURb9InsHCQryflEHIqFJrD0mWEzmbVhgFQFvI1w0mt
         JSFhWufzUTTxeOicc6wSnqTUHSh8k3Aj8L16YKiK0oyYnr5We/+7yhpwoHfcuiueKu+/
         RnHqrKd9ZyAmV/zEq34pFPErmdJUNYH9pNMFAxeCPGpUd3RqVgeb+KU1wc88WaLD4/LD
         rrztNBLli66Wg9aEG+/0hyqhuauEOpV5zEj/vif8vjVQ+Yq17aG3mC1txiVWxdO7dMNz
         DADDErrVqs/3fIuCFP0n4PPRb7FasjDInEkNkno/rCYaYbCfYKyyVj32az3tGunIxLYL
         w/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U5Xee1nWGWRf4U7sOGzZ/yhKEr2omkTib7NUJ1y8Lic=;
        b=P+yFq8A/vOEbS9BZOFfzuJh0869cZ6yRr51/7om5tGjU+S3YeSMjphYZytzs6goSbK
         Vms305s2PpK0VU1+tFGNKqWwC1nWnH42UDjTwFNjJOl3KpAtDDA3bMeowIzKuAg4jA9A
         POGs7H4tRhxHB1CNuI4xURSslGMOBB8ylrjodhGiJGHU3VyhoDaoGHxBvIiXPodgvANE
         YXw7YlVZ+OCiwNDtzWOwqrBRje0wXsMM1AkV599XOy8pitRAidezdFxP018z+XZaWFza
         TZB7dYtLquhckPKo3oNpmgjll8783WwkXS/2H8aDiotvnv3ZUdArgL08Z8TGih6DKjXk
         UIrQ==
X-Gm-Message-State: AOAM532AurApBz4qRr86jxVyESkLCiqadwrrQubq8O33haaI1xShJjqW
        0KtBw/Rf3kavPKhaD5OLki1GBmmnytCLvA==
X-Google-Smtp-Source: ABdhPJw7dW5USNY2wqoFH1aplTri/zdWl8Na9Oi6AskJQD3ROtTCwM7xIvKSK6ZDVCtMh8R1IrGuOg==
X-Received: by 2002:a63:305:: with SMTP id 5mr3077239pgd.234.1611620947344;
        Mon, 25 Jan 2021 16:29:07 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id 14sm16999418pfi.131.2021.01.25.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 16:29:06 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V6 0/1] block: fix I/O errors in BLKRRPART
Date:   Tue, 26 Jan 2021 09:29:00 +0900
Message-Id: <20210126002901.5533-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

(This series is just RESEND with rebasing it on for-next)

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

Since V5:
  - Rebased on for-next

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

Minwoo Im (1):
  block: reject I/O for same fd if block size changed

 block/blk-settings.c    |  3 +++
 block/partitions/core.c | 12 ++++++++++++
 fs/block_dev.c          |  8 ++++++++
 include/linux/blkdev.h  |  1 +
 4 files changed, 24 insertions(+)

-- 
2.17.1

