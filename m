Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC7F286A6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 23:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgJGVpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 17:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbgJGVpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 17:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602107141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HW8OEIB2v/3NbD2TNZtIeljE7aJBVgAky13HzY3nNm4=;
        b=NdJ+zK5u3C4riPyi/7wEx6gbABaBI1vgMDCByAWBLKCvw2cZfvMiJEiCf5Tw8nx5EYlShs
        CuZel9E3jCiIyV4H3keS/v52A+DMnnYjOs0creK8NX5cWfNs8N99hLyX56WJM8KryN1dRY
        g3+KIEBKkcBY6U3Ed/GHK2zUQ429hyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-PjEJ89a3MAm8sT_gIn3EDw-1; Wed, 07 Oct 2020 17:45:36 -0400
X-MC-Unique: PjEJ89a3MAm8sT_gIn3EDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA65387950B;
        Wed,  7 Oct 2020 21:45:34 +0000 (UTC)
Received: from redhat.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0CB46EF5D;
        Wed,  7 Oct 2020 21:45:33 +0000 (UTC)
Date:   Wed, 7 Oct 2020 17:45:32 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201007214532.GA3484657@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
 <20201007175419.GA3478056@redhat.com>
 <20201007183316.GV20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007183316.GV20115@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 07, 2020 at 07:33:16PM +0100, Matthew Wilcox wrote:
> On Wed, Oct 07, 2020 at 01:54:19PM -0400, Jerome Glisse wrote:
> > On Wed, Oct 07, 2020 at 06:05:58PM +0100, Matthew Wilcox wrote:
> > > On Wed, Oct 07, 2020 at 10:48:35AM -0400, Jerome Glisse wrote:
> > > > On Wed, Oct 07, 2020 at 04:20:13AM +0100, Matthew Wilcox wrote:
> > > > > On Tue, Oct 06, 2020 at 09:05:49PM -0400, jglisse@redhat.com wrote:
> > > For other things (NUMA distribution), we can point to something which

[...]

> > > isn't a struct page and can be distiguished from a real struct page by a
> > > bit somewhere (I have ideas for at least three bits in struct page that
> > > could be used for this).  Then use a pointer in that data structure to
> > > point to the real page.  Or do NUMA distribution at the inode level.
> > > Have a way to get from (inode, node) to an address_space which contains
> > > just regular pages.
> > 
> > How do you find all the copies ? KSM maintains a list for a reasons.
> > Same would be needed here because if you want to break the write prot
> > you need to find all the copy first. If you intend to walk page table
> > then how do you synchronize to avoid more copy to spawn while you
> > walk reverse mapping, we could lock the struct page i guess. Also how
> > do you walk device page table which are completely hidden from core mm.
> 
> You have the inode and you iterate over each mapping, looking up the page
> that's in each mapping.  Or you use the i_mmap tree to find the pages.

This would slow down for everyone as we would have to walk all mapping
each time we try to write to page. Also we a have mechanism for page
write back to avoid race between thread trying to write and write back.
We would also need something similar. Without mediating this through
struct page i do not see how to keep this reasonable from performance
point of view.


> > > I don't have time to work on all of these.  If there's one that
> > > particularly interests you, let's dive deep into it and figure out how
> > 
> > I care about KSM, duplicate NUMA copy (not only for CPU but also
> > device) and write protection or exclusive write access. In each case
> > you need a list of all the copy (for KSM of the deduplicated page)
> > Having a special entry in the page cache does not sound like a good
> > option in many code path you would need to re-look the page cache to
> > find out if the page is in special state. If you use a bit flag in
> > struct page how do you get to the callback or to the copy/alias,
> > walk all the page tables ?
> 
> Like I said, something that _looks_ like a struct page.  At least looks
> enough like a struct page that you can pull a pointer out of the page
> cache and check the bit.  But since it's not actually a struct page,
> you can use the rest of the data structure for pointers to things you
> want to track.  Like the real struct page.

What i fear is the added cost because it means we need to do this look-
up everytime to check and we also need proper locking to avoid races.
Adding an ancilliary struct and trying to keep everything synchronize
seems harder to me.

> 
> > I do not see how i am doing violence to struct page :) The basis of
> > my approach is to pass down the mapping. We always have the mapping
> > at the top of the stack (either syscall entry point on a file or
> > through the vma when working on virtual address).
> 
> Yes, you explained all that in Utah.  I wasn't impressed than, and I'm
> not impressed now.

Is this more of a taste thing or is there something specific you do not
like ?

Cheers,
Jérôme

