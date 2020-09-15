Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2326B309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 00:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgIOW7E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 18:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgIOPQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:16:27 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631BC061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 08:16:27 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l17so3388171edq.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Y/E8RIZkFddtFHwulQR49x2idyk01ZxBjW2bmut0Hc=;
        b=aYUToB6zrH24LY2xVmoAyJwITz8fGR6B9Qyvei4FahpHnuBBGJskZBN99qaAB3fUtt
         eplyUOquGjz16GIfT0XPfVfK6rWzZUl6W++JUAYHXdSONpYAZ7oJQoQpSO9WoXxERlUM
         BFE2EAtpbMqxL86TEUDW3nuKqnw5j+jNh6OhDaegsg2GfPGpcr4OuwCKUDkneHf+Y9xq
         aF/WATLPPJGPZQAXRmmcXIEywdheUmmHpm935jG7Gi26yjgWfBSUee5TXycCcQbZI8Xe
         L/4gjmmxDcj43zn6sB3SSphAW6uwaG7Mdenlq44BpIKgApFbwOJF1G6xT2ZkwdzYA6s7
         qSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Y/E8RIZkFddtFHwulQR49x2idyk01ZxBjW2bmut0Hc=;
        b=jl3ShW2ydi2JB3bvyWCM1IfhmRHM5oS04G6gqzp35qZ40bKKDLyCRhQ47gwHKf6M7I
         eSx0rA9EhO7C3Wusjn4Tyg/vTRCCz1MgoUOMwJfOlZWyMKxUWTKouF5HfzM6C2kbFY6p
         EXd3gOwA0ElyC69TNPO2Z64RAHGzRflXMEGN2qo6jEDUquZaOdJ0v7DfRU3Lu62L51wE
         K0SQ+uTNexrrCA743YTC6WxifikkZmRKP5/yo4lDy7AmmsyNROhJ4jYlU6+PRtMrveYq
         iWvosoFPWq4p2Xk+LC3jp8KMx+EidMtkPha5PyTDA9vRz67H+tJbu85u/FztNYu7Iugh
         qkHg==
X-Gm-Message-State: AOAM532nZ6iUUJZUOBIGNZ2jbeX7Jzvfq1ofFSH0ZGoUUD75peu5X4/5
        yXG4ylZwH5RXbtIyxLJh22+SF6afG8QxUS4a55i60A==
X-Google-Smtp-Source: ABdhPJythHZ3a+LmcR0W/cN6t2efwSdOy7mTxn9YsBnVaa3RGCOahJdxMaNVwwar29AYxB16Vjz9H4YOkhyHfRSam2I=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr23655873edo.354.1600182982436;
 Tue, 15 Sep 2020 08:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Sep 2020 08:16:11 -0700
Message-ID: <CAPcyv4gh=QaDB61_9_QTgtt-pZuTFdR6td0orE0VMH6=6SA2vw@mail.gmail.com>
Subject: Re: [RFC] nvfs: a filesystem for persistent memory
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Eric Sandeen <esandeen@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Kani, Toshi" <toshi.kani@hpe.com>,
        "Norton, Scott J" <scott.norton@hpe.com>,
        "Tadakamadla, Rajesh (DCIG/CDI/HPS Perf)" 
        <rajesh.tadakamadla@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 15, 2020 at 5:35 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Hi
>
> I am developing a new filesystem suitable for persistent memory - nvfs.

Nice!

> The goal is to have a small and fast filesystem that can be used on
> DAX-based devices. Nvfs maps the whole device into linear address space
> and it completely bypasses the overhead of the block layer and buffer
> cache.

So does device-dax, but device-dax lacks read(2)/write(2).

> In the past, there was nova filesystem for pmem, but it was abandoned a
> year ago (the last version is for the kernel 5.1 -
> https://github.com/NVSL/linux-nova ). Nvfs is smaller and performs better.
>
> The design of nvfs is similar to ext2/ext4, so that it fits into the VFS
> layer naturally, without too much glue code.
>
> I'd like to ask you to review it.
>
>
> tarballs:
>         http://people.redhat.com/~mpatocka/nvfs/
> git:
>         git://leontynka.twibright.com/nvfs.git
> the description of filesystem internals:
>         http://people.redhat.com/~mpatocka/nvfs/INTERNALS
> benchmarks:
>         http://people.redhat.com/~mpatocka/nvfs/BENCHMARKS
>
>
> TODO:
>
> - programs run approximately 4% slower when running from Optane-based
> persistent memory. Therefore, programs and libraries should use page cache
> and not DAX mapping.

This needs to be based on platform firmware data f(ACPI HMAT) for the
relative performance of a PMEM range vs DRAM. For example, this
tradeoff should not exist with battery backed DRAM, or virtio-pmem.

>
> - when the fsck.nvfs tool mmaps the device /dev/pmem0, the kernel uses
> buffer cache for the mapping. The buffer cache slows does fsck by a factor
> of 5 to 10. Could it be possible to change the kernel so that it maps DAX
> based block devices directly?

We've been down this path before.

5a023cdba50c block: enable dax for raw block devices
9f4736fe7ca8 block: revert runtime dax control of the raw block device
acc93d30d7d4 Revert "block: enable dax for raw block devices"

EXT2/4 metadata buffer management depends on the page cache and we
eliminated a class of bugs by removing that support. The problems are
likely tractable, but there was not a straightforward fix visible at
the time.

> - __copy_from_user_inatomic_nocache doesn't flush cache for leading and
> trailing bytes.

You want copy_user_flushcache(). See how fs/dax.c arranges for
dax_copy_from_iter() to route to pmem_copy_from_iter().
