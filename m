Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF61E6222
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 15:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbgE1NXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390295AbgE1NXt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 09:23:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B27C05BD1E;
        Thu, 28 May 2020 06:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=876zKjaeAoHItKy5v6K+oJgLPOJlwJDj+y9Y+u5ub3Q=; b=oCffCv1kWlYM7vfE13NaT/An7r
        FivxfRrag/U7kCLFWrdaTBOn1MfgamU6vtb7+86bOlktrTuPU0RMc7tN8UBT66EdDHqq9wKLsBQwB
        BheUjDeh1TCkHl904kAKiyVFjkgm9qGMjitFbP0vIBf7o9YDTUSegr2VGOoABaxqQs0adNbRROgFK
        bvNf6ZMqbKBfKdm18q8XE4YAYrMT2/cEq2caDtfQ2VJiJ8QUZB/w6gPJSQVNqMOp1J1RjMcDYU2Kb
        sRZdgxRBV7TY0InZfFLKWsUxav6oCggbvU7rLVIx6d97gCuIe5HxWQtqUre10DFvb21uVR8jTDgLJ
        n2Vl6v4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeIVQ-00056k-0N; Thu, 28 May 2020 13:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C9832307643;
        Thu, 28 May 2020 15:23:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD35D20D0904E; Thu, 28 May 2020 15:23:27 +0200 (CEST)
Date:   Thu, 28 May 2020 15:23:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200528132327.GB706460@hirez.programming.kicks-ass.net>
References: <20200511154053.7822-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511154053.7822-1-qais.yousef@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 04:40:52PM +0100, Qais Yousef wrote:
> +/*
> + * By default RT tasks run at the maximum performance point/capacity of the
> + * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
> + * SCHED_CAPACITY_SCALE.
> + *
> + * This knob allows admins to change the default behavior when uclamp is being
> + * used. In battery powered devices, particularly, running at the maximum
> + * capacity and frequency will increase energy consumption and shorten the
> + * battery life.
> + *
> + * This knob only affects RT tasks that their uclamp_se->user_defined == false.
> + *
> + * This knob will not override the system default sched_util_clamp_min defined
> + * above.
> + *
> + * Any modification is applied lazily on the next attempt to calculate the
> + * effective value of the task.
> + */
> +unsigned int sysctl_sched_uclamp_util_min_rt_default = SCHED_CAPACITY_SCALE;
> +
>  /* All clamps are required to be less or equal than these values */
>  static struct uclamp_se uclamp_default[UCLAMP_CNT];
>  
> @@ -872,6 +892,28 @@ unsigned int uclamp_rq_max_value(struct rq *rq, enum uclamp_id clamp_id,
>  	return uclamp_idle_value(rq, clamp_id, clamp_value);
>  }
>  
> +static inline void uclamp_sync_util_min_rt_default(struct task_struct *p,
> +						   enum uclamp_id clamp_id)
> +{
> +	unsigned int default_util_min = sysctl_sched_uclamp_util_min_rt_default;
> +	struct uclamp_se *uc_se;
> +
> +	/* Only sync for UCLAMP_MIN and RT tasks */
> +	if (clamp_id != UCLAMP_MIN || !rt_task(p))
> +		return;
> +
> +	uc_se = &p->uclamp_req[UCLAMP_MIN];
> +
> +	/*
> +	 * Only sync if user didn't override the default request and the sysctl
> +	 * knob has changed.
> +	 */
> +	if (uc_se->user_defined || uc_se->value == default_util_min)
> +		return;
> +
> +	uclamp_se_set(uc_se, default_util_min, false);
> +}

So afaict this is directly added to the enqueue/dequeue path, and we've
recently already had complaints that uclamp is too slow.

Is there really no other way?
