Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7B3758A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhEFQqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 12:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235891AbhEFQqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 12:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620319511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0s/7VDcOT9Z56vBvGNlao04OZufq+cCm9HLSATOe2hs=;
        b=YKgqzUJ4GOTx6bmW4NSxv6DPiIY3WWTz3FO8rQ9MCvHhPyTMuh9yxAK3jWqjYG+oTtyTrK
        FmZ1McC87KPhPOaBsNJfacaqvRUgVuc4LR9lkAyuKIEyxOvZq1T4/SzaK6ibEd7/xIjK4X
        /bZeAWZxWEv9GLcVfWb2W6jkgzXXN4k=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-Q3NMmFn2M7yCc7BaJMsHUg-1; Thu, 06 May 2021 12:45:10 -0400
X-MC-Unique: Q3NMmFn2M7yCc7BaJMsHUg-1
Received: by mail-ej1-f72.google.com with SMTP id yh1-20020a17090706e1b029038d0f848c7aso1958593ejb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 May 2021 09:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0s/7VDcOT9Z56vBvGNlao04OZufq+cCm9HLSATOe2hs=;
        b=JnOqMBdnSRDqX+Ix2CfV+a76ehIStnj1gV0AG7RLJFGIhs6b0tgxyu6HTzOs9jof/k
         5teIez4xk71ZVLz7Rsv7wwDlgp9swCUT9ZmHCVZJEuvLVCsCbsgcttw37S8EsILsu9Pf
         76DlIksDHESaEDnPdF2vAfXdbaAvHbPEPebxwH9+gAzSQKpshIsQnwykAr3FclsvPidu
         /o1PZVq9JLjEDgIqVeHeK4ZTReK9eMFSM0yRsgaNkb8FT3Z2RB6o51C+5B1cM45HEbBh
         4cqdxl1dh+OCqb/RleDmvh7IGIrFH1oZKcy5ESbU90cvnbe+fwdEZ5GnZBkuy6mzBfEa
         LePA==
X-Gm-Message-State: AOAM530Sy8F/CrG0KrDjuljXD5YchR9exatWMWmtnHRzaokpvQe5pnB5
        JiTYJNAqgA2D84Jsg6mkTXylF64oPfY/5wGw2jy4TnasyGF2UtSIHoK0i2dnPKXe38shsn3+FmR
        hpxKqnmuZALTO36LiyzXKv3qkXg==
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr5478134ejc.206.1620319508732;
        Thu, 06 May 2021 09:45:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw+5/fwG+KvK+SBzoVexxr801GBTZ6Zrmz5O+rAzTFPxJI4yj9g+Ax3izTWEuuMsZJC630XQ==
X-Received: by 2002:a17:907:1c98:: with SMTP id nb24mr5478083ejc.206.1620319508409;
        Thu, 06 May 2021 09:45:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id f19sm2095318edu.12.2021.05.06.09.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 09:45:08 -0700 (PDT)
To:     jejb@linux.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
Date:   Thu, 6 May 2021 18:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.05.21 17:26, James Bottomley wrote:
> On Wed, 2021-05-05 at 12:08 -0700, Andrew Morton wrote:
>> On Wed,  3 Mar 2021 18:22:00 +0200 Mike Rapoport <rppt@kernel.org>
>> wrote:
>>
>>> This is an implementation of "secret" mappings backed by a file
>>> descriptor.
>>>
>>> The file descriptor backing secret memory mappings is created using
>>> a dedicated memfd_secret system call The desired protection mode
>>> for the memory is configured using flags parameter of the system
>>> call. The mmap() of the file descriptor created with memfd_secret()
>>> will create a "secret" memory mapping. The pages in that mapping
>>> will be marked as not present in the direct map and will be present
>>> only in the page table of the owning mm.
>>>
>>> Although normally Linux userspace mappings are protected from other
>>> users, such secret mappings are useful for environments where a
>>> hostile tenant is trying to trick the kernel into giving them
>>> access to other tenants mappings.
>>
>> I continue to struggle with this and I don't recall seeing much
>> enthusiasm from others.  Perhaps we're all missing the value point
>> and some additional selling is needed.
>>
>> Am I correct in understanding that the overall direction here is to
>> protect keys (and perhaps other things) from kernel bugs?  That if
>> the kernel was bug-free then there would be no need for this
>> feature?  If so, that's a bit sad.  But realistic I guess.
> 
> Secret memory really serves several purposes. The "increase the level
> of difficulty of secret exfiltration" you describe.  And, as you say,
> if the kernel were bug free this wouldn't be necessary.
> 
> But also:
> 
>     1. Memory safety for use space code.  Once the secret memory is
>        allocated, the user can't accidentally pass it into the kernel to be
>        transmitted somewhere.

That's an interesting point I didn't realize so far.

>     2. It also serves as a basis for context protection of virtual
>        machines, but other groups are working on this aspect, and it is
>        broadly similar to the secret exfiltration from the kernel problem.
> 

I was wondering if this also helps against CPU microcode issues like 
spectre and friends.

>>
>> Is this intended to protect keys/etc after the attacker has gained
>> the ability to run arbitrary kernel-mode code?  If so, that seems
>> optimistic, doesn't it?
> 
> Not exactly: there are many types of kernel attack, but mostly the
> attacker either manages to effect a privilege escalation to root or
> gets the ability to run a ROP gadget.  The object of this code is to be
> completely secure against root trying to extract the secret (some what
> similar to the lockdown idea), thus defeating privilege escalation and
> to provide "sufficient" protection against ROP gadget.

What stops "root" from mapping /dev/mem and reading that memory?

IOW, would we want to enforce "CONFIG_STRICT_DEVMEM" with CONFIG_SECRETMEM?


Also, there is a way to still read that memory when root by

1. Having kdump active (which would often be the case, but maybe not to 
dump user pages )
2. Triggering a kernel crash (easy via proc as root)
3. Waiting for the reboot after kump() created the dump and then reading 
the content from disk.

Or, as an attacker, load a custom kexec() kernel and read memory from 
the new environment. Of course, the latter two are advanced mechanisms, 
but they are possible when root. We might be able to mitigate, for 
example, by zeroing out secretmem pages before booting into the kexec 
kernel, if we care :)

-- 
Thanks,

David / dhildenb

