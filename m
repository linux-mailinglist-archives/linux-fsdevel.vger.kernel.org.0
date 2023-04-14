Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F916E2B1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDNUcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 16:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDNUcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:32:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320205B93;
        Fri, 14 Apr 2023 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zkJ52LKFN3KW2VRgFxWenolm+nSjIO2xurI61vRkfQg=; b=F61Xsi7hJg8p79oBCG/Ya4KZTs
        NYyItO8lVqFUsyrFHUeHuSURJ8s59rMlIiWS7BsvUy4qB3i5uzGwW+rdiuBav36hIRnTg46zEearw
        Xnseesrp3Lz6ju4rdZfBg9QAqsDrYMYtutNLh339JNW6vkxUIa4JL2Cbc/iTetC3zgnKGnAH1MCIg
        AiM6IMqSgf0hcUWq/q1jH4TL5Q7NyoJixXwfUwfFjE1D9amcThVPP3aqN4qX/zKxhYnHJ93qN/xTW
        cqlx53Uk6XjvJNHnU7VSi9nk/bQuOX061GIoEoD2sgE2fW8toStzRjxFgZ6LUsEpK1+Jjy9Nh4AP+
        cmvyNvcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnQ5P-0093og-C7; Fri, 14 Apr 2023 20:31:59 +0000
Date:   Fri, 14 Apr 2023 21:31:59 +0100
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
Message-ID: <ZDm4P37XXyMBOMdZ@casper.infradead.org>
References: <20230414180043.1839745-1-surenb@google.com>
 <ZDmetaUdmlEz/W8Q@casper.infradead.org>
 <CAJuCfpFPNiZmqQPP+K7CAuiFP5qLdd6W9T84VQNdRsN-9ggm1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFPNiZmqQPP+K7CAuiFP5qLdd6W9T84VQNdRsN-9ggm1w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 12:48:54PM -0700, Suren Baghdasaryan wrote:
> >  - We can call migration_entry_wait().  This will wait for PG_locked to
> >    become clear (in migration_entry_wait_on_locked()).  As previously
> >    discussed offline, I think this is safe to do while holding the VMA
> >    locked.

Just to be clear, this particular use of PG_locked is not during I/O,
it's during page migration.  This is a few orders of magnitude
different.

> >  - We can call swap_readpage() if we allocate a new folio.  I haven't
> >    traced through all this code to tell if it's OK.

... whereas this will wait for I/O.  If we decide that's not OK, we'll
need to test for FAULT_FLAG_VMA_LOCK and bail out of this path.

> > So ... I believe this is all OK, but we're definitely now willing to
> > wait for I/O from the swap device while holding the VMA lock when we
> > weren't before.  And maybe we should make a bigger deal of it in the
> > changelog.
> >
> > And maybe we shouldn't just be failing the folio_lock_or_retry(),
> > maybe we should be waiting for the folio lock with the VMA locked.
> 
> Wouldn't that cause holding the VMA lock for the duration of swap I/O
> (something you said we want to avoid in the previous paragraph) and
> effectively undo d065bd810b6d ("mm: retry page fault when blocking on
> disk transfer") for VMA locks?

I'm not certain we want to avoid holding the VMA lock for the duration
of an I/O.  Here's how I understand the rationale for avoiding holding
the mmap_lock while we perform I/O (before the existence of the VMA lock):

 - If everybody is doing page faults, there is no specific problem;
   we all hold the lock for read and multiple page faults can be handled
   in parallel.
 - As soon as one thread attempts to manipulate the tree (eg calls
   mmap()), all new readers must wait (as the rwsem is fair), and the
   writer must wait for all existing readers to finish.  That's
   potentially milliseconds for an I/O during which time all page faults
   stop.

Now we have the per-VMA lock, faults which can be handled without taking
the mmap_lock can still be satisfied, as long as that VMA is not being
modified.  It is rare for a real application to take a page fault on a
VMA which is being modified.

So modifications to the tree will generally not take VMA locks on VMAs
which are currently handling faults, and new faults will generally not
find a VMA which is write-locked.

When we find a locked folio (presumably for I/O, although folios are
locked for other reasons), if we fall back to taking the mmap_lock
for read, we increase contention on the mmap_lock and make the page
fault wait on any mmap() operation.  If we simply sleep waiting for the
I/O, we make any mmap() operation _which touches this VMA_ wait for
the I/O to complete.  But I think that's OK, because new page faults
can continue to be serviced ... as long as they don't need to take
the mmap_lock.

So ... I think what we _really_ want here is ...

+++ b/mm/filemap.c
@@ -1690,7 +1690,8 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
                         unsigned int flags)
 {
-       if (fault_flag_allow_retry_first(flags)) {
+       if (!(flags & FAULT_FLAG_VMA_LOCK) &&
+           fault_flag_allow_retry_first(flags)) {
                /*
                 * CAUTION! In this case, mmap_lock is not released
                 * even though return 0.
@@ -1710,7 +1711,8 @@ bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,

                ret = __folio_lock_killable(folio);
                if (ret) {
-                       mmap_read_unlock(mm);
+                       if (!(flags & FAULT_FLAG_VMA_LOCK))
+                               mmap_read_unlock(mm);
                        return false;
                }
        } else {

