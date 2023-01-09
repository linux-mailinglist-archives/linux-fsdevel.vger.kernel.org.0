Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15807662E8B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 19:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjAISRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 13:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbjAISQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:16:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549EC676DF;
        Mon,  9 Jan 2023 10:12:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so4950083wma.1;
        Mon, 09 Jan 2023 10:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP681VH/DRNmhcZCYHTHRmQgpSCO53ttRPG7agMVOk4=;
        b=UyCykFurxMOCPMVOSevkcLMvkVU04JiVBggv99OoG2lMYVTKA9/Yc4ccveSyVTQDSj
         7o5WxgAbPB7pETSKiUKkxL3mKy8AWuX+DTRe5yIxrr2666h05mJz09nFtPTaSipWYUP3
         6A4ipjBve2ICQaE1RSjDpMX8QH8XxVvZUkqq0KdCfXVYOsoDOVxsF/ZURzHCm/Q0gAAH
         6qMUEDCrk6c+SGIkMWdbe2Sq36D1d9QD+KtChIF+KyL9qRQRwL21KsRqG3xUOAjy7Aqr
         xeMwRWXgwu8Hw49lHdeH7pN2U1g4288U5J4xubAhymyi0MuziF2TN6mlqUnXFaCeEtcn
         fxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP681VH/DRNmhcZCYHTHRmQgpSCO53ttRPG7agMVOk4=;
        b=PDhrcg/Xdfda8QNznAqq7PrW1lYXgCTaHX12D7k4zEDsKGc6YBi1q5VCMrjf/lC5ZK
         EYdvrzcVH3SdRdyAHRUv4YcekdbJGwGd8vjwGwPKyMgJJtYVtL2JkOmAKxUxIJZFiHfO
         SbSAjMjZ+SWQwM2rPTr6rEBiIOG+A9+/Oq3UbHcs0TYnvwOPlj9nYksr/HXus0zMmMyu
         eyNRV6sU8BxitIHIOhhw/DQ2o0Q1dMZuLKShwIKJlwMAop5sXV24wTLCtu+RyOr/XF6I
         Og+zzoSTtZ9enRk1lZUdxUECjRouPRDt0JS8UkUT/AM9WPv+5i2iIGjeM6niVWJRwfM6
         QgIw==
X-Gm-Message-State: AFqh2kp+zq3nEUuIwC2Bqt7ww3jPrMB+CSr+8wWW9vWR+Se0fc9P6XtF
        oncL8IAXyN+PMvlkpiBJhKk=
X-Google-Smtp-Source: AMrXdXvdIf2dvwj8nk4q2bim5WRRzYWnCruchi7dBMSuj1arkemgUZgqH26xk1ZjaPll3iBcSuT43w==
X-Received: by 2002:a05:600c:3485:b0:3d1:ee6c:f897 with SMTP id a5-20020a05600c348500b003d1ee6cf897mr47341850wmq.3.1673287945273;
        Mon, 09 Jan 2023 10:12:25 -0800 (PST)
Received: from suse.localnet (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id f15-20020a7bcd0f000000b003d9a71ee54dsm11930914wmj.36.2023.01.09.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:12:24 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RESEND PATCH] fs/aio: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Mon, 09 Jan 2023 19:12:23 +0100
Message-ID: <2131868.irdbgypaU6@suse>
In-Reply-To: <5882941.lOV4Wx5bFT@suse>
References: <20221016150656.5803-1-fmdefrancesco@gmail.com> <5882941.lOV4Wx5bFT@suse>
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

On gioved=C3=AC 1 dicembre 2022 15:29:17 CET Fabio M. De Francesco wrote:
> On domenica 16 ottobre 2022 17:06:56 CET Fabio M. De Francesco wrote:
> > The use of kmap() and kmap_atomic() are being deprecated in favor of
> > kmap_local_page().
> >=20
> > There are two main problems with kmap(): (1) It comes with an overhead =
as
> > the mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when t=
he
> > kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> > utilized until a slot becomes available.
> >=20
> > With kmap_local_page() the mappings are per thread, CPU local, can take
> > page faults, and can be called from any context (including interrupts).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> > the tasks can be preempted and, when they are scheduled to run again, t=
he
> > kernel virtual addresses are restored and still valid.
> >=20
> > Since its use in fs/aio.c is safe everywhere, it should be preferred.
> >=20
> > Therefore, replace kmap() and kmap_atomic() with kmap_local_page() in
> > fs/aio.c.
> >=20
> > Tested with xfstests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> > with HIGHMEM64GB enabled.
> >=20
> > Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>=20
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
>=20
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
>=20
> I'm sorry to resend again. Last time I forgot to forward the "Reviewed-by=
:"
> tag from Jeff (thanks!).
>=20
> > I've tested with "./check -g aio". The tests in this group fail 3/26
> > times, with and without my patch. Therefore, these changes don't introd=
uce
> > further errors. I'm not aware of any further tests I may run, so that
> > any suggestions would be precious and much appreciated :-)
> >=20
> > I'm resending this patch because some recipients were missing in the
> > previous submissions. In the meantime I'm also adding some more=20
information
> > in the commit message. There are no changes in the code.
> >=20
> >  fs/aio.c | 32 ++++++++++++++++----------------
> >  1 file changed, 16 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/fs/aio.c b/fs/aio.c
> > index 3c249b938632..343fea0c6d1a 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -567,7 +567,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsig=
ned
>=20
> int
>=20
> > nr_events) ctx->user_id =3D ctx->mmap_base;
> >=20
> >  	ctx->nr_events =3D nr_events; /* trusted copy */
> >=20
> > -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> > +	ring =3D kmap_local_page(ctx->ring_pages[0]);
> >=20
> >  	ring->nr =3D nr_events;	/* user copy */
> >  	ring->id =3D ~0U;
> >  	ring->head =3D ring->tail =3D 0;
> >=20
> > @@ -575,7 +575,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsig=
ned
>=20
> int
>=20
> > nr_events) ring->compat_features =3D AIO_RING_COMPAT_FEATURES;
> >=20
> >  	ring->incompat_features =3D AIO_RING_INCOMPAT_FEATURES;
> >  	ring->header_length =3D sizeof(struct aio_ring);
> >=20
> > -	kunmap_atomic(ring);
> > +	kunmap_local(ring);
> >=20
> >  	flush_dcache_page(ctx->ring_pages[0]);
> >  =09
> >  	return 0;
> >=20
> > @@ -678,9 +678,9 @@ static int ioctx_add_table(struct kioctx *ctx, stru=
ct
> > mm_struct *mm) * we are protected from page migration
> >=20
> >  					 * changes ring_pages by -
> >
> >ring_lock.
> >
> >  					 */
> >=20
> > -					ring =3D kmap_atomic(ctx-
> >
> >ring_pages[0]);
> >
> > +					ring =3D kmap_local_page(ctx-
> >
> >ring_pages[0]);
> >
> >  					ring->id =3D ctx->id;
> >=20
> > -					kunmap_atomic(ring);
> > +					kunmap_local(ring);
> >=20
> >  					return 0;
> >  			=09
> >  				}
> >=20
> > @@ -1024,9 +1024,9 @@ static void user_refill_reqs_available(struct kio=
ctx
> > *ctx) * against ctx->completed_events below will make sure we do the
> >=20
> >  		 * safe/right thing.
> >  		 */
> >=20
> > -		ring =3D kmap_atomic(ctx->ring_pages[0]);
> > +		ring =3D kmap_local_page(ctx->ring_pages[0]);
> >=20
> >  		head =3D ring->head;
> >=20
> > -		kunmap_atomic(ring);
> > +		kunmap_local(ring);
> >=20
> >  		refill_reqs_available(ctx, head, ctx->tail);
> >  =09
> >  	}
> >=20
> > @@ -1132,12 +1132,12 @@ static void aio_complete(struct aio_kiocb *iocb)
> >=20
> >  	if (++tail >=3D ctx->nr_events)
> >  =09
> >  		tail =3D 0;
> >=20
> > -	ev_page =3D kmap_atomic(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
> > +	ev_page =3D kmap_local_page(ctx->ring_pages[pos /
>=20
> AIO_EVENTS_PER_PAGE]);
>=20
> >  	event =3D ev_page + pos % AIO_EVENTS_PER_PAGE;
> >  =09
> >  	*event =3D iocb->ki_res;
> >=20
> > -	kunmap_atomic(ev_page);
> > +	kunmap_local(ev_page);
> >=20
> >  	flush_dcache_page(ctx->ring_pages[pos / AIO_EVENTS_PER_PAGE]);
> >  =09
> >  	pr_debug("%p[%u]: %p: %p %Lx %Lx %Lx\n", ctx, tail, iocb,
> >=20
> > @@ -1151,10 +1151,10 @@ static void aio_complete(struct aio_kiocb *iocb)
> >=20
> >  	ctx->tail =3D tail;
> >=20
> > -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> > +	ring =3D kmap_local_page(ctx->ring_pages[0]);
> >=20
> >  	head =3D ring->head;
> >  	ring->tail =3D tail;
> >=20
> > -	kunmap_atomic(ring);
> > +	kunmap_local(ring);
> >=20
> >  	flush_dcache_page(ctx->ring_pages[0]);
> >  =09
> >  	ctx->completed_events++;
> >=20
> > @@ -1214,10 +1214,10 @@ static long aio_read_events_ring(struct kioctx=
=20
*ctx,
> >=20
> >  	mutex_lock(&ctx->ring_lock);
> >  =09
> >  	/* Access to ->ring_pages here is protected by ctx->ring_lock. */
> >=20
> > -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> > +	ring =3D kmap_local_page(ctx->ring_pages[0]);
> >=20
> >  	head =3D ring->head;
> >  	tail =3D ring->tail;
> >=20
> > -	kunmap_atomic(ring);
> > +	kunmap_local(ring);
> >=20
> >  	/*
> >  =09
> >  	 * Ensure that once we've read the current tail pointer, that
> >=20
> > @@ -1249,10 +1249,10 @@ static long aio_read_events_ring(struct kioctx=
=20
*ctx,
> >=20
> >  		avail =3D min(avail, nr - ret);
> >  		avail =3D min_t(long, avail, AIO_EVENTS_PER_PAGE - pos);
> >=20
> > -		ev =3D kmap(page);
> > +		ev =3D kmap_local_page(page);
> >=20
> >  		copy_ret =3D copy_to_user(event + ret, ev + pos,
> >  	=09
> >  					sizeof(*ev) * avail);
> >=20
> > -		kunmap(page);
> > +		kunmap_local(ev);
> >=20
> >  		if (unlikely(copy_ret)) {
> >  	=09
> >  			ret =3D -EFAULT;
> >=20
> > @@ -1264,9 +1264,9 @@ static long aio_read_events_ring(struct kioctx *c=
tx,
> >=20
> >  		head %=3D ctx->nr_events;
> >  =09
> >  	}
> >=20
> > -	ring =3D kmap_atomic(ctx->ring_pages[0]);
> > +	ring =3D kmap_local_page(ctx->ring_pages[0]);
> >=20
> >  	ring->head =3D head;
> >=20
> > -	kunmap_atomic(ring);
> > +	kunmap_local(ring);
> >=20
> >  	flush_dcache_page(ctx->ring_pages[0]);
> >  =09
> >  	pr_debug("%li  h%u t%u\n", ret, head, tail);
> >=20
> > --
> > 2.36.1

Please disregard this patch because I just sent a v2 with some additional=20
information in the commit message and added Jeff's "Reviewed-by" tag.

Thanks,

=46abio

[1] https://lore.kernel.org/lkml/20230109175629.9482-1-fmdefrancesco@gmail.=
com/



