Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE1385E00
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfHHJQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:16:20 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39934 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbfHHJQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:16:20 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so12501514lfn.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2019 02:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M0Lkp7TI/1lX0PjPf1h84OWxjj1q7OPrwwtMkQUMB80=;
        b=Z1XISyDmNMrKzhH5jpoXRm+UDpftCfPHsXSHiMp386hpt6qzA47mI+MZCjhh8/Zeyw
         jokbLjILXaPIhi16o8/c61dqditvR/MIYHeLbkQyQnW1HIi9UnftiHokpg6qK507fm7J
         Af4qYSS1b0OGvvXKHezXLIVBZAA22zNmMLXIgrCO7kd7HL9v99JBKOfmG2a8I4SKpTHT
         bYqs+AyT4ajWAbpBYl2QGZEPQO6YYKHDcpVDFpxR617xywNAkq8MTsHvEe09qcGQm0N/
         Q2SBZWzsoeIcTUgNNHs8jSQHhyhyqyNLDF5nH869msJXyFVwIVvvUIWwVSw8UZZBa3BW
         /xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M0Lkp7TI/1lX0PjPf1h84OWxjj1q7OPrwwtMkQUMB80=;
        b=otAgDbv7wlcVh2Jl0B7JxNvJ4OpwcOQN1qBqmkkoH2R3iGUs5hnLPIo5s+V+XIsVCX
         ZK4w1mckXeucF6X2Qw8kjXKqJU2kMglQonvE81mZdQ1NoRI9mz/PqERWKmf4nHQuTa0N
         zdnP3HTiVDVDF+laD9kWbl6qHLakNru/6SvbvRaC8+qxBrhC1qVTrPC4ao1wfwI4dICV
         qODOMKla+El9uJ9Zjz6A/nW+rsXMmHe5cziSNzk7CjHC3Z1xmvdxrDoEDLBcO/9IelRZ
         8SaSsli0JXWNE2HSMnh1cWNBxazxkBybZ3nZ42guMUwOoi1tSA9XkK/VuDydWNWIHQeq
         h71g==
X-Gm-Message-State: APjAAAXK8ePLQdtjaBGvMJuj4PumREJpEZ8brNtWFES8hx5wHnH8wiqT
        aLoK0iEoykvqm3YfydDPGbBjZg==
X-Google-Smtp-Source: APXvYqwAZY8WXCeiGX2n+XECYEd8x3LcF9hNec57wPu9uZBuLdOygGHP8AmFYhQOUjDhlaSnPEqcXw==
X-Received: by 2002:a19:c711:: with SMTP id x17mr8605646lff.147.1565255778647;
        Thu, 08 Aug 2019 02:16:18 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:8c7:ada9:25b2:24d8:3973:eb87? ([2a00:1fa0:8c7:ada9:25b2:24d8:3973:eb87])
        by smtp.gmail.com with ESMTPSA id f23sm406561lfc.25.2019.08.08.02.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 02:16:17 -0700 (PDT)
Subject: Re: [PATCH v6 09/14] mips: Properly account for stack randomization
 and stack guard gap
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190808061756.19712-1-alex@ghiti.fr>
 <20190808061756.19712-10-alex@ghiti.fr>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <bd67507e-8a5b-34b5-1a33-5500bbb724b2@cogentembedded.com>
Date:   Thu, 8 Aug 2019 12:16:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808061756.19712-10-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On 08.08.2019 9:17, Alexandre Ghiti wrote:

> This commit takes care of stack randomization and stack guard gap when
> computing mmap base address and checks if the task asked for randomization.
> 
> This fixes the problem uncovered and not fixed for arm here:
> https://lkml.kernel.org/r/20170622200033.25714-1-riel@redhat.com
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: Paul Burton <paul.burton@mips.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   arch/mips/mm/mmap.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index d79f2b432318..f5c778113384 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -21,8 +21,9 @@ unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>   EXPORT_SYMBOL(shm_align_mask);
>   
>   /* gap between mmap and stack */
> -#define MIN_GAP (128*1024*1024UL)
> -#define MAX_GAP ((TASK_SIZE)/6*5)
> +#define MIN_GAP		(128*1024*1024UL)
> +#define MAX_GAP		((TASK_SIZE)/6*5)

    Could add spaces around *, while touching this anyway? And parens
around TASK_SIZE shouldn't be needed...

> +#define STACK_RND_MASK	(0x7ff >> (PAGE_SHIFT - 12))
>   
>   static int mmap_is_legacy(struct rlimit *rlim_stack)
>   {
> @@ -38,6 +39,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
>   static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
>   {
>   	unsigned long gap = rlim_stack->rlim_cur;
> +	unsigned long pad = stack_guard_gap;
> +
> +	/* Account for stack randomization if necessary */
> +	if (current->flags & PF_RANDOMIZE)
> +		pad += (STACK_RND_MASK << PAGE_SHIFT);

    Parens not needed here.

> +
> +	/* Values close to RLIM_INFINITY can overflow. */
> +	if (gap + pad > gap)
> +		gap += pad;
>   
>   	if (gap < MIN_GAP)
>   		gap = MIN_GAP;
> 

