Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F323562D8D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 12:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiKQLFt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 06:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbiKQLFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:05:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F481D67F;
        Thu, 17 Nov 2022 03:05:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2BF59CE1CA1;
        Thu, 17 Nov 2022 11:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8673FC433C1;
        Thu, 17 Nov 2022 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668683133;
        bh=R/1udujr+EpldTJkI3dLIc5lWvtIBUXov5AATIJC3I0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gFabA+/uQRJ3T8uspYUJR1FSr+0BMz6wE6ZPPghOOrNHemLXDv7g1aW2VYg0yaIc3
         feCh2A85ZhxnHmJ3a+oXjhBkGmA5DeeAGvBk+vwpEREf+nKmdeVW2i0mglbObTIK22
         SYOiFP/BYtHinoZ/0P7cCRsA5CvTyzg3Hq2vujvBPKT6ixKEm3Z8pgn8efv81clPUK
         eTmCjR7pQ54KG4YRhnnytA/c4MjciPZYISf+KTfVxLo1k/g7XZhffH3dZyS8NKdIYW
         F8gnKAyqp9a+CvOYMjKjTYK7Szd2tGBWKMSDSxWAi9mfV69B+aHcZdm3TOsNpjNSsk
         UzJX6RQqpiCmw==
Message-ID: <a8831e31df79ac00943ccc21ac5d207e5faea96a.camel@kernel.org>
Subject: Re: [PATCH v4 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
From:   Jeff Layton <jlayton@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Thu, 17 Nov 2022 06:05:31 -0500
In-Reply-To: <20221117053017.21074-2-jefflexu@linux.alibaba.com>
References: <20221117053017.21074-1-jefflexu@linux.alibaba.com>
         <20221117053017.21074-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2022-11-17 at 13:30 +0800, Jingbo Xu wrote:
> Add prepare_ondemand_read() callback dedicated for the on-demand read
> scenario, so that callers from this scenario can be decoupled from
> netfs_io_subrequest.
>=20
> The original cachefiles_prepare_read() is now refactored to a generic
> routine accepting a parameter list instead of netfs_io_subrequest.
> There's no logic change, except that some debug info retrieved from
> netfs_io_subrequest is removed from trace_cachefiles_prep_read().
>=20
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/cachefiles/io.c                | 77 ++++++++++++++++++++-----------
>  include/linux/netfs.h             |  8 ++++
>  include/trace/events/cachefiles.h | 27 ++++++-----
>  3 files changed, 71 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 000a28f46e59..13648348d9f9 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -385,38 +385,35 @@ static int cachefiles_write(struct netfs_cache_reso=
urces *cres,
>  				  term_func, term_func_priv);
>  }
> =20
> -/*
> - * Prepare a read operation, shortening it to a cached/uncached
> - * boundary as appropriate.
> - */
> -static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subr=
equest *subreq,
> -						      loff_t i_size)
> +static inline enum netfs_io_source
> +cachefiles_do_prepare_read(struct netfs_cache_resources *cres,
> +			   loff_t start, size_t *_len, loff_t i_size,
> +			   unsigned long *_flags)
>  {
>  	enum cachefiles_prepare_read_trace why;
> -	struct netfs_io_request *rreq =3D subreq->rreq;
> -	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
> -	struct cachefiles_object *object;
> +	struct cachefiles_object *object =3D NULL;
>  	struct cachefiles_cache *cache;
>  	struct fscache_cookie *cookie =3D fscache_cres_cookie(cres);
>  	const struct cred *saved_cred;
>  	struct file *file =3D cachefiles_cres_file(cres);
>  	enum netfs_io_source ret =3D NETFS_DOWNLOAD_FROM_SERVER;
> +	size_t len =3D *_len;
>  	loff_t off, to;
>  	ino_t ino =3D file ? file_inode(file)->i_ino : 0;
>  	int rc;
> =20
> -	_enter("%zx @%llx/%llx", subreq->len, subreq->start, i_size);
> +	_enter("%zx @%llx/%llx", len, start, i_size);
> =20
> -	if (subreq->start >=3D i_size) {
> +	if (start >=3D i_size) {
>  		ret =3D NETFS_FILL_WITH_ZEROES;
>  		why =3D cachefiles_trace_read_after_eof;
>  		goto out_no_object;
>  	}
> =20
>  	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
> -		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
> +		__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
>  		why =3D cachefiles_trace_read_no_data;
> -		if (!test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags))
> +		if (!test_bit(NETFS_SREQ_ONDEMAND, _flags))
>  			goto out_no_object;
>  	}
> =20
> @@ -437,7 +434,7 @@ static enum netfs_io_source cachefiles_prepare_read(s=
truct netfs_io_subrequest *
>  retry:
>  	off =3D cachefiles_inject_read_error();
>  	if (off =3D=3D 0)
> -		off =3D vfs_llseek(file, subreq->start, SEEK_DATA);
> +		off =3D vfs_llseek(file, start, SEEK_DATA);
>  	if (off < 0 && off >=3D (loff_t)-MAX_ERRNO) {
>  		if (off =3D=3D (loff_t)-ENXIO) {
>  			why =3D cachefiles_trace_read_seek_nxio;
> @@ -449,21 +446,22 @@ static enum netfs_io_source cachefiles_prepare_read=
(struct netfs_io_subrequest *
>  		goto out;
>  	}
> =20
> -	if (off >=3D subreq->start + subreq->len) {
> +	if (off >=3D start + len) {
>  		why =3D cachefiles_trace_read_found_hole;
>  		goto download_and_store;
>  	}
> =20
> -	if (off > subreq->start) {
> +	if (off > start) {
>  		off =3D round_up(off, cache->bsize);
> -		subreq->len =3D off - subreq->start;
> +		len =3D off - start;
> +		*_len =3D len;
>  		why =3D cachefiles_trace_read_found_part;
>  		goto download_and_store;
>  	}
> =20
>  	to =3D cachefiles_inject_read_error();
>  	if (to =3D=3D 0)
> -		to =3D vfs_llseek(file, subreq->start, SEEK_HOLE);
> +		to =3D vfs_llseek(file, start, SEEK_HOLE);
>  	if (to < 0 && to >=3D (loff_t)-MAX_ERRNO) {
>  		trace_cachefiles_io_error(object, file_inode(file), to,
>  					  cachefiles_trace_seek_error);
> @@ -471,12 +469,13 @@ static enum netfs_io_source cachefiles_prepare_read=
(struct netfs_io_subrequest *
>  		goto out;
>  	}
> =20
> -	if (to < subreq->start + subreq->len) {
> -		if (subreq->start + subreq->len >=3D i_size)
> +	if (to < start + len) {
> +		if (start + len >=3D i_size)
>  			to =3D round_up(to, cache->bsize);
>  		else
>  			to =3D round_down(to, cache->bsize);
> -		subreq->len =3D to - subreq->start;
> +		len =3D to - start;
> +		*_len =3D len;
>  	}
> =20
>  	why =3D cachefiles_trace_read_have_data;
> @@ -484,12 +483,11 @@ static enum netfs_io_source cachefiles_prepare_read=
(struct netfs_io_subrequest *
>  	goto out;
> =20
>  download_and_store:
> -	__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
> -	if (test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags)) {
> -		rc =3D cachefiles_ondemand_read(object, subreq->start,
> -					      subreq->len);
> +	__set_bit(NETFS_SREQ_COPY_TO_CACHE, _flags);
> +	if (test_bit(NETFS_SREQ_ONDEMAND, _flags)) {
> +		rc =3D cachefiles_ondemand_read(object, start, len);
>  		if (!rc) {
> -			__clear_bit(NETFS_SREQ_ONDEMAND, &subreq->flags);
> +			__clear_bit(NETFS_SREQ_ONDEMAND, _flags);
>  			goto retry;
>  		}
>  		ret =3D NETFS_INVALID_READ;
> @@ -497,10 +495,34 @@ static enum netfs_io_source cachefiles_prepare_read=
(struct netfs_io_subrequest *
>  out:
>  	cachefiles_end_secure(cache, saved_cred);
>  out_no_object:
> -	trace_cachefiles_prep_read(subreq, ret, why, ino);
> +	trace_cachefiles_prep_read(object, start, len, *_flags, ret, why, ino);
>  	return ret;
>  }
> =20
> +/*
> + * Prepare a read operation, shortening it to a cached/uncached
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subr=
equest *subreq,
> +						    loff_t i_size)
> +{
> +	return cachefiles_do_prepare_read(&subreq->rreq->cache_resources,
> +					  subreq->start, &subreq->len, i_size,
> +					  &subreq->flags);
> +}
> +
> +/*
> + * Prepare an on-demand read operation, shortening it to a cached/uncach=
ed
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source
> +cachefiles_prepare_ondemand_read(struct netfs_cache_resources *cres,
> +				 loff_t start, size_t *_len, loff_t i_size,
> +				 unsigned long *_flags)
> +{
> +	return cachefiles_do_prepare_read(cres, start, _len, i_size, _flags);
> +}
> +
>  /*
>   * Prepare for a write to occur.
>   */
> @@ -621,6 +643,7 @@ static const struct netfs_cache_ops cachefiles_netfs_=
cache_ops =3D {
>  	.write			=3D cachefiles_write,
>  	.prepare_read		=3D cachefiles_prepare_read,
>  	.prepare_write		=3D cachefiles_prepare_write,
> +	.prepare_ondemand_read	=3D cachefiles_prepare_ondemand_read,
>  	.query_occupancy	=3D cachefiles_query_occupancy,
>  };
> =20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index f2402ddeafbf..95cc0397f0ee 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -267,6 +267,14 @@ struct netfs_cache_ops {
>  			     loff_t *_start, size_t *_len, loff_t i_size,
>  			     bool no_space_allocated_yet);
> =20
> +	/* Prepare an on-demand read operation, shortening it to a cached/uncac=
hed
> +	 * boundary as appropriate.
> +	 */
> +	enum netfs_io_source (*prepare_ondemand_read)(struct netfs_cache_resour=
ces *cres,
> +						      loff_t start, size_t *_len,
> +						      loff_t i_size,
> +						      unsigned long *_flags);
> +
>  	/* Query the occupancy of the cache in a region, returning where the
>  	 * next chunk of data starts and how long it is.
>  	 */
> diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cac=
hefiles.h
> index d8d4d73fe7b6..171c0d7f0bb7 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -428,44 +428,43 @@ TRACE_EVENT(cachefiles_vol_coherency,
>  	    );
> =20
>  TRACE_EVENT(cachefiles_prep_read,
> -	    TP_PROTO(struct netfs_io_subrequest *sreq,
> +	    TP_PROTO(struct cachefiles_object *obj,
> +		     loff_t start,
> +		     size_t len,
> +		     unsigned short flags,
>  		     enum netfs_io_source source,
>  		     enum cachefiles_prepare_read_trace why,
>  		     ino_t cache_inode),
> =20
> -	    TP_ARGS(sreq, source, why, cache_inode),
> +	    TP_ARGS(obj, start, len, flags, source, why, cache_inode),
> =20
>  	    TP_STRUCT__entry(
> -		    __field(unsigned int,		rreq		)
> -		    __field(unsigned short,		index		)
> +		    __field(unsigned int,		obj		)
>  		    __field(unsigned short,		flags		)
>  		    __field(enum netfs_io_source,	source		)
>  		    __field(enum cachefiles_prepare_read_trace,	why	)
>  		    __field(size_t,			len		)
>  		    __field(loff_t,			start		)
> -		    __field(unsigned int,		netfs_inode	)
>  		    __field(unsigned int,		cache_inode	)
>  			     ),
> =20
>  	    TP_fast_assign(
> -		    __entry->rreq	=3D sreq->rreq->debug_id;
> -		    __entry->index	=3D sreq->debug_index;
> -		    __entry->flags	=3D sreq->flags;
> +		    __entry->obj	=3D obj ? obj->debug_id : 0;
> +		    __entry->flags	=3D flags;
>  		    __entry->source	=3D source;
>  		    __entry->why	=3D why;
> -		    __entry->len	=3D sreq->len;
> -		    __entry->start	=3D sreq->start;
> -		    __entry->netfs_inode =3D sreq->rreq->inode->i_ino;
> +		    __entry->len	=3D len;
> +		    __entry->start	=3D start;
>  		    __entry->cache_inode =3D cache_inode;
>  			   ),
> =20
> -	    TP_printk("R=3D%08x[%u] %s %s f=3D%02x s=3D%llx %zx ni=3D%x B=3D%x"=
,
> -		      __entry->rreq, __entry->index,
> +	    TP_printk("o=3D%08x %s %s f=3D%02x s=3D%llx %zx B=3D%x",
> +		      __entry->obj,
>  		      __print_symbolic(__entry->source, netfs_sreq_sources),
>  		      __print_symbolic(__entry->why, cachefiles_prepare_read_traces),
>  		      __entry->flags,
>  		      __entry->start, __entry->len,
> -		      __entry->netfs_inode, __entry->cache_inode)
> +		      __entry->cache_inode)
>  	    );
> =20
>  TRACE_EVENT(cachefiles_read,


Reviewed-by: Jeff Layton <jlayton@kernel.org>
