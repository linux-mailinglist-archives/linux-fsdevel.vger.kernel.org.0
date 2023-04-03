Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDFC6D3F55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjDCIo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjDCIop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:44:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BA901F;
        Mon,  3 Apr 2023 01:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E126B815B8;
        Mon,  3 Apr 2023 08:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F63C433EF;
        Mon,  3 Apr 2023 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511469;
        bh=rcNTkexBq3Q+uJyB3j6QpUz1kVSfgLh2+uusgW7/vik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=athY3XDRKOfxSL5sGLnDLlGzre4UmRyr1xaYX9FpdWCv+iyibHSeO+JqhP5tfpvBp
         AsWg7CGZzp2vcQY4jZAbSmmtiZ92SK6bfW7/Bz0PQLeraEQQU483gjwuHdADaSJuoA
         kgI2jW9Lo7p56UaSfv2c1etvhGJ9kyL6o6GuFZXqekORJFwQRKzxyjUGu4olLqM0Yn
         kR9FM0/wQLmiCN3AnanGE6blZPurvXcCDzZcOeZc1qiin92YzvdOnt1n88FVpIF7/V
         Y591H2k+t4U4mLMIXhtBqBOVX4cL0QvUUvca9lmtX05Km670+t/EuWCVyJkkqBsxO2
         xkWojXuUymQ+w==
Date:   Mon, 3 Apr 2023 11:44:23 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>, dan.j.williams@intel.com,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        ying.huang@intel.com, nil-migration@lists.linux.dev
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Message-ID: <ZCqR55Ryrewmy6Bo@kernel.org>
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
 <ZB/yb9n6e/eNtNsf@kernel.org>
 <362a9e19-fea5-e45a-3c22-3aa47e851aea@stancevic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <362a9e19-fea5-e45a-3c22-3aa47e851aea@stancevic.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dragan,

On Thu, Mar 30, 2023 at 05:03:24PM -0500, Dragan Stancevic wrote:
> On 3/26/23 02:21, Mike Rapoport wrote:
> > Hi,
> > 
> > [..] >> One problem we experienced was occured in the combination of
> hot-remove and kerelspace allocation usecases.
> > > ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
> > > ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
> > > Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
> > > In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
> > > We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
> > > As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
> > > So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
> > 
> > This still does not describe what are the use cases that require having
> > kernel allocations on CXL.mem.
> > 
> > I believe it's important to start with explanation *why* it is important to
> > have kernel allocations on removable devices.
> 
> Hi Mike,
> 
> not speaking for Kyungsan here, but I am starting to tackle hypervisor
> clustering and VM migration over cxl.mem [1].
> 
> And in my mind, at least one reason that I can think of having kernel
> allocations from cxl.mem devices is where you have multiple VH connections
> sharing the memory [2]. Where for example you have a user space application
> stored in cxl.mem, and then you want the metadata about this
> process/application that the kernel keeps on one hypervisor be "passed on"
> to another hypervisor. So basically the same way processors in a single
> hypervisors cooperate on memory, you extend that across processors that span
> over physical hypervisors. If that makes sense...

Let me reiterate to make sure I understand your example.
If we focus on VM usecase, your suggestion is to store VM's memory and
associated KVM structures on a CXL.mem device shared by several nodes.  
Even putting aside the aspect of keeping KVM structures on presumably
slower memory, what ZONE_EXMEM will provide that cannot be accomplished
with having the cxl memory in a memoryless node and using that node to
allocate VM metadata?
 
> [1] A high-level explanation is at http://nil-migration.org
> [2] Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, figure
> 1-4, black color scheme circle(3) and bars.
> 
> --
> Peace can only come as a natural consequence
> of universal enlightenment -Dr. Nikola Tesla
> 

-- 
Sincerely yours,
Mike.
