Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB7524C0AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHTOeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 10:34:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgHTOeg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:34:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 772DDAF50;
        Thu, 20 Aug 2020 14:35:01 +0000 (UTC)
Date:   Thu, 20 Aug 2020 16:34:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Suren Baghdasaryan <surenb@google.com>, timmurray@google.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        esyr@redhat.com, christian@kellner.me, areber@redhat.com,
        shakeelb@google.com, cyphar@cyphar.com, oleg@redhat.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, minchan@kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in
 __set_oom_adj when not necessary
Message-ID: <20200820143433.GO5033@dhcp22.suse.cz>
References: <87zh6pxzq6.fsf@x220.int.ebiederm.org>
 <20200820124241.GJ5033@dhcp22.suse.cz>
 <87lfi9xz7y.fsf@x220.int.ebiederm.org>
 <87d03lxysr.fsf@x220.int.ebiederm.org>
 <20200820132631.GK5033@dhcp22.suse.cz>
 <20200820133454.ch24kewh42ax4ebl@wittgenstein>
 <dcb62b67-5ad6-f63a-a909-e2fa70b240fc@i-love.sakura.ne.jp>
 <20200820140054.fdkbotd4tgfrqpe6@wittgenstein>
 <20200820141538.GM5033@dhcp22.suse.cz>
 <42d5645e-0364-c8cd-01dc-93a9aaff5b09@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42d5645e-0364-c8cd-01dc-93a9aaff5b09@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 20-08-20 23:26:29, Tetsuo Handa wrote:
> On 2020/08/20 23:15, Michal Hocko wrote:
> > I would tend to agree that from the userspace POV it is nice to look at
> > oom tuning per process but fundamentaly the oom killer operates on the
> > address space much more than other resources bound to a process because
> > it is usually the address space hogging the largest portion of the
> > memory footprint. This is the reason why the oom killer has been
> > evaluating tasks based on that aspect rather than other potential memory
> > consumers bound to a task. Mostly due to lack of means to evaluate
> > those.
> 
> We already allow specifying potential memory consumers via oom_task_origin().

oom_task_origin is a single purpose hack to handle swapoff situation
more gracefully. By no means this is something to base the behavior on.

> If we change from a property of the task/thread-group to a property of mm,
> we won't be able to add means to adjust oom score based on other potential
> memory consumers bound to a task (e.g. pipes) in the future.

While that would be really nice to achieve I am not really sure this is
feasible. Mostly because accounting shared resources like pipes but fd
based resources in general is really hard to do right without any
surprises. Pipes are not really bound to a specific process for example.
You are free to hand over fd to a different process for example.
-- 
Michal Hocko
SUSE Labs
