Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06A43A5A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhJYVSz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 17:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhJYVSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:18:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A83C061243
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:16:31 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q187so11960414pgq.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Oct 2021 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WykFcEu3gun2Q4Ung304wd/4WeKNK4r+geKtd+xDG0A=;
        b=hWzvmP79GbX+2eowlYcyfK+E8HA2QNjpW0MJuY8fPca5jpPKczyuxL99sDKZ2l+n/X
         SxAyl0TSq3Ea0DALPnln0NZpNxMYwlTDA5PUU+7iHnGLqD0pZGV4hk9D1ME0tSJXqtXk
         ZUpoQQOloYhp8IUHhi9LljGkNAk/40P4+klD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WykFcEu3gun2Q4Ung304wd/4WeKNK4r+geKtd+xDG0A=;
        b=250a5Gh9WAGtzniV8y3PRHOPMP1PB8jgr6aGmI6z+TAo5ScnjLYXD2ziIoP04hcshH
         iAf4zq537OfcrOAmWBQKJEw8Kf1B2rymJUSmRR2p2YxO4THEwCxa19yuhybt5D/n8B1D
         V6vH0n0CiHZ+s5MHEyuOAHwiq9y+LhbIdv9cFAaAeqgTjHI9yglHpAjGKejsTO4HUWSZ
         d1wOClJLVsXegsVtDEnuHhxOG0ALaloHcB/1BzaF8G6ZSek3zyHJNgInATryzkR2Qidn
         B4dE50N/l7qodawjpsdAYPMbHaG+ynLUB5el72i10kZ9I5Gw3d89hzoiaymxP3aw+5jD
         uz+w==
X-Gm-Message-State: AOAM533ONCRA6yxqy1VHFe0Pjx7wpwIkmrwJ6WPq3zyn7lFJy/0AW7S6
        lT/dfJZmpmX2YWN6SaQwH/3WJw==
X-Google-Smtp-Source: ABdhPJxmKiP4mIzK9EfWIWfSZIlru2lTN121HsO8gbDbxDQk4Vut9f2sGsYffv4goiE6GSJh6quc/g==
X-Received: by 2002:a62:445:0:b0:44c:3b5b:f680 with SMTP id 66-20020a620445000000b0044c3b5bf680mr21808807pfe.30.1635196590644;
        Mon, 25 Oct 2021 14:16:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm22785970pfu.12.2021.10.25.14.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 14:16:30 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:16:29 -0700
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
Subject: Re: [PATCH v6 04/12] drivers/infiniband: make setup_ctxt always get
 a nul terminated task comm
Message-ID: <202110251415.9AD37837@keescook>
References: <20211025083315.4752-1-laoar.shao@gmail.com>
 <20211025083315.4752-5-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025083315.4752-5-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 08:33:07AM +0000, Yafang Shao wrote:
> Use strscpy_pad() instead of strlcpy() to make the comm always nul
> terminated. As the comment above the hard-coded 16, we can replace it
> with TASK_COMM_LEN, then it will adopt to the comm size change.
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
>  drivers/infiniband/hw/qib/qib.h          | 2 +-
>  drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
> index 9363bccfc6e7..a8e1c30c370f 100644
> --- a/drivers/infiniband/hw/qib/qib.h
> +++ b/drivers/infiniband/hw/qib/qib.h
> @@ -196,7 +196,7 @@ struct qib_ctxtdata {
>  	pid_t pid;
>  	pid_t subpid[QLOGIC_IB_MAX_SUBCTXT];
>  	/* same size as task_struct .comm[], command that opened context */
> -	char comm[16];
> +	char comm[TASK_COMM_LEN];
>  	/* pkeys set by this use of this ctxt */
>  	u16 pkeys[4];
>  	/* so file ops can get at unit */
> diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
> index 63854f4b6524..7ab2b448c183 100644
> --- a/drivers/infiniband/hw/qib/qib_file_ops.c
> +++ b/drivers/infiniband/hw/qib/qib_file_ops.c
> @@ -1321,7 +1321,7 @@ static int setup_ctxt(struct qib_pportdata *ppd, int ctxt,
>  	rcd->tid_pg_list = ptmp;
>  	rcd->pid = current->pid;
>  	init_waitqueue_head(&dd->rcd[ctxt]->wait);
> -	strlcpy(rcd->comm, current->comm, sizeof(rcd->comm));
> +	strscpy_pad(rcd->comm, current->comm, sizeof(rcd->comm));

This should use (the adjusted) get_task_comm() instead of leaving this
open-coded.

>  	ctxt_fp(fp) = rcd;
>  	qib_stats.sps_ctxts++;
>  	dd->freectxts--;
> -- 
> 2.17.1
> 

-- 
Kees Cook
