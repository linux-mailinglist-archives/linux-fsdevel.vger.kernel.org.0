Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43787833A3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbfHFOKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 10:10:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:52522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728259AbfHFOKE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:10:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01A6BAD43;
        Tue,  6 Aug 2019 14:10:01 +0000 (UTC)
Date:   Tue, 6 Aug 2019 16:09:59 +0200
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
Message-ID: <20190806140959.GD11812@dhcp22.suse.cz>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806111446.GA117316@google.com>
 <20190806115703.GY11812@dhcp22.suse.cz>
 <20190806134321.GA15167@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806134321.GA15167@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-08-19 09:43:21, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 01:57:03PM +0200, Michal Hocko wrote:
> > On Tue 06-08-19 07:14:46, Joel Fernandes wrote:
> > > On Tue, Aug 06, 2019 at 12:47:55PM +0200, Michal Hocko wrote:
> > > > On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> > > > > On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > > > > > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > > > > > This bit will be used by idle page tracking code to correctly identify
> > > > > > > if a page that was swapped out was idle before it got swapped out.
> > > > > > > Without this PTE bit, we lose information about if a page is idle or not
> > > > > > > since the page frame gets unmapped.
> > > > > > 
> > > > > > And why do we need that? Why cannot we simply assume all swapped out
> > > > > > pages to be idle? They were certainly idle enough to be reclaimed,
> > > > > > right? Or what does idle actualy mean here?
> > > > > 
> > > > > Yes, but other than swapping, in Android a page can be forced to be swapped
> > > > > out as well using the new hints that Minchan is adding?
> > > > 
> > > > Yes and that is effectivelly making them idle, no?
> > > 
> > > That depends on how you think of it.
> > 
> > I would much prefer to have it documented so that I do not have to guess ;)
> 
> Sure :)
> 
> > > If you are thinking of a monitoring
> > > process like a heap profiler, then from the heap profiler's (that only cares
> > > about the process it is monitoring) perspective it will look extremely odd if
> > > pages that are recently accessed by the process appear to be idle which would
> > > falsely look like those processes are leaking memory. The reality being,
> > > Android forced those pages into swap because of other reasons. I would like
> > > for the swapping mechanism, whether forced swapping or memory reclaim, not to
> > > interfere with the idle detection.
> > 
> > Hmm, but how are you going to handle situation when the page is unmapped
> > and refaulted again (e.g. a normal reclaim of a pagecache)? You are
> > losing that information same was as in the swapout case, no? Or am I
> > missing something?
> 
> Yes you are right, it would have the same issue, thanks for bringing it up.
> Should we rename this bit to PTE_IDLE and do the same thing that we are doing
> for swap?

What if we decide to tear the page table down as well? E.g. because we
can reclaim file backed mappings and free some memory used for page
tables. We do not do that right now but I can see that really large
mappings might push us that direction. Sure this is mostly a theoretical
concern but I am wondering whether promissing to keep the idle bit over
unmapping is not too much.

I am not sure how to deal with this myself, TBH. In any case the current
semantic - via pfn - will lose the idle bit already so can we mimic it
as well? We only have 1 bit for each address which makes it challenging.
The easiest way would be to declare that the idle bit might disappear on
activating or reclaiming the page. How well that suits different
usecases is a different question. I would be interested in hearing from
other people about this of course.
-- 
Michal Hocko
SUSE Labs
