Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945E55B2DA3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 06:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiIIEox (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 00:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIIEou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFCF37FAB;
        Thu,  8 Sep 2022 21:44:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 424D360E73;
        Fri,  9 Sep 2022 04:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E45CC433C1;
        Fri,  9 Sep 2022 04:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662698687;
        bh=enEwLIV4OwLmN/RgbTuEUX2L54sFfCWJPwewzGbYInE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cLrhFtKHGXINYvsGREelVRIrtsdDSdhyssoSgqKj1qRrv8lKr0eHelXtdnDQr85sC
         vUhwAfnsNzkQoKexpnXMoJMT2YKwm5XKP5lz/55VUhKJAfkOYJlwEC7BQKT5XWACfI
         1k3vOOYkyrSJreY+nrZBkF7nlWbJdvuk7q1CKzdUycNfapzFNnsGW/qGhV4hFmnntR
         OfJ8zVRoAu1qi5JA6EiUBZ7jakY55X0EANPYhumQNRuDzDBGpuIpiLT6sCkdfGVwZE
         3o0LkAEWoAGTiudx3mSdHcf7Y878UhbbaZuVzxJ+2HSUPNQIqSpy8GPq8284tGcG6p
         KiZxc67uW85HQ==
Message-ID: <48f7d192-993d-1df1-db0a-f985e61669b6@kernel.org>
Date:   Thu, 8 Sep 2022 21:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220818132421.6xmjqduempmxnnu2@box>
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

On 8/18/22 06:24, Kirill A . Shutemov wrote:
> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
>> On Wed, 6 Jul 2022, Chao Peng wrote:
>>> This is the v7 of this series which tries to implement the fd-based KVM
>>> guest private memory.
>>
>> Here at last are my reluctant thoughts on this patchset.
>>
>> fd-based approach for supporting KVM guest private memory: fine.
>>
>> Use or abuse of memfd and shmem.c: mistaken.
>>
>> memfd_create() was an excellent way to put together the initial prototype.
>>
>> But since then, TDX in particular has forced an effort into preventing
>> (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
>>
>> Are any of the shmem.c mods useful to existing users of shmem.c? No.
>> Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
>>
>> What use do you have for a filesystem here?  Almost none.
>> IIUC, what you want is an fd through which QEMU can allocate kernel
>> memory, selectively free that memory, and communicate fd+offset+length
>> to KVM.  And perhaps an interface to initialize a little of that memory
>> from a template (presumably copied from a real file on disk somewhere).
>>
>> You don't need shmem.c or a filesystem for that!
>>
>> If your memory could be swapped, that would be enough of a good reason
>> to make use of shmem.c: but it cannot be swapped; and although there
>> are some references in the mailthreads to it perhaps being swappable
>> in future, I get the impression that will not happen soon if ever.
>>
>> If your memory could be migrated, that would be some reason to use
>> filesystem page cache (because page migration happens to understand
>> that type of memory): but it cannot be migrated.
> 
> Migration support is in pipeline. It is part of TDX 1.5 [1]. And swapping
> theoretically possible, but I'm not aware of any plans as of now.
> 
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
> 

This thing?

https://cdrdv2.intel.com/v1/dl/getContent/733578

That looks like migration between computers, not between NUMA nodes.  Or 
am I missing something?
