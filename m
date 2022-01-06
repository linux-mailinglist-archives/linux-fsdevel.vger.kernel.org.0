Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBC48679A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiAFQ1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 11:27:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241202AbiAFQ1G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641486426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqGE+ogCsKbt8jpL4JhbwafMN3V+xGn5LKE8WlKnEkY=;
        b=YvdqY8XN6VFaN78TGcvB1ybWA0/cr3CWgvTifKaXO8JBsCERqwnpgL8W60ifNl+2xvc/rq
        SCWHtZq9ehjtzi3UcjbHdjGQHolZgHybwSK5eRFYoD9Zm1QMqns1BYAtgkEHLh0RFyLVV6
        fQD2r5FJjYHCZCsjlzU9LUqYGzriVAc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-2bLqDce9NF-N5Qh7l0pIvA-1; Thu, 06 Jan 2022 11:27:04 -0500
X-MC-Unique: 2bLqDce9NF-N5Qh7l0pIvA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF7AD92500;
        Thu,  6 Jan 2022 16:27:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26CED70D3D;
        Thu,  6 Jan 2022 16:26:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <043a206f03929c2667a465314144e518070a9b2d.camel@kernel.org>
References: <043a206f03929c2667a465314144e518070a9b2d.camel@kernel.org> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021525963.640689.9264556596205140044.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 28/68] fscache: Provide a function to note the release of a page
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2848130.1641486417.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 06 Jan 2022 16:26:57 +0000
Message-ID: <2848131.1641486417@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > +/**
> > + * fscache_note_page_release - Note that a netfs page got released
> > + * @cookie: The cookie corresponding to the file
> > + *
> > + * Note that a page that has been copied to the cache has been releas=
ed.  This
> > + * means that future reads will need to look in the cache to see if i=
t's there.
> > + */
> > +static inline
> > +void fscache_note_page_release(struct fscache_cookie *cookie)
> > +{
> > +	if (cookie &&
> > +	    test_bit(FSCACHE_COOKIE_HAVE_DATA, &cookie->flags) &&
> > +	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
> > +		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
> > +}
> > +
> >  #endif /* _LINUX_FSCACHE_H */
> > =

> > =

> =

> Is this logic correct?
> =

> FSCACHE_COOKIE_HAVE_DATA gets set in cachefiles_write_complete, but will
> that ever be called on a cookie that has no data? Will we ever call
> cachefiles_write at all when there is no data to be written?

FSCACHE_COOKIE_NO_DATA_TO_READ is set if we have no data in the cache yet
(ie. the backing file lookup was negative, the file is 0 length or the coo=
kie
got invalidated).  It means that we have no data in the cache, not that th=
e
file is necessarily empty on the server.

FSCACHE_COOKIE_HAVE_DATA is set once we've stored data in the backing file=
.
=46rom that point on, we have data we *could* read - however, it's covered=
 by
pages in the netfs pagecache until at such time one of those covering page=
s is
released.

So if we've written data to the cache (HAVE_DATA) and there wasn't any dat=
a in
the cache when we started (NO_DATA_TO_READ), it may no longer be true that=
 we
can skip reading from the cache.

Read skipping is done by cachefiles_prepare_read().

Note that I'm not doing tracking on a per-page basis, but only on a per-fi=
le
basis.

David

