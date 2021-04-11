Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36FF35B715
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhDKVyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 17:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhDKVyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:54:18 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E3FC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Apr 2021 14:54:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 7so11471352qka.7
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Apr 2021 14:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MtiFWw1lbP0fMU8IjBYDnw/l/xTMOINcMgt3bBeyFUQ=;
        b=PG+ZhpbevqnFN02a353tQmKOg9Ymas6v9qIPtEg3btcid0JVUsvNaGkQ/9PqJtVijP
         4+W6yPqIwQHOOxLvo339fUYtqfxp6+HEQq09hVLT6wnRgvzeWbJH6tuQh5UHp6gD5LIl
         TZHSBqGGXa4dv2bqMTUhdlVRC0UgYCQVfnxxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MtiFWw1lbP0fMU8IjBYDnw/l/xTMOINcMgt3bBeyFUQ=;
        b=iO0IuGePP44Dw8WPaBM/LYUtKATh8XxZgmz0FMkYY84FVjeCRqd7kyg4bcw5/ohkK3
         EhJto5QkhPZ7cb50uB4NyBPjGNNU60GlGGHvMpfL8q4dnkI8jINsWKpZu8J/tBn5Otcs
         hp3lkxpUDXUrU6QOOFOZNVZ5WaMk0EX7YM48+ruG/XthtUVKd6nJtntTrpj1VlHGqCE6
         is4S29T1YP/k+py2Zt9WJ0YlywSFHV2/ZIwUFb3Lql5gMdiPcoDZzO0CMAfNASLvGWth
         ApZH4DAnIkO3NcdQVwFG1vfld1X4GtSgHo2tpIH7VB9/c8Q66TQ25UalqZx4s1wpzPAg
         Q+ng==
X-Gm-Message-State: AOAM532/SgbkGRs8ewARHoa+6iUIcE71PUNOz2Gz+nOK5iPFxWBcUxLQ
        wq9YDSO8/QJloJT84xI7/L4QBiNfp/+53Q==
X-Google-Smtp-Source: ABdhPJxzdua/Yco8q7cKN9wvkxCZ3NrA33iW2N7vU1FSm0ELgCOm8coRE9ufmY8FF0zQd/JKs/FePA==
X-Received: by 2002:a05:620a:56f:: with SMTP id p15mr933292qkp.102.1618178040526;
        Sun, 11 Apr 2021 14:54:00 -0700 (PDT)
Received: from [152.23.147.117] ([152.23.147.117])
        by smtp.gmail.com with ESMTPSA id w4sm5895148qkd.94.2021.04.11.14.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 14:54:00 -0700 (PDT)
Subject: Re: [RESEND,PATCH] fs/binfmt_elf: Fix regression limiting ELF program
 header size
From:   Joshua Bakita <jbakita@cs.unc.edu>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201215034624.1887447-1-jbakita@cs.unc.edu>
 <7cba1c24-5034-53e1-6014-982973e66ea3@cs.unc.edu>
Message-ID: <fbcd2886-d505-f14e-ad6b-c4b5fa77707e@cs.unc.edu>
Date:   Sun, 11 Apr 2021 17:53:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <7cba1c24-5034-53e1-6014-982973e66ea3@cs.unc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'd greatly appreciate it if this patch would be reviewed. It's been 
nearly 6 months since I first submitted it, there's clear evidence that 
this regression effects real programs, and the fix is simple. If no 
maintainers on this list have the time to review this change, I would 
appreciate suggestions on alternative lists and/or maintainers who I 
could reach out to instead.

Best,

Joshua Bakita

On 2/11/21 3:27 PM, Joshua Bakita wrote:
> Hello all,
> 
> I raised this patch on #linuxfs on IRC, and I got asked if this actually 
> effects real programs. To demonstrate that it does, I wrote up a simple 
> C program which just does a table lookup of a prime number. The table is 
> stored sparsely, so newer versions of GCC+LD automatically put each 
> table entry in its own program section and segment. This results in over 
> 100 ELF program header entries, which Linux since 3.19 will refuse to 
> load with ENOEXEC due to the errant limit fixed in my patch. (The 
> current broken limit is 73, whereas the manpage states a limit of 64k.)
> 
> My example program is available at 
> https://www.cs.unc.edu/~jbakita/get_prime.c and should be built as gcc 
> get_prime.c -o get_prime. I know this works with GCC 9.3.0 and LD 2.34 
> (GCC 7.5.0 and LD 2.30 are too old). You can verify it built correctly 
> by checking the "Number of program headers" as printed by readelf -h is 
> at least 100.
> 
> I tried to keep this patch small to make it easy to review, but there 
> are a few other bugs (like the 64KB limit) in the ELF loader. Would it 
> be more helpful or make review easier to just fix all the bugs at once? 
> This is my first kernel patch, and I'd really like to make it the first 
> of many.
> 
> Best,
> 
> Joshua Bakita
> 
> On 12/14/20 10:46 PM, Joshua Bakita wrote:
>> Commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a
>> function") merged load_elf_binary and load_elf_interp into
>> load_elf_phdrs. This change imposed a limit that the program headers of
>> all ELF binaries are smaller than ELF_MIN_ALIGN. This is a mistake for
>> two reasons:
>> 1. load_elf_binary previously had no such constraint, meaning that
>>     previously valid ELF program headers are now rejected by the 
>> kernel as
>>     oversize and invalid.
>> 2. The ELF interpreter's program headers should never have been 
>> limited to
>>     ELF_MIN_ALIGN (and previously PAGE_SIZE) in the first place. Commit
>>     057f54fbba73 ("Import 1.1.54") introduced this limit to the ELF
>>     interpreter alongside the initial ELF parsing support without any
>>     explanation.
>> This patch removes the ELF_MIN_ALIGN size constraint in favor of only
>> relying on an earlier check that the allocation will be less than 64KiB.
>> (It's worth mentioning that the 64KiB limit is also unnecessarily strict,
>> but that's not addressed here for simplicity. The ELF manpage says that
>> the program header size is supposed to have at most 64 thousand entries,
>> not less than 64 thousand bytes.)
>>
>> Fixes: 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to 
>> a function")
>> Signed-off-by: Joshua Bakita <jbakita@cs.unc.edu>
>> ---
>>   fs/binfmt_elf.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 2472af2798c7..55162056590f 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -412,15 +412,11 @@ static struct elf_phdr *load_elf_phdrs(struct 
>> elfhdr *elf_ex,
>>       /* Sanity check the number of program headers... */
>>       if (elf_ex->e_phnum < 1 ||
>>           elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
>>           goto out;
>> -    /* ...and their total size. */
>>       size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
>> -    if (size > ELF_MIN_ALIGN)
>> -        goto out;
>> -
>>       elf_phdata = kmalloc(size, GFP_KERNEL);
>>       if (!elf_phdata)
>>           goto out;
>>       /* Read in the program headers */
>>
