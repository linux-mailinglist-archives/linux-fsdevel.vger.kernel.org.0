Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C95215967
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgGFO25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 10:28:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45100 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbgGFO25 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:28:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B40630E;
        Mon,  6 Jul 2020 07:28:56 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0773F71E;
        Mon,  6 Jul 2020 07:28:53 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Qais Yousef <qais.yousef@arm.com>,
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
Subject: [PATCH v6 0/2] sched/uclamp: new sysctl for default RT boost value
Date:   Mon,  6 Jul 2020 15:28:37 +0100
Message-Id: <20200706142839.26629-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series introduces a new sysctl_sched_uclamp_util_min_rt_default to control
at runtime the default boost value of RT tasks.

Full rationale is in patch 1 commit message.

v6 has changed the approach taken in v5 [1] and earlier by moving away from the
lazy update approach that touched the fast path to a synchronous one that is
performed when the write to the procfs entry is done.

for_each_process_thread() is used to update all existing RT tasks now. And to
handle the race with a concurrent fork() we introduce sched_post_fork() in
_do_fork() to ensure a concurrently forked RT tasks gets the right update.

To ensure the race condition is handled correctly, I wrote this small (simple!)
test program:

	https://github.com/qais-yousef/uclamp_test.git

And ran it on 4core x86 system and 8core big.LITTLE juno-r2 system.

From juno-r2 run, 10 iterations each run:

Without sched_post_fork()

	# ./run.sh
	pid 3105 has 336 but default should be 337
	pid 13162 has 336 but default should be 337
	pid 23256 has 338 but default should be 339
	All forked RT tasks had the correct uclamp.min
	pid 10638 has 334 but default should be 335
	All forked RT tasks had the correct uclamp.min
	pid 30683 has 335 but default should be 336
	pid 8247 has 336 but default should be 337
	pid 18170 has 1024 but default should be 334
	pid 28274 has 336 but default should be 337

With sched_post_fork()

	# ./run.sh
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min
	All forked RT tasks had the correct uclamp.min

Thanks

--
Qais Yousef

[1] https://lore.kernel.org/lkml/20200511154053.7822-1-qais.yousef@arm.com/

CC: Jonathan Corbet <corbet@lwn.net>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Kees Cook <keescook@chromium.org>
CC: Iurii Zaikin <yzaikin@google.com>
CC: Quentin Perret <qperret@google.com>
CC: Valentin Schneider <valentin.schneider@arm.com>
CC: Patrick Bellasi <patrick.bellasi@matbug.net>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org

Qais Yousef (2):
  sched/uclamp: Add a new sysctl to control RT default boost value
  Documentation/sysctl: Document uclamp sysctl knobs

 Documentation/admin-guide/sysctl/kernel.rst |  54 ++++++++
 include/linux/sched/sysctl.h                |   1 +
 include/linux/sched/task.h                  |   1 +
 kernel/fork.c                               |   1 +
 kernel/sched/core.c                         | 132 ++++++++++++++++++--
 kernel/sysctl.c                             |   7 ++
 6 files changed, 189 insertions(+), 7 deletions(-)

-- 
2.17.1

