Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A366E57C817
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 11:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbiGUJuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 05:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiGUJux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38B9B7E811
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 02:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658397051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CO7yqSOqdsoA6FvkegluY8/8ZAYmjQUUu2UI2GMdWBk=;
        b=g0t9sncE7mdImJqYQm7BmbGU86Il0rQ1sVbdiBpMUoWAfy5pZXY1GE88FS+32Sd7qNg4Sw
        Zzy6cXugq5N30Uh1qIY7rV1HILKAMn8JQrhO3VRNE/h+b7KfFasKXMhy8C/Hp20zBxFUhn
        cTr+5fnAQoAB7sGOtSL6UfpB0T3MRwM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-J3DxSkBPM9i5WqMbgsZJ3g-1; Thu, 21 Jul 2022 05:50:49 -0400
X-MC-Unique: J3DxSkBPM9i5WqMbgsZJ3g-1
Received: by mail-wm1-f69.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so471433wmb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 02:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=CO7yqSOqdsoA6FvkegluY8/8ZAYmjQUUu2UI2GMdWBk=;
        b=EYlPD7qDXLhG3dyeI7nYs+aFQTAFoxe6hzU+8g1Hef4AQ4W8dVB193ozg+Mr0ScPbT
         5PqOpB45sAAaaZPO1ORKY/mqTjfrO/obU6rLClxKYYkUQlbp7BmGXOfWYoGj7XDQmfGi
         9ZVs8xLRVY/QD+dUWhOwTqd6WUFjDQBneuk7wOWc1UXlbCkTBdWs81YM31WKati/2k+H
         p0o98PWrNWNqs6lO1xw42t3yIhp5q/sTTvHgZxNhgOnfwaNtkq7u6hfAvx66sTBV9Ng8
         D+IvahQ+eK5A4eskwjNB6EwjfLCGHmgN+AQfGULkYAITeoTtQb3Uia/F+CS8xLNSJleD
         JGlA==
X-Gm-Message-State: AJIora9JXU2zm6frYNayW2i5rJ1vt4EnRAgfLqPqqL8c8FDTU4UgeEoM
        H+f/rBnDEPlaz/wxVNLc4cOzNYTF8fNVnSJJpozV08UBsmpNFW+SqXOvE1M9eGH1srYw5nh5ari
        FU2Dgu4SY8T6blW/b+hoeAiIH6w==
X-Received: by 2002:a05:600c:cd:b0:3a3:f40:8776 with SMTP id u13-20020a05600c00cd00b003a30f408776mr7645484wmm.9.1658397048696;
        Thu, 21 Jul 2022 02:50:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uts89nDIOzg3pgovfDVxNFStA298ovCBRrYUGQIqDJzEAWNm0lSXxPmyA4m/lsmvtQcMdkAw==
X-Received: by 2002:a05:600c:cd:b0:3a3:f40:8776 with SMTP id u13-20020a05600c00cd00b003a30f408776mr7645440wmm.9.1658397048195;
        Thu, 21 Jul 2022 02:50:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:e000:25d3:15fa:4c8b:7e8d? (p200300cbc707e00025d315fa4c8b7e8d.dip0.t-ipconnect.de. [2003:cb:c707:e000:25d3:15fa:4c8b:7e8d])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003a31b00c216sm1340719wms.0.2022.07.21.02.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:50:47 -0700 (PDT)
Message-ID: <39067d09-b32b-23a6-ae0e-00ac2fe0466c@redhat.com>
Date:   Thu, 21 Jul 2022 11:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
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
 <20220706082016.2603916-2-chao.p.peng@linux.intel.com>
 <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
Organization: Red Hat
In-Reply-To: <f39c4f63-a511-4beb-b3a4-66589ddb5475@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21.07.22 11:44, David Hildenbrand wrote:
> On 06.07.22 10:20, Chao Peng wrote:
>> Normally, a write to unallocated space of a file or the hole of a sparse
>> file automatically causes space allocation, for memfd, this equals to
>> memory allocation. This new seal prevents such automatically allocating,
>> either this is from a direct write() or a write on the previously
>> mmap-ed area. The seal does not prevent fallocate() so an explicit
>> fallocate() can still cause allocating and can be used to reserve
>> memory.
>>
>> This is used to prevent unintentional allocation from userspace on a
>> stray or careless write and any intentional allocation should use an
>> explicit fallocate(). One of the main usecases is to avoid memory double
>> allocation for confidential computing usage where we use two memfds to
>> back guest memory and at a single point only one memfd is alive and we
>> want to prevent memory allocation for the other memfd which may have
>> been mmap-ed previously. More discussion can be found at:
>>
>>   https://lkml.org/lkml/2022/6/14/1255
>>
>> Suggested-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> ---
>>  include/uapi/linux/fcntl.h |  1 +
>>  mm/memfd.c                 |  3 ++-
>>  mm/shmem.c                 | 16 ++++++++++++++--
>>  3 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
>> index 2f86b2ad6d7e..98bdabc8e309 100644
>> --- a/include/uapi/linux/fcntl.h
>> +++ b/include/uapi/linux/fcntl.h
>> @@ -43,6 +43,7 @@
>>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
>>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
>> +#define F_SEAL_AUTO_ALLOCATE	0x0020  /* prevent allocation for writes */
> 
> Why only "on writes" and not "on reads". IIRC, shmem doesn't support the
> shared zeropage, so you'll simply allocate a new page via read() or on
> read faults.

Correction: on read() we don't allocate a fresh page. But on read faults
we would. So this comment here needs clarification.

> 
> 
> Also, I *think* you can place pages via userfaultfd into shmem. Not sure
> if that would count "auto alloc", but it would certainly bypass fallocate().
> 


-- 
Thanks,

David / dhildenb

