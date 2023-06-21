Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F284B739241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjFUWHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 18:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFUWHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:07:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1110319AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 15:07:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e64e97e2so3728572b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687385258; x=1689977258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0PowIWqo4PLdrqAZJfSJz7mBwOeooLrme3LrJ4Pl0WM=;
        b=EefWUCYhLFxRxUehWD4t7+ujvS1/psRK+05waekOcY6WP+pWUEzf5UtIuZ242s67fA
         sYjL2WjBqmO8bUOVeWrUex8xfu/1CeGnLyCHhaQdKYcAVwwQ08AjIKq5PyU7iJeq85uK
         0/1gFZpKqrBJ/Lir6za3ZIlvFA+EkzaqeU8ut4q/G5qudhKFsynE65X40o7aREI6thwK
         ub3kxXX+GW0bqVDAYf4JXy/C3FcO1XoWEugUX/1a4jN5EgxBX0H3EnLov+kVIpiLwcWl
         3egmftlR0dmudql1NKx8MtidnHe34z46DVYyzUGJX+z36Rxih0GQh0AYgPA5ZblUKQXn
         04MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385258; x=1689977258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PowIWqo4PLdrqAZJfSJz7mBwOeooLrme3LrJ4Pl0WM=;
        b=NQBQCRK90csKGVJsQW0xrgIZkrEh/aVsQSz8CtJqvJ7DZJn6Ses6M3a3QAOmN2L6yP
         3AilvQ/j0UhLUy2Q1AEwMdq83xxEjWnTij3bzhiKibdS4oFMsU3h8jJbpW0lOdAc10T7
         ZAtKiKpxOTvvsSybKC6krloi1I9EOxwiIsjZvh5BVPxPgskPV7S7/vykB5TRApvzJz7B
         JKDUHOcvkVQb6IpTglEYP+M2Jmic2fb/M024aULp3gTB3+BB0fMkIYl5fkv1MJxeDeXL
         eqg/kj0U1drQYuGnFhhadOeqJbhL/KJvnR6zuKsaKa2mZ+auLdCVo9zGyxjhrR1JO+4Z
         vl7Q==
X-Gm-Message-State: AC+VfDyN3JQUCb12zXL7XQWG/IfqLmpUmrwkuKZohYHu+1jnQH42QsBO
        fVngSLAADb4DSn8pDn59d4vZEQ==
X-Google-Smtp-Source: ACHHUZ52+J36kGyQxrOIbU0A3aFtw6RWU96C/mBm8DKAlrPEVlIGB/xwxibOfkd7X+lsQbZdPrDl2A==
X-Received: by 2002:a05:6a20:3d26:b0:10b:8698:2097 with SMTP id y38-20020a056a203d2600b0010b86982097mr16419204pzi.0.1687385258499;
        Wed, 21 Jun 2023 15:07:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id w4-20020aa78584000000b0064aea45b040sm3332616pfn.168.2023.06.21.15.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 15:07:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qC5zC-00EbnU-2k;
        Thu, 22 Jun 2023 08:07:34 +1000
Date:   Thu, 22 Jun 2023 08:07:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, willy@infradead.org,
        gost.dev@samsung.com, mcgrof@kernel.org, hch@lst.de,
        jwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/4] minimum folio order support in filemap
Message-ID: <ZJN0pvgA2TqOQ9BC@dread.disaster.area>
References: <CGME20230621083825eucas1p1b05a6d7e0bf90e7a3d8e621f6578ff0a@eucas1p1.samsung.com>
 <20230621083823.1724337-1-p.raghav@samsung.com>
 <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b311ae01-cec9-8e06-02a6-f139e37d5863@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:00:24AM +0200, Hannes Reinecke wrote:
> On 6/21/23 10:38, Pankaj Raghav wrote:
> > There has been a lot of discussion recently to support devices and fs for
> > bs > ps. One of the main plumbing to support buffered IO is to have a minimum
> > order while allocating folios in the page cache.
> > 
> > Hannes sent recently a series[1] where he deduces the minimum folio
> > order based on the i_blkbits in struct inode. This takes a different
> > approach based on the discussion in that thread where the minimum and
> > maximum folio order can be set individually per inode.
> > 
> > This series is based on top of Christoph's patches to have iomap aops
> > for the block cache[2]. I rebased his remaining patches to
> > next-20230621. The whole tree can be found here[3].
> > 
> > Compiling the tree with CONFIG_BUFFER_HEAD=n, I am able to do a buffered
> > IO on a nvme drive with bs>ps in QEMU without any issues:
> > 
> > [root@archlinux ~]# cat /sys/block/nvme0n2/queue/logical_block_size
> > 16384
> > [root@archlinux ~]# fio -bs=16k -iodepth=8 -rw=write -ioengine=io_uring -size=500M
> > 		    -name=io_uring_1 -filename=/dev/nvme0n2 -verify=md5
> > io_uring_1: (g=0): rw=write, bs=(R) 16.0KiB-16.0KiB, (W) 16.0KiB-16.0KiB, (T) 16.0KiB-16.0KiB, ioengine=io_uring, iodepth=8
> > fio-3.34
> > Starting 1 process
> > Jobs: 1 (f=1): [V(1)][100.0%][r=336MiB/s][r=21.5k IOPS][eta 00m:00s]
> > io_uring_1: (groupid=0, jobs=1): err= 0: pid=285: Wed Jun 21 07:58:29 2023
> >    read: IOPS=27.3k, BW=426MiB/s (447MB/s)(500MiB/1174msec)
> >    <snip>
> > Run status group 0 (all jobs):
> >     READ: bw=426MiB/s (447MB/s), 426MiB/s-426MiB/s (447MB/s-447MB/s), io=500MiB (524MB), run=1174-1174msec
> >    WRITE: bw=198MiB/s (207MB/s), 198MiB/s-198MiB/s (207MB/s-207MB/s), io=500MiB (524MB), run=2527-2527msec
> > 
> > Disk stats (read/write):
> >    nvme0n2: ios=35614/4297, merge=0/0, ticks=11283/1441, in_queue=12725, util=96.27%
> > 
> > One of the main dependency to work on a block device with bs>ps is
> > Christoph's work on converting block device aops to use iomap.
> > 
> > [1] https://lwn.net/Articles/934651/
> > [2] https://lwn.net/ml/linux-kernel/20230424054926.26927-1-hch@lst.de/
> > [3] https://github.com/Panky-codes/linux/tree/next-20230523-filemap-order-generic-v1
> > 
> > Luis Chamberlain (1):
> >    block: set mapping order for the block cache in set_init_blocksize
> > 
> > Matthew Wilcox (Oracle) (1):
> >    fs: Allow fine-grained control of folio sizes
> > 
> > Pankaj Raghav (2):
> >    filemap: use minimum order while allocating folios
> >    nvme: enable logical block size > PAGE_SIZE
> > 
> >   block/bdev.c             |  9 ++++++++
> >   drivers/nvme/host/core.c |  2 +-
> >   include/linux/pagemap.h  | 46 ++++++++++++++++++++++++++++++++++++----
> >   mm/filemap.c             |  9 +++++---
> >   mm/readahead.c           | 34 ++++++++++++++++++++---------
> >   5 files changed, 82 insertions(+), 18 deletions(-)
> > 
> 
> Hmm. Most unfortunate; I've just finished my own patchset (duplicating much
> of this work) to get 'brd' running with large folios.
> And it even works this time, 'fsx' from the xfstest suite runs happily on
> that.

So you've converted a filesystem to use bs > ps, too? Or is the
filesystem that fsx is running on just using normal 4kB block size?
If the latter, then fsx is not actually testing the large folio page
cache support, it's mostly just doing 4kB aligned IO to brd....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
