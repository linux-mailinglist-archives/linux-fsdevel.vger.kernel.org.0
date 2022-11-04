Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB2619540
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 12:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKDLSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 07:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKDLSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 07:18:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABCFF45;
        Fri,  4 Nov 2022 04:18:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E94ABB82B46;
        Fri,  4 Nov 2022 11:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73B9C433C1;
        Fri,  4 Nov 2022 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667560689;
        bh=CK29If4EWiRrz7gJ/vpFOsjuanASNOCL6aO3uz9vGas=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UKq30hhIx0zd0n/4UXBfv17u0npZR773BEVnxjLgKVoPkXj9WDShYQIWA8fN65SWx
         3j3o6VBuMnMaxPMMrRyzAjsuWIatmEKje9dtSra5Oq5I1ecCoZa2Tfyz7w75vJhor0
         mNA3mKX8euD0ExBLeC4g/zxKdRlclGqHVLy/PBzu5zqtdcaGyJqotgZWWdqzJa5bZE
         qqbJ2LQ+PlgGqCpEIeu9xwe+yCrCh88jOmBimu/sP5sfY/vLlIWmNxtKvBvsiOT4bh
         X1WzBWoXqwn7YPB9bRQX4OwfrGhtt3vInRaqpMqgAdU4EkQXiS1cZzzUAaKWypaScM
         iAfoQSKLsrvDA==
Message-ID: <c0d893bf6f52702a0bd2056a8cb005861b8324ea.camel@kernel.org>
Subject: Re: [PATCH 1/2] fscache,cachefiles: add prepare_ondemand_read()
 callback
From:   Jeff Layton <jlayton@kernel.org>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        xiang@kernel.org, chao@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 04 Nov 2022 07:18:07 -0400
In-Reply-To: <20221104072637.72375-2-jefflexu@linux.alibaba.com>
References: <20221104072637.72375-1-jefflexu@linux.alibaba.com>
         <20221104072637.72375-2-jefflexu@linux.alibaba.com>
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
> Add prepare_ondemand_read() callback dedicated for the on-demand read
> scenario, so that callers from this scenario can be decoupled from
> netfs_io_subrequest.
>=20
> To reuse the hole detecting logic as mush as possible, both the
> implementation of prepare_read() and prepare_ondemand_read() inside
> Cachefiles call a common routine.
>=20
> In the near future, prepare_read() will get enhanced and more
> information will be needed and then returned to callers. Thus
> netfs_io_subrequest is a reasonable candidate for holding places for all
> these information needed in the internal implementation.
>=20
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/cachefiles/io.c                | 42 +++++++++++++++++++++++++------
>  include/linux/netfs.h             |  7 ++++++
>  include/trace/events/cachefiles.h |  4 +--
>  3 files changed, 43 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
> index 000a28f46e59..6427259fcba9 100644
> --- a/fs/cachefiles/io.c
> +++ b/fs/cachefiles/io.c
> @@ -385,16 +385,11 @@ static int cachefiles_write(struct netfs_cache_reso=
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
> +static enum netfs_io_source cachefiles_do_prepare_read(struct netfs_io_s=
ubrequest *subreq,
> +						       struct netfs_cache_resources *cres,
> +						       loff_t i_size)
>  {
>  	enum cachefiles_prepare_read_trace why;
> -	struct netfs_io_request *rreq =3D subreq->rreq;
> -	struct netfs_cache_resources *cres =3D &rreq->cache_resources;
>  	struct cachefiles_object *object;
>  	struct cachefiles_cache *cache;
>  	struct fscache_cookie *cookie =3D fscache_cres_cookie(cres);
> @@ -501,6 +496,36 @@ static enum netfs_io_source cachefiles_prepare_read(=
struct netfs_io_subrequest *
>  	return ret;
>  }
> =20
> +/*
> + * Prepare a read operation, shortening it to a cached/uncached
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subr=
equest *subreq,
> +						      loff_t i_size)
> +{
> +	return cachefiles_do_prepare_read(subreq,
> +			&subreq->rreq->cache_resources, i_size);
> +}
> +
> +/*
> + * Prepare an on-demand read operation, shortening it to a cached/uncach=
ed
> + * boundary as appropriate.
> + */
> +static enum netfs_io_source cachefiles_prepare_ondemand_read(struct netf=
s_cache_resources *cres,
> +		loff_t start, size_t *_len, loff_t i_size)
> +{
> +	enum netfs_io_source source;
> +	struct netfs_io_subrequest subreq =3D {
> +		.start	=3D start,
> +		.len	=3D *_len,
> +		.flags	=3D 1 << NETFS_SREQ_ONDEMAND,
> +	};
> +

Faking up a struct like this is sort of fragile. What if we change
cachefiles_do_prepare_read to consult other fields in this structure
later?

It might be best to have cachefiles_do_prepare_read take individual
start, len, and flags values instead of doing this.


> +	source =3D cachefiles_do_prepare_read(&subreq, cres, i_size);
> +	*_len =3D subreq.len;
> +	return source;
> +}
> +
>  /*
>   * Prepare for a write to occur.
>   */
> @@ -621,6 +646,7 @@ static const struct netfs_cache_ops cachefiles_netfs_=
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
> index d8d4d73fe7b6..655d5900b8ef 100644
> --- a/include/trace/events/cachefiles.h
> +++ b/include/trace/events/cachefiles.h
> @@ -448,14 +448,14 @@ TRACE_EVENT(cachefiles_prep_read,
>  			     ),
> =20
>  	    TP_fast_assign(
> -		    __entry->rreq	=3D sreq->rreq->debug_id;
> +		    __entry->rreq	=3D sreq->rreq ? sreq->rreq->debug_id : 0;
>  		    __entry->index	=3D sreq->debug_index;
>  		    __entry->flags	=3D sreq->flags;
>  		    __entry->source	=3D source;
>  		    __entry->why	=3D why;
>  		    __entry->len	=3D sreq->len;
>  		    __entry->start	=3D sreq->start;
> -		    __entry->netfs_inode =3D sreq->rreq->inode->i_ino;
> +		    __entry->netfs_inode =3D sreq->rreq ? sreq->rreq->inode->i_ino : 0=
;
>  		    __entry->cache_inode =3D cache_inode;
>  			   ),
> =20

--=20
Jeff Layton <jlayton@kernel.org>
