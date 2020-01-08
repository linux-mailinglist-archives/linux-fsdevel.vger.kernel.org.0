Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB494134B45
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgAHTJH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 14:09:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44302 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgAHTJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:09:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so4565905wrm.11;
        Wed, 08 Jan 2020 11:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EDt9PpnWYw9+1uM3iek2is+z9rkEsgm1w44H6sertTc=;
        b=dVqtXlkAXEi/9UJPPsX+UGIYgpXve2s1HFxP6xtAVZf8NJmh1ES+yeZ0QjnYcUbExI
         ettOyqIfHCpSs79eEedeeJPoqDx3z4ArfOWFSl0nhMjFp1WUxD3ntqwUBSJkSwDAguAQ
         pqk77oyUlax6ChTuUpUuGyXGcjpBdEoP1DoGEAj68y3SsB+KaoNiGN47kxfoRY3v2d2t
         aYeJRcXWcUP4ArA35L2fXEbdzkPyYRRXVd2e1wVo9tsPVFTjg66UP2MBmie0kAxsqSyt
         l5zl26C78PjIkwAPEv9BvNXQygrWoHdFOywgSgWsgBbS+DvdUKiLLlsJgn4rrAXNCLe1
         UEXg==
X-Gm-Message-State: APjAAAW3KOp/QqfdCde0+ZuAn/el9YtCBdjKelaOoNrdseBVUJYu7GKB
        HtgRk0rhzWA8XLkUnETNsv4=
X-Google-Smtp-Source: APXvYqyJVrHpKvwQw0WvOKVuy9aPtIbMWBNlGnRkVPXKDkNRRrwoqwysf3uNntLZ4Qp4lyZXxG9ixw==
X-Received: by 2002:adf:f586:: with SMTP id f6mr6115866wro.46.1578510545450;
        Wed, 08 Jan 2020 11:09:05 -0800 (PST)
Received: from darkstar ([2a04:ee41:4:500b:c62:197d:80dc:1629])
        by smtp.gmail.com with ESMTPSA id b16sm5451110wrj.23.2020.01.08.11.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jan 2020 11:09:04 -0800 (PST)
Date:   Wed, 8 Jan 2020 20:08:52 +0100
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        valentin.schneider@arm.com, qperret@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Add a new sysctl to control uclamp_util_min
Message-ID: <20200108190852.GB9635@darkstar>
References: <20191220164838.31619-1-qais.yousef@arm.com>
 <20200108134448.GG2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108134448.GG2844@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08-Jan 14:44, Peter Zijlstra wrote:
> On Fri, Dec 20, 2019 at 04:48:38PM +0000, Qais Yousef wrote:
> > RT tasks by default try to run at the highest capacity/performance
> > level. When uclamp is selected this default behavior is retained by
> > enforcing the uclamp_util_min of the RT tasks to be
> > uclamp_none(UCLAMP_MAX), which is SCHED_CAPACITY_SCALE; the maximum
> > value.
> > 
> > See commit 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks").
> > 
> > On battery powered devices, this default behavior could consume more
> > power, and it is desired to be able to tune it down. While uclamp allows
> > tuning this by changing the uclamp_util_min of the individual tasks, but
> > this is cumbersome and error prone.
> > 
> > To control the default behavior globally by system admins and device
> > integrators, introduce the new sysctl_sched_rt_uclamp_util_min to
> > change the default uclamp_util_min value of the RT tasks.
> > 
> > Whenever the new default changes, it'd be applied on the next wakeup of
> > the RT task, assuming that it still uses the system default value and
> > not a user applied one.
> 
> This is because these RT tasks are not in a cgroup or not affected by
> cgroup settings? I feel the justification is a little thin here.

RT task are kind of special right now. To keep simple the initial
implementation we hardcoded the behavior: always run at max OPP unless
explicitely asked by a task-specific value.

To add a system wide setting specifically for RT tasks, we need to
generalize what we already do for CFS tasks and keep the behavior of
the two classes aligned (apart for the default value).
IOW, no rt.c specific code should be required.

> > If the uclamp_util_min of an RT task is 0, then the RT utilization of
> > the rq is used to drive the frequency selection in schedutil for RT
> > tasks.
> 
> Did cpu_uclamp_write() forget to check for input<0 ?

The cgroup API uses percentages, which gets only sanitized [0..100].00
values.

Moreover, capacity_from_percent() returns a uclamp_request.util which
is a u64. Thus, there should not be issues related to negative values.
Writing such a value should just fail the write syscall.


-- 
#include <best/regards.h>

Patrick Bellasi
