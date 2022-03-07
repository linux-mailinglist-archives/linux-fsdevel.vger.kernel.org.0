Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1A44D0393
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbiCGP7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiCGP7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:59:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA46338AB;
        Mon,  7 Mar 2022 07:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B06B81627;
        Mon,  7 Mar 2022 15:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52D7C340E9;
        Mon,  7 Mar 2022 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646668726;
        bh=W5kqratoVSRl9NEd4VE6Iu3BSqv9ulKVQPHP1qdhNvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aurmVE6NZjU7sOJJ+E50h+AIed6RxvrashOmy+xb2DcYubmVUquVyy5I9fekqFNX5
         Cj+DSIerBr9haVVQWprk2CNueZQDWhPWsYbjZnFm5soSe9mGKZABgiP7UB87yme/N4
         6EPfyNphy7nkrwusx8woJNJVhhRtzd+KdAwnPwTkOb1R7gnVSFeh7a2JW9/ViytEVh
         Q601UbynX2V3G3LMpsywSlFS/RXL1A8v1EyttbFgnIXyJHWxWdXHy8L4t6dm0RnGNZ
         1nhf2OPJo2RASPa3NwFjwplBGb8ddISaD7ZUdDcGoU3Lc8nvMUP2jl9oHK4F7hlT1g
         hFXST0Agp0K8w==
Date:   Mon, 7 Mar 2022 17:58:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>, G@iki.fi,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-mips@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
Message-ID: <YiYrjRW/Qmoq8c+L@iki.fi>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <YiSb7tsUEBRGS+HA@casper.infradead.org>
 <YiW4yurDXSifTYUt@infradead.org>
 <YiYIv9guOgClLKT8@iki.fi>
 <YiYrRWMp1akXY8Vb@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYrRWMp1akXY8Vb@infradead.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:56:53AM -0800, Christoph Hellwig wrote:
> On Mon, Mar 07, 2022 at 03:29:35PM +0200, Jarkko Sakkinen wrote:
> > So what would you suggest to sort out the issue? I'm happy to go with
> > ioctl if nothing else is acceptable.
> 
> PLenty of drivers treat all mmaps as if MAP_POPULATE was specified,
> typically by using (io_)remap_pfn_range.  If there any reason to only
> optionally have the pre-fault semantics for sgx?  If not this should
> be really simple.  And if we have a real need for it to be optional
> we'll just need to find a sane way to pass that information to ->mmap.

Dave, what if mmap() would just unconditionally EAUG after initialization?

It's an option, yes.

BR, Jarkko
