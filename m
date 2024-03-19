Return-Path: <linux-fsdevel+bounces-14811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB2087FF63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49431F23935
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052881ABD;
	Tue, 19 Mar 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkfTjeZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EF81741
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857702; cv=none; b=fCebPB+nW9H2KXTLlmcuuKSt+SjAAILJFpOeauWLu5q+hFAtJB/6ygOLgIYEWXQ1FQn3Bs4uGjGc1Y7FACn9MAe5oAMXm13RR9kllgDHV5dwo8Cw5MbvcAW5AWD3zToqPuteHSZ43pe8q/gw8nSc4UxMhvAEAKfJk2Z5JVCa8lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857702; c=relaxed/simple;
	bh=xkAb1InU9RoZkNjiU+AcuFfqyRq8G3AqX8f6uQ9VC8Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=kshqnCtQVpEZuyBNDyNFES3JKux00kD/Ngw6phed8grvvpfk08z5gWgKJyG8QDWgkNEr5STv5JRccjZl6+uqLAhMFWYs9gEFJjj+oeKROGntqPxJnvXnD2Wl0hwdbcejl0qxWGD0wZHO00adoI7P9p+hfZK6c8rrINjUtBgK6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkfTjeZC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710857699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tO0V8aj/5qg/fr51DKNlXHyJU/GLErDbNftb0tj9j8Q=;
	b=TkfTjeZCft50cIYUEhpwQGWSGr2vBI2tAwUd2VexjQuFOMmVwBn3oVuH0mGK7nOckK/0cE
	HfM3Q+FHzO696SBjfOGKEYUqup4Tr5kZ09+xm+rfYjS7le0Z87VOSikH4j2h29sNAon/T0
	H8qKZmztx4eg+uEgUCb7P5lOH22V9EY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368--eOoKW_BP26pSFwrkb5TTQ-1; Tue, 19 Mar 2024 10:14:56 -0400
X-MC-Unique: -eOoKW_BP26pSFwrkb5TTQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5463C101CF81;
	Tue, 19 Mar 2024 14:14:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58E25492BD0;
	Tue, 19 Mar 2024 14:14:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com>
References: <CAJfpegv8X0PY7PvxEF=zEwRbdZ7yZZcwB80iDO+XLverognx+g@mail.gmail.com> <1668172.1709764777@warthog.procyon.org.uk> <ZelGX3vVlGfEZm8H@casper.infradead.org> <1831809.1709807788@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
    linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev,
    v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
    ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, devel@lists.orangefs.org,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: Replace ->launder_folio() with flush and wait
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <651178.1710857687.1@warthog.procyon.org.uk>
Date: Tue, 19 Mar 2024 14:14:47 +0000
Message-ID: <651179.1710857687@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Miklos Szeredi <miklos@szeredi.hu> wrote:

> >  (2) invalidate_inode_pages2() is used in some places to effect
> >      invalidation of the pagecache in the case where the server tells us
> >      that a third party modified the server copy of a file.  What the
> >      right behaviour should be here, I'm not sure, but at the moment, any
> >      dirty data will get laundered back to the server.  Possibly it should
> >      be simply invalidated locally or the user asked how they want to
> >      handle the divergence.
> 
> Skipping ->launder_page will mean there's a window where the data
> *will* be lost, AFAICS.
> 
> Of course concurrent cached writes on different hosts against the same
> region (the size of which depends on how the caching is done) will
> conflict.

Indeed.  Depending on when you're using invalidate_inode_pages2() and co. and
what circumstances you're using it for, you *are* going to suffer data loss.

For instance, if you have dirty data on the local host and get an invalidation
notification from the server: if you write just your dirty data back, you may
corrupt the file on the server, losing the third party changes; if you write
back your entire copy of the file, you might avoid corrupting the file, but
completely obliterate the third party changes; if you discard your changes,
you lose those instead, but save the third party changes.

I'm working towards supporting disconnected operation where I'll need to add
some sort of user interaction mechanism that will allow the user to say how
they want to handle this.

> But if concurrent writes are to different regions, then they shouldn't
> be lost, no?  Without the current ->launder_page thing I don't see how
> that could be guaranteed.

Define "different regions".  If they're not on the same folios, then why would
they be lost by simply flushing the data before doing the invalidation?  If
they are on different parts of the same folio, all the above still apply when
you flush the whole folio.

Now, you can mitigate the latter case by keeping track of which bytes changed,
but that still allows you to corrupt the file by writing back just your
particular changes.

And then there's the joker in the deck: mmap.  The main advantage of
invalidate_inode_pages2() is that it forcibly unmaps the page before
laundering it.  However, this doesn't prevent you then corrupting the upstream
copy by writing the changes back.

What particular usage case of invalidate_inode_pages2() are you thinking of?

DIO read/write can only be best effort: flush, invalidate then do the DIO
which may bring the buffers back in because they're mmapped.  In which case
doing a flush and a non-laundering invalidate that leaves dirty pages in place
ought to be fine.

David


