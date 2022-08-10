Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B030858EA1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiHJJza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiHJJz1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68F56286FD
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660125325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5UKomJJr5XDUN8t2Kmb7khiadiUQsrzaj90s+j66gQ=;
        b=XauGWYwm2YHllDCVya8h3dh2VCxcMp2eXLrGwCCuukmjOLrdAx5dk/CMcpX/u+Lxbe24xF
        6/yzLXImuFsBVkN5tVXkNKcIczY4r9o46GIbAr0lLA4DDNQc4p7aNcS4wjx+f70N3f13Je
        hmRhx8eqHVUmTxMEGhGKI3mOSI+l6LM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-1wk7g00QMGufq-iDWPFKFg-1; Wed, 10 Aug 2022 05:55:23 -0400
X-MC-Unique: 1wk7g00QMGufq-iDWPFKFg-1
Received: by mail-wm1-f71.google.com with SMTP id 9-20020a1c0209000000b003a53ae8015bso866340wmc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 02:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=m5UKomJJr5XDUN8t2Kmb7khiadiUQsrzaj90s+j66gQ=;
        b=4/t4Y0zmvPDjoU5GcmcZJwWI67d/1x8CZkQZHgsYV32S24mZNkty+1Q8UUcFPu6im3
         4wiIjHoP2pLmhbJ0+BfApj34i2bBB+vZjjbU/3985KAqB1+/C+YiUU7nNoamxLMyZ+eW
         tPesNZ9PWb4CPQMv1v1SlHgSSvPp6RmBs3urS/uXYGRU6C7AHYhFGUJnRgHAjw81EmEw
         e9v3/HX/w5aCWGKJWUBiN/b3D7IVLJ/KgsE7Q/jieoz5NXoAj8M2yBBKhUKHERpe124s
         ub+mSjLHSFhVEbAdPxnhZ6zQ7A5/GiVx3LUBkwETptfYjMFgOEwprS3mWuYC6OeuI9ps
         i/KA==
X-Gm-Message-State: ACgBeo1VVPe0G7fHKzzTTcMsdQYmd7DEGGMe9zst/PD3xRXQuDpBrn7a
        C463GEs6iaaiJAeTFNoQvIlha+tlPPN2pHIbBejx/+FaTPj4GGsnEjn07LR/tTziq5kFfsQvA8N
        IbqaOvRan81al6sG6o8mxeaq4CQ==
X-Received: by 2002:a5d:64e4:0:b0:222:d4da:c2e1 with SMTP id g4-20020a5d64e4000000b00222d4dac2e1mr7468909wri.15.1660125322308;
        Wed, 10 Aug 2022 02:55:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR57ng+8LAmFqiWIYkxzU0qIaLTw96OSbpCj25JDzNCtyJxE1FXqxz6BaUC8mUFwvCSeHhucCg==
X-Received: by 2002:a5d:64e4:0:b0:222:d4da:c2e1 with SMTP id g4-20020a5d64e4000000b00222d4dac2e1mr7468880wri.15.1660125322007;
        Wed, 10 Aug 2022 02:55:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b003a4bb3f9bc6sm1837127wmq.41.2022.08.10.02.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:55:21 -0700 (PDT)
Message-ID: <64ab9678-c72d-b6d9-8532-346cc9c06814@redhat.com>
Date:   Wed, 10 Aug 2022 11:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 05/14] mm/memfd: Introduce MFD_INACCESSIBLE flag
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
 <20220706082016.2603916-6-chao.p.peng@linux.intel.com>
 <203c752f-9439-b5ae-056c-27b2631dcb81@redhat.com>
 <20220810093741.GE862421@chaop.bj.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220810093741.GE862421@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.08.22 11:37, Chao Peng wrote:
> On Fri, Aug 05, 2022 at 03:28:50PM +0200, David Hildenbrand wrote:
>> On 06.07.22 10:20, Chao Peng wrote:
>>> Introduce a new memfd_create() flag indicating the content of the
>>> created memfd is inaccessible from userspace through ordinary MMU
>>> access (e.g., read/write/mmap). However, the file content can be
>>> accessed via a different mechanism (e.g. KVM MMU) indirectly.
>>>
>>> It provides semantics required for KVM guest private memory support
>>> that a file descriptor with this flag set is going to be used as the
>>> source of guest memory in confidential computing environments such
>>> as Intel TDX/AMD SEV but may not be accessible from host userspace.
>>>
>>> The flag can not coexist with MFD_ALLOW_SEALING, future sealing is
>>> also impossible for a memfd created with this flag.
>>
>> It's kind of weird to have it that way. Why should the user have to
>> care? It's the notifier requirement to have that, no?
>>
>> Why can't we handle that when register a notifier? If anything is
>> already mapped, fail registering the notifier if the notifier has these
>> demands. If registering succeeds, block it internally.
>>
>> Or what am I missing? We might not need the memfile set flag semantics
>> eventually and would not have to expose such a flag to user space.
> 
> This makes sense if doable. The major concern was: is there a reliable
> way to detect this (already mapped) at the time of memslot registering.

If too complicated, we could simplify to "was this ever mapped" and fail
for now. Hooking into shmem_mmap() might be sufficient for that to get
notified about the first mmap.

As an alternative, mapping_mapped() or similar *might* do what we want.



-- 
Thanks,

David / dhildenb

