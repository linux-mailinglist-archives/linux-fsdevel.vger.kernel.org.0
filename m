Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056146D5AEF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjDDIb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDDIb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16645A8;
        Tue,  4 Apr 2023 01:31:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8B9F61689;
        Tue,  4 Apr 2023 08:31:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10ECC433D2;
        Tue,  4 Apr 2023 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680597083;
        bh=iruvF61gWTN0Vg96KJHTh6O2xF0lYRK04YezfwLzB7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxQSkEMXR1/79xtLVurLzzoxr8ryGCcBNrj4iWtEEFauIwdIeHWTxMQmyTaNUo+Ck
         /oEtyVbc21eYYlVUFOEM1LX6RDdLwSmJ1MA35oKHzHUHZtH6VyeY4fkuXvKQX0Aq5D
         NsIU/x6FyacPIRhnxlnzSKkx0Wa8S24chPaEfoJebH7dag5pB6FxWMPTTnGs4udR3q
         HAvpqKmU9R3/MQ9qI3LFf9PCBo36h+AGdC01GIDo3ahFZgJdPujUsHEmHmHa7peZjK
         93OkPi2hNwnkcMh6In2OFRjUAr+HlUQVD3pGtgUd6poQ1YhodKxMNTXdC9TqQeICqa
         FZptQy2ei1PDw==
Date:   Tue, 4 Apr 2023 11:31:08 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
Subject: Re: RE: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for
 CXL
Message-ID: <ZCvgTA5uk/HcyMAk@kernel.org>
References: <ZB/yb9n6e/eNtNsf@kernel.org>
 <CGME20230331114526epcas2p2b6f1d4c8c1c0b2e3c12a425b6e48c0d8@epcas2p2.samsung.com>
 <20230331114525.400375-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331114525.400375-1-ks0204.kim@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 08:45:25PM +0900, Kyungsan Kim wrote:
> Thank you Mike Rapoport for participating discussion and adding your thought.
> 
> >Hi,
> >
> >On Thu, Mar 23, 2023 at 07:51:05PM +0900, Kyungsan Kim wrote:
> >> I appreciate dan for the careful advice.
> >> 
> >> >Kyungsan Kim wrote:
> >> >[..]
> >> >> >In addition to CXL memory, we may have other kind of memory in the
> >> >> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
> >> >> >memory in GPU card, etc.  I guess that we need to consider them
> >> >> >together.  Do we need to add one zone type for each kind of memory?
> >> >> 
> >> >> We also don't think a new zone is needed for every single memory
> >> >> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
> >> >> manage multiple volatile memory devices due to the increased device
> >> >> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
> >> >> represent extended volatile memories that have different HW
> >> >> characteristics.
> >> >
> >> >Some advice for the LSF/MM discussion, the rationale will need to be
> >> >more than "we think the ZONE_EXMEM can be used to represent extended
> >> >volatile memories that have different HW characteristics". It needs to
> >> >be along the lines of "yes, to date Linux has been able to describe DDR
> >> >with NUMA effects, PMEM with high write overhead, and HBM with improved
> >> >bandwidth not necessarily latency, all without adding a new ZONE, but a
> >> >new ZONE is absolutely required now to enable use case FOO, or address
> >> >unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
> >> >maintainability concern of "fewer degress of freedom in the ZONE
> >> >dimension" starts to dominate.
> >> 
> >> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
> >> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
> >> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
> >> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
> >> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
> >> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
> >> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
> >> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
> >
> >This still does not describe what are the use cases that require having
> >kernel allocations on CXL.mem. 
> >
> >I believe it's important to start with explanation *why* it is important to
> >have kernel allocations on removable devices.
> > 
> 
> In general, a memory system with DDR/CXL DRAM will have near/far memory.
> And, we think kernel already includes memory tiering solutions - Meta TPP, zswap, and pagecache.
> Some kernel contexts would prefer fast memory. For example, a hot data with time locality or a data for fast processing such as metadata or indexing.
> Others would enough with slow memory. For example, a zswap page which is being used while swapping. 

The point of zswap IIUC is to have small and fast swap device and
compression is required to better utilize DRAM capacity at expense of CPU
time.

Presuming CXL memory will have larger capacity than DRAM, why not skip the
compression and use CXL as a swap device directly? 

And even supposing there's an advantage in putting zswap on CXL memory,
why that can be done with node-based APIs but warrants a new zone?

-- 
Sincerely yours,
Mike.
