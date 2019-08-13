Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4978BC40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 16:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfHMO5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 10:57:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729586AbfHMO5w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:57:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63704ABD6;
        Tue, 13 Aug 2019 14:57:49 +0000 (UTC)
Date:   Tue, 13 Aug 2019 16:57:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 1/6] mm/page_idle: Add per-pid idle page tracking
 using virtual index
Message-ID: <20190813145748.GM17933@dhcp22.suse.cz>
References: <20190807130402.49c9ea8bf144d2f83bfeb353@linux-foundation.org>
 <20190807204530.GB90900@google.com>
 <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
 <20190807213105.GA14622@google.com>
 <20190808080044.GA18351@dhcp22.suse.cz>
 <20190812145620.GB224541@google.com>
 <20190813091430.GE17933@dhcp22.suse.cz>
 <20190813135152.GC258732@google.com>
 <20190813141432.GL17933@dhcp22.suse.cz>
 <20190813144517.GE258732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813144517.GE258732@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 13-08-19 10:45:17, Joel Fernandes wrote:
> On Tue, Aug 13, 2019 at 04:14:32PM +0200, Michal Hocko wrote:
> [snip] 
> > > > If the API is flawed then this is likely going
> > > > to kick us later and will be hard to fix. I am still not convinced about
> > > > the swap part of the thing TBH.
> > > 
> > > Ok, then let us discuss it. As I mentioned before, without this we lose the
> > > access information due to MADVISE or swapping. Minchan and Konstantin both
> > > suggested it that's why I also added it (other than me also realizing that it
> > > is neeed).
> > 
> > I have described my concerns about the general idle bit behavior after
> > unmapping pointing to discrepancy with !anon pages. And I believe those
> > haven't been addressed yet.
> 
> You are referring to this post right?
> https://lkml.org/lkml/2019/8/6/637
> 
> Specifically your question was:
> How are you going to handle situation when the page is unmapped  and refaulted again (e.g. a normal reclaim of a pagecache)?
> 
> Currently I don't know how to implement that. Would it work if I stored the
> page-idle bit information in the pte of the file page (after the page is
> unmapped by reclaim?).

It would work as long as we keep page tables around after unmap. As they
are easily reconstructable this is a good candidate for reclaim as well.

> Also, this could be a future extension - the Android heap profiler does not
> need it right now. I know that's not a good argument but it is useful to say
> that it doesn't affect a real world usecase.. the swap issue on the other
> hand, is a real usecase. Since the profiler should not get affected by
> swapping or MADVISE_COLD hints.
> 
> > Besides that I am still not seeing any
> > description of the usecase that would suffer from the lack of the
> > functionality in changelogs.
> 
> You are talking about the swap usecase? The usecase is well layed out in v5
> 2/6. Did you see it? https://lore.kernel.org/patchwork/patch/1112283/

For some reason I've missed it. I will coment on that.

-- 
Michal Hocko
SUSE Labs
