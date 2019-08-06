Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071AF83067
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbfHFLO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 07:14:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:49424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730071AbfHFLO4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:14:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41BA7ABE3;
        Tue,  6 Aug 2019 11:14:54 +0000 (UTC)
Date:   Tue, 6 Aug 2019 13:14:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
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
        paulmck@linux.ibm.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 3/5] [RFC] arm64: Add support for idle bit in swap PTE
Message-ID: <20190806111452.GW11812@dhcp22.suse.cz>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
 <20190806104755.GR11812@dhcp22.suse.cz>
 <20190806110737.GB32615@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806110737.GB32615@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-08-19 20:07:37, Minchan Kim wrote:
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
> 1. mark page-A idle which was present at that time.
> 2. run workload
> 3. page-A is touched several times
> 4. *sudden* memory pressure happen so finally page A is finally swapped out
> 5. now see the page A idle - but it's incorrect.

Could you expand on what you mean by idle exactly? Why pageout doesn't
really qualify as "mark-idle and reclaim"? Also could you describe a
usecase where the swapout distinction really matters and it would lead
to incorrect behavior?

-- 
Michal Hocko
SUSE Labs
