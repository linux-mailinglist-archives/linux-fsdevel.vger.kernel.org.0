Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43A3216D4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGGM6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 08:58:33 -0400
Received: from foss.arm.com ([217.140.110.172]:47750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgGGM6c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:58:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D0EC0A;
        Tue,  7 Jul 2020 05:58:32 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89BFF3F71E;
        Tue,  7 Jul 2020 05:58:29 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:58:27 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Anderson <dianders@chromium.org>,
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
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] sched/uclamp: Add a new sysctl to control RT
 default boost value
Message-ID: <20200707125826.e6lrllulf6x5bqek@e107158-lin.cambridge.arm.com>
References: <20200706142839.26629-1-qais.yousef@arm.com>
 <20200706142839.26629-2-qais.yousef@arm.com>
 <jhj1rln8sfv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhj1rln8sfv.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/07/20 12:39, Valentin Schneider wrote:
> 
> On 06/07/20 15:28, Qais Yousef wrote:
> > RT tasks by default run at the highest capacity/performance level. When
> > uclamp is selected this default behavior is retained by enforcing the
> > requested uclamp.min (p->uclamp_req[UCLAMP_MIN]) of the RT tasks to be
> > uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> > value.
> >
> > This is also referred to as 'the default boost value of RT tasks'.
> >
> > See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> >
> > On battery powered devices, it is desired to control this default
> > (currently hardcoded) behavior at runtime to reduce energy consumed by
> > RT tasks.
> >
> > For example, a mobile device manufacturer where big.LITTLE architecture
> > is dominant, the performance of the little cores varies across SoCs, and
> > on high end ones the big cores could be too power hungry.
> >
> > Given the diversity of SoCs, the new knob allows manufactures to tune
> > the best performance/power for RT tasks for the particular hardware they
> > run on.
> >
> > They could opt to further tune the value when the user selects
> > a different power saving mode or when the device is actively charging.
> >
> > The runtime aspect of it further helps in creating a single kernel image
> > that can be run on multiple devices that require different tuning.
> >
> > Keep in mind that a lot of RT tasks in the system are created by the
> > kernel. On Android for instance I can see over 50 RT tasks, only
> > a handful of which created by the Android framework.
> >
> > To control the default behavior globally by system admins and device
> > integrator, introduce the new sysctl_sched_uclamp_util_min_rt_default
> > to change the default boost value of the RT tasks.
> >
> > I anticipate this to be mostly in the form of modifying the init script
> > of a particular device.
> >
> 
> Sorry for going at this again, but I feel like I can squeeze more juice out
> of this.
> 
> This being mainly tweaked in init scripts makes me question why we should
> harden this for runtime tweaking. Yes, there's the whole single image
> thing, but there's other ways to have different init-time values on a
> single image (e.g. cmdline, although that one is usually a bit
> controversial).

cmdline is not userfriendly. A person who installs a new distro on their laptop
can easily modify a sysctl knob to squeeze maximum battery life, but not play
with grub and bootloader to add a cmdline option.

> 
> For instance, Android could set the min to 0 and then go about its life
> tweaking the clamp of individual / all RT tasks at runtime, using the
> existing uclamp API.

This was addressed before. This is not flexible and having a daemon that
monitors RT tasks as they come and go is terrible IMO.

If you're suggesting to hardcode it to 0, then this is not what we're trying to
achieve here.

I don't think we've hit a wall where things look really ugly to not continue
pursue this flexible and more robust solution.

Thanks

--
Qais Yousef
