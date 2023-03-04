Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F566AAA40
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 14:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCDNlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 08:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDNlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 08:41:10 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522CCF75E;
        Sat,  4 Mar 2023 05:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677937266;
        bh=0BnLfnbKbKNKsYCI8VyTnqzvOXG/vTqppzaUia/sHiw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PLx1HmSQAX/krZrfbLo+rNVNaPCGzbJqukUcMgZ5oHzBYTAA1/d7jq1dWSuXBvpy+
         Z3t8t3KFz+l4iE0Zw2k0rOw4AydCH1ExlmiYraxZvLh77iGTwRuR/BUhqcwIqBtO0v
         BDxKhuDHNqX6E2tJfVCXY4EphuGkYmOfP5H9Rewo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BFC381280954;
        Sat,  4 Mar 2023 08:41:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u3zTdhfQFg-Z; Sat,  4 Mar 2023 08:41:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1677937266;
        bh=0BnLfnbKbKNKsYCI8VyTnqzvOXG/vTqppzaUia/sHiw=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=PLx1HmSQAX/krZrfbLo+rNVNaPCGzbJqukUcMgZ5oHzBYTAA1/d7jq1dWSuXBvpy+
         Z3t8t3KFz+l4iE0Zw2k0rOw4AydCH1ExlmiYraxZvLh77iGTwRuR/BUhqcwIqBtO0v
         BDxKhuDHNqX6E2tJfVCXY4EphuGkYmOfP5H9Rewo=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id A205D1280050;
        Sat,  4 Mar 2023 08:41:05 -0500 (EST)
Message-ID: <2600732b9ed0ddabfda5831aff22fd7e4270e3be.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Date:   Sat, 04 Mar 2023 08:41:04 -0500
In-Reply-To: <ZAL0ifa66TfMinCh@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
         <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
         <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
         <f68905c5785b355b621847974d620fb59f021a41.camel@HansenPartnership.com>
         <ZAL0ifa66TfMinCh@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-03-04 at 07:34 +0000, Matthew Wilcox wrote:
> On Fri, Mar 03, 2023 at 08:11:47AM -0500, James Bottomley wrote:
> > On Fri, 2023-03-03 at 03:49 +0000, Matthew Wilcox wrote:
> > > On Thu, Mar 02, 2023 at 06:58:58PM -0700, Keith Busch wrote:
> > > > That said, I was hoping you were going to suggest supporting
> > > > 16k logical block sizes. Not a problem on some arch's, but
> > > > still problematic when PAGE_SIZE is 4k. :)
> > > 
> > > I was hoping Luis was going to propose a session on LBA size >
> > > PAGE_SIZE. Funnily, while the pressure is coming from the storage
> > > vendors, I don't think there's any work to be done in the storage
> > > layers.  It's purely a FS+MM problem.
> > 
> > Heh, I can do the fools rush in bit, especially if what we're
> > interested in the minimum it would take to support this ...
> > 
> > The FS problem could be solved simply by saying FS block size must
> > equal device block size, then it becomes purely a MM issue.
> 
> Spoken like somebody who's never converted a filesystem to
> supporting large folios.  There are a number of issues:
> 
> 1. The obvious; use of PAGE_SIZE and/or PAGE_SHIFT

Well, yes, a filesystem has to be aware it's using a block size larger
than page size.

> 2. Use of kmap-family to access, eg directories.  You can't kmap
>    an entire folio, only one page at a time.  And if a dentry is
> split across a page boundary ...

Is kmap relevant?  It's only used for reading user pages in the kernel
and I can't see why a filesystem would use it unless it wants to pack
inodes into pages that also contain user data, which is an optimization
not a fundamental issue (although I grant that as the blocksize grows
it becomes more useful) so it doesn't have to be part of the minimum
viable prototype.

> 3. buffer_heads do not currently support large folios.  Working on
> it.

Yes, I always forget filesystems still use the buffer cache.  But
fundamentally the buffer_head structure can cope with buffers that span
pages so most of the logic changes would be around grow_dev_page().  It
seems somewhat messy but not too hard.

> Probably a few other things I forget.  But look through the recent
> patches to AFS, CIFS, NFS, XFS, iomap that do folio conversions.
> A lot of it is pretty mechanical, but some of it takes hard thought.
> And if you have ideas about how to handle ext2 directories, I'm all
> ears.

OK, so I can see you were waiting for someone to touch a nerve, but if
I can go back to the stated goal, I never really thought *every*
filesystem would be suitable for block size > page size, so simply
getting a few of the modern ones working would be good enough for the
minimum viable prototype.

> 
> > The MM issue could be solved by adding a page order attribute to
> > struct address_space and insisting that pagecache/filemap functions
> > in mm/filemap.c all have to operate on objects that are an integer
> > multiple of the address space order.  The base allocator is
> > filemap_alloc_folio, which already has an apparently always zero
> > order parameter (hmmm...) and it always seems to be called from
> > sites that
> > have the address_space, so it could simply be modified to always
> > operate at the address_space order.
> 
> Oh, I have a patch for that.  That's the easy part.  The hard part is
> plugging your ears to the screams of the MM people who are convinced
> that fragmentation will make it impossible to mount your filesystem.

Right, so if the MM issue is solved it's picking a first FS for
conversion and solving the buffer problem.

I fully understand that eventually we'll need to get a single large
buffer to span discontiguous pages ... I noted that in the bit you cut,
but I don't see why the prototype shouldn't start with contiguous
pages.

James

