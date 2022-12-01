Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9007363F2DA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 15:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiLAO3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 09:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiLAO3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:29:22 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46122A7A9F;
        Thu,  1 Dec 2022 06:29:21 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4007167wme.5;
        Thu, 01 Dec 2022 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LO8HYd4h632EoelSH71DA9q0EI9uMmpEDkXZLk2p4rg=;
        b=NL+96sIlffx6zg1RYCnRJNyHuyVFo0uBCoId+r/h6BLbjJckmOlPxEIvLMGViXnJfx
         M/B52y3zs8lEilCRQ5K0ZgfFQgSzpyWHXZc4JxXKEkcfb3jbW+NoBNydJ5vmtwRUXlXU
         IDPHJNMan9290O3XQL6kbtNYHGVeimWTTWgtDPEZr16LUEet7T8NUF78zSgfB5vqdIgS
         ILyP783+Sq6md9pLW76r+VxpCPDWu6UIumPzqoAqBMgg+RXzWwUpakbWZQZo5Ya0E8K6
         kGJ9Ih7ZqXuOL0cmDg3ayvULohpVWlJ7P5S74tNdhnN/s0eKFV8wbvZPALZDo8dwF/uJ
         S5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LO8HYd4h632EoelSH71DA9q0EI9uMmpEDkXZLk2p4rg=;
        b=MKgrtsn2eRq0gBdUcpKqURUgyCTZpd2MnesRut7FMFvyeOQkFBijRyAf6ews95av8r
         Cjlj2xQP6ola49Vs2MUgF/E/q/qZ02kn1HnfdAq/kA0CyrOc5aYDgO6ruVLM1huWHD7A
         HqIcpTSiPOPRDFufN7w88f3/UZLDhnQsUJdMn1dbpzgdRULR3ZvP0vcO3y3RxN7UCBTx
         K112G1bF6XKCUBMSevevNruR8UayXSMq2aVVJhF4NVdGgvtJOBBpBcrtbbCsGX/cPDcI
         4FeQvdzZxHV6JijsNSsALmv1wmc1rsyWKl8GX44N0zp9cbOBl8DiXI2PVaBVybLsTejN
         4uyQ==
X-Gm-Message-State: ANoB5pnpH5KBNvOXdQ57l4ERIHqAevZJhfwaVJSqPvAl7L6muSVEiscj
        x3fCc4mHhzD1Z48JQBz7Cco=
X-Google-Smtp-Source: AA0mqf5rd8rHx+AM/g2GEdExoUBA16Udgb2kplNsq78CUZEipA4C97pd141rZnkWVlkqZ56FYzZeUw==
X-Received: by 2002:a05:600c:5254:b0:3d0:75d5:c64b with SMTP id fc20-20020a05600c525400b003d075d5c64bmr5345838wmb.12.1669904959550;
        Thu, 01 Dec 2022 06:29:19 -0800 (PST)
Received: from suse.localnet (host-79-55-110-244.retail.telecomitalia.it. [79.55.110.244])
        by smtp.gmail.com with ESMTPSA id k27-20020a5d525b000000b00242269c8b8esm4493830wrc.25.2022.12.01.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 06:29:18 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Thu, 01 Dec 2022 15:29:17 +0100
Message-ID: <5882941.lOV4Wx5bFT@suse>
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
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---

I'm sorry to resend again. Last time I forgot to forward the "Reviewed-by:"=
=20
tag from Jeff (thanks!).

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




