Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6585C8F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfHHINx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 04:13:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:33204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731781AbfHHINw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:13:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68840AFFE;
        Thu,  8 Aug 2019 08:13:49 +0000 (UTC)
Date:   Thu, 8 Aug 2019 10:00:44 +0200
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
Message-ID: <20190808080044.GA18351@dhcp22.suse.cz>
References: <20190807171559.182301-1-joel@joelfernandes.org>
 <20190807130402.49c9ea8bf144d2f83bfeb353@linux-foundation.org>
 <20190807204530.GB90900@google.com>
 <20190807135840.92b852e980a9593fe91fbf59@linux-foundation.org>
 <20190807213105.GA14622@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807213105.GA14622@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 07-08-19 17:31:05, Joel Fernandes wrote:
> On Wed, Aug 07, 2019 at 01:58:40PM -0700, Andrew Morton wrote:
> > On Wed, 7 Aug 2019 16:45:30 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > On Wed, Aug 07, 2019 at 01:04:02PM -0700, Andrew Morton wrote:
> > > > On Wed,  7 Aug 2019 13:15:54 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> > > > 
> > > > > In Android, we are using this for the heap profiler (heapprofd) which
> > > > > profiles and pin points code paths which allocates and leaves memory
> > > > > idle for long periods of time. This method solves the security issue
> > > > > with userspace learning the PFN, and while at it is also shown to yield
> > > > > better results than the pagemap lookup, the theory being that the window
> > > > > where the address space can change is reduced by eliminating the
> > > > > intermediate pagemap look up stage. In virtual address indexing, the
> > > > > process's mmap_sem is held for the duration of the access.
> > > > 
> > > > So is heapprofd a developer-only thing?  Is heapprofd included in
> > > > end-user android loads?  If not then, again, wouldn't it be better to
> > > > make the feature Kconfigurable so that Android developers can enable it
> > > > during development then disable it for production kernels?
> > > 
> > > Almost all of this code is already configurable with
> > > CONFIG_IDLE_PAGE_TRACKING. If you disable it, then all of this code gets
> > > disabled.
> > > 
> > > Or are you referring to something else that needs to be made configurable?
> > 
> > Yes - the 300+ lines of code which this patchset adds!
> > 
> > The impacted people will be those who use the existing
> > idle-page-tracking feature but who will not use the new feature.  I
> > guess we can assume this set is small...
> 
> Yes, I think this set should be small. The code size increase of page_idle.o
> is from ~1KB to ~2KB. Most of the extra space is consumed by
> page_idle_proc_generic() function which this patch adds. I don't think adding
> another CONFIG option to disable this while keeping existing
> CONFIG_IDLE_PAGE_TRACKING enabled, is worthwhile but I am open to the
> addition of such an option if anyone feels strongly about it. I believe that
> once this patch is merged, most like this new interface being added is what
> will be used more than the old interface (for some of the usecases) so it
> makes sense to keep it alive with CONFIG_IDLE_PAGE_TRACKING.

I would tend to agree with Joel here. The functionality falls into an
existing IDLE_PAGE_TRACKING config option quite nicely. If there really
are users who want to save some space and this is standing in the way
then they can easily add a new config option with some justification so
the savings are clear. Without that an additional config simply adds to
the already existing configurability complexity and balkanization.
-- 
Michal Hocko
SUSE Labs
