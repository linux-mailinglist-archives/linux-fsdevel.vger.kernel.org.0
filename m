Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA132559BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 14:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgH1MAh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 08:00:37 -0400
Received: from smtp.h3c.com ([60.191.123.56]:5969 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgH1MAN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:00:13 -0400
Received: from DAG2EX06-IDC.srv.huawei-3com.com ([10.8.0.69])
        by h3cspam01-ex.h3c.com with ESMTPS id 07SBvFgg038729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 19:57:15 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX06-IDC.srv.huawei-3com.com (10.8.0.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 28 Aug 2020 19:57:18 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Fri, 28 Aug 2020 19:57:18 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        Jan Kara <jack@suse.cz>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>
Subject: RE: [PATCH] aio: make aio wait path to account iowait time
Thread-Topic: [PATCH] aio: make aio wait path to account iowait time
Thread-Index: AQHWfQJrlBVndhGZlkOx+wrnBltm+qlMtS6AgAAJgICAABOrgIAAlxcg
Date:   Fri, 28 Aug 2020 11:57:18 +0000
Message-ID: <fa88dffe413c4111b173107f94e72733@h3c.com>
References: <20200828060712.34983-1-tian.xianting@h3c.com>
 <20200828090729.GT1362448@hirez.programming.kicks-ass.net>
 <20200828094129.GF7072@quack2.suse.cz>
 <20200828105153.GV1362448@hirez.programming.kicks-ass.net>
In-Reply-To: <20200828105153.GV1362448@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07SBvFgg038729
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks peterz, jan
So, enable aio iowait time accounting is a bad idea:(
I gained a lot from you, thanks

-----Original Message-----
From: peterz@infradead.org [mailto:peterz@infradead.org] 
Sent: Friday, August 28, 2020 6:52 PM
To: Jan Kara <jack@suse.cz>
Cc: tianxianting (RD) <tian.xianting@h3c.com>; viro@zeniv.linux.org.uk; bcrl@kvack.org; mingo@redhat.com; juri.lelli@redhat.com; vincent.guittot@linaro.org; dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com; mgorman@suse.de; linux-fsdevel@vger.kernel.org; linux-aio@kvack.org; linux-kernel@vger.kernel.org; Tejun Heo <tj@kernel.org>; hannes@cmpxchg.org
Subject: Re: [PATCH] aio: make aio wait path to account iowait time

On Fri, Aug 28, 2020 at 11:41:29AM +0200, Jan Kara wrote:
> On Fri 28-08-20 11:07:29, peterz@infradead.org wrote:
> > On Fri, Aug 28, 2020 at 02:07:12PM +0800, Xianting Tian wrote:
> > > As the normal aio wait path(read_events() ->
> > > wait_event_interruptible_hrtimeout()) doesn't account iowait time, 
> > > so use this patch to make it to account iowait time, which can 
> > > truely reflect the system io situation when using a tool like 'top'.
> > 
> > Do be aware though that io_schedule() is potentially far more 
> > expensive than regular schedule() and io-wait accounting as a whole 
> > is a trainwreck.
> 
> Hum, I didn't know that io_schedule() is that much more expensive. 
> Thanks for info.

It's all relative, but it can add up under contention. And since these storage thingies are getting faster every year, I'm assuming these schedule rates are increasing along with it.

> > When in_iowait is set schedule() and ttwu() will have to do 
> > additional atomic ops, and (much) worse, PSI will take additional locks.
> > 
> > And all that for a number that, IMO, is mostly useless, see the 
> > comment with nr_iowait().
> 
> Well, I understand the limited usefulness of the system or even per 
> CPU percentage spent in IO wait. However whether a particular task is 
> sleeping waiting for IO or not

So strict per-task state is not a problem, and we could easily change
get_task_state() to distinguish between IO-wait or not, basically duplicate S/D state into an IO-wait variant of the same. Although even this has ABI implications :-(

> is IMO a useful diagnostic information and there are several places in 
> the kernel that take that into account (PSI, hangcheck timer, cpufreq, 
> ...).

So PSI is the one I hate most. We spend an aweful lot of time to not have to take the old rq->lock on wakeup, and PSI reintroduced it for accounting purposes -- I hate accounting overhead. :/

There's a number of high frequency scheduling workloads where it really adds up, which is the reason we got rid of it in the first place.

OTOH, PSI gives more sensible numbers, although it goes side-ways when you introduce affinity masks / cpusets.

The menu-cpufreq gov is known crazy and we're all hard working on replacing it.

And the tick-sched usage is, iirc, the nohz case of iowait.

> So I don't see that properly accounting that a task is waiting for IO 
> is just "expensive random number generator" as you mention below :). 
> But I'm open to being educated...

It's the userspace iowait, and in particular the per-cpu iowait numbers that I hate. Only on UP does any of that make sense.

But we can't remove them because ABI :-(

