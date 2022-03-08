Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0A4D1473
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 11:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbiCHKMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 05:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiCHKMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:12:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ABB42EEE;
        Tue,  8 Mar 2022 02:11:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C517161512;
        Tue,  8 Mar 2022 10:11:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F770C340EB;
        Tue,  8 Mar 2022 10:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646734286;
        bh=fYSUhe3wecNdmSDhFtYlrEjcl8plDtdT7/KRcR78mg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4nsxISBKCbp0kWFZQFzaUS+y+q3Vc8eNVHhG0Dmv4Nb/JhF26ncQ7Echex+2TBWw
         HzESBnHl4TLrNzabSQGNB7ZbF8RfKTG8YIJq2SApT5oCxEWRfJr2l9JoJPXihK3vfQ
         duy0ns8W9IpIrx2oeLNdvolKx2mHVixqS4CJNaiMHhOoWN2qQZmcekG4CxoSZIyJX4
         EJo+hN5kIQOs94WI2C6ml3xu/HoLZzZhctA1CyAepjY5M6e1IrYFTj5uS071+txQfv
         E2z0+8a/Amxg9QK2hYAnt6jFaeTl8IVajwPvjbBMhdwUfexozvzQDosql+YtSoO6QB
         ViNC/V8kidVXQ==
Date:   Tue, 8 Mar 2022 12:10:45 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Christoph Hellwig' <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthew Auld <matthew.auld@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Chris Wilson <chris@chris-wilson.co.uk>, "G@iki.fi" <G@iki.fi>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        zhangyiru <zhangyiru3@huawei.com>,
        Alexey Gladkov <legion@kernel.org>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "codalist@coda.cs.cmu.edu" <codalist@coda.cs.cmu.edu>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/3] MAP_POPULATE for device memory
Message-ID: <YicrpX9K1dSdCK7u@iki.fi>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <YiSb7tsUEBRGS+HA@casper.infradead.org>
 <YiW4yurDXSifTYUt@infradead.org>
 <YiYIv9guOgClLKT8@iki.fi>
 <YiYrRWMp1akXY8Vb@infradead.org>
 <5729d03d6a174da6b66d1534ebdb1127@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5729d03d6a174da6b66d1534ebdb1127@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:11:19PM +0000, David Laight wrote:
> From: Christoph Hellwig
> > Sent: 07 March 2022 15:57
> > 
> > On Mon, Mar 07, 2022 at 03:29:35PM +0200, Jarkko Sakkinen wrote:
> > > So what would you suggest to sort out the issue? I'm happy to go with
> > > ioctl if nothing else is acceptable.
> > 
> > PLenty of drivers treat all mmaps as if MAP_POPULATE was specified,
> > typically by using (io_)remap_pfn_range.  If there any reason to only
> > optionally have the pre-fault semantics for sgx?  If not this should
> > be really simple.  And if we have a real need for it to be optional
> > we'll just need to find a sane way to pass that information to ->mmap.
> 
> Is there any space in vma->vm_flags ?
> 
> That would be better than an extra argument or function.

It's very dense but I'll give a shot for callback route based on Dave's
comments in this thread. I.e. use it as filter inside __mm_populate() and
populate_vma_page_range().

For Enarx, which we are implementing being able to use MAP_POPULATE and get
the full range EAUG'd would be best way to optimize the performance of wasm
JIT (Enarx is a wasm run-time capable of running inside an SGX enclave, AMD
SEV-SNP VM etc.). More so than any predictor (ra_state, madvice etc.) inside
#PF handler, which have been suggested in this thread.

After some research on how we implement user space, I'd rather keep the #PF
handler working on a single page (EAUG a single page) and have either ioctl
or MAP_POPULATE to do the batch fill.

We can still "not trust the user space" i.e. the populate does not have to
guarantee to do the full length since the #PF handler will then fill the
holes. This was one concern in this thread but it is not hard to address.

BR, Jarkko
