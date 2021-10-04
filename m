Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCC7421811
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 22:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhJDUB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhJDUB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:01:58 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256FC061745
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Oct 2021 13:00:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id m21so17569065pgu.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Oct 2021 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d6Gq2wxjvSc42T6HpCo3o9gtXEpVvUYCVOoy839gL24=;
        b=Q29MVoEbK058uA4FsGGNoPe+IOo7qmxdWzqpwz6WQd9MZ9CL78KY7ipweYpC5KArK4
         NbKLZGcLMUfO6LkqrmVXaVxPnMZIAjsmQ/AXuNQusOC9b3ycPTZAEnhLKqcrBDb2QcBR
         6bgRBMdrZfDvxMDI0/0ObsuJjy6KM8sDJtXsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d6Gq2wxjvSc42T6HpCo3o9gtXEpVvUYCVOoy839gL24=;
        b=VhyIL6rQlmzkkPcc7TsjXTX8wpEz7e1i19bnVy5RNDLaA9Cs4MkmBA1LDEDyVrUwwa
         XsZXhmgZpv5KmmWfFHCu4yscW50TtcvEulrzr7Xg6OhJT9Is+b/jmsAKkQ8X9wk09v3Y
         blf0YZDJyLqZThLavr7HgXt6oXVv1upPcsHwchO/DnnIk8wzKiNOit77DoLLVeUGPb73
         EHcX6vDwMNIMZpLjzEQpnx2f8K1hLWjnY+jxZJAhm+F+Vfs00Z0AzhaMwnMYOCQkFzI1
         UrV2kPYa+8ohkpG0B+e5gR9ZeF0naLVzkgu2TNkOrir/V5H8UUiJTKfYPS9n41ODhA5t
         cC3w==
X-Gm-Message-State: AOAM532Hq+trWK25EK9J1P1As+etnQxtA29jg7SrwIs2cs0Ge6nXZbgD
        RTWiMLlsgf5ClANZjRqBHDsU6A==
X-Google-Smtp-Source: ABdhPJxM4cKpWgXOu7MUF6+yRe0HLC6gFmI/QTriTlRkZkD1E2+wved5jQO1AOrFrxegYpcStRBbpQ==
X-Received: by 2002:a05:6a00:2d0:b0:446:d18c:9aac with SMTP id b16-20020a056a0002d000b00446d18c9aacmr26961304pft.16.1633377608295;
        Mon, 04 Oct 2021 13:00:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6sm15398944pfh.63.2021.10.04.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:00:07 -0700 (PDT)
Date:   Mon, 4 Oct 2021 13:00:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chen Jingwen <chenjingwen6@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Andrei Vagin <avagin@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] elf: don't use MAP_FIXED_NOREPLACE for elf interpreter
 mappings
Message-ID: <202110041255.83A6616D9@keescook>
References: <20210928125657.153293-1-chenjingwen6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928125657.153293-1-chenjingwen6@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:56:57PM +0800, Chen Jingwen wrote:
> In commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf executable mappings")
> we still leave MAP_FIXED_NOREPLACE in place for load_elf_interp.
> Unfortunately, this will cause kernel to fail to start with
> 
> [    2.384321] 1 (init): Uhuuh, elf segment at 00003ffff7ffd000 requested but the memory is mapped already
> [    2.386240] Failed to execute /init (error -17)
> 

I guess you mean "init" fails to start (but yes, same result).

> The reason is that the elf interpreter (ld.so) has overlapping segments.

Ewww. What toolchain generated this (and what caused it to just start
happening)? (This was added in v4.17; it's been 3 years.)

> 
> readelf -l ld-2.31.so
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x000000000002c94c 0x000000000002c94c  R E    0x10000
>   LOAD           0x000000000002dae0 0x000000000003dae0 0x000000000003dae0
>                  0x00000000000021e8 0x0000000000002320  RW     0x10000
>   LOAD           0x000000000002fe00 0x000000000003fe00 0x000000000003fe00
>                  0x00000000000011ac 0x0000000000001328  RW     0x10000
> 
> The reason for this problem is the same as described in
> commit ad55eac74f20 ("elf: enforce MAP_FIXED on overlaying elf segments").
> Not only executable binaries, elf interpreters (e.g. ld.so) can have
> overlapping elf segments, so we better drop MAP_FIXED_NOREPLACE and go
> back to MAP_FIXED in load_elf_interp.

We could also just expand the logic that fixed[1] this for ELF, yes?

Andrew, are you able to pick up [1], BTW? It seems to have fallen
through the cracks.

[1] https://lore.kernel.org/all/20210916215947.3993776-1-keescook@chromium.org/T/#u

> 
> Fixes: 4ed28639519c ("fs, elf: drop MAP_FIXED usage from elf_map")
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Chen Jingwen <chenjingwen6@huawei.com>
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 69d900a8473d..a813b70f594e 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -630,7 +630,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
>  
>  			vaddr = eppnt->p_vaddr;
>  			if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
> -				elf_type |= MAP_FIXED_NOREPLACE;
> +				elf_type |= MAP_FIXED;
>  			else if (no_base && interp_elf_ex->e_type == ET_DYN)
>  				load_addr = -vaddr;


-- 
Kees Cook
