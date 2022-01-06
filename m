Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC9648641B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 13:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiAFMFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 07:05:08 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:42695 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbiAFMFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 07:05:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0V164GZB_1641470704;
Received: from 30.21.164.187(mailfrom:cruzzhao@linux.alibaba.com fp:SMTPD_---0V164GZB_1641470704)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 20:05:05 +0800
Message-ID: <3dc03eec-e88c-f886-efd5-81162350f12c@linux.alibaba.com>
Date:   Thu, 6 Jan 2022 20:05:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 2/2] sched/core: Uncookied force idle accounting per cpu
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NsP+sMQPRwS2e3zoeBsX1+p2aevFFO+i9GdB5VQ0ujEbA@mail.gmail.com>
 <8be4679f-632b-97e5-9e48-1e1a37727ddf@linux.alibaba.com>
 <CABk29Nv4OXnNz5-ZdYmAE8o0YpmhkbH=GooksaKYY7n0YYUQxg@mail.gmail.com>
From:   cruzzhao <cruzzhao@linux.alibaba.com>
In-Reply-To: <CABk29Nv4OXnNz5-ZdYmAE8o0YpmhkbH=GooksaKYY7n0YYUQxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


在 2022/1/6 上午4:59, Josh Don 写道:

It's a good idea to combine them into a single sum. I separated them in
order to be consistent with the task accounting and for easy to understand.
As for change the task accounting, I've tried but I haven't found a
proper method to do so. I've considered the following methods:
1. Account the uncookie'd force idle time to the uncookie'd task, but
it'll be hard to trace the uncookie'd task.
2. Account the uncookie'd force idle time to the cookie'd task in the
core_tree of the core, but it will cost a lot on traversing the core_tree.

Many thanks for suggestions.
Best,
Cruz Zhao

> Why do you need this separated out into two fields then? Could we just
> combine the uncookie'd and cookie'd forced idle into a single sum?
> 
> IMO it is fine to account the forced idle from uncookie'd tasks, but
> we should then also change the task accounting to do the same, for
> consistency.
