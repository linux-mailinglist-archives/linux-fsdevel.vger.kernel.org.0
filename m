Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74A6D58E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 08:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjDDGsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDDGsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:48:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEABC1FC7;
        Mon,  3 Apr 2023 23:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680590933; x=1712126933;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=PjJgdWrwZgxiLagwtkRn+xzvUwkUZzEFWyx3CfgywsY=;
  b=eLCfIqAeO4NZdPiVNED/HwNJvl1luyQ45O1iPQUK2/zNkFWC/eWF/R+0
   JQVAfosh0ehj62YYFBsubt6DEgZFhe8J/5NL/sEfAqo5twRxtqjxYya5r
   nTC8Y5qrHzhLE80KmdYsRbXda1GiYJOLgpIehQSC/akcSWDdJ94ah76n2
   yd3ZjtbtrIn45Hge7D3qeWZ/JfgjxIIvkLUIU9+Uvm2E2HhJGrtoWD4u5
   fpG+KaZTJYl91NBx56Gvwh/7OJ+gSAEf/FAiFoz+28fLy70JMTGVZRqEc
   +r+K/11A2LvHdPaDh8VetBEzzFiVeCfDJbBVlwpVWrvqiVPafx4XGlg+L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="369918490"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="369918490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 23:48:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="829860923"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400"; 
   d="scan'208";a="829860923"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 23:48:50 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Dragan Stancevic <dragan@stancevic.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        dan.j.williams@intel.com, lsf-pc@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        viacheslav.dubeyko@bytedance.com, nil-migration@lists.linux.dev
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
        <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
        <20230323105105.145783-1-ks0204.kim@samsung.com>
        <ZB/yb9n6e/eNtNsf@kernel.org>
        <362a9e19-fea5-e45a-3c22-3aa47e851aea@stancevic.com>
        <ZCqR55Ryrewmy6Bo@kernel.org>
        <81baa7f2-6c95-5225-a675-71d1290032f0@stancevic.com>
Date:   Tue, 04 Apr 2023 14:47:45 +0800
In-Reply-To: <81baa7f2-6c95-5225-a675-71d1290032f0@stancevic.com> (Dragan
        Stancevic's message of "Mon, 3 Apr 2023 23:27:07 -0500")
Message-ID: <87sfdgywha.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dragan Stancevic <dragan@stancevic.com> writes:

> Hi Mike,
>
> On 4/3/23 03:44, Mike Rapoport wrote:
>> Hi Dragan,
>> On Thu, Mar 30, 2023 at 05:03:24PM -0500, Dragan Stancevic wrote:
>>> On 3/26/23 02:21, Mike Rapoport wrote:
>>>> Hi,
>>>>
>>>> [..] >> One problem we experienced was occured in the combination of
>>> hot-remove and kerelspace allocation usecases.
>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>>>>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>>>
>>>> This still does not describe what are the use cases that require having
>>>> kernel allocations on CXL.mem.
>>>>
>>>> I believe it's important to start with explanation *why* it is important to
>>>> have kernel allocations on removable devices.
>>>
>>> Hi Mike,
>>>
>>> not speaking for Kyungsan here, but I am starting to tackle hypervisor
>>> clustering and VM migration over cxl.mem [1].
>>>
>>> And in my mind, at least one reason that I can think of having kernel
>>> allocations from cxl.mem devices is where you have multiple VH connections
>>> sharing the memory [2]. Where for example you have a user space application
>>> stored in cxl.mem, and then you want the metadata about this
>>> process/application that the kernel keeps on one hypervisor be "passed on"
>>> to another hypervisor. So basically the same way processors in a single
>>> hypervisors cooperate on memory, you extend that across processors that span
>>> over physical hypervisors. If that makes sense...
>> Let me reiterate to make sure I understand your example.
>> If we focus on VM usecase, your suggestion is to store VM's memory and
>> associated KVM structures on a CXL.mem device shared by several nodes.
>
> Yes correct. That is what I am exploring, two different approaches:
>
> Approach 1: Use CXL.mem for VM migration between hypervisors. In this
> approach the VM and the metadata executes/resides on a traditional
> NUMA node (cpu+dram) and only uses CXL.mem to transition between
> hypervisors. It's not kept permanently there. So basically on
> hypervisor A you would do something along the lines of migrate_pages
> into cxl.mem and then on hypervisor B you would migrate_pages from
> cxl.mem and onto the regular NUMA node (cpu+dram).
>
> Approach 2: Use CXL.mem to cluster hypervisors to improve high
> availability of VMs. In this approach the VM and metadata would be
> kept in CXL.mem permanently and each hypervisor accessing this shared
> memory could have the potential to schedule/run the VM if the other
> hypervisor experienced a failure.
>
>> Even putting aside the aspect of keeping KVM structures on presumably
>> slower memory, 
>
> Totally agree, presumption of memory speed dully noted. As far as I am
> aware, CXL.mem at this point has higher latency than DRAM, and
> switched CXL.mem has an additional latency. That may or may not change
> in the future, but even with actual CXL induced latency I think there
> are benefits to the approaches.
>
> In the example #1 above, I think even if you had a very noisy VM that
> is dirtying pages at a high rate, once migrate_pages has occurred, it 
> wouldn't have to be quiesced for the migration to happen. A migration
> could basically occur in-between the CPU slices, once VCPU is done
> with it's slice on hypervisor A, the next slice could be on hypervisor
> B.
>
> And the example #2 above, you are trading memory speed for
> high-availability. Where either hypervisor A or B could run the CPU
> load of the VM. You could even have a VM where some of the VCPUs are 
> executing on hypervisor A and others on hypervisor B to be able to
> shift CPU load across hypervisors in quasi real-time.
>
>
>> what ZONE_EXMEM will provide that cannot be accomplished
>> with having the cxl memory in a memoryless node and using that node to
>> allocate VM metadata?
>
> It has crossed my mind to perhaps use NUMA node distance for the two
> approaches above. But I think that is not sufficient because we can
> have varying distance, and distance in itself doesn't indicate 
> switched/shared CXL.mem or non-switched/non-shared CXL.mem. Strictly
> speaking just for myself here, with the two approaches above, the 
> crucial differentiator in order for #1 and #2 to work would be that
> switched/shared CXL.mem would have to be indicated as such in a way. 
> Because switched memory would have to be treated and formatted in some
> kind of ABI way that would allow hypervisors to cooperate and follow 
> certain protocols when using this memory.
>
>
> I can't answer what ZONE_EXMEM will provide since we haven's seen
> Kyungsan's talk yet, that's why I myself was very curious to find out 
> more about ZONE_EXMEM proposal and if it includes some provisions for
> CXL switched/shared memory.
>
> To me, I don't think it makes a difference if pages are coming from
> ZONE_NORMAL, or ZONE_EXMEM but the part that I was curious about was
> if I could allocate from or migrate_pages to (ZONE_EXMEM | type 
> "SWITCHED/SHARED"). So it's not the zone that is crucial for me,  it's
> the typing. That's what I meant with my initial response but I guess
> it wasn't clear enough, "_if_ ZONE_EXMEM had some typing mechanism, in
> my case, this is where you'd have kernel allocations on CXL.mem"
>

We have 2 choices here.

a) Put CXL.mem in a separate NUMA node, with an existing ZONE type
(normal or movable).  Then you can migrate pages there with
move_pages(2) or migrate_pages(2).  Or you can run your workload on the
CXL.mem with numactl.

b) Put CXL.mem in an existing NUMA node, with a new ZONE type.  To
control your workloads in user space, you need a set of new ABIs.
Anything you cannot do in a)?

Best Regards,
Huang, Ying
