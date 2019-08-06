Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE948310A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfHFL5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 07:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:33706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbfHFL5I (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:57:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF36EAD95;
        Tue,  6 Aug 2019 11:57:05 +0000 (UTC)
Date:   Tue, 6 Aug 2019 13:57:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806115703.GY11812@dhcp22.suse.cz>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806111446.GA117316@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806111446.GA117316@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-08-19 07:14:46, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 12:47:55PM +0200, Michal Hocko wrote:
> > On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> > > On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > > > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > > > This bit will be used by idle page tracking code to correctly identify
> > > > > if a page that was swapped out was idle before it got swapped out.
> > > > > Without this PTE bit, we lose information about if a page is idle or not
> > > > > since the page frame gets unmapped.
> > > > 
> > > > And why do we need that? Why cannot we simply assume all swapped out
> > > > pages to be idle? They were certainly idle enough to be reclaimed,
> > > > right? Or what does idle actualy mean here?
> > > 
> > > Yes, but other than swapping, in Android a page can be forced to be swapped
> > > out as well using the new hints that Minchan is adding?
> > 
> > Yes and that is effectivelly making them idle, no?
> 
> That depends on how you think of it.

I would much prefer to have it documented so that I do not have to guess ;)

> If you are thinking of a monitoring
> process like a heap profiler, then from the heap profiler's (that only cares
> about the process it is monitoring) perspective it will look extremely odd if
> pages that are recently accessed by the process appear to be idle which would
> falsely look like those processes are leaking memory. The reality being,
> Android forced those pages into swap because of other reasons. I would like
> for the swapping mechanism, whether forced swapping or memory reclaim, not to
> interfere with the idle detection.

Hmm, but how are you going to handle situation when the page is unmapped
and refaulted again (e.g. a normal reclaim of a pagecache)? You are
losing that information same was as in the swapout case, no? Or am I
missing something?

> This is just an effort to make the idle tracking a little bit better. We
> would like to not lose the 'accessed' information of the pages.
> 
> Initially, I had proposed what you are suggesting as well however the above
> reasons made me to do it like this. Also Minchan and Konstantin suggested
> this, so there are more people interested in the swap idle bit. Minchan, can
> you provide more thoughts here? (He is on 2-week vacation from today so
> hopefully replies before he vanishes ;-)).

We can move on with the rest of the series in the mean time but I would
like to see a proper justification for the swap entries and why they
should be handled special.

> Also assuming all swap pages as idle has other "semantic" issues. It is quite
> odd if a swapped page is automatically marked as idle without userspace
> telling it to. Consider the following set of events: 1. Userspace marks only
> a certain memory region as idle. 2. Userspace reads back the bits
> corresponding to a bigger region. Part of this bigger region is swapped.
> Userspace expects all of the pages it did not mark, to have idle bit set to
> '0' because it never marked them as idle. However if it is now surprised by
> what it read back (not all '0' read back). Since a page is swapped, it will
> be now marked "automatically" as idle as per your proposal, even if userspace
> never marked it explicity before. This would be quite confusing/ambiguous.

OK, I see. I guess the primary question I have is how do you distinguish
Idle page which got unmapped and faulted in again from swapped out page
and refaulted - including the time the pte is not present.
-- 
Michal Hocko
SUSE Labs
