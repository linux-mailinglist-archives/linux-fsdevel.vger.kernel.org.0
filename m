Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665B02E8F32
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 02:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbhADB3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 20:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbhADB3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 20:29:19 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E856C061574;
        Sun,  3 Jan 2021 17:28:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n7so17847414pgg.2;
        Sun, 03 Jan 2021 17:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+zxFsWWYV9Z2Xr5M2Vh3JplDnIId4U3fI3Xozfok3+w=;
        b=HBCtGtCOrF9NeQDLZaa3A2Jae5rofhorRpRDVR6MxE9TxlH7Xo5zRqN+0CxtHTLMqy
         NqsgzNx7h3NGr4KDoKqaSzHEKiuqhWZGlcxMhCGluL4MrmpDzpYgsJKQkjoANGgSB4w9
         wLQqGuDCgdDwFvimGBc+hkjfMF6DJ+SmVHnFy3Z7lwsPRw2KZtpax31moxgLo/j5ZcC9
         oxQNwy+OHTlwXOKeDOKZrrL2EeGgUMsG4ZQZRimsikdGDIsM1JMGngOZqvnsDO1DCkbd
         GsPkhx8M5jFuNROX6uGA72CFO0k8SrRBmbedXGDPNCCZX6gzxbDXME/nKvFuM2sxi4ZX
         mXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+zxFsWWYV9Z2Xr5M2Vh3JplDnIId4U3fI3Xozfok3+w=;
        b=psHBjZggRYoAwWX/3sSxi5mXVNPzBV4608Qf8IcqH26ui6munXk19CZSzZn+uSyWYi
         algwWOVN7P6aRnmo7ZIgBZW/x8OB4VVCwftGhW4s8BNKkKcDrOZp5Xm4zHULhub4jcM3
         RmgYTUy8DKtpc7ydOYpp+7VSYnzYftRHD5Cj6vZe7icAmSqOlVtgqn8X1FofMTbuO1tq
         MgninR0lt7xemHbEUzQiGbFVfYAJ6fpF4vi1X/7ZX9ydc75/njEZfS5gFvF1ND+lVRov
         LLQL99QIN0LMegKetyEBvAQobvsETmKjpjpa8YYJgzYKIjhOYef4VZjPjtVZUeTWA03a
         TkCg==
X-Gm-Message-State: AOAM530egA7o9oKsytvY0TOBNhE2hEPU/0VsFmb+AzNSPW5j8eh6eP8K
        lG5cVfYV9MA97faD5WbpBNk=
X-Google-Smtp-Source: ABdhPJxknjWrYweGbs9hioPQrnNyVo+5IRkOgyVumkwbebNiMVrN5WNdBjxZQBIRkWQDEAJhpdQENg==
X-Received: by 2002:a63:1f47:: with SMTP id q7mr8643146pgm.10.1609723719046;
        Sun, 03 Jan 2021 17:28:39 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id y6sm54199614pfn.145.2021.01.03.17.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jan 2021 17:28:38 -0800 (PST)
Date:   Mon, 4 Jan 2021 10:28:36 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC V2] block: reject I/O for same fd if block size changed
Message-ID: <20210104012836.GA3873@localhost.localdomain>
References: <20201230160129.23731-1-minwoo.im.dev@gmail.com>
 <BYAPR04MB49659FFF1A820C9E7BBC1D0386D20@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49659FFF1A820C9E7BBC1D0386D20@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21-01-04 00:57:07, Chaitanya Kulkarni wrote:
> On 12/30/20 08:03, Minwoo Im wrote:
> > Let's say, for example of NVMe device, Format command to change out
> > LBA format to another logical block size and BLKRRPART to re-read
> > partition information with a same file descriptor like:
> >
> > 	fd = open("/dev/nvme0n1", O_RDONLY);
> >
> > 	nvme_format(fd, ...);
> > 	if (ioctl(fd, BLKRRPART) < 0)
> > 		..
> >
> > In this case, ioctl causes invalid Read operations which are triggered
> > by buffer_head I/O path to re-read partition information.  This is
> > because it's still playing around with i_blksize and i_blkbits.  So,
> > 512 -> 4096 -> 512 logical block size changes will cause an under-flowed
> > length of Read operations.
> >
> > Case for NVMe:
> >   (LBAF 1 512B, LBAF 0 4K logical block size)
> >
> >   nvme format /dev/nvme0n1 --lbaf=1 --force  # to 512B LBA
> >   nvme format /dev/nvme0n1 --lbaf=0 --force  # to 4096B LBA
> >
> > [dmesg-snip]
> >   [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> >   [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
> >
> > [event-snip]
> >   kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
> >    ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002
> >
> > As the previous discussion [1], this patch introduced a gendisk flag
> > to indicate that block size has been changed in the runtime.  This flag
> > is set when logical block size is changed in the runtime in the block
> > layer.  It will be cleared when the file descriptor for the
> > block devie is opened again through __blkdev_get() which updates the block
> > size via set_init_blocksize().
> >
> > This patch rejects I/O from the path of add_partitions() to avoid
> > issuing invalid Read operations to device.  It also sets a flag to
> > gendisk in blk_queue_logical_block_size to minimize caller-side updates.
> >
> > [1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t
> >
> > Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Rewrite the change-log similar to what we have in the repo and fix
> the spelling mistakes. Add a cover-letter to explain the testcase
> and the execution effect, also I'd move discussion link into
> cover-letter.

Thanks for your time.  Will prepare V3 with proper change logs and cover
letter to explain issue and testcase.

Thanks,
