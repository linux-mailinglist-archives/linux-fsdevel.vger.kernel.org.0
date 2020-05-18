Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C8F1D72FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgERIcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 04:32:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERIcH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 04:32:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60807106F;
        Mon, 18 May 2020 01:32:06 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC403F305;
        Mon, 18 May 2020 01:32:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
References: <20200511154053.7822-1-qais.yousef@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <01c318b6-a109-2b8a-0ac3-a25b3c61e45a@arm.com>
Date:   Mon, 18 May 2020 10:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511154053.7822-1-qais.yousef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/05/2020 17:40, Qais Yousef wrote:

[..]

> @@ -790,6 +790,26 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
>  /* Max allowed maximum utilization */
>  unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
>  
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

Nit pick: Isn't there a verb missing in this sentence?

[...]

> @@ -1114,12 +1161,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  				loff_t *ppos)
>  {
>  	bool update_root_tg = false;
> -	int old_min, old_max;
> +	int old_min, old_max, old_min_rt;

Nit pick: Order local variable declarations according to length.

[...]

> @@ -1128,7 +1176,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
>  		goto done;
>  
>  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
> -	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
> +	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE		||

Nit pick: This extra space looks weird to me.

[...]

Apart from that, LGTM

For both patches of this v5:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
