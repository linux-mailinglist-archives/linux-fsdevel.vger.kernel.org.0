Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDBE82FFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 12:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbfHFKr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 06:47:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728845AbfHFKr7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:47:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73D9CAFCC;
        Tue,  6 Aug 2019 10:47:57 +0000 (UTC)
Date:   Tue, 6 Aug 2019 12:47:55 +0200
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
Message-ID: <20190806104755.GR11812@dhcp22.suse.cz>
References: <20190805170451.26009-1-joel@joelfernandes.org>
 <20190805170451.26009-3-joel@joelfernandes.org>
 <20190806084203.GJ11812@dhcp22.suse.cz>
 <20190806103627.GA218260@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806103627.GA218260@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 06-08-19 06:36:27, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 10:42:03AM +0200, Michal Hocko wrote:
> > On Mon 05-08-19 13:04:49, Joel Fernandes (Google) wrote:
> > > This bit will be used by idle page tracking code to correctly identify
> > > if a page that was swapped out was idle before it got swapped out.
> > > Without this PTE bit, we lose information about if a page is idle or not
> > > since the page frame gets unmapped.
> > 
> > And why do we need that? Why cannot we simply assume all swapped out
> > pages to be idle? They were certainly idle enough to be reclaimed,
> > right? Or what does idle actualy mean here?
> 
> Yes, but other than swapping, in Android a page can be forced to be swapped
> out as well using the new hints that Minchan is adding?

Yes and that is effectivelly making them idle, no?

> Also, even if they were idle enough to be swapped, there is a chance that they
> were marked as idle and *accessed* before the swapping. Due to swapping, the
> "page was accessed since we last marked it as idle" information is lost. I am
> able to verify this.
> 
> Idle in this context means the same thing as in page idle tracking terms, the
> page was not accessed by userspace since we last marked it as idle (using
> /proc/<pid>/page_idle).

Please describe a usecase and why that information might be useful.

-- 
Michal Hocko
SUSE Labs
