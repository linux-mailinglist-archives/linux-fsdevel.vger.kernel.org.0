Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E096D578B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 06:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjDDEf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 00:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjDDEf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:35:27 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F821BF5;
        Mon,  3 Apr 2023 21:35:24 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 664FA920A42;
        Tue,  4 Apr 2023 04:27:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a294.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C792E920ED4;
        Tue,  4 Apr 2023 04:27:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680582429; a=rsa-sha256;
        cv=none;
        b=Fn8EozMTPb1R/DvADxzRoFXg39jtYKeMjbki0PyEbwEpW0qZjZvDSw2dGgepLXOUwpWk8j
        fpuWQEjz4dTl7BqAKQTfZr1sv1EG/mvMCfOU+PSh1zzpXCA62RNr/EBlAuu1KdqYoIKKjn
        EBldSy+2+3TDmvu6tNdKBiXLo5iKWzRlkYVaQMTKE+1IcWelCNbYrkXfEY0s6OQ73QXnJb
        LRfzSbpHoK+sH3KBdiAF9lje/3qEmUgFaJW6mjFgwjj6ME3YothWZqd3jGZiNwxAKlPviu
        0f+VtlCjctzIHzjAM1KVKU/DQy1LAbslN97tA3TB1L2xcNln+4AUqfHWid7Zsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680582429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=CF9FicUMWtv9bSMayochbShUK9RldiignDBxLbYauzs=;
        b=8YQdxZAM38aL07VtWYLMnRcGDx4aQv3ry7VYvtWDunPl1c6tmQwLiD0d3BNor9vO30cESo
        vOkCmBn3ctOta4+a4H0vGvB9NpnaYsGk7jRKufJ44fL1ScHpB0u50bU9u/IF8Nbw44T5RL
        2ACHW/XReE3g05ESnpoxKnCdqNQ+X9MSbMkzHU3g10x2E7q2IZejWcW/5tTPqHntQiO39p
        YrKQw7P5STxzhgB7gz5mEpsVxaZlQM+eupY1GG8mhQfKOCymvhiaEWoocTd3w8aUsDg7LN
        fogalavUCSFdiRjiDopQl7YlC3RRbE/Vr5Qp13sf9+6Tn7oN1rcYcrEqYAgewg==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-qqssp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Supply-Continue: 5ad618ec37c341c5_1680582430209_3758986715
X-MC-Loop-Signature: 1680582430209:577629720
X-MC-Ingress-Time: 1680582430209
Received: from pdx1-sub0-mail-a294.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.253.211 (trex/6.7.2);
        Tue, 04 Apr 2023 04:27:10 +0000
Received: from [192.168.1.31] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a294.dreamhost.com (Postfix) with ESMTPSA id 4PrF8r3HQgz1B;
        Mon,  3 Apr 2023 21:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1680582429;
        bh=CF9FicUMWtv9bSMayochbShUK9RldiignDBxLbYauzs=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=LKUNngcXAXmSMQjBnyZyfgukZomSvDb7nCRr9toxNqWdwThDf+DjE/gYEH/nyc2Mj
         E8iAgtP9EBgGoS7iFmX7RLk2a4avOElBS13OqjSBP1wbsa/Vtis3aZGxBT7CWQyB2H
         RkpUWgg/BVZREzsDHuKaryPzt/P1XuDieVNdHLtI25+DHy2EL5xcPiYUTfSuHFcNjb
         5qgdIruW1NT6h2htlM1GXgoOLL2Zzv1Vy1otQU7Z3IIKiZdYs01k1fmayG4YLKluGi
         /0oFgOTGIyWLxk8TqIt2o2Wmqm5bv5DMC29i1W9wPkxG/9Og/4o874u86K4r5UzMod
         J3bV1ioGkpz1Q==
Message-ID: <81baa7f2-6c95-5225-a675-71d1290032f0@stancevic.com>
Date:   Mon, 3 Apr 2023 23:27:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>, dan.j.williams@intel.com,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        ying.huang@intel.com, nil-migration@lists.linux.dev
References: <641b7b2117d02_1b98bb294cb@dwillia2-xfh.jf.intel.com.notmuch>
 <CGME20230323105106epcas2p39ea8de619622376a4698db425c6a6fb3@epcas2p3.samsung.com>
 <20230323105105.145783-1-ks0204.kim@samsung.com>
 <ZB/yb9n6e/eNtNsf@kernel.org>
 <362a9e19-fea5-e45a-3c22-3aa47e851aea@stancevic.com>
 <ZCqR55Ryrewmy6Bo@kernel.org>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ZCqR55Ryrewmy6Bo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mike,

On 4/3/23 03:44, Mike Rapoport wrote:
> Hi Dragan,
> 
> On Thu, Mar 30, 2023 at 05:03:24PM -0500, Dragan Stancevic wrote:
>> On 3/26/23 02:21, Mike Rapoport wrote:
>>> Hi,
>>>
>>> [..] >> One problem we experienced was occured in the combination of
>> hot-remove and kerelspace allocation usecases.
>>>> ZONE_NORMAL allows kernel context allocation, but it does not allow hot-remove because kernel resides all the time.
>>>> ZONE_MOVABLE allows hot-remove due to the page migration, but it only allows userspace allocation.
>>>> Alternatively, we allocated a kernel context out of ZONE_MOVABLE by adding GFP_MOVABLE flag.
>>>> In case, oops and system hang has occasionally occured because ZONE_MOVABLE can be swapped.
>>>> We resolved the issue using ZONE_EXMEM by allowing seletively choice of the two usecases.
>>>> As you well know, among heterogeneous DRAM devices, CXL DRAM is the first PCIe basis device, which allows hot-pluggability, different RAS, and extended connectivity.
>>>> So, we thought it could be a graceful approach adding a new zone and separately manage the new features.
>>>
>>> This still does not describe what are the use cases that require having
>>> kernel allocations on CXL.mem.
>>>
>>> I believe it's important to start with explanation *why* it is important to
>>> have kernel allocations on removable devices.
>>
>> Hi Mike,
>>
>> not speaking for Kyungsan here, but I am starting to tackle hypervisor
>> clustering and VM migration over cxl.mem [1].
>>
>> And in my mind, at least one reason that I can think of having kernel
>> allocations from cxl.mem devices is where you have multiple VH connections
>> sharing the memory [2]. Where for example you have a user space application
>> stored in cxl.mem, and then you want the metadata about this
>> process/application that the kernel keeps on one hypervisor be "passed on"
>> to another hypervisor. So basically the same way processors in a single
>> hypervisors cooperate on memory, you extend that across processors that span
>> over physical hypervisors. If that makes sense...
> 
> Let me reiterate to make sure I understand your example.
> If we focus on VM usecase, your suggestion is to store VM's memory and
> associated KVM structures on a CXL.mem device shared by several nodes.

Yes correct. That is what I am exploring, two different approaches:

Approach 1: Use CXL.mem for VM migration between hypervisors. In this 
approach the VM and the metadata executes/resides on a traditional NUMA 
node (cpu+dram) and only uses CXL.mem to transition between hypervisors. 
It's not kept permanently there. So basically on hypervisor A you would 
do something along the lines of migrate_pages into cxl.mem and then on 
hypervisor B you would migrate_pages from cxl.mem and onto the regular 
NUMA node (cpu+dram).

Approach 2: Use CXL.mem to cluster hypervisors to improve high 
availability of VMs. In this approach the VM and metadata would be kept 
in CXL.mem permanently and each hypervisor accessing this shared memory 
could have the potential to schedule/run the VM if the other hypervisor 
experienced a failure.

> Even putting aside the aspect of keeping KVM structures on presumably
> slower memory, 

Totally agree, presumption of memory speed dully noted. As far as I am 
aware, CXL.mem at this point has higher latency than DRAM, and switched 
CXL.mem has an additional latency. That may or may not change in the 
future, but even with actual CXL induced latency I think there are 
benefits to the approaches.

In the example #1 above, I think even if you had a very noisy VM that is 
dirtying pages at a high rate, once migrate_pages has occurred, it 
wouldn't have to be quiesced for the migration to happen. A migration 
could basically occur in-between the CPU slices, once VCPU is done with 
it's slice on hypervisor A, the next slice could be on hypervisor B.

And the example #2 above, you are trading memory speed for 
high-availability. Where either hypervisor A or B could run the CPU load 
of the VM. You could even have a VM where some of the VCPUs are 
executing on hypervisor A and others on hypervisor B to be able to shift 
CPU load across hypervisors in quasi real-time.


> what ZONE_EXMEM will provide that cannot be accomplished
> with having the cxl memory in a memoryless node and using that node to
> allocate VM metadata?

It has crossed my mind to perhaps use NUMA node distance for the two 
approaches above. But I think that is not sufficient because we can have 
varying distance, and distance in itself doesn't indicate 
switched/shared CXL.mem or non-switched/non-shared CXL.mem. Strictly 
speaking just for myself here, with the two approaches above, the 
crucial differentiator in order for #1 and #2 to work would be that 
switched/shared CXL.mem would have to be indicated as such in a way. 
Because switched memory would have to be treated and formatted in some 
kind of ABI way that would allow hypervisors to cooperate and follow 
certain protocols when using this memory.


I can't answer what ZONE_EXMEM will provide since we haven's seen 
Kyungsan's talk yet, that's why I myself was very curious to find out 
more about ZONE_EXMEM proposal and if it includes some provisions for 
CXL switched/shared memory.

To me, I don't think it makes a difference if pages are coming from 
ZONE_NORMAL, or ZONE_EXMEM but the part that I was curious about was if 
I could allocate from or migrate_pages to (ZONE_EXMEM | type 
"SWITCHED/SHARED"). So it's not the zone that is crucial for me,  it's 
the typing. That's what I meant with my initial response but I guess it 
wasn't clear enough, "_if_ ZONE_EXMEM had some typing mechanism, in my 
case, this is where you'd have kernel allocations on CXL.mem"


Sorry if it got long, hope that makes sense... :)


>   
>> [1] A high-level explanation is at http://nil-migration.org
>> [2] Compute Express Link Specification r3.0, v1.0 8/1/22, Page 51, figure
>> 1-4, black color scheme circle(3) and bars.
>>



--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla
