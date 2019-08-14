Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91FF88CD9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfHNIFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 04:05:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:36094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725265AbfHNIFf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:05:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 818D6AFB0;
        Wed, 14 Aug 2019 08:05:32 +0000 (UTC)
Date:   Wed, 14 Aug 2019 10:05:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     khlebnikov@yandex-team.ru, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>, namhyung@google.com,
        paulmck@linux.ibm.com, Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 2/6] mm/page_idle: Add support for handling swapped
 PG_Idle pages
Message-ID: <20190814080531.GP17933@dhcp22.suse.cz>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807171559.182301-2-joel@joelfernandes.org>
 <20190813150450.GN17933@dhcp22.suse.cz>
 <20190813153659.GD14622@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813153659.GD14622@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-08-19 11:36:59, Joel Fernandes wrote:
> On Tue, Aug 13, 2019 at 05:04:50PM +0200, Michal Hocko wrote:
> > On Wed 07-08-19 13:15:55, Joel Fernandes (Google) wrote:
> > > Idle page tracking currently does not work well in the following
> > > scenario:
> > >  1. mark page-A idle which was present at that time.
> > >  2. run workload
> > >  3. page-A is not touched by workload
> > >  4. *sudden* memory pressure happen so finally page A is finally swapped out
> > >  5. now see the page A - it appears as if it was accessed (pte unmapped
> > >     so idle bit not set in output) - but it's incorrect.
> > > 
> > > To fix this, we store the idle information into a new idle bit of the
> > > swap PTE during swapping of anonymous pages.
> > >
> > > Also in the future, madvise extensions will allow a system process
> > > manager (like Android's ActivityManager) to swap pages out of a process
> > > that it knows will be cold. To an external process like a heap profiler
> > > that is doing idle tracking on another process, this procedure will
> > > interfere with the idle page tracking similar to the above steps.
> > 
> > This could be solved by checking the !present/swapped out pages
> > right? Whoever decided to put the page out to the swap just made it
> > idle effectively.  So the monitor can make some educated guess for
> > tracking. If that is fundamentally not possible then please describe
> > why.
> 
> But the monitoring process (profiler) does not have control over the 'whoever
> made it effectively idle' process.

Why does that matter? Whether it is a global/memcg reclaim or somebody
calling MADV_PAGEOUT or whatever it is a decision to make the page not
hot. Sure you could argue that a missing idle bit on swap entries might
mean that the swap out decision was pre-mature/sub-optimal/wrong but is
this the aim of the interface?

> As you said it will be a guess, it will not be accurate.

Yes and the point I am trying to make is that having some space and not
giving a guarantee sounds like a safer option for this interface because
...
> 
> I am curious what is your concern with using a bit in the swap PTE?

... It is a promiss of the semantic I find limiting for future. The bit
in the pte might turn out insufficient (e.g. pte reclaim) so teaching
the userspace to consider this a hard guarantee is a ticket to problems
later on. Maybe I am overly paranoid because I have seen so many "nice
to have" features turning into a maintenance burden in the past.

If this is really considered mostly debugging purpouse interface then a
certain level of imprecision should be tolerateable. If there is a
really strong real world usecase that simply has no other way to go
then this might be added later. Adding an information is always safer
than take it away.

That being said, if I am a minority voice here then I will not really
stand in the way and won't nack the patch. I will not ack it neither
though.

-- 
Michal Hocko
SUSE Labs
