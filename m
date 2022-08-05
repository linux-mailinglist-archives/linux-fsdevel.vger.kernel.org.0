Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2B58AF87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiHESGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbiHESGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 14:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00CBD74E3D
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Aug 2022 11:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659722768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTG5sYKz5wYWpj0OuPtAuT0vzoUTMIRW2UW4E5SQLSQ=;
        b=EqtatFDulK1RwYEUXVMucgeZtcmVXqtT8a4mf7nysaZnENR/B78tcR/PjnyTpZs7euqc4r
        /xsrR39d50VVRXAPVuQ+Fry6vuDwWyRKOM9Nc8HfsLjvPZQjxweQffVfEiqPz5dhr2xZqE
        oFEPcIKVnFDX4tLmD5mv3ASVCl9MFrw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-XqqIl7AfMoCdIxgSWaCbNQ-1; Fri, 05 Aug 2022 14:06:07 -0400
X-MC-Unique: XqqIl7AfMoCdIxgSWaCbNQ-1
Received: by mail-wm1-f70.google.com with SMTP id r4-20020a1c4404000000b003a4ef3d710aso244070wma.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Aug 2022 11:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=gTG5sYKz5wYWpj0OuPtAuT0vzoUTMIRW2UW4E5SQLSQ=;
        b=AmjJ/71MZwJi+FL5DwjgyQw83WHozGqGTYy7fOlPAwgwiW6siA1WtltSF6ju2CpeIi
         f+M21Ovhyq9lJsovFqF4HRPSTwSyVz9CNkaR3vj9Fh+6vSVU/gkxUCJhLwnSXZUFOUXN
         oMXr+9rc+W+2bT1ruMUkmmh/pNoKTO0M5mOXyorakSCWUIoXwTwgUMsBnPmCEL8syJVf
         13rSxY5ychWfkD6B4uq9ZLCppYBpeDqdMCBSZbgw6B5ptEwGc8smIj38ATQ4V78292NM
         vqPekwzlcEbngvko2dr9p1suumTvfYvdrrNLvR3e1ZTPwdKPgLpUF7TSuqtSjEqq0vkf
         FpfQ==
X-Gm-Message-State: ACgBeo2nNDGcg/rbDiVBllAOkVXVFE/7+5xerRSKgXUg6Znoem+m6+Bd
        WkTrnjvlh23Ms+M6UE/S16glrewggEiv71wPsNUh/bsQFypVE4QpeKWiLdbt13bpYEAL/57dg5W
        myKgb6bNOdctIYx7bgbJmIF5xOQ==
X-Received: by 2002:a05:6000:811:b0:220:6262:ac66 with SMTP id bt17-20020a056000081100b002206262ac66mr4741208wrb.529.1659722765759;
        Fri, 05 Aug 2022 11:06:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4YiYJd4RGqr8HPcVnnEu37Kzz2xizPBJ/DFAoYEPdnVgyVJMfvEXwBl3Yrl6juKrdXAyBEpQ==
X-Received: by 2002:a05:6000:811:b0:220:6262:ac66 with SMTP id bt17-20020a056000081100b002206262ac66mr4741186wrb.529.1659722765470;
        Fri, 05 Aug 2022 11:06:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b003a31b79dc0esm26070221wmq.1.2022.08.05.11.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 11:06:05 -0700 (PDT)
Message-ID: <a2b8fa73-4efd-426f-abcd-7975ff9a7101@redhat.com>
Date:   Fri, 5 Aug 2022 20:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 01/14] mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <472207cf-ff71-563b-7b66-0c7bea9ea8ad@redhat.com>
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

On 05.08.22 19:55, Paolo Bonzini wrote:
> On 7/21/22 11:44, David Hildenbrand wrote:
>>
>> Also, I*think*  you can place pages via userfaultfd into shmem. Not
>> sure if that would count "auto alloc", but it would certainly bypass
>> fallocate().
> 
> Yeah, userfaultfd_register would probably have to forbid this for 
> F_SEAL_AUTO_ALLOCATE vmas.  Maybe the memfile_node can be reused for 
> this, adding a new MEMFILE_F_NO_AUTO_ALLOCATE flags?  Then 
> userfault_register would do something like 
> memfile_node_get_flags(vma->vm_file) and check the result.

An alternative is to simply have the shmem allocation fail in a similar
way. Maybe it does already, I haven't checked (don't think so).


-- 
Thanks,

David / dhildenb

