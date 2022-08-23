Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E5D59D260
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238745AbiHWHhF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiHWHhE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0BC642F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661240222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HohlDOM1an5R3Aeg0WJ6GQRtA32+l/PSRz3n64TVcFI=;
        b=QoG+AdmEJFhLTazALmYxXOH4iLtqDgwci802sX/4jdTKKs4NhjaLT9ue+8poTKZKPJXvue
        nmFmdOgkspSXedAXE3I5BMh6OLPQRUNlV1ya9JXx0gqdD0KegS/uqTRaEsMtd4r2rdDQv8
        MdDUr0stYsbatJPckuknEUldl2YOEEU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-4gW0pTJtPfClc7fcaRFOsQ-1; Tue, 23 Aug 2022 03:37:01 -0400
X-MC-Unique: 4gW0pTJtPfClc7fcaRFOsQ-1
Received: by mail-wr1-f72.google.com with SMTP id s20-20020adfbc14000000b002252dae05f7so2042818wrg.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 00:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=HohlDOM1an5R3Aeg0WJ6GQRtA32+l/PSRz3n64TVcFI=;
        b=ZBuUp9UdVKCzllXnySahVHvG6Da96dshxzXv8FL2EBi2Dl00Q973QK5Z6Ni7Un6XnE
         qD3JgZMul5DJbnrtUbUrl+Rx8WCpIqbLVHfaPv7FiMVtcfkYWK/IMWZpjAwCrx+6VxG7
         pQbeXB1LMjkH5D8CerG8eInSolKzoCW3VyzoDmYIfU6uWMv6xNlqQ/UIINW/BYVVf7C/
         dyjJ/tv+Ens8WPNxj/4qunwOvzg5Jtmwf9MK3G4Yrq8O3JNikT2Hp4jRbasIkzI++EtV
         Tww5eOApuuxnm8Ekm/WHA2IGhEZN18fDijyLJAyKr4+JOzuWQJ0cBcERihyqOCLibCI9
         AHRw==
X-Gm-Message-State: ACgBeo1AS9E8VndRw7khNOg9IOY0nRIqUD7XoURTaDruHXLJugRKhQhO
        DwyakAf49MlTzLanWnVP9gNB9hyyWOjS38Fm+T4eMmphIaonN7uozAmSrF2m32j1+NcbPPgfpSR
        /9exGvzed79TUKh5QeXzYNbt2fg==
X-Received: by 2002:a05:600c:4e04:b0:3a5:a34e:ae81 with SMTP id b4-20020a05600c4e0400b003a5a34eae81mr1210652wmq.147.1661240219939;
        Tue, 23 Aug 2022 00:36:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4NUFG4IFicJqv+j50eM5lq6Rzd1ri/9X+RKdy6Bv7oWpP5THIKdol8DYBnS2vZ39y/40KufQ==
X-Received: by 2002:a05:600c:4e04:b0:3a5:a34e:ae81 with SMTP id b4-20020a05600c4e0400b003a5a34eae81mr1210635wmq.147.1661240219655;
        Tue, 23 Aug 2022 00:36:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdb92000000b0021eaf4138aesm16379582wri.108.2022.08.23.00.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 00:36:59 -0700 (PDT)
Message-ID: <8f6f428b-85e6-a188-7f32-512b6aae0abf@redhat.com>
Date:   Tue, 23 Aug 2022 09:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
 <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
 <20220817234120.mw2j3cgshmuyo2vw@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220817234120.mw2j3cgshmuyo2vw@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18.08.22 01:41, Kirill A. Shutemov wrote:
> On Fri, Aug 05, 2022 at 07:55:38PM +0200, Paolo Bonzini wrote:
>> On 7/21/22 11:44, David Hildenbrand wrote:
>>>
>>> Also, I*think*  you can place pages via userfaultfd into shmem. Not
>>> sure if that would count "auto alloc", but it would certainly bypass
>>> fallocate().
>>
>> Yeah, userfaultfd_register would probably have to forbid this for
>> F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for this,
>> adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then userfault_register
>> would do something like memfile_node_get_flags(vma->vm_file) and check the
>> result.
> 
> I donno, memory allocation with userfaultfd looks pretty intentional to
> me. Why would F_SEAL_AUTO_ALLOCATE prevent it?
> 

Can't we say the same about a write()?

> Maybe we would need it in the future for post-copy migration or something?
> 
> Or existing practises around userfaultfd touch memory randomly and
> therefore incompatible with F_SEAL_AUTO_ALLOCATE intent?
> 
> Note, that userfaultfd is only relevant for shared memory as it requires
> VMA which we don't have for MFD_INACCESSIBLE.

This feature (F_SEAL_AUTO_ALLOCATE) is independent of all the lovely
encrypted VM stuff, so it doesn't matter how it relates to MFD_INACCESSIBLE.

-- 
Thanks,

David / dhildenb

