Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486961E694E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 20:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405784AbgE1S3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405744AbgE1S3l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 14:29:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7CCC08C5C6;
        Thu, 28 May 2020 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rHMEzb11uh2HkVb3MRV65qzSdnkQbtUfzMniKNSh5V4=; b=l6I4q/VNvcMk9WtCZ7L3CtVjsD
        4RdeCehuLo5Y+5/uJwh7db/V7hlgZ2wuCeIFjt/sepFaXsjq20myaWbxJ+C14e4PKFGuXMNJeG6DC
        DdnyXJ13RvVu4IsViLZQUgaRNGJhkFexoU6bS1/U5wE2AORU73PIYycA9cBtwGM+aqfOX+tcgbtyV
        AK6lJiwvF5GXamTSHziGU2E2jaXHBzIMxAvc+5FH3onDIZlmvZxRTzhtxPkOMDaAmcfTP/EvN/g4i
        INBw4+6Lw3RVFUN+tNNvi2E/yzHJePRXzMTwLF0FZcJ3wBYWAOa5MaUTV9LzkOnH43ManVv/M6LPA
        KUJsTyQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeNHJ-0001Er-1U; Thu, 28 May 2020 18:29:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 116BE9836F8; Thu, 28 May 2020 20:29:14 +0200 (CEST)
Date:   Thu, 28 May 2020 20:29:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200528182913.GQ2483@worktop.programming.kicks-ass.net>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 05:51:31PM +0100, Qais Yousef wrote:

> In my head, the simpler version of
> 
> 	if (rt_task(p) && !uc->user_defined)
> 		// update_uclamp_min
> 
> Is a single branch and write to cache, so should be fast. I'm failing to see
> how this could generate an overhead tbh, but will not argue about it :-)

Mostly true; but you also had a load of that sysctl in there, which is
likely to be a miss, and those are expensive.

Also; if we're going to have to optimize this, less logic is in there,
the less we need to take out. Esp. for stuff that 'never' changes, like
this.

> > It's more code, but it is all outside of the normal paths where we care
> > about performance.
> 
> I am happy to take that direction if you think it's worth it. I'm thinking
> task_woken_rt() is good. But again, maybe I am missing something.

Basic rule, if the state 'never' changes, don't touch fast paths.

Such little things can be very difficult to measure, but at some point
they cause death-by-a-thousnd-cuts.

> > Indeed, that one. The fact that regular distros cannot enable this
> > feature due to performance overhead is unfortunate. It means there is a
> > lot less potential for this stuff.
> 
> I had a humble try to catch the overhead but wasn't successful. The observation
> wasn't missed by us too then.

Right, I remember us doing benchmarks when we introduced all this and
clearly we missed something. I would be good if Mel can share which
benchmark hurt most so we can go have a look.
