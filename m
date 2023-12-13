Return-Path: <linux-fsdevel+bounces-5981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA098119A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6251C20E8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AEF36AFB;
	Wed, 13 Dec 2023 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8SqnJSP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DA1EB40;
	Wed, 13 Dec 2023 16:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E38C433C8;
	Wed, 13 Dec 2023 16:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485432;
	bh=V32SSwQkFcdJtQ1OoYuVyd25z6w9bcMt4t9UsGwYsP4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D8SqnJSPhj6SbuAenL02YENotJTjraF6N0zvWRTqrkE4whmfCzWlDCdZ+087BcH1/
	 3iEfCs0VdZZdXgE2ozF9oD1UIFVW1z+8aEK3PH3Vj6iG7g/A2oss2Kb8X76ebqD226
	 dpUllSglbfP1OmQhnPgntX+FhwyLjaNZAch4wzTY+z46hdXlCV9nSQJ47VcD0QoUHt
	 mbj1URgcPE6nSyewhFcam14wX9uD96jkEfLVSzybnE1v6I2caJFDXCvsoSLL2Wkm1/
	 EgeLcAcIT8POwUa0J2yQlqEk5fAkzi3dXccsFVF/5NYO/ub919+aYf5E9HttPx93Eb
	 fHkXzp+nOdXEw==
Message-ID: <367107fa03540f7ddd2e8de51c751348bd7eb42c.camel@kernel.org>
Subject: Re: [PATCH v4 12/39] netfs: Add iov_iters to (sub)requests to
 describe various buffers
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
Date: Wed, 13 Dec 2023 11:37:10 -0500
In-Reply-To: <20231213152350.431591-13-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
	 <20231213152350.431591-13-dhowells@redhat.com>
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
> Add three iov_iter structs:
>=20
>  (1) Add an iov_iter (->iter) to the I/O request to describe the
>      unencrypted-side buffer.
>=20
>  (2) Add an iov_iter (->io_iter) to the I/O request to describe the
>      encrypted-side I/O buffer.  This may be a different size to the buff=
er
>      in (1).
>=20
>  (3) Add an iov_iter (->io_iter) to the I/O subrequest to describe the pa=
rt
>      of the I/O buffer for that subrequest.
>=20
> This will allow future patches to point to a bounce buffer instead for
> purposes of handling oversize writes, decryption (where we want to save t=
he
> encrypted data to the cache) and decompression.
>=20
> These iov_iters persist for the lifetime of the (sub)request, and so can =
be
> accessed multiple times without worrying about them being deallocated upo=
n
> return to the caller.
>=20
> The network filesystem must appropriately advance the iterator before
> terminating the request.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/afs/file.c            |  6 +---
>  fs/netfs/buffered_read.c | 13 ++++++++
>  fs/netfs/io.c            | 69 +++++++++++++++++++++++++++++-----------
>  include/linux/netfs.h    |  3 ++
>  4 files changed, 67 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index c5013ec3c1dc..aa95b4d6376c 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
> @@ -320,11 +320,7 @@ static void afs_issue_read(struct netfs_io_subreques=
t *subreq)
>  	fsreq->len	=3D subreq->len   - subreq->transferred;
>  	fsreq->key	=3D key_get(subreq->rreq->netfs_priv);
>  	fsreq->vnode	=3D vnode;
> -	fsreq->iter	=3D &fsreq->def_iter;
> -
> -	iov_iter_xarray(&fsreq->def_iter, ITER_DEST,
> -			&fsreq->vnode->netfs.inode.i_mapping->i_pages,
> -			fsreq->pos, fsreq->len);
> +	fsreq->iter	=3D &subreq->io_iter;
> =20
>  	afs_fetch_data(fsreq->vnode, fsreq);
>  	afs_put_read(fsreq);
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index d39d0ffe75d2..751556faa70b 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -199,6 +199,10 @@ void netfs_readahead(struct readahead_control *ractl=
)
> =20
>  	netfs_rreq_expand(rreq, ractl);
> =20
> +	/* Set up the output buffer */
> +	iov_iter_xarray(&rreq->iter, ITER_DEST, &ractl->mapping->i_pages,
> +			rreq->start, rreq->len);
> +
>  	/* Drop the refs on the folios here rather than in the cache or
>  	 * filesystem.  The locks will be dropped in netfs_rreq_unlock().
>  	 */
> @@ -251,6 +255,11 @@ int netfs_read_folio(struct file *file, struct folio=
 *folio)
> =20
>  	netfs_stat(&netfs_n_rh_readpage);
>  	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpag=
e);
> +
> +	/* Set up the output buffer */
> +	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
> +			rreq->start, rreq->len);
> +
>  	return netfs_begin_read(rreq, true);
> =20
>  discard:
> @@ -408,6 +417,10 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  	ractl._nr_pages =3D folio_nr_pages(folio);
>  	netfs_rreq_expand(rreq, &ractl);
> =20
> +	/* Set up the output buffer */
> +	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
> +			rreq->start, rreq->len);

Should the above be ITER_SOURCE ?

> +
>  	/* We hold the folio locks, so we can drop the references */
>  	folio_get(folio);
>  	while (readahead_folio(&ractl))
> diff --git a/fs/netfs/io.c b/fs/netfs/io.c
> index 7f753380e047..e9d408e211b8 100644
> --- a/fs/netfs/io.c
> +++ b/fs/netfs/io.c
> @@ -21,12 +21,7 @@
>   */
>  static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
>  {
> -	struct iov_iter iter;
> -
> -	iov_iter_xarray(&iter, ITER_DEST, &subreq->rreq->mapping->i_pages,
> -			subreq->start + subreq->transferred,
> -			subreq->len   - subreq->transferred);
> -	iov_iter_zero(iov_iter_count(&iter), &iter);
> +	iov_iter_zero(iov_iter_count(&subreq->io_iter), &subreq->io_iter);
>  }
> =20
>  static void netfs_cache_read_terminated(void *priv, ssize_t transferred_=
or_error,
> @@ -46,14 +41,9 @@ static void netfs_read_from_cache(struct netfs_io_requ=
est *rreq,
>  				  enum netfs_read_from_hole read_hole)
>  {
>  	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
> -	struct iov_iter iter;
> =20
>  	netfs_stat(&netfs_n_rh_read);
> -	iov_iter_xarray(&iter, ITER_DEST, &rreq->mapping->i_pages,
> -			subreq->start + subreq->transferred,
> -			subreq->len   - subreq->transferred);
> -
> -	cres->ops->read(cres, subreq->start, &iter, read_hole,
> +	cres->ops->read(cres, subreq->start, &subreq->io_iter, read_hole,
>  			netfs_cache_read_terminated, subreq);
>  }
> =20
> @@ -88,6 +78,11 @@ static void netfs_read_from_server(struct netfs_io_req=
uest *rreq,
>  				   struct netfs_io_subrequest *subreq)
>  {
>  	netfs_stat(&netfs_n_rh_download);
> +	if (iov_iter_count(&subreq->io_iter) !=3D subreq->len - subreq->transfe=
rred)
> +		pr_warn("R=3D%08x[%u] ITER PRE-MISMATCH %zx !=3D %zx-%zx %lx\n",
> +			rreq->debug_id, subreq->debug_index,
> +			iov_iter_count(&subreq->io_iter), subreq->len,
> +			subreq->transferred, subreq->flags);

pr_warn is a bit alarmist, esp given the cryptic message.=A0 Maybe demote
this to INFO or DEBUG?

Does this indicate a bug in the client or that the server is sending us
malformed frames?

>  	rreq->netfs_ops->issue_read(subreq);
>  }
> =20
> @@ -259,6 +254,30 @@ static void netfs_rreq_short_read(struct netfs_io_re=
quest *rreq,
>  		netfs_read_from_server(rreq, subreq);
>  }
> =20
> +/*
> + * Reset the subrequest iterator prior to resubmission.
> + */
> +static void netfs_reset_subreq_iter(struct netfs_io_request *rreq,
> +				    struct netfs_io_subrequest *subreq)
> +{
> +	size_t remaining =3D subreq->len - subreq->transferred;
> +	size_t count =3D iov_iter_count(&subreq->io_iter);
> +
> +	if (count =3D=3D remaining)
> +		return;
> +
> +	_debug("R=3D%08x[%u] ITER RESUB-MISMATCH %zx !=3D %zx-%zx-%llx %x\n",
> +	       rreq->debug_id, subreq->debug_index,
> +	       iov_iter_count(&subreq->io_iter), subreq->transferred,
> +	       subreq->len, rreq->i_size,
> +	       subreq->io_iter.iter_type);
> +
> +	if (count < remaining)
> +		iov_iter_revert(&subreq->io_iter, remaining - count);
> +	else
> +		iov_iter_advance(&subreq->io_iter, count - remaining);
> +}
> +
>  /*
>   * Resubmit any short or failed operations.  Returns true if we got the =
rreq
>   * ref back.
> @@ -287,6 +306,7 @@ static bool netfs_rreq_perform_resubmissions(struct n=
etfs_io_request *rreq)
>  			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
>  			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
>  			atomic_inc(&rreq->nr_outstanding);
> +			netfs_reset_subreq_iter(rreq, subreq);
>  			netfs_read_from_server(rreq, subreq);
>  		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
>  			netfs_rreq_short_read(rreq, subreq);
> @@ -399,9 +419,9 @@ void netfs_subreq_terminated(struct netfs_io_subreque=
st *subreq,
>  	struct netfs_io_request *rreq =3D subreq->rreq;
>  	int u;
> =20
> -	_enter("[%u]{%llx,%lx},%zd",
> -	       subreq->debug_index, subreq->start, subreq->flags,
> -	       transferred_or_error);
> +	_enter("R=3D%x[%x]{%llx,%lx},%zd",
> +	       rreq->debug_id, subreq->debug_index,
> +	       subreq->start, subreq->flags, transferred_or_error);
> =20
>  	switch (subreq->source) {
>  	case NETFS_READ_FROM_CACHE:
> @@ -501,7 +521,8 @@ static enum netfs_io_source netfs_cache_prepare_read(=
struct netfs_io_subrequest
>   */
>  static enum netfs_io_source
>  netfs_rreq_prepare_read(struct netfs_io_request *rreq,
> -			struct netfs_io_subrequest *subreq)
> +			struct netfs_io_subrequest *subreq,
> +			struct iov_iter *io_iter)
>  {
>  	enum netfs_io_source source;
> =20
> @@ -528,9 +549,14 @@ netfs_rreq_prepare_read(struct netfs_io_request *rre=
q,
>  		}
>  	}
> =20
> -	if (WARN_ON(subreq->len =3D=3D 0))
> +	if (WARN_ON(subreq->len =3D=3D 0)) {
>  		source =3D NETFS_INVALID_READ;
> +		goto out;
> +	}
> =20
> +	subreq->io_iter =3D *io_iter;
> +	iov_iter_truncate(&subreq->io_iter, subreq->len);
> +	iov_iter_advance(io_iter, subreq->len);
>  out:
>  	subreq->source =3D source;
>  	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
> @@ -541,6 +567,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq=
,
>   * Slice off a piece of a read request and submit an I/O request for it.
>   */
>  static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
> +				    struct iov_iter *io_iter,
>  				    unsigned int *_debug_index)
>  {
>  	struct netfs_io_subrequest *subreq;
> @@ -565,7 +592,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_r=
equest *rreq,
>  	 * (the starts must coincide), in which case, we go around the loop
>  	 * again and ask it to download the next piece.
>  	 */
> -	source =3D netfs_rreq_prepare_read(rreq, subreq);
> +	source =3D netfs_rreq_prepare_read(rreq, subreq, io_iter);
>  	if (source =3D=3D NETFS_INVALID_READ)
>  		goto subreq_failed;
> =20
> @@ -603,6 +630,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_r=
equest *rreq,
>   */
>  int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
>  {
> +	struct iov_iter io_iter;
>  	unsigned int debug_index =3D 0;
>  	int ret;
> =20
> @@ -615,6 +643,8 @@ int netfs_begin_read(struct netfs_io_request *rreq, b=
ool sync)
>  		return -EIO;
>  	}
> =20
> +	rreq->io_iter =3D rreq->iter;
> +
>  	INIT_WORK(&rreq->work, netfs_rreq_work);
> =20
>  	if (sync)
> @@ -624,8 +654,9 @@ int netfs_begin_read(struct netfs_io_request *rreq, b=
ool sync)
>  	 * want and submit each one.
>  	 */
>  	atomic_set(&rreq->nr_outstanding, 1);
> +	io_iter =3D rreq->io_iter;
>  	do {
> -		if (!netfs_rreq_submit_slice(rreq, &debug_index))
> +		if (!netfs_rreq_submit_slice(rreq, &io_iter, &debug_index))
>  			break;
> =20
>  	} while (rreq->submitted < rreq->len);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index fc6d9756a029..3da962e977f5 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -150,6 +150,7 @@ struct netfs_cache_resources {
>  struct netfs_io_subrequest {
>  	struct netfs_io_request *rreq;		/* Supervising I/O request */
>  	struct list_head	rreq_link;	/* Link in rreq->subrequests */
> +	struct iov_iter		io_iter;	/* Iterator for this subrequest */
>  	loff_t			start;		/* Where to start the I/O */
>  	size_t			len;		/* Size of the I/O */
>  	size_t			transferred;	/* Amount of data transferred */
> @@ -186,6 +187,8 @@ struct netfs_io_request {
>  	struct netfs_cache_resources cache_resources;
>  	struct list_head	proc_link;	/* Link in netfs_iorequests */
>  	struct list_head	subrequests;	/* Contributory I/O operations */
> +	struct iov_iter		iter;		/* Unencrypted-side iterator */
> +	struct iov_iter		io_iter;	/* I/O (Encrypted-side) iterator */
>  	void			*netfs_priv;	/* Private data for the netfs */
>  	unsigned int		debug_id;
>  	atomic_t		nr_outstanding;	/* Number of ops in progress */
>=20

--=20
Jeff Layton <jlayton@kernel.org>

