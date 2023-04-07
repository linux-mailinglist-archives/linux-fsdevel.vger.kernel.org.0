Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CBD6DA6BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 03:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbjDGBAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 21:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjDGBAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 21:00:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73322727;
        Thu,  6 Apr 2023 18:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680829222; x=1712365222;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=H8PzAq4MZj9y6pQzKtlQnXPgFDTwgOaxbpIxbMFZ55w=;
  b=Y5+NF18k7vFLFyimeH2wdOBj921q0M2Gny318Mrk43snv0xoOu0edzHK
   4NfatJJPBNl4F1gJUdzCVho9EwVtxD3fapc5pCz5MW6B6kJ8osocbGT8p
   teS0oQtHgCzSlDT/QW2d4kJNdkGPXpS89wLOkRBbPdi+hkzrFfgiBUBJ1
   FFmIP2zePsFqLrvaJ8BIMLlW0w0mAjEPWAtlSHvZJWDWslQTJGkQckL74
   oCawbPkT0cKysIaJ760GyHQ2QIGQlS8I7LYCq84T+F4MY4ogpVruzaIti
   TgB1KaYgDh0MjxceoFar0eTrdmLOXshgItq1oGT3YJPq7dBQ95Y5zrgAC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="429171085"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="429171085"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="756524437"
X-IronPort-AV: E=Sophos;i="5.98,324,1673942400"; 
   d="scan'208";a="756524437"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 18:00:19 -0700
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
        <87sfdgywha.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <a81875d6-10d4-6e94-4c21-18dad9f1640e@stancevic.com>
Date:   Fri, 07 Apr 2023 08:58:47 +0800
In-Reply-To: <a81875d6-10d4-6e94-4c21-18dad9f1640e@stancevic.com> (Dragan
        Stancevic's message of "Thu, 6 Apr 2023 17:27:22 -0500")
Message-ID: <87a5zky0c8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dragan Stancevic <dragan@stancevic.com> writes:

> Hi Ying-
>
> On 4/4/23 01:47, Huang, Ying wrote:
>> Dragan Stancevic <dragan@stancevic.com> writes:
>> 
>>> Hi Mike,
>>>
>>> On 4/3/23 03:44, Mike Rapoport wrote:
>>>> Hi Dragan,
>>>> On Thu, Mar 30, 2023 at 05:03:24PM -0500, Dragan Stancevic wrote:
>>>>> On 3/26/23 02:21, Mike Rapoport wrote:
>>>>>> Hi,
>>>>>>
>>>>>> [..] >> One problem we experienced was occured in the combination of
>>>>> hot-remove and kerelspace allocation usecases.
>>>>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>>>>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>>>>>>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>>>>>
>>>>>> This still does not describe what are the use cases that require having
>>>>>> kernel allocations on CXL.mem.
>>>>>>
>>>>>> I believe it's important to start with explanation *why* it is important to
>>>>>> have kernel allocations on removable devices.
>>>>>
>>>>> Hi Mike,
>>>>>
>>>>> not speaking for Kyungsan here, but I am starting to tackle hypervisor
>>>>> clustering and VM migration over cxl.mem [1].
>>>>>
>>>>> And in my mind, at least one reason that I can think of having kernel
>>>>> allocations from cxl.mem devices is where you have multiple VH connections
>>>>> sharing the memory [2]. Where for example you have a user space application
>>>>> stored in cxl.mem, and then you want the metadata about this
>>>>> process/application that the kernel keeps on one hypervisor be "passed on"
>>>>> to another hypervisor. So basically the same way processors in a single
>>>>> hypervisors cooperate on memory, you extend that across processors that span
>>>>> over physical hypervisors. If that makes sense...
>>>> Let me reiterate to make sure I understand your example.
>>>> If we focus on VM usecase, your suggestion is to store VM's memory and
>>>> associated KVM structures on a CXL.mem device shared by several nodes.
>>>
>>> Yes correct. That is what I am exploring, two different approaches:
>>>
>>> Approach 1: Use CXL.mem for VM migration between hypervisors. In this
>>> approach the VM and the metadata executes/resides on a traditional
>>> NUMA node (cpu+dram) and only uses CXL.mem to transition between
>>> hypervisors. It's not kept permanently there. So basically on
>>> hypervisor A you would do something along the lines of migrate_pages
>>> into cxl.mem and then on hypervisor B you would migrate_pages from
>>> cxl.mem and onto the regular NUMA node (cpu+dram).
>>>
>>> Approach 2: Use CXL.mem to cluster hypervisors to improve high
>>> availability of VMs. In this approach the VM and metadata would be
>>> kept in CXL.mem permanently and each hypervisor accessing this shared
>>> memory could have the potential to schedule/run the VM if the other
>>> hypervisor experienced a failure.
>>>
>>>> Even putting aside the aspect of keeping KVM structures on presumably
>>>> slower memory,
>>>
>>> Totally agree, presumption of memory speed dully noted. As far as I am
>>> aware, CXL.mem at this point has higher latency than DRAM, and
>>> switched CXL.mem has an additional latency. That may or may not change
>>> in the future, but even with actual CXL induced latency I think there
>>> are benefits to the approaches.
>>>
>>> In the example #1 above, I think even if you had a very noisy VM that
>>> is dirtying pages at a high rate, once migrate_pages has occurred, it
>>> wouldn't have to be quiesced for the migration to happen. A migration
>>> could basically occur in-between the CPU slices, once VCPU is done
>>> with it's slice on hypervisor A, the next slice could be on hypervisor
>>> B.
>>>
>>> And the example #2 above, you are trading memory speed for
>>> high-availability. Where either hypervisor A or B could run the CPU
>>> load of the VM. You could even have a VM where some of the VCPUs are
>>> executing on hypervisor A and others on hypervisor B to be able to
>>> shift CPU load across hypervisors in quasi real-time.
>>>
>>>
>>>> what ZONE_EXMEM will provide that cannot be accomplished
>>>> with having the cxl memory in a memoryless node and using that node to
>>>> allocate VM metadata?
>>>
>>> It has crossed my mind to perhaps use NUMA node distance for the two
>>> approaches above. But I think that is not sufficient because we can
>>> have varying distance, and distance in itself doesn't indicate
>>> switched/shared CXL.mem or non-switched/non-shared CXL.mem. Strictly
>>> speaking just for myself here, with the two approaches above, the
>>> crucial differentiator in order for #1 and #2 to work would be that
>>> switched/shared CXL.mem would have to be indicated as such in a way.
>>> Because switched memory would have to be treated and formatted in some
>>> kind of ABI way that would allow hypervisors to cooperate and follow
>>> certain protocols when using this memory.
>>>
>>>
>>> I can't answer what ZONE_EXMEM will provide since we haven's seen
>>> Kyungsan's talk yet, that's why I myself was very curious to find out
>>> more about ZONE_EXMEM proposal and if it includes some provisions for
>>> CXL switched/shared memory.
>>>
>>> To me, I don't think it makes a difference if pages are coming from
>>> ZONE_NORMAL, or ZONE_EXMEM but the part that I was curious about was
>>> if I could allocate from or migrate_pages to (ZONE_EXMEM | type
>>> "SWITCHED/SHARED"). So it's not the zone that is crucial for me,  it's
>>> the typing. That's what I meant with my initial response but I guess
>>> it wasn't clear enough, "_if_ ZONE_EXMEM had some typing mechanism, in
>>> my case, this is where you'd have kernel allocations on CXL.mem"
>>>
>> We have 2 choices here.
>> a) Put CXL.mem in a separate NUMA node, with an existing ZONE type
>> (normal or movable).  Then you can migrate pages there with
>> move_pages(2) or migrate_pages(2).  Or you can run your workload on the
>> CXL.mem with numactl.
>> b) Put CXL.mem in an existing NUMA node, with a new ZONE type.  To
>> control your workloads in user space, you need a set of new ABIs.
>> Anything you cannot do in a)?
>
> I like the CXL.mem as a NUMA node approach, and also think it's best
> to do this with move/migrate_pages and numactl and those a & b are
> good choices.
>
> I think there is an option c too though, which is an amalgamation of a
> & b. Here is my thinking, and please do let me know what you think
> about this approach.
>
> If you think about CXL 3.0 shared/switched memory as a portal for a VM
> to move from one hypervisor to another, I think each switched memory 
> should be represented by it's own node and have a distinct type so the
> migration path becomes more deterministic. I was thinking along the 
> lines that there would be some kind of user space clustering/migration
> app/script that runs on all the hypervisors. Which would read, let's
> say /proc/pagetypeinfo to find these "portals":
> Node 4, zone Normal, type Switched ....
> Node 6, zone Normal, type Switched ....
>
> Then it would build a traversal Graph, find per hypervisor reach and
> critical connections, where critical connections are cross-rack or 
> cross-pod, perhaps something along the lines of this pseudo/python code:
> class Graph:
> 	def __init__(self, mydict):
> 		self.dict = mydict
> 		self.visited = set()
> 		self.critical = list()
> 		self.reach = dict()
> 		self.id = 0
> 	def depth_first_search(self, vertex, parent):
> 		self.visited.add(vertex)
> 		if vertex not in self.reach:
> 			self.reach[vertex] = {'id':self.id, 'reach':self.id}
> 			self.id += 1
> 		for next_vertex in self.dict[vertex] - {parent}:
> 			if next_vertex not in self.visited:
> 				self.depth_first_search(next_vertex, vertex)
> 			if self.reach[next_vertex]['reach'] < self.reach[vertex]['reach']:
> 				self.reach[vertex]['reach'] = self.reach[next_vertex]['reach']
> 		if parent != None and self.reach[vertex]['id'] ==
> 		self.reach[vertex]['reach']:
> 			self.critical.append([parent, vertex])
> 		return self.critical
>
> critical = mygraph.depth_first_search("hostname-foo4", None)
>
> that way you could have a VM migrate between only two hypervisors
> sharing switched memory, or pass through a subset of hypervisors (that 
> don't necessarily share switched memory) to reach it's
> destination. This may be rack confined, or across a rack or even a pod
> using critical connections.
>
> Long way of saying that if you do a) then the clustering/migration
> script only sees a bunch of nodes and a bunch of normal zones it 
> wouldn't know how to build the "flight-path" and where to send a
> VM. You'd probably have to add an additional interface in the kernel
> for the script to query the paths somehow, where on the other hand
> pulling things from proc/sys is easy.
>
>
> And then if you do b) and put it in an existing NUMA and with a
> "Switched" type, you could potentially end up with several "Switched" 
> types under the same node. So when you numactl/move/migrate pages they
> could go in either direction and you could send some pages through one 
> "portal" and others through another "portal", which is not what you
> want to do.
>
> That's why I think the c option might be the most optimal, where each
> switched memory has it's own node number. And then displaying type as 
> "Switched" just makes it easier to detect and Graph the topology.
>
>
> And with regards to an ABI, I was referring to an ABI needed between
> the kernels running on separate hypervisors. When hypervisor B boots,
> it needs to detect through an ABI if this switched/shared memory is
> already initialized and if there are VMs in there which are used by
> another hypervisor, say A. Also during the migration, hypervisors A
> and B would have to use this ABI to synchronize the hand-off between
> the two physical hosts. Not an all-inclusive list, but I was referring
> to those types of scenarios.
>
> What do you think?

It seems unnecessary to add a new zone type to mark a node with some
attribute.  For example, in the following patch, a per-node attribute
can be added and shown in sysfs.

https://lore.kernel.org/linux-mm/20220704135833.1496303-10-martin.fernandez@eclypsium.com/

Best Regards,
Huang, Ying
