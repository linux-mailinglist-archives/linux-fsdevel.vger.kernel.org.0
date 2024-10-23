Return-Path: <linux-fsdevel+bounces-32630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C469ABAB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 02:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534F72850AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B51C2BD;
	Wed, 23 Oct 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZTUeg7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931352F34
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 00:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644752; cv=none; b=EDdHnHy2qtuc1xbigJE8yiCkPzGTezAk+VUrkx/HaAkzGkRn3xJtdTrxkjAno+8S+8Y2os4Ve9AlMCx6qkTrq5UX79yzZY0rJyDLHQHyWV6dKgOccV6PVVk55CI3ElQ1zw2IqYnibqUuV3JYTXzK/FwmTnJr3LoE0HRVWSrWdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644752; c=relaxed/simple;
	bh=FNkzG0t+3f9F5epDbyaeahtZ9CUMnffH1zgZo2l7/8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7uib9QymTMivGKvP6oS+rmdC8LP+Srj9NmflEE4ukd+FS4C0qkmLY+wYv596j/1PEjZMrRcxoeUnB/cHHRcHmBGcwQ7LTeMgzjEkYf+yDCjg+Mti5I8IsQkT2zGMjNA9LDxosdchad7qw2W2lKeetbMBYTRR81xM8ZjTk6YSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZTUeg7u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0cee600aso779400266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 17:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729644749; x=1730249549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRIYo0vfi/WbTNWFN/Rxuhp7/0FV171BLNc1zvZJ4gI=;
        b=KZTUeg7ui9+laANP1iLrK4zlo51VVjPmrhwiAdM6cp8TfY9twxbo+TsPtopXbrBQIa
         1QFOkfvGztJdmJG6zEpWripEhunW5Cl7HJU2Q/B9o+bq1Yp395EyNYGoLQb1NvOmSYq2
         qzPm4dvEqxk7Qnp67lP0g6Uv9E4Wx54UjQCVTBQE80PzE1fqmLEyU8Q1JE3IfNwJieDt
         cnB1slECB2ry3likO3IsSaiCo3OJHXgHEZwRbD3MNVz51aiY0VFyYmNgav2Lt0EH4yMp
         4YaJYFN11EMhtk/83yMgDQtxj7nE/sW1Ry03rLiygvS/R5qDefsp6q5WOkgA03tXv4bV
         IMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644749; x=1730249549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRIYo0vfi/WbTNWFN/Rxuhp7/0FV171BLNc1zvZJ4gI=;
        b=WyD1kGtuMlnbc7wFbizU15/uuu7eZWrj2qELqmRlo766hEGo085FVwtfRhunPk+n5h
         MfXj7tfoxdNEDCrkBcpizVvpb2p/AQy2UaXeZnOK3Flw+RjY8EhRjsK8lRM3xSlyd95T
         fFj/+iq/Aa0OzqIe3gW+TvVeyTXvwq5nl/KOEi/38Xja+fRgU+B9PzlxHZ3SxNdlL+jM
         jLxpMjIZs/FEcUWkWiJNOC4q1JtxeoMGtTlnsiAZCZvWuUGVNWyYqfUdM/MFPq1ZYLL0
         kxkGvGwlOUAHhQ0Tz0C2mOJksblYdIKHwZrGPESm59t83o/5pmfIqU/zEGPOZujnLtP3
         rQEw==
X-Forwarded-Encrypted: i=1; AJvYcCUzhwIeXh0ebxnBMSxJyKOv8aGdx2TwcCQn14Gj9qK0W3qifODr90K5fW1HfcxAsMdpvk7yomF3qiRApmX2@vger.kernel.org
X-Gm-Message-State: AOJu0YysvHFegU1Cu0Hn7c5ueRjof543WM0OT6Eobmm+XBu4PPQzEY2Y
	13vGjwPChFbCvUYMYcpvCd7z5OvaiZjAkJgZRWE/gxg7w7ozPyrmHkY913KzYcU5k3P8uD0wu8p
	nuzwINuu100IKnRZS74GDGyAYvOhu1/0YUG97
X-Google-Smtp-Source: AGHT+IGaSuqXB7IIAkW6V33L0/YI5ddbxQfQQvy9XmGu9/QvRowihI63d3sdCC7W9vU1fxOSJOB31qFe99DHuA4HBaA=
X-Received: by 2002:a17:907:3e0a:b0:a9a:6ab:c93b with SMTP id
 a640c23a62f3a-a9abf9b5984mr62235166b.62.1729644748622; Tue, 22 Oct 2024
 17:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com> <20241018064101.336232-11-kanchana.p.sridhar@intel.com>
In-Reply-To: <20241018064101.336232-11-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 22 Oct 2024 17:51:52 -0700
Message-ID: <CAJD7tkbA=7LxUvQKfg47jTCPUnN0idQ5jDZJJHXiLnueMb8RCw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/13] mm: zswap: Create multiple reqs/buffers in
 crypto_acomp_ctx if platform has IAA.
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
> Intel IAA hardware acceleration can be used effectively to improve the
> zswap_store() performance of large folios by batching multiple pages in a
> folio to be compressed in parallel by IAA. Hence, to build compress batch=
ing
> of zswap large folio stores using IAA, we need to be able to submit a bat=
ch
> of compress jobs from zswap to the hardware to compress in parallel if th=
e
> iaa_crypto "async" mode is used.
>
> The IAA compress batching paradigm works as follows:
>
>  1) Submit N crypto_acomp_compress() jobs using N requests.
>  2) Use the iaa_crypto driver async poll() method to check for the jobs
>     to complete.
>  3) There are no ordering constraints implied by submission, hence we
>     could loop through the requests and process any job that has
>     completed.
>  4) This would repeat until all jobs have completed with success/error
>     status.
>
> To facilitate this, we need to provide for multiple acomp_reqs in
> "struct crypto_acomp_ctx", each representing a distinct compress
> job. Likewise, there needs to be a distinct destination buffer
> corresponding to each acomp_req.
>
> If CONFIG_ZSWAP_STORE_BATCHING_ENABLED is enabled, this patch will set th=
e
> SWAP_CRYPTO_SUB_BATCH_SIZE constant to 8UL. This implies each per-cpu
> crypto_acomp_ctx associated with the zswap_pool can submit up to 8
> acomp_reqs at a time to accomplish parallel compressions.
>
> If IAA is not present and/or CONFIG_ZSWAP_STORE_BATCHING_ENABLED is not
> set, SWAP_CRYPTO_SUB_BATCH_SIZE will be set to 1UL.
>
> On an Intel Sapphire Rapids server, each socket has 4 IAA, each of which
> has 2 compress engines and 8 decompress engines. Experiments modeling a
> contended system with say 72 processes running under a cgroup with a fixe=
d
> memory-limit, have shown that there is a significant performance
> improvement with dispatching compress jobs from all cores to all the
> IAA devices on the socket. Hence, SWAP_CRYPTO_SUB_BATCH_SIZE is set to
> 8 to maximize compression throughput if IAA is available.
>
> The definition of "struct crypto_acomp_ctx" is modified to make the
> req/buffer be arrays of size SWAP_CRYPTO_SUB_BATCH_SIZE. Thus, the
> added memory footprint cost of this per-cpu structure for batching is
> incurred only for platforms that have Intel IAA.
>
> Suggested-by: Ying Huang <ying.huang@intel.com>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Does this really need to be done in zswap? Why can't zswap submit a
single compression request with the supported number of pages, and
have the driver handle it as it sees fit?

> ---
>  mm/swap.h  |  11 ++++++
>  mm/zswap.c | 104 ++++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 78 insertions(+), 37 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index ad2f121de970..566616c971d4 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -8,6 +8,17 @@ struct mempolicy;
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
>
> +/*
> + * For IAA compression batching:
> + * Maximum number of IAA acomp compress requests that will be processed
> + * in a sub-batch.
> + */
> +#if defined(CONFIG_ZSWAP_STORE_BATCHING_ENABLED)
> +#define SWAP_CRYPTO_SUB_BATCH_SIZE 8UL
> +#else
> +#define SWAP_CRYPTO_SUB_BATCH_SIZE 1UL
> +#endif
> +
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);
>  struct swap_iocb;
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 4893302d8c34..579869d1bdf6 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -152,9 +152,9 @@ bool zswap_never_enabled(void)
>
>  struct crypto_acomp_ctx {
>         struct crypto_acomp *acomp;
> -       struct acomp_req *req;
> +       struct acomp_req *req[SWAP_CRYPTO_SUB_BATCH_SIZE];
> +       u8 *buffer[SWAP_CRYPTO_SUB_BATCH_SIZE];
>         struct crypto_wait wait;
> -       u8 *buffer;
>         struct mutex mutex;
>         bool is_sleepable;
>  };
> @@ -832,49 +832,64 @@ static int zswap_cpu_comp_prepare(unsigned int cpu,=
 struct hlist_node *node)
>         struct zswap_pool *pool =3D hlist_entry(node, struct zswap_pool, =
node);
>         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ct=
x, cpu);
>         struct crypto_acomp *acomp;
> -       struct acomp_req *req;
>         int ret;
> +       int i, j;
>
>         mutex_init(&acomp_ctx->mutex);
>
> -       acomp_ctx->buffer =3D kmalloc_node(PAGE_SIZE * 2, GFP_KERNEL, cpu=
_to_node(cpu));
> -       if (!acomp_ctx->buffer)
> -               return -ENOMEM;
> -
>         acomp =3D crypto_alloc_acomp_node(pool->tfm_name, 0, 0, cpu_to_no=
de(cpu));
>         if (IS_ERR(acomp)) {
>                 pr_err("could not alloc crypto acomp %s : %ld\n",
>                                 pool->tfm_name, PTR_ERR(acomp));
> -               ret =3D PTR_ERR(acomp);
> -               goto acomp_fail;
> +               return PTR_ERR(acomp);
>         }
>         acomp_ctx->acomp =3D acomp;
>         acomp_ctx->is_sleepable =3D acomp_is_async(acomp);
>
> -       req =3D acomp_request_alloc(acomp_ctx->acomp);
> -       if (!req) {
> -               pr_err("could not alloc crypto acomp_request %s\n",
> -                      pool->tfm_name);
> -               ret =3D -ENOMEM;
> -               goto req_fail;
> +       for (i =3D 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i) {
> +               acomp_ctx->buffer[i] =3D kmalloc_node(PAGE_SIZE * 2,
> +                                               GFP_KERNEL, cpu_to_node(c=
pu));
> +               if (!acomp_ctx->buffer[i]) {
> +                       for (j =3D 0; j < i; ++j)
> +                               kfree(acomp_ctx->buffer[j]);
> +                       ret =3D -ENOMEM;
> +                       goto buf_fail;
> +               }
> +       }
> +
> +       for (i =3D 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i) {
> +               acomp_ctx->req[i] =3D acomp_request_alloc(acomp_ctx->acom=
p);
> +               if (!acomp_ctx->req[i]) {
> +                       pr_err("could not alloc crypto acomp_request req[=
%d] %s\n",
> +                              i, pool->tfm_name);
> +                       for (j =3D 0; j < i; ++j)
> +                               acomp_request_free(acomp_ctx->req[j]);
> +                       ret =3D -ENOMEM;
> +                       goto req_fail;
> +               }
>         }
> -       acomp_ctx->req =3D req;
>
> +       /*
> +        * The crypto_wait is used only in fully synchronous, i.e., with =
scomp
> +        * or non-poll mode of acomp, hence there is only one "wait" per
> +        * acomp_ctx, with callback set to req[0].
> +        */
>         crypto_init_wait(&acomp_ctx->wait);
>         /*
>          * if the backend of acomp is async zip, crypto_req_done() will w=
akeup
>          * crypto_wait_req(); if the backend of acomp is scomp, the callb=
ack
>          * won't be called, crypto_wait_req() will return without blockin=
g.
>          */
> -       acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
> +       acomp_request_set_callback(acomp_ctx->req[0], CRYPTO_TFM_REQ_MAY_=
BACKLOG,
>                                    crypto_req_done, &acomp_ctx->wait);
>
>         return 0;
>
>  req_fail:
> +       for (i =3D 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i)
> +               kfree(acomp_ctx->buffer[i]);
> +buf_fail:
>         crypto_free_acomp(acomp_ctx->acomp);
> -acomp_fail:
> -       kfree(acomp_ctx->buffer);
>         return ret;
>  }
>
> @@ -884,11 +899,17 @@ static int zswap_cpu_comp_dead(unsigned int cpu, st=
ruct hlist_node *node)
>         struct crypto_acomp_ctx *acomp_ctx =3D per_cpu_ptr(pool->acomp_ct=
x, cpu);
>
>         if (!IS_ERR_OR_NULL(acomp_ctx)) {
> -               if (!IS_ERR_OR_NULL(acomp_ctx->req))
> -                       acomp_request_free(acomp_ctx->req);
> +               int i;
> +
> +               for (i =3D 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i)
> +                       if (!IS_ERR_OR_NULL(acomp_ctx->req[i]))
> +                               acomp_request_free(acomp_ctx->req[i]);
> +
> +               for (i =3D 0; i < SWAP_CRYPTO_SUB_BATCH_SIZE; ++i)
> +                       kfree(acomp_ctx->buffer[i]);
> +
>                 if (!IS_ERR_OR_NULL(acomp_ctx->acomp))
>                         crypto_free_acomp(acomp_ctx->acomp);
> -               kfree(acomp_ctx->buffer);
>         }
>
>         return 0;
> @@ -911,7 +932,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>
>         mutex_lock(&acomp_ctx->mutex);
>
> -       dst =3D acomp_ctx->buffer;
> +       dst =3D acomp_ctx->buffer[0];
>         sg_init_table(&input, 1);
>         sg_set_page(&input, page, PAGE_SIZE, 0);
>
> @@ -921,7 +942,7 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>          * giving the dst buffer with enough length to avoid buffer overf=
low.
>          */
>         sg_init_one(&output, dst, PAGE_SIZE * 2);
> -       acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SI=
ZE, dlen);
> +       acomp_request_set_params(acomp_ctx->req[0], &input, &output, PAGE=
_SIZE, dlen);
>
>         /*
>          * If the crypto_acomp provides an asynchronous poll() interface,
> @@ -940,19 +961,20 @@ static bool zswap_compress(struct page *page, struc=
t zswap_entry *entry,
>          * parallel.
>          */
>         if (acomp_ctx->acomp->poll) {
> -               comp_ret =3D crypto_acomp_compress(acomp_ctx->req);
> +               comp_ret =3D crypto_acomp_compress(acomp_ctx->req[0]);
>                 if (comp_ret =3D=3D -EINPROGRESS) {
>                         do {
> -                               comp_ret =3D crypto_acomp_poll(acomp_ctx-=
>req);
> +                               comp_ret =3D crypto_acomp_poll(acomp_ctx-=
>req[0]);
>                                 if (comp_ret && comp_ret !=3D -EAGAIN)
>                                         break;
>                         } while (comp_ret);
>                 }
>         } else {
> -               comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_=
ctx->req), &acomp_ctx->wait);
> +               comp_ret =3D crypto_wait_req(crypto_acomp_compress(acomp_=
ctx->req[0]),
> +                                          &acomp_ctx->wait);
>         }
>
> -       dlen =3D acomp_ctx->req->dlen;
> +       dlen =3D acomp_ctx->req[0]->dlen;
>         if (comp_ret)
>                 goto unlock;
>
> @@ -1006,31 +1028,39 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct folio *folio)
>          */
>         if ((acomp_ctx->is_sleepable && !zpool_can_sleep_mapped(zpool)) |=
|
>             !virt_addr_valid(src)) {
> -               memcpy(acomp_ctx->buffer, src, entry->length);
> -               src =3D acomp_ctx->buffer;
> +               memcpy(acomp_ctx->buffer[0], src, entry->length);
> +               src =3D acomp_ctx->buffer[0];
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_folio(&output, folio, PAGE_SIZE, 0);
> -       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> +       acomp_request_set_params(acomp_ctx->req[0], &input, &output,
> +                                entry->length, PAGE_SIZE);
>         if (acomp_ctx->acomp->poll) {
> -               ret =3D crypto_acomp_decompress(acomp_ctx->req);
> +               ret =3D crypto_acomp_decompress(acomp_ctx->req[0]);
>                 if (ret =3D=3D -EINPROGRESS) {
>                         do {
> -                               ret =3D crypto_acomp_poll(acomp_ctx->req)=
;
> +                               ret =3D crypto_acomp_poll(acomp_ctx->req[=
0]);
>                                 BUG_ON(ret && ret !=3D -EAGAIN);
>                         } while (ret);
>                 }
>         } else {
> -               BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx-=
>req), &acomp_ctx->wait));
> +               BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx-=
>req[0]),
> +                                      &acomp_ctx->wait));
>         }
> -       BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> -       mutex_unlock(&acomp_ctx->mutex);
> +       BUG_ON(acomp_ctx->req[0]->dlen !=3D PAGE_SIZE);
>
> -       if (src !=3D acomp_ctx->buffer)
> +       if (src !=3D acomp_ctx->buffer[0])
>                 zpool_unmap_handle(zpool, entry->handle);
> +
> +       /*
> +        * It is safer to unlock the mutex after the check for
> +        * "src !=3D acomp_ctx->buffer[0]" so that the value of "src"
> +        * does not change.
> +        */
> +       mutex_unlock(&acomp_ctx->mutex);
>  }
>
>  /*********************************
> --
> 2.27.0
>

