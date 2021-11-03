Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5144440D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 15:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhKCPBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 11:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhKCPBU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635951523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioiM+Du60rzXrbVCIHTdbL7lBwbxpxRPlGADqNtS8t8=;
        b=GcrqyYypsY7s0U8qJL/OwflY6Sb8N13PGPKhCP8C4QzFn0kr0GuPrwKShZ0UdBxRCZT3zt
        BY8/uq6Ia3w6HJgOBQ8TPmRoePD9nTwHUo9xA/sJxvUMciKdhwOw1t0K2d9qFIl9+vMLC1
        vJALMPzww1tlXSihhJvedh+JLfFL82I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-sSG_VRK5OiSDTeHnbcefkg-1; Wed, 03 Nov 2021 10:58:40 -0400
X-MC-Unique: sSG_VRK5OiSDTeHnbcefkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E91656C8B;
        Wed,  3 Nov 2021 14:58:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C887D69FA2;
        Wed,  3 Nov 2021 14:58:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YYKa3bfQZxK5/wDN@casper.infradead.org>
References: <YYKa3bfQZxK5/wDN@casper.infradead.org> <163584174921.4023316.8927114426959755223.stgit@warthog.procyon.org.uk> <163584187452.4023316.500389675405550116.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] netfs, 9p, afs, ceph: Use folios
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1038256.1635951492.1@warthog.procyon.org.uk>
Date:   Wed, 03 Nov 2021 14:58:12 +0000
Message-ID: <1038257.1635951492@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +	len = (size >= start + gran) ? gran : size - start;
> 
> This seems like the most complicated way to write this ... how about:
> 
>         size_t len = min_t(loff_t, isize - start, folio_size(folio));

I was trying to hedge against isize-start going negative.  Can this code race
against truncate?  truncate_setsize() changes i_size *before* invalidating the
pages.

> >  static int afs_symlink_readpage(struct file *file, struct page *page)
> >  {
> > -	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
> > +	struct afs_vnode *vnode = AFS_FS_I(page_mapping(page)->host);
> 
> How does swap end up calling readpage on a symlink?

Um - readpage is called to read the symlink.

> > -	page_endio(page, false, ret);
> > +	page_endio(&folio->page, false, ret);
> 
> We need a folio_endio() ...

I think we mentioned this before and I think you said you had or would make a
patch for it.  I can just create a wrapper for it if that'll do.

David

