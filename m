Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52022287BE1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgJHStA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 14:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729230AbgJHStA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602182938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XKvUN7mKPbV+B612jB+Si5npQlDaawUSuukFx01DKck=;
        b=Qm3OHv+7WtTMRXEPblASj+0Yaa3t9mT2F+0gIRDfz+feq89PxT1NqQDEuxoSdnI5KxnftT
        Y6oPv0d9Ok52HEJw/XN5ez6ZU9kEePOAe7o8mjkyQqt/tQSDlkBrfl6oOwTPvs2xOs/JO+
        Zgqguu7OaLIjtlSLlQc3AnxG3/l6i9A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-d1bW96jfNOOyzfUHXbAlQw-1; Thu, 08 Oct 2020 14:48:54 -0400
X-MC-Unique: d1bW96jfNOOyzfUHXbAlQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01FB99CC11;
        Thu,  8 Oct 2020 18:48:53 +0000 (UTC)
Received: from redhat.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7DC66EF4A;
        Thu,  8 Oct 2020 18:48:51 +0000 (UTC)
Date:   Thu, 8 Oct 2020 14:48:49 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 00/14] Small step toward KSM for file back page.
Message-ID: <20201008184849.GA3514601@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
 <20201007032013.GS20115@casper.infradead.org>
 <20201007144835.GA3471400@redhat.com>
 <20201007170558.GU20115@casper.infradead.org>
 <20201007175419.GA3478056@redhat.com>
 <20201007220916.GX20115@casper.infradead.org>
 <20201008153028.GA3508856@redhat.com>
 <20201008154341.GJ20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008154341.GJ20115@casper.infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 08, 2020 at 04:43:41PM +0100, Matthew Wilcox wrote:
> On Thu, Oct 08, 2020 at 11:30:28AM -0400, Jerome Glisse wrote:
> > On Wed, Oct 07, 2020 at 11:09:16PM +0100, Matthew Wilcox wrote:
> > > So ... why don't you put a PageKsm page in the page cache?  That way you
> > > can share code with the current KSM implementation.  You'd need
> > > something like this:
> > 
> > I do just that but there is no need to change anything in page cache.
> 
> That's clearly untrue.  If you just put a PageKsm page in the page
> cache today, here's what will happen on a truncate:
> 
> void truncate_inode_pages_range(struct address_space *mapping,
>                                 loff_t lstart, loff_t lend)
> {
> ...
>                 struct page *page = find_lock_page(mapping, start - 1);
> 
> find_lock_page() does this:
>         return pagecache_get_page(mapping, offset, FGP_LOCK, 0);
> 
> pagecache_get_page():
> 
> repeat:
>         page = find_get_entry(mapping, index);
> ...
>         if (fgp_flags & FGP_LOCK) {
> ...
>                 if (unlikely(compound_head(page)->mapping != mapping)) {
>                         unlock_page(page);
>                         put_page(page);
>                         goto repeat;
> 
> so it's just going to spin.  There are plenty of other codepaths that
> would need to be checked.  If you haven't found them, that shows you
> don't understand the problem deeply enough yet.

I also change truncate, splice and few other special cases that do
not goes through GUP/page fault/mkwrite (memory debug too but that's
a different beast).


> I believe we should solve this problem, but I don't think you're going
> about it the right way.

I have done much more than what i posted but there is bug that i
need to hammer down before posting everything and i wanted to get
the discussion started. I guess i will finish tracking that one
down and post the whole thing.


> > So flow is:
> > 
> >   Same as before:
> >     1 - write fault (address, vma)
> >     2 - regular write fault handler -> find page in page cache
> > 
> >   New to common page fault code:
> >     3 - ksm check in write fault common code (same as ksm today
> >         for anonymous page fault code path).
> >     4 - break ksm (address, vma) -> (file offset, mapping)
> >         4.a - use mapping and file offset to lookup the proper
> >               fs specific information that were save when the
> >               page was made ksm.
> >         4.b - allocate new page and initialize it with that
> >               information (and page content), update page cache
> >               and mappings ie all the pte who where pointing to
> >               the ksm for that mapping at that offset to now use
> >               the new page (like KSM for anonymous page today).
> 
> But by putting that logic in the page fault path, you've missed
> the truncate path.  And maybe other places.  Putting the logic
> down in pagecache_get_page() means you _don't_ need to find
> all the places that call pagecache_get_page().

They are cases where pagecache is not even in the loop ie you
already have the page and you do not need to look it up (page
fault, some fs common code, anything that goes through GUP,
memory reclaim, ...). Making all those places having to go
through page cache all the times will slow them down and many
are hot code path that i do not believe we want to slow even
if a feature is not use.

Cheers,
Jérôme

