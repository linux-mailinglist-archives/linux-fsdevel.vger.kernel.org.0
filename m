Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B1076B981
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHAQQq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjHAQQm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE81A7
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690906553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFOWMuiniORO49YwegiVgeiHM1mUI62YaxCFbHJJ65A=;
        b=cF0pi4Rrn5Vow9cylGRut0eituyVduyJkyhBKtVDSgcNw8FQ/nbEU7ins0IHr9Px+tHeyj
        Bs4rhsjARTvHrAWIb+LQgfGh8NOXvTdYqOtG3+k+btfd3TbGuSsROAotXbBaNyIjsXT9s/
        p1sMF/bztKCnRishBS5uHEi3Fbbizvs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-S6LILE7CPMWhwpj-rp67uQ-1; Tue, 01 Aug 2023 12:15:52 -0400
X-MC-Unique: S6LILE7CPMWhwpj-rp67uQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe1dadb5d2so14685615e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Aug 2023 09:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906551; x=1691511351;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFOWMuiniORO49YwegiVgeiHM1mUI62YaxCFbHJJ65A=;
        b=jLjtX7UTDJbKeDTRhszv8oBjNv0dH9Bg5V5FOH7s6Xpl91bWyQSjbsz0pzJSWyPJiN
         PxnMOaV9xCJob38T+w5S8x1TfBBjR3XV4uMfI89VRxIpN47p9ML00reLvPuHHa9Qa8ym
         3P2PzOnj2ZWSJ5vQxykcDfrGWWTYB6GTZGV2YHoAUJSVd7hr7KcW0zfoYE988rRtlcjH
         3janMGa9YBVl4cEYkQBkiTTHkdr5iiiJxBjoHqOAmYua6WT6035SxCq2L2Zlmb2zJzT6
         iz2GAur0opMqS6zzyCHUgogwnZCoTm/+f0K6pT44ot++PLTS9GT0/D9U2WR/J/CnTHK4
         MrDA==
X-Gm-Message-State: ABy/qLYsxWooImgnZxrJHV1ds37tj9wRLV36cU8cSFjiU/Kb7A1mR9QH
        Gz8qhzeA7IFIRb3R2nBXtJDqMgtr5ugr3WYidI4ytIRgNDQlKC54LbW9NO01tejttANyTXZq60u
        ycj1d9X7zwof+M9AB+8PHMt1xGw==
X-Received: by 2002:a05:600c:215a:b0:3fe:1820:2447 with SMTP id v26-20020a05600c215a00b003fe18202447mr2804528wml.21.1690906550838;
        Tue, 01 Aug 2023 09:15:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFevGQtmVAGPlMaUXjii2Ctv0aJTKLmXl6/VsEHj+ZxnwzOQpAFPv/TCZKzFkPu+a5+a4EGfQ==
X-Received: by 2002:a05:600c:215a:b0:3fe:1820:2447 with SMTP id v26-20020a05600c215a00b003fe18202447mr2804514wml.21.1690906550506;
        Tue, 01 Aug 2023 09:15:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:d100:871b:ec55:67d:5247? (p200300cbc705d100871bec55067d5247.dip0.t-ipconnect.de. [2003:cb:c705:d100:871b:ec55:67d:5247])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c025500b003fe1a96845bsm8445619wmj.2.2023.08.01.09.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 09:15:50 -0700 (PDT)
Message-ID: <30d86a2d-4af2-d840-91be-2e68c73a07bd@redhat.com>
Date:   Tue, 1 Aug 2023 18:15:48 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZMkpM95vdc9wgs9T@x1n>
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

On 01.08.23 17:48, Peter Xu wrote:
> On Tue, Aug 01, 2023 at 02:48:37PM +0200, David Hildenbrand wrote:
>> @@ -2240,6 +2244,12 @@ static bool is_valid_gup_args(struct page **pages, int *locked,
>>   		gup_flags |= FOLL_UNLOCKABLE;
>>   	}
>>   
>> +	/*
>> +	 * For now, always trigger NUMA hinting faults. Some GUP users like
>> +	 * KVM really require it to benefit from autonuma.
>> +	 */
>> +	gup_flags |= FOLL_HONOR_NUMA_FAULT;
> 
> Since at it, do we want to not set it for FOLL_REMOTE, which still sounds
> like a good thing to have?

I thought about that, but decided against making that patch here more 
complicated to eventually rip it again all out in #4.

I fully agree that FOLL_REMOTE does not make too much sense, but let's 
rather keep it simple for this patch.


Thanks!

> 
> Other than that, looks good here.
> 
> Side note: when I was looking at the flags again just to check the
> interactions over numa balancing, I found FOLL_NOFAULT and I highly suspect
> that's not needed, instead it just wants to use follow_page[_mask]() with
> some proper gup flags passed over.. but that's off topic.

Be prepared for my proposal of removing foll_flags from follow_page() ;)

(accompanied by a proper documentation)

Especially as we have FOLL_PIN users of FOLL_NOFAULT, follow_page() is a 
bad fit.

-- 
Cheers,

David / dhildenb

