Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D791C365416
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhDTI3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:29:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhDTI3S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618907326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mr0hIV45HZyfj36zbs5xzzipJ3KnBhIuZDQPVZgMTZE=;
        b=dq/bpuXT3bF+hCrpYPqZY1xwAOCOUjyiFqC5wk/ykrf87PD9oZXdJAfr+mfXakUrhNKeMt
        36N6tLpRSUQgs/pHahy7NAI1Ycx70QdxQ5+BettDyKUFcQEONkPD3i0F94AIfqxmBSm7Kl
        iAZWSVV+28ze1kQL3raW38q8lpiC7EQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BA77ADDC;
        Tue, 20 Apr 2021 08:28:46 +0000 (UTC)
Date:   Tue, 20 Apr 2021 10:28:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com, rppt@kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YH6QvSuz3hITr2iH@dhcp22.suse.cz>
References: <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
 <07ed1421-89f8-8845-b254-21730207c185@amd.com>
 <YH59E15ztpTTUKqS@dhcp22.suse.cz>
 <b89c84da-65d2-35df-7249-ea8edc0bee9b@amd.com>
 <YH6GyThr2mPrM6h5@dhcp22.suse.cz>
 <2d0e3c44-832b-f297-90da-e2c3280eff32@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d0e3c44-832b-f297-90da-e2c3280eff32@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 20-04-21 10:00:07, Christian König wrote:
> Am 20.04.21 um 09:46 schrieb Michal Hocko:
> > On Tue 20-04-21 09:32:14, Christian König wrote:
> > > Am 20.04.21 um 09:04 schrieb Michal Hocko:
> > > > On Mon 19-04-21 18:37:13, Christian König wrote:
> > > > > Am 19.04.21 um 18:11 schrieb Michal Hocko:
> > [...]
> > > > What I am trying to bring up with NUMA side is that the same problem can
> > > > happen on per-node basis. Let's say that some user consumes unexpectedly
> > > > large amount of dma-buf on a certain node. This can lead to observable
> > > > performance impact on anybody on allocating from that node and even
> > > > worse cause an OOM for node bound consumers. How do I find out that it
> > > > was dma-buf that has caused the problem?
> > > Yes, that is the direction my thinking goes as well, but also even further.
> > > 
> > > See DMA-buf is also used to share device local memory between processes as
> > > well. In other words VRAM on graphics hardware.
> > > 
> > > On my test system here I have 32GB of system memory and 16GB of VRAM. I can
> > > use DMA-buf to allocate that 16GB of VRAM quite easily which then shows up
> > > under /proc/meminfo as used memory.
> > This is something that would be really interesting in the changelog. I
> > mean the expected and extreme memory consumption of this memory. Ideally
> > with some hints on what to do when the number is really high (e.g. mount
> > debugfs and have a look here and there to check whether this is just too
> > many users or an unexpected pattern to be reported).
> > 
> > > But that isn't really system memory at all, it's just allocated device
> > > memory.
> > OK, that was not really clear to me. So this is not really accounted to
> > MemTotal?
> 
> It depends. In a lot of embedded systems you only have system memory and in
> this case that value here is indeed really useful.
> 
> > If that is really the case then reporting it into the oom
> > report is completely pointless and I am not even sure /proc/meminfo is
> > the right interface either. It would just add more confusion I am
> > afraid.
> 
> I kind of agree. As I said a DMA-buf could be backed by system memory or
> device memory.
> 
> In the case when it is backed by system memory it does make sense to report
> this in an OOM dump.
> 
> But only the exporting driver knows what the DMA-buf handle represents, the
> framework just provides the common ground for inter driver communication.

Then those drivers need to account for meminfo/oom report purposes.

> > > > See where I am heading?
> > > Yeah, totally. Thanks for pointing this out.
> > > 
> > > Suggestions how to handle that?
> > As I've pointed out in previous reply we do have an API to account per
> > node memory but now that you have brought up that this is not something
> > we account as a regular memory then this doesn't really fit into that
> > model. But maybe I am just confused.
> 
> Well does that API also has a counter for memory used by device drivers?

I think that "memory used by device drivers" is immaterial. The only
important thing is to account that memory where it makes sense. So for
RAM based allocations to report them via meminfo and find other way to
report device memory allocations.
-- 
Michal Hocko
SUSE Labs
