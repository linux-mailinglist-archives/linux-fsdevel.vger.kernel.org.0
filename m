Return-Path: <linux-fsdevel+bounces-32632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C9D9ABAC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DE8B2245B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C71C2BD;
	Wed, 23 Oct 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1z/jJ5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780F20322
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644830; cv=none; b=JxG6nvXMoyupof2xy/bmrVKudNKYt+NkppQfjxuF0fD7sbQR5tjAMRJkMvFg8WLDdvLiB6SZiSQTKZHDKrdf0VZkJsvN2eBIAjj5NS9Qj1B+gCPQo4FFhztxAY5iSfO70CWEix/fQLN9nmGTvkkxyJ+E2/3dV67Ln+p5UV8su9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644830; c=relaxed/simple;
	bh=58G2ffkSWBtuGCrPtZed+KWSwSI10CYKhO2VL0MVVxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIIVFJruEfEhYBQG7lvteNZ9mQlNGUn7n4keAoUKk7oAyTFxK+x62i07Jmj7lM/aTMo8ZvdnyzBmKJVlPns0FC9vuygG3lHIESfdFpYNHnEisMa/yqxwpi8lBMFydecI/sWfN5m+MUkO/X4Zl68voOtP1ohrS2JGkxrbQXODDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1z/jJ5q; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a850270e2so619740466b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729644827; x=1730249627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elKEUgYOBb9hlnUkKA6N1hOgZ0Y3H2ei9uKOJEOK+EY=;
        b=U1z/jJ5q2zmUM6X9uFO23lJiy78lUCia61l9JRZitEbRvCtZX8nxyd1/d1qW48JuW7
         AYZNtcRVPe8veUFIFkw42pH8bngQhXuHfrPb9yaVKTJ7+DBno68dtB6cOSoG6POAXwbV
         Nd7qpc3E/J/3j6b2WPYNekLbHNvfzeAb7Nya58zyml3aDsejPIDx7DmkgsnQ+Q5HI6or
         6Mhs5R961dLhHkvG18uSYKElMrNbCAwqEZQOxV8F9UHPvcF4hL8tNWQttLsnM8A3RT/6
         8x1+DuKX4hgcrgXpHuNKvTHWVDUDc0pLihsZwEKgLM+lTOcHZj3ykmyMsRd8NeIyXi1Y
         ka+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644827; x=1730249627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elKEUgYOBb9hlnUkKA6N1hOgZ0Y3H2ei9uKOJEOK+EY=;
        b=HhVpRiHU8DM0Bx+MpJId+LsHlGOod3q7y1WlvOjmQ7BlP5rSF5HXBm6ifyt1p/znrJ
         zopKxU3PdCjxjOD67oNEvXgFLhphL8Z88DSbnlvAfrLbHPJTbby2MPj0TsTcI0rVA3Zy
         wOyBt9TQtN52QwbE/9hxsTv0WKAXBJOmrOZw+F83qZ5MGCx5wRlwMkJnW8QFCkUf1eZs
         4T3L3IhxFQEy7vj0vwdwzC+6KLvueEwiRF58xa2qZ0c7EjDCpQQfuOvuHdh+cALa0Fke
         WSYbmCWbDEgi9/2zw2RMFPBZ2OBdXt5cPwGPfXePmKIHZtjjPboyn2N5+lA1VU5TnNm8
         MDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEcqpMPyIFZGgTXcPsL0jnPFqRUftFG7AVrY5TPMGfRt8k38b4MiTeaPT2dZgvNjOucx1zt6uMOF+eWsp1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0GVmd/kPDMi5bGSlCrUh0StmBc4oGIUmjeSMvVk4FMUo1P/q/
	gI9+LAlJbUk3wwbanQopsVHu7iMVdWo5pcSwetwFhQZMy1BTzL99OTHG/0ugAt8gVv9bj0Jk3Zk
	4mfonp7sgnx7r9itxQ74Y51Wwi86sT+gAnzKe
X-Google-Smtp-Source: AGHT+IFvb4nuTDqZSgOQT/PkUifYMSJP87uSJMegevloYuQ+XMxD6rU7IQjfW1EjkbdiLAZ2EDHqJEJt3TT9St/pBug=
X-Received: by 2002:a17:907:86a1:b0:a9a:5b8d:68ad with SMTP id
 a640c23a62f3a-a9abf94da9emr60511966b.48.1729644826990; Tue, 22 Oct 2024
 17:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com> <20241018064101.336232-12-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241018064101.336232-12-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 17:53:11 -0700
Message-ID: <CAJD7tkZnEp98A+bP4N8GvFn=vT5Ck4NgrqsFQn+V8gpSbyAzkg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 11/13] mm: swap: Add IAA batch compression API swap_crypto_acomp_compress_batch().
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, clabbe@baylibre.com, 
	ardb@kernel.org, ebiggers@google.com, surenb@google.com, 
	kristen.c.accardi@intel.com, zanussi@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, mcgrof@kernel.org, kees@kernel.org, 
	joel.granados@kernel.org, bfoster@redhat.com, willy@infradead.org, 
	linux-fsdevel@vger.kernel.org, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:41=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added a new API swap_crypto_acomp_compress_batch() that does batch
> compression. A system that has Intel IAA can avail of this API to submit =
a
> batch of compress jobs for parallel compression in the hardware, to impro=
ve
> performance. On a system without IAA, this API will process each compress
> job sequentially.
>
> The purpose of this API is to be invocable from any swap module that need=
s
> to compress large folios, or a batch of pages in the general case. For
> instance, zswap would batch compress up to SWAP_CRYPTO_SUB_BATCH_SIZE
> (i.e. 8 if the system has IAA) pages in the large folio in parallel to
> improve zswap_store() performance.
>
> Towards this eventual goal:
>
> 1) The definition of "struct crypto_acomp_ctx" is moved to mm/swap.h
>    so that mm modules like swap_state.c and zswap.c can reference it.
> 2) The swap_crypto_acomp_compress_batch() interface is implemented in
>    swap_state.c.
>
> It would be preferable for "struct crypto_acomp_ctx" to be defined in,
> and for swap_crypto_acomp_compress_batch() to be exported via
> include/linux/swap.h so that modules outside mm (for e.g. zram) can
> potentially use the API for batch compressions with IAA. I would
> appreciate RFC comments on this.

Same question as the last patch, why does this need to be in the swap
code? Why can't zswap just submit a single request to compress a large
folio or a range of contiguous subpages at once?

>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/swap.h       |  45 +++++++++++++++++++
>  mm/swap_state.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/zswap.c      |   9 ----
>  3 files changed, 160 insertions(+), 9 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 566616c971d4..4dcb67e2cc33 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -7,6 +7,7 @@ struct mempolicy;
>  #ifdef CONFIG_SWAP
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
> +#include <linux/crypto.h>
>
>  /*
>   * For IAA compression batching:
> @@ -19,6 +20,39 @@ struct mempolicy;
>  #define SWAP_CRYPTO_SUB_BATCH_SIZE 1UL
>  #endif
>
> +/* linux/mm/swap_state.c, zswap.c */
> +struct crypto_acomp_ctx {
> +       struct crypto_acomp *acomp;
> +       struct acomp_req *req[SWAP_CRYPTO_SUB_BATCH_SIZE];
> +       u8 *buffer[SWAP_CRYPTO_SUB_BATCH_SIZE];
> +       struct crypto_wait wait;
> +       struct mutex mutex;
> +       bool is_sleepable;
> +};
> +
> +/**
> + * This API provides IAA compress batching functionality for use by swap
> + * modules.
> + * The acomp_ctx mutex should be locked/unlocked before/after calling th=
is
> + * procedure.
> + *
> + * @pages: Pages to be compressed.
> + * @dsts: Pre-allocated destination buffers to store results of IAA comp=
ression.
> + * @dlens: Will contain the compressed lengths.
> + * @errors: Will contain a 0 if the page was successfully compressed, or=
 a
> + *          non-0 error value to be processed by the calling function.
> + * @nr_pages: The number of pages, up to SWAP_CRYPTO_SUB_BATCH_SIZE,
> + *            to be compressed.
> + * @acomp_ctx: The acomp context for iaa_crypto/other compressor.
> + */
> +void swap_crypto_acomp_compress_batch(
> +       struct page *pages[],
> +       u8 *dsts[],
> +       unsigned int dlens[],
> +       int errors[],
> +       int nr_pages,
> +       struct crypto_acomp_ctx *acomp_ctx);
> +
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);
>  struct swap_iocb;
> @@ -119,6 +153,17 @@ static inline int swap_zeromap_batch(swp_entry_t ent=
ry, int max_nr,
>
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
> +struct crypto_acomp_ctx {};
> +static inline void swap_crypto_acomp_compress_batch(
> +       struct page *pages[],
> +       u8 *dsts[],
> +       unsigned int dlens[],
> +       int errors[],
> +       int nr_pages,
> +       struct crypto_acomp_ctx *acomp_ctx)
> +{
> +}
> +
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb=
 **plug)
>  {
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 4669f29cf555..117c3caa5679 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -23,6 +23,8 @@
>  #include <linux/swap_slots.h>
>  #include <linux/huge_mm.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/scatterlist.h>
> +#include <crypto/acompress.h>
>  #include "internal.h"
>  #include "swap.h"
>
> @@ -742,6 +744,119 @@ void exit_swap_address_space(unsigned int type)
>         swapper_spaces[type] =3D NULL;
>  }
>
> +#ifdef CONFIG_SWAP
> +
> +/**
> + * This API provides IAA compress batching functionality for use by swap
> + * modules.
> + * The acomp_ctx mutex should be locked/unlocked before/after calling th=
is
> + * procedure.
> + *
> + * @pages: Pages to be compressed.
> + * @dsts: Pre-allocated destination buffers to store results of IAA comp=
ression.
> + * @dlens: Will contain the compressed lengths.
> + * @errors: Will contain a 0 if the page was successfully compressed, or=
 a
> + *          non-0 error value to be processed by the calling function.
> + * @nr_pages: The number of pages, up to SWAP_CRYPTO_SUB_BATCH_SIZE,
> + *            to be compressed.
> + * @acomp_ctx: The acomp context for iaa_crypto/other compressor.
> + */
> +void swap_crypto_acomp_compress_batch(
> +       struct page *pages[],
> +       u8 *dsts[],
> +       unsigned int dlens[],
> +       int errors[],
> +       int nr_pages,
> +       struct crypto_acomp_ctx *acomp_ctx)
> +{
> +       struct scatterlist inputs[SWAP_CRYPTO_SUB_BATCH_SIZE];
> +       struct scatterlist outputs[SWAP_CRYPTO_SUB_BATCH_SIZE];
> +       bool compressions_done =3D false;
> +       int i, j;
> +
> +       BUG_ON(nr_pages > SWAP_CRYPTO_SUB_BATCH_SIZE);
> +
> +       /*
> +        * Prepare and submit acomp_reqs to IAA.
> +        * IAA will process these compress jobs in parallel in async mode=
.
> +        * If the compressor does not support a poll() method, or if IAA =
is
> +        * used in sync mode, the jobs will be processed sequentially usi=
ng
> +        * acomp_ctx->req[0] and acomp_ctx->wait.
> +        */
> +       for (i =3D 0; i < nr_pages; ++i) {
> +               j =3D acomp_ctx->acomp->poll ? i : 0;
> +               sg_init_table(&inputs[i], 1);
> +               sg_set_page(&inputs[i], pages[i], PAGE_SIZE, 0);
> +
> +               /*
> +                * Each acomp_ctx->buffer[] is of size (PAGE_SIZE * 2).
> +                * Reflect same in sg_list.
> +                */
> +               sg_init_one(&outputs[i], dsts[i], PAGE_SIZE * 2);
> +               acomp_request_set_params(acomp_ctx->req[j], &inputs[i],
> +                                        &outputs[i], PAGE_SIZE, dlens[i]=
);
> +
> +               /*
> +                * If the crypto_acomp provides an asynchronous poll()
> +                * interface, submit the request to the driver now, and p=
oll for
> +                * a completion status later, after all descriptors have =
been
> +                * submitted. If the crypto_acomp does not provide a poll=
()
> +                * interface, submit the request and wait for it to compl=
ete,
> +                * i.e., synchronously, before moving on to the next requ=
est.
> +                */
> +               if (acomp_ctx->acomp->poll) {
> +                       errors[i] =3D crypto_acomp_compress(acomp_ctx->re=
q[j]);
> +
> +                       if (errors[i] !=3D -EINPROGRESS)
> +                               errors[i] =3D -EINVAL;
> +                       else
> +                               errors[i] =3D -EAGAIN;
> +               } else {
> +                       errors[i] =3D crypto_wait_req(
> +                                             crypto_acomp_compress(acomp=
_ctx->req[j]),
> +                                             &acomp_ctx->wait);
> +                       if (!errors[i])
> +                               dlens[i] =3D acomp_ctx->req[j]->dlen;
> +               }
> +       }
> +
> +       /*
> +        * If not doing async compressions, the batch has been processed =
at
> +        * this point and we can return.
> +        */
> +       if (!acomp_ctx->acomp->poll)
> +               return;
> +
> +       /*
> +        * Poll for and process IAA compress job completions
> +        * in out-of-order manner.
> +        */
> +       while (!compressions_done) {
> +               compressions_done =3D true;
> +
> +               for (i =3D 0; i < nr_pages; ++i) {
> +                       /*
> +                        * Skip, if the compression has already completed
> +                        * successfully or with an error.
> +                        */
> +                       if (errors[i] !=3D -EAGAIN)
> +                               continue;
> +
> +                       errors[i] =3D crypto_acomp_poll(acomp_ctx->req[i]=
);
> +
> +                       if (errors[i]) {
> +                               if (errors[i] =3D=3D -EAGAIN)
> +                                       compressions_done =3D false;
> +                       } else {
> +                               dlens[i] =3D acomp_ctx->req[i]->dlen;
> +                       }
> +               }
> +       }
> +}
> +EXPORT_SYMBOL_GPL(swap_crypto_acomp_compress_batch);
> +
> +#endif /* CONFIG_SWAP */
> +
>  static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
>                            unsigned long *end)
>  {
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 579869d1bdf6..cab3114321f9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -150,15 +150,6 @@ bool zswap_never_enabled(void)
>  * data structures
>  **********************************/
>
> -struct crypto_acomp_ctx {
> -       struct crypto_acomp *acomp;
> -       struct acomp_req *req[SWAP_CRYPTO_SUB_BATCH_SIZE];
> -       u8 *buffer[SWAP_CRYPTO_SUB_BATCH_SIZE];
> -       struct crypto_wait wait;
> -       struct mutex mutex;
> -       bool is_sleepable;
> -};
> -
>  /*
>   * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
>   * The only case where lru_lock is not acquired while holding tree.lock =
is
> --
> 2.27.0
>

