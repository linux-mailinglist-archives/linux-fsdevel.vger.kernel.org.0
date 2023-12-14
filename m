Return-Path: <linux-fsdevel+bounces-6058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9036081306D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182BD1F22151
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2B4D58A;
	Thu, 14 Dec 2023 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzPy7UwU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98434177A;
	Thu, 14 Dec 2023 12:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC3FC433C7;
	Thu, 14 Dec 2023 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702557785;
	bh=zSVF6NzO+A+mhu3Y9Z3RNtw/mvo+KasUoTd8T7k89ag=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nzPy7UwU+c1ADPENvtxvguztaVIO0NAfSoIUpBniIO6LFY48Bn3VABvk5oj/NkuMy
	 1rG3t1J5rjxIhW+hPoD5vv6bvMTRtZ3PgoZ9M3Z8ELM6QNRIgHkaNGRvwzM/Pzx73d
	 GtQIk30+m3N+NNFDPvAgFUCSaXUuNLo6e7QkN4cReY9O+UE6khgz7Kdg7hNDTS9KgY
	 jdSa3QOl3G4GifWJ8gbOScDDNE/AhJdKEwC9K6yGwkUGKMXTLi1mCpV09QIqUMSRmN
	 rksqp7zGfax4xQG5Sg/gCKLcnlaNZs050NUE7sX0xksebSYVFQ1AwTmp21pgWJyTKV
	 Za8tzEAbOWgYw==
Message-ID: <36ba1d9f8668e701a9eebcc6cbaa9367e7ccb182.camel@kernel.org>
Subject: Re: [PATCH v4 28/39] netfs: Implement support for unbuffered/DIO
 read
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Christian Brauner
 <christian@brauner.io>, linux-cachefs@redhat.com,
 linux-afs@lists.infradead.org,  linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org,  ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,  linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 14 Dec 2023 07:43:02 -0500
In-Reply-To: <20231213152350.431591-29-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
	 <20231213152350.431591-29-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 15:23 +0000, David Howells wrote:
> Implement support for unbuffered and DIO reads in the netfs library,
> utilising the existing read helper code to do block splitting and
> individual queuing.  The code also handles extraction of the destination
> buffer from the supplied iterator, allowing async unbuffered reads to tak=
e
> place.
>=20
> The read will be split up according to the rsize setting and, if supplied=
,
> the ->clamp_length() method.  Note that the next subrequest will be issue=
d
> as soon as issue_op returns, without waiting for previous ones to finish.
> The network filesystem needs to pause or handle queuing them if it doesn'=
t
> want to fire them all at the server simultaneously.
>=20
> Once all the subrequests have finished, the state will be assessed and th=
e
> amount of data to be indicated as having being obtained will be
> determined.  As the subrequests may finish in any order, if an intermedia=
te
> subrequest is short, any further subrequests may be copied into the buffe=
r
> and then abandoned.
>=20
> In the future, this will also take care of doing an unbuffered read from
> encrypted content, with the decryption being done by the library.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/Makefile            |   1 +
>  fs/netfs/direct_read.c       | 252 +++++++++++++++++++++++++++++++++++
>  fs/netfs/internal.h          |   1 +
>  fs/netfs/io.c                |  82 ++++++++++--
>  fs/netfs/main.c              |   1 +
>  fs/netfs/objects.c           |   5 +-
>  fs/netfs/stats.c             |   4 +-
>  include/linux/netfs.h        |   9 ++
>  include/trace/events/netfs.h |   7 +-
>  mm/filemap.c                 |   1 +
>  10 files changed, 352 insertions(+), 11 deletions(-)
>  create mode 100644 fs/netfs/direct_read.c
>=20
> diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
> index 85d8333a1ed4..e968ab1eca40 100644
> --- a/fs/netfs/Makefile
> +++ b/fs/netfs/Makefile
> @@ -3,6 +3,7 @@
>  netfs-y :=3D \
>  	buffered_read.o \
>  	buffered_write.o \
> +	direct_read.o \
>  	io.o \
>  	iterator.o \
>  	locking.o \
> diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
> new file mode 100644
> index 000000000000..1d26468aafd9
> --- /dev/null
> +++ b/fs/netfs/direct_read.c
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Direct I/O support.
> + *
> + * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
> +#include <linux/slab.h>
> +#include <linux/uio.h>
> +#include <linux/sched/mm.h>
> +#include <linux/task_io_accounting_ops.h>
> +#include <linux/netfs.h>
> +#include "internal.h"
> +
> +/*
> + * Copy all of the data from the folios in the source xarray into the
> + * destination iterator.  We cannot step through and kmap the dest itera=
tor if
> + * it's an iovec, so we have to step through the xarray and drop the RCU=
 lock
> + * each time.
> + */
> +static int netfs_copy_xarray_to_iter(struct netfs_io_request *rreq,
> +				     struct xarray *xa, struct iov_iter *dst,
> +				     unsigned long long start, size_t avail)
> +{
> +	struct folio *folio;
> +	void *base;
> +	pgoff_t index =3D start / PAGE_SIZE;
> +	size_t len, copied, count =3D min(avail, iov_iter_count(dst));
> +
> +	XA_STATE(xas, xa, index);
> +
> +	_enter("%zx", count);
> +
> +	if (!count) {
> +		trace_netfs_failure(rreq, NULL, -EIO, netfs_fail_dio_read_zero);
> +		return -EIO;
> +	}
> +
> +	len =3D PAGE_SIZE - offset_in_page(start);
> +	rcu_read_lock();
> +	xas_for_each(&xas, folio, ULONG_MAX) {
> +		size_t offset;
> +
> +		if (xas_retry(&xas, folio))
> +			continue;
> +
> +		/* There shouldn't be a need to call xas_pause() as no one else
> +		 * should be modifying the xarray we're iterating over.
> +		 * Really, we only need the RCU readlock to keep lockdep happy
> +		 * inside xas_for_each().
> +		 */
> +		rcu_read_unlock();
> +

Are you sure it's still safe to access "folio" once you've dropped the
rcu_read_lock? I wonder if you need to take a reference or something.

I guess if this is a "private" xarray then nothing should be modifying
it?
=20
> +		offset =3D offset_in_folio(folio, start);
> +		kdebug("folio %lx +%zx [%llx]", folio->index, offset, start);
> +
> +		while (offset < folio_size(folio)) {
> +			len =3D min(count, len);
> +
> +			base =3D kmap_local_folio(folio, offset);
> +			copied =3D copy_to_iter(base, len, dst);
> +			kunmap_local(base);
> +			if (copied !=3D len)
> +				goto out;
> +			count -=3D len;
> +			if (count =3D=3D 0)
> +				goto out;
> +
> +			start +=3D len;
> +			offset +=3D len;
> +			len =3D PAGE_SIZE;
> +		}
> +
> +		rcu_read_lock();
> +	}
> +
> +	rcu_read_unlock();
> +out:
> +	_leave(" =3D %zx", count);
> +	return count ? -EFAULT : 0;
> +}
> +
> +/*
> + * If we did a direct read to a bounce buffer (say we needed to decrypt =
it),
> + * copy the data obtained to the destination iterator.
> + */
> +static int netfs_dio_copy_bounce_to_dest(struct netfs_io_request *rreq)
> +{
> +	struct iov_iter *dest_iter =3D &rreq->iter;
> +	struct kiocb *iocb =3D rreq->iocb;
> +	unsigned long long start =3D rreq->start;
> +
> +	_enter("%zx/%zx @%llx", rreq->transferred, rreq->len, start);
> +
> +	if (!test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags))
> +		return 0;
> +
> +	if (start < iocb->ki_pos) {
> +		if (rreq->transferred <=3D iocb->ki_pos - start) {
> +			trace_netfs_failure(rreq, NULL, -EIO, netfs_fail_dio_read_short);
> +			return -EIO;
> +		}
> +		rreq->len =3D rreq->transferred;
> +		rreq->transferred -=3D iocb->ki_pos - start;
> +	}
> +
> +	if (rreq->transferred > iov_iter_count(dest_iter))
> +		rreq->transferred =3D iov_iter_count(dest_iter);
> +
> +	_debug("xfer %zx/%zx @%llx", rreq->transferred, rreq->len, iocb->ki_pos=
);
> +	return netfs_copy_xarray_to_iter(rreq, &rreq->bounce, dest_iter,
> +					 iocb->ki_pos, rreq->transferred);
> +}
> +
> +/**
> + * netfs_unbuffered_read_iter_locked - Perform an unbuffered or direct I=
/O read
> + * @iocb: The I/O control descriptor describing the read
> + * @iter: The output buffer (also specifies read length)
> + *
> + * Perform an unbuffered I/O or direct I/O from the file in @iocb to the
> + * output buffer.  No use is made of the pagecache.
> + *
> + * The caller must hold any appropriate locks.
> + */
> +static ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, str=
uct iov_iter *iter)
> +{
> +	struct netfs_io_request *rreq;
> +	struct netfs_inode *ctx;
> +	unsigned long long start, end;
> +	unsigned int min_bsize;
> +	pgoff_t first, last;
> +	ssize_t ret;
> +	size_t orig_count =3D iov_iter_count(iter);
> +	bool async =3D !is_sync_kiocb(iocb);
> +
> +	_enter("");
> +
> +	if (!orig_count)
> +		return 0; /* Don't update atime */
> +
> +	ret =3D kiocb_write_and_wait(iocb, orig_count);
> +	if (ret < 0)
> +		return ret;
> +	file_accessed(iocb->ki_filp);
> +
> +	rreq =3D netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
> +				   iocb->ki_pos, orig_count,
> +				   NETFS_DIO_READ);
> +	if (IS_ERR(rreq))
> +		return PTR_ERR(rreq);
> +
> +	ctx =3D netfs_inode(rreq->inode);
> +	netfs_stat(&netfs_n_rh_dio_read);
> +	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_dio_rea=
d);
> +
> +	/* If this is an async op, we have to keep track of the destination
> +	 * buffer for ourselves as the caller's iterator will be trashed when
> +	 * we return.
> +	 *
> +	 * In such a case, extract an iterator to represent as much of the the
> +	 * output buffer as we can manage.  Note that the extraction might not
> +	 * be able to allocate a sufficiently large bvec array and may shorten
> +	 * the request.
> +	 */
> +	if (user_backed_iter(iter)) {
> +		ret =3D netfs_extract_user_iter(iter, rreq->len, &rreq->iter, 0);
> +		if (ret < 0)
> +			goto out;
> +		rreq->direct_bv =3D (struct bio_vec *)rreq->iter.bvec;
> +		rreq->direct_bv_count =3D ret;
> +		rreq->direct_bv_unpin =3D iov_iter_extract_will_pin(iter);
> +		rreq->len =3D iov_iter_count(&rreq->iter);
> +	} else {
> +		rreq->iter =3D *iter;
> +		rreq->len =3D orig_count;
> +		rreq->direct_bv_unpin =3D false;
> +		iov_iter_advance(iter, orig_count);
> +	}
> +
> +	/* If we're going to use a bounce buffer, we need to set it up.  We
> +	 * will then need to pad the request out to the minimum block size.
> +	 */
> +	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags)) {
> +		start =3D rreq->start;
> +		end =3D min_t(unsigned long long,
> +			    round_up(rreq->start + rreq->len, min_bsize),
> +			    ctx->remote_i_size);
> +
> +		rreq->start =3D start;
> +		rreq->len   =3D end - start;
> +		first =3D start / PAGE_SIZE;
> +		last  =3D (end - 1) / PAGE_SIZE;
> +		_debug("bounce %llx-%llx %lx-%lx",
> +		       rreq->start, end, first, last);
> +
> +		ret =3D netfs_add_folios_to_buffer(&rreq->bounce, rreq->mapping,
> +						 first, last, GFP_KERNEL);
> +		if (ret < 0)
> +			goto out;
> +	}
> +
> +	if (async)
> +		rreq->iocb =3D iocb;
> +
> +	ret =3D netfs_begin_read(rreq, is_sync_kiocb(iocb));
> +	if (ret < 0)
> +		goto out; /* May be -EIOCBQUEUED */
> +	if (!async) {
> +		ret =3D netfs_dio_copy_bounce_to_dest(rreq);
> +		if (ret =3D=3D 0) {
> +			iocb->ki_pos +=3D rreq->transferred;
> +			ret =3D rreq->transferred;
> +		}
> +	}
> +
> +out:
> +	netfs_put_request(rreq, false, netfs_rreq_trace_put_return);
> +	if (ret > 0)
> +		orig_count -=3D ret;
> +	if (ret !=3D -EIOCBQUEUED)
> +		iov_iter_revert(iter, orig_count - iov_iter_count(iter));
> +	return ret;
> +}
> +
> +/**
> + * netfs_unbuffered_read_iter - Perform an unbuffered or direct I/O read
> + * @iocb: The I/O control descriptor describing the read
> + * @iter: The output buffer (also specifies read length)
> + *
> + * Perform an unbuffered I/O or direct I/O from the file in @iocb to the
> + * output buffer.  No use is made of the pagecache.
> + */
> +ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *=
iter)
> +{
> +	struct inode *inode =3D file_inode(iocb->ki_filp);
> +	ssize_t ret;
> +
> +	if (!iter->count)
> +		return 0; /* Don't update atime */
> +
> +	ret =3D netfs_start_io_direct(inode);
> +	if (ret =3D=3D 0) {
> +		ret =3D netfs_unbuffered_read_iter_locked(iocb, iter);
> +		netfs_end_io_direct(inode);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(netfs_unbuffered_read_iter);
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 62c349cc71f9..5bb1cdbdee0e 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -100,6 +100,7 @@ int netfs_begin_write(struct netfs_io_request *wreq, =
bool may_wait,
>   * stats.c
>   */
>  #ifdef CONFIG_NETFS_STATS
> +extern atomic_t netfs_n_rh_dio_read;
>  extern atomic_t netfs_n_rh_readahead;
>  extern atomic_t netfs_n_rh_readpage;
>  extern atomic_t netfs_n_rh_rreq;
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index 776ca0aa6b62..e017dc735cdb 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -78,7 +78,9 @@ static void netfs_read_from_server(struct netfs_io_requ=
est *rreq,
>  				   struct netfs_io_subrequest *subreq)
>  {
>  	netfs_stat(&netfs_n_rh_download);
> -	if (iov_iter_count(&subreq->io_iter) !=3D subreq->len - subreq->transfe=
rred)
> +
> +	if (rreq->origin !=3D NETFS_DIO_READ &&
> +	    iov_iter_count(&subreq->io_iter) !=3D subreq->len - subreq->transfe=
rred)
>  		pr_warn("R=3D%08x[%u] ITER PRE-MISMATCH %zx !=3D %zx-%zx %lx\n",
>  			rreq->debug_id, subreq->debug_index,
>  			iov_iter_count(&subreq->io_iter), subreq->len,
> @@ -341,6 +343,43 @@ static void netfs_rreq_is_still_valid(struct netfs_i=
o_request *rreq)
>  	}
>  }
> =20
> +/*
> + * Determine how much we can admit to having read from a DIO read.
> + */
> +static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
> +{
> +	struct netfs_io_subrequest *subreq;
> +	unsigned int i;
> +	size_t transferred =3D 0;
> +
> +	for (i =3D 0; i < rreq->direct_bv_count; i++)
> +		flush_dcache_page(rreq->direct_bv[i].bv_page);
> +
> +	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
> +		if (subreq->error || subreq->transferred =3D=3D 0)
> +			break;
> +		transferred +=3D subreq->transferred;
> +		if (subreq->transferred < subreq->len)
> +			break;
> +	}
> +
> +	for (i =3D 0; i < rreq->direct_bv_count; i++)
> +		flush_dcache_page(rreq->direct_bv[i].bv_page);
> +
> +	rreq->transferred =3D transferred;
> +	task_io_account_read(transferred);
> +
> +	if (rreq->iocb) {
> +		rreq->iocb->ki_pos +=3D transferred;
> +		if (rreq->iocb->ki_complete)
> +			rreq->iocb->ki_complete(
> +				rreq->iocb, rreq->error ? rreq->error : transferred);
> +	}
> +	if (rreq->netfs_ops->done)
> +		rreq->netfs_ops->done(rreq);
> +	inode_dio_end(rreq->inode);
> +}
> +
>  /*
>   * Assess the state of a read request and decide what to do next.
>   *
> @@ -361,7 +400,10 @@ static void netfs_rreq_assess(struct netfs_io_reques=
t *rreq, bool was_async)
>  		return;
>  	}
> =20
> -	netfs_rreq_unlock_folios(rreq);
> +	if (rreq->origin !=3D NETFS_DIO_READ)
> +		netfs_rreq_unlock_folios(rreq);
> +	else
> +		netfs_rreq_assess_dio(rreq);
> =20
>  	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
>  	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> @@ -526,14 +568,16 @@ netfs_rreq_prepare_read(struct netfs_io_request *rr=
eq,
>  			struct netfs_io_subrequest *subreq,
>  			struct iov_iter *io_iter)
>  {
> -	enum netfs_io_source source;
> +	enum netfs_io_source source =3D NETFS_DOWNLOAD_FROM_SERVER;
>  	size_t lsize;
> =20
>  	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rr=
eq->i_size);
> =20
> -	source =3D netfs_cache_prepare_read(subreq, rreq->i_size);
> -	if (source =3D=3D NETFS_INVALID_READ)
> -		goto out;
> +	if (rreq->origin !=3D NETFS_DIO_READ) {
> +		source =3D netfs_cache_prepare_read(subreq, rreq->i_size);
> +		if (source =3D=3D NETFS_INVALID_READ)
> +			goto out;
> +	}
> =20
>  	if (source =3D=3D NETFS_DOWNLOAD_FROM_SERVER) {
>  		/* Call out to the netfs to let it shrink the request to fit
> @@ -544,6 +588,8 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq=
,
>  		 */
>  		if (subreq->len > rreq->i_size - subreq->start)
>  			subreq->len =3D rreq->i_size - subreq->start;
> +		if (rreq->rsize && subreq->len > rreq->rsize)
> +			subreq->len =3D rreq->rsize;
> =20
>  		if (rreq->netfs_ops->clamp_length &&
>  		    !rreq->netfs_ops->clamp_length(subreq)) {
> @@ -662,6 +708,9 @@ int netfs_begin_read(struct netfs_io_request *rreq, b=
ool sync)
>  		return -EIO;
>  	}
> =20
> +	if (rreq->origin =3D=3D NETFS_DIO_READ)
> +		inode_dio_begin(rreq->inode);
> +
>  	if (test_bit(NETFS_RREQ_USE_BOUNCE_BUFFER, &rreq->flags))
>  		iov_iter_xarray(&rreq->io_iter, ITER_DEST, &rreq->bounce,
>  				rreq->start, rreq->len);
> @@ -677,11 +726,25 @@ int netfs_begin_read(struct netfs_io_request *rreq,=
 bool sync)
>  	atomic_set(&rreq->nr_outstanding, 1);
>  	io_iter =3D rreq->io_iter;
>  	do {
> +		_debug("submit %llx + %zx >=3D %llx",
> +		       rreq->start, rreq->submitted, rreq->i_size);
> +		if (rreq->origin =3D=3D NETFS_DIO_READ &&
> +		    rreq->start + rreq->submitted >=3D rreq->i_size)
> +			break;
>  		if (!netfs_rreq_submit_slice(rreq, &io_iter, &debug_index))
>  			break;
> +		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
> +		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
> +			break;
> =20
>  	} while (rreq->submitted < rreq->len);
> =20
> +	if (!rreq->submitted) {
> +		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
> +		ret =3D 0;
> +		goto out;
> +	}
> +
>  	if (sync) {
>  		/* Keep nr_outstanding incremented so that the ref always
>  		 * belongs to us, and the service code isn't punted off to a
> @@ -698,7 +761,8 @@ int netfs_begin_read(struct netfs_io_request *rreq, b=
ool sync)
>  			    TASK_UNINTERRUPTIBLE);
> =20
>  		ret =3D rreq->error;
> -		if (ret =3D=3D 0 && rreq->submitted < rreq->len) {
> +		if (ret =3D=3D 0 && rreq->submitted < rreq->len &&
> +		    rreq->origin !=3D NETFS_DIO_READ) {
>  			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
>  			ret =3D -EIO;
>  		}
> @@ -706,7 +770,9 @@ int netfs_begin_read(struct netfs_io_request *rreq, b=
ool sync)
>  		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
>  		if (atomic_dec_and_test(&rreq->nr_outstanding))
>  			netfs_rreq_assess(rreq, false);
> -		ret =3D 0;
> +		ret =3D -EIOCBQUEUED;
>  	}
> +
> +out:
>  	return ret;
>  }
> diff --git a/fs/netfs/main.c b/fs/netfs/main.c
> index 6584eafda944..d4430b51b03c 100644
> --- a/fs/netfs/main.c
> +++ b/fs/netfs/main.c
> @@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] =
=3D {
>  	[NETFS_READPAGE]	=3D "RP",
>  	[NETFS_READ_FOR_WRITE]	=3D "RW",
>  	[NETFS_WRITEBACK]	=3D "WB",
> +	[NETFS_DIO_READ]	=3D "DR",
>  };
> =20
>  /*
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 3ce6313cc5f9..d46e957812a6 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -20,7 +20,8 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>  	struct inode *inode =3D file ? file_inode(file) : mapping->host;
>  	struct netfs_inode *ctx =3D netfs_inode(inode);
>  	struct netfs_io_request *rreq;
> -	bool cached =3D netfs_is_cache_enabled(ctx);
> +	bool is_dio =3D (origin =3D=3D NETFS_DIO_READ);
> +	bool cached =3D is_dio && netfs_is_cache_enabled(ctx);
>  	int ret;
> =20
>  	rreq =3D kzalloc(ctx->ops->io_request_size ?: sizeof(struct netfs_io_re=
quest),
> @@ -43,6 +44,8 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>  	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
>  	if (cached)
>  		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
> +	if (file && file->f_flags & O_NONBLOCK)
> +		__set_bit(NETFS_RREQ_NONBLOCK, &rreq->flags);
>  	if (rreq->netfs_ops->init_request) {
>  		ret =3D rreq->netfs_ops->init_request(rreq, file);
>  		if (ret < 0) {
> diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
> index c1f85cd595a4..15fd5c3f0f39 100644
> --- a/fs/netfs/stats.c
> +++ b/fs/netfs/stats.c
> @@ -9,6 +9,7 @@
>  #include <linux/seq_file.h>
>  #include "internal.h"
> =20
> +atomic_t netfs_n_rh_dio_read;
>  atomic_t netfs_n_rh_readahead;
>  atomic_t netfs_n_rh_readpage;
>  atomic_t netfs_n_rh_rreq;
> @@ -36,7 +37,8 @@ atomic_t netfs_n_wh_write_failed;
> =20
>  int netfs_stats_show(struct seq_file *m, void *v)
>  {
> -	seq_printf(m, "Netfs  : RA=3D%u RP=3D%u WB=3D%u WBZ=3D%u rr=3D%u sr=3D%=
u\n",
> +	seq_printf(m, "Netfs  : DR=3D%u RA=3D%u RP=3D%u WB=3D%u WBZ=3D%u rr=3D%=
u sr=3D%u\n",
> +		   atomic_read(&netfs_n_rh_dio_read),
>  		   atomic_read(&netfs_n_rh_readahead),
>  		   atomic_read(&netfs_n_rh_readpage),
>  		   atomic_read(&netfs_n_rh_write_begin),
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 63258998defb..da391f8c81c7 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -226,6 +226,7 @@ enum netfs_io_origin {
>  	NETFS_READPAGE,			/* This read is a synchronous read */
>  	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
>  	NETFS_WRITEBACK,		/* This write was triggered by writepages */
> +	NETFS_DIO_READ,			/* This is a direct I/O read */
>  	nr__netfs_io_origin
>  } __mode(byte);
> =20
> @@ -240,6 +241,7 @@ struct netfs_io_request {
>  	};
>  	struct inode		*inode;		/* The file being accessed */
>  	struct address_space	*mapping;	/* The mapping being accessed */
> +	struct kiocb		*iocb;		/* AIO completion vector */
>  	struct netfs_cache_resources cache_resources;
>  	struct list_head	proc_link;	/* Link in netfs_iorequests */
>  	struct list_head	subrequests;	/* Contributory I/O operations */
> @@ -251,12 +253,14 @@ struct netfs_io_request {
>  	__counted_by(direct_bv_count);
>  	unsigned int		direct_bv_count; /* Number of elements in direct_bv[] */
>  	unsigned int		debug_id;
> +	unsigned int		rsize;		/* Maximum read size (0 for none) */
>  	unsigned int		wsize;		/* Maximum write size (0 for none) */
>  	unsigned int		subreq_counter;	/* Next subreq->debug_index */
>  	atomic_t		nr_outstanding;	/* Number of ops in progress */
>  	atomic_t		nr_copy_ops;	/* Number of copy-to-cache ops in progress */
>  	size_t			submitted;	/* Amount submitted for I/O so far */
>  	size_t			len;		/* Length of the request */
> +	size_t			transferred;	/* Amount to be indicated as transferred */
>  	short			error;		/* 0 or error that occurred */
>  	enum netfs_io_origin	origin;		/* Origin of the request */
>  	bool			direct_bv_unpin; /* T if direct_bv[] must be unpinned */
> @@ -274,6 +278,8 @@ struct netfs_io_request {
>  #define NETFS_RREQ_USE_BOUNCE_BUFFER	6	/* Use bounce buffer */
>  #define NETFS_RREQ_WRITE_TO_CACHE	7	/* Need to write to the cache */
>  #define NETFS_RREQ_UPLOAD_TO_SERVER	8	/* Need to write to the server */
> +#define NETFS_RREQ_NONBLOCK		9	/* Don't block if possible (O_NONBLOCK) *=
/
> +#define NETFS_RREQ_BLOCKED		10	/* We blocked */
>  	const struct netfs_request_ops *netfs_ops;
>  	void (*cleanup)(struct netfs_io_request *req);
>  };
> @@ -370,6 +376,9 @@ struct netfs_cache_ops {
>  			       loff_t *_data_start, size_t *_data_len);
>  };
> =20
> +/* High-level read API. */
> +ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *=
iter);
> +
>  /* High-level write API */
>  ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
>  			    struct netfs_group *netfs_group);
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 082a5e717b58..5a4edadf0e59 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -16,6 +16,7 @@
>   * Define enums for tracing information.
>   */
>  #define netfs_read_traces					\
> +	EM(netfs_read_trace_dio_read,		"DIO-READ ")	\
>  	EM(netfs_read_trace_expanded,		"EXPANDED ")	\
>  	EM(netfs_read_trace_readahead,		"READAHEAD")	\
>  	EM(netfs_read_trace_readpage,		"READPAGE ")	\
> @@ -31,7 +32,8 @@
>  	EM(NETFS_READAHEAD,			"RA")		\
>  	EM(NETFS_READPAGE,			"RP")		\
>  	EM(NETFS_READ_FOR_WRITE,		"RW")		\
> -	E_(NETFS_WRITEBACK,			"WB")
> +	EM(NETFS_WRITEBACK,			"WB")		\
> +	E_(NETFS_DIO_READ,			"DR")
> =20
>  #define netfs_rreq_traces					\
>  	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
> @@ -70,6 +72,8 @@
>  #define netfs_failures							\
>  	EM(netfs_fail_check_write_begin,	"check-write-begin")	\
>  	EM(netfs_fail_copy_to_cache,		"copy-to-cache")	\
> +	EM(netfs_fail_dio_read_short,		"dio-read-short")	\
> +	EM(netfs_fail_dio_read_zero,		"dio-read-zero")	\
>  	EM(netfs_fail_read,			"read")			\
>  	EM(netfs_fail_short_read,		"short-read")		\
>  	EM(netfs_fail_prepare_write,		"prep-write")		\
> @@ -81,6 +85,7 @@
>  	EM(netfs_rreq_trace_put_complete,	"PUT COMPLT ")	\
>  	EM(netfs_rreq_trace_put_discard,	"PUT DISCARD")	\
>  	EM(netfs_rreq_trace_put_failed,		"PUT FAILED ")	\
> +	EM(netfs_rreq_trace_put_no_submit,	"PUT NO-SUBM")	\
>  	EM(netfs_rreq_trace_put_return,		"PUT RETURN ")	\
>  	EM(netfs_rreq_trace_put_subreq,		"PUT SUBREQ ")	\
>  	EM(netfs_rreq_trace_put_work,		"PUT WORK   ")	\
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c0d7e1d7eea2..85a8eb23cfd2 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2678,6 +2678,7 @@ int kiocb_write_and_wait(struct kiocb *iocb, size_t=
 count)
> =20
>  	return filemap_write_and_wait_range(mapping, pos, end);
>  }
> +EXPORT_SYMBOL_GPL(kiocb_write_and_wait);
> =20
>  int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
>  {
>=20

--=20
Jeff Layton <jlayton@kernel.org>

