Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A5758EA37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiHJKFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiHJKFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3BF453D1D
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660125950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=83RYZm97KNj9NYPWWYz4fzmlCpq267m27613RMfC+Pg=;
        b=erdjO+qotIQw5lTb7SMXfmAiNQpu8VLhFboKhjORTXdQOs0pzWJyBqwsVwrJ0L6SW0QtGb
        FeF+mK4nLN5fi44b9GA70g2dhrDTvyo8GpizubejlUTI4Gl54FPUOoiBa+9Lr64EofuUCC
        0zVpkird0Oe4Hc+KDHe0MASK+kAKD+w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-qJZLkBaCNq6fjBNKPPSODg-1; Wed, 10 Aug 2022 06:05:45 -0400
X-MC-Unique: qJZLkBaCNq6fjBNKPPSODg-1
Received: by mail-wm1-f69.google.com with SMTP id a17-20020a05600c349100b003a545125f6eso870786wmq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Aug 2022 03:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=83RYZm97KNj9NYPWWYz4fzmlCpq267m27613RMfC+Pg=;
        b=L8kzY1j5adr89n6mo6X6RcvLsX//6j+3x+Uh6uWra0XHx5TBW5HV1Wd0VPJeeyeAZ3
         aNzaDbE3lVGwVKnk09RkDZFI9kHuGEErPdiYKJPhHYW+GIvi7lxB1lJDGpWLMmZuMd1G
         HTZ2YhNs3bTSJXJivHrpMmTAi5lPP3XoL68abpmyx+j2qs0FTPxY4ENlIPZAmP1SyXY0
         5Cz19OknIujV2pSnbHrzD1eiqAUHFjzI0+tImTzeFeJjfhT0Lei2Z/dyV6x50EGZjiK1
         PophEXjgU9RhI6RPXAc/WGbrl2PGNrKawBDuf8/wyBpjhWLYTll+BE39cPh8v8gs+PQg
         +E3A==
X-Gm-Message-State: ACgBeo2BINewpH4714HJ9TSA/iCJR72Puhf5W5vzOxC85prvZZ66CRNt
        /ZffmkaE8BaBAlNcnnpachcs4oTXJuFHF48e0dBtQzKM0hQrKoj4JUr1z/uDNbOqeZg0WYJ0S3g
        Z0TKgGvFHGunwD2CHj60rhFeT5A==
X-Received: by 2002:a5d:64ae:0:b0:220:6c4c:5a60 with SMTP id m14-20020a5d64ae000000b002206c4c5a60mr17058823wrp.636.1660125944509;
        Wed, 10 Aug 2022 03:05:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5i72uisBNMVtDIvVDVfSxV1hzWrZROoCbvcTeBej4J7CIdnSDFuFoSBTJk3opG5+sXP+xgow==
X-Received: by 2002:a5d:64ae:0:b0:220:6c4c:5a60 with SMTP id m14-20020a5d64ae000000b002206c4c5a60mr17058769wrp.636.1660125944245;
        Wed, 10 Aug 2022 03:05:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:1600:a3ce:b459:ef57:7b93? (p200300cbc7071600a3ceb459ef577b93.dip0.t-ipconnect.de. [2003:cb:c707:1600:a3ce:b459:ef57:7b93])
        by smtp.gmail.com with ESMTPSA id t188-20020a1c46c5000000b003a327f19bf9sm1793951wma.14.2022.08.10.03.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 03:05:43 -0700 (PDT)
Message-ID: <00f1aa03-bc82-ffce-569b-e2d5c459992c@redhat.com>
Date:   Wed, 10 Aug 2022 12:05:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
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
 <20220706082016.2603916-4-chao.p.peng@linux.intel.com>
 <13394075-fca0-6f2b-92a2-f1291fcec9a3@redhat.com>
 <20220810092232.GC862421@chaop.bj.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v7 03/14] mm: Introduce memfile_notifier
In-Reply-To: <20220810092232.GC862421@chaop.bj.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.08.22 11:22, Chao Peng wrote:
> On Fri, Aug 05, 2022 at 03:22:58PM +0200, David Hildenbrand wrote:
>> On 06.07.22 10:20, Chao Peng wrote:
>>> This patch introduces memfile_notifier facility so existing memory file
>>> subsystems (e.g. tmpfs/hugetlbfs) can provide memory pages to allow a
>>> third kernel component to make use of memory bookmarked in the memory
>>> file and gets notified when the pages in the memory file become
>>> invalidated.
>>
>> Stupid question, but why is this called "memfile_notifier" and not
>> "memfd_notifier". We're only dealing with memfd's after all ... which
>> are anonymous files essentially. Or what am I missing? Are there any
>> other plans for fs than plain memfd support that I am not aware of?
> 
> There were some discussions on this in v3.
>   https://lkml.org/lkml/2021/12/28/484
> Sean commented it's OK to abstract it from memfd but he also wants the
> kAPI (name) should not bind to memfd to make room for future non-memfd
> usages.

Sorry, but how is "memfile" any better? memfd abstracted to memfile?! :)

I understand Sean's suggestion about abstracting, but if the new name
makes it harder to grasp and there isn't really an alternative to memfd
in sight, I'm not so sure I enjoy the tried abstraction here.

Otherwise we'd have to get creative now and discuss something like
"file_population_notifer" or "mapping_population_notifer" and I am not
sure that our time is well spent doing so right now.

... as this is kernel-internal, we can always adjust the name as we
please later, once we *actually* now what the abstraction should be.
Until then I'd suggest to KIS and soft-glue this to memfd.

Or am I missing something important?

-- 
Thanks,

David / dhildenb

