Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A121439AE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 17:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhJYP6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhJYP6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:58:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23781C061745;
        Mon, 25 Oct 2021 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=63/HPzVfsVfvlLUwfHSmj4UKi2rkI606Smp9Pq0RM9c=; b=nG+4lV665EQSy1nSoqAv6NTX/5
        RAyNrlf56LVCcQMnq2jAutrG2feuzyVbHT4gZ6GWijnvxcxeJcmZRsNlEJwFXRIWpaHpPAuRylqeU
        hwG0mtAxF1n2hHKe49IW+RY6eOl034N2nbR+kdrRmDNtkaPA/xob9lZGiCXhcLCWDNQ4LZVuv8ghY
        LY6QxD+H5QT3JKrunKZFL3WHvMD2Y+imRDGQXUlQ5FqmVNqF1hqDgkDK3ZdCj3gqV2bfLp4NTX/2+
        OX7qktSNamN/HNYjFKQFefApvu6VxmWiJcwldnFc0+uoUN1h65lu2GQY+dbvvUAzoaGeriLCHwP/o
        iIGyz7ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf2Gm-00GEci-SZ; Mon, 25 Oct 2021 15:53:17 +0000
Date:   Mon, 25 Oct 2021 16:52:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Folios for 5.15 request - Was: re: Folio discussion recap -
Message-ID: <YXbSsAnr0vAZVze6@casper.infradead.org>
References: <YWpG1xlPbm7Jpf2b@casper.infradead.org>
 <YW2lKcqwBZGDCz6T@cmpxchg.org>
 <YW28vaoW7qNeX3GP@casper.infradead.org>
 <YW3tkuCUPVICvMBX@cmpxchg.org>
 <20211018231627.kqrnalsi74bgpoxu@box.shutemov.name>
 <YW7hQlny+Go1K3LT@cmpxchg.org>
 <YXBUPguecSeSO6UD@moria.home.lan>
 <YXHdpQTL1Udz48fc@cmpxchg.org>
 <YXIZX0truEBv2YSz@casper.infradead.org>
 <YXbOvR6jMXZ0WPcM@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXbOvR6jMXZ0WPcM@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 11:35:25AM -0400, Johannes Weiner wrote:
> On Fri, Oct 22, 2021 at 02:52:31AM +0100, Matthew Wilcox wrote:
> > > Anyway. I can even be convinved that we can figure out the exact fault
> > > lines along which we split the page down the road.
> > > 
> > > My worry is more about 2). A shared type and generic code is likely to
> > > emerge regardless of how we split it. Think about it, the only world
> > > in which that isn't true would be one in which either
> > > 
> > > 	a) page subtypes are all the same, or
> > > 	b) the subtypes have nothing in common
> > > 
> > > and both are clearly bogus.
> > 
> > Amen!
> > 
> > I'm convinced that pgtable, slab and zsmalloc uses of struct page can all
> > be split out into their own types instead of being folios.  They have
> > little-to-nothing in common with anon+file; they can't be mapped into
> > userspace and they can't be on the LRU.  The only situation you can find
> > them in is something like compaction which walks PFNs.
> 
> They can all be accounted to a cgroup. pgtables are tracked the same
> as other __GFP_ACCOUNT pages (pipe buffers and kernel stacks right now
> from a quick grep, but as you can guess that's open-ended).

Oh, this is good information!

> So if those all aren't folios, the generic type and the interfacing
> object for memcg and accounting would continue to be the page.
> 
> > Perhaps you could comment on how you'd see separate anon_mem and
> > file_mem types working for the memcg code?  Would you want to have
> > separate lock_anon_memcg() and lock_file_memcg(), or would you want
> > them to be cast to a common type like lock_folio_memcg()?
> 
> That should be lock_<generic>_memcg() since it actually serializes and
> protects the same thing for all subtypes (unlike lock_page()!).
> 
> The memcg interface is fully type agnostic nowadays, but it also needs
> to be able to handle any subtype. It should continue to interface with
> the broadest, most generic definition of "chunk of memory".

Some of the memory descriptors might prefer to keep their memcg_data at a
different offset from the start of the struct.  Can we accommodate that,
or do we ever get handed a specialised memory descriptor, then have to
cast back to an unspecialised descriptor?

(the LRU list would be an example of this; the list_head must be at the
same offset in all memory descriptors which use the LRU list)
