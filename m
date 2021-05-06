Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6E37593C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 19:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhEFR0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 13:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236227AbhEFR0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 13:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620321907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jExgBas4mYe2R7HQ1xBXEHvzUr1CEHDDU82ObrbRp1A=;
        b=caHbs9Sn6Bed3l2X080RGSPQ6Rr28FsneVtVYxJSY+XPbk81P7C0bJHHsjjlSMS2dA3WMz
        kPrl4+DSZLXe4UJf/pna7xPYlDvC+nw82FHa2LQWwlSj+3axeUG5yr1SvcuUQY3Sn9kkAe
        An1O3b1eBPYjY9ZOBkkrh6KRiYaYGew=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-cAmGwesjNBq5ycTjxinaKA-1; Thu, 06 May 2021 13:24:47 -0400
X-MC-Unique: cAmGwesjNBq5ycTjxinaKA-1
Received: by mail-ed1-f70.google.com with SMTP id y19-20020a0564022713b029038a9f36060dso3025270edd.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 May 2021 10:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jExgBas4mYe2R7HQ1xBXEHvzUr1CEHDDU82ObrbRp1A=;
        b=iC6KGSbehNtkH+7OKkD+3Ttte9iY6GKuPvCOkbg7+vuUwxjeZQiYkrouLPgWEfXra2
         6YDdbh9BAlvgqowYGisrEPIYaNS7Vcjj4jrxEgKHXYLOnJUiPl8u/iVvpl0kRGPrbNRt
         ELF5LaM4RddaKPGKb7+im7KxnxYnS+Q+FwR/A39kxeeApSx3LTzoxsrOFPuLvadQohwY
         9EkqlvavM/k8bhMVFpAUqdK1fYPUVyQhvPPWXNWv3KWYa32CJdgRtpYx6CgYuHfRSVkj
         IUEOdDuGfhGMtC+vnlluOpp+codaIeaFvATOVxpHCT1Thfky73t/34Gxki+H7AlQhgLO
         q+lg==
X-Gm-Message-State: AOAM5302D4DYS1B6zDSYd2xTXfv4sm8I22Wp8zOnBYcX6LB6WemcbOfr
        rYL5vXZR6adRk+2tTAVXyb94G/YGZ5zUNRXSGvLduf3IcVue28ySoAnZpSW5YqCrwIJ6q+aH0/w
        qZ65HhWGCYCU0ZxTHaMaQC6o1nw==
X-Received: by 2002:aa7:d952:: with SMTP id l18mr6506585eds.83.1620321886025;
        Thu, 06 May 2021 10:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0HYEbkAPLbEzE0RQH/Kg006zDXqRhpGiJee/o6TGxungGJENUOS9lWTxREQMEK2RJtQPDnQ==
X-Received: by 2002:aa7:d952:: with SMTP id l18mr6506560eds.83.1620321885798;
        Thu, 06 May 2021 10:24:45 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c64ae.dip0.t-ipconnect.de. [91.12.100.174])
        by smtp.gmail.com with ESMTPSA id y19sm2147544edc.73.2021.05.06.10.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 10:24:45 -0700 (PDT)
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
 <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
 <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <a5b19a4f-5d7b-9840-fd70-67a39bc8969e@redhat.com>
Date:   Thu, 6 May 2021 19:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>> Is this intended to protect keys/etc after the attacker has
>>>> gained the ability to run arbitrary kernel-mode code?  If so,
>>>> that seems optimistic, doesn't it?
>>>
>>> Not exactly: there are many types of kernel attack, but mostly the
>>> attacker either manages to effect a privilege escalation to root or
>>> gets the ability to run a ROP gadget.  The object of this code is
>>> to be completely secure against root trying to extract the secret
>>> (some what similar to the lockdown idea), thus defeating privilege
>>> escalation and to provide "sufficient" protection against ROP
>>> gadget.
>>
>> What stops "root" from mapping /dev/mem and reading that memory?
> 
> /dev/mem uses the direct map for the copy at least for read/write, so
> it gets a fault in the same way root trying to use ptrace does.  I
> think we've protected mmap, but Mike would know that better than I.
> 

I'm more concerned about the mmap case -> remap_pfn_range(). Anybody 
going via the VMA shouldn't see the struct page, at least when 
vma_normal_page() is properly used; so you cannot detect secretmem
memory mapped via /dev/mem reliably. At least that's my theory :)

[...]

>> Also, there is a way to still read that memory when root by
>>
>> 1. Having kdump active (which would often be the case, but maybe not
>> to dump user pages )
>> 2. Triggering a kernel crash (easy via proc as root)
>> 3. Waiting for the reboot after kump() created the dump and then
>> reading the content from disk.
> 
> Anything that can leave physical memory intact but boot to a kernel
> where the missing direct map entry is restored could theoretically
> extract the secret.  However, it's not exactly going to be a stealthy
> extraction ...
> 
>> Or, as an attacker, load a custom kexec() kernel and read memory
>> from the new environment. Of course, the latter two are advanced
>> mechanisms, but they are possible when root. We might be able to
>> mitigate, for example, by zeroing out secretmem pages before booting
>> into the kexec kernel, if we care :)
> 
> I think we could handle it by marking the region, yes, and a zero on
> shutdown might be useful ... it would prevent all warm reboot type
> attacks.

Right. But I guess when you're actually root, you can just write a 
kernel module to extract the information you need (unless we have signed 
modules, so it could be harder/impossible).

-- 
Thanks,

David / dhildenb

