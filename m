Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2480C4DE94B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 17:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243630AbiCSQZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 12:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:25:01 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E7B8BF4D;
        Sat, 19 Mar 2022 09:23:39 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22JGN4VN007569
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Mar 2022 12:23:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 49E8815C0038; Sat, 19 Mar 2022 12:23:04 -0400 (EDT)
Date:   Sat, 19 Mar 2022 12:23:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjYDaBnN36zggeGa@mit.edu>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org>
 <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
 <YjOlJL7xwktKoLFN@casper.infradead.org>
 <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
 <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:56:04AM -0700, Linus Torvalds wrote:
> On Fri, Mar 18, 2022 at 6:16 AM Jan Kara <jack@suse.cz> wrote:
> >
> > I agree with Dave that 'keep_towrite' thing is kind of self-inflicted
> > damage on the ext4 side (we need to write out some blocks underlying the
> > page but cannot write all from the transaction commit code, so we need to
> > keep xarray tags intact so that data integrity sync cannot miss the page).
> > Also it is no longer needed in the current default ext4 setup. But if you
> > have blocksize < pagesize and mount the fs with 'dioreadlock,data=ordered'
> > mount options, the hack is still needed AFAIK and we don't have a
> > reasonable way around it.
> 
> I assume you meant 'dioread_lock'.
> 
> Which seems to be the default (even if 'data=ordered' is not).

That's not quite right.  data=ordered is the default, and that has
been the case since ext3 was introduced.

"dioread_lock" was the default in the days of ext3; "dioread_nolock"
was added to allow parallel Direct I/O reads (hence "nolock").  A
while back, we tried to make dioread_nolock the default since it tends
improve performance for workloads that have a mix of writes that
should be affected by fsyncs, and those that shouldn't.

Howevver, we had to revert that change when blocksize < pagesize to
work around a problem found on Power machines where "echo 3 >
drop_caches" on the host appears to cause file system corruptions on
the guest.  (Commit 626b035b816b "ext4: don't set dioread_nolock by
default for blocksize < pagesize").

> IOW, we could simply warn about "data=ordered is no longer supported"
> and turn it into data=journal.
> 
> Obviously *only* do this for the case of "blocksize < PAGE_SIZE".

Actiavelly, we've discussed a number of times doing the reverse ---
removing data=journal entirely, since it's (a) rarely used, and (b)
data=journal disables a bunch of optimizations, including
preallocation, and so its performance is pretty awful for most
workloads.  The main reason why haven't until now is that we believe
there is a small number of people who do find data=journal useful for
their workload, and at least _so_ far it's not been that hard to keep
it limping along --- although in most cases, data=journal doesn't get
supported for new features or performance optimizations, and it
definitely does note get as much testing.


So the thing that I've been waiting to do for a while is to replace
the whole data=ordered vs data=writeback and dioread_nolock and
dioread_lock is a complete reworking of the ext4 buffered writeback
path, where we write the data blocks *first*, and only then update the
ext4 metadata.

Historically, going as far back as ext2, we've always allocated data
blocks and updatted the metadata blocks, and only then updated the
buffer or page cache for the data blocks.  All of the complexities
around data=ordered, data=writeback, dioread_nolock, etc., is because
we haven't done the fundamental work of reversing the order in which
we do buffered writeback.   What we *should* be doing is:

*) Determining where the new allocated data blockblocks should be, and
   preventing those blocks from being used for any other purposes, but
   *not* updating the file system metadata to reflect that change.

*) Submit the data block write

*) On write completion, update the metadata blocks in a kernel thread.

Over time, we've been finding more and more reasons why I need to do
this work, so it's something I'm going to have to prioritize in the
next few months.

Cheerse,

						- Ted
