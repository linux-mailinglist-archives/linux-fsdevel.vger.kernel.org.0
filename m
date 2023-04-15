Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8416E2E8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 04:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjDOCQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 22:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjDOCQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:16:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255C055B3;
        Fri, 14 Apr 2023 19:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=I+T4EDQebiiyahHWac5SLmoudsQlP+Xbpp0Ua4hQnmY=; b=k0M36e49KyrwSvcWcznvQjbAoh
        TT4GvgvX/m/ZSoD4vmfsjLWLXE3V5uqOFSI0OPrCpLBMlpD406oVS+1Rrrswdi8vlTw3cR6If6faE
        VsGwtaBllrkW1/GtNU/0/FPglY1QTTYqre0iaIu3I1apLYlyWZB1Nfumb7hKqrrno82bVsGCAw6gg
        bRSki81u9jypJx5rg3rGTM6+/DN8IdJtTdPjdZ5EGymdxARh3oL+UjHzDzjNA3V4JXfj8OFKH88Oy
        MWP84DlBJQV35D/rz8QktIlaLzz+5UHcwbS7W4sciNbDVYfu1J2a8xB7vIoIEnEWE5VtyflOjaCVO
        xI/z99Sw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnVS8-009HLo-CN; Sat, 15 Apr 2023 02:15:48 +0000
Date:   Sat, 15 Apr 2023 03:15:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
Message-ID: <ZDoI1PdzgV9YBCzd@casper.infradead.org>
References: <20230414180043.1839745-1-surenb@google.com>
 <ZDmetaUdmlEz/W8Q@casper.infradead.org>
 <CAJuCfpFPNiZmqQPP+K7CAuiFP5qLdd6W9T84VQNdRsN-9ggm1w@mail.gmail.com>
 <ZDm4P37XXyMBOMdZ@casper.infradead.org>
 <CAJuCfpF2idZUjON6TZw4NV+himmACMGGE=2jgmt=fgAXv6L5Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF2idZUjON6TZw4NV+himmACMGGE=2jgmt=fgAXv6L5Pg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 02:51:59PM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 14, 2023 at 1:32 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Apr 14, 2023 at 12:48:54PM -0700, Suren Baghdasaryan wrote:
> > > >  - We can call migration_entry_wait().  This will wait for PG_locked to
> > > >    become clear (in migration_entry_wait_on_locked()).  As previously
> > > >    discussed offline, I think this is safe to do while holding the VMA
> > > >    locked.
> >
> > Just to be clear, this particular use of PG_locked is not during I/O,
> > it's during page migration.  This is a few orders of magnitude
> > different.
> >
> > > >  - We can call swap_readpage() if we allocate a new folio.  I haven't
> > > >    traced through all this code to tell if it's OK.
> >
> > ... whereas this will wait for I/O.  If we decide that's not OK, we'll
> > need to test for FAULT_FLAG_VMA_LOCK and bail out of this path.
> >
> > > > So ... I believe this is all OK, but we're definitely now willing to
> > > > wait for I/O from the swap device while holding the VMA lock when we
> > > > weren't before.  And maybe we should make a bigger deal of it in the
> > > > changelog.
> > > >
> > > > And maybe we shouldn't just be failing the folio_lock_or_retry(),
> > > > maybe we should be waiting for the folio lock with the VMA locked.
> > >
> > > Wouldn't that cause holding the VMA lock for the duration of swap I/O
> > > (something you said we want to avoid in the previous paragraph) and
> > > effectively undo d065bd810b6d ("mm: retry page fault when blocking on
> > > disk transfer") for VMA locks?
> >
> > I'm not certain we want to avoid holding the VMA lock for the duration
> > of an I/O.  Here's how I understand the rationale for avoiding holding
> > the mmap_lock while we perform I/O (before the existence of the VMA lock):
> >
> >  - If everybody is doing page faults, there is no specific problem;
> >    we all hold the lock for read and multiple page faults can be handled
> >    in parallel.
> >  - As soon as one thread attempts to manipulate the tree (eg calls
> >    mmap()), all new readers must wait (as the rwsem is fair), and the
> >    writer must wait for all existing readers to finish.  That's
> >    potentially milliseconds for an I/O during which time all page faults
> >    stop.
> >
> > Now we have the per-VMA lock, faults which can be handled without taking
> > the mmap_lock can still be satisfied, as long as that VMA is not being
> > modified.  It is rare for a real application to take a page fault on a
> > VMA which is being modified.
> >
> > So modifications to the tree will generally not take VMA locks on VMAs
> > which are currently handling faults, and new faults will generally not
> > find a VMA which is write-locked.
> >
> > When we find a locked folio (presumably for I/O, although folios are
> > locked for other reasons), if we fall back to taking the mmap_lock
> > for read, we increase contention on the mmap_lock and make the page
> > fault wait on any mmap() operation.
> 
> Do you mean we increase mmap_lock contention by holding the mmap_lock
> between the start of pagefault retry and until we drop it in
> __folio_lock_or_retry?

Yes, and if there is a writer (to any VMA, not just to the VMA we're
working on), this page fault has to wait for that writer.  Rather than
just waiting for this I/O to complete.

> > If we simply sleep waiting for the
> > I/O, we make any mmap() operation _which touches this VMA_ wait for
> > the I/O to complete.  But I think that's OK, because new page faults
> > can continue to be serviced ... as long as they don't need to take
> > the mmap_lock.
> 
> Ok, so we will potentially block VMA writers for the duration of the I/O...
> Stupid question: why was this a bigger problem for mmap_lock?
> Potentially our address space can consist of only one anon VMA, so
> locking that VMA vs mmap_lock should be the same from swap pagefault
> POV. Maybe mmap_lock is taken for write in some other important cases
> when VMA lock is not needed?

I really doubt any process has only a single VMA.  Usually, there's at
least stack, program text, program data, program rodata, heap, vdso,
libc text, libc data, libc rodata, etc.

$ cat /proc/self/maps |wc -l
23

That's 5 for the program, 5 for ld.so, 5 for libc, heap, stack, vvar,
vdso, and a few I can't identify.

Also, if our program only has one anon VMA, what is it doing that
it needs to modify the tree?  Growing it, perhaps?  Almost anything
else would cause it to have more than one VMA ;-)

But let's consider the case where we have a 1TB VMA which is servicing the
majority of faults and we try to mprotect one page in it.  The mprotect()
thread will take the mmap_lock for write, then block on the VMA lock until
all the other threads taking page faults have finished (ie waiting for all
the swapin to happen).  While it waits, new faults on that VMA will also
block (on the mmap_lock as the read_trylock on the VMA lock will fail).
So yes, this case is just as bad as the original problem.

We have two alternatives here.  We can do what we do today -- fall back
to taking the mmap_lock for read before dropping it while we wait
for the folio lock.  Or we can do something like this ...

+++ b/mm/filemap.c
@@ -1698,7 +1698,10 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
                if (flags & FAULT_FLAG_RETRY_NOWAIT)
                        return false;

-               mmap_read_unlock(mm);
+               if (flags & FAULT_FLAG_VMA_LOCK)
+                       vma_end_read(vma);
+               else
+                       mmap_read_unlock(mm);
                if (flags & FAULT_FLAG_KILLABLE)
                        folio_wait_locked_killable(folio);
                else

... and then figure out a return value that lets the caller of
handle_mm_fault() know not to call vma_end_read().

Or we can decide that it's OK to reintroduce this worst-case scenario,
because we've now reduced the likelihood of it happening so far.
