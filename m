Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12B131C912
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 11:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhBPKuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 05:50:04 -0500
Received: from verein.lst.de ([213.95.11.211]:40815 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhBPKt7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:49:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D58946736F; Tue, 16 Feb 2021 11:49:14 +0100 (CET)
Date:   Tue, 16 Feb 2021 11:49:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/33] fscache, cachefiles: Add alternate API to use
 kiocb for read/write to cache
Message-ID: <20210216104914.GA28196@lst.de>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <161340402057.1303470.8038373593844486698.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161340402057.1303470.8038373593844486698.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 03:47:00PM +0000, David Howells wrote:
> Add an alternate API by which the cache can be accessed through a kiocb,
> doing async DIO, rather than using the current API that tells the cache
> where all the pages are.
> 
> The new API is intended to be used in conjunction with the netfs helper
> library.  A filesystem must pick one or the other and not mix them.
> 
> Filesystems wanting to use the new API must #define FSCACHE_USE_NEW_IO_API
> before #including the header

What exactly does this ifdef buys us?  It seems like the old and new
APIs don't even conflict.  And if we really need an ifdef I'd rather
use that for the old code to make grepping for that easier.

> +extern void cachefiles_put_object(struct fscache_object *_object,
> +				  enum fscache_obj_ref_trace why);

No need for the extern here on all the other function prototypes.

> +	if (ki->term_func) {
> +		if (ret < 0)
> +			ki->term_func(ki->term_func_priv, ret);
> +		else
> +			ki->term_func(ki->term_func_priv, ki->skipped + ret);

Why not simplify:

		if (ret > 0)
			ret += ki->skipped;
		ki->term_func(ki->term_func_priv, ret);

> +	/* If the caller asked us to seek for data before doing the read, then
> +	 * we should do that now.  If we find a gap, we fill it with zeros.
> +	 */

FYI, this is not the normal kernel comment style..

> +	ret = rw_verify_area(READ, file, &ki->iocb.ki_pos, len - skipped);
> +	if (ret < 0)
> +		goto presubmission_error_free;
> +
> +	get_file(ki->iocb.ki_filp);
> +
> +	old_nofs = memalloc_nofs_save();
> +	ret = call_read_iter(file, &ki->iocb, iter);
> +	memalloc_nofs_restore(old_nofs);

As mentioned before I think all this magic belongs in to a helper
in the VFS.

> +static const struct netfs_cache_ops cachefiles_netfs_cache_ops = {
> +	.end_operation		= cachefiles_end_operation,
> +	.read			= cachefiles_read,
> +	.write			= cachefiles_write,
> +	.expand_readahead	= NULL,
> +	.prepare_read		= cachefiles_prepare_read,
> +};

No need to set any member in a static allocated structure to zero.

Also at least in linux-next ->read and ->write seem to never actually
be called.

> +{
> +	struct cachefiles_object *object;
> +	struct cachefiles_cache *cache;
> +	struct path path;
> +	struct file *file;
> +
> +	_enter("");
> +
> +	object = container_of(op->op.object,
> +			      struct cachefiles_object, fscache);
> +	cache = container_of(object->fscache.cache,
> +			     struct cachefiles_cache, cache);
> +
> +	path.mnt = cache->mnt;
> +	path.dentry = object->backer;
> +	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
> +				   d_inode(object->backer), cache->cache_cred);

I think this should be plain old dentry_open?

> +extern struct fscache_retrieval *fscache_alloc_retrieval(struct fscache_cookie *,
> +							 struct address_space *,
> +							 fscache_rw_complete_t, void *);

No need for the extern.  And no need to indent the parameters totally out
sight, a single tab should be enough.  And it's always nice to spell out
the parameter names.

> +	op = fscache_alloc_retrieval(cookie, NULL, NULL, NULL);
> +	if (!op)
> +		return -ENOMEM;
> +	//atomic_set(&op->n_pages, 1);

???

> +static inline
> +int fscache_begin_read_operation(struct netfs_read_request *rreq,

Normal kernel style is to have the static and the inline on the
same line as the return type.

> +				 struct fscache_cookie *cookie)
> +{
> +	if (fscache_cookie_valid(cookie) && fscache_cookie_enabled(cookie))
> +		return __fscache_begin_read_operation(rreq, cookie);
> +	else
> +		return -ENOBUFS;
> +}

No need for an else after a return.  I personally also prefer to always
handle the error case first, ala:

        if (!fscache_cookie_valid(cookie) || !fscache_cookie_enabled(cookie))
	                return -ENOBUFS;
	return __fscache_begin_read_operation(rreq, cookie);

Also do we really need this inline fast path to start with?
