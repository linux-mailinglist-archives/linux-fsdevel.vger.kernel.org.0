Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0812F28664B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 19:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgJGRyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 13:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728710AbgJGRyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602093271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NP2NwvRNkpskpbqtazC17Q7q1+ouDsoPdcjnY53Rhgc=;
        b=cfw4iEu4dbt9k2544boJWBEvvS4uk8W9kNsB26YMN38B57U4yE1s2bQoW878gIkREoBwYX
        Mld8VdAhIHOPgt+E6twotZiWBP4seRoIWsufjqLd4rjjWHXVRoPz3P1LsOJ7yWDmQwEPLe
        Cy6Q1N2lM1bw2L0BeMyp18xhzcdxsIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-YdsGazGJMfuY6Pu2pCBvfQ-1; Wed, 07 Oct 2020 13:54:27 -0400
X-MC-Unique: YdsGazGJMfuY6Pu2pCBvfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BF4119080B1;
        Wed,  7 Oct 2020 17:54:26 +0000 (UTC)
Received: from redhat.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96D1F6EF5B;
        Wed,  7 Oct 2020 17:54:24 +0000 (UTC)
Date:   Wed, 7 Oct 2020 13:54:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007175419.GA3478056@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007170558.GU20115@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 06:05:58PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 07, 2020 at 10:48:35AM -0400, Jerome Glisse wrote:
> > On Wed, Oct 07, 2020 at 04:20:13AM +0100, Matthew Wilcox wrote:
> > > On Tue, Oct 06, 2020 at 09:05:49PM -0400, jglisse@redhat.com wrote:
> > > > The present patchset just add mapping argument to the various vfs call-
> > > > backs. It does not make use of that new parameter to avoid regression.
> > > > I am posting this whole things as small contain patchset as it is rather
> > > > big and i would like to make progress step by step.
> > > 
> > > Well, that's the problem.  This patch set is gigantic and unreviewable.
> > > And it has no benefits.  The idea you present here was discussed at
> > > LSFMM in Utah and I recall absolutely nobody being in favour of it.
> > > You claim many wonderful features will be unlocked by this, but I think
> > > they can all be achieved without doing any of this very disruptive work.
> > 
> > You have any ideas on how to achieve them without such change ? I will
> > be more than happy for a simpler solution but i fail to see how you can
> > work around the need for a pointer inside struct page. Given struct
> > page can not grow it means you need to be able to overload one of the
> > existing field, at least i do not see any otherway.
> 
> The one I've spent the most time thinking about is sharing pages between
> reflinked files.  My approach is to pull DAX entries into the main page
> cache and have them reference the PFN directly.  It's not a struct page,
> but we can find a struct page from it if we need it.  The struct page
> would belong to a mapping that isn't part of the file.

You would need to do a lot of filesystem specific change to make sure
the fs understand the special mapping. It is doable but i feel it would
have a lot of fs specific part.


> For other things (NUMA distribution), we can point to something which
> isn't a struct page and can be distiguished from a real struct page by a
> bit somewhere (I have ideas for at least three bits in struct page that
> could be used for this).  Then use a pointer in that data structure to
> point to the real page.  Or do NUMA distribution at the inode level.
> Have a way to get from (inode, node) to an address_space which contains
> just regular pages.

How do you find all the copies ? KSM maintains a list for a reasons.
Same would be needed here because if you want to break the write prot
you need to find all the copy first. If you intend to walk page table
then how do you synchronize to avoid more copy to spawn while you
walk reverse mapping, we could lock the struct page i guess. Also how
do you walk device page table which are completely hidden from core mm.


> Using main memory to cache DAX could be done today without any data
> structure changes.  It just needs the DAX entries pulled up into the
> main pagecache.  See earlier item.
> 
> Exclusive write access ... you could put a magic value in the pagecache
> for pages which are exclusively for someone else's use and handle those
> specially.  I don't entirely understand this use case.

For this use case you need a callback to break the protection and it
needs to handle all cases ie not only write by CPU through file mapping
but also file write syscall and other syscall that can write to page
(pipe, ...).


> I don't have time to work on all of these.  If there's one that
> particularly interests you, let's dive deep into it and figure out how

I care about KSM, duplicate NUMA copy (not only for CPU but also
device) and write protection or exclusive write access. In each case
you need a list of all the copy (for KSM of the deduplicated page)
Having a special entry in the page cache does not sound like a good
option in many code path you would need to re-look the page cache to
find out if the page is in special state. If you use a bit flag in
struct page how do you get to the callback or to the copy/alias,
walk all the page tables ?

> you can do it without committing this kind of violence to struct page.

I do not see how i am doing violence to struct page :) The basis of
my approach is to pass down the mapping. We always have the mapping
at the top of the stack (either syscall entry point on a file or
through the vma when working on virtual address).

But we rarely pass down this mapping down the stack into the fs code.
I am only passing down the mapping through the bottom of the stack so
we do not need to rely of page->mapping all the time. I am not trying
to remove the page->mapping field, it is still usefull, i just want
to be able to overload it so that we can make KSM code generic and
allow to reuse that generic part for other usecase.

Cheers,
Jérôme

