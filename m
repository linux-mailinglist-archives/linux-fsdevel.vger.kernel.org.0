Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0963F483C37
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 08:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbiADH1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 02:27:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37202 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiADH1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 02:27:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 529E3B81155;
        Tue,  4 Jan 2022 07:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04620C36AE9;
        Tue,  4 Jan 2022 07:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641281228;
        bh=YAiWEaNKF4OI+SkuBr/lyYfKRYi/Gm5pnRDcrQZpCmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6Dr+J3eoIPr88f5SrpQUnwUrZXyoXl/kT2XVwpgjzziwr/C0+obD7+XFPCiS5pA7
         LcOcSUxCPaH9WAurgjU7r0c4wPzq25/p67w0pWTMTlO2xSFot/3nCYkkTHfEZaY/aE
         +8m2UB+PCmWQCSUeqB1Kj9ZqkVXPMfEwduaVkorc=
Date:   Tue, 4 Jan 2022 08:27:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Walt Drummond <walt@drummond.us>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 8/8] signals: Support BSD VSTATUS, KERNINFO and
 SIGINFO
Message-ID: <YdP2yvYfmMp3QKKi@kroah.com>
References: <20220103181956.983342-1-walt@drummond.us>
 <20220103181956.983342-9-walt@drummond.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103181956.983342-9-walt@drummond.us>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 03, 2022 at 10:19:56AM -0800, Walt Drummond wrote:
> Support TTY VSTATUS character, NOKERNINFO local control bit and the
> signal SIGINFO, all as in 4.3BSD.

I am sorry, but this changelog text does not make any sense to me at
all.  It needs to be much more detailed and explain why you are doing
this and what exactly it is doing as I have no idea.

Also, you seem to be adding new user/kernel apis here with no
documentation that I can see, nor any tests.  So how is anyone supposed
to use this?

And finally:

> --- /dev/null
> +++ b/drivers/tty/tty_status.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-1.0+

Please no, you know better than that, and the checkpatch tool should
have warned you.


> +/*
> + * tty_status.c --- implements VSTATUS and TIOCSTAT from BSD4.3/4.4
> + *
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/tty.h>
> +#include <linux/sched/cputime.h>
> +#include <linux/sched/loadavg.h>
> +#include <linux/pid.h>
> +#include <linux/slab.h>
> +#include <linux/math64.h>
> +
> +#define MSGLEN (160 + TASK_COMM_LEN)
> +
> +inline unsigned long getRSSk(struct mm_struct *mm)
> +{
> +	if (mm == NULL)
> +		return 0;
> +	return get_mm_rss(mm) * PAGE_SIZE / 1024;
> +}
> +
> +inline long nstoms(long l)
> +{
> +	l /= NSEC_PER_MSEC * 10;
> +	if (l < 10)
> +		l *= 10;
> +	return l;
> +}
> +
> +inline struct task_struct *compare(struct task_struct *new,
> +				   struct task_struct *old)
> +{
> +	unsigned int ostate, nstate;
> +
> +	if (old == NULL)
> +		return new;
> +
> +	ostate = task_state_index(old);
> +	nstate = task_state_index(new);
> +
> +	if (ostate == nstate) {
> +		if (old->start_time > new->start_time)
> +			return old;
> +		return new;
> +	}
> +
> +	if (ostate < nstate)
> +		return old;
> +
> +	return new;
> +}
> +
> +struct task_struct *pick_process(struct pid *pgrp)

Also, always run sparse on your changes, you have loads of new global
functions for no reason.

thanks,

greg k-h
