Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506ED363EB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238693AbhDSJjR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 05:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238584AbhDSJjP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618825125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W9MP8cjbzcrX9DzJPJwd3PFnkP3wW8EZhTQvmYtyhYA=;
        b=aSUDHsDRby2E8EtiMp9TFt9+e2RJwj6hKsww3mBHOCtlhOGbyaosvAouc3JrEs1DNbJWON
        EF/Qap1ZmSbO6QBUcDDxI2vV+f6MqXq2u4l8A7R/M8tb0jNHhliMJ6NgP9zLiPJZ3HtpsF
        MH1zxYFTJqBDAoRV5oNkXijPSq6BdfY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-hmzFDbf0MyKZzenMLNikAA-1; Mon, 19 Apr 2021 05:38:44 -0400
X-MC-Unique: hmzFDbf0MyKZzenMLNikAA-1
Received: by mail-ed1-f70.google.com with SMTP id l22-20020a0564021256b0290384ebfba68cso7030687edw.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W9MP8cjbzcrX9DzJPJwd3PFnkP3wW8EZhTQvmYtyhYA=;
        b=BPus0RC4V+g6ZfLawjU5up0yKkwEj9eqAokYP4cgO247yPgi5vrMK+HyAx4O7Emn/q
         c6ew9GCb8cobuL9PBr4LjxMnye25SMO+P6IQonXsh0aXVd9uYhPa5j+GeLKAs8SgPIof
         RbL7P/30f5nUE7SlMwkicUT1WlzmHk19FszvtrbcjMcRmhQF8ylxnto3E28cvPs7Cwud
         AKPYbMUGaEt8jPnKwAnjcGSQQbI51qImZhHXnaGN/R/2F8Fq5KjTV1b7H6kPjX0QXEyI
         19Sgd874FUR34XAoOnSmtIQ/E2LaSCOFXEOSTQmoBXFFMXXAz7t6SHd3N9QJr0+1/g8G
         5lZg==
X-Gm-Message-State: AOAM530cD9tp59PFyTFS+fQ4DgHTqtgf4eifMscDFp17cB24DLyRDN0/
        A/UeNyWCC+1Lf5lDOUOQgnuZm8cSQmt+tj1KUScIFhs/eafVBsRdndeIDnffDZaOySqMLsbcpKf
        aNoqfLDad8AERRIZAR9Y3JX3Uxw==
X-Received: by 2002:a17:906:98d6:: with SMTP id zd22mr16697347ejb.17.1618825122869;
        Mon, 19 Apr 2021 02:38:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGQ30kMI3cddajeZS/U8PQuAuuPoix56tOatD7f6VV3+y8LgKZjvgSrEGol9OdxIgtH/QwWg==
X-Received: by 2002:a17:906:98d6:: with SMTP id zd22mr16697331ejb.17.1618825122657;
        Mon, 19 Apr 2021 02:38:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id x7sm11903755eds.67.2021.04.19.02.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:38:42 -0700 (PDT)
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
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
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
Date:   Mon, 19 Apr 2021 11:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH1PE4oWeicpJT9g@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19.04.21 11:36, Mike Rapoport wrote:
> On Mon, Apr 19, 2021 at 11:15:02AM +0200, David Hildenbrand wrote:
>> On 19.04.21 10:42, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Kernel test robot reported -4.2% regression of will-it-scale.per_thread_ops
>>> due to commit "mm: introduce memfd_secret system call to create "secret"
>>> memory areas".
>>>
>>> The perf profile of the test indicated that the regression is caused by
>>> page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
>>>
>>>    27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
>>>     0.00  +3.2   3.19 ± 2%  perf-profile.children.cycles-pp.page_mapping
>>>     0.00  +3.7   3.66 ± 2%  perf-profile.children.cycles-pp.page_is_secretmem
>>>
>>> Further analysis showed that the slow down happens because neither
>>> page_is_secretmem() nor page_mapping() are not inline and moreover,
>>> multiple page flags checks in page_mapping() involve calling
>>> compound_head() several times for the same page.
>>>
>>> Make page_is_secretmem() inline and replace page_mapping() with page flag
>>> checks that do not imply page-to-head conversion.
>>>
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>
>>> @Andrew,
>>> The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate if it would
>>> be added as a fixup to the memfd_secret series.
>>>
>>>    include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
>>>    mm/secretmem.c            | 12 +-----------
>>>    2 files changed, 26 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
>>> index 907a6734059c..b842b38cbeb1 100644
>>> --- a/include/linux/secretmem.h
>>> +++ b/include/linux/secretmem.h
>>> @@ -4,8 +4,32 @@
>>>    #ifdef CONFIG_SECRETMEM
>>> +extern const struct address_space_operations secretmem_aops;
>>> +
>>> +static inline bool page_is_secretmem(struct page *page)
>>> +{
>>> +	struct address_space *mapping;
>>> +
>>> +	/*
>>> +	 * Using page_mapping() is quite slow because of the actual call
>>> +	 * instruction and repeated compound_head(page) inside the
>>> +	 * page_mapping() function.
>>> +	 * We know that secretmem pages are not compound and LRU so we can
>>> +	 * save a couple of cycles here.
>>> +	 */
>>> +	if (PageCompound(page) || !PageLRU(page))
>>> +		return false;
>>
>> I'd assume secretmem pages are rare in basically every setup out there. So
>> maybe throwing in a couple of likely()/unlikely() might make sense.
> 
> I'd say we could do unlikely(page_is_secretmem()) at call sites. Here I can
> hardly estimate which pages are going to be checked.
>   
>>> +
>>> +	mapping = (struct address_space *)
>>> +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>>> +
>>
>> Not sure if open-coding page_mapping is really a good idea here -- or even
>> necessary after the fast path above is in place. Anyhow, just my 2 cents.
> 
> Well, most if the -4.2% of the performance regression kbuild reported were
> due to repeated compount_head(page) in page_mapping(). So the whole point
> of this patch is to avoid calling page_mapping().

I would have thought the fast path "(PageCompound(page) || 
!PageLRU(page))" would already avoid calling page_mapping() in many cases.


-- 
Thanks,

David / dhildenb

