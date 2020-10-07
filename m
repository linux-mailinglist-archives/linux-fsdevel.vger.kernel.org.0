Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8F28676B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 20:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgJGSdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 14:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgJGSdT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:33:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B5C061755;
        Wed,  7 Oct 2020 11:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U/c+B7T9WMrd6eL8WgkscuYEd+YykLCR9sKTV+rRDys=; b=c96dhvCXuJIi/qeyZLC5agD9yN
        qiFHXVMZDLOSUY70PBEI000aLqDNl98m2cQDIv8FucPUdLY8SKqi19p77SRh1shbJfIRFedT1yKkM
        utQZTINNrdvXEZ8s8b8XrmbOg8Cbi2KJvXNKvPnxKf2f2II4yiKXsBc4ef1V2NIgL4+8FgAEarRQr
        aboaQDSsodSV5MFG+/+g/qrqPKGkAeHTtrQtE62d2Du50L6XYO4PU2k4AOA3Acn2fB/V7B2KVcPv/
        xz3Yk/ZrzPXGQSlGIRBSHg2fo3fPFco3GvGE+WeOeRvB133K2T6KPAt+7yQH7g65faHN65J938kBj
        JtMSiQEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQEFY-0003Qk-33; Wed, 07 Oct 2020 18:33:16 +0000
Date:   Wed, 7 Oct 2020 19:33:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007183316.GV20115@casper.infradead.org>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
 <20201007175419.GA3478056@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007175419.GA3478056@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 01:54:19PM -0400, Jerome Glisse wrote:
> On Wed, Oct 07, 2020 at 06:05:58PM +0100, Matthew Wilcox wrote:
> > On Wed, Oct 07, 2020 at 10:48:35AM -0400, Jerome Glisse wrote:
> > > On Wed, Oct 07, 2020 at 04:20:13AM +0100, Matthew Wilcox wrote:
> > > > On Tue, Oct 06, 2020 at 09:05:49PM -0400, jglisse@redhat.com wrote:
> > > > > The present patchset just add mapping argument to the various vfs call-
> > > > > backs. It does not make use of that new parameter to avoid regression.
> > > > > I am posting this whole things as small contain patchset as it is rather
> > > > > big and i would like to make progress step by step.
> > > > 
> > > > Well, that's the problem.  This patch set is gigantic and unreviewable.
> > > > And it has no benefits.  The idea you present here was discussed at
> > > > LSFMM in Utah and I recall absolutely nobody being in favour of it.
> > > > You claim many wonderful features will be unlocked by this, but I think
> > > > they can all be achieved without doing any of this very disruptive work.
> > > 
> > > You have any ideas on how to achieve them without such change ? I will
> > > be more than happy for a simpler solution but i fail to see how you can
> > > work around the need for a pointer inside struct page. Given struct
> > > page can not grow it means you need to be able to overload one of the
> > > existing field, at least i do not see any otherway.
> > 
> > The one I've spent the most time thinking about is sharing pages between
> > reflinked files.  My approach is to pull DAX entries into the main page
> > cache and have them reference the PFN directly.  It's not a struct page,
> > but we can find a struct page from it if we need it.  The struct page
> > would belong to a mapping that isn't part of the file.
> 
> You would need to do a lot of filesystem specific change to make sure
> the fs understand the special mapping. It is doable but i feel it would
> have a lot of fs specific part.

I can't see any way to make it work without filesystem cooperation.

> > For other things (NUMA distribution), we can point to something which
> > isn't a struct page and can be distiguished from a real struct page by a
> > bit somewhere (I have ideas for at least three bits in struct page that
> > could be used for this).  Then use a pointer in that data structure to
> > point to the real page.  Or do NUMA distribution at the inode level.
> > Have a way to get from (inode, node) to an address_space which contains
> > just regular pages.
> 
> How do you find all the copies ? KSM maintains a list for a reasons.
> Same would be needed here because if you want to break the write prot
> you need to find all the copy first. If you intend to walk page table
> then how do you synchronize to avoid more copy to spawn while you
> walk reverse mapping, we could lock the struct page i guess. Also how
> do you walk device page table which are completely hidden from core mm.

You have the inode and you iterate over each mapping, looking up the page
that's in each mapping.  Or you use the i_mmap tree to find the pages.

> > Using main memory to cache DAX could be done today without any data
> > structure changes.  It just needs the DAX entries pulled up into the
> > main pagecache.  See earlier item.
> > 
> > Exclusive write access ... you could put a magic value in the pagecache
> > for pages which are exclusively for someone else's use and handle those
> > specially.  I don't entirely understand this use case.
> 
> For this use case you need a callback to break the protection and it
> needs to handle all cases ie not only write by CPU through file mapping
> but also file write syscall and other syscall that can write to page
> (pipe, ...).

If the page can't be found in the page cache, then by definition you
won't be able to write to them.

> > I don't have time to work on all of these.  If there's one that
> > particularly interests you, let's dive deep into it and figure out how
> 
> I care about KSM, duplicate NUMA copy (not only for CPU but also
> device) and write protection or exclusive write access. In each case
> you need a list of all the copy (for KSM of the deduplicated page)
> Having a special entry in the page cache does not sound like a good
> option in many code path you would need to re-look the page cache to
> find out if the page is in special state. If you use a bit flag in
> struct page how do you get to the callback or to the copy/alias,
> walk all the page tables ?

Like I said, something that _looks_ like a struct page.  At least looks
enough like a struct page that you can pull a pointer out of the page cache and check the bit.  But since it's not actually a struct page, you can
use the rest of the data structure for pointers to things you want to
track.  Like the real struct page.

> I do not see how i am doing violence to struct page :) The basis of
> my approach is to pass down the mapping. We always have the mapping
> at the top of the stack (either syscall entry point on a file or
> through the vma when working on virtual address).

Yes, you explained all that in Utah.  I wasn't impressed than, and I'm
not impressed now.
