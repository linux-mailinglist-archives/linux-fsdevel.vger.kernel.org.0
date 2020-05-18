Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664671D7F1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgERQtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 12:49:35 -0400
Received: from foss.arm.com ([217.140.110.172]:44270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgERQtf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 12:49:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD5D8106F;
        Mon, 18 May 2020 09:49:34 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683E73F305;
        Mon, 18 May 2020 09:49:32 -0700 (PDT)
Date:   Mon, 18 May 2020 17:49:30 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200518164929.dja4ry6iiq3jny72@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <01c318b6-a109-2b8a-0ac3-a25b3c61e45a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01c318b6-a109-2b8a-0ac3-a25b3c61e45a@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05/18/20 10:31, Dietmar Eggemann wrote:
> On 11/05/2020 17:40, Qais Yousef wrote:
> 
> [..]
> 
> > @@ -790,6 +790,26 @@ unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
> >  /* Max allowed maximum utilization */
> >  unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> >  
> > +/*
> > + * By default RT tasks run at the maximum performance point/capacity of the
> > + * system. Uclamp enforces this by always setting UCLAMP_MIN of RT tasks to
> > + * SCHED_CAPACITY_SCALE.
> > + *
> > + * This knob allows admins to change the default behavior when uclamp is being
> > + * used. In battery powered devices, particularly, running at the maximum
> > + * capacity and frequency will increase energy consumption and shorten the
> > + * battery life.
> > + *
> > + * This knob only affects RT tasks that their uclamp_se->user_defined == false.
> 
> Nit pick: Isn't there a verb missing in this sentence?
> 
> [...]
> 
> > @@ -1114,12 +1161,13 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  				loff_t *ppos)
> >  {
> >  	bool update_root_tg = false;
> > -	int old_min, old_max;
> > +	int old_min, old_max, old_min_rt;
> 
> Nit pick: Order local variable declarations according to length.
> 
> [...]
> 
> > @@ -1128,7 +1176,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
> >  		goto done;
> >  
> >  	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
> > -	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
> > +	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE		||
> 
> Nit pick: This extra space looks weird to me.
> 
> [...]
> 
> Apart from that, LGTM
> 
> For both patches of this v5:
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks Dietmar and Patrick.

Peter, let me know if you'd like me to address the nitpicks or you're okay with
this as-is.

Thanks!

--
Qais Yousef
