Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC763974B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKZQvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Nov 2022 11:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKZQvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:51:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0F417AA1;
        Sat, 26 Nov 2022 08:51:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso5492988wms.4;
        Sat, 26 Nov 2022 08:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vN9PyBSjs8Dht8TLsEgLILbh6kQml9P6IFGITXb4rg4=;
        b=Rb4NKzfa4WmBCqDvn6BQu7ppfX+/fChWamqf/r+6hZ/4xqcj9fKuLD9VM90skg2zsn
         swh1l1apNXlUy8R3XafLunM18CgoOB5wj8H5B5ifv78KlNMnfdVDW99HBiQMZa8+kmS1
         fY+b1+C50I6UawOjkbldVt1q8FHxYWZpCkfQhsY3OpBHohmWD2BP/8knd3YKF5xGJtlG
         3KW38VF5O8k0PKP4XXip1d/3/Rt8ERS+tinYiWGmR5OJhzfeU1HYep0HOtj7YE0iqjby
         sgOfR+71/aNTAydtDuyY5R99usSd/MietjwvAYTyQo35vNHEVhfcKeh/vRzXvjLNMnNr
         D7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vN9PyBSjs8Dht8TLsEgLILbh6kQml9P6IFGITXb4rg4=;
        b=gvkdb/1wMmGiZwx4mvGiBhZqLTNSmzybo00P+BgChp72TMpvbR7GJBSYlNgAyVKv4q
         fONqjn3CQjDMns/vRNFOp9kc4KJPihQUv71d/JJgj88zBQlF1eWYP3mvs9XZtiQj6Q4P
         IHCoD/VkjJNslq3wx19xGyYuWWSjlYWu2eGpIc+I269UZezgfKdXUYXXtb8DndIpxqrG
         da3NTsRA4+QpeKdfpRMFuYWaigwzwR8WEJE2+5D1Nzc5QqtFi2J6Lw+JO8111lEsV/XM
         8z1i42+q1A0fOEFsWXa2aKxPxImoPNGDKWwPKnycvnWZgNj8NZeanRWrSDr9/YUm9vkB
         b7dw==
X-Gm-Message-State: ANoB5pkTZ+lI/nfWm5guCHWDkst0QaKasxRX8Ng+jCXmTyQ50RZj/nOX
        mrjTdfCMSHenUPxGjfqOcdY=
X-Google-Smtp-Source: AA0mqf42aznnNyKmB2Z/SjtITTKNfD9oq5uAoQWErPvzGXfi/k/L5fDRiV+qOB68p6OwRJXOntkyWA==
X-Received: by 2002:a05:600c:4e06:b0:3cf:703e:1d88 with SMTP id b6-20020a05600c4e0600b003cf703e1d88mr20930581wmq.155.1669481509252;
        Sat, 26 Nov 2022 08:51:49 -0800 (PST)
Received: from suse.localnet (host-79-55-110-244.retail.telecomitalia.it. [79.55.110.244])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003cf57329221sm14190444wms.14.2022.11.26.08.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 08:51:48 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Sat, 26 Nov 2022 17:51:47 +0100
Message-ID: <2600872.Lt9SDvczpP@suse>
In-Reply-To: <20221016150656.5803-1-fmdefrancesco@gmail.com>
References: <20221016150656.5803-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On domenica 16 ottobre 2022 17:06:56 CET Fabio M. De Francesco wrote:
> The use of kmap() and kmap_atomic() are being deprecated in favor of
> kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in fs/aio.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> fs/aio.c.
>=20
> Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.
>=20
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> I've tested with "./check -g aio". The tests in this group fail 3/26
> times, with and without my patch. Therefore, these changes don't introduce
> further errors. I'm not aware of any further tests I may run, so that
> any suggestions would be precious and much appreciated :-)
>=20
> I'm resending this patch because some recipients were missing in the
> previous submissions. In the meantime I'm also adding some more informati=
on
> in the commit message. There are no changes in the code.
>=20
>  fs/aio.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/aio.c b/fs/aio.c
> index 3c249b938632..343fea0c6d1a 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -567,7 +567,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigne=
d=20
int
> nr_events) ctx->user_id =3D ctx->mmap_base;
>  	ctx->nr_events =3D nr_events; /* trusted copy */
>=20
> -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> +	ring =3D kmap_local_page(ctx->ring_pages[0]);
>  	ring->nr =3D nr_events;	/* user copy */
>  	ring->id =3D ~0U;
>  	ring->head =3D ring->tail =3D 0;
> @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigne=
d=20
int
> nr_events) ring->compat_features =3D AIO_RING_COMPAT_FEATURES;
>  	ring->incompat_features =3D AIO_RING_INCOMPAT_FEATURES;
>  	ring->header_length =3D sizeof(struct aio_ring);
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);
>=20
>  	return 0;
> @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, struct
> mm_struct *mm) * we are protected from page migration
>  					 * changes ring_pages by -
>ring_lock.
>  					 */
> -					ring =3D kmap_atomic(ctx-
>ring_pages[0]);
> +					ring =3D kmap_local_page(ctx-
>ring_pages[0]);
>  					ring->id =3D ctx->id;
> -					kunmap_atomic(ring);
> +					kunmap_local(ring);
>  					return 0;
>  				}
>=20
> @@ -1024,9 +1024,9 @@ static void user_refill_reqs_available(struct kioctx
> *ctx) * against ctx->completed_events below will make sure we do the
>  		 * safe/right thing.
>  		 */
> -		ring =3D kmap_atomic(ctx->ring_pages[0]);
> +		ring =3D kmap_local_page(ctx->ring_pages[0]);
>  		head =3D ring->head;
> -		kunmap_atomic(ring);
> +		kunmap_local(ring);
>=20
>  		refill_reqs_available(ctx, head, ctx->tail);
>  	}
> @@ -1132,12 +1132,12 @@ static void aio_complete(struct aio_kiocb *iocb)
>  	if (++tail >=3D ctx->nr_events)
>  		tail =3D 0;
>=20
> -	ev_page =3D kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
> +	ev_page =3D kmap_local_page(ctx->ring_pages[pos /=20
AIO_EVENTS_PER_PAGE]);
>  	event =3D ev_page + pos % AIO_EVENTS_PER_PAGE;
>=20
>  	*event =3D iocb->ki_res;
>=20
> -	kunmap_atomic(ev_page);
> +	kunmap_local(ev_page);
>  	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
>=20
>  	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
> @@ -1151,10 +1151,10 @@ static void aio_complete(struct aio_kiocb *iocb)
>=20
>  	ctx->tail =3D tail;
>=20
> -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> +	ring =3D kmap_local_page(ctx->ring_pages[0]);
>  	head =3D ring->head;
>  	ring->tail =3D tail;
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);
>=20
>  	ctx->completed_events++;
> @@ -1214,10 +1214,10 @@ static long aio_read_events_ring(struct kioctx *c=
tx,
>  	mutex_lock(&ctx->ring_lock);
>=20
>  	/* Access to ->ring_pages here is protected by ctx->ring_lock. */
> -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> +	ring =3D kmap_local_page(ctx->ring_pages[0]);
>  	head =3D ring->head;
>  	tail =3D ring->tail;
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>=20
>  	/*
>  	 * Ensure that once we've read the current tail pointer, that
> @@ -1249,10 +1249,10 @@ static long aio_read_events_ring(struct kioctx *c=
tx,
>  		avail =3D min(avail, nr - ret);
>  		avail =3D min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
>=20
> -		ev =3D kmap(page);
> +		ev =3D kmap_local_page(page);
>  		copy_ret =3D copy_to_user(event + ret, ev + pos,
>  					sizeof(*ev) * avail);
> -		kunmap(page);
> +		kunmap_local(ev);
>=20
>  		if (unlikely(copy_ret)) {
>  			ret =3D -EFAULT;
> @@ -1264,9 +1264,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  		head %=3D ctx->nr_events;
>  	}
>=20
> -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> +	ring =3D kmap_local_page(ctx->ring_pages[0]);
>  	ring->head =3D head;
> -	kunmap_atomic(ring);
> +	kunmap_local(ring);
>  	flush_dcache_page(ctx->ring_pages[0]);
>=20
>  	pr_debug("%li  h%u t%u\n", ret, head, tail);
> --
> 2.36.1

Al, Benjamin,

I'm sending a gentle ping for this old patch too (and thanking Al again for=
=20
pointing me out how fs/ufs and fs/sysv conversions must be reworked and=20
mistakes fixed).

About this I've had Ira's and Jeff's "Reviewed-by:" tags. I also responded =
in=20
this thread to a couple of objections from Jeff which were regarding some=20
ambiguities in the commit message.

Please let me know if here too there are mistakes which must be fixed and c=
ode=20
to be reworked.

I'm currently just a little more than a pure hobbyist, therefore please be=
=20
patient for the time it takes because until mid February 2023 I'll only be=
=20
able to work few hours per weeks using my spare time.=20

I'm looking forward to hearing from you.

Regards,

=46abio



