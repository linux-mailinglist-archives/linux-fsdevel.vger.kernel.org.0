Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60F52557E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 11:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgH1Jle (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 05:41:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbgH1Jlb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:41:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7A89AC6F;
        Fri, 28 Aug 2020 09:42:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8E94A1E12C0; Fri, 28 Aug 2020 11:41:29 +0200 (CEST)
Date:   Fri, 28 Aug 2020 11:41:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     peterz@infradead.org
Cc:     Xianting Tian <tian.xianting@h3c.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] aio: make aio wait path to account iowait time
Message-ID: <20200828094129.GF7072@quack2.suse.cz>
References: <20200828060712.34983-1-tian.xianting@h3c.com>
 <20200828090729.GT1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828090729.GT1362448@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 28-08-20 11:07:29, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 02:07:12PM +0800, Xianting Tian wrote:
> > As the normal aio wait path(read_events() ->
> > wait_event_interruptible_hrtimeout()) doesn't account iowait time, so use
> > this patch to make it to account iowait time, which can truely reflect
> > the system io situation when using a tool like 'top'.
> 
> Do be aware though that io_schedule() is potentially far more expensive
> than regular schedule() and io-wait accounting as a whole is a
> trainwreck.

Hum, I didn't know that io_schedule() is that much more expensive. Thanks
for info.

> When in_iowait is set schedule() and ttwu() will have to do additional
> atomic ops, and (much) worse, PSI will take additional locks.
> 
> And all that for a number that, IMO, is mostly useless, see the comment
> with nr_iowait().

Well, I understand the limited usefulness of the system or even per CPU
percentage spent in IO wait. However whether a particular task is sleeping
waiting for IO or not is IMO a useful diagnostic information and there are
several places in the kernel that take that into account (PSI, hangcheck
timer, cpufreq, ...). So I don't see that properly accounting that a task
is waiting for IO is just "expensive random number generator" as you
mention below :). But I'm open to being educated...

> But, if you don't care about performance, and want to see a shiny random
> number generator, by all means, use io_schedule().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
