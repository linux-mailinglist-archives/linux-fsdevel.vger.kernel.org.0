Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD574DC98B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiCQPF1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbiCQPF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:05:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF219F1AF9;
        Thu, 17 Mar 2022 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QLo0R6NBrD91QOQqMyjlOOoC1IzW77Quyf+MZ5H7cG8=; b=Cqu9289362tN91gDWTpmVhKM6G
        VdzQN1Mu2RrVhnlw1HA+JLgGm2wAugpgHVlhgntEZ6MnDpzUYyKKTn7p8n8pSRIcraDh9CC9vuRyH
        xKc37b6tfm6XTzzVFQlYb6BFc8hAlyjtSHr8UY7jwMYspmNkZsd/6ZBhcpX/QTyiSVza0zjo1Rj9w
        yFW6iehhzi6H4gsWTHxwJJ1iMcMV1En/t9976mYSqqCHYbr5pfE+xn8bhm/96PN5UCKXSQWH3MiZn
        J+L9TLsBvydU4Dp+zhvYxcyIsiru2iXSmmuFQnOscvS2YtnA7WLOwtWBJllxRiqC7DyB2ex68d3ol
        zCMdMX9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUrfZ-00744E-5H; Thu, 17 Mar 2022 15:04:05 +0000
Date:   Thu, 17 Mar 2022 15:04:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brian Foster <bfoster@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjNN5SzHELGig+U4@casper.infradead.org>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 04:35:10PM -0700, Linus Torvalds wrote:
> On Wed, Mar 16, 2022 at 1:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > As I recall, the bookmark hack was introduced in order to handle
> > lock_page() problems.  It wasn't really supposed to handle writeback,
> > but nobody thought it would cause any harm (and indeed, it didn't at the
> > time).  So how about we only use bookmarks for lock_page(), since
> > lock_page() usually doesn't have the multiple-waker semantics that
> > writeback has?
> 
> I was hoping that some of the page lock problems are gone and we could
> maybe try to get rid of the bookmarks entirely.
> 
> But the page lock issues only ever showed up on some private
> proprietary load and machine, so we never really got confirmation that
> they are fixed. There were lots of strong signs to them being related
> to the migration page locking, and it may be that the bookmark code is
> only hurting these days.

Ah, I found Tim's mail describing the workload:
https://lore.kernel.org/all/a9e74f64-dee6-dc23-128e-8ef8c7383d77@linux.intel.com/

Relevant part:

: They have a parent process that spawns off 10 children per core and
: kicked them to run. The child processes all access a common library.
: We have 384 cores so 3840 child processes running.  When migration occur on
: a page in the common library, the first child that access the page will
: page fault and lock the page, with the other children also page faulting
: quickly and pile up in the page wait list, till the first child is done.

Seems like someone should be able to write a test app that does
something along those lines fairly easily.  The trick is finding a
giant system to run it on.  Although doing it on a smaller system with
more SW threads/CPU would probably be enough.

> See for example commit 9a1ea439b16b ("mm:
> put_and_wait_on_page_locked() while page is migrated") which doesn't
> actually change the *locking* side, but drops the page reference when
> waiting for the locked page to be unlocked, which in turn removes a
> "loop and try again when migration". And that may have been the real
> _fix_ for the problem.

Actually, I think it fixes a livelock.  If you have hundreds (let alone
thousands) of threads all trying to migrate the same page, they're all
going to fail with the original code because migration can't succeed with
an elevated refcount, and each thread that is waiting holds a refcount.
I had a similar problem trying to split a folio in ->readpage with
one of the xfstests that has 500 threads all trying to read() from the
same page.  That was solved by also using put_and_wait_on_page_locked()
in bd8a1f3655a7 ("mm/filemap: support readpage splitting a page").

> Because while the bookmark thing avoids the NMI lockup detector firing
> due to excessive hold times, the bookmarking also _causes_ that "we
> now will see the same page multiple times because we dropped the lock
> and somebody re-added it at the end of the queue" issue. Which seems
> to be the problem here.
> 
> Ugh. I wish we had some way to test "could we just remove the bookmark
> code entirely again".

I think we should be safe to remove it entirely now.  Of course, that
may show somewhere else that now suffers from a similar livelock ...
but if it does, we ought to fix that anyway, because the bookmark
code is stopping the livelock problem from being seen.

> Of course, the PG_lock case also works fairly hard to not actually
> remove and re-add the lock waiter to the queue, but having an actual
> "wait for and get the lock" operation. The writeback bit isn't done
> that way.
> 
> I do hate how we had to make folio_wait_writeback{_killable}() use
> "while" rather than an "if". It *almost* works with just a "wait for
> current writeback", but not quite. See commit c2407cf7d22d ("mm: make
> wait_on_page_writeback() wait for multiple pending writebacks") for
> why we have to loop. Ugly, ugly.
> 
> Because I do think that "while" in the writeback waiting is a problem.
> Maybe _the_ problem.

I do like the idea of wait-and-set the writeback flag in the VFS instead
of leaving it to the individual filesystems.  I'll put it on my list of
things to do.

Actually ... I don't think that calling folio_start_writeback() twice
is a problem per se.  It's inefficient (cycling the i_pages lock,
walking the xarray, atomic bitoperations on the flag), but nothing
goes wrong.  Except that NFS and AFS check the return value and
squawk.

So how about we do something like this:

 - Make folio_start_writeback() and set_page_writeback() return void,
   fixing up AFS and NFS.
 - Add a folio_wait_start_writeback() to use in the VFS
 - Remove the calls to set_page_writeback() in the filesystems

That keepwrite thing troubles me, and hints it might be more complicated
than that.
