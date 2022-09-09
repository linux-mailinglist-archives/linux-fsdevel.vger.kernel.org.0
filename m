Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EFF5B2DD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 06:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIIEzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 00:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIIEzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:55:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F780B57;
        Thu,  8 Sep 2022 21:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4BC54CE2072;
        Fri,  9 Sep 2022 04:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DD9C433C1;
        Fri,  9 Sep 2022 04:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662699330;
        bh=msAn2untxTbG9lve9YPiSW6u+1kfRzel1BmeAbbTzVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IKpdWrtStwoZtZ8Zp9KpRJe1T01ctzX66EYNB7h2x8B4rtGdZP9oYfts2NOHcp1Kh
         E1cA58qajYyLtbh77dc2M+/EoeARTgA9xWAWZ4e9XN/mL8rv8RfSZlJP8LXwLggjmY
         YpRluduZsf7cTrFjP4TfVLVCoO0ysDpWAqC+fgIuJ0YrwP/sS0O+AXsXLFqy83uAvb
         XvSwOe03Uha8ElXacHenw22uJDKmJ4cL4fTSkDreOUCeYZMs6kr0YHWmtdGDqUj9bE
         ogaegpX9MZ8RpBZW/2ATqKUOaVyI4yqiiItNREGu3ok+kqbbK6NSi9juXf/vUiVBT0
         U2x+iNrNJgM/g==
Message-ID: <8f2fdba8-ce19-0dff-5934-5d51cde94915@kernel.org>
Date:   Thu, 8 Sep 2022 21:55:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        dave.hansen@intel.com, ak@linux.intel.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        "Gupta, Pankaj" <pankaj.gupta@amd.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <ff5c5b97-acdf-9745-ebe5-c6609dd6322e@google.com>
 <20220818132421.6xmjqduempmxnnu2@box> <Yv7XTON3MwuC1Q3U@google.com>
 <226ab26d-9aa8-dce2-c7f0-9e3f5b65b63@google.com>
 <b2743a3a-a1b4-2d2e-98be-87b58ad387cf@redhat.com>
 <YwT6x2g9jcMH60LI@google.com> <20220824094149.GA1383966@chaop.bj.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220824094149.GA1383966@chaop.bj.intel.com>
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

On 8/24/22 02:41, Chao Peng wrote:
> On Tue, Aug 23, 2022 at 04:05:27PM +0000, Sean Christopherson wrote:
>> On Tue, Aug 23, 2022, David Hildenbrand wrote:
>>> On 19.08.22 05:38, Hugh Dickins wrote:
>>>> On Fri, 19 Aug 2022, Sean Christopherson wrote:
>>>>> On Thu, Aug 18, 2022, Kirill A . Shutemov wrote:
>>>>>> On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
>>>>>>> On Wed, 6 Jul 2022, Chao Peng wrote:
>>>>>>> But since then, TDX in particular has forced an effort into preventing
>>>>>>> (by flags, seals, notifiers) almost everything that makes it shmem/tmpfs.
>>>>>>>
>>>>>>> Are any of the shmem.c mods useful to existing users of shmem.c? No.
>>>>>>> Is MFD_INACCESSIBLE useful or comprehensible to memfd_create() users? No.
>>>>>
>>>>> But QEMU and other VMMs are users of shmem and memfd.  The new features certainly
>>>>> aren't useful for _all_ existing users, but I don't think it's fair to say that
>>>>> they're not useful for _any_ existing users.
>>>>
>>>> Okay, I stand corrected: there exist some users of memfd_create()
>>>> who will also have use for "INACCESSIBLE" memory.
>>>
>>> As raised in reply to the relevant patch, I'm not sure if we really have
>>> to/want to expose MFD_INACCESSIBLE to user space. I feel like this is a
>>> requirement of specific memfd_notifer (memfile_notifier) implementations
>>> -- such as TDX that will convert the memory and MCE-kill the machine on
>>> ordinary write access. We might be able to set/enforce this when
>>> registering a notifier internally instead, and fail notifier
>>> registration if a condition isn't met (e.g., existing mmap).
>>>
>>> So I'd be curious, which other users of shmem/memfd would benefit from
>>> (MMU)-"INACCESSIBLE" memory obtained via memfd_create()?
>>
>> I agree that there's no need to expose the inaccessible behavior via uAPI.  Making
>> it a kernel-internal thing that's negotiated/resolved when KVM binds to the fd
>> would align INACCESSIBLE with the UNMOVABLE and UNRECLAIMABLE flags (and any other
>> flags that get added in the future).
>>
>> AFAICT, the user-visible flag is a holdover from the early RFCs and doesn't provide
>> any unique functionality.
> 
> That's also what I'm thinking. And I don't see problem immediately if
> user has populated the fd at the binding time. Actually that looks an
> advantage for previously discussed guest payload pre-loading.

I think this gets awkward. Trying to define sensible semantics for what 
happens if a shmem or similar fd gets used as secret guest memory and 
that fd isn't utterly and completely empty can get quite nasty.  For 
example:

If there are already mmaps, then TDX (much more so than SEV) really 
doesn't want to also use it as guest memory.

If there is already data in the fd, then maybe some technologies can use 
this for pre-population, but TDX needs explicit instructions in order to 
get the guest's hash right.


In general, it seems like it will be much more likely to actually work 
well if the user (uAPI) is required to declare to the kernel exactly 
what the fd is for (e.g. TDX secret memory, software-only secret memory, 
etc) before doing anything at all with it other than binding it to KVM.

INACCESSIBLE is a way to achieve this.  Maybe it's not the prettiest in 
the world -- I personally would rather see an explicit request for, say, 
TDX or SEV memory or maybe the memory that works for a particular KVM 
instance instead of something generic like INACCESSIBLE, but this is a 
pretty weak preference.  But I think that just starting with a plain 
memfd is a can of worms.
