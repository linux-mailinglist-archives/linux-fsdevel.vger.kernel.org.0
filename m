Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551F033E22C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 00:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhCPXdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 19:33:44 -0400
Received: from casper.infradead.org ([90.155.50.34]:44504 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhCPXdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 19:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ugD/jJZR2x4PlwFOPLM1Z8A1WHyvGKetbXN+yb06xfM=; b=OX7RitBwZ7oc3GO38XAXfxdoij
        vfKiFKYeao1v7N+9Nx7PTu9Z61XntTa7fENRJtgQ3CooWOi6pFGDLJfOCWvQSPDMt18AuEvLmsG/t
        w8/YLaN0lddz/EqtFRwAlhyPeA9k4RDxbsO5JOnmoGPMQvITYjkp3S7vUIHxpsbZNUio5Ko0ZVsEk
        spv1+ANWI7xmV3T6aAKDnp+5lQTDx1iFWg+gZ2u+pQegvhUWAjAjQXwbLjDk4o9yLmXkUmEvsqvJb
        3MnhN12ApsM12ymiXHH0JigGgpTf+2cbMmzeHJageIJBcRi9noxplnjX/iPmBZqWg1lpllSgZWaT2
        pwg8kffg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMJB6-000lEX-7N; Tue, 16 Mar 2021 23:32:48 +0000
Date:   Tue, 16 Mar 2021 23:32:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for
 PG_private_2/PG_fscache
Message-ID: <20210316233244.GE3420@casper.infradead.org>
References: <20210316190707.GD3420@casper.infradead.org>
 <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
 <3313319.1615927080@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3313319.1615927080@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 08:38:00PM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > So ... a page with both flags cleared should have a refcount of N.
> > A page with one or both flags set should have a refcount of N+1.
> > ...
> > How is a poor filesystem supposed to make that true?  Also btrfs has this
> > problem since it uses private_2 for its own purposes.
> 
> It's simpler if it's N+2 for both patches set.  Btw, patch 13 adds that - and
> possibly that should be merged into an earlier patch.

So ...

static inline int page_has_private(struct page *page)
{
	unsigned long flags = page->flags;
	return ((flags >> PG_private) & 1) + ((flags >> PG_private_2) & 1);
}

perhaps?
