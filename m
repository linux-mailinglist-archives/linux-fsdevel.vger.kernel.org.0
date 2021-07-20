Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A893CFE6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhGTPRS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbhGTOxu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:53:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A5C0613DB;
        Tue, 20 Jul 2021 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YMJtZl0zXHIg/quYkGxZ124m2IPJSkonaupGUSsz4Eg=; b=LmHCNdtnyQmWHaZa+nyfYJ9TbM
        hlWkq/nRtQ+gQeZBatFJyw8v5ISxlLOHOrPJOZGpGTscR2vBu0ynTY3otLp/O+0DYdo8AHvH9U1OZ
        CexnBvS9QvhGiyRDsimnFgbK0ffkcFhiBi2Nd/J3FW3NMJVoA1HoCZm+gXjwm92SEfPQDFlGEXviJ
        pGMDTHuSUXpsgvPaE8lGNpGaIJO1+MGDWFs0FYYGgjWcj4IJVs7dkg2h16lwDhXQivyHSMclIAm7I
        289weZ1G+Pa2nUUXhyiKPNb7YoHelS2rbxk2G76taXCJ3U0GT1/o6oJz/VyD1GcaLXsgjEuAiLOFb
        5ihwf5wA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5raj-008Feq-29; Tue, 20 Jul 2021 15:23:41 +0000
Date:   Tue, 20 Jul 2021 16:23:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 000/138] Memory folios
Message-ID: <YPbqcQ9i/Vi7ivEE@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YParbk8LxhrZMExc@kernel.org>
 <YPbEax52N7OBQCZp@casper.infradead.org>
 <YPbpBv30NqeQPqPK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPbpBv30NqeQPqPK@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 06:17:26PM +0300, Mike Rapoport wrote:
> On Tue, Jul 20, 2021 at 01:41:15PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 20, 2021 at 01:54:38PM +0300, Mike Rapoport wrote:
> > > Most of the changelogs (at least at the first patches) mention reduction of
> > > the kernel size for your configuration on x86. I wonder, what happens if
> > > you build the kernel with "non-distro" configuration, e.g. defconfig or
> > > tiny.config?
> > 
> > I did an allnoconfig build and that reduced in size by ~2KiB.
> > 
> > > Also, what is the difference on !x86 builds?
> > 
> > I don't generally do non-x86 builds ... feel free to compare for
> > yourself!
> 
> I did allnoconfig and defconfig for arm64 and powerpc.
> 
> All execpt arm64::defconfig show decrease by ~1KiB, while arm64::defconfig
> was actually increased by ~500 bytes.

Which patch did you go up to for that?  If you're going past patch 50 or
so, then you're starting to add functionality (ie support for arbitrary
order pages), so a certain amount of extra code size might be expected.
I measured 6KB at patch 32 or so, then between patch 32 & 50 was pretty
much a wash.

> I didn't dig into objdumps yet.
> 
> I also tried to build arm but it failed with:
> 
>   CC      fs/remap_range.o
> fs/remap_range.c: In function 'vfs_dedupe_file_range_compare':
> fs/remap_range.c:250:3: error: implicit declaration of function 'flush_dcache_folio'; did you mean 'flush_cache_louis'? [-Werror=implicit-function-declaration]
>   250 |   flush_dcache_folio(src_folio);
>       |   ^~~~~~~~~~~~~~~~~~
>       |   flush_cache_louis
> cc1: some warnings being treated as errors

Already complained about by the build bot; already fixed.  You should
maybe look at the git tree if you're doing more than code review.
