Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2EF55C73C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345640AbiF1MOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbiF1MOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62B7237FA
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E1160F97
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085C3C3411D;
        Tue, 28 Jun 2022 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418441;
        bh=OGHSNCYqpTewrv01Tuvh/bnKT3des/g6iWsRj+QrRqk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Zv5tF+wfawsXzICsPKsBxWcPNvzloYU/nPP+DZUcfZewv3pKFyLbN6E6GUY6gz8XK
         /bycg9P7SyGFlXSIoqfc/YRZZTCPreHEi7WaAwPTKBQxV42QZYNdj9/KJDb4dfWo3Y
         qC1yE0yYYG24LSiVl6kzJSoBx1Yt0ST10ymIAaD1JgYGtwrM8ZmGViHEv4oCsnRkgM
         lJxTkq7ciGpohy9yAWEy379mIewQRbq6LKj2qCyL3uIyX3jkdilewousudZFCOLodJ
         2afYV7KU18Y2HaH6KVh9A/kWIzwWJLKcjclTFMy377KiNhg40M5dZ3zHXzxDge1/G/
         NwnW9sIn+KIwA==
Message-ID: <faada52980b8581257639ea1ef033a8b01896546.camel@kernel.org>
Subject: Re: [PATCH 36/44] iov_iter: advancing variants of
 iov_iter_get_pages{,_alloc}()
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:13:59 -0400
In-Reply-To: <20220622041552.737754-36-viro@zeniv.linux.org.uk>
References: <YrKWRCOOWXPHRCKg@ZenIV>
         <20220622041552.737754-1-viro@zeniv.linux.org.uk>
         <20220622041552.737754-36-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-06-22 at 05:15 +0100, Al Viro wrote:
> Most of the users immediately follow successful iov_iter_get_pages()
> with advancing by the amount it had returned.
>=20
> Provide inline wrappers doing that, convert trivial open-coded
> uses of those.
>=20
> BTW, iov_iter_get_pages() never returns more than it had been asked
> to; such checks in cifs ought to be removed someday...
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/vhost/scsi.c |  4 +---
>  fs/ceph/file.c       |  3 +--
>  fs/cifs/file.c       |  6 ++----
>  fs/cifs/misc.c       |  3 +--
>  fs/direct-io.c       |  3 +--
>  fs/fuse/dev.c        |  3 +--
>  fs/fuse/file.c       |  3 +--
>  fs/nfs/direct.c      |  6 ++----
>  include/linux/uio.h  | 20 ++++++++++++++++++++
>  net/core/datagram.c  |  3 +--
>  net/core/skmsg.c     |  3 +--
>  net/rds/message.c    |  3 +--
>  net/tls/tls_sw.c     |  4 +---
>  13 files changed, 34 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index ffd9e6c2ffc1..9b65509424dc 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -643,14 +643,12 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
>  	size_t offset;
>  	unsigned int npages =3D 0;
> =20
> -	bytes =3D iov_iter_get_pages(iter, pages, LONG_MAX,
> +	bytes =3D iov_iter_get_pages2(iter, pages, LONG_MAX,
>  				VHOST_SCSI_PREALLOC_UPAGES, &offset);
>  	/* No pages were pinned */
>  	if (bytes <=3D 0)
>  		return bytes < 0 ? bytes : -EFAULT;
> =20
> -	iov_iter_advance(iter, bytes);
> -
>  	while (bytes) {
>  		unsigned n =3D min_t(unsigned, PAGE_SIZE - offset, bytes);
>  		sg_set_page(sg++, pages[npages++], n, offset);
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index c535de5852bf..8fab5db16c73 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -95,12 +95,11 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter=
, size_t maxsize,
>  		size_t start;
>  		int idx =3D 0;
> =20
> -		bytes =3D iov_iter_get_pages(iter, pages, maxsize - size,
> +		bytes =3D iov_iter_get_pages2(iter, pages, maxsize - size,
>  					   ITER_GET_BVECS_PAGES, &start);
>  		if (bytes < 0)
>  			return size ?: bytes;
> =20
> -		iov_iter_advance(iter, bytes);
>  		size +=3D bytes;
> =20
>  		for ( ; bytes; idx++, bvec_idx++) {
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index e1e05b253daa..3ba013e2987f 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -3022,7 +3022,7 @@ cifs_write_from_iter(loff_t offset, size_t len, str=
uct iov_iter *from,
>  		if (ctx->direct_io) {
>  			ssize_t result;
> =20
> -			result =3D iov_iter_get_pages_alloc(
> +			result =3D iov_iter_get_pages_alloc2(
>  				from, &pagevec, cur_len, &start);
>  			if (result < 0) {
>  				cifs_dbg(VFS,
> @@ -3036,7 +3036,6 @@ cifs_write_from_iter(loff_t offset, size_t len, str=
uct iov_iter *from,
>  				break;
>  			}
>  			cur_len =3D (size_t)result;
> -			iov_iter_advance(from, cur_len);
> =20
>  			nr_pages =3D
>  				(cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
> @@ -3758,7 +3757,7 @@ cifs_send_async_read(loff_t offset, size_t len, str=
uct cifsFileInfo *open_file,
>  		if (ctx->direct_io) {
>  			ssize_t result;
> =20
> -			result =3D iov_iter_get_pages_alloc(
> +			result =3D iov_iter_get_pages_alloc2(
>  					&direct_iov, &pagevec,
>  					cur_len, &start);
>  			if (result < 0) {
> @@ -3774,7 +3773,6 @@ cifs_send_async_read(loff_t offset, size_t len, str=
uct cifsFileInfo *open_file,
>  				break;
>  			}
>  			cur_len =3D (size_t)result;
> -			iov_iter_advance(&direct_iov, cur_len);
> =20
>  			rdata =3D cifs_readdata_direct_alloc(
>  					pagevec, cifs_uncached_readv_complete);
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index c69e1240d730..37493118fb72 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -1022,7 +1022,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct=
 iov_iter *iter, int rw)
>  	saved_len =3D count;
> =20
>  	while (count && npages < max_pages) {
> -		rc =3D iov_iter_get_pages(iter, pages, count, max_pages, &start);
> +		rc =3D iov_iter_get_pages2(iter, pages, count, max_pages, &start);
>  		if (rc < 0) {
>  			cifs_dbg(VFS, "Couldn't get user pages (rc=3D%zd)\n", rc);
>  			break;
> @@ -1034,7 +1034,6 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct=
 iov_iter *iter, int rw)
>  			break;
>  		}
> =20
> -		iov_iter_advance(iter, rc);
>  		count -=3D rc;
>  		rc +=3D start;
>  		cur_npages =3D DIV_ROUND_UP(rc, PAGE_SIZE);
> diff --git a/fs/direct-io.c b/fs/direct-io.c
> index 72237f49ad94..9724244f12ce 100644
> --- a/fs/direct-io.c
> +++ b/fs/direct-io.c
> @@ -169,7 +169,7 @@ static inline int dio_refill_pages(struct dio *dio, s=
truct dio_submit *sdio)
>  {
>  	ssize_t ret;
> =20
> -	ret =3D iov_iter_get_pages(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES,
> +	ret =3D iov_iter_get_pages2(sdio->iter, dio->pages, LONG_MAX, DIO_PAGES=
,
>  				&sdio->from);
> =20
>  	if (ret < 0 && sdio->blocks_available && (dio->op =3D=3D REQ_OP_WRITE))=
 {
> @@ -191,7 +191,6 @@ static inline int dio_refill_pages(struct dio *dio, s=
truct dio_submit *sdio)
>  	}
> =20
>  	if (ret >=3D 0) {
> -		iov_iter_advance(sdio->iter, ret);
>  		ret +=3D sdio->from;
>  		sdio->head =3D 0;
>  		sdio->tail =3D (ret + PAGE_SIZE - 1) / PAGE_SIZE;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 8d657c2cd6f7..51897427a534 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -730,14 +730,13 @@ static int fuse_copy_fill(struct fuse_copy_state *c=
s)
>  		}
>  	} else {
>  		size_t off;
> -		err =3D iov_iter_get_pages(cs->iter, &page, PAGE_SIZE, 1, &off);
> +		err =3D iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
>  		if (err < 0)
>  			return err;
>  		BUG_ON(!err);
>  		cs->len =3D err;
>  		cs->offset =3D off;
>  		cs->pg =3D page;
> -		iov_iter_advance(cs->iter, err);
>  	}
> =20
>  	return lock_request(cs->req);
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c982e3afe3b4..69e19fc0afc1 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1401,14 +1401,13 @@ static int fuse_get_user_pages(struct fuse_args_p=
ages *ap, struct iov_iter *ii,
>  	while (nbytes < *nbytesp && ap->num_pages < max_pages) {
>  		unsigned npages;
>  		size_t start;
> -		ret =3D iov_iter_get_pages(ii, &ap->pages[ap->num_pages],
> +		ret =3D iov_iter_get_pages2(ii, &ap->pages[ap->num_pages],
>  					*nbytesp - nbytes,
>  					max_pages - ap->num_pages,
>  					&start);
>  		if (ret < 0)
>  			break;
> =20
> -		iov_iter_advance(ii, ret);
>  		nbytes +=3D ret;
> =20
>  		ret +=3D start;
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 022e1ce63e62..c275c83f0aef 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -364,13 +364,12 @@ static ssize_t nfs_direct_read_schedule_iovec(struc=
t nfs_direct_req *dreq,
>  		size_t pgbase;
>  		unsigned npages, i;
> =20
> -		result =3D iov_iter_get_pages_alloc(iter, &pagevec,=20
> +		result =3D iov_iter_get_pages_alloc2(iter, &pagevec,
>  						  rsize, &pgbase);
>  		if (result < 0)
>  			break;
>  =09
>  		bytes =3D result;
> -		iov_iter_advance(iter, bytes);
>  		npages =3D (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
>  		for (i =3D 0; i < npages; i++) {
>  			struct nfs_page *req;
> @@ -812,13 +811,12 @@ static ssize_t nfs_direct_write_schedule_iovec(stru=
ct nfs_direct_req *dreq,
>  		size_t pgbase;
>  		unsigned npages, i;
> =20
> -		result =3D iov_iter_get_pages_alloc(iter, &pagevec,=20
> +		result =3D iov_iter_get_pages_alloc2(iter, &pagevec,
>  						  wsize, &pgbase);
>  		if (result < 0)
>  			break;
> =20
>  		bytes =3D result;
> -		iov_iter_advance(iter, bytes);
>  		npages =3D (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
>  		for (i =3D 0; i < npages; i++) {
>  			struct nfs_page *req;
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index d3e13b37ea72..ab1cc218b9de 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -349,4 +349,24 @@ static inline void iov_iter_ubuf(struct iov_iter *i,=
 unsigned int direction,
>  	};
>  }
> =20
> +static inline ssize_t iov_iter_get_pages2(struct iov_iter *i, struct pag=
e **pages,
> +			size_t maxsize, unsigned maxpages, size_t *start)
> +{
> +	ssize_t res =3D iov_iter_get_pages(i, pages, maxsize, maxpages, start);
> +
> +	if (res >=3D 0)
> +		iov_iter_advance(i, res);
> +	return res;
> +}
> +
> +static inline ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, stru=
ct page ***pages,
> +			size_t maxsize, size_t *start)
> +{
> +	ssize_t res =3D iov_iter_get_pages_alloc(i, pages, maxsize, start);
> +
> +	if (res >=3D 0)
> +		iov_iter_advance(i, res);
> +	return res;
> +}
> +
>  #endif
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 50f4faeea76c..344b4c5791ac 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -629,12 +629,11 @@ int __zerocopy_sg_from_iter(struct sock *sk, struct=
 sk_buff *skb,
>  		if (frag =3D=3D MAX_SKB_FRAGS)
>  			return -EMSGSIZE;
> =20
> -		copied =3D iov_iter_get_pages(from, pages, length,
> +		copied =3D iov_iter_get_pages2(from, pages, length,
>  					    MAX_SKB_FRAGS - frag, &start);
>  		if (copied < 0)
>  			return -EFAULT;
> =20
> -		iov_iter_advance(from, copied);
>  		length -=3D copied;
> =20
>  		truesize =3D PAGE_ALIGN(copied + start);
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 22b983ade0e7..662151678f20 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -324,14 +324,13 @@ int sk_msg_zerocopy_from_iter(struct sock *sk, stru=
ct iov_iter *from,
>  			goto out;
>  		}
> =20
> -		copied =3D iov_iter_get_pages(from, pages, bytes, maxpages,
> +		copied =3D iov_iter_get_pages2(from, pages, bytes, maxpages,
>  					    &offset);
>  		if (copied <=3D 0) {
>  			ret =3D -EFAULT;
>  			goto out;
>  		}
> =20
> -		iov_iter_advance(from, copied);
>  		bytes -=3D copied;
>  		msg->sg.size +=3D copied;
> =20
> diff --git a/net/rds/message.c b/net/rds/message.c
> index 799034e0f513..d74be4e3f3fa 100644
> --- a/net/rds/message.c
> +++ b/net/rds/message.c
> @@ -391,7 +391,7 @@ static int rds_message_zcopy_from_user(struct rds_mes=
sage *rm, struct iov_iter *
>  		size_t start;
>  		ssize_t copied;
> =20
> -		copied =3D iov_iter_get_pages(from, &pages, PAGE_SIZE,
> +		copied =3D iov_iter_get_pages2(from, &pages, PAGE_SIZE,
>  					    1, &start);
>  		if (copied < 0) {
>  			struct mmpin *mmp;
> @@ -405,7 +405,6 @@ static int rds_message_zcopy_from_user(struct rds_mes=
sage *rm, struct iov_iter *
>  			goto err;
>  		}
>  		total_copied +=3D copied;
> -		iov_iter_advance(from, copied);
>  		length -=3D copied;
>  		sg_set_page(sg, pages, copied, start);
>  		rm->data.op_nents++;
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 0513f82b8537..b1406c60f8df 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1361,7 +1361,7 @@ static int tls_setup_from_iter(struct iov_iter *fro=
m,
>  			rc =3D -EFAULT;
>  			goto out;
>  		}
> -		copied =3D iov_iter_get_pages(from, pages,
> +		copied =3D iov_iter_get_pages2(from, pages,
>  					    length,
>  					    maxpages, &offset);
>  		if (copied <=3D 0) {
> @@ -1369,8 +1369,6 @@ static int tls_setup_from_iter(struct iov_iter *fro=
m,
>  			goto out;
>  		}
> =20
> -		iov_iter_advance(from, copied);
> -
>  		length -=3D copied;
>  		size +=3D copied;
>  		while (copied) {

Reviewed-by: Jeff Layton <jlayton@kernel.org>
