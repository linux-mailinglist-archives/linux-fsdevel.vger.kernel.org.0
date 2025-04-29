Return-Path: <linux-fsdevel+bounces-47580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3117AA0955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620CB1B63EBC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C42155333;
	Tue, 29 Apr 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3MRE0eA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169929DB7C;
	Tue, 29 Apr 2025 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745925148; cv=none; b=PL2JeUyfMgjOAOLuF8p3aHqOGbaVT3mcTO1kXTLCpI5nR/k4tBaJGbH5DPw0z73I3j7uuogpjFJLs1dFiuxWUpGHCMO/rPBmyeJmBqqwMX+S2NKWXxqVXMsuzYRwsv7FD3aEPKzybaWZtc5Cje0jV1FlU2qdziZj5WYGhpVPT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745925148; c=relaxed/simple;
	bh=zENo5bEX0ne3MO8pGB3vOTRBErU4NJSorjZzxthNBZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m5aCLzLc2U5F0XZez1/5+tKZOicimAknx5M+xiBwEm4kyQirODtXFpWST3/UxXQKUHsplv9CkJOVfB/BOS/Jv6uO3RauT6vDkax+i95o63hNaZ74C+i1w7Oi/T+PSR5A+R6oZUv9Gr1Sc3wnw/p+9Y8XhDfZ00K3Z3bKoxTEiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3MRE0eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADF4C4CEEF;
	Tue, 29 Apr 2025 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745925148;
	bh=zENo5bEX0ne3MO8pGB3vOTRBErU4NJSorjZzxthNBZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j3MRE0eAJZ3LXDLUZ+lAVAgTxWaHeNKZURwvrUSvIBh3sSuQoD3Dt5qEBVStu5y48
	 3dpF60MruCcq8t9UVTgcWeZN8VhAQuJ9/1m0UwhQmsRlzwl7A7JGgg/WJ/Med85YMF
	 unXucdY1dsWDycnNBRd3sjkyaU9rg2eX3gMpL9jXF6jC8fmqK4c8HahEPXW1xRS2/J
	 u4gqykLQ6PxGZbPlcU+vdOCGpXtunlr976oLp0N2SCIqTni/Qxnp8XPu4qgF+3GI0x
	 6ReLMWQL7NoXjLvwR/Z9r/+2GbAG2J7Xexb3O9TDTeEw9Defa8fv9h6vKPrwiyJxKK
	 nGjMYPwjcFj+g==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2cc57330163so3882580fac.2;
        Tue, 29 Apr 2025 04:12:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUeTBL8L29F+Prd1UYSap+Y7EBOt8HRXKdHcN2xofMs8Gflkoq2h/VvUlRUu8KoQY4iZ5zeJ2vTH+T9@vger.kernel.org, AJvYcCUfR8DYqyrDHW0sMGvaDlB8Y9e9jXAIBHN5Rx8Vfsf2PhAK20Z2OC6v2Ad044ekd912MY0wF3NfvYw=@vger.kernel.org, AJvYcCUqwUnayUAVAiDoQ6oFJDDALZZhLpEeSAxfqcgI2Tcc2E1BZTptP+NOlHSR7iDIjBL4VPytue9gfNyVqWEidA==@vger.kernel.org, AJvYcCVwfUl2BKMBqxypyqtLvWLbkVzMJcPYT69+BMDs9AG30HtDrfc83mfQZICl57WRPnmgVJoDBOuC1V23WNA=@vger.kernel.org, AJvYcCWHRCvrSeX9BzK4S2DY2MmxxmL5tGNqoihau/DnURUQfoU33CqkQezZgdT5+mzI+eJBvqp3iz1oAP6M9fo=@vger.kernel.org, AJvYcCWnPPlInsu2OzpU0Uyx8/YE004urmYhxgQkxyLvTnwVPk7e1GFZy4ux1SEIr8nLSd2VsKjU7bXDakSuIxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEapYFBOd3R+fCOxRdF/EJWVVchFZIvLe13gJq1FPG3WoD64Ib
	J+imLDLVtDycwX3vOPNIuz9fYc6AII8rj0BJ4rBK4Zfi/p/kb7aKkAhiiaYFjicjPjd2wYrRkec
	BAEbyNxw0d2JhO1Zp8ECaf4UrXt4=
X-Google-Smtp-Source: AGHT+IGUWDcWT0YY8d56VudKuK1SbBcTr2tpfzC5s5DOpLaSa5JjR2p03SezTcsNj4ZQ5wvrsLmbMqiftKZFtmYD2T4=
X-Received: by 2002:a05:6870:71cc:b0:2d4:d9d6:c8bf with SMTP id
 586e51a60fabf-2da48704b4fmr1286917fac.32.1745925147264; Tue, 29 Apr 2025
 04:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-18-hch@lst.de>
In-Reply-To: <20250422142628.1553523-18-hch@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Apr 2025 13:12:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHa3vS+hOvGBcDkFDkfb=J+-JQUovd6+tvgxWkVJwhgw@mail.gmail.com>
X-Gm-Features: ATxdqUGQ7vaDrCKBYkk6DLUX_6jYnIAgCV74wXKGpVmOgPrLqL0j1SE2o5Nc940
Message-ID: <CAJZ5v0iHa3vS+hOvGBcDkFDkfb=J+-JQUovd6+tvgxWkVJwhgw@mail.gmail.com>
Subject: Re: [PATCH 17/17] PM: hibernate: split and simplify hib_submit_io
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Coly Li <colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	linux-bcache@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:27=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Split hib_submit_io into a sync and async version.  The sync version is
> a small wrapper around bdev_rw_virt which implements all the logic to
> add a kernel direct mapping range to a bio and synchronously submits it,
> while the async version is slightly simplified using the
> bio_add_virt_nofail for adding the single range.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM, so

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

and please route it as needed along with the rest of the series.

> ---
>  kernel/power/swap.c | 103 +++++++++++++++++++-------------------------
>  1 file changed, 45 insertions(+), 58 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 80ff5f933a62..ad13c461b657 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -268,35 +268,26 @@ static void hib_end_io(struct bio *bio)
>         bio_put(bio);
>  }
>
> -static int hib_submit_io(blk_opf_t opf, pgoff_t page_off, void *addr,
> +static int hib_submit_io_sync(blk_opf_t opf, pgoff_t page_off, void *add=
r)
> +{
> +       return bdev_rw_virt(file_bdev(hib_resume_bdev_file),
> +                       page_off * (PAGE_SIZE >> 9), addr, PAGE_SIZE, opf=
);
> +}
> +
> +static int hib_submit_io_async(blk_opf_t opf, pgoff_t page_off, void *ad=
dr,
>                          struct hib_bio_batch *hb)
>  {
> -       struct page *page =3D virt_to_page(addr);
>         struct bio *bio;
> -       int error =3D 0;
>
>         bio =3D bio_alloc(file_bdev(hib_resume_bdev_file), 1, opf,
>                         GFP_NOIO | __GFP_HIGH);
>         bio->bi_iter.bi_sector =3D page_off * (PAGE_SIZE >> 9);
> -
> -       if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
> -               pr_err("Adding page to bio failed at %llu\n",
> -                      (unsigned long long)bio->bi_iter.bi_sector);
> -               bio_put(bio);
> -               return -EFAULT;
> -       }
> -
> -       if (hb) {
> -               bio->bi_end_io =3D hib_end_io;
> -               bio->bi_private =3D hb;
> -               atomic_inc(&hb->count);
> -               submit_bio(bio);
> -       } else {
> -               error =3D submit_bio_wait(bio);
> -               bio_put(bio);
> -       }
> -
> -       return error;
> +       bio_add_virt_nofail(bio, addr, PAGE_SIZE);
> +       bio->bi_end_io =3D hib_end_io;
> +       bio->bi_private =3D hb;
> +       atomic_inc(&hb->count);
> +       submit_bio(bio);
> +       return 0;
>  }
>
>  static int hib_wait_io(struct hib_bio_batch *hb)
> @@ -316,7 +307,7 @@ static int mark_swapfiles(struct swap_map_handle *han=
dle, unsigned int flags)
>  {
>         int error;
>
> -       hib_submit_io(REQ_OP_READ, swsusp_resume_block, swsusp_header, NU=
LL);
> +       hib_submit_io_sync(REQ_OP_READ, swsusp_resume_block, swsusp_heade=
r);
>         if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
>             !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
>                 memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
> @@ -329,8 +320,8 @@ static int mark_swapfiles(struct swap_map_handle *han=
dle, unsigned int flags)
>                 swsusp_header->flags =3D flags;
>                 if (flags & SF_CRC32_MODE)
>                         swsusp_header->crc32 =3D handle->crc32;
> -               error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
> -                                     swsusp_resume_block, swsusp_header,=
 NULL);
> +               error =3D hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
> +                                     swsusp_resume_block, swsusp_header)=
;
>         } else {
>                 pr_err("Swap header not found!\n");
>                 error =3D -ENODEV;
> @@ -380,36 +371,30 @@ static int swsusp_swap_check(void)
>
>  static int write_page(void *buf, sector_t offset, struct hib_bio_batch *=
hb)
>  {
> +       gfp_t gfp =3D GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
>         void *src;
>         int ret;
>
>         if (!offset)
>                 return -ENOSPC;
>
> -       if (hb) {
> -               src =3D (void *)__get_free_page(GFP_NOIO | __GFP_NOWARN |
> -                                             __GFP_NORETRY);
> -               if (src) {
> -                       copy_page(src, buf);
> -               } else {
> -                       ret =3D hib_wait_io(hb); /* Free pages */
> -                       if (ret)
> -                               return ret;
> -                       src =3D (void *)__get_free_page(GFP_NOIO |
> -                                                     __GFP_NOWARN |
> -                                                     __GFP_NORETRY);
> -                       if (src) {
> -                               copy_page(src, buf);
> -                       } else {
> -                               WARN_ON_ONCE(1);
> -                               hb =3D NULL;      /* Go synchronous */
> -                               src =3D buf;
> -                       }
> -               }
> -       } else {
> -               src =3D buf;
> +       if (!hb)
> +               goto sync_io;
> +
> +       src =3D (void *)__get_free_page(gfp);
> +       if (!src) {
> +               ret =3D hib_wait_io(hb); /* Free pages */
> +               if (ret)
> +                       return ret;
> +               src =3D (void *)__get_free_page(gfp);
> +               if (WARN_ON_ONCE(!src))
> +                       goto sync_io;
>         }
> -       return hib_submit_io(REQ_OP_WRITE | REQ_SYNC, offset, src, hb);
> +
> +       copy_page(src, buf);
> +       return hib_submit_io_async(REQ_OP_WRITE | REQ_SYNC, offset, src, =
hb);
> +sync_io:
> +       return hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC, offset, buf);
>  }
>
>  static void release_swap_writer(struct swap_map_handle *handle)
> @@ -1041,7 +1026,7 @@ static int get_swap_reader(struct swap_map_handle *=
handle,
>                         return -ENOMEM;
>                 }
>
> -               error =3D hib_submit_io(REQ_OP_READ, offset, tmp->map, NU=
LL);
> +               error =3D hib_submit_io_sync(REQ_OP_READ, offset, tmp->ma=
p);
>                 if (error) {
>                         release_swap_reader(handle);
>                         return error;
> @@ -1065,7 +1050,10 @@ static int swap_read_page(struct swap_map_handle *=
handle, void *buf,
>         offset =3D handle->cur->entries[handle->k];
>         if (!offset)
>                 return -EFAULT;
> -       error =3D hib_submit_io(REQ_OP_READ, offset, buf, hb);
> +       if (hb)
> +               error =3D hib_submit_io_async(REQ_OP_READ, offset, buf, h=
b);
> +       else
> +               error =3D hib_submit_io_sync(REQ_OP_READ, offset, buf);
>         if (error)
>                 return error;
>         if (++handle->k >=3D MAP_PAGE_ENTRIES) {
> @@ -1590,8 +1578,8 @@ int swsusp_check(bool exclusive)
>                                 BLK_OPEN_READ, holder, NULL);
>         if (!IS_ERR(hib_resume_bdev_file)) {
>                 clear_page(swsusp_header);
> -               error =3D hib_submit_io(REQ_OP_READ, swsusp_resume_block,
> -                                       swsusp_header, NULL);
> +               error =3D hib_submit_io_sync(REQ_OP_READ, swsusp_resume_b=
lock,
> +                                       swsusp_header);
>                 if (error)
>                         goto put;
>
> @@ -1599,9 +1587,9 @@ int swsusp_check(bool exclusive)
>                         memcpy(swsusp_header->sig, swsusp_header->orig_si=
g, 10);
>                         swsusp_header_flags =3D swsusp_header->flags;
>                         /* Reset swap signature now */
> -                       error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
> +                       error =3D hib_submit_io_sync(REQ_OP_WRITE | REQ_S=
YNC,
>                                                 swsusp_resume_block,
> -                                               swsusp_header, NULL);
> +                                               swsusp_header);
>                 } else {
>                         error =3D -EINVAL;
>                 }
> @@ -1650,13 +1638,12 @@ int swsusp_unmark(void)
>  {
>         int error;
>
> -       hib_submit_io(REQ_OP_READ, swsusp_resume_block,
> -                       swsusp_header, NULL);
> +       hib_submit_io_sync(REQ_OP_READ, swsusp_resume_block, swsusp_heade=
r);
>         if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
>                 memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
> -               error =3D hib_submit_io(REQ_OP_WRITE | REQ_SYNC,
> +               error =3D hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
>                                         swsusp_resume_block,
> -                                       swsusp_header, NULL);
> +                                       swsusp_header);
>         } else {
>                 pr_err("Cannot find swsusp signature!\n");
>                 error =3D -ENODEV;
> --
> 2.47.2
>

