Return-Path: <linux-fsdevel+bounces-660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41827CE0A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B30281D00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA2B37CB2;
	Wed, 18 Oct 2023 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn2cvizO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C831A86;
	Wed, 18 Oct 2023 15:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E9C433C8;
	Wed, 18 Oct 2023 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697641393;
	bh=L6D+qpbBdCzUDrl/li04wVioUZCLruBmB/YXF1xf4Bs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Gn2cvizOXkUy01k71YGxTE7X4z6vLqaoJLFafo+1V2D8V7Wv88ZBfmZ6d50ZFxvKj
	 r0STRxGjErKUq13H3Iv7mn7AvIVCLxpKl0n0AqJx/zBkuo7ZkXLhcheBVnAbwngAJy
	 S2skRkZqL4VlJYnoY86FUfOK7xrHRmF0ZzWNiFTOC5AyErC5YFeuU702fAYEtK/kQ0
	 aIQ4dUnbHPpyCEC4k4S/zZbe8fb2opZ517pamFcrGwYG5OKsJ8cUyxGf+7h0XtSe7s
	 mTD2R7Bi85VJqLSadyBjO5Aq+0cQCsfNSkx/qUgSy3TUsIJ33tfm5uq6iku67rtVOB
	 05ypzoiMkKRgg==
Message-ID: <9d2fc137b4295058ac3f88f1cca7a54bc67f01fd.camel@kernel.org>
Subject: Re: [RFC PATCH 12/53] netfs: Provide tools to create a buffer in an
 xarray
From: Jeff Layton <jlayton@kernel.org>
To: David Howells <dhowells@redhat.com>, Steve French <smfrench@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Marc Dionne
 <marc.dionne@auristor.com>,  Paulo Alcantara <pc@manguebit.com>, Shyam
 Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Dominique
 Martinet <asmadeus@codewreck.org>, Ilya Dryomov <idryomov@gmail.com>,
 Christian Brauner <christian@brauner.io>,  linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org,  linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Date: Wed, 18 Oct 2023 11:03:10 -0400
In-Reply-To: <20231013160423.2218093-13-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
	 <20231013160423.2218093-13-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-10-13 at 17:03 +0100, David Howells wrote:
> Provide tools to create a buffer in an xarray, with a function to add
> new folios with a mark.  This will be used to create bounce buffer and ca=
n be
> used more easily to create a list of folios the span of which would requi=
re
> more than a page's worth of bio_vec structs.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/internal.h   |  16 +++++
>  fs/netfs/misc.c       | 140 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h |   4 ++
>  3 files changed, 160 insertions(+)
>=20
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 1f067aa96c50..00e01278316f 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -52,6 +52,22 @@ static inline void netfs_proc_add_rreq(struct netfs_io=
_request *rreq) {}
>  static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
>  #endif
> =20
> +/*
> + * misc.c
> + */
> +int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
> +			    struct folio *folio, bool put_mark,
> +			    bool pagecache_mark, gfp_t gfp_mask);
> +int netfs_add_folios_to_buffer(struct xarray *buffer,
> +			       struct address_space *mapping,
> +			       pgoff_t index, pgoff_t to, gfp_t gfp_mask);
> +int netfs_set_up_buffer(struct xarray *buffer,
> +			struct address_space *mapping,
> +			struct readahead_control *ractl,
> +			struct folio *keep,
> +			pgoff_t have_index, unsigned int have_folios);
> +void netfs_clear_buffer(struct xarray *buffer);
> +
>  /*
>   * objects.c
>   */
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index c3baf2b247d9..c70f856f3129 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -8,6 +8,146 @@
>  #include <linux/swap.h>
>  #include "internal.h"
> =20
> +/*
> + * Attach a folio to the buffer and maybe set marks on it to say that we=
 need
> + * to put the folio later and twiddle the pagecache flags.
> + */
> +int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
> +			    struct folio *folio, bool put_mark,
> +			    bool pagecache_mark, gfp_t gfp_mask)
> +{
> +	XA_STATE_ORDER(xas, xa, index, folio_order(folio));
> +
> +retry:
> +	xas_lock(&xas);
> +	for (;;) {
> +		xas_store(&xas, folio);
> +		if (!xas_error(&xas))
> +			break;
> +		xas_unlock(&xas);
> +		if (!xas_nomem(&xas, gfp_mask))
> +			return xas_error(&xas);
> +		goto retry;
> +	}
> +
> +	if (put_mark)
> +		xas_set_mark(&xas, NETFS_BUF_PUT_MARK);
> +	if (pagecache_mark)
> +		xas_set_mark(&xas, NETFS_BUF_PAGECACHE_MARK);
> +	xas_unlock(&xas);
> +	return xas_error(&xas);
> +}
> +
> +/*
> + * Create the specified range of folios in the buffer attached to the re=
ad
> + * request.  The folios are marked with NETFS_BUF_PUT_MARK so that we kn=
ow that
> + * these need freeing later.
> + */

Some kerneldoc comments on these new helpers would be nice. I assume
that "index" and "to" are "start" and "end" for this, but it'd be nice
to make that explicit.


> +int netfs_add_folios_to_buffer(struct xarray *buffer,
> +			       struct address_space *mapping,
> +			       pgoff_t index, pgoff_t to, gfp_t gfp_mask)
> +{
> +	struct folio *folio;
> +	int ret;
> +
> +	if (to + 1 =3D=3D index) /* Page range is inclusive */
> +		return 0;
> +
> +	do {
> +		/* TODO: Figure out what order folio can be allocated here */
> +		folio =3D filemap_alloc_folio(readahead_gfp_mask(mapping), 0);
> +		if (!folio)
> +			return -ENOMEM;
> +		folio->index =3D index;
> +		ret =3D netfs_xa_store_and_mark(buffer, index, folio,
> +					      true, false, gfp_mask);
> +		if (ret < 0) {
> +			folio_put(folio);
> +			return ret;
> +		}
> +
> +		index +=3D folio_nr_pages(folio);
> +	} while (index <=3D to && index !=3D 0);
> +
> +	return 0;
> +}
> +
> +/*
> + * Set up a buffer into which to data will be read or decrypted/decompre=
ssed.
> + * The folios to be read into are attached to this buffer and the gaps f=
illed
> + * in to form a continuous region.
> + */
> +int netfs_set_up_buffer(struct xarray *buffer,
> +			struct address_space *mapping,
> +			struct readahead_control *ractl,
> +			struct folio *keep,
> +			pgoff_t have_index, unsigned int have_folios)
> +{
> +	struct folio *folio;
> +	gfp_t gfp_mask =3D readahead_gfp_mask(mapping);
> +	unsigned int want_folios =3D have_folios;
> +	pgoff_t want_index =3D have_index;
> +	int ret;
> +
> +	ret =3D netfs_add_folios_to_buffer(buffer, mapping, want_index,
> +					 have_index - 1, gfp_mask);
> +	if (ret < 0)
> +		return ret;
> +	have_folios +=3D have_index - want_index;
> +
> +	ret =3D netfs_add_folios_to_buffer(buffer, mapping,
> +					 have_index + have_folios,
> +					 want_index + want_folios - 1,
> +					 gfp_mask);

I don't get it. Why are you calling netfs_add_folios_to_buffer twice
here? Why not just make one call? Either way, a comment here explaining
that would also be nice.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Transfer the folios proposed by the VM into the buffer and take refs
> +	 * on them.  The locks will be dropped in netfs_rreq_unlock().
> +	 */
> +	if (ractl) {
> +		while ((folio =3D readahead_folio(ractl))) {
> +			folio_get(folio);
> +			if (folio =3D=3D keep)
> +				folio_get(folio);
> +			ret =3D netfs_xa_store_and_mark(buffer, folio->index, folio,
> +						      true, true, gfp_mask);
> +			if (ret < 0) {
> +				if (folio !=3D keep)
> +					folio_unlock(folio);
> +				folio_put(folio);
> +				return ret;
> +			}
> +		}
> +	} else {
> +		folio_get(keep);
> +		ret =3D netfs_xa_store_and_mark(buffer, keep->index, keep,
> +					      true, true, gfp_mask);
> +		if (ret < 0) {
> +			folio_put(keep);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Clear an xarray buffer, putting a ref on the folios that have
> + * NETFS_BUF_PUT_MARK set.
> + */
> +void netfs_clear_buffer(struct xarray *buffer)
> +{
> +	struct folio *folio;
> +	XA_STATE(xas, buffer, 0);
> +
> +	rcu_read_lock();
> +	xas_for_each_marked(&xas, folio, ULONG_MAX, NETFS_BUF_PUT_MARK) {
> +		folio_put(folio);
> +	}
> +	rcu_read_unlock();
> +	xa_destroy(buffer);
> +}
> +
>  /**
>   * netfs_invalidate_folio - Invalidate or partially invalidate a folio
>   * @folio: Folio proposed for release
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 66479a61ad00..e8d702ac6968 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -109,6 +109,10 @@ static inline int wait_on_page_fscache_killable(stru=
ct page *page)
>  	return folio_wait_private_2_killable(page_folio(page));
>  }
> =20
> +/* Marks used on xarray-based buffers */
> +#define NETFS_BUF_PUT_MARK	XA_MARK_0	/* - Page needs putting  */
> +#define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag=
 wrangling */
> +
>  enum netfs_io_source {
>  	NETFS_FILL_WITH_ZEROES,
>  	NETFS_DOWNLOAD_FROM_SERVER,
>=20

--=20
Jeff Layton <jlayton@kernel.org>

