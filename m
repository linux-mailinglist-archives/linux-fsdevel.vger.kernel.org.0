Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C085476CB23
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHBKn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 06:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjHBKnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:43:01 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 03:40:25 PDT
Received: from outbound-smtp57.blacknight.com (outbound-smtp57.blacknight.com [46.22.136.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F10249FD
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 03:40:24 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp57.blacknight.com (Postfix) with ESMTPS id CF40DFAD9E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:24:05 +0100 (IST)
Received: (qmail 650 invoked from network); 2 Aug 2023 10:24:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Aug 2023 10:24:05 -0000
Date:   Wed, 2 Aug 2023 11:24:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <20230802102402.at2lvqp3hlbksoz4@techsingularity.net>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 28, 2023 at 07:30:33PM +0200, David Hildenbrand wrote:
> On 28.07.23 18:18, Linus Torvalds wrote:
> > On Thu, 27 Jul 2023 at 14:28, David Hildenbrand <david@redhat.com> wrote:
> > > 
> > > This is my proposal on how to handle the fallout of 474098edac26
> > > ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
> > > accidentially missed that follow_page() and smaps implicitly kept the
> > > FOLL_NUMA flag clear by *not* setting it if FOLL_FORCE is absent, to
> > > not trigger faults on PROT_NONE-mapped PTEs.
> > 
> > Ugh.
> 
> I was hoping for that reaction, with the assumption that we would get
> something cleaner :)
> 
> > 
> > I hate how it uses FOLL_FORCE that is inherently scary.
> 
> I hate FOLL_FORCE, but I hate FOLL_NUMA even more, because to me it
> is FOLL_FORCE in disguise (currently and before 474098edac26, if
> FOLL_FORCE is set, FOLL_NUMA won't be set and the other way around).
> 

FOLL_NUMA being conflated with FOLL_FORCE is almost certainly a historical
accident.

> > 
> > Why do we have that "gup_can_follow_protnone()" logic AT ALL?
> 
> That's what I was hoping for.
> 
> > 
> > Couldn't we just get rid of that disgusting thing, and just say that
> > GUP (and follow_page()) always just ignores NUMA hinting, and always
> > just follows protnone?
> > 
> > We literally used to have this:
> > 
> >          if (!(gup_flags & FOLL_FORCE))
> >                  gup_flags |= FOLL_NUMA;
> > 
> > ie we *always* set FOLL_NUMA for any sane situation. FOLL_FORCE should
> > be the rare crazy case.
> 
> Yes, but my point would be that we now spell that "rare crazy case"
> out for follow_page().
> 
> If you're talking about patch #1, I agree, therefore patch #3 to
> avoid all that nasty FOLL_FORCE handling in GUP callers.
> 
> But yeah, if we can avoid all that, great.
> 
> > 
> > The original reason for not setting FOLL_NUMA all the time is
> > documented in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
> > page faults from gup/gup_fast") from way back in 2012:
> > 
> >           * If FOLL_FORCE and FOLL_NUMA are both set, handle_mm_fault
> >           * would be called on PROT_NONE ranges. We must never invoke
> >           * handle_mm_fault on PROT_NONE ranges or the NUMA hinting
> >           * page faults would unprotect the PROT_NONE ranges if
> >           * _PAGE_NUMA and _PAGE_PROTNONE are sharing the same pte/pmd
> >           * bitflag. So to avoid that, don't set FOLL_NUMA if
> >           * FOLL_FORCE is set.
> 
> 
> In handle_mm_fault(), we never call do_numa_page() if
> !vma_is_accessible(). Same for do_huge_pmd_numa_page().
> 
> So, if we would ever end up triggering a page fault on
> mprotect(PROT_NONE) ranges (i.e., via FOLL_FORCE), we
> would simply do nothing.
> 
> At least that's the hope, I'll take a closer look just to make
> sure we're good on all call paths.
> 
> > 
> > but I don't think the original reason for this is *true* any more.
> > 
> > Because then two years later in 2014, in commit c46a7c817e66 ("x86:
> > define _PAGE_NUMA by reusing software bits on the PMD and PTE levels")
> > Mel made the code able to distinguish between PROT_NONE and NUMA
> > pages, and he changed the comment above too.
> 
> CCing Mel.
> 
> I remember that pte_protnone() can only distinguished between
> NUMA vs. actual mprotect(PROT_NONE) by looking at the VMA -- vma_is_accessible().
> 

Ok, as usual, I'm far behind and this thread massive but I'll respond
to this part before trying to digest the history of this and the current
implementation.

To the best of my recollection, FOLL_NUMA used to be a correctness issue
but that should no longer true. Initially, it was to prevent mixing up
"PROT_NONE" that was for NUMA hinting and "PROT_NONE" due to VMA
protections. Now the bits are different so this case should be
avoidable.

Later it was still a different correctness issue because PMD migration had
a hacky implementation without migration entries and a GUP could find a
page that was being collapsed and had to be serialised. That should also
now be avoidable.

At some point, FOLL_FORCE and FOLL_NUMA got conflated but they really should
not be related even if they are by accident. FOLL_FORCE (e.g. ptrace)
may have to process the fault and make the page resident and accessible
regardless of any other consequences. FOLL_NUMA ideally should be much
more specific. If the calling context only cares about the struct page
(e.g. smaps) then it's ok to get a reference to the page. If necessary,
it could clear the protection and lose the hinting fault although it's less
than ideal. Just needing the struct page for informational purposes though
should not be treated as a NUMA hinting fault because it has nothing to
do with the tasks memory reference behaviour.

A variant of FOLL_NUMA (FOLL_NUMA_HINT?) may still be required to indicate
the calling context is accessing the page for reasons that are equivalent
to a real memory access from a CPU related to the task mapping the page.
I didn't check but KVM may be an example of this when dealing with some MMU
faults as the page is being looked up on behalf of the task and presumably
from the same CPU the task was running run. Something like reading smaps
only needs the struct page but it should not be treated as a NUMA hinting
fault as the access has nothing to do with the task mapping the page.

> > The original reason for FOLL_NUMA simply does not exist any more. We
> > know exactly when a page is marked for NUMA faulting, and we should
> > simply *ignore* it for GUP and follow_page().
> > 

I'd be wary of completely ignoring it if there is any known calling context
that is equivalent to a memory access and the hinting fault should be
processed -- KVM may be an example.

-- 
Mel Gorman
SUSE Labs
