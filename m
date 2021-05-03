Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED92371FE1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhECSr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhECSrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 14:47:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79BCC061761
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 May 2021 11:46:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t18so6663924wry.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 May 2021 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Amr9TVs27FxtVOmr0nrzqRE5o3ox/iYMhBzcq+PDVKg=;
        b=chDFELazuzknpzzSIq1xhX/vzpRxEm/RAvX47Oo0wCj9JarLRRD1FV2TruIT+nvuG6
         Cu74aqhTT9XT9tMKkJG69n7m5ffLMUZPhZRBC/rBynO2KUj4LDt3nt5C0yelD3hONOp3
         yRDK3i7iLRoeAYgmpa+GwpEtXs4KYQfmal+u6HzPFTgORD738GBnZNDmXiqqFfSgDVxE
         T4VLU6nbeOh2LGgBECpwXaoG4xnCNDImueMXDEzfDjzPMd8cqEP2Gx2JFv/fDfADPtK+
         inBn9unXsmIcFOLj9z6VuI+o7qwyMiBV/MhBNAghoUP7AmWYWnogF11aq9jZPHXJeOZU
         WfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Amr9TVs27FxtVOmr0nrzqRE5o3ox/iYMhBzcq+PDVKg=;
        b=T1kIjyBcRCCLBYBivWVqRlvmwBc5fkUMDr4daQhFBo8x7JEmkcGrGGP8Pcic+Elou/
         2gmurei8+KYybGFtFAo8PtprhOo8XfTgKVSz9MDSTtxOQgIJyQCoa5EGKG2+zYwgq+N8
         wQmfAoGPSnmtP2Nr2RlpV0qRMcoIXhQHmrAMqzoPawoVgOZlOKahmoQdpkx1kskdG3JL
         XAJUdqXzoP+oYUbK2hkeW4Hn8hqMcobFJEfq+rgUflY5WtWJ2FFSBL0tmHGfbG65HRrg
         pPL3aDDfPf3jsQDLJgmun4eI7dzX9svl8LyD5dyOmVtLHoV5HwREhFaujD05s+2ATXUn
         zx0Q==
X-Gm-Message-State: AOAM533io8myI4mf/b6S6zJ9qBktNFgrsz9igXjrjzwgybvLwJ3tzRQ4
        ihg2TGkVM84isfS7XYk7kULSDQ==
X-Google-Smtp-Source: ABdhPJyfxW0swHJoR911kqP/dzWnxsFI7AOGcDFTEvRuVYBRFCIANcgwlpjWLmjnuRxMTpkLV18m6Q==
X-Received: by 2002:a5d:5310:: with SMTP id e16mr3631274wrv.321.1620067589456;
        Mon, 03 May 2021 11:46:29 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:aa2:5da4:ba57:b7e7])
        by smtp.gmail.com with ESMTPSA id i3sm14573640wrb.46.2021.05.03.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:46:28 -0700 (PDT)
Date:   Mon, 3 May 2021 20:46:23 +0200
From:   Marco Elver <elver@google.com>
To:     Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     trivial@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Tejun Heo <htejun@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH] poll: Ignore benign race on pwd->triggered
Message-ID: <YJBE/3nzZV3pazGx@elver.google.com>
References: <20210429034411.6379-1-baptiste.lepers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429034411.6379-1-baptiste.lepers@gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the patch -- any progress on this front is much appreciated.

However, the subject is not really doing this patch justice. We're not
ignoring the race -- and if by "ignore" you mean let KCSAN ignore the
race, then it's more like saying "we'll make the sanitizer not report
this problem anymore... by fixing the problem".

I'd suggest, similar to wording below:

	"poll: mark racy accesses on pwq->triggered"

Data races are real, and even though at a high-level (where we pretend
all accesses are atomic) these races are safe and intentional, it it not
at all clear to the reader why the data race would be "benign" -- that
is if the compiler optimized or miscompiled the code in such a way that
we end up with cases unintended by the programmer.

In this case, we can probably argue that the data race would be safe
(benign), given there's a simple 0->1 transition on triggered, and the
reader only doing a compare-against-0.

Nevertheless, a READ_ONCE()/WRITE_ONCE() pair is preferred if there are
no objections, and generated code almost always is the same, and it
saves us reasoning about another use of data_race().

Paul recently summarized some of these strategies:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

On Thu, Apr 29, 2021 at 01:44PM +1000, Baptiste Lepers wrote:
> Mark data races to pwd->triggered as benign using READ_ONCE and
> WRITE_ONCE. These accesses are expected to be racy per comment.

This sounds fine, given there's already a comment.

> This patch is part of a series of patches aiming at reducing the number
> of benign races reported by KCSAN in order to focus future debugging
> effort on harmful races.

Looking forward to the rest.

> Reported-by: syzbot+9b3fb64bcc8c1d807595@syzkaller.appspotmail.com
> Fixes: 5f820f648c92a ("poll: allow f_op->poll to sleep")
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>

Acked-by: Marco Elver <elver@google.com>

> ---
>  fs/select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 945896d0ac9e..e71b4d1a2606 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -194,7 +194,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
>  	 * and is paired with smp_store_mb() in poll_schedule_timeout.
>  	 */
>  	smp_wmb();
> -	pwq->triggered = 1;
> +	WRITE_ONCE(pwq->triggered, 1);
>  
>  	/*
>  	 * Perform the default wake up operation using a dummy
> @@ -239,7 +239,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
>  	int rc = -EINTR;
>  
>  	set_current_state(state);
> -	if (!pwq->triggered)
> +	if (!READ_ONCE(pwq->triggered))
>  		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
>  	__set_current_state(TASK_RUNNING);
>  
> -- 
> 2.17.1
