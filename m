Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854A96AAB28
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 17:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCDQjS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 11:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCDQjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:39:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7841B477;
        Sat,  4 Mar 2023 08:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=h97qSCKBwWKB/vgNGl/R2rNrAByzPswrGoQZipssPGg=; b=IgVFiNLcTJCMLaVE1nNe+gXi6O
        M94ahKtwVh8NWYTFWg/3iRrlZ58rayMTrKLYF2d/HMi3XTNDkjJMS24eAsYoCJEGMqGskv54cDoij
        A6vZiS8T4E2IhmTMAulcqCw6jhCGJJhHiJQJCIYP9srvi7E4QxvQlrOi4lQzIqeLcCiZOS0eWHYIi
        seTPHhJQTfkD6U2ZROwBkVcF7/FXNR7zVPvHda0BFSyY0Uc4wyv23jOnV7Tv/UouWQ4x2eBIT44+N
        jJho6nkn3JBfLlz+TKgF0vURa+FOiiL1RmgCYtaR09+ukfexTu0/96RpX/RZtMNUbxg9oOCGL+Xf+
        ylykMb6g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pYUuU-003wF5-VT; Sat, 04 Mar 2023 16:39:03 +0000
Date:   Sat, 4 Mar 2023 16:39:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAN0JkklyCRIXVo6@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
 <ZAL0ifa66TfMinCh@casper.infradead.org>
 <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 08:41:04AM -0500, James Bottomley wrote:
> On Sat, 2023-03-04 at 07:34 +0000, Matthew Wilcox wrote:
> > On Fri, Mar 03, 2023 at 08:11:47AM -0500, James Bottomley wrote:
> > > On Fri, 2023-03-03 at 03:49 +0000, Matthew Wilcox wrote:
> > > > On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
> > > > > That said, I was hoping you were going to suggest supporting
> > > > > 16k logical block sizes. Not a problem on some arch's, but
> > > > > still problematic when PAGE_SIZE is 4k. :)
> > > > 
> > > > I was hoping Luis was going to propose a session on LBA size >
> > > > PAGE_SIZE. Funnily, while the pressure is coming from the storage
> > > > vendors, I don't think there's any work to be done in the storage
> > > > layers.  It's purely a FS+MM problem.
> > > 
> > > Heh, I can do the fools rush in bit, especially if what we're
> > > interested in the minimum it would take to support this ...
> > > 
> > > The FS problem could be solved simply by saying FS block size must
> > > equal device block size, then it becomes purely a MM issue.
> > 
> > Spoken like somebody who's never converted a filesystem to
> > supporting large folios.  There are a number of issues:
> > 
> > 1. The obvious; use of PAGE_SIZE and/or PAGE_SHIFT
> 
> Well, yes, a filesystem has to be aware it's using a block size larger
> than page size.
> 
> > 2. Use of kmap-family to access, eg directories.  You can't kmap
> >    an entire folio, only one page at a time.  And if a dentry is
> > split across a page boundary ...
> 
> Is kmap relevant?  It's only used for reading user pages in the kernel
> and I can't see why a filesystem would use it unless it wants to pack
> inodes into pages that also contain user data, which is an optimization
> not a fundamental issue (although I grant that as the blocksize grows
> it becomes more useful) so it doesn't have to be part of the minimum
> viable prototype.

Filesystems often choose to store their metadata in HIGHMEM.  This wasn't
an entirely crazy idea back in, say, 2005, when you might be running
an ext2 filesystem on a machine with 32GB of RAM, and only 800MB of
address space for it.

Now it's silly.  Buy a real computer.  I'm getting more and more
comfortable with the idea that "Linux doesn't support block sizes >
PAGE_SIZE on 32-bit machines" is an acceptable answer.

> > 3. buffer_heads do not currently support large folios.  Working on
> > it.
> 
> Yes, I always forget filesystems still use the buffer cache.  But
> fundamentally the buffer_head structure can cope with buffers that span
> pages so most of the logic changes would be around grow_dev_page().  It
> seems somewhat messy but not too hard.

I forgot one particularly nasty case; we have filesystems (including the
mpage code used by a number of filesystems) which put an array of block
numbers on the stack.  Not a big deal when that's 8 entries (4kB/512 * 8
bytes = 64 bytes), but it starts to get noticable at 64kB PAGE_SIZE (1kB
is a little large for a stack allocation) and downright unreasonable
if you try to do something to a 2MB allocation (32kB).

> > Probably a few other things I forget.  But look through the recent
> > patches to AFS, CIFS, NFS, XFS, iomap that do folio conversions.
> > A lot of it is pretty mechanical, but some of it takes hard thought.
> > And if you have ideas about how to handle ext2 directories, I'm all
> > ears.
> 
> OK, so I can see you were waiting for someone to touch a nerve, but if
> I can go back to the stated goal, I never really thought *every*
> filesystem would be suitable for block size > page size, so simply
> getting a few of the modern ones working would be good enough for the
> minimum viable prototype.

XFS already works with arbitrary-order folios.  The only needed piece is
specifying to the VFS that there's a minimum order for this particular
inode, and having the VFS honour that everywhere.

What "touches a nerve" is people who clearly haven't been paying attention
to the problem making sweeping assertions about what the easy and hard
parts are.

> I fully understand that eventually we'll need to get a single large
> buffer to span discontiguous pages ... I noted that in the bit you cut,
> but I don't see why the prototype shouldn't start with contiguous
> pages.

I disagree that this is a desirable goal.  To solve the scalability
issues we have in the VFS, we need to manage memory in larger chunks
than PAGE_SIZE.  That makes the concerns expressed in previous years moot.
