Return-Path: <linux-fsdevel+bounces-64512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE3BEB5DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 21:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1323E6E092B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBE2FC86B;
	Fri, 17 Oct 2025 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPsNtg+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0392F9DA4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728295; cv=none; b=DW0dmP3hH+hHGun8oGvlPwEm+fZbG35+Up3MET5WZl0KS0sTjRiggclhQgTkWsrI/6UmHjVQU9SOU6uiJHfuEAneMHgzOBVDMjhRUEw3C1c07K41jU569rfkivCUVI6PdZtqg7MxF9A381n0889qWqWRLfriS8KG8MUHQkK3Hms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728295; c=relaxed/simple;
	bh=rZlVo0hqETHHWosbDDO1yCZXsWvpf7FQP7auewrGHgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgcOAxueSkYhyDhbCCAUBVcZxXo1+chp2J2GMXxEQbzjLFjxUlHoROhifTCsHZcAZqh+Hjz7fLHY2mOPSmUnVq+5J5wROrvKIi+lilIkJ6P6cey77Vz7yLHcnF9Upk/6lPBlb0Nmnr3dmRgB7K8NieQ1WLKHqMt7fTo/76TCPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPsNtg+u; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso439994966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760728291; x=1761333091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhR7N/1fveVtt6wxaFP4nn/bZMr+K94/sut3rmsfdTg=;
        b=ZPsNtg+uEziD3Lq0OoqRsQwYiROSHbXhXNbmwPYq6A+WQ3BTG2glApmFPScJQg28fK
         x4P4bRtnVsnmQC+jcVEIY4FfONyUoAnSQHWKqOw4s8MMftkySjdRsaoCYNtoX3aNKutZ
         MkqCvr/ShEXbxWd5pE9GcdDxhCs4g+EWOOCuVvxZj0Kp1a17WacGXDFgUfUesqjIyuXm
         UkysWd7Mn669Wq9kwKKKFR/JW+rrzm+T3Za7qPqJAwmd8JSEtzKoI1jil9v5rt96GkAV
         OKOlcemI798oPT9QBkMFFUlMSOhUtyEsz0V6JYLjP3+ReU+vTGP9VmqFKhShdbvJe6L1
         aiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760728291; x=1761333091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhR7N/1fveVtt6wxaFP4nn/bZMr+K94/sut3rmsfdTg=;
        b=TQcAH3NhXIiVeWWBHAWxIflJz3r0ZUj3lI8PQczY6qaeZlCcCz2MTzt8dMgW0H4P8g
         CUJz+32gxzbdCsF6A2npylfsEmXppkWMNIBv3fCGO39NBsSE3fPh3yADDySALz8Ge6xl
         uJ+puMOVEgfNVUtJoUJKmYjAbHmkUHvVKyFAnswE0fLFI9/3m4ZocrYos0Id8A7sa0sK
         6JsqF6RBnbZRO0dE7eSV+Z70isp13jTnLuUoqiwGNqcAk6PxLhIMd8eGwYsfSbzPjppH
         GDQGhlZ4SB7vg+bkjprkK/35/LsSYbckn1gGegddNGzEH5yx5e9O3Y4hIhZHY50WstVT
         lCzg==
X-Forwarded-Encrypted: i=1; AJvYcCWObYGfqCz9KbugsCjgs+CbzSWS6Xg0vLtZzg9hx+VqYw2vmGW/megcTtIjQYC9XH4nPxjrGnt0cmw2cn1m@vger.kernel.org
X-Gm-Message-State: AOJu0YxIwYd6ScloZoHSuT1Uh3UD/IUcHoUmblmiLvn15+y7nekcRiks
	pkfMdGsf1M2vaBEgG7bi8Eci+R7oSXFhY0V6baj4mRMHZaaG7/5VI005MGSGC8UoCeHGEWRfvxj
	in4RMNkp+uHUTdTnFw/+fgd5I0yGjN5g=
X-Gm-Gg: ASbGncu0LaRDfhclmHwZiLwc10F7C1UpBTupodfa8igEnxo3JFnhKOXscg6Qf8Et1QY
	/bGeGn42nKdlVidVYf+XC7UyvjlNRcRcQ1m1QtKrtnWV/JuC4hJE53JCf5shO3Qr5TOqW1jId1u
	K3TjIAJwh0XpegVJhj1Jpn8y2eAcfkVGnsBDMasgtZ9RVzt8EwRqXsOTI1p/N1pkk86lYdKSA0l
	lHsqw0Dr6OU5YE0bFHaaUP6vEnewU6CNpIxrqPRNvLA8fSPW99+ossf2BG/A10PlkHpFGpdgiTj
	jFGDsQ==
X-Google-Smtp-Source: AGHT+IFDOlJ6XYwDeGzUOeuUv7tu/n9jNAnoTgbcA/YtbUqQ9ooDi0ZvO1Y7Lz1HWF/EaVHKgjB6T0ljyIDFi13wLII=
X-Received: by 2002:a17:907:940f:b0:b40:e687:c2c with SMTP id
 a640c23a62f3a-b647394ce7fmr469325666b.37.1760728290384; Fri, 17 Oct 2025
 12:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016033452.125479-1-ziy@nvidia.com> <20251016033452.125479-3-ziy@nvidia.com>
In-Reply-To: <20251016033452.125479-3-ziy@nvidia.com>
From: Yang Shi <shy828301@gmail.com>
Date: Fri, 17 Oct 2025 12:11:17 -0700
X-Gm-Features: AS18NWBFTKLOBvlIpa6FLOiYX2FyPcTBMCd4lweftBhZd_zGhKkHrG1wKzTNxSo
Message-ID: <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio handling.
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, 
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:38=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
>
> For soft offline, do not split the large folio if it cannot be split to
> order-0. Since the folio is still accessible from userspace and premature
> split might lead to potential performance loss.
>
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/memory-failure.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..443df9581c24 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn,=
 struct page *p,
>   * there is still more to do, hence the page refcount we took earlier
>   * is still needed.
>   */
> -static int try_to_split_thp_page(struct page *page, bool release)
> +static int try_to_split_thp_page(struct page *page, unsigned int new_ord=
er,
> +               bool release)
>  {
>         int ret;
>
>         lock_page(page);
> -       ret =3D split_huge_page(page);
> +       ret =3D split_huge_page_to_list_to_order(page, NULL, new_order);
>         unlock_page(page);
>
>         if (ret && release)
> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>         folio_unlock(folio);
>
>         if (folio_test_large(folio)) {
> +               int new_order =3D min_order_for_split(folio);
>                 /*
>                  * The flag must be set after the refcount is bumped
>                  * otherwise it may race with THP split.
> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
>                  * page is a valid handlable page.
>                  */
>                 folio_set_has_hwpoisoned(folio);
> -               if (try_to_split_thp_page(p, false) < 0) {
> +               /*
> +                * If the folio cannot be split to order-0, kill the proc=
ess,
> +                * but split the folio anyway to minimize the amount of u=
nusable
> +                * pages.
> +                */
> +               if (try_to_split_thp_page(p, new_order, false) || new_ord=
er) {

folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
to order-0 folios because the PG_hwpoisoned flag is set on the
poisoned page. But if you split the folio to some smaller order large
folios, it seems you need to keep PG_has_hwpoisoned flag on the
poisoned folio.

Yang


> +                       /* get folio again in case the original one is sp=
lit */
> +                       folio =3D page_folio(p);
>                         res =3D -EHWPOISON;
>                         kill_procs_now(p, pfn, flags, folio);
>                         put_page(p);
> @@ -2621,7 +2630,15 @@ static int soft_offline_in_use_page(struct page *p=
age)
>         };
>
>         if (!huge && folio_test_large(folio)) {
> -               if (try_to_split_thp_page(page, true)) {
> +               int new_order =3D min_order_for_split(folio);
> +
> +               /*
> +                * If the folio cannot be split to order-0, do not split =
it at
> +                * all to retain the still accessible large folio.
> +                * NOTE: if getting free memory is perferred, split it li=
ke it
> +                * is done in memory_failure().
> +                */
> +               if (new_order || try_to_split_thp_page(page, new_order, t=
rue)) {
>                         pr_info("%#lx: thp split failed\n", pfn);
>                         return -EBUSY;
>                 }
> --
> 2.51.0
>
>

