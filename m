Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C666DC7A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Apr 2023 16:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjDJOLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Apr 2023 10:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDJOLc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:11:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4428C211E
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Apr 2023 07:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eiCcYEWIB87jLLdts+JRmXomsXEzMRopRm+6D+Npf4I=; b=po93Wz3WVFN4U5e8lMUOLHeSro
        Uy6gRtjvBoBQ8fC10wH7G1eljI+THqkYS43rrXircOqjbLNTIPbaedwOMEbwOgNNnByXHpXg1Rwzo
        iS3U7wUyp47lxaP2wrKmUfJcT1/m0n/qldmK6i1VrFD8KlhxXqw0ifXXb40BKaLQ3CBzGCBeHC9TA
        LLy8I6eg6dNjVThmm1tE6t+5lXL+OYal8bgiaSk0KC8b7s286FuPUsu+LREw88CRvndwdATtmys80
        q8NXfbWoQPV5fB1ICKAHRhABfO5BjlR2FFkeFi1lztjwyWy8TnKX+vO+wAm2txDh9i5hmG3Ps5p5f
        jq3QiKBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1plsEn-004FSp-J0; Mon, 10 Apr 2023 14:11:17 +0000
Date:   Mon, 10 Apr 2023 15:11:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Agrawal, Punit" <punit.agrawal@bytedance.com>
Subject: Re: [PATCH 6/6] mm: Run the fault-around code under the VMA lock
Message-ID: <ZDQZBdJNiG0lIw2v@casper.infradead.org>
References: <20230404135850.3673404-1-willy@infradead.org>
 <20230404135850.3673404-7-willy@infradead.org>
 <ZCxA+DYkzVWbLAod@casper.infradead.org>
 <1c700db59114617ca0a7b6e40754a6ea0dbb86e0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c700db59114617ca0a7b6e40754a6ea0dbb86e0.camel@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 10, 2023 at 04:53:19AM +0000, Yin, Fengwei wrote:
> On Tue, 2023-04-04 at 16:23 +0100, Matthew Wilcox wrote:
> > On Tue, Apr 04, 2023 at 02:58:50PM +0100, Matthew Wilcox (Oracle)
> > wrote:
> > > The map_pages fs method should be safe to run under the VMA lock
> > > instead
> > > of the mmap lock.  This should have a measurable reduction in
> > > contention
> > > on the mmap lock.
> > 
> > https://github.com/antonblanchard/will-it-scale/pull/37/files should
> > be a good microbenchmark to report numbers from.  Obviously real-
> > world
> > benchmarks will be more compelling.
> > 
> 
> Test result in my side with page_fault4 of will-it-scale in thread 
> mode is:
>   15274196 (without the patch) -> 17291444 (with the patch)
> 
> 13.2% improvement on a Ice Lake with 48C/96T + 192G RAM + ext4 
> filesystem.

Thanks!  That is really good news.

> The perf showed the mmap_lock contention reduced a lot:
> (Removed the grandson functions of do_user_addr_fault()) 
> 
> latest linux-next with the patch:
>     51.78%--do_user_addr_fault
>             |          
>             |--49.09%--handle_mm_fault
>             |--1.19%--lock_vma_under_rcu
>             --1.09%--down_read
> 
> latest linux-next without the patch:
>     73.65%--do_user_addr_fault
>             |          
>             |--28.65%--handle_mm_fault
>             |--17.22%--down_read_trylock
>             |--10.92%--down_read
>             |--9.20%--up_read
>             --7.30%--find_vma
> 
> My understanding is down_read_trylock, down_read and up_read all are
> related with mmap_lock. So the mmap_lock contention reduction is quite
> obvious.

Absolutely.  I'm a little surprised that find_vma() basically disappeared
from the perf results.  I guess that it was cache cold after contending
on the mmap_lock rwsem.  But this is a very encouraging result.
