Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FDD62BD01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiKPMGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 07:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiKPMFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:05:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5C8BC39;
        Wed, 16 Nov 2022 03:58:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF88861D4C;
        Wed, 16 Nov 2022 11:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6440FC433C1;
        Wed, 16 Nov 2022 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668599884;
        bh=TubRFrIRup0f+iGUnBCblOY73bmIPJMnqGnMKJLR7O4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WPZoa/107vxATM7EOnSSWYfXR1DJAcSa6lOg6Zo2OTAOLE76x2XoAnPw/md4X8D3w
         xkXmTMAkZnJHsJTAQxROywu6Sx20E41i0RVcRQCm85JxwU0k1GB461tRF3oMOlV8hF
         stdLVAY+An5bIY9R78HNZ0uk+0wHilfBGurqIJ1lw2uqIY7HMfM9zq9wV1wJKblqg7
         /n3t884km+meWglgrK5y0Sk62u/XE9KZre3mVG7QMLrFPTn7KwGg019/Jh6IC2Zley
         Wrt7Pd9aFCbNvTNIwS4rmKrbpX7SEd0MvFPwsISq3u5l+G8Ome+dHM3sNY7JO5lVi2
         QYD7z36PYJXYA==
Message-ID: <2b595b62f6ecd28298a860fcdc5b4941dcafd9eb.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
From:   Jeff Layton <jlayton@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cachefs@redhat.com, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 16 Nov 2022 06:58:01 -0500
In-Reply-To: <20221116104502.107431-2-jefflexu@linux.alibaba.com>
References: <20221116104502.107431-1-jefflexu@linux.alibaba.com>
         <20221116104502.107431-2-jefflexu@linux.alibaba.com>
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

On Wed, 2022-11-16 at 18:45 +0800, Jingbo Xu wrote:
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
>  fs/cachefiles/io.c                | 75 ++++++++++++++++++++-----------
>  include/linux/netfs.h             |  7 +++
>  include/trace/events/cachefiles.h | 27 ++++++-----
>  3 files changed, 68 insertions(+), 41 deletions(-)
>=20
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 000a28f46e59..3eeafef21c4e 100644
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
> +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_cach=
e_resources *cres,
> +					loff_t *_start, size_t *_len,
> +					unsigned long *_flags, loff_t i_size)

_start is never changed, so it should be passed by value instead of by
pointer. I'd also reverse the position of the arguments for _flags and
i_size.=A0 Otherwise, the CPU/compiler have to shuffle things around more
in cachefiles_prepare_ondemand_read before they call this.


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
> +	loff_t start =3D *_start;
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
> @@ -497,10 +495,32 @@ static enum netfs_io_source cachefiles_prepare_read=
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
> +			&subreq->start, &subreq->len, &subreq->flags, i_size);
> +}
> +
> +/*
> + * Prepare an on-demand read operation, shortening it to a cached/uncach=
ed
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source cachefiles_prepare_ondemand_read(struct netf=
s_cache_resources *cres,
> +			loff_t start, size_t *_len, loff_t i_size)
> +{
> +	unsigned long flags =3D 1 << NETFS_SREQ_ONDEMAND;
> +	return cachefiles_do_prepare_read(cres, &start, _len, &flags, i_size);
> +}
> +
>  /*
>   * Prepare for a write to occur.
>   */
> @@ -621,6 +641,7 @@ static const struct netfs_cache_ops cachefiles_netfs_=
cache_ops =3D {
>  	.write			=3D cachefiles_write,
>  	.prepare_read		=3D cachefiles_prepare_read,
>  	.prepare_write		=3D cachefiles_prepare_write,
> +	.prepare_ondemand_read	=3D cachefiles_prepare_ondemand_read,
>  	.query_occupancy	=3D cachefiles_query_occupancy,
>  };
> =20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index f2402ddeafbf..d82071c37133 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -267,6 +267,13 @@ struct netfs_cache_ops {
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
> +						      loff_t i_size);
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


The rest looks pretty reasonable though.
--=20
Jeff Layton <jlayton@kernel.org>
