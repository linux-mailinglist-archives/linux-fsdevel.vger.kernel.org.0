Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985F32E79E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 15:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgL3OFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 09:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL3OFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:05:48 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4371CC061799;
        Wed, 30 Dec 2020 06:05:08 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id h186so9759147pfe.0;
        Wed, 30 Dec 2020 06:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RznXSw7qxQXCa6AGnGmmtVifZFqLdwppqr0oE+H73IQ=;
        b=FiNo6uDsC8Fr0nL/oPoVOKzAGkk6h4ZY8XO2eOKKH32+LjhNXcma4jGLFZ50yQ2SJA
         e289avFGuWNFUkBP0NfwaUTY5lhlENek0BSSTXQ2hXFNECXxCajrTLj0yOOPsM+SNqLO
         QzC9j4//1IeOtOgsWgdLrDNZsWStVYdAcj6opbdYQykMWfwNozG1w8J/nfOdR4pmP8LW
         56C0fU6c1QyCSLwjAE8TrQtsrtrsQo32DpQzetO4y7Z16ZMCJ8iaMHfAQnBxKt6RyrBa
         +3f5BAihLHMb0mQCnxKX40ttERxcmdRUqd2zIxvS7d5xYT+KExPqDPux1dowkveOuxI1
         kudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RznXSw7qxQXCa6AGnGmmtVifZFqLdwppqr0oE+H73IQ=;
        b=MVptWGhZ4hDSsYioOYDfl4oYmjTHSUD8VDTWqP4aT+8nOxDE14tSvRFw9R/jGEa/Am
         EdSTYZQThH29RfrqlDTdM6JGnsPG3rk493JaIGHl++cGm0gRrRNSUWqz5N2TbGSY/P/q
         qsqlq6hWTF/qa1wL+8KD0AEAJzMlqt8+n0KQKyZ+YIeK4wDhxc0C1m85dJ/z/wAuoBxv
         uGMyzmY4p50eqCykp+gMFKYI0sR8fr1quP2K5j23v/I0+8tIKyxcesUFHz8qvEwXUUnc
         kI/A+djdQkDNlt1f1iYda58R7wVKW1zrClo4bUBwMgj7O9ku/N+UexOVuF77agSZ3XtW
         UAtQ==
X-Gm-Message-State: AOAM5303D0oGGfVsCHeJYJyJlUhE5bNm6gmNw0Kyj28X8Tdkev2coK3F
        KJ9J+UUwfCNzm+XZHu3uyrL0qnk/PeWNIQ==
X-Google-Smtp-Source: ABdhPJw8xRASTcrtl2r8MBKh8DGsaJWaLP8WYraJJ3sYSTpRzFpO8y4QbnJFKUNPqe8cPlCRiXdfqw==
X-Received: by 2002:a63:da58:: with SMTP id l24mr52102176pgj.178.1609337107580;
        Wed, 30 Dec 2020 06:05:07 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id b1sm7087859pjh.54.2020.12.30.06.05.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 06:05:07 -0800 (PST)
Date:   Wed, 30 Dec 2020 23:05:04 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] block: reject I/O in BLKRRPART if block size changed
Message-ID: <20201230140504.GB7917@localhost.localdomain>
References: <20201226180232.12276-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201226180232.12276-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20-12-27 03:02:32, Minwoo Im wrote:
> Background:
>   Let's say we have 2 LBA format for 4096B and 512B LBA size for a
> NVMe namespace.  Assume that current LBA format is 4096B and in case
> we convert namespace to 512B and 4096B back again:
> 
>   nvme format /dev/nvme0n1 --lbaf=1 --force  # to 512B LBA
>   nvme format /dev/nvme0n1 --lbaf=0 --force  # to 4096B LBA
> 
>   Then we can see the following errors during the BLKRRPART ioctl from
> the nvme-cli format subcommand:
> 
>   [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>   [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
>   ...
> 
>   Also, we can see the Read commands followed by the Format command due
> to BLKRRPART ioctl with Number of LBAs to 65535(0xffff) which is
> under-flowed because the request for the Read commands are coming with
> 512B and this is because it's playing around with i_blkbits from the
> block_device inode which needs to be avoided as [1].
> 
>   kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
>   ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002
>   ...
> 
>   Before we have commit 5ff9f19231a0 ("block: simplify
> set_init_blocksize"), block size used to be bumped up to the
> 4K(PAGE_SIZE) in this example and we have not seen these errors.  But
> with this patch, we have to make sure that bdev->bd_inode->i_blkbits to
> make sure that BLKRRPART ioctl pass proper request length based on the
> changed logical block size.
> 
> Description:
>   As the previous discussion [1], this patch introduced a gendisk flag
> to indicate that block size has been changed in the runtime.  This flag
> is set when logical block size is changed in the runtime with sector
> capacity itself.  It will be cleared when the file descriptor for the
> block devie is opened again which means __blkdev_get() updates the block
> size via set_init_blocksize().
>   This patch rejects I/O from the path of add_partitions() and
> application should open the file descriptor again to update the block
> size of the block device inode.
> 
> [1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Hello,

Sorry for the noises here.  Please ignore this patch.  Will try to
prepare a new one for this issue.

Thanks,
