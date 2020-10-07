Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9167728656A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 19:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgJGRGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGRGC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:06:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C01C061755;
        Wed,  7 Oct 2020 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yKmG7sDo2Hnmphbd29uuI2McQMWDJPEwalTXCxvAe3w=; b=U9HXBDNu+js8W+6zeTrV/jtVbE
        oMZoX096Vc8qatSsLrVFG7bwYEYUWHjBzexbJg2O0Rge2BHdOTAHGkuoHcMBNJvkVFvlkbgWYoMaV
        D5g7T1A2br7NSa3/EP3hesxNxR+rP8hlaRJt5b8WIwE0EtyOGEkMU2TXl0eyIYF+eXRA2lw+dCJI2
        93JiKTXr0l/z2ovvqGoOYkSP0yzM6zD4PhTQuxnCTqBSDpaPXy7f6m3VTRMCxN36K0Y16lMFkMlnD
        0fM0rhB+yHBfryWGrgBHb9TgsEUqjETEcVHsfU7VjgXMA6KM7Db1Vd5Wde79UK81MdFSp+IvZwPRW
        sTkTHBKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQCt4-0005jh-S1; Wed, 07 Oct 2020 17:05:58 +0000
Date:   Wed, 7 Oct 2020 18:05:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007170558.GU20115@casper.infradead.org>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007144835.GA3471400@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 10:48:35AM -0400, Jerome Glisse wrote:
> On Wed, Oct 07, 2020 at 04:20:13AM +0100, Matthew Wilcox wrote:
> > On Tue, Oct 06, 2020 at 09:05:49PM -0400, jglisse@redhat.com wrote:
> > > The present patchset just add mapping argument to the various vfs call-
> > > backs. It does not make use of that new parameter to avoid regression.
> > > I am posting this whole things as small contain patchset as it is rather
> > > big and i would like to make progress step by step.
> > 
> > Well, that's the problem.  This patch set is gigantic and unreviewable.
> > And it has no benefits.  The idea you present here was discussed at
> > LSFMM in Utah and I recall absolutely nobody being in favour of it.
> > You claim many wonderful features will be unlocked by this, but I think
> > they can all be achieved without doing any of this very disruptive work.
> 
> You have any ideas on how to achieve them without such change ? I will
> be more than happy for a simpler solution but i fail to see how you can
> work around the need for a pointer inside struct page. Given struct
> page can not grow it means you need to be able to overload one of the
> existing field, at least i do not see any otherway.

The one I've spent the most time thinking about is sharing pages between
reflinked files.  My approach is to pull DAX entries into the main page
cache and have them reference the PFN directly.  It's not a struct page,
but we can find a struct page from it if we need it.  The struct page
would belong to a mapping that isn't part of the file.

For other things (NUMA distribution), we can point to something which
isn't a struct page and can be distiguished from a real struct page by a
bit somewhere (I have ideas for at least three bits in struct page that
could be used for this).  Then use a pointer in that data structure to
point to the real page.  Or do NUMA distribution at the inode level.
Have a way to get from (inode, node) to an address_space which contains
just regular pages.

Using main memory to cache DAX could be done today without any data
structure changes.  It just needs the DAX entries pulled up into the
main pagecache.  See earlier item.

Exclusive write access ... you could put a magic value in the pagecache
for pages which are exclusively for someone else's use and handle those
specially.  I don't entirely understand this use case.

I don't have time to work on all of these.  If there's one that
particularly interests you, let's dive deep into it and figure out how
you can do it without committing this kind of violence to struct page.
