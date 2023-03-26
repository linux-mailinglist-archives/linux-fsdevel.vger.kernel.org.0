Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3F6C92FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Mar 2023 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCZHVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Mar 2023 03:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCZHVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Mar 2023 03:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B49A27B;
        Sun, 26 Mar 2023 00:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E1A60DEA;
        Sun, 26 Mar 2023 07:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E90C4339C;
        Sun, 26 Mar 2023 07:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679815293;
        bh=pxji88z27H0PgsSBucqTZmQTQyn/hGoPa6A+2B7kyW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoEL8Z115aro/jpVXBgeGYPwcL9BwfsejvL0g41x465R0UnGpA/zXlecUoU/yWn7y
         FLAWi9tECSA30YB/defwKA1auizlk4JfbZGWhFQpo1CW3Q+vuOHYMMPC0F/4h3Rt9G
         kIz/PUvmxiDxUuD7JkrkvEIrsyLpuDUAttNypHcnRQMO15p8DLcAmIKs4Nutqcbrvc
         jA8BlJz8+l4sSO0AOYNTkkAausD233l0C8SM0ckC1E61TrL9ZpOD/+wCpOcEf3so0c
         E2fA+c2E61WU8z6CZMzAhQ7uhKq01nPM+pessiFEIY4wTolXBimWtb+rTwW10a3shX
         DsFZ/xPvK0fUA==
Date:   Sun, 26 Mar 2023 10:21:19 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     dan.j.williams@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, ying.huang@intel.com
Subject: Re: RE(2): FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZB/yb9n6e/eNtNsf@kernel.org>
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323105105.145783-1-ks0204.kim@samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Mar 23, 2023 at 07:51:05PM +0900, Kyungsan Kim wrote:
> I appreciate dan for the careful advice.
> 
> >Kyungsan Kim wrote:
> >[..]
> >> >In addition to CXL memory, we may have other kind of memory in the
> >> >system, for example, HBM (High Bandwidth Memory), memory in FPGA card,
> >> >memory in GPU card, etc.  I guess that we need to consider them
> >> >together.  Do we need to add one zone type for each kind of memory?
> >> 
> >> We also don't think a new zone is needed for every single memory
> >> device.  Our viewpoint is the sole ZONE_NORMAL becomes not enough to
> >> manage multiple volatile memory devices due to the increased device
> >> types.  Including CXL DRAM, we think the ZONE_EXMEM can be used to
> >> represent extended volatile memories that have different HW
> >> characteristics.
> >
> >Some advice for the LSF/MM discussion, the rationale will need to be
> >more than "we think the ZONE_EXMEM can be used to represent extended
> >volatile memories that have different HW characteristics". It needs to
> >be along the lines of "yes, to date Linux has been able to describe DDR
> >with NUMA effects, PMEM with high write overhead, and HBM with improved
> >bandwidth not necessarily latency, all without adding a new ZONE, but a
> >new ZONE is absolutely required now to enable use case FOO, or address
> >unfixable NUMA problem BAR." Without FOO and BAR to discuss the code
> >maintainability concern of "fewer degress of freedom in the ZONE
> >dimension" starts to dominate.
> 
> One problem we experienced was occured in the combination of hot-remove and kerelspace allocation usecases.
> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.

This still does not describe what are the use cases that require having
kernel allocations on CXL.mem. 

I believe it's important to start with explanation *why* it is important to
have kernel allocations on removable devices.
 
> Kindly let me know any advice or comment on our thoughts.
> 
> 

-- 
Sincerely yours,
Mike.
