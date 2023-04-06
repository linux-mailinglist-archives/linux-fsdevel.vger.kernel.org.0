Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B576D9700
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbjDFM2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjDFM17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553CD6EB6
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Apr 2023 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680784034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8VPDq2rzp/RMvuM0GkwvstrEUPv56pcKGMAu1vG79k=;
        b=a9RraZsFPSMrxw+eIFM6tSXZLCksAEJPdO9otz+wClItoboMB533Jmu7iSHRIdscmJYxzA
        Gn3Co7Wwr9CGUAqQpbnymIrsI9GZFV28ShoK+iwUA9D/1oAKjOzjdurmjqpIbQX/aXuwAF
        j0JjoBGkz1qtbwO99FbZufMG216YbEU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-wnXoYxihPi6fB4Ko60Y-7A-1; Thu, 06 Apr 2023 08:27:13 -0400
X-MC-Unique: wnXoYxihPi6fB4Ko60Y-7A-1
Received: by mail-wm1-f69.google.com with SMTP id iv18-20020a05600c549200b003ee21220fccso18242686wmb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Apr 2023 05:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680784032; x=1683376032;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8VPDq2rzp/RMvuM0GkwvstrEUPv56pcKGMAu1vG79k=;
        b=yO9n9hiSqlpZDF+I1+G/jBFcH2DW0SeJbYa9g5ZcBhJgd0ovstR7WwMreVQwJqrDWC
         aoliizxtvBYfTQrZz7rrFs3sLwAcowja3UZFZNamwHkG3y5AibXwpxkK1c3+AQMYDDhi
         R5h1HkGzvgtb6Vi/oRcuJ/hSx2R1hkH+JoNlWTCmeVcUZ5KxZJdNDqEwicy4lWY5ay7I
         BmDfbbPUM6n1JOLFDcBa5CiNR3hMbLmmhBWpfgfCmhZWGper3XEeS3JcwCsMHE4i+Oi4
         zksNQt1FwzZaBkF+MYFtannFeSAGQurQD+vYPA7YkNUJwR3cEIxrveaBggehsRlc+kUo
         Xl/g==
X-Gm-Message-State: AAQBX9c3w8TLTwvkb6xLkJFjBGMj1X4JBJNS+9hnRagoxTQPCbwVuwlZ
        J90t4ci2+hyeSvtbGbrFd7zBs9uEqfJOpK/It81RD3gvkk3Et0HBQZcN8wvDdUE7gf8NTamApjt
        h6UKqS4UHj4osYdW4MCSTKh9t2A==
X-Received: by 2002:a1c:7406:0:b0:3ee:18e:a1ef with SMTP id p6-20020a1c7406000000b003ee018ea1efmr6734885wmc.1.1680784032400;
        Thu, 06 Apr 2023 05:27:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zj5O+SuV6Tw/J9ZVlMtHct578hAy7ZuVMILZV4dGS4JekWIUunN5jJ+9DL6SdhkTn/sDSC0A==
X-Received: by 2002:a1c:7406:0:b0:3ee:18e:a1ef with SMTP id p6-20020a1c7406000000b003ee018ea1efmr6734862wmc.1.1680784031963;
        Thu, 06 Apr 2023 05:27:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003ede03e4369sm5268391wmq.33.2023.04.06.05.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:27:11 -0700 (PDT)
Message-ID: <6ebf38f1-b7c4-cb38-b72f-2e406d2a2fdc@redhat.com>
Date:   Thu, 6 Apr 2023 14:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Kyungsan Kim <ks0204.kim@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        seungjun.ha@samsung.com, wj28.lee@samsung.com
References: <ZCbX6+x1xJ0tnwLw@casper.infradead.org>
 <CGME20230405020027epcas2p4682d43446a493385b60c39a1dbbf07d6@epcas2p4.samsung.com>
 <20230405020027.413578-1-ks0204.kim@samsung.com>
 <642cfda9ccd64_21a8294fd@dwillia2-xfh.jf.intel.com.notmuch>
 <ZC26HpJiBexoIApc@casper.infradead.org>
 <642dcf4169ae5_21a8294f@dwillia2-xfh.jf.intel.com.notmuch>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: FW: [LSF/MM/BPF TOPIC] SMDK inspired MM changes for CXL
In-Reply-To: <642dcf4169ae5_21a8294f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.04.23 21:42, Dan Williams wrote:
> Matthew Wilcox wrote:
>> On Tue, Apr 04, 2023 at 09:48:41PM -0700, Dan Williams wrote:
>>> Kyungsan Kim wrote:
>>>> We know the situation. When a CXL DRAM channel is located under ZONE_NORMAL,
>>>> a random allocation of a kernel object by calling kmalloc() siblings makes the entire CXL DRAM unremovable.
>>>> Also, not all kernel objects can be allocated from ZONE_MOVABLE.
>>>>
>>>> ZONE_EXMEM does not confine a movability attribute(movable or unmovable), rather it allows a calling context can decide it.
>>>> In that aspect, it is the same with ZONE_NORMAL but ZONE_EXMEM works for extended memory device.
>>>> It does not mean ZONE_EXMEM support both movability and kernel object allocation at the same time.
>>>> In case multiple CXL DRAM channels are connected, we think a memory consumer possibly dedicate a channel for movable or unmovable purpose.
>>>>
>>>
>>> I want to clarify that I expect the number of people doing physical CXL
>>> hotplug of whole devices to be small compared to dynamic capacity
>>> devices (DCD). DCD is a new feature of the CXL 3.0 specification where a
>>> device maps 1 or more thinly provisioned memory regions that have
>>> individual extents get populated and depopulated by a fabric manager.
>>>
>>> In that scenario there is a semantic where the fabric manager hands out
>>> 100G to a host and asks for it back, it is within the protocol that the
>>> host can say "I can give 97GB back now, come back and ask again if you
>>> need that last 3GB".
>>
>> Presumably it can't give back arbitrary chunks of that 100GB?  There's
>> some granularity that's preferred; maybe on 1GB boundaries or something?
> 
> The device picks a granularity that can be tiny per spec, but it makes
> the hardware more expensive to track in small extents, so I expect
> something reasonable like 1GB, but time will tell once actual devices
> start showing up.

It all sounds a lot like virtio-mem using real hardware [I know, there 
are important differences, but for the dynamic aspect there are very 
similar issues to solve]

Fir virtio-mem, the current best way to support hotplugging of large 
memory to a VM to eventually be able to unplug a big fraction again is 
using a combination of ZONE_MOVABLE and ZONE_NORMAL -- "auto-movable" 
memory onlining policy. What's online to ZONE_MOVABLE can get (fairly) 
reliably unplugged again. What's onlined to ZONE_NORMAL is possibly lost 
forever.

Like (incrementally) hotplugging 1 TiB to a 4 GiB VM. Being able to 
unplug 1 TiB reliably again is pretty much out of scope. But the more 
memory we can reliably get back the better. And the more memory we can 
get in the common case, the better. With a ZONE_NORMAL vs. ZONE_MOVABLE 
ration of 1:3 on could unplug ~768 GiB again reliably. The remainder 
depends on fragmentation on the actual system and the unplug granularity.

The original plan was to use ZONE_PREFER_MOVABLE as a safety buffer to 
reduce ZONE_NORMAL memory without increasing ZONE_MOVABLE memory (and 
possibly harming the system). The underlying idea was that in many 
setups that memory in ZONE_PREFER_MOVABLE would not get used for 
unmovable allocations and it could, therefore, get unplugged fairly 
reliably in these setups. For all other setups, unmmovable allocations 
could leak into ZONE_PREFER_MOVABLE and reduce the number of memory we 
could unplug again. But the system would try to keep unmovable 
allocations to ZONE_NORMAL, so in most cases with some 
ZONE_PREFER_MOVABLE memory we would perform better than with only 
ZONE_NORMAL.

-- 
Thanks,

David / dhildenb

