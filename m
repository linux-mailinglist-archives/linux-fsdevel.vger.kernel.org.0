Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0653846351D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 14:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbhK3NM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 08:12:59 -0500
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:38353 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236929AbhK3NM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:12:58 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 56C361F21
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 13:09:38 +0000 (GMT)
Received: (qmail 27593 invoked from network); 30 Nov 2021 13:09:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 30 Nov 2021 13:09:38 -0000
Date:   Tue, 30 Nov 2021 13:09:35 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Alexey Avramov <hakavlad@inbox.lv>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211130130935.GR3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
 <20211127011246.7a8ac7b8@mail.inbox.lv>
 <20211129150117.GO3366@techsingularity.net>
 <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
 <20211130112244.GQ3366@techsingularity.net>
 <b8f607c771a4f698fcb651379ca30d3bb6a83ccd.camel@gmx.de>
 <b966ccc578ac60d3684cff0c88c1b9046b408ea3.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b966ccc578ac60d3684cff0c88c1b9046b408ea3.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:51:10PM +0100, Mike Galbraith wrote:
> On Tue, 2021-11-30 at 13:00 +0100, Mike Galbraith wrote:
> > On Tue, 2021-11-30 at 11:22 +0000, Mel Gorman wrote:
> > > On Tue, Nov 30, 2021 at 11:14:32AM +0100, Mike Galbraith wrote:
> > > > >       }
> > > > > +       if (2 * write_pending <= reclaimable)
> > > >
> > > > That is always true here...
> > > >
> > >
> > > Always true for you or always true in general?
> >
> > "Here" as in the boxen located at my GPS coordinates :)
> >
> > > The intent of the check is "are a majority of reclaimable pages
> > > marked WRITE_PENDING?". It's similar to the check that existed prior
> > > to 132b0d21d21f ("mm/page_alloc: remove the throttling logic from the
> > > page allocator").
> >
> > I'll put my trace_printk() back and see if I can't bend-adjust it.
> 
> As it sits, write_pending is always 0 with tail /dev/zero.
> 

That is not a surprise for the test in question as it doesn't trigger
a case where there are lots of page cache being marked dirty and write
pending.

-- 
Mel Gorman
SUSE Labs
