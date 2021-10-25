Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E543A5C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 23:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhJYVXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhJYVXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:23:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36BC061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:21:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id f5so11919414pgc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dg+3da77xCN0ept3lU6Adg5MAj44I6g+k6oh+Yv/Wmk=;
        b=ZZAE5vvBlXBqmnqPeVDMpzNlRMG4f8aUTMM11B3Wt0yaKexrHt55FQmO5u1fD7bidR
         02xhl5QvTcmR3cGt0oq36GHl7u+9soV9E6KhT6dXaK6gGrqfTsgCADyJ2v6e5SSMny1K
         kHJTuEDYeo3h4PCPdtNNG1VGr+EIBO7xWhzuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dg+3da77xCN0ept3lU6Adg5MAj44I6g+k6oh+Yv/Wmk=;
        b=1MZPpfqQzblcryh2CJ820YepucNFC7H1jIsEu/W+DO9FzBtkeeh++8hnxJkpu+Jrjo
         xIcz6LKT0VBS+QyYKAXPywpixBARumt861oPhYF9e7d1Qs2omry0xek4lDRyEi1O1DAY
         tkm7g54flvC5zAwtVVKfIpYgefXCbsfMzr1zLhhHbRhYyux0ERCQYYQgh8uGEtLTt0tf
         hA0+eIh1DZL+Jjrx2pxJtR87gWSHB+3n7xYpjup5/0erc1XRa4ab0dVLyKm1bmiodE/E
         AA9k7K0cWeIVaofM/c4GHg/IL5o6V+eMx3sUAbrgyAhTvOjurViERvmWLUQGk8pOHK8N
         Hs5Q==
X-Gm-Message-State: AOAM532ZrRtmjuacxRPyEELbI6S8XfDjNT/GVPWchGtLKjhL350d417z
        AqdkwoxFt5BNn9ahj6p13vY7oQ==
X-Google-Smtp-Source: ABdhPJwuFvhpOg9qcPmPW8fWT61xDymkszr5XQdULAP3e/U/Jqkxh9G7sdKWk3bNge4o+fhW5E7j4Q==
X-Received: by 2002:a63:7c52:: with SMTP id l18mr9384968pgn.112.1635196887256;
        Mon, 25 Oct 2021 14:21:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j3sm20621719pfu.218.2021.10.25.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:21:26 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:21:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     akpm@linux-foundation.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
        pmladek@suse.com, peterz@infradead.org, viro@zeniv.linux.org.uk,
        valentin.schneider@arm.com, qiang.zhang@windriver.com,
        robdclark@chromium.org, christian@brauner.io,
        dietmar.eggemann@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com, lkp@intel.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH v6 07/12] samples/bpf/offwaketime_kern: make sched_switch
 tracepoint args adopt to comm size change
Message-ID: <202110251421.0CD56F8@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-8-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-8-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:10AM +0000, Yafang Shao wrote:
> The sched:sched_switch tracepoint is derived from kernel, we should make
> its args compitable with the kernel.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> ---
>  samples/bpf/offwaketime_kern.c | 4 ++--

Seems this should be merged with the prior bpf samples patch?

-Kees

>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/bpf/offwaketime_kern.c b/samples/bpf/offwaketime_kern.c
> index 4866afd054da..eb4d94742e6b 100644
> --- a/samples/bpf/offwaketime_kern.c
> +++ b/samples/bpf/offwaketime_kern.c
> @@ -113,11 +113,11 @@ static inline int update_counts(void *ctx, u32 pid, u64 delta)
>  /* taken from /sys/kernel/debug/tracing/events/sched/sched_switch/format */
>  struct sched_switch_args {
>  	unsigned long long pad;
> -	char prev_comm[16];
> +	char prev_comm[TASK_COMM_LEN];
>  	int prev_pid;
>  	int prev_prio;
>  	long long prev_state;
> -	char next_comm[16];
> +	char next_comm[TASK_COMM_LEN];
>  	int next_pid;
>  	int next_prio;
>  };
> -- 
> 2.17.1
> 

-- 
Kees Cook
