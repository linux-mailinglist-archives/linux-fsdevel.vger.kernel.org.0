Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2D0FDBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfD3QW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:22:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:34772 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfD3QW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:22:28 -0400
Received: by mail-it1-f193.google.com with SMTP id p18so984256itm.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IiiftTrWTfmIaDA1D3wDl83dBHWiHFdk/K80Z8+p/tA=;
        b=JkLcOFJL9M/i1B1p5XJpQbUlVntidhJ7sprGKO9xZUyLHXPEx/LjCEePFuB61sWbVf
         hOz8PUn2t0r8TjZKhrz1cak0+7sq62bSJJ6PejOuSkptjSNoCR1C+CiPWhq0aBKVUkmG
         L6KuSmUy4YT97jk0F6V3PhkDM3edTOggSMpnj4/irkkn8eb6mkG7ZSxK5luZMWiiJenU
         uYcoKym2uS7HnPmsmYXP7c4d8SQ1asj8CjclFQ8NPhYPF2RTlWkkM5qbvuqRuCxjNILo
         K1WDHVXlsx4Jjokb4H4zARr1/r3sMEf/zCOC9tTMHpCFn8EZNWKpqs1XxgNdUWChm0b5
         gWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IiiftTrWTfmIaDA1D3wDl83dBHWiHFdk/K80Z8+p/tA=;
        b=GVQmPQOYEZT/PDcpKLU5pN6EmgkPmWGXxsrQUDUZIUD3fzuQdd2iTIlGl5IcrOs9fy
         ReuOZQ1vw5E48M3Z2ZAhKlXnY5pkrEyhwDXdk1Eu+67cM+goSc0XY2vTN59jCvF0ze55
         OuGGNeyE7fo/VAY0CbxpqhWJ23Fj3cUlCQc229I58bD6BhdK4+Ymdkc7rPuFb0fiPaGS
         x6kQEWi3h+uJAkzsGVwl6qYpDnSBpBCuj03S/F2NKLAWyhxyT8ZNaoBtGvYFhOYI/f1W
         M9s9d/9ovKpOiMaxhXjtW9+72I+YQvqyOhfWnOnJDZlBSk6VnnrAFXrqCiUr1W8zYGSv
         1Trw==
X-Gm-Message-State: APjAAAUQzO/jnNK7VuUQJn2oSZ+XGdFBrXJpj/Zvesq1Ml3YL6dRWGZx
        aUf1izj22+Pg9f/EMzpaaNTIFg==
X-Google-Smtp-Source: APXvYqycvSZ06D8U48GgbHTYl0fWFp5IJNAVm7y7BWjm8BYBMRvsJEg3e+s2thRkEBTtVH1NtTw/9A==
X-Received: by 2002:a24:7347:: with SMTP id y68mr4397950itb.58.1556641346707;
        Tue, 30 Apr 2019 09:22:26 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h8sm14272577iof.36.2019.04.30.09.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:22:25 -0700 (PDT)
Subject: Re: [PATCH] io_uring: free allocated io_memory once
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.or
References: <20190430162018.40040-1-mark.rutland@arm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <89bc35e4-ae74-a15f-03fd-9f766c86315a@kernel.dk>
Date:   Tue, 30 Apr 2019 10:22:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430162018.40040-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/19 10:20 AM, Mark Rutland wrote:
> If io_allocate_scq_urings() fails to allocate an sq_* region, it will
> call io_mem_free() for any previously allocated regions, but leave
> dangling pointers to these regions in the ctx. Any regions which have
> not yet been allocated are left NULL. Note that when returning
> -EOVERFLOW, the previously allocated sq_ring is not freed, which appears
> to be an unintentional leak.
> 
> When io_allocate_scq_urings() fails, io_uring_create() will call
> io_ring_ctx_wait_and_kill(), which calls io_mem_free() on all the sq_*
> regions, assuming the pointers are valid and not NULL.
> 
> This can result in pages being freed multiple times, which has been
> observed to corrupt the page state, leading to subsequent fun. This can
> also result in virt_to_page() on NULL, resulting in the use of bogus
> page addresses, and yet more subsequent fun. The latter can be detected
> with CONFIG_DEBUG_VIRTUAL on arm64.
> 
> Adding a cleanup path to io_allocate_scq_urings() complicates the logic,
> so let's leave it to io_ring_ctx_free() to consistently free these
> pointers, and simplify the io_allocate_scq_urings() error paths.
> 
> Full splats from before this patch below. Note that the pointer logged
> by the DEBUG_VIRTUAL "non-linear address" warning has been hashed, and
> is actually NULL.
> 
> [   26.098129] page:ffff80000e949a00 count:0 mapcount:-128 mapping:0000000000000000 index:0x0
> [   26.102976] flags: 0x63fffc000000()
> [   26.104373] raw: 000063fffc000000 ffff80000e86c188 ffff80000ea3df08 0000000000000000
> [   26.108917] raw: 0000000000000000 0000000000000001 00000000ffffff7f 0000000000000000
> [   26.137235] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
> [   26.143960] ------------[ cut here ]------------
> [   26.146020] kernel BUG at include/linux/mm.h:547!
> [   26.147586] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [   26.149163] Modules linked in:
> [   26.150287] Process syz-executor.21 (pid: 20204, stack limit = 0x000000000e9cefeb)
> [   26.153307] CPU: 2 PID: 20204 Comm: syz-executor.21 Not tainted 5.1.0-rc7-00004-g7d30b2ea43d6 #18
> [   26.156566] Hardware name: linux,dummy-virt (DT)
> [   26.158089] pstate: 40400005 (nZcv daif +PAN -UAO)
> [   26.159869] pc : io_mem_free+0x9c/0xa8
> [   26.161436] lr : io_mem_free+0x9c/0xa8
> [   26.162720] sp : ffff000013003d60
> [   26.164048] x29: ffff000013003d60 x28: ffff800025048040
> [   26.165804] x27: 0000000000000000 x26: ffff800025048040
> [   26.167352] x25: 00000000000000c0 x24: ffff0000112c2820
> [   26.169682] x23: 0000000000000000 x22: 0000000020000080
> [   26.171899] x21: ffff80002143b418 x20: ffff80002143b400
> [   26.174236] x19: ffff80002143b280 x18: 0000000000000000
> [   26.176607] x17: 0000000000000000 x16: 0000000000000000
> [   26.178997] x15: 0000000000000000 x14: 0000000000000000
> [   26.181508] x13: 00009178a5e077b2 x12: 0000000000000001
> [   26.183863] x11: 0000000000000000 x10: 0000000000000980
> [   26.186437] x9 : ffff000013003a80 x8 : ffff800025048a20
> [   26.189006] x7 : ffff8000250481c0 x6 : ffff80002ffe9118
> [   26.191359] x5 : ffff80002ffe9118 x4 : 0000000000000000
> [   26.193863] x3 : ffff80002ffefe98 x2 : 44c06ddd107d1f00
> [   26.196642] x1 : 0000000000000000 x0 : 000000000000003e
> [   26.198892] Call trace:
> [   26.199893]  io_mem_free+0x9c/0xa8
> [   26.201155]  io_ring_ctx_wait_and_kill+0xec/0x180
> [   26.202688]  io_uring_setup+0x6c4/0x6f0
> [   26.204091]  __arm64_sys_io_uring_setup+0x18/0x20
> [   26.205576]  el0_svc_common.constprop.0+0x7c/0xe8
> [   26.207186]  el0_svc_handler+0x28/0x78
> [   26.208389]  el0_svc+0x8/0xc
> [   26.209408] Code: aa0203e0 d0006861 9133a021 97fcdc3c (d4210000)
> [   26.211995] ---[ end trace bdb81cd43a21e50d ]---
> 
> [   81.770626] ------------[ cut here ]------------
> [   81.825015] virt_to_phys used for non-linear address: 000000000d42f2c7 (          (null))
> [   81.827860] WARNING: CPU: 1 PID: 30171 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x48/0x68
> [   81.831202] Modules linked in:
> [   81.832212] CPU: 1 PID: 30171 Comm: syz-executor.20 Not tainted 5.1.0-rc7-00004-g7d30b2ea43d6 #19
> [   81.835616] Hardware name: linux,dummy-virt (DT)
> [   81.836863] pstate: 60400005 (nZCv daif +PAN -UAO)
> [   81.838727] pc : __virt_to_phys+0x48/0x68
> [   81.840572] lr : __virt_to_phys+0x48/0x68
> [   81.842264] sp : ffff80002cf67c70
> [   81.843858] x29: ffff80002cf67c70 x28: ffff800014358e18
> [   81.846463] x27: 0000000000000000 x26: 0000000020000080
> [   81.849148] x25: 0000000000000000 x24: ffff80001bb01f40
> [   81.851986] x23: ffff200011db06c8 x22: ffff2000127e3c60
> [   81.854351] x21: ffff800014358cc0 x20: ffff800014358d98
> [   81.856711] x19: 0000000000000000 x18: 0000000000000000
> [   81.859132] x17: 0000000000000000 x16: 0000000000000000
> [   81.861586] x15: 0000000000000000 x14: 0000000000000000
> [   81.863905] x13: 0000000000000000 x12: ffff1000037603e9
> [   81.866226] x11: 1ffff000037603e8 x10: 0000000000000980
> [   81.868776] x9 : ffff80002cf67840 x8 : ffff80001bb02920
> [   81.873272] x7 : ffff1000037603e9 x6 : ffff80001bb01f47
> [   81.875266] x5 : ffff1000037603e9 x4 : dfff200000000000
> [   81.876875] x3 : ffff200010087528 x2 : ffff1000059ecf58
> [   81.878751] x1 : 44c06ddd107d1f00 x0 : 0000000000000000
> [   81.880453] Call trace:
> [   81.881164]  __virt_to_phys+0x48/0x68
> [   81.882919]  io_mem_free+0x18/0x110
> [   81.886585]  io_ring_ctx_wait_and_kill+0x13c/0x1f0
> [   81.891212]  io_uring_setup+0xa60/0xad0
> [   81.892881]  __arm64_sys_io_uring_setup+0x2c/0x38
> [   81.894398]  el0_svc_common.constprop.0+0xac/0x150
> [   81.896306]  el0_svc_handler+0x34/0x88
> [   81.897744]  el0_svc+0x8/0xc
> [   81.898715] ---[ end trace b4a703802243cbba ]---
> 
> Fixes: 2b188cc1bb857a9d ("Add io_uring IO interface")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-block@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.or
> ---
>  fs/io_uring.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 25fc8cb56fc5..5228e9b41708 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2552,9 +2552,12 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
>  		sock_release(ctx->ring_sock);
>  #endif
>  
> -	io_mem_free(ctx->sq_ring);
> -	io_mem_free(ctx->sq_sqes);
> -	io_mem_free(ctx->cq_ring);
> +	if (ctx->sq_ring)
> +		io_mem_free(ctx->sq_ring);
> +	if (ctx->sq_sqes)
> +		io_mem_free(ctx->sq_sqes);
> +	if (ctx->cq_ring)
> +		io_mem_free(ctx->cq_ring);

Please just make io_mem_free() handle a NULL pointer so we don't need
these checks.

-- 
Jens Axboe

