Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0BA1BCF94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 00:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgD1WOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 18:14:25 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60412 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgD1WOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:14:24 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 543753A44C1;
        Wed, 29 Apr 2020 07:47:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jTY4k-0008LL-IM; Wed, 29 Apr 2020 07:47:34 +1000
Date:   Wed, 29 Apr 2020 07:47:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Message-ID: <20200428214653.GD2005@dread.disaster.area>
References: <20200428161355.6377-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428161355.6377-1-schatzberg.dan@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=1gqJplI6GZ5HzG39sUQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:13:46PM -0400, Dan Schatzberg wrote:
> The loop device runs all i/o to the backing file on a separate kworker
> thread which results in all i/o being charged to the root cgroup. This
> allows a loop device to be used to trivially bypass resource limits
> and other policy. This patch series fixes this gap in accounting.

How is this specific to the loop device? Isn't every block device
that offloads work to a kthread or single worker thread susceptible
to the same "exploit"?

Or is the problem simply that the loop worker thread is simply not
taking the IO's associated cgroup and submitting the IO with that
cgroup associated with it? That seems kinda simple to fix....

> Naively charging cgroups could result in priority inversions through
> the single kworker thread in the case where multiple cgroups are
> reading/writing to the same loop device.

And that's where all the complexity and serialisation comes from,
right?

So, again: how is this unique to the loop device? Other block
devices also offload IO to kthreads to do blocking work and IO
submission to lower layers. Hence this seems to me like a generic
"block device does IO submission from different task" issue that
should be handled by generic infrastructure and not need to be
reimplemented multiple times in every block device driver that
offloads work to other threads...

> This patch series does some
> minor modification to the loop driver so that each cgroup can make
> forward progress independently to avoid this inversion.
> 
> With this patch series applied, the above script triggers OOM kills
> when writing through the loop device as expected.

NACK!

The IO that is disallowed should fail with ENOMEM or some similar
error, not trigger an OOM kill that shoots some innocent bystander
in the head. That's worse than using BUG() to report errors...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
