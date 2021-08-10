Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D213E841E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhHJUJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:09:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:55710 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229788AbhHJUJa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:09:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="202152493"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="202152493"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 13:09:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="515971399"
Received: from pdmuelle-desk2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.166.202])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 13:09:05 -0700
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4f9effcb-055b-51ee-6722-c9f0cc1d8acf@linux.intel.com>
Date:   Tue, 10 Aug 2021 13:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/10/21 12:48 PM, Tom Lendacky wrote:
> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 7/27/21 3:26 PM, Tom Lendacky wrote:
>>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
>>> index de01903c3735..cafed6456d45 100644
>>> --- a/arch/x86/kernel/head64.c
>>> +++ b/arch/x86/kernel/head64.c
>>> @@ -19,7 +19,7 @@
>>>    #include <linux/start_kernel.h>
>>>    #include <linux/io.h>
>>>    #include <linux/memblock.h>
>>> -#include <linux/mem_encrypt.h>
>>> +#include <linux/protected_guest.h>
>>>    #include <linux/pgtable.h>
>>>      #include <asm/processor.h>
>>> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
>>> physaddr,
>>>         * there is no need to zero it after changing the memory encryption
>>>         * attribute.
>>>         */
>>> -    if (mem_encrypt_active()) {
>>> +    if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
>>>            vaddr = (unsigned long)__start_bss_decrypted;
>>>            vaddr_end = (unsigned long)__end_bss_decrypted;
>>
>>
>> Since this change is specific to AMD, can you replace PATTR_MEM_ENCRYPT with
>> prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not used in
>> TDX.
> 
> This is a direct replacement for now. I think the change you're requesting
> should be done as part of the TDX support patches so it's clear why it is
> being changed.

Ok. I will include it part of TDX changes.

> 
> But, wouldn't TDX still need to do something with this shared/unencrypted
> area, though? Or since it is shared, there's actually nothing you need to
> do (the bss decrpyted section exists even if CONFIG_AMD_MEM_ENCRYPT is not
> configured)?

Kirill had a requirement to turn on CONFIG_AMD_MEM_ENCRYPT for adding lazy
accept support in TDX guest kernel. Kirill, can you add details here?

> 
> Thanks,
> Tom
> 
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
