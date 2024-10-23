Return-Path: <linux-fsdevel+bounces-32627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C469ABAA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBFB28501E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462C1BDC3;
	Wed, 23 Oct 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1onzLvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79E28E3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644564; cv=none; b=LqIYpRdBU4ripRLvMGMJOmdyJZcbsYvrjF4i429iCL4V4DTecMZpxvFiK3xgja4AgAjjdubnBjeAb4sjwxA5+JzPJxGYRGiKUNuw3XPDdhN5r1Syr9I/L2AzbinFaUQdpyyK1nx+XYZvwfhbfKf/mlVe1cZG9Ny0uTf01fQvga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644564; c=relaxed/simple;
	bh=SljGXz63/h+3m3uwl/K21ZDFOEGEc6Jc0sc55fTNPWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC/Lu0KecXBYOXjYGFrLv1fR7H6T6aJSbmswXYHeD0aoCD9cDcW5ENO1wu/JTeInA2ldkBdET/JheqnMhrtpXPHrQ9rblgKHtzqzIT8bFoYsSBvhzbTm4x9SlLNcdBGdohDlBDg07xhUmhMSoTakE6y+kaXUpm225HtFOnY6Dwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1onzLvI; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7aa086b077so749269766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729644561; x=1730249361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7h7Ib3rin1j+j/i/BmxIphxr1v+kKzDbsGLgavpQz7o=;
        b=D1onzLvIdPSVywJEJ1/2ei2UbvngZsC0vHA/3IPM6SNhSfjI13Nqi1U+Zs82J4J0MR
         1xynNeq0GuiRhDkSWVBUivLpCW4FF4P27ePAc05Ul0dXZVhymDYYO8qvXkCqVSjxAvsU
         Rf1LgmMjYEY/XlLwp4ruAXXzS5B2nLxJdgBJX8mzVGDCsEVBCUtrhcqko63zSo+LCHHl
         k3m6+XPLTE/YGggYT9ADMXkzcfFvonyp2ZJrCuspq8H//DrJfdcKO/CGBKEZY0Pd0lOy
         cVRjHfQRAMFsVAX0+9lcL1m/1v6YbZBvgcJflHA7r5l3ep7WZbSbU9AAdl566FT1D4Cw
         4/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644561; x=1730249361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h7Ib3rin1j+j/i/BmxIphxr1v+kKzDbsGLgavpQz7o=;
        b=Cz1tHeGxDdd6/s93UJpjl4jPX+nPoV79nyzktXMRRT5sFUso6a8Dz8R9LnGvz0HDgT
         h+CdqWYQNmx1o/aH4ppg54+HlCU1xlZN2z2mwy+8TBa0eNqjzeqbqcDC5d/2TcbnBNTN
         OSHW8pb/x1FYaD/aa5IS+mCy6OGDUawzDwzpAOoRZpNHOOAy7Q+cOJteICtQqVoqUJpi
         JtkR28TPihomfcDvLPekFpLR5OE6xmGFSS1b+1ceR+Bqi5qL7Z0DmQ3Da4+pPZn+904r
         ToyistzglVcLkeH9WhV0dUu2mWzsl49Z1uvs1rnD1m+IlOpfWenSTs7uVnkIVQbPykOA
         VAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMo121GzLIHGKjlH6XGoUwtqKLWGAvEe68nqKeh3jQvDgIIWhn4MhtVSnJcrBx+tLVwWy1m7gHKzv/X+t5@vger.kernel.org
X-Gm-Message-State: AOJu0YxExso6Gr/WCQzzv5WpzCvni22y6fZfWna8ShJG15PqztTYeZWv
	SOChSKZ2xnhIoaqAvSiMP3trGuAuTbKZTaa61ZvRUHxtL2H/xlxbisPS7H7MBh39ki701GN6QqO
	x1/ocOWAbF41kNpdGOJZ/mO+ynnhd2HDB99ZG
X-Google-Smtp-Source: AGHT+IFMisZ4oMvMqemTXU5KgbzeivNdbDaya3XBywWCinRAAR5cqjPylB/Gg9m/GBrxRcfF6/Ojst9RWuKwv4fnkO4=
X-Received: by 2002:a17:907:86a4:b0:a9a:1a6a:b5f5 with SMTP id
 a640c23a62f3a-a9abf964381mr65014466b.56.1729644560784; Tue, 22 Oct 2024
 17:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com> <20241018064101.336232-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241018064101.336232-5-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 17:48:44 -0700
Message-ID: <CAJD7tkZPuMGB4=ULd=znbVqk1LL8oL_gdxi8q-K+vAub33nHgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 04/13] mm: zswap: zswap_compress()/decompress() can
 submit, then poll an acomp_req.
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
> If the crypto_acomp has a poll interface registered, zswap_compress()
> and zswap_decompress() will submit the acomp_req, and then poll() for a
> successful completion/error status in a busy-wait loop. This allows an
> asynchronous way to manage (potentially multiple) acomp_reqs without
> the use of interrupts, which is supported in the iaa_crypto driver.
>
> This enables us to implement batch submission of multiple
> compression/decompression jobs to the Intel IAA hardware accelerator,
> which will process them in parallel; followed by polling the batch's
> acomp_reqs for completion status.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 51 +++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f6316b66fb23..948c9745ee57 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -910,18 +910,34 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
>         acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
>
>         /*
> -        * it maybe looks a little bit silly that we send an asynchronous=
 request,
> -        * then wait for its completion synchronously. This makes the pro=
cess look
> -        * synchronous in fact.
> -        * Theoretically, acomp supports users send multiple acomp reques=
ts in one
> -        * acomp instance, then get those requests done simultaneously. b=
ut in this
> -        * case, zswap actually does store and load page by page, there i=
s no
> -        * existing method to send the second page before the first page =
is done
> -        * in one thread doing zwap.
> -        * but in different threads running on different cpu, we have dif=
ferent
> -        * acomp instance, so multiple threads can do (de)compression in =
parallel.
> +        * If the crypto_acomp provides an asynchronous poll() interface,
> +        * submit the descriptor and poll for a completion status.
> +        *
> +        * It maybe looks a little bit silly that we send an asynchronous
> +        * request, then wait for its completion in a busy-wait poll loop=
, or,
> +        * synchronously. This makes the process look synchronous in fact=
.
> +        * Theoretically, acomp supports users send multiple acomp reques=
ts in
> +        * one acomp instance, then get those requests done simultaneousl=
y.
> +        * But in this case, zswap actually does store and load page by p=
age,
> +        * there is no existing method to send the second page before the
> +        * first page is done in one thread doing zswap.
> +        * But in different threads running on different cpu, we have dif=
ferent
> +        * acomp instance, so multiple threads can do (de)compression in
> +        * parallel.
>          */
> -       comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_ctx->req=
), &acomp_ctx->wait);
> +       if (acomp_ctx->acomp->poll) {
> +               comp_ret =3D crypto_acomp_compress(acomp_ctx->req);
> +               if (comp_ret =3D=3D -EINPROGRESS) {
> +                       do {
> +                               comp_ret =3D crypto_acomp_poll(acomp_ctx-=
>req);
> +                               if (comp_ret && comp_ret !=3D -EAGAIN)
> +                                       break;
> +                       } while (comp_ret);
> +               }
> +       } else {
> +               comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_=
ctx->req), &acomp_ctx->wait);
> +       }
> +

Is Herbert suggesting that crypto_wait_req(crypto_acomp_compress(..))
essentially do the poll internally for IAA, and hence this change can
be dropped?

>         dlen =3D acomp_ctx->req->dlen;
>         if (comp_ret)
>                 goto unlock;
> @@ -959,6 +975,7 @@ static void zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src;
> +       int ret;
>
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>         mutex_lock(&acomp_ctx->mutex);
> @@ -984,7 +1001,17 @@ static void zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>         sg_init_table(&output, 1);
>         sg_set_folio(&output, folio, PAGE_SIZE, 0);
>         acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> -       BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
> +       if (acomp_ctx->acomp->poll) {
> +               ret =3D crypto_acomp_decompress(acomp_ctx->req);
> +               if (ret =3D=3D -EINPROGRESS) {
> +                       do {
> +                               ret =3D crypto_acomp_poll(acomp_ctx->req)=
;
> +                               BUG_ON(ret && ret !=3D -EAGAIN);
> +                       } while (ret);
> +               }
> +       } else {
> +               BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx-=
>req), &acomp_ctx->wait));
> +       }
>         BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
>         mutex_unlock(&acomp_ctx->mutex);
>
> --
> 2.27.0
>

