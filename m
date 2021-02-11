Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7599231947E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 21:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhBKU23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 15:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhBKU20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 15:28:26 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D910EC06178A
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 12:27:39 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id e15so5141231qte.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vubsqxgo0fEnqEVj8qEmdEXuz9badpnuh2QBKPAa7ik=;
        b=L0cWHu+kQEIeJQeqgVfSEKeUlAIaAp3+Pfe89/ZQeKN3F3bbYqLy3NJLmNUthnd4qM
         9lXIZuZcHd/WTVyGpc8G0D9A8cq4FjGHefZkv5/tTR7tWv6mOJlzXD96qRk1d8ZzLMkV
         T8dMp4h6UkEUEkD/1q9n0TI4Lbac3w9ny5gTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vubsqxgo0fEnqEVj8qEmdEXuz9badpnuh2QBKPAa7ik=;
        b=hQZAkAr5yo8XeXJsJ6zDhyhLjP+hMMrovtnsjpJc35Pyhi7J5ouPFZ0EzwXQO+u0rR
         FGOBm2xhY6bV8c/Ii2BfxlhD/P2jT6IhVD7gl+66IeWrNAF08DbyDh6wsSIhIgESRVol
         c97S/XShxs5GEK6HiT4I85BockvPZr9/xHvves+MO8ojjtgYvQ1sndqMbqF7xxvsEZKk
         JmtPqEEIr+bRXc3objoqyLMSNJXqTR7Tc8A/INM5D4UFqKc55/0q+wHJyRk7aI0u9/t4
         pDfPZOWLo1w/WqFkAYvYBm5IOv6mpB39JRwj4IzAW/BhTHnmyuSi1e0AHU0ylrQjmzJV
         tPWA==
X-Gm-Message-State: AOAM530YhK0Eu11uhgcrZ/SnhQN3wjJm4Co3kmCgQ2arOjMVQTA5ImCh
        ZmL5n5iaNrCA8kgT8dYbWruv4PVYRDb5vvrA
X-Google-Smtp-Source: ABdhPJz1jsXqn0tjNekHrH0oAqIcaYJ91d5jZ3kdxUf4iKzQWMY6sFnNTyUE8YmVpy6mVy1hAuWsBA==
X-Received: by 2002:ac8:604a:: with SMTP id k10mr8965414qtm.178.1613075258834;
        Thu, 11 Feb 2021 12:27:38 -0800 (PST)
Received: from [152.23.151.151] ([152.23.151.151])
        by smtp.gmail.com with ESMTPSA id f188sm4749827qkj.110.2021.02.11.12.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 12:27:37 -0800 (PST)
Subject: Re: [RESEND,PATCH] fs/binfmt_elf: Fix regression limiting ELF program
 header size
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201215034624.1887447-1-jbakita@cs.unc.edu>
From:   Joshua Bakita <jbakita@cs.unc.edu>
Message-ID: <7cba1c24-5034-53e1-6014-982973e66ea3@cs.unc.edu>
Date:   Thu, 11 Feb 2021 15:27:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201215034624.1887447-1-jbakita@cs.unc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello all,

I raised this patch on #linuxfs on IRC, and I got asked if this actually 
effects real programs. To demonstrate that it does, I wrote up a simple 
C program which just does a table lookup of a prime number. The table is 
stored sparsely, so newer versions of GCC+LD automatically put each 
table entry in its own program section and segment. This results in over 
100 ELF program header entries, which Linux since 3.19 will refuse to 
load with ENOEXEC due to the errant limit fixed in my patch. (The 
current broken limit is 73, whereas the manpage states a limit of 64k.)

My example program is available at 
https://www.cs.unc.edu/~jbakita/get_prime.c and should be built as gcc 
get_prime.c -o get_prime. I know this works with GCC 9.3.0 and LD 2.34 
(GCC 7.5.0 and LD 2.30 are too old). You can verify it built correctly 
by checking the "Number of program headers" as printed by readelf -h is 
at least 100.

I tried to keep this patch small to make it easy to review, but there 
are a few other bugs (like the 64KB limit) in the ELF loader. Would it 
be more helpful or make review easier to just fix all the bugs at once? 
This is my first kernel patch, and I'd really like to make it the first 
of many.

Best,

Joshua Bakita

On 12/14/20 10:46 PM, Joshua Bakita wrote:
> Commit 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a
> function") merged load_elf_binary and load_elf_interp into
> load_elf_phdrs. This change imposed a limit that the program headers of
> all ELF binaries are smaller than ELF_MIN_ALIGN. This is a mistake for
> two reasons:
> 1. load_elf_binary previously had no such constraint, meaning that
>     previously valid ELF program headers are now rejected by the kernel as
>     oversize and invalid.
> 2. The ELF interpreter's program headers should never have been limited to
>     ELF_MIN_ALIGN (and previously PAGE_SIZE) in the first place. Commit
>     057f54fbba73 ("Import 1.1.54") introduced this limit to the ELF
>     interpreter alongside the initial ELF parsing support without any
>     explanation.
> This patch removes the ELF_MIN_ALIGN size constraint in favor of only
> relying on an earlier check that the allocation will be less than 64KiB.
> (It's worth mentioning that the 64KiB limit is also unnecessarily strict,
> but that's not addressed here for simplicity. The ELF manpage says that
> the program header size is supposed to have at most 64 thousand entries,
> not less than 64 thousand bytes.)
> 
> Fixes: 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a function")
> Signed-off-by: Joshua Bakita <jbakita@cs.unc.edu>
> ---
>   fs/binfmt_elf.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 2472af2798c7..55162056590f 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -412,15 +412,11 @@ static struct elf_phdr *load_elf_phdrs(struct elfhdr *elf_ex,
>   	/* Sanity check the number of program headers... */
>   	if (elf_ex->e_phnum < 1 ||
>   		elf_ex->e_phnum > 65536U / sizeof(struct elf_phdr))
>   		goto out;
>   
> -	/* ...and their total size. */
>   	size = sizeof(struct elf_phdr) * elf_ex->e_phnum;
> -	if (size > ELF_MIN_ALIGN)
> -		goto out;
> -
>   	elf_phdata = kmalloc(size, GFP_KERNEL);
>   	if (!elf_phdata)
>   		goto out;
>   
>   	/* Read in the program headers */
> 
