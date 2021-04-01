Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE123517A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhDARme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhDARkz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0DC0613B7;
        Thu,  1 Apr 2021 05:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=va8qn5g4PgTK88LQPiudtRQop1hpvFRhQHbtOQww9PI=; b=pc69UnNrx8lT1fXY3IIJHGLjw9
        q93oM03GXUqBzcTaPfdYZhCOlexLLekFjKV20iJgC2kpZ3X/EMoQT2BkQznw1mftNPHvZL+nT9S8N
        JV0yQQULvZ/p1kdNmupujYDYg++7rEJ5/6TDBdzIxmLlfqeKAdiIKLq9WPhq5Ahr21SKuLvbu90PO
        rIIg17XTaOT4Mpw2mAVD9iOrEod/ZmxexixoSZUcCfU5nXuN1S8B0JxPesH8jLS5Drxzq82mtKjlb
        uDRep989/fepB+rbmYZtykGVXtL4knJKcE8bk5xGFYu3xReNDHJbnuQp3jvrWjuGayfswf01m1DKJ
        oGagJI4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRw6I-00669P-7s; Thu, 01 Apr 2021 12:07:04 +0000
Date:   Thu, 1 Apr 2021 13:07:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: Re: [PATCH v5 00/27] Memory Folios
Message-ID: <20210401120702.GB351017@casper.infradead.org>
References: <20210320054104.1300774-1-willy@infradead.org>
 <YFja/LRC1NI6quL6@cmpxchg.org>
 <20210322184744.GU1719932@casper.infradead.org>
 <YFqH3B80Gn8pcPqB@cmpxchg.org>
 <20210324062421.GQ1719932@casper.infradead.org>
 <YF4eX/VBPLmontA+@cmpxchg.org>
 <20210329165832.GG351017@casper.infradead.org>
 <YGN8biqigvPP0SGN@cmpxchg.org>
 <20210330210929.GR351017@casper.infradead.org>
 <YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGVUobKUMUtEy1PS@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 05:05:37AM +0000, Al Viro wrote:
> On Tue, Mar 30, 2021 at 10:09:29PM +0100, Matthew Wilcox wrote:
> 
> > That's a very Intel-centric way of looking at it.  Other architectures
> > support a multitude of page sizes, from the insane ia64 (4k, 8k, 16k, then
> > every power of four up to 4GB) to more reasonable options like (4k, 32k,
> > 256k, 2M, 16M, 128M).  But we (in software) shouldn't constrain ourselves
> > to thinking in terms of what the hardware currently supports.  Google
> > have data showing that for their workloads, 32kB is the goldilocks size.
> > I'm sure for some workloads, it's much higher and for others it's lower.
> > But for almost no workload is 4kB the right choice any more, and probably
> > hasn't been since the late 90s.
> 
> Out of curiosity I looked at the distribution of file sizes in the
> kernel tree:
> 71455 files total
> 0--4Kb		36702
> 4--8Kb		11820
> 8--16Kb		10066
> 16--32Kb	6984
> 32--64Kb	3804
> 64--128Kb	1498
> 128--256Kb	393
> 256--512Kb	108
> 512Kb--1Mb	35
> 1--2Mb		25
> 2--4Mb		5
> 4--6Mb		7
> 6--8Mb		4
> 12Mb		2 
> 14Mb		1
> 16Mb		1
> 
> ... incidentally, everything bigger than 1.2Mb lives^Wshambles under
> drivers/gpu/drm/amd/include/asic_reg/

I'm just going to edit this table to add a column indicating ratio
to previous size:

> Page size	Footprint
> 4Kb		1128Mb
> 8Kb		1324Mb		1.17
> 16Kb		1764Mb		1.33
> 32Kb		2739Mb		1.55
> 64Kb		4832Mb		1.76
> 128Kb		9191Mb		1.90
> 256Kb		18062Mb		1.96
> 512Kb		35883Mb		1.98
> 1Mb		71570Mb		1.994
> 2Mb		142958Mb	1.997
> 
> So for kernel builds (as well as grep over the tree, etc.) uniform 2Mb pages
> would be... interesting.

Yep, that's why I opted for a "start out slowly and let readahead tell me
when to increase the page size" approach.

I think Johannes' real problem is that slab and page cache / anon pages
are getting intermingled.  We could solve this by having slab allocate
2MB pages from the page allocator and then split them up internally
(so not all of that 2MB necessarily goes to a single slab cache, but all
of that 2MB goes to some slab cache).
