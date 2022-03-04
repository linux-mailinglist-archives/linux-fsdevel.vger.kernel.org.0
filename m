Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E034CDE4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 21:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiCDUBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 15:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiCDUA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:00:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770F23BF05;
        Fri,  4 Mar 2022 11:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABE50B82B5E;
        Fri,  4 Mar 2022 19:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E62EC340E9;
        Fri,  4 Mar 2022 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646421874;
        bh=56U7h/PWatXCc+X0v4IbqX2HG9yyywUYaKIctbWn0sI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rcP1L14pFaadmjABQMFUr1EX7rWJpbYgqQlSedShGUvIRlZ8fa4jppJuK+5TIdI2g
         wibl11/CJ6TjP8fu7MvwoRWIejhd4jB3LvIoeQkylIrREoRzQUkMIQRZTUbjldUszp
         zCjaWrxHMHV6DfUWk453gSFhDX2+0ofcCUp7G5vUgvHTiBRluWdDHjOHRh/7lb60jq
         jmoaWcRzOe35+r9+UystrpbhsHpwc/Jxy6rb2chN2Eq8yfmDf+A+JFjNFJ6WuZ/HCl
         ztl8skrIds3LAyw2HgJ6Wd5mZP+fXAZuInXKeTd+HzMsdWuIL1nnbxfhwG5VK1axZP
         Jr2SPQZffiFoA==
Message-ID: <7cc65bbd-e323-eabb-c576-b5656a3355ac@kernel.org>
Date:   Fri, 4 Mar 2022 11:24:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org, Linux API <linux-api@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
 <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
 <20220217130631.GB32679@chaop.bj.intel.com>
 <2ca78dcb-61d9-4c9d-baa9-955b6f4298bb@www.fastmail.com>
 <20220223114935.GA53733@chaop.bj.intel.com>
 <71a06402-6743-bfd2-bbd4-997f8e256554@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <71a06402-6743-bfd2-bbd4-997f8e256554@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/23/22 04:05, Steven Price wrote:
> On 23/02/2022 11:49, Chao Peng wrote:
>> On Thu, Feb 17, 2022 at 11:09:35AM -0800, Andy Lutomirski wrote:
>>> On Thu, Feb 17, 2022, at 5:06 AM, Chao Peng wrote:
>>>> On Fri, Feb 11, 2022 at 03:33:35PM -0800, Andy Lutomirski wrote:
>>>>> On 1/18/22 05:21, Chao Peng wrote:
>>>>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>>>>
>>>>>> Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
>>>>>> the file is inaccessible from userspace through ordinary MMU access
>>>>>> (e.g., read/write/mmap). However, the file content can be accessed
>>>>>> via a different mechanism (e.g. KVM MMU) indirectly.
>>>>>>
>>>>>> It provides semantics required for KVM guest private memory support
>>>>>> that a file descriptor with this seal set is going to be used as the
>>>>>> source of guest memory in confidential computing environments such
>>>>>> as Intel TDX/AMD SEV but may not be accessible from host userspace.
>>>>>>
>>>>>> At this time only shmem implements this seal.
>>>>>>
>>>>>
>>>>> I don't dislike this *that* much, but I do dislike this. F_SEAL_INACCESSIBLE
>>>>> essentially transmutes a memfd into a different type of object.  While this
>>>>> can apparently be done successfully and without races (as in this code),
>>>>> it's at least awkward.  I think that either creating a special inaccessible
>>>>> memfd should be a single operation that create the correct type of object or
>>>>> there should be a clear justification for why it's a two-step process.
>>>>
>>>> Now one justification maybe from Stever's comment to patch-00: for ARM
>>>> usage it can be used with creating a normal memfd, (partially)populate
>>>> it with initial guest memory content (e.g. firmware), and then
>>>> F_SEAL_INACCESSIBLE it just before the first time lunch of the guest in
>>>> KVM (definitely the current code needs to be changed to support that).
>>>
>>> Except we don't allow F_SEAL_INACCESSIBLE on a non-empty file, right?  So this won't work.
>>
>> Hmm, right, if we set F_SEAL_INACCESSIBLE on a non-empty file, we will
>> need to make sure access to existing mmap-ed area should be prevented,
>> but that is hard.
>>
>>>
>>> In any case, the whole confidential VM initialization story is a bit buddy.  From the earlier emails, it sounds like ARM expects the host to fill in guest memory and measure it.  From my recollection of Intel's scheme (which may well be wrong, and I could easily be confusing it with SGX), TDX instead measures what is essentially a transcript of the series of operations that initializes the VM.  These are fundamentally not the same thing even if they accomplish the same end goal.  For TDX, we unavoidably need an operation (ioctl or similar) that initializes things according to the VM's instructions, and ARM ought to be able to use roughly the same mechanism.
>>
>> Yes, TDX requires a ioctl. Steven may comment on the ARM part.
> 
> The Arm story is evolving so I can't give a definite answer yet. Our
> current prototyping works by creating the initial VM content in a
> memslot as with a normal VM and then calling an ioctl which throws the
> big switch and converts all the (populated) pages to be protected. At
> this point the RMM performs a measurement of the data that the VM is
> being populated with.
> 
> The above (in our prototype) suffers from all the expected problems with
> a malicious VMM being able to trick the host kernel into accessing those
> pages after they have been protected (causing a fault detected by the
> hardware).
> 
> The ideal (from our perspective) approach would be to follow the same
> flow but where the VMM populates a memfd rather than normal anonymous
> pages. The memfd could then be sealed and the pages converted to
> protected ones (with the RMM measuring them in the process).
> 
> The question becomes how is that memfd populated? It would be nice if
> that could be done using normal operations on a memfd (i.e. using
> mmap()) and therefore this code could be (relatively) portable. This
> would mean that any pages mapped from the memfd would either need to
> block the sealing or be revoked at the time of sealing.
> 
> The other approach is we could of course implement a special ioctl which
> effectively does a memcpy into the (created empty and sealed) memfd and
> does the necessary dance with the RMM to measure the contents. This
> would match the "transcript of the series of operations" described above
> - but seems much less ideal from the viewpoint of the VMM.

A VMM that supports Other Vendors will need to understand this sort of 
model regardless.

I don't particularly mind the idea of having the kernel consume a normal 
memfd and spit out a new object, but I find the concept of changing the 
type of the object in place, even if it has other references, and trying 
to control all the resulting races to be somewhat alarming.

In pseudo-Rust, this is the difference between:

fn convert_to_private(in: &mut Memfd)

and

fn convert_to_private(in: Memfd) -> PrivateMemoryFd

This doesn't map particularly nicely to the kernel, though.

--Andy\
