Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2456810E484
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 03:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLBCXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Dec 2019 21:23:13 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:50555 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727285AbfLBCXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:23:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TjbqBc0_1575253385;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TjbqBc0_1575253385)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Dec 2019 10:23:06 +0800
Subject: Re: [PATCH v2 2/3] sched/numa: expose per-task
 pages-migration-failure
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
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
        "Paul E. McKenney" <paulmck@linux.ibm.com>
References: <743eecad-9556-a241-546b-c8a66339840e@linux.alibaba.com>
 <207ef46c-672c-27c8-2012-735bd692a6de@linux.alibaba.com>
 <3931bf05-2939-0499-7660-8cc9a6f71c9a@linux.alibaba.com>
Message-ID: <c63e9e2c-ea9e-3f61-734c-afa3b92cd5bb@linux.alibaba.com>
Date:   Mon, 2 Dec 2019 10:22:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3931bf05-2939-0499-7660-8cc9a6f71c9a@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Peter,

This has been acked by Mel Gorman, since it is not much related
with the rest patches, would you like to pick this one now?

Regards,
Michael Wang

On 2019/11/27 上午9:50, 王贇 wrote:
> NUMA balancing will try to migrate pages between nodes, which
> could caused by memory policy or numa group aggregation, while
> the page migration could failed too for eg when the target node
> run out of memory.
> 
> Since this is critical to the performance, admin should know
> how serious the problem is, and take actions before it causing
> too much performance damage, thus this patch expose the counter
> as 'migfailed' in '/proc/PID/sched'.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Koutný <mkoutny@suse.com>
> Suggested-by: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  kernel/sched/debug.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index f7e4579e746c..73c4809c8f37 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -848,6 +848,7 @@ static void sched_show_numa(struct task_struct *p, struct seq_file *m)
>  	P(total_numa_faults);
>  	SEQ_printf(m, "current_node=%d, numa_group_id=%d\n",
>  			task_node(p), task_numa_group_id(p));
> +	SEQ_printf(m, "migfailed=%lu\n", p->numa_faults_locality[2]);
>  	show_numa_stats(p, m);
>  	mpol_put(pol);
>  #endif
> 
