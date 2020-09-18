Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7E26FE6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 15:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIRN0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 09:26:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:56530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIRN0i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:26:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FF75B03F;
        Fri, 18 Sep 2020 13:27:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A45CC1E12E1; Fri, 18 Sep 2020 15:26:35 +0200 (CEST)
Date:   Fri, 18 Sep 2020 15:26:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     peterz@infradead.org, Jan Kara <jack@suse.cz>,
        Boaz Harrosh <boaz@plexistor.com>,
        Hou Tao <houtao1@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: use this_cpu_{inc|dec}() for
 read_count
Message-ID: <20200918132635.GI18920@quack2.suse.cz>
References: <20200915160344.GH35926@hirez.programming.kicks-ass.net>
 <b885ce8e-4b0b-8321-c2cc-ee8f42de52d4@huawei.com>
 <ddd5d732-06da-f8f2-ba4a-686c58297e47@plexistor.com>
 <20200917120132.GA5602@redhat.com>
 <20200918090702.GB18920@quack2.suse.cz>
 <20200918100112.GN1362448@hirez.programming.kicks-ass.net>
 <20200918101216.GL35926@hirez.programming.kicks-ass.net>
 <20200918104824.GA23469@redhat.com>
 <20200918110310.GO1362448@hirez.programming.kicks-ass.net>
 <20200918130914.GA26777@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918130914.GA26777@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-09-20 15:09:14, Oleg Nesterov wrote:
> On 09/18, Peter Zijlstra wrote:
> > > But again, do we really want this?
> >
> > I like the two counters better, avoids atomics entirely, some archs
> > hare horridly expensive atomics (*cough* power *cough*).
> 
> I meant... do we really want to introduce percpu_up_read_irqsafe() ?
> 
> Perhaps we can live with the fix from Hou? At least until we find a
> "real" performance regression.

I can say that for users of percpu rwsem in filesystems the cost of atomic
inc/dec is unlikely to matter. The lock hold times there are long enough
that it would be just lost in the noise.

For other stuff using them like get_online_cpus() or get_online_mems() I'm
not so sure...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
