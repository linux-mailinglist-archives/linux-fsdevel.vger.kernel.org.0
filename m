Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296776BADB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjHARLV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjHARLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54722733
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690909800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1l/TRXWCo6q5BSenRhC8N4s4Tp9EqB26+z+WAcvOc7U=;
        b=EHC0cy1NGM8LvfN+M805RlRYXXZdK0COGgZvs/Tzpw9PQf2GPfFj6SacQxOTdElZxc1om7
        1HLQOJaAOrxN9nkF12P/WPKBFAgfgpiyC95nwm/o1Ur+HgitlRnj/5jt7f133Qm9Bo01GP
        UeKsqq4yGpYuyVCKMg5sAudA25pjzWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-TMFLDqziOV6vVMttTsAWqw-1; Tue, 01 Aug 2023 13:09:58 -0400
X-MC-Unique: TMFLDqziOV6vVMttTsAWqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fe25f8c4bfso9615925e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 10:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690909797; x=1691514597;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1l/TRXWCo6q5BSenRhC8N4s4Tp9EqB26+z+WAcvOc7U=;
        b=dVg8uJBkvsnUb7IpL28rD8B3GS58zGGDWKmBaBIVgE3C4dP9UdtO1qHt3YPG/5ImK2
         9JXORcIttZpA1jhU+cNbMf9nr3FxvV10E/r1PTZdH/0NQqVgWyPkq3Iy6Dm1P4XSArv5
         vwkY1mM4s/96ycOrYvlfr9g0TA7qmlbklReqcpfjuTPBBGaJYYvlV710BPhMDy46ZJoZ
         wrleH54LVEVdW3esxIcZxN3nNQLd432LdIhe8woU30wgfcIMR/a8Q8k5/yd7Ghmh2rMy
         aYNwwHYeeuk9PSzjAxaZz92sX8GjNLbwblhzr75ggdE8fuu829l6TyIs/SEPFLWs9aZM
         UkTQ==
X-Gm-Message-State: ABy/qLbN/Su45oFeQGX9CQODlDy49yqQLqtZBFWpgWFZebw1fAB1dTjz
        97KrqJrjgAxd2bCBhDPdJhgaIUZmrupLw6oukfyqgvxIGv2pWLLTvZXFpgo2Gn6+tFirCI5NAA7
        nTf8WXVk1EZUXRRhdPw34xr2k5Q==
X-Received: by 2002:a7b:cc9a:0:b0:3fc:e1:24b5 with SMTP id p26-20020a7bcc9a000000b003fc00e124b5mr2894745wma.23.1690909797588;
        Tue, 01 Aug 2023 10:09:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEy+R1U+qIKux7XS+l+xQITmSgyj55taDV+mQEkAlldXw1fmNp7lyrJvX5NkSWlbviyLnW9yw==
X-Received: by 2002:a7b:cc9a:0:b0:3fc:e1:24b5 with SMTP id p26-20020a7bcc9a000000b003fc00e124b5mr2894727wma.23.1690909797209;
        Tue, 01 Aug 2023 10:09:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id z17-20020a05600c221100b003fe24441e23sm4361391wml.24.2023.08.01.10.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 10:09:56 -0700 (PDT)
Message-ID: <d0edd1f3-4bad-f55a-e4f5-e202bc9d09f5@redhat.com>
Date:   Tue, 1 Aug 2023 19:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/8] mm/gup: reintroduce FOLL_NUMA as
 FOLL_HONOR_NUMA_FAULT
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-2-david@redhat.com> <ZMkpM95vdc9wgs9T@x1n>
 <30d86a2d-4af2-d840-91be-2e68c73a07bd@redhat.com> <ZMk7MqApTDZXzwKX@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMk7MqApTDZXzwKX@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.08.23 19:04, Peter Xu wrote:
> On Tue, Aug 01, 2023 at 06:15:48PM +0200, David Hildenbrand wrote:
>> On 01.08.23 17:48, Peter Xu wrote:
>>> On Tue, Aug 01, 2023 at 02:48:37PM +0200, David Hildenbrand wrote:
>>>> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>>>>    		gup_flags |= FOLL_UNLOCKABLE;
>>>>    	}
>>>> +	/*
>>>> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
>>>> +	 * KVM really require it to benefit from autonuma.
>>>> +	 */
>>>> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
>>>
>>> Since at it, do we want to not set it for FOLL_REMOTE, which still sounds
>>> like a good thing to have?
>>
>> I thought about that, but decided against making that patch here more
>> complicated to eventually rip it again all out in #4.
> 
> I thought that was the whole point of having patch 4 separate, because we
> should assume patch 4 may not exist in (at least) some trees, so I ignored
> patch 4 when commenting here, and we should not assume it's destined to be
> removed here.

For me, the goal of this patch is to bring it *as close as possible* to 
the previous state as before, so we can backport it to stable without 
too many surprises (effectively, only a handful of FOLL_FORCE/ptrace 
user will get a different behavior).

I could add a separate patch that does the FOLL_REMOTE thing, but then, 
maybe we should do that if patch #4 runs into real trouble :)

But no strong opinion if this is what everybody wants in this patch.

> 
>>
>> I fully agree that FOLL_REMOTE does not make too much sense, but let's
>> rather keep it simple for this patch.
> 
> It's fine - I suppose this patch fixes whatever we're aware of that's
> broken with FOLL_NUMA's removal, so it can even be anything on top when
> needed.  I assume I'm happy to ack this with/without that change, then:
> 
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

> 
> PS: I still hope that the other oneliner can be squashed here directly; it
> literally changes exact the same line above so reading this patch alone can
> be affected.  You said there you didn't want the commit message to be too
> long here, but this is definitely not long at all!  I bet you have similar
> understanding to me on defining "long commit message". :) I'd never worry
> that.  Your call.

No strong opinion, it just felt cleaner to not start adding what I have 
in that separate patch commit message in here.

-- 
Cheers,

David / dhildenb

