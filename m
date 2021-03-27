Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A634B576
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 09:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhC0Ibp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 04:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhC0Ibn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616833903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bbOL3irgRfzOHP3/c5t81XACOHIUpl+HN0q6jVzA+SI=;
        b=XAhNvGKztftXh/F+uuEkgrKLIkqTeR96GCku674dCPB2bt5xfbaAqMonuk4hpqv1oUM5pq
        kji883d1ckQqZA2qzpf+SYd0eKRMPNshIlgAibrua+z/oWHM7Ly1AfXSrxZHgAZxL1LB9m
        VZ7Xy6pA1/iX7af40WvQ8z4tL5NY6NA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-dsLd_zk6POCuaLQe1GkrMA-1; Sat, 27 Mar 2021 04:31:40 -0400
X-MC-Unique: dsLd_zk6POCuaLQe1GkrMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEF961007468;
        Sat, 27 Mar 2021 08:31:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E1D690F1;
        Sat, 27 Mar 2021 08:31:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210327035019.GG1719932@casper.infradead.org>
References: <20210327035019.GG1719932@casper.infradead.org> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com> <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1507387.1616833898.1@warthog.procyon.org.uk>
Date:   Sat, 27 Mar 2021 08:31:38 +0000
Message-ID: <1507388.1616833898@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > I've been looking at it a long time :-), I'll look more
> > tomorrow... do you see anything obvious?
> 
> Yes; Dave's sample code doesn't consume the pages from the readahead
> iterator, so the core code thinks you didn't consume them and unlocks
> / puts the pages for you.  That goes wrong, because you did actually
> consume them.  Glad I added the assertions now!

Yeah...  The cleanup function that I posted potentially happens asynchronously
from the ->readahead function, so the ractl consumption has to be done
elsewhere and may already have happened.  In the case of the code I posted
from, it's actually done in the netfs lib that's in the works:

void netfs_readahead(...)
{
...
	/* Drop the refs on the pages here rather than in the cache or
	 * filesystem.  The locks will be dropped in netfs_rreq_unlock().
	 */
	while ((page = readahead_page(ractl)))
		put_page(page);
...
}

> We should probably add something like:
> 
> static inline void readahead_consume(struct readahead_control *ractl,
> 		unsigned int nr)
> {
> 	ractl->_nr_pages -= nr;
> 	ractl->_index += nr;
> }
> 
> to indicate that you consumed the pages other than by calling
> readahead_page() or readahead_page_batch().  Or maybe Dave can
> wrap iov_iter_xarray() in a readahead_iter() macro or something
> that takes care of adjusting index & nr_pages for you.

I'm not sure either is useful for my case since iov_iter_xarray() for me isn't
being used anywhere that there's an ractl and I still have to drop the page
refs.

However, in Mike's orangefs_readahead_cleanup(), he could replace:

	rcu_read_lock();
	xas_for_each(&xas, page, last) {
		page_endio(page, false, 0);
		put_page(page);
	}
	rcu_read_unlock();

with:

	while ((page = readahead_page(ractl))) {
		page_endio(page, false, 0);
		put_page(page);
	}

maybe?

David

