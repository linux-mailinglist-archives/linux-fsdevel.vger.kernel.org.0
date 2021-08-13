Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41B53EB102
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 09:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhHMHCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 03:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbhHMHCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:02:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A3DC061756;
        Fri, 13 Aug 2021 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=onKtoiz9ihWGwge0kQ+Ja7KXdN4ndzIdwSWxHzXriMk=; b=WlJYfTlr2mBSve0pr1f8L9Px2X
        h9ovcQELktRmcgcGPXPW6HdsvdabSAcqCDWWLLHYjSiezpT3caLaHOx+8Zh9xdjtWS8JD5RrCY3TD
        V55SQEtcAk2svYDD85ptBtrucbdiRvUiZSeWPChx5aVBvpwBtXiLvuPS1BFvkUUtmlCb2vI1IfOeQ
        4HLvrseYu1O9U4tivU3D34JRp/vie80XXJlnXxxDuatuyn/+tQqBY0tJJNsidgH70oAOpiyV4RE+A
        1zT2ZEnyhYfXtg1qCHYDnFc5yKTT85C70GVuP9/+IFNw4YoR0J6vYpuBTNLgNj/iI9ulbcofv4Kmj
        AOSycLbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mER4k-00FQ2P-O5; Fri, 13 Aug 2021 06:54:29 +0000
Date:   Fri, 13 Aug 2021 07:53:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] netfs, afs, ceph: Use folios
Message-ID: <YRYXAii0zZ0SzDt+@infradead.org>
References: <2408234.1628687271@warthog.procyon.org.uk>
 <YRVHLu3OAwylCONm@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRVHLu3OAwylCONm@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 05:07:10PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 11, 2021 at 02:07:51PM +0100, David Howells wrote:
> >  (*) Can page_endio() be split into two separate functions, one for read
> >      and one for write?  If seems a waste of time to conditionally switch
> >      between two different branches.
> 
> At this point I'm thinking ...
> 
> static inline void folio_end_read(struct folio *folio, int err)
> {
> 	if (!err)
> 		folio_set_uptodate(folio);
> 	folio_unlock(folio);
> }
> 
> Clearly the page isn't uptodate at this point, or ->readpage wouldn't've
> been called.  So there's no need to clear it.  And PageError is
> completely useless.

Just opencoding the above makes a lot more sense.  No need to turn err
into some acceptable form, and trivial to follow.  Not all little
convenience helpers are good.

> >  	}
> >  
> > -	*_page = page;
> > +	*_page = &folio->page;
> 
> Can't do anything about this one; the write_begin API needs to be fixed.

It actually needs to go away.  There's not real good use for that level
of API. netfs should just open code the releavant parts of
generic_perform_write, similar to iomap.

