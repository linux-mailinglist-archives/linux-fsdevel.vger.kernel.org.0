Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E32C47E3A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243742AbhLWMky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:40:54 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:57985 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233015AbhLWMky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:40:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V.XbQOB_1640263250;
Received: from 30.21.164.116(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V.XbQOB_1640263250)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Dec 2021 20:40:51 +0800
Message-ID: <10c12ba2-81cc-1f26-f48f-66b95db2c4ec@linux.alibaba.com>
Date:   Thu, 23 Dec 2021 20:40:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] Forced idle time accounting per cpu
Content-Language: en-US
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     adobriyan@gmail.com, joshdon@google.com, edumazet@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's also a problem confused me: how to account the uncookie'd forced
idle from the perspective of task. A feasible method is to divide the
uncookie'd forced idle time by the number of tasks in the core_tree, and
add the result to these tasks, but it will cost a lot on traversing the
core_tree.

在 2021/12/23 下午8:30, Cruz Zhao 写道:
> Josh Don's patch 4feee7d12603 ("sched/core: Forced idle accounting")
> provides one means to measure the cost of enabling core scheduling
> from the perspective of the task, and this patchset provides another
> means to do that from the perspective of the cpu.
> 
> Forced idle can be divided into two types, forced idle with cookie'd task
> running on it SMT sibling, and forced idle with uncookie'd task running
> on it SMT sibling, which should be accounting to measure the cost of
> enabling core scheduling too. This patchset accounts both and the sum
> of both, which are displayed via /proc/stat.
> 
> Cruz Zhao (2):
>   sched/core: Cookied forceidle accounting per cpu
>   sched/core: Uncookied force idle accounting per cpu
> 
>  fs/proc/stat.c              | 26 ++++++++++++++++++++++++++
>  include/linux/kernel_stat.h |  4 ++++
>  kernel/sched/core.c         |  7 +++----
>  kernel/sched/core_sched.c   | 21 +++++++++++++++++++--
>  kernel/sched/sched.h        | 10 ++--------
>  5 files changed, 54 insertions(+), 14 deletions(-)
> 
> base commit: 2850c2311ef4bf30ae8dd8927f0f66b026ff08fb
> 
