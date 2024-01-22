Return-Path: <linux-fsdevel+bounces-8452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E5836C4B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236821F269FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B85FF0C;
	Mon, 22 Jan 2024 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLdP1dRa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BC3D984;
	Mon, 22 Jan 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937941; cv=none; b=brd3ALTFwqTgey8aCffEdh20m7qizqGFo12b9jkATQO4qegt/rN4b///oIvNhCo595vWoTCG111+NWbDXQVbt+BQN6G8RmkYNCHLIb4bV4HbPIjQ1fIa9+heRHCuOtSHGLQVDLmHwytEliHqtZi7i8sfF7nwlsgNbP0t9+rm4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937941; c=relaxed/simple;
	bh=oaCbQBTCYx6bHXBvnqEWZsS9lXl+GWX2DYm5Eu7VA20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3QJVfpLAH02ZNLz1DW8sdaueQkSvaLJuK3MhduM397fLLYDeFlWKlr/CC36TGDayBVhlsAo4OlnrQKwa6A2HJj8Wsg9mlRvtGXRRFvnyco3HCJCKQsXJMYVdJTfM8TPAFPoJVV9KblmGksyUqvYv3G96EcSOgWYh8uFwWzUQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLdP1dRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77476C433F1;
	Mon, 22 Jan 2024 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937940;
	bh=oaCbQBTCYx6bHXBvnqEWZsS9lXl+GWX2DYm5Eu7VA20=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eLdP1dRahnbX0mHTSXaovN/RWa3a+o7oxMCN12L+51rCxtbaOHRv8yT43j4KVYu6A
	 cJYZFbl4S7q9iPsfKAvWuCmE+lVUq6Fo6Vg8AI2U79fCW7SfztXac/F4LZC+dh3kt5
	 VAANezOXn4IxOttaKkCBItBhC+wp85fZu/qghdRPyE13/+pE7n4zlt4VYURvsh72k6
	 as4xlneLC1JvSmEBsuRG5MKFVOmPrqqOQWNKvu0bwaJidc9A1vj1aAlgrxWJcaunKK
	 9UphMLstLscs9ofGLS7THuTNgeOREwpyGUVEQh4FCQ1sJKchprMHOxORTqAKoitgG0
	 uhUNi0XauLBiQ==
Message-ID: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
Subject: Re: [PATCH 01/10] netfs: Don't use certain internal folio_*()
 functions
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
	 <christian@brauner.io>
Cc: Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, 
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev,  linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Date: Mon, 22 Jan 2024 10:38:58 -0500
In-Reply-To: <20240122123845.3822570-2-dhowells@redhat.com>
References: <20240122123845.3822570-1-dhowells@redhat.com>
	 <20240122123845.3822570-2-dhowells@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-22 at 12:38 +0000, David Howells wrote:
> Filesystems should not be using folio->index not folio_index(folio) and

I think you mean "should be" here.

> folio->mapping, not folio_mapping() or folio_file_mapping() in filesystem
> code.
>=20
> Change this automagically with:
>=20
> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/netfs/*.c
> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/netfs/=
*.c
> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/netfs/*.c
>=20
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: linux-cachefs@redhat.com
> cc: linux-cifs@vger.kernel.org
> cc: linux-erofs@lists.ozlabs.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/buffered_read.c  | 12 ++++++------
>  fs/netfs/buffered_write.c | 10 +++++-----
>  fs/netfs/io.c             |  2 +-
>  fs/netfs/misc.c           |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index a59e7b2edaac..3298c29b5548 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -101,7 +101,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request=
 *rreq)
>  		}
> =20
>  		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
> -			if (folio_index(folio) =3D=3D rreq->no_unlock_folio &&
> +			if (folio->index =3D=3D rreq->no_unlock_folio &&
>  			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
>  				_debug("no unlock");
>  			else
> @@ -246,13 +246,13 @@ EXPORT_SYMBOL(netfs_readahead);
>   */
>  int netfs_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct address_space *mapping =3D folio_file_mapping(folio);
> +	struct address_space *mapping =3D folio->mapping;
>  	struct netfs_io_request *rreq;
>  	struct netfs_inode *ctx =3D netfs_inode(mapping->host);
>  	struct folio *sink =3D NULL;
>  	int ret;
> =20
> -	_enter("%lx", folio_index(folio));
> +	_enter("%lx", folio->index);
> =20
>  	rreq =3D netfs_alloc_request(mapping, file,
>  				   folio_file_pos(folio), folio_size(folio),
> @@ -460,7 +460,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  		ret =3D PTR_ERR(rreq);
>  		goto error;
>  	}
> -	rreq->no_unlock_folio	=3D folio_index(folio);
> +	rreq->no_unlock_folio	=3D folio->index;
>  	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
> =20
>  	ret =3D netfs_begin_cache_read(rreq, ctx);
> @@ -518,7 +518,7 @@ int netfs_prefetch_for_write(struct file *file, struc=
t folio *folio,
>  			     size_t offset, size_t len)
>  {
>  	struct netfs_io_request *rreq;
> -	struct address_space *mapping =3D folio_file_mapping(folio);
> +	struct address_space *mapping =3D folio->mapping;
>  	struct netfs_inode *ctx =3D netfs_inode(mapping->host);
>  	unsigned long long start =3D folio_pos(folio);
>  	size_t flen =3D folio_size(folio);
> @@ -535,7 +535,7 @@ int netfs_prefetch_for_write(struct file *file, struc=
t folio *folio,
>  		goto error;
>  	}
> =20
> -	rreq->no_unlock_folio =3D folio_index(folio);
> +	rreq->no_unlock_folio =3D folio->index;
>  	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
>  	ret =3D netfs_begin_cache_read(rreq, ctx);
>  	if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)
> diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
> index 93dc76f34e39..e7f9ba6fb16b 100644
> --- a/fs/netfs/buffered_write.c
> +++ b/fs/netfs/buffered_write.c
> @@ -343,7 +343,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struc=
t iov_iter *iter,
>  			break;
>  		default:
>  			WARN(true, "Unexpected modify type %u ix=3D%lx\n",
> -			     howto, folio_index(folio));
> +			     howto, folio->index);
>  			ret =3D -EIO;
>  			goto error_folio_unlock;
>  		}
> @@ -648,7 +648,7 @@ static void netfs_pages_written_back(struct netfs_io_=
request *wreq)
>  	xas_for_each(&xas, folio, last) {
>  		WARN(!folio_test_writeback(folio),
>  		     "bad %zx @%llx page %lx %lx\n",
> -		     wreq->len, wreq->start, folio_index(folio), last);
> +		     wreq->len, wreq->start, folio->index, last);
> =20
>  		if ((finfo =3D netfs_folio_info(folio))) {
>  			/* Streaming writes cannot be redirtied whilst under
> @@ -795,7 +795,7 @@ static void netfs_extend_writeback(struct address_spa=
ce *mapping,
>  				continue;
>  			if (xa_is_value(folio))
>  				break;
> -			if (folio_index(folio) !=3D index) {
> +			if (folio->index !=3D index) {
>  				xas_reset(xas);
>  				break;
>  			}
> @@ -901,7 +901,7 @@ static ssize_t netfs_write_back_from_locked_folio(str=
uct address_space *mapping,
>  	long count =3D wbc->nr_to_write;
>  	int ret;
> =20
> -	_enter(",%lx,%llx-%llx,%u", folio_index(folio), start, end, caching);
> +	_enter(",%lx,%llx-%llx,%u", folio->index, start, end, caching);
> =20
>  	wreq =3D netfs_alloc_request(mapping, NULL, start, folio_size(folio),
>  				   NETFS_WRITEBACK);
> @@ -1047,7 +1047,7 @@ static ssize_t netfs_writepages_begin(struct addres=
s_space *mapping,
> =20
>  	start =3D folio_pos(folio); /* May regress with THPs */
> =20
> -	_debug("wback %lx", folio_index(folio));
> +	_debug("wback %lx", folio->index);
> =20
>  	/* At this point we hold neither the i_pages lock nor the page lock:
>  	 * the page may be truncated or invalidated (changing page->mapping to
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index 4309edf33862..e8ff1e61ce79 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -124,7 +124,7 @@ static void netfs_rreq_unmark_after_write(struct netf=
s_io_request *rreq,
>  			/* We might have multiple writes from the same huge
>  			 * folio, but we mustn't unlock a folio more than once.
>  			 */
> -			if (have_unlocked && folio_index(folio) <=3D unlocked)
> +			if (have_unlocked && folio->index <=3D unlocked)
>  				continue;
>  			unlocked =3D folio_next_index(folio) - 1;
>  			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 0e3af37fc924..90051ced8e2a 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -180,7 +180,7 @@ void netfs_invalidate_folio(struct folio *folio, size=
_t offset, size_t length)
>  	struct netfs_folio *finfo =3D NULL;
>  	size_t flen =3D folio_size(folio);
> =20
> -	_enter("{%lx},%zx,%zx", folio_index(folio), offset, length);
> +	_enter("{%lx},%zx,%zx", folio->index, offset, length);
> =20
>  	folio_wait_fscache(folio);
> =20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

