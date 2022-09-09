Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686975B2DC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 06:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIIEss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 00:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIIEsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A8123EED;
        Thu,  8 Sep 2022 21:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA47F61E5D;
        Fri,  9 Sep 2022 04:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD9C433C1;
        Fri,  9 Sep 2022 04:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662698919;
        bh=0J6ER8fnpFHY39WsvpWQrzmPphu08JvaKTYLSCsE2Hg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nhj471FrBLU3A3EN6xY82qO+CS7EigLtAFQjoed4e7kJlmYNbsyWx58NBcDcWid+C
         kpl5OUkyH4T1KLqbUBdoGbX1tHo5jzChTsJZhr63Y2a6JPOddewEf+EMoxk93bvuz9
         NqGv5k6mcLo2uOReZLUpdQMNVueJVO1CH7VHOd9P1WHejMuUiLAWq1/eSAkVsNC3Fh
         xd5DtarFsGvOADus8UhKVpVH5D9jaRiIAJe/VLjr3kknWg2PAkKRdx+wB+RLNrdTTE
         S1pu4iFWorBwalJrPWhjEAwsV7cOngtqcJEVDb3sqUBFE54ruJIj9kp8cQq5SkvUdr
         AKq+U1uONwy/g==
Message-ID: <95bd287b-d17f-fda8-58c9-20700b1e0c72@kernel.org>
Date:   Thu, 8 Sep 2022 21:48:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
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
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, jun.nakajima@intel.com,
        dave.hansen@intel.com, ak@linux.intel.com, david@redhat.com,
        aarcange@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box>
 <c6ccbb96-5849-2e2f-3b49-4ea711af525d@google.com>
 <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220820002700.6yflrxklmpsavdzi@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/22 17:27, Kirill A. Shutemov wrote:
> On Thu, Aug 18, 2022 at 08:00:41PM -0700, Hugh Dickins wrote:
>> On Thu, 18 Aug 2022, Kirill A . Shutemov wrote:
>>> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
>>>>
>>>> If your memory could be swapped, that would be enough of a good reason
>>>> to make use of shmem.c: but it cannot be swapped; and although there
>>>> are some references in the mailthreads to it perhaps being swappable
>>>> in future, I get the impression that will not happen soon if ever.
>>>>
>>>> If your memory could be migrated, that would be some reason to use
>>>> filesystem page cache (because page migration happens to understand
>>>> that type of memory): but it cannot be migrated.
>>>
>>> Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
>>> theoretically possible, but I'm not aware of any plans as of now.
>>>
>>> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
>>
>> I always forget, migration means different things to different audiences.
>> As an mm person, I was meaning page migration, whereas a virtualization
>> person thinks VM live migration (which that reference appears to be about),
>> a scheduler person task migration, an ornithologist bird migration, etc.
>>
>> But you're an mm person too: you may have cited that reference in the
>> knowledge that TDX 1.5 Live Migration will entail page migration of the
>> kind I'm thinking of.  (Anyway, it's not important to clarify that here.)
> 
> TDX 1.5 brings both.
> 
> In TDX speak, mm migration called relocation. See TDH.MEM.PAGE.RELOCATE.
> 

This seems to be a pretty bad fit for the way that the core mm migrates 
pages.  The core mm unmaps the page, then moves (in software) the 
contents to a new address, then faults it in.  TDH.MEM.PAGE.RELOCATE 
doesn't fit into that workflow very well.  I'm not saying it can't be 
done, but it won't just work.
