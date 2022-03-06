Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106854CEC4D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 17:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiCFQyR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Mar 2022 11:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiCFQyQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Mar 2022 11:54:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5A24D26B;
        Sun,  6 Mar 2022 08:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F1F160ECA;
        Sun,  6 Mar 2022 16:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F83C340EC;
        Sun,  6 Mar 2022 16:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646585602;
        bh=MsFvCvDm3Ch69LnmbtaI1I9nqbcwEoILGdlAPzIetO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y914rtUiHzXvBnz643r24P9/50ijdnH21BhkmMXNdPFnctYpw+CGGwkjiSO4OwtXJ
         cIj6IDXTGuX4ok/Azkkkz4yPB4UiDiPEI3ZnY1KuetY2NlaSDCT4alak24MLKqMMWT
         81w5Bw17iwZvWhZno4RxV9EAK9enO5SHr8ultMzE3oiqsv18m8lefFW9p7UhVw52Rl
         P6T7XXKOZbWsN36s081JMMyXiGRVG5ePMhoUhLaFZ1j0EZtYdQz3Yxv9v0DV/r8mqd
         A923uLtITDotkTWx1rpjNsEoRnRjJwbB7SjCx/NcIAi4R8U3aH/UB0N3Tz2bKFyora
         Nys80UhGrEPVg==
Date:   Sun, 6 Mar 2022 18:52:41 +0200
From:   'Jarkko Sakkinen' <jarkko@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        Chris Wilson <chris@chris-wilson.co.uk>,
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
Message-ID: <YiTm2b8KTRUsDkC0@iki.fi>
References: <20220306053211.135762-1-jarkko@kernel.org>
 <7f46ef3c80734f478501d21cef0182c5@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f46ef3c80734f478501d21cef0182c5@AcuMS.aculab.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 08:30:14AM +0000, David Laight wrote:
> From: Jarkko Sakkinen
> > Sent: 06 March 2022 05:32
> > 
> > For device memory (aka VM_IO | VM_PFNMAP) MAP_POPULATE does nothing. Allow
> > to use that for initializing the device memory by providing a new callback
> > f_ops->populate() for the purpose.
> > 
> > SGX patches are provided to show the callback in context.
> > 
> > An obvious alternative is a ioctl but it is less elegant and requires
> > two syscalls (mmap + ioctl) per memory range, instead of just one
> > (mmap).
> 
> Is this all about trying to stop the vm_operations_struct.fault()
> function being called?

In SGX protected memory is actually encrypted normal memory and CPU access
control semantics (marked as reserved, e.g. struct page's).

In SGX you need call ENCLS[EAUG] outside the protected memory to add new
pages to the protected memory. Then when CPU is executing inside this
protected memory, also known as enclaves, it commits the memory as part of
the enclave either with ENCLU[EACCEPT] or ENCLU[EACCEPTCOPY].

So the point is not prevent page faults but to prepare the memory for
pending state so that the enclave can then accept them without round-trips,
and in some cases thus improve performance (in our case in enarx.dev
platform that we are developing).

In fact, #PF handler in SGX driver in the current SGX2 patch set also does
EAUG on-demand. Optimal is to have both routes available. And said, this
can be of course also implemented as ioctl.

BR, Jarkko
