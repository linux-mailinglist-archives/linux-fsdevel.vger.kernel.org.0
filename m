Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D871550FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBGDe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:34:59 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60017 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgBGDe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:34:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04428;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0TpKMeB3_1581046489;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TpKMeB3_1581046489)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 Feb 2020 11:34:49 +0800
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [PATCH RESEND v8 0/2] sched/numa: introduce numa locality
Message-ID: <fe56d99d-82e0-498c-ae44-f7cde83b5206@linux.alibaba.com>
Date:   Fri, 7 Feb 2020 11:34:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v8:
  * document edited
v7:
  * rebased on latest linux-next
v6:
  * fix compile failure when NUMA disabled
v5:
  * improved documentation
v4:
  * fix comments and improved documentation
v3:
  * simplified the locality concept & implementation
v2:
  * improved documentation

Modern production environment could use hundreds of cgroup to control
the resources for different workloads, along with the complicated
resource binding.

On NUMA platforms where we have multiple nodes, things become even more
complicated, we hope there are more local memory access to improve the
performance, and NUMA Balancing keep working hard to achieve that,
however, wrong memory policy or node binding could easily waste the
effort, result a lot of remote page accessing.

We need to notice such problems, then we got chance to fix it before
there are too much damages, however, there are no good monitoring
approach yet to help catch the mouse who introduced the remote access.

This patch set is trying to fill in the missing pieces， by introduce
the per-cgroup NUMA locality info, with this new statistics, we could
achieve the daily monitoring on NUMA efficiency, to give warning when
things going too wrong.

Please check the second patch for more details.

Michael Wang (2):
  sched/numa: introduce per-cgroup NUMA locality info
  sched/numa: documentation for per-cgroup numa statistics

 Documentation/admin-guide/cg-numa-stat.rst      | 178 ++++++++++++++++++++++++
 Documentation/admin-guide/index.rst             |   1 +
 Documentation/admin-guide/kernel-parameters.txt |   4 +
 Documentation/admin-guide/sysctl/kernel.rst     |   9 ++
 include/linux/sched.h                           |  15 ++
 include/linux/sched/sysctl.h                    |   6 +
 init/Kconfig                                    |  11 ++
 kernel/sched/core.c                             |  75 ++++++++++
 kernel/sched/fair.c                             |  62 +++++++++
 kernel/sched/sched.h                            |  12 ++
 kernel/sysctl.c                                 |  11 ++
 11 files changed, 384 insertions(+)
 create mode 100644 Documentation/admin-guide/cg-numa-stat.rst

-- 
2.14.4.44.g2045bb6

