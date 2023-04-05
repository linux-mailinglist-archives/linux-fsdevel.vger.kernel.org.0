Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1766D85C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjDESNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjDESNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:13:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AA6581;
        Wed,  5 Apr 2023 11:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A1OvYUgP4FG9EQlktdUAjWwsZKNpPiqegresn/FLTXw=; b=jMd1255as8B3cu19099m7uTzR4
        +PK3TbWYZOHCxqYFSPrIXmyCD+B9rjxZjSVmYctrshO+gGCqvA3Ad5sT0Oy5UnH+sVK0a98/q66T3
        eILt8SACBMmEEglX6LWK3NejoAFlReV92ipO+TWoa61avFcm3OTQ55cf1NBn8sae+VRYgoiRCwMNk
        XFKkinkcjWg4OFuW9KBud6Y41ITwsfRPduZ6claAyA2sfc2Zf9gmUupYKiNuD25MMNNmGt93rnUex
        COVlRUnCECa4eNvW4vxZzsq+nvl+LdZoyxERjiTdbwHd+Z+yf6Fb3qOyra1SPy7r0psMH9blQHOtE
        7kgDwY1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pk7ck-00Gcqk-Uw; Wed, 05 Apr 2023 18:12:46 +0000
Date:   Wed, 5 Apr 2023 19:12:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
Subject: Re: Re: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes
 for CXL
Message-ID: <ZC26HpJiBexoIApc@casper.infradead.org>
References: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
 <CGME20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6@epcas2p4.samsung.com>
 <20230405020027.413578-1-ks0204.kim@samsung.com>
 <642cfda9ccd64_21a8294fd@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642cfda9ccd64_21a8294fd@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:48:41PM -0700, Dan Williams wrote:
> Kyungsan Kim wrote:
> > We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
> > a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
> > Also, not all kernel objects can be allocated from ZONE_MOVABLE.
> > 
> > ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
> > In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
> > It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
> > In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.
> > 
> 
> I want to clarify that I expect the number of people doing physical CXL
> hotplug of whole devices to be small compared to dynamic capacity
> devices (DCD). DCD is a new feature of the CXL 3.0 specification where a
> device maps 1 or more thinly provisioned memory regions that have
> individual extents get populated and depopulated by a fabric manager.
> 
> In that scenario there is a semantic where the fabric manager hands out
> 100G to a host and asks for it back, it is within the protocol that the
> host can say "I can give 97GB back now, come back and ask again if you
> need that last 3GB".

Presumably it can't give back arbitrary chunks of that 100GB?  There's
some granularity that's preferred; maybe on 1GB boundaries or something?

> In other words even pinned pages in ZONE_MOVABLE are not fatal to the
> flow. Alternatively, if a deployment needs 100% guarantees that the host
> will return all the memory it was assigned when asked there is always
> the option to keep that memory out of the page allocator and just access
> it via a device. That's the role device-dax plays for "dedicated" memory
> that needs to be set aside from kernel allocations.
> 
> This is to say something like ZONE_PREFER_MOVABLE semantics can be
> handled within the DCD protocol, where 100% unpluggability is not
> necessary and 97% is good enough.

This certainly makes life better (and rather more like hypervisor
shrinking than like DIMM hotplug), but I think fragmentation may well
result in "only 3GB of 100GB allocated" will result in being able to
return less than 50% of the memory, depending on granule size and
exactly how the allocations got chunked.
