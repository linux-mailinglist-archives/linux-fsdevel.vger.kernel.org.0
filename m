Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66ED74E261
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGKABP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 20:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjGKABO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:01:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99AC1A8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 17:01:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2783380b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1689033672; x=1691625672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rDIkwchrh1kX50Ws/4IvfjUjrf1QWTEULS+sELz0oE=;
        b=t5a3wBvXt9ZocBTTvC5el8i9lsEtR596Y5o182OBCSZMIkC55OqaWZ2VtNhKjkayKJ
         wUf3WoQyVs1fv3JbQLsSVrsV3Bb97RLqGoWS2K8SW2huZFeShaqCsFEBho4aVqq8bMtX
         LrrQomEIJMDr4cptUY/U6Chq1a++zgOYl6bfeN2kZgTHzf1Kz1IstkHwljWRGEdXJonW
         xIx3mp4XpSzG0yqoh1xprKa01E/0uEIZ1S91m/z8EHzdZEzi1tPaz/kn/czvyt/xUnC7
         3TeZrL3cwK1X3APHkXdEKPB062GlZU3F8PjoOJFUuTgssglNqCgxb+eVtArMw2at7ue5
         UN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033672; x=1691625672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rDIkwchrh1kX50Ws/4IvfjUjrf1QWTEULS+sELz0oE=;
        b=N1uwuaNeVMI9b2ImgDGzuYUY8BkK7CAZqwnAtf3qPHTwp6ZHLCA5kAlH+kW4wrA8c/
         QvR/EjRHJz7MSrd0qaOPmvTtVvCbYzx60xlkUok/f7I58twSRUS6BtSh5o+iBRS8h7cn
         DMWBZZhsAj+2HeXOSEuP34RLq5rJ5Pn3ssvPvyA8655mQNN4dEe6euzsqgECXv7+1dsq
         Ne7kSp+KkfkcaE/ektriVbuy9/cTUbhaMY6Labu14X+vAFiYQxLS7F5rpPzxS66Z8tSv
         7xQwEzFlLRyUmLlnVzZ83PK9fMKqt4NAO4AW0JbGebH9tSx8mzifwdbyV1au5Av0JyOG
         Jj/A==
X-Gm-Message-State: ABy/qLZ4EgYhHj2Hf/W7ya/vuBNo0ztVDTubD0CdmMJxmVFD8tYS3R7U
        DZOplvh4OByRd38shoAiZim34TnxphQse6Q4hgs=
X-Google-Smtp-Source: APBJJlHBAdk6VvIiu+xr7uciE2CXQTs9pQCluRDCXt/I/P2nXztsEpuWNncx0Aih62Vfd+SS6DVh5g==
X-Received: by 2002:a05:6a20:1584:b0:128:b722:e789 with SMTP id h4-20020a056a20158400b00128b722e789mr14304135pzj.1.1689033672053;
        Mon, 10 Jul 2023 17:01:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-246-40.pa.nsw.optusnet.com.au. [49.180.246.40])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001a95f632340sm465418pll.46.2023.07.10.17.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 17:01:11 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qJ0oW-004aE0-0T;
        Tue, 11 Jul 2023 10:01:08 +1000
Date:   Tue, 11 Jul 2023 10:01:08 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v4 0/9] Create large folios in iomap buffered write path
Message-ID: <ZKybxCxzmuI1TFYn@dread.disaster.area>
References: <20230710130253.3484695-1-willy@infradead.org>
 <ZKyMVRDhwYWvqyvv@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKyMVRDhwYWvqyvv@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,LOTS_OF_MONEY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:55:17PM -0700, Luis Chamberlain wrote:
> On Mon, Jul 10, 2023 at 02:02:44PM +0100, Matthew Wilcox (Oracle) wrote:
> > Commit ebb7fb1557b1 limited the length of ioend chains to 4096 entries
> > to improve worst-case latency.  Unfortunately, this had the effect of
> > limiting the performance of:
> > 
> > fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 \
> >         -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 \
> >         -numjobs=4 -directory=/mnt/test
> 
> When you say performance, do you mean overall throughput / IOPS /
> latency or all?
> 
> And who noticed it / reported it?

https://lore.kernel.org/linux-xfs/20230508172406.1CF3.409509F4@e16-tech.com/

> The above incantation seems pretty
> specific so I'm curious who runs that test and what sort of work flow
> is it trying to replicate.

Not specific at all. It's just a basic concurrent sequential
buffered write performance test. It needs multiple jobs to max out
typical cheap pcie 4.0 NVMe SSD storage (i.e. 6-8GB/s) because
sequential non-async buffered writes are CPU bound at (typically)
2-3GB/s per file write.

> > The problem ends up being lock contention on the i_pages spinlock as we
> > clear the writeback bit on each folio (and propagate that up through
> > the tree).  By using larger folios, we decrease the number of folios
> > to be processed by a factor of 256 for this benchmark, eliminating the
> > lock contention.
> 
> Implied here seems to suggest that the associated cost for the search a
> larger folio is pretty negligable compared the gains of finding one.
> That seems to be nice but it gets me wondering if there are other
> benchmarks under which there is any penalties instead.
> 
> Ie, is the above a microbenchmark where this yields good results?

No, the workload gains are general - they avoid the lock contention
problems involved with cycling, accounting and state changes for
millions of objects (order-0 folios) a second through a single
exclusive lock (mapping tree lock) by reducing the mapping tree lock
cycling by a couple of orders of magnitude.

> > It's also the right thing to do.  This is a project that has been on
> > the back burner for years, it just hasn't been important enough to do
> > before now.
> 
> Commit ebb7fb1557b1 (xfs, iomap: limit individual ioend chain lengths in
> writeback") dates back to just one year, and so it gets me wondering
> how a project in the back burner for years now finds motivation for
> just a one year old regression.

The change in ebb7fb1557b1 is just the straw that broke the camel's
back. It got rid of the massive IO batch processing we used to
minimise the inherent cross-process mapping tree contention in
buffered writes. i.e. the process doing write() calls, multiple
kswapds doing memory reclaim, writeback submission and writeback
completion all contend at the same time for the mapping tree lock.

We largely removed the IO submission and completion from the picture
with huge batch processing, but that then started causing latency
problems with IO completion processing. So we went back to smaller
chunks of IO submission and completion, and that means we went from
3 threads contending on the mapping tree lock to 5 threads. And that
drove the system into catastrophic lock breakdown on the mapping
tree lock.

And so -everything- then went really slow because each write() task
burns down at least 5 CPUs on the mapping tree lock each....

THis is not an XFS issue to solve - this is a general page cache
problem and we've always wanted to fix it in the page cache, either
by large folio support or by large block size support that required
aligned high-order pages in the page cache. Same solution - less
pages to iterate - but different methods...

> What was the original motivation of the older project dating this
> effort back to its inception?

https://www.kernel.org/doc/ols/2006/ols2006v1-pages-177-192.pdf

That was run on a 64kB page size machine (itanic), but there were
signs that the mapping tree lock would be an issue in future.
Indeed, when these large SSI supercomputers moved to x86-64 (down to
4kB page size) a couple of years later, the mapping tree lock popped
up to the top of the list of buffered write throughput limiting
factors.

i.e. the larger the NUMA distances between the workload doing the
write and the node the mapping tree lock is located on, the slower
buffered writes go and the more CPU we burnt on the mapping tree
lock. We carefully worked around that with cpusets and locality
control, and the same was then done in HPC environments on these
types of machines and hence it wasn't an immediate limiting
factor...

But we're talking about multi-million dollar supercomputers here,
and in most cases people just rewrote the apps to use direct IO and
so the problem just went away and the HPC apps could easily use all
the perofrmance the storage provided....

IOWs, we've know about this problem for over 15 years, but the
difference is now that consumer hardware is capable of >10GB/s write
speeds (current PCIe 5.0 nvme ssds) for just a couple of hundred
dollars, rather than multi-million dollar machines in carefully
optimised environments that we first saw it on back in 2006...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
