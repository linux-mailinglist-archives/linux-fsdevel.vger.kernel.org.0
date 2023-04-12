Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0286DF36D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 13:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDLL2a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjDLL2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C427684
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681298817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFstME57OpFndVBoorjybpUh09Bom8GSKJlx74kUL/g=;
        b=VhGpaVud2K+yIHc17Ze+Ir4pBkH4sZwWWhxXu0rxtzmoVbOgttGmbIaoWMFwecaxoaCKAb
        p6UhPWHtbiS3EI4lPUXLXArIkpYtV17k03XiGK9F2NLNuE0Qf1AMJMfcL9tR16dz0oVBP8
        F3+tesQeu8R0L5hsPrWCmLVa7OpntfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-jbqrtWy4OGGrPgWTLHptZw-1; Wed, 12 Apr 2023 07:26:55 -0400
X-MC-Unique: jbqrtWy4OGGrPgWTLHptZw-1
Received: by mail-wm1-f71.google.com with SMTP id l20-20020a05600c4f1400b003f0a04fe9b9so273885wmq.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 04:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298814; x=1683890814;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFstME57OpFndVBoorjybpUh09Bom8GSKJlx74kUL/g=;
        b=oRQSv4HvvpJzm6u/ysUC0sG3r6LBy4NjFcz7JiCMP7PTRtMFo26Y8FfRiM0KvboXOm
         O4zpRcmIAmgPtYnBLuajLxWPoFjxFXSVCEyy3meAzDBKkQmIpARnDvzC92iKwoul3egf
         bNWDcVdufnlXKPHyV3qxzdD60qibwpyGGwA030aL0gQDr7JlqBxRAY1n0aqbmfgrBON/
         ak2I7hA+b/eYLjGPrNJe8twMhodVrqgfCVpMbBQ1sh+a1fT1+u5BPdsVXqTZY6zggSDD
         eOeMbZn20Sbg02Jh1VlJYhx4TuAAdY6kL6GaA4eqVNJz/tBKUTp+o+T8UCvUpN8Bn9yR
         eDqw==
X-Gm-Message-State: AAQBX9c2aLYsAFe8j6yNwWQIWxjVVTWDIZgNn61SHI19DlHfJrLI3TEH
        8TOJEQ6jfwXK/GPl2JC3Lg6hxQ9em6uBIYPBGkLDZfC+GAFVwqrrotgIJoFaX+/gcaz1AK9kH+Y
        aGE5hFjcVPAk6Rw5R58YzK4s/r3Ixi570XA==
X-Received: by 2002:adf:cd8b:0:b0:2cc:459b:8bc8 with SMTP id q11-20020adfcd8b000000b002cc459b8bc8mr11934600wrj.6.1681298814478;
        Wed, 12 Apr 2023 04:26:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350bKiPtn0M7N9Ns7kjv5Eqgc5pVwSYAJTLw8hVIz9qZoH9v7bIi2Kp/ypGNnNQvysM+4xb4xkw==
X-Received: by 2002:adf:cd8b:0:b0:2cc:459b:8bc8 with SMTP id q11-20020adfcd8b000000b002cc459b8bc8mr11934589wrj.6.1681298814088;
        Wed, 12 Apr 2023 04:26:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id x18-20020adfec12000000b002f2b8cb5d9csm5056882wrn.28.2023.04.12.04.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 04:26:53 -0700 (PDT)
Message-ID: <f9432319-4df8-00c2-e6df-c0a69932e7e7@redhat.com>
Date:   Wed, 12 Apr 2023 13:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: FW: [LSF/MM/BPF TOPIC] BoF VM live migration over CXL memory
Content-Language: en-US
To:     Kyungsan Kim <ks0204.kim@samsung.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
        a.manzanares@samsung.com, viacheslav.dubeyko@bytedance.com,
        dan.j.williams@intel.com, seungjun.ha@samsung.com,
        wj28.lee@samsung.com
References: <f4f9eedf-c514-3388-29ad-dcb497a19303@redhat.com>
 <CGME20230412111034epcas2p1b46d2a26b7d3ac5db3b0e454255527b0@epcas2p1.samsung.com>
 <20230412111033.434644-1-ks0204.kim@samsung.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230412111033.434644-1-ks0204.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12.04.23 13:10, Kyungsan Kim wrote:
>>> Gregory Price <gregory.price@memverge.com> writes:
>>>
>>>> On Tue, Apr 11, 2023 at 02:37:50PM +0800, Huang, Ying wrote:
>>>>> Gregory Price <gregory.price@memverge.com> writes:
>>>>>
>>>>> [snip]
>>>>>
>>>>>> 2. During the migration process, the memory needs to be forced not to be
>>>>>>      migrated to another node by other means (tiering software, swap,
>>>>>>      etc).  The obvious way of doing this would be to migrate and
>>>>>>      temporarily pin the page... but going back to problem #1 we see that
>>>>>>      ZONE_MOVABLE and Pinning are mutually exclusive.  So that's
>>>>>>      troublesome.
>>>>>
>>>>> Can we use memory policy (cpusets, mbind(), set_mempolicy(), etc.) to
>>>>> avoid move pages out of CXL.mem node?  Now, there are gaps in tiering,
>>>>> but I think it is fixable.
>>>>>
>>>>> Best Regards,
>>>>> Huang, Ying
>>>>>
>>>>> [snip]
>>>>
>>>> That feels like a hack/bodge rather than a proper solution to me.
>>>>
>>>> Maybe this is an affirmative argument for the creation of an EXMEM
>>>> zone.
>>>
>>> Let's start with requirements.  What is the requirements for a new zone
>>> type?
>>
>> I'm stills scratching my head regarding this. I keep hearing all
>> different kind of statements that just add more confusions "we want it
>> to be hotunpluggable" "we want to allow for long-term pinning memory"
>> "but we still want it to be movable" "we want to place some unmovable
>> allocations on it". Huh?
>>
>> Just to clarify: ZONE_MOVABLE allows for pinning. It just doesn't allow
>> for long-term pinning of memory.
>>
>> For good reason, because long-term pinning of memory is just the worst
>> (memory waste, fragmentation, overcommit) and instead of finding new
>> ways to *avoid* long-term pinnings, we're coming up with advanced
>> concepts to work-around the fundamental property of long-term pinnings.
>>
>> We want all memory to be long-term pinnable and we want all memory to be
>> movable/hotunpluggable. That's not going to work.
> 
> Looks there is misunderstanding about ZONE_EXMEM argument.
> Pinning and plubbability is mutual exclusive so it can not happen at the same time.
> What we argue is ZONE_EXMEM does not "confine movability". an allocation context can determine the movability attribute.
> Even one unmovable allocation will make the entire CXL DRAM unpluggable.
> When you see ZONE_EXMEM just on movable/unmoable aspect, we think it is the same with ZONE_NORMAL,
> but ZONE_EXMEM works on an extended memory, as of now CXL DRAM.
> 
> Then why ZONE_EXMEM is, ZONE_EXMEM considers not only the pluggability aspect, but CXL identifier for user/kenelspace API,
> the abstraction of multiple CXL DRAM channels, and zone unit algorithm for CXL HW characteristics.
> The last one is potential at the moment, though.
> 
> As mentioned in ZONE_EXMEM thread, we are preparing slides to explain experiences and proposals.
> It it not final version now[1].
> [1] https://github.com/OpenMPDK/SMDK/wiki/93.-%5BLSF-MM-BPF-TOPIC%5D-SMDK-inspired-MM-changes-for-CXL

Yes, hopefully we can discuss at LSF/MM also the problems we are trying 
to solve instead of focusing on one solution. [did not have the time to 
look at the slides yet, sorry]

-- 
Thanks,

David / dhildenb

