Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128366CA0D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjC0KI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 06:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjC0KI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:08:26 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF649E5;
        Mon, 27 Mar 2023 03:08:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso4664901wmo.1;
        Mon, 27 Mar 2023 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679911702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ns8gSkJtJW5rMO78ceC2Rx9q40ENuy+LObl6UHDFr0s=;
        b=A2s+PhaodoqCLLLRJguEBx3d5jAeCOVtN7rBoBFlXu4437lLyE5qxigqlp4rG92yr1
         95tnxTkjrJRU+2curSzfyWYGqUI9PFyA+vw8bvMSo2OLtOlgcuhmqIwSkBoQn2Z3L4Oz
         bQH5pite9NsfEJGM1KMxUYko0n6Gf0/RfwC7sMZY+cozQICRQumh2MntgVQix2tSURR6
         u9ZU90VaKlX+Rleu38iP/x8C3PQgyYqAhCpUICjvzUUczbgigBTGA3rdOOJaf0Gxqu42
         +RelkfsqsxBzsuNlGOk4Df0s9hs8dQdhm5p7S2IO4XRDARLrno7uMkeQr/S8crbwaEMl
         r59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ns8gSkJtJW5rMO78ceC2Rx9q40ENuy+LObl6UHDFr0s=;
        b=VhgDudWGdKrhCwjqacLbTeAQ0b993omBtQHP/VDrFzxBBogZCq4bcnZwrJYLJqzVWG
         +x7tQBTjNCo7pPzKEc/t+twC2zjmU8mAYs4vQQyO1d4313ooJXjAKsATs+P8yLUXEDat
         2ghq4vMXRfTqnfMduJbr/Pj/DiJw0TMOxiRYl+uwZGWTDYOMQjpgoxJBzrzVbrwa0Nqw
         4B0qRQ8OfQmkFVnKsROZ1qOEYQWylWOobV0JOLXMOKJuOghA3crYo9UjXZcTLTRoznta
         To4F3QL4GWYc67uhibQE2bchJ5OQlRxD16rC8MfikeXp13v8zC1p4E63/xEwR2xTlulg
         +gCQ==
X-Gm-Message-State: AO0yUKXIE4+i+8mCnQUdy4KdwCfeIMqQ1Mos2LijgJYRR0603/Ga+MdW
        GfumjrcZ8pJbklgPzM4xm60=
X-Google-Smtp-Source: AK7set/OUvcas6A4CNBYtPhi8pDjfVzAQ9EoB/9pQmPLmbliqfY1SslWKQkt44yWgum//NbLWWwBEQ==
X-Received: by 2002:a7b:ca4a:0:b0:3ed:af6b:7fb3 with SMTP id m10-20020a7bca4a000000b003edaf6b7fb3mr9147943wml.2.1679911702205;
        Mon, 27 Mar 2023 03:08:22 -0700 (PDT)
Received: from suse.localnet (host-87-19-99-235.retail.telecomitalia.it. [87.19.99.235])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm8404891wms.41.2023.03.27.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:08:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH v3] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Mon, 27 Mar 2023 12:08:20 +0200
Message-ID: <2114426.VsPgYW4pTa@suse>
In-Reply-To: <20230119162055.20944-1-fmdefrancesco@gmail.com>
References: <20230119162055.20944-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=C3=AC 19 gennaio 2023 17:20:55 CEST Fabio M. De Francesco wrote:
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
> The use of kmap_local_page() in fs/aio.c is "safe" in the sense that the
> code don't hands the returned kernel virtual addresses to other threads
> and there are no nesting which should be handled with the stack based
> (LIFO) mappings/un-mappings order. Furthermore, the code between the old
> kmap_atomic()/kunmap_atomic() did not depend on disabling page-faults
> and/or preemption, so that there is no need to call pagefault_disable()
> and/or preempt_disable() before the mappings.
>=20
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> fs/aio.c.
>=20
> Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.
>
Hi Al,

I see that this patch is here since Jan 19, 2023.
Is there anything that prevents its merging? Am I expected to do further=20
changes? Please notice that it already had three "Reviewed-by:" tags (again=
=20
thanks to Ira, Jeff and Kent).=20

Can you please take it in your three?

Thanks,

=46abio
>=20
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> I've tested with "./check -g aio". The tests in this group fail 3/26
> times, with and without my patch. Therefore, these changes don't introduce
> further errors. I'm not aware of any other tests which I may run, so that
> any suggestions would be precious and much appreciated :-)
>=20
> I'm resending this patch because some recipients were missing in the
> previous submissions. In the meantime I'm also adding some more informati=
on
> in the commit message. There are no changes in the code.
>=20
> Changes from v1:
>         Add further information in the commit message, and the
>         "Reviewed-by" tags from Ira and Jeff (thanks!).
>=20
> Changes from v2:
> 	Rewrite a block of code between mapping/un-mapping to improve
> 	readability in aio_setup_ring() and add a missing call to
> 	flush_dcache_page() in ioctx_add_table() (thanks to Al Viro);
> 	Add a "Reviewed-by" tag from Kent Overstreet (thanks).
>=20
>  fs/aio.c | 46 +++++++++++++++++++++-------------------------
>  1 file changed, 21 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/aio.c b/fs/aio.c
> index 562916d85cba..9b39063dc7ac 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -486,7 +486,6 @@ static const struct address_space_operations=20
aio_ctx_aops
> =3D {
>=20
>  static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
>  {
> -	struct aio_ring *ring;
>  	struct mm_struct *mm =3D current->mm;
>  	unsigned long size, unused;
>  	int nr_pages;
> @@ -567,16 +566,12 @@ static int aio_setup_ring(struct kioctx *ctx, unsig=
ned
> int nr_events) ctx->user_id =3D ctx->mmap_base;
>  	ctx->nr_events =3D nr_events; /* trusted copy */
>=20
> -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> -	ring->nr =3D nr_events;	/* user copy */
> -	ring->id =3D ~0U;
> -	ring->head =3D ring->tail =3D 0;
> -	ring->magic =3D AIO_RING_MAGIC;
> -	ring->compat_features =3D AIO_RING_COMPAT_FEATURES;
> -	ring->incompat_features =3D AIO_RING_INCOMPAT_FEATURES;
> -	ring->header_length =3D sizeof(struct aio_ring);
> -	kunmap_atomic(ring);
> -	flush_dcache_page(ctx->ring_pages[0]);
> +	memcpy_to_page(ctx->ring_pages[0], 0, (const char *)&(struct=20
aio_ring) {
> +		       .nr =3D nr_events, .id =3D ~0U, .magic =3D=20
AIO_RING_MAGIC,
> +		       .compat_features =3D AIO_RING_COMPAT_FEATURES,
> +		       .incompat_features =3D AIO_RING_INCOMPAT_FEATURES,
> +		       .header_length =3D sizeof(struct aio_ring) },
> +		       sizeof(struct aio_ring));
>=20
>  	return 0;
>  }
> @@ -678,9 +673,10 @@ static int ioctx_add_table(struct kioctx *ctx, struct
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
> +					flush_dcache_page(ctx-
>ring_pages[0]);
>  					return 0;
>  				}
>=20
> @@ -1021,9 +1017,9 @@ static void user_refill_reqs_available(struct kioctx
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
> @@ -1129,12 +1125,12 @@ static void aio_complete(struct aio_kiocb *iocb)
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
> @@ -1148,10 +1144,10 @@ static void aio_complete(struct aio_kiocb *iocb)
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
> @@ -1211,10 +1207,10 @@ static long aio_read_events_ring(struct kioctx *c=
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
> @@ -1246,10 +1242,10 @@ static long aio_read_events_ring(struct kioctx *c=
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
> @@ -1261,9 +1257,9 @@ static long aio_read_events_ring(struct kioctx *ctx,
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
> 2.39.0




