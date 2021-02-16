Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74331CCA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 16:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBPPJt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 10:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229626AbhBPPJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 10:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613488098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JCnbKFxVherPJvijqokAmpOf4MBIzvDJNcC9jg92S8M=;
        b=PAV4LeqAeFHKGmIkku9vrAS/YDdUMPgfgtXebctwyCRHTc57RABBBy+e+wOL5zgiwSDiib
        MZKk4IopOy1cEeU6AFpK3C6H1xWWRUaYfIIQi//7dISMBBPHtm4khzIU1KCpG5OMJdHe0e
        diwP9spfO/ICFMNdLJlBKoI59Qeywpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-o3PEyjdyPCSTBJfIKqjt2A-1; Tue, 16 Feb 2021 10:08:16 -0500
X-MC-Unique: o3PEyjdyPCSTBJfIKqjt2A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88CE100CCC1;
        Tue, 16 Feb 2021 15:08:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5855219D6C;
        Tue, 16 Feb 2021 15:08:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210216104914.GA28196@lst.de>
References: <20210216104914.GA28196@lst.de> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340402057.1303470.8038373593844486698.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] fscache, cachefiles: Add alternate API to use kiocb for read/write to cache
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1444258.1613488086.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 16 Feb 2021 15:08:06 +0000
Message-ID: <1444259.1613488086@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> > Filesystems wanting to use the new API must #define FSCACHE_USE_NEW_IO=
_API
> > before #including the header
> =

> What exactly does this ifdef buys us?  It seems like the old and new
> APIs don't even conflict.

I was asked to add this.  The APIs look like they don't conflict, but you
can't mix them for a given file because of the differing behaviour of the
PG_fscache flag.  It also makes it much easier to make sure you don't miss
something.  That has happened and it led to some strange effects before we
worked out what was going on.

> And if we really need an ifdef I'd rather use that for the old code to m=
ake
> grepping for that easier.

I can do it that way - but this doesn't require changing filesystems that
aren't being changed.  The intent would be to eliminate the #ifdef in a cy=
cle
or two anyway.

Besides, there are 5 filesystems that use this, and two of them are conver=
ted
here.  grep would only return three hits: one each in fs/9p/cache.h,
fs/cifs/fscache.h and fs/nfs/fscache.h.

OTOH, I suppose it might dissuade people from adding new usages of the old
API.

> > +	if (ki->term_func) {
> > +		if (ret < 0)
> > +			ki->term_func(ki->term_func_priv, ret);
> > +		else
> > +			ki->term_func(ki->term_func_priv, ki->skipped + ret);
> =

> Why not simplify:
> =

> 		if (ret > 0)
> 			ret +=3D ki->skipped;
> 		ki->term_func(ki->term_func_priv, ret);

Could do that I suppose.  The optimiser will make them the same anyway.

I still wonder if I should do something with ret2 as obtained from the kio=
cb
completion function:

  static void cachefiles_read_complete(struct kiocb *iocb, long ret, long =
ret2)

Can we consolidate to one return value?

> > +	/* If the caller asked us to seek for data before doing the read, th=
en
> > +	 * we should do that now.  If we find a gap, we fill it with zeros.
> > +	 */
> =

> FYI, this is not the normal kernel comment style..

I've been following the network style.

> > +	ret =3D rw_verify_area(READ, file, &ki->iocb.ki_pos, len - skipped);
> > +	if (ret < 0)
> > +		goto presubmission_error_free;
> > +
> > +	get_file(ki->iocb.ki_filp);
> > +
> > +	old_nofs =3D memalloc_nofs_save();
> > +	ret =3D call_read_iter(file, &ki->iocb, iter);
> > +	memalloc_nofs_restore(old_nofs);
> =

> As mentioned before I think all this magic belongs in to a helper
> in the VFS.

You suggested vfs_iocb_iter_read() in your reply to another patch, but it
occurs to me that that doesn't have memalloc_nofs_*() in it.  I could hois=
t
the memalloc_nofs stuff out and use those helpers.

> > +static const struct netfs_cache_ops cachefiles_netfs_cache_ops =3D {
> > +	.end_operation		=3D cachefiles_end_operation,
> > +	.read			=3D cachefiles_read,
> > +	.write			=3D cachefiles_write,
> > +	.expand_readahead	=3D NULL,
> > +	.prepare_read		=3D cachefiles_prepare_read,
> > +};
> ...
> Also at least in linux-next ->read and ->write seem to never actually
> be called.

See netfs_read_from_cache() and netfs_rreq_do_write_to_cache() in
fs/netfs/read_helper.c.  Look for "cres->ops->".

> > +{
> > +	struct cachefiles_object *object;
> > +	struct cachefiles_cache *cache;
> > +	struct path path;
> > +	struct file *file;
> > +
> > +	_enter("");
> > +
> > +	object =3D container_of(op->op.object,
> > +			      struct cachefiles_object, fscache);
> > +	cache =3D container_of(object->fscache.cache,
> > +			     struct cachefiles_cache, cache);
> > +
> > +	path.mnt =3D cache->mnt;
> > +	path.dentry =3D object->backer;
> > +	file =3D open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
> > +				   d_inode(object->backer), cache->cache_cred);
> =

> I think this should be plain old dentry_open?

open_with_fake_path() sets FMODE_NOACCOUNT.  In the fscache-iter branch, t=
he
file is held open a lot longer and then ENFILE/EMFILE starts being a serio=
us
problem.

That said, I'm considering changing things so that all the data in the cac=
he
is held in one or a few files with an index to locate things - at which po=
int
this issue goes away.

> > +	op =3D fscache_alloc_retrieval(cookie, NULL, NULL, NULL);
> > +	if (!op)
> > +		return -ENOMEM;
> > +	//atomic_set(&op->n_pages, 1);
> =

> ???

I should remove that - it kind of got left behind.  That was necessary for=
 the
old API, but a whole load of this code, including the fscache_retrieval st=
ruct
will be going away when the cookie and operation handling get rewritten.

> > +{
> > +	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
> > +		return __fscache_begin_read_operation(rreq, cookie);
> > +	else
> > +		return -ENOBUFS;
> > +}
> =

> No need for an else after a return.  I personally also prefer to always
> handle the error case first, ala:

It's not precisely an error case, more a "fallback required" case.

>         if (!fscache_cookie_valid(cookie) || !fscache_cookie_enabled(coo=
kie))
> 	                return -ENOBUFS;
> 	return __fscache_begin_read_operation(rreq, cookie);
> =

> Also do we really need this inline fast path to start with?

Yes.  fscache might be compiled out, in which case we'll never go down the
slow path.  And the common case is that cookie =3D=3D NULL, so let's not j=
ump out
of line if we don't have to.

David

