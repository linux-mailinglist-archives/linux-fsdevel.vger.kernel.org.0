Return-Path: <linux-fsdevel+bounces-6074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFE81321D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 14:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434311F222F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1E57898;
	Thu, 14 Dec 2023 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbYUwZpz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61AE56B7D;
	Thu, 14 Dec 2023 13:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99E7C433C8;
	Thu, 14 Dec 2023 13:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702561770;
	bh=zmJFQFRT3Ce/ZycciWKkUVry0rBAoAVSLjXBGo/8jM0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WbYUwZpzJDoG/48JP0w0SLSFeRfi1MDmMYAVm3jTsMeE2PnJT3CRJx8BeBJcoX8JP
	 pm8sfgJ6+dEdvAezZXj/HKG7N7iUQK0yJ5IKxcR6fvIYub35L3DBJRwIMgq4FG6zbF
	 rWSND/Wd0aEXnTt7WuwyEdQ/EoUeRJhrg0u/b5ClI2o43CW6nzwccsb8qrPx2fBX/U
	 v+5HXigcuoAlBziUBQ2Uq1PFRPEDsxPNrWB8rbCg05iwZFO0y15URLNHI8lF/dUkLC
	 5BG7jpoMOAdyPKtIm+fnC+pc2USRKVcKSpaK1HTBjafh4s9Vjm2tlNEEkPYy/ggQst
	 0VH83S8m9iarQ==
Message-ID: <d1d4f3996f55cb98ab6297844a51bc905e2ce631.camel@kernel.org>
Subject: Re: [PATCH v4 36/39] netfs: Implement a write-through caching option
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
Date: Thu, 14 Dec 2023 08:49:27 -0500
In-Reply-To: <20231213152350.431591-37-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
	 <20231213152350.431591-37-dhowells@redhat.com>
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
> Provide a flag whereby a filesystem may request that cifs_perform_write()
> perform write-through caching.  This involves putting pages directly into
> writeback rather than dirty and attaching them to a write operation as we
> go.
>=20
> Further, the writes being made are limited to the byte range being writte=
n
> rather than whole folios being written.  This can be used by cifs, for
> example, to deal with strict byte-range locking.
>=20

This is pretty cool. I wonder if that will help cifs pass more locking
tests?

> This can't be used with content encryption as that may require expansion =
of
> the write RPC beyond the write being made.
>=20
> This doesn't affect writes via mmap - those are written back in the norma=
l
> way; similarly failed writethrough writes are marked dirty and left to
> writeback to retry.  Another option would be to simply invalidate them, b=
ut
> the contents can be simultaneously accessed by read() and through mmap.
>=20

I do wish Linux were less of a mess in this regard. Different
filesystems behave differently when writeback fails.

That said, the modern consensus with local filesystems is to just leave
the pages clean when buffered writeback fails, but set a writeback error
on the inode. That at least keeps dirty pages from stacking up in the
cache. In the case of something like a netfs, we usually invalidate the
inode and the pages -- netfs's usually have to spontaneously deal with
that anyway, so we might as well.

Marking the pages dirty here should mean that they'll effectively get a
second try at writeback, which is a change in behavior from most
filesystems. I'm not sure it's a bad one, but writeback can take a long
time if you have a laggy network.

When a write has already failed once, why do you think it'll succeed on
a second attempt (and probably with page-aligned I/O, I guess)?

Another question: when the writeback is (re)attempted, will it end up
just doing page-aligned I/O, or is the byte range still going to be
limited to the written range?

The more I consider it, I think it might be a lot simpler to just "fail
fast" here rather than remarking the write dirty.

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/buffered_write.c    | 69 +++++++++++++++++++++++----
>  fs/netfs/internal.h          |  3 ++
>  fs/netfs/main.c              |  1 +
>  fs/netfs/objects.c           |  1 +
>  fs/netfs/output.c            | 90 ++++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h        |  2 +
>  include/trace/events/netfs.h |  8 +++-
>  7 files changed, 162 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 8e0ebb7175a4..dce6995fb644 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -26,6 +26,8 @@ enum netfs_how_to_modify {
>  	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
>  };
> =20
> +static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq);
> +
>  static void netfs_set_group(struct folio *folio, struct netfs_group *net=
fs_group)
>  {
>  	if (netfs_group && !folio_get_private(folio))
> @@ -133,6 +135,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, stru=
ct iov_iter *iter,
>  	struct inode *inode =3D file_inode(file);
>  	struct address_space *mapping =3D inode->i_mapping;
>  	struct netfs_inode *ctx =3D netfs_inode(inode);
> +	struct writeback_control wbc =3D {
> +		.sync_mode	=3D WB_SYNC_NONE,
> +		.for_sync	=3D true,
> +		.nr_to_write	=3D LONG_MAX,
> +		.range_start	=3D iocb->ki_pos,
> +		.range_end	=3D iocb->ki_pos + iter->count,
> +	};
> +	struct netfs_io_request *wreq =3D NULL;
>  	struct netfs_folio *finfo;
>  	struct folio *folio;
>  	enum netfs_how_to_modify howto;
> @@ -143,6 +153,30 @@ ssize_t netfs_perform_write(struct kiocb *iocb, stru=
ct iov_iter *iter,
>  	size_t max_chunk =3D PAGE_SIZE << MAX_PAGECACHE_ORDER;
>  	bool maybe_trouble =3D false;
> =20
> +	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
> +		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
> +	    ) {
> +		if (pos < i_size_read(inode)) {
> +			ret =3D filemap_write_and_wait_range(mapping, pos, pos + iter->count)=
;
> +			if (ret < 0) {
> +				goto out;
> +			}
> +		}
> +
> +		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
> +
> +		wreq =3D netfs_begin_writethrough(iocb, iter->count);
> +		if (IS_ERR(wreq)) {
> +			wbc_detach_inode(&wbc);
> +			ret =3D PTR_ERR(wreq);
> +			wreq =3D NULL;
> +			goto out;
> +		}
> +		if (!is_sync_kiocb(iocb))
> +			wreq->iocb =3D iocb;
> +		wreq->cleanup =3D netfs_cleanup_buffered_write;
> +	}
> +
>  	do {
>  		size_t flen;
>  		size_t offset;	/* Offset into pagecache folio */
> @@ -315,7 +349,25 @@ ssize_t netfs_perform_write(struct kiocb *iocb, stru=
ct iov_iter *iter,
>  		}
>  		written +=3D copied;
> =20
> -		folio_mark_dirty(folio);
> +		if (likely(!wreq)) {
> +			folio_mark_dirty(folio);
> +		} else {
> +			if (folio_test_dirty(folio))
> +				/* Sigh.  mmap. */
> +				folio_clear_dirty_for_io(folio);
> +			/* We make multiple writes to the folio... */
> +			if (!folio_test_writeback(folio)) {
> +				folio_wait_fscache(folio);
> +				folio_start_writeback(folio);
> +				folio_start_fscache(folio);
> +				if (wreq->iter.count =3D=3D 0)
> +					trace_netfs_folio(folio, netfs_folio_trace_wthru);
> +				else
> +					trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
> +			}
> +			netfs_advance_writethrough(wreq, copied,
> +						   offset + copied =3D=3D flen);
> +		}
>  	retry:
>  		folio_unlock(folio);
>  		folio_put(folio);
> @@ -325,17 +377,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, str=
uct iov_iter *iter,
>  	} while (iov_iter_count(iter));
> =20
>  out:
> -	if (likely(written)) {
> -		/* Flush and wait for a write that requires immediate synchronisation.=
 */
> -		if (iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) {
> -			_debug("dsync");
> -			ret =3D filemap_fdatawait_range(mapping, iocb->ki_pos,
> -						      iocb->ki_pos + written);
> -		}
> -
> -		iocb->ki_pos +=3D written;
> +	if (unlikely(wreq)) {
> +		ret =3D netfs_end_writethrough(wreq, iocb);
> +		wbc_detach_inode(&wbc);
> +		if (ret =3D=3D -EIOCBQUEUED)
> +			return ret;
>  	}
> =20
> +	iocb->ki_pos +=3D written;
>  	_leave(" =3D %zd [%zd]", written, ret);
>  	return written ? written : ret;
> =20
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index fe72280b0f30..b3749d6ec1ff 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -101,6 +101,9 @@ static inline void netfs_see_request(struct netfs_io_=
request *rreq,
>   */
>  int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
>  		      enum netfs_write_trace what);
> +struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, si=
ze_t len);
> +int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t cop=
ied, bool to_page_end);
> +int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *=
iocb);
> =20
>  /*
>   * stats.c
> diff --git a/fs/netfs/main.c b/fs/netfs/main.c
> index 8d5ee0f56f28..7139397931b7 100644
> --- a/fs/netfs/main.c
> +++ b/fs/netfs/main.c
> @@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] =
=3D {
>  	[NETFS_READPAGE]		=3D "RP",
>  	[NETFS_READ_FOR_WRITE]		=3D "RW",
>  	[NETFS_WRITEBACK]		=3D "WB",
> +	[NETFS_WRITETHROUGH]		=3D "WT",
>  	[NETFS_LAUNDER_WRITE]		=3D "LW",
>  	[NETFS_UNBUFFERED_WRITE]	=3D "UW",
>  	[NETFS_DIO_READ]		=3D "DR",
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index 16252cc4576e..37626328577e 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -42,6 +42,7 @@ struct netfs_io_request *netfs_alloc_request(struct add=
ress_space *mapping,
>  	rreq->debug_id	=3D atomic_inc_return(&debug_ids);
>  	xa_init(&rreq->bounce);
>  	INIT_LIST_HEAD(&rreq->subrequests);
> +	INIT_WORK(&rreq->work, NULL);
>  	refcount_set(&rreq->ref, 1);
> =20
>  	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> diff --git a/fs/netfs/output.c b/fs/netfs/output.c
> index cc9065733b42..625eb68f3e5a 100644
> --- a/fs/netfs/output.c
> +++ b/fs/netfs/output.c
> @@ -386,3 +386,93 @@ int netfs_begin_write(struct netfs_io_request *wreq,=
 bool may_wait,
>  		    TASK_UNINTERRUPTIBLE);
>  	return wreq->error;
>  }
> +
> +/*
> + * Begin a write operation for writing through the pagecache.
> + */
> +struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, si=
ze_t len)
> +{
> +	struct netfs_io_request *wreq;
> +	struct file *file =3D iocb->ki_filp;
> +
> +	wreq =3D netfs_alloc_request(file->f_mapping, file, iocb->ki_pos, len,
> +				   NETFS_WRITETHROUGH);
> +	if (IS_ERR(wreq))
> +		return wreq;
> +
> +	trace_netfs_write(wreq, netfs_write_trace_writethrough);
> +
> +	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
> +	iov_iter_xarray(&wreq->iter, ITER_SOURCE, &wreq->mapping->i_pages, wreq=
->start, 0);
> +	wreq->io_iter =3D wreq->iter;
> +
> +	/* ->outstanding > 0 carries a ref */
> +	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
> +	atomic_set(&wreq->nr_outstanding, 1);
> +	return wreq;
> +}
> +
> +static void netfs_submit_writethrough(struct netfs_io_request *wreq, boo=
l final)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
> +	unsigned long long start;
> +	size_t len;
> +
> +	if (!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
> +		return;
> +
> +	start =3D wreq->start + wreq->submitted;
> +	len =3D wreq->iter.count - wreq->submitted;
> +	if (!final) {
> +		len /=3D wreq->wsize; /* Round to number of maximum packets */
> +		len *=3D wreq->wsize;
> +	}
> +
> +	ictx->ops->create_write_requests(wreq, start, len);
> +	wreq->submitted +=3D len;
> +}
> +
> +/*
> + * Advance the state of the write operation used when writing through th=
e
> + * pagecache.  Data has been copied into the pagecache that we need to a=
ppend
> + * to the request.  If we've added more than wsize then we need to creat=
e a new
> + * subrequest.
> + */
> +int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t cop=
ied, bool to_page_end)
> +{
> +	_enter("ic=3D%zu sb=3D%zu ws=3D%u cp=3D%zu tp=3D%u",
> +	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_=
end);
> +
> +	wreq->iter.count +=3D copied;
> +	wreq->io_iter.count +=3D copied;
> +	if (to_page_end && wreq->io_iter.count - wreq->submitted >=3D wreq->wsi=
ze)
> +		netfs_submit_writethrough(wreq, false);
> +
> +	return wreq->error;
> +}
> +
> +/*
> + * End a write operation used when writing through the pagecache.
> + */
> +int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *=
iocb)
> +{
> +	int ret =3D -EIOCBQUEUED;
> +
> +	_enter("ic=3D%zu sb=3D%zu ws=3D%u",
> +	       wreq->iter.count, wreq->submitted, wreq->wsize);
> +
> +	if (wreq->submitted < wreq->io_iter.count)
> +		netfs_submit_writethrough(wreq, true);
> +
> +	if (atomic_dec_and_test(&wreq->nr_outstanding))
> +		netfs_write_terminated(wreq, false);
> +
> +	if (is_sync_kiocb(iocb)) {
> +		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
> +			    TASK_UNINTERRUPTIBLE);
> +		ret =3D wreq->error;
> +	}
> +
> +	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
> +	return ret;
> +}
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index a7c2cb856e81..fc77f7be220a 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -139,6 +139,7 @@ struct netfs_inode {
>  	unsigned long		flags;
>  #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
>  #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
> +#define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
>  };
> =20
>  /*
> @@ -227,6 +228,7 @@ enum netfs_io_origin {
>  	NETFS_READPAGE,			/* This read is a synchronous read */
>  	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
>  	NETFS_WRITEBACK,		/* This write was triggered by writepages */
> +	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
>  	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
>  	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
>  	NETFS_DIO_READ,			/* This is a direct I/O read */
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index cc998798e20a..447a8c21cf57 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -27,13 +27,15 @@
>  	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
>  	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
>  	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
> -	E_(netfs_write_trace_writeback,		"WRITEBACK")
> +	EM(netfs_write_trace_writeback,		"WRITEBACK")	\
> +	E_(netfs_write_trace_writethrough,	"WRITETHRU")
> =20
>  #define netfs_rreq_origins					\
>  	EM(NETFS_READAHEAD,			"RA")		\
>  	EM(NETFS_READPAGE,			"RP")		\
>  	EM(NETFS_READ_FOR_WRITE,		"RW")		\
>  	EM(NETFS_WRITEBACK,			"WB")		\
> +	EM(NETFS_WRITETHROUGH,			"WT")		\
>  	EM(NETFS_LAUNDER_WRITE,			"LW")		\
>  	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
>  	EM(NETFS_DIO_READ,			"DR")		\
> @@ -136,7 +138,9 @@
>  	EM(netfs_folio_trace_redirty,		"redirty")	\
>  	EM(netfs_folio_trace_redirtied,		"redirtied")	\
>  	EM(netfs_folio_trace_store,		"store")	\
> -	E_(netfs_folio_trace_store_plus,	"store+")
> +	EM(netfs_folio_trace_store_plus,	"store+")	\
> +	EM(netfs_folio_trace_wthru,		"wthru")	\
> +	E_(netfs_folio_trace_wthru_plus,	"wthru+")
> =20
>  #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
>  #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
>=20

--=20
Jeff Layton <jlayton@kernel.org>

