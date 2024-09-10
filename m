Return-Path: <linux-fsdevel+bounces-29036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7155C973C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317A3286683
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA219E80F;
	Tue, 10 Sep 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6Y7DeRY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30077191F82;
	Tue, 10 Sep 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983014; cv=none; b=r/4L+qI5kL5trUdvg3YyjUACci3wLjigD+8wrQhNRnw9A7FZJfEqntVXcf5FjIGspSjjYVgg/Z4NihL477m7HpwgxTTIr/7+R6pa8NK+eceTJ1oxhN35PjMwP5eREApju3hbBXCxIrG9rCYjFfGdOHfACMYCpQ6AbHfzDV8ccxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983014; c=relaxed/simple;
	bh=cCpInj7SrdFmk/5zLwUXhgOxaMyyJgq0aYBt3L8xf2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMWQFKXV+zz4+lxvR76SA3zU0g/xhCQBekN6qJrVal0P3V9q7wr5NrdHWrHDx8imShSqTsAwXZU/h+oyUipEZpLyM19RlIjA0407jXGQwRHnqNs3qcF7FssTlH+ZOu/0vukCL2vVe765eWNDk6HLUYt5r+z1HdyJBeekDgZRWpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6Y7DeRY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c35b545b41so61940906d6.1;
        Tue, 10 Sep 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725983012; x=1726587812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+c1Ws3i4xnxafy/8/uhCyz6F73NXZODVZEQSxTuP6w=;
        b=V6Y7DeRYn3o1q00VS0u9PX+FonKsxr7AvWr0EtKc0fZx/BariHhHqFELYeOO93iC0z
         tALuraUHZOGSeKVf4m2WpZ9f+JtO/VvLxG38rSpf+NcisO7bGIGgE7TV4qdkazfVIsMj
         g45pLLUJasuxbE8IbczmiHkheBaP4eSz3yrao5sPqTDSyTvYJTsw7hD1HWU2tS6oGYPE
         ULxWoznch6aWEJ2NRamguYnqACXi8pXmObp6sxnT8NnsGU1XsWHIAhWdpxPcvB7cqJdn
         /idQeRBYiwBrTvUeO7AB81u7YlGpB86FklectNYbsEy06pi9Hc+jfhw3Ei+5btmOFdcL
         7l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725983012; x=1726587812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+c1Ws3i4xnxafy/8/uhCyz6F73NXZODVZEQSxTuP6w=;
        b=Zzx0ctOyaPK67d2hjXA9p6gUrNGhmDCNIN8UbwP/TSLlAqKlubrFbQtBDVGpt82IJJ
         Ll8PFvzCMxf9JsVvQLUASCa6+8zUdGTRWKdx37cMAqEf3OEuif1gy29VhKW98WX0JriZ
         HAoADr6eyqqKlOA2H2N5U7mX03PdEIfK7W2Rgh00gwAOYKvCz2b/X+Ox0nF4hnZHPAOB
         DJwbh9YUs/fay9i5UxMNYCV48GR4lSbU1rC8Sa8JgT+QHyTLzKzWtpUT5ssj4uiaIbMW
         DRT65Cturm6Wjff542ShqYjleWpCPpJ7hAf+iwV8+BZBIK3ewSuzetBYszxEt0cYqfXU
         6UYw==
X-Forwarded-Encrypted: i=1; AJvYcCWurW/RIXyf79Ws2icnPDSxW93nLgewhxEDjUnJ12turVfITnuhZfSr8njM72N2cmgbXkhk2R74YehoauSl@vger.kernel.org, AJvYcCXd2H4bzk2gHUZgh2iwqZbdYje2EbDjxrIMmc6sFY+Xg/4ZCAirsR4q4ZMSLbEJm+DWNmTFsn+VPg+OWrrp@vger.kernel.org
X-Gm-Message-State: AOJu0YyuSKISgEfOyk++iRkCiAUU8XILHys2CpLJCwO4YJBn08MTb8AT
	zCuAd5NH1gOHVrWIKoMAxu8vE+MVMsnZWlSXp6aRwtpDqk9l8lkDFRxAPTsXeBGEfTBXJIOLqQb
	ztDUiZUBKYtSlqLM6d2+7t+w+CuM=
X-Google-Smtp-Source: AGHT+IGG4nYFHZ+aDiM1pYnJoOv987Lq+iKjTpG3FbL9Qloy6SL9gI6dtK19ybwDEn+hCKo3gAQixZAAEG4R6C1Wnm0=
X-Received: by 2002:a05:6214:3a87:b0:6c5:5b0b:d2bd with SMTP id
 6a1803df08f44-6c55b0bd473mr29374256d6.25.1725983011982; Tue, 10 Sep 2024
 08:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906230512.124643-1-shakeel.butt@linux.dev>
In-Reply-To: <20240906230512.124643-1-shakeel.butt@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 10 Sep 2024 08:43:21 -0700
Message-ID: <CAKEwX=MgjrXjai8enV6bFXsv3=gJoQ2p---8nbQMNcvfbqdN3g@mail.gmail.com>
Subject: Re: [PATCH] mm: replace xa_get_order with xas_get_order where appropriate
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 4:05=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> The tracing of invalidation and truncation operations on large files
> showed that xa_get_order() is among the top functions where kernel
> spends a lot of CPUs. xa_get_order() needs to traverse the tree to reach
> the right node for a given index and then extract the order of the
> entry. However it seems like at many places it is being called within an
> already happening tree traversal where there is no need to do another
> traversal. Just use xas_get_order() at those places.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/filemap.c | 6 +++---
>  mm/shmem.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 070dee9791a9..7e3412941a8d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2112,7 +2112,7 @@ unsigned find_lock_entries(struct address_space *ma=
pping, pgoff_t *start,
>                         VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_ind=
ex),
>                                         folio);
>                 } else {
> -                       nr =3D 1 << xa_get_order(&mapping->i_pages, xas.x=
a_index);
> +                       nr =3D 1 << xas_get_order(&xas);
>                         base =3D xas.xa_index & ~(nr - 1);
>                         /* Omit order>0 value which begins before the sta=
rt */
>                         if (base < *start)
> @@ -3001,7 +3001,7 @@ static inline loff_t folio_seek_hole_data(struct xa=
_state *xas,
>  static inline size_t seek_folio_size(struct xa_state *xas, struct folio =
*folio)
>  {
>         if (xa_is_value(folio))
> -               return PAGE_SIZE << xa_get_order(xas->xa, xas->xa_index);
> +               return PAGE_SIZE << xas_get_order(xas);
>         return folio_size(folio);
>  }
>
> @@ -4297,7 +4297,7 @@ static void filemap_cachestat(struct address_space =
*mapping,
>                 if (xas_retry(&xas, folio))
>                         continue;
>
> -               order =3D xa_get_order(xas.xa, xas.xa_index);
> +               order =3D xas_get_order(&xas);

Yikesy that's my bad. This is late, but FWIW:

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

