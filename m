Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC03EA604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhHLNw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbhHLNw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:52:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA962C061756;
        Thu, 12 Aug 2021 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FSEsyOd/4VgGNCa1AqMwPM0EjAO09/FKI4Y/RKgJ9oc=; b=PB5TN4rKLBFyrXRJ8+IpPQ6GFx
        2HZerN1HTd63PeshnKhem+nljRBmLxaui/i1om21F1sWmP+hMjDDJS55xmhS4oxKnXpp00KnpzlE2
        6tQVDF8Pd76VOg9hA0cSJAVGBbnv7LS9wdSGk8uZBVHe2WoYmsCL9EPrsjzBwNlB7m9OA+qWOBH1G
        DTyJpos7StYMPNb6UNL6IuKFA0DUtnHaaEuEKWdoAYnmFSKoMzx36cch7maZBd4MaeMtpzgCwzvbB
        9o5RCPCZF/Z5mBKHgCxOE1L3ECk8GErwIJcu9ZXSzHn3MSgCYAsxdlO5JdfXXv/TKXFzWMqGvGsxv
        lm77IDCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEB6d-00Ed87-Bu; Thu, 12 Aug 2021 13:50:55 +0000
Date:   Thu, 12 Aug 2021 14:50:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     trond.myklebust@primarydata.com, darrick.wong@oracle.com,
        hch@lst.de, jlayton@kernel.org, sfrench@samba.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make swap_readpage() for SWP_FS_OPS use
 ->direct_IO() not ->readpage()
Message-ID: <YRUnN+Y2CQ0qcjO6@casper.infradead.org>
References: <3088327.1628774588@warthog.procyon.org.uk>
 <YRUbXoMzWVX9X/Vf@casper.infradead.org>
 <162876946134.3068428.15475611190876694695.stgit@warthog.procyon.org.uk>
 <162876947840.3068428.12591293664586646085.stgit@warthog.procyon.org.uk>
 <3088958.1628775479@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3088958.1628775479@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 02:37:59PM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > > After submitting the IO here ...
> > > 
> > > > +	if (ret != -EIOCBQUEUED)
> > > > +		swapfile_read_complete(&ki->iocb, ret, 0);
> > > 
> > > We only touch the 'ki' here ... if the caller didn't call read_complete
> > > 
> > > > +	swapfile_put_kiocb(ki);
> > > 
> > > Except for here, which is only touched in order to put the refcount.
> > > 
> > > So why can't swapfile_read_complete() do the work of freeing the ki?
> > 
> > When I was doing something similar for cachefiles, I couldn't get it to work
> > like that.  I'll have another look at that.
> 
> Ah, yes.  generic_file_direct_write() accesses in the kiocb *after* calling
> ->direct_IO(), so the kiocb *must not* go away until after
> generic_file_direct_write() has returned.

This is a read, not a write ... but we don't care about ki_pos being
updated, so that store can be conditioned on IOCB_SWAP being clear.
Or instead of storing directly to ki_pos, we take a pointer to ki_pos
and then redirect that pointer somewhere harmless.
