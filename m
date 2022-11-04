Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E391619595
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 12:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiKDLqn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKDLql (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EB2CDED;
        Fri,  4 Nov 2022 04:46:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2A6562171;
        Fri,  4 Nov 2022 11:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4D8C433D6;
        Fri,  4 Nov 2022 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667562399;
        bh=J4hnIzgGZepZLTiOSEto/fiY51Ieg6w/6LSkcZ9R8h8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DTE6xq6O6kPHmOoXg+U35OE+48xVcGourcyk55aXWJJtT0dU9sdvEKaKv5Lyc4MGc
         QGCTDqcpTEo8nNJIOrRD4BO61hqUtlkmyP+/IIGJOGqtuU64VfNxanvNa7wpaRHDqV
         f+4QKMEbJMsYnoDi9uvW96Y2DrOa1DSgnjG0NwmFsUWY21uiVBMcqUNi0zTZvzKMh/
         RYBy8hUzvm+tyS4ykuMl4AkVZTLuR9Dzr3zsUHyFw4ksuRR/4UJ6QSuN4p/hONC6la
         JrIxxCPA81HZUsc4WRiY9hiFBvoeJ0oTg8UAIt0ht6fZFNIrZeJhFZpxRJaX1X08Qm
         HSCd2L8k1HOiw==
Message-ID: <2e2eceeb11972462bb9161a73c00a9c77f8af8d2.camel@kernel.org>
Subject: Re: [PATCH 2/2] erofs: switch to prepare_ondemand_read() in fscache
 mode
From:   Jeff Layton <jlayton@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 04 Nov 2022 07:46:37 -0400
In-Reply-To: <20221104072637.72375-3-jefflexu@linux.alibaba.com>
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
         <20221104072637.72375-3-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-04 at 15:26 +0800, Jingbo Xu wrote:
> Switch to prepare_ondemand_read() interface and a self-contained request
> completion to get rid of netfs_io_[request|subrequest].
>=20
> The whole request will still be split into slices (subrequest) according
> to the cache state of the backing file.  As long as one of the
> subrequests fails, the whole request will be marked as failed. Besides
> it will not retry for short read.  Similarly the whole request will fail
> if that really happens.=A0
>=20

That's sort of nasty. The kernel can generally give you a short read for
all sorts of reasons, some of which may have nothing to do with the
underlying file or filesystem.

Passing an error back to an application on a short read is probably not
what you want to do here. The usual thing to do is just to return what
you can, and let the application redrive the request if it wants.

>  Thus the subrequest structure is not a
> necessity here.  What we need is just to hold one refcount to the
> request for each subrequest during the slicing, and put the refcount
> back during the completion.
>=20
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c | 257 ++++++++++++++++-----------------------------
>  1 file changed, 92 insertions(+), 165 deletions(-)
>=20
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 260fa4737fc0..7fc9cd35ab76 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -11,253 +11,176 @@ static DEFINE_MUTEX(erofs_domain_cookies_lock);
>  static LIST_HEAD(erofs_domain_list);
>  static struct vfsmount *erofs_pseudo_mnt;
> =20
> -static struct netfs_io_request *erofs_fscache_alloc_request(struct addre=
ss_space *mapping,
> +struct erofs_fscache_request {
> +	struct netfs_cache_resources cache_resources;
> +	struct address_space	*mapping;	/* The mapping being accessed */
> +	loff_t			start;		/* Start position */
> +	size_t			len;		/* Length of the request */
> +	size_t			submitted;	/* Length of submitted */
> +	short			error;		/* 0 or error that occurred */
> +	refcount_t		ref;
> +};
> +
> +static struct erofs_fscache_request *erofs_fscache_req_alloc(struct addr=
ess_space *mapping,
>  					     loff_t start, size_t len)
>  {
> -	struct netfs_io_request *rreq;
> +	struct erofs_fscache_request *req;
> =20
> -	rreq =3D kzalloc(sizeof(struct netfs_io_request), GFP_KERNEL);
> -	if (!rreq)
> +	req =3D kzalloc(sizeof(struct erofs_fscache_request), GFP_KERNEL);
> +	if (!req)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	rreq->start	=3D start;
> -	rreq->len	=3D len;
> -	rreq->mapping	=3D mapping;
> -	rreq->inode	=3D mapping->host;
> -	INIT_LIST_HEAD(&rreq->subrequests);
> -	refcount_set(&rreq->ref, 1);
> -	return rreq;
> -}
> -
> -static void erofs_fscache_put_request(struct netfs_io_request *rreq)
> -{
> -	if (!refcount_dec_and_test(&rreq->ref))
> -		return;
> -	if (rreq->cache_resources.ops)
> -		rreq->cache_resources.ops->end_operation(&rreq->cache_resources);
> -	kfree(rreq);
> -}
> -
> -static void erofs_fscache_put_subrequest(struct netfs_io_subrequest *sub=
req)
> -{
> -	if (!refcount_dec_and_test(&subreq->ref))
> -		return;
> -	erofs_fscache_put_request(subreq->rreq);
> -	kfree(subreq);
> -}
> -
> -static void erofs_fscache_clear_subrequests(struct netfs_io_request *rre=
q)
> -{
> -	struct netfs_io_subrequest *subreq;
> +	req->mapping =3D mapping;
> +	req->start   =3D start;
> +	req->len     =3D len;
> +	refcount_set(&req->ref, 1);
> =20
> -	while (!list_empty(&rreq->subrequests)) {
> -		subreq =3D list_first_entry(&rreq->subrequests,
> -				struct netfs_io_subrequest, rreq_link);
> -		list_del(&subreq->rreq_link);
> -		erofs_fscache_put_subrequest(subreq);
> -	}
> +	return req;
>  }
> =20
> -static void erofs_fscache_rreq_unlock_folios(struct netfs_io_request *rr=
eq)
> +static void erofs_fscache_req_complete(struct erofs_fscache_request *req=
)
>  {
> -	struct netfs_io_subrequest *subreq;
>  	struct folio *folio;
> -	unsigned int iopos =3D 0;
> -	pgoff_t start_page =3D rreq->start / PAGE_SIZE;
> -	pgoff_t last_page =3D ((rreq->start + rreq->len) / PAGE_SIZE) - 1;
> -	bool subreq_failed =3D false;
> -
> -	XA_STATE(xas, &rreq->mapping->i_pages, start_page);
> +	pgoff_t start_page =3D req->start / PAGE_SIZE;
> +	pgoff_t last_page =3D ((req->start + req->len) / PAGE_SIZE) - 1;
> +	bool failed =3D req->error;
> =20
> -	subreq =3D list_first_entry(&rreq->subrequests,
> -				  struct netfs_io_subrequest, rreq_link);
> -	subreq_failed =3D (subreq->error < 0);
> +	XA_STATE(xas, &req->mapping->i_pages, start_page);
> =20
>  	rcu_read_lock();
>  	xas_for_each(&xas, folio, last_page) {

You probably need to use xas_retry() here. See David's patch posted
yesterday:

    netfs: Fix missing xas_retry() calls in xarray iteration

> -		unsigned int pgpos =3D
> -			(folio_index(folio) - start_page) * PAGE_SIZE;
> -		unsigned int pgend =3D pgpos + folio_size(folio);
> -		bool pg_failed =3D false;
> -
> -		for (;;) {
> -			if (!subreq) {
> -				pg_failed =3D true;
> -				break;
> -			}
> -
> -			pg_failed |=3D subreq_failed;
> -			if (pgend < iopos + subreq->len)
> -				break;
> -
> -			iopos +=3D subreq->len;
> -			if (!list_is_last(&subreq->rreq_link,
> -					  &rreq->subrequests)) {
> -				subreq =3D list_next_entry(subreq, rreq_link);
> -				subreq_failed =3D (subreq->error < 0);
> -			} else {
> -				subreq =3D NULL;
> -				subreq_failed =3D false;
> -			}
> -			if (pgend =3D=3D iopos)
> -				break;
> -		}
> -
> -		if (!pg_failed)
> +		if (!failed)
>  			folio_mark_uptodate(folio);
> -
>  		folio_unlock(folio);
>  	}
>  	rcu_read_unlock();
> +
> +	if (req->cache_resources.ops)
> +		req->cache_resources.ops->end_operation(&req->cache_resources);
> +
> +	kfree(req);
>  }
> =20
> -static void erofs_fscache_rreq_complete(struct netfs_io_request *rreq)
> +static void erofs_fscache_req_put(struct erofs_fscache_request *req)
>  {
> -	erofs_fscache_rreq_unlock_folios(rreq);
> -	erofs_fscache_clear_subrequests(rreq);
> -	erofs_fscache_put_request(rreq);
> +	if (refcount_dec_and_test(&req->ref))
> +		erofs_fscache_req_complete(req);
>  }
> =20
> -static void erofc_fscache_subreq_complete(void *priv,
> +static void erofs_fscache_subreq_complete(void *priv,
>  		ssize_t transferred_or_error, bool was_async)
>  {
> -	struct netfs_io_subrequest *subreq =3D priv;
> -	struct netfs_io_request *rreq =3D subreq->rreq;
> +	struct erofs_fscache_request *req =3D priv;
> =20
>  	if (IS_ERR_VALUE(transferred_or_error))
> -		subreq->error =3D transferred_or_error;
> -
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		erofs_fscache_rreq_complete(rreq);
> -
> -	erofs_fscache_put_subrequest(subreq);
> +		req->error =3D transferred_or_error;
> +	erofs_fscache_req_put(req);
>  }
> =20
>  /*
> - * Read data from fscache and fill the read data into page cache describ=
ed by
> - * @rreq, which shall be both aligned with PAGE_SIZE. @pstart describes
> - * the start physical address in the cache file.
> + * Read data from fscache (cookie, pstart, len), and fill the read data =
into
> + * page cache described by (req->mapping, lstart, len). @pstart describe=
is the
> + * start physical address in the cache file.
>   */
>  static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie=
,
> -				struct netfs_io_request *rreq, loff_t pstart)
> +		struct erofs_fscache_request *req, loff_t pstart, size_t len)
>  {
>  	enum netfs_io_source source;
> -	struct super_block *sb =3D rreq->mapping->host->i_sb;
> -	struct netfs_io_subrequest *subreq;
> -	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
> +	struct super_block *sb =3D req->mapping->host->i_sb;
> +	struct netfs_cache_resources *cres =3D &req->cache_resources;
>  	struct iov_iter iter;
> -	loff_t start =3D rreq->start;
> -	size_t len =3D rreq->len;
> +	loff_t lstart =3D req->start + req->submitted;
>  	size_t done =3D 0;
>  	int ret;
> =20
> -	atomic_set(&rreq->nr_outstanding, 1);
> +	DBG_BUGON(len > req->len - req->submitted);
> =20
>  	ret =3D fscache_begin_read_operation(cres, cookie);
>  	if (ret)
> -		goto out;
> +		return ret;
> =20
>  	while (done < len) {
> -		subreq =3D kzalloc(sizeof(struct netfs_io_subrequest),
> -				 GFP_KERNEL);
> -		if (subreq) {
> -			INIT_LIST_HEAD(&subreq->rreq_link);
> -			refcount_set(&subreq->ref, 2);
> -			subreq->rreq =3D rreq;
> -			refcount_inc(&rreq->ref);
> -		} else {
> -			ret =3D -ENOMEM;
> -			goto out;
> -		}
> +		loff_t sstart =3D pstart + done;
> +		size_t slen =3D len - done;
> =20
> -		subreq->start =3D pstart + done;
> -		subreq->len	=3D  len - done;
> -		subreq->flags =3D 1 << NETFS_SREQ_ONDEMAND;
> -
> -		list_add_tail(&subreq->rreq_link, &rreq->subrequests);
> -
> -		source =3D cres->ops->prepare_read(subreq, LLONG_MAX);
> -		if (WARN_ON(subreq->len =3D=3D 0))
> +		source =3D cres->ops->prepare_ondemand_read(cres, sstart, &slen, LLONG=
_MAX);
> +		if (WARN_ON(slen =3D=3D 0))
>  			source =3D NETFS_INVALID_READ;
>  		if (source !=3D NETFS_READ_FROM_CACHE) {
> -			erofs_err(sb, "failed to fscache prepare_read (source %d)",
> -				  source);
> -			ret =3D -EIO;
> -			subreq->error =3D ret;
> -			erofs_fscache_put_subrequest(subreq);
> -			goto out;
> +			erofs_err(sb, "failed to fscache prepare_read (source %d)", source);
> +			return -EIO;
>  		}
> =20
> -		atomic_inc(&rreq->nr_outstanding);
> +		refcount_inc(&req->ref);
> +		iov_iter_xarray(&iter, READ, &req->mapping->i_pages,
> +				lstart + done, slen);
> =20
> -		iov_iter_xarray(&iter, READ, &rreq->mapping->i_pages,
> -				start + done, subreq->len);
> -
> -		ret =3D fscache_read(cres, subreq->start, &iter,
> -				   NETFS_READ_HOLE_FAIL,
> -				   erofc_fscache_subreq_complete, subreq);
> +		ret =3D fscache_read(cres, sstart, &iter, NETFS_READ_HOLE_FAIL,
> +				   erofs_fscache_subreq_complete, req);
>  		if (ret =3D=3D -EIOCBQUEUED)
>  			ret =3D 0;
>  		if (ret) {
>  			erofs_err(sb, "failed to fscache_read (ret %d)", ret);
> -			goto out;
> +			return ret;
>  		}
> =20
> -		done +=3D subreq->len;
> +		done +=3D slen;
>  	}
> -out:
> -	if (atomic_dec_and_test(&rreq->nr_outstanding))
> -		erofs_fscache_rreq_complete(rreq);
> -
> -	return ret;
> +	DBG_BUGON(done !=3D len);
> +	req->submitted +=3D len;
> +	return 0;
>  }
> =20
>  static int erofs_fscache_meta_read_folio(struct file *data, struct folio=
 *folio)
>  {
>  	int ret;
>  	struct super_block *sb =3D folio_mapping(folio)->host->i_sb;
> -	struct netfs_io_request *rreq;
> +	struct erofs_fscache_request *req;
>  	struct erofs_map_dev mdev =3D {
>  		.m_deviceid =3D 0,
>  		.m_pa =3D folio_pos(folio),
>  	};
> =20
>  	ret =3D erofs_map_dev(sb, &mdev);
> -	if (ret)
> -		goto out;
> +	if (ret) {
> +		folio_unlock(folio);
> +		return ret;
> +	}
> =20
> -	rreq =3D erofs_fscache_alloc_request(folio_mapping(folio),
> +	req =3D erofs_fscache_req_alloc(folio_mapping(folio),
>  				folio_pos(folio), folio_size(folio));
> -	if (IS_ERR(rreq)) {
> -		ret =3D PTR_ERR(rreq);
> -		goto out;
> +	if (IS_ERR(req)) {
> +		folio_unlock(folio);
> +		return PTR_ERR(req);
>  	}
> =20
> -	return erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> -				rreq, mdev.m_pa);
> -out:
> -	folio_unlock(folio);
> +	ret =3D erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +				req, mdev.m_pa, folio_size(folio));
> +	if (ret)
> +		req->error =3D ret;
> +
> +	erofs_fscache_req_put(req);
>  	return ret;
>  }
> =20
>  /*
>   * Read into page cache in the range described by (@pos, @len).
>   *
> - * On return, the caller is responsible for page unlocking if the output=
 @unlock
> - * is true, or the callee will take this responsibility through netfs_io=
_request
> - * interface.
> + * On return, if the output @unlock is true, the caller is responsible f=
or page
> + * unlocking; otherwise the callee will take this responsibility through=
 request
> + * completion.
>   *
>   * The return value is the number of bytes successfully handled, or nega=
tive
>   * error code on failure. The only exception is that, the length of the =
range
> - * instead of the error code is returned on failure after netfs_io_reque=
st is
> - * allocated, so that .readahead() could advance rac accordingly.
> + * instead of the error code is returned on failure after request is all=
ocated,
> + * so that .readahead() could advance rac accordingly.
>   */
>  static int erofs_fscache_data_read(struct address_space *mapping,
>  				   loff_t pos, size_t len, bool *unlock)
>  {
>  	struct inode *inode =3D mapping->host;
>  	struct super_block *sb =3D inode->i_sb;
> -	struct netfs_io_request *rreq;
> +	struct erofs_fscache_request *req;
>  	struct erofs_map_blocks map;
>  	struct erofs_map_dev mdev;
>  	struct iov_iter iter;
> @@ -314,13 +237,17 @@ static int erofs_fscache_data_read(struct address_s=
pace *mapping,
>  	if (ret)
>  		return ret;
> =20
> -	rreq =3D erofs_fscache_alloc_request(mapping, pos, count);
> -	if (IS_ERR(rreq))
> -		return PTR_ERR(rreq);
> +	req =3D erofs_fscache_req_alloc(mapping, pos, count);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> =20
>  	*unlock =3D false;
> -	erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> -			rreq, mdev.m_pa + (pos - map.m_la));
> +	ret =3D erofs_fscache_read_folios_async(mdev.m_fscache->cookie,
> +			req, mdev.m_pa + (pos - map.m_la), count);
> +	if (ret)
> +		req->error =3D ret;
> +
> +	erofs_fscache_req_put(req);
>  	return count;
>  }
> =20

--=20
Jeff Layton <jlayton@kernel.org>
