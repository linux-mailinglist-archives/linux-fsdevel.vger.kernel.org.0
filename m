Return-Path: <linux-fsdevel+bounces-22556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8D3919BBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 02:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9046AB22369
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1888F23CB;
	Thu, 27 Jun 2024 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grh9kd7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE215B7;
	Thu, 27 Jun 2024 00:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719447813; cv=none; b=ew/OQHpsO4wLpAHw965w09km/DCi99zaqnkxeHFzitUoxgQu+SUD7nBFBIhTx5BBPJZnF+Lh75N2uZWq8uzdFZrOYFEdU99kHhC8kohHe0t0APyxfUYT52zSgKjQOYv4xn1GOANYckTgBIGbFjbQfyeNfDNsxfd0aR/z3q7TAlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719447813; c=relaxed/simple;
	bh=IN4hTFo1Axt3yoFLYSXJOnwonckWm9p64AYaZnD94FY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9G9oFVX2p1ucAKfhV9lgGVCbXqc3S5VRyI2W0uzx1krEheZIxkwqhFEpNrxcdZBiZ+OA1V+5aNioEHIUlSHLRRt7DJk1lSil6jdOuPx6xzmzCprpZ5nbgVr2ObJ3yBUKu19nRTLkJKxumVyW09QdRll07zBSfgyTEqMIZ41Lyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grh9kd7s; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdf2c7454so9046488e87.1;
        Wed, 26 Jun 2024 17:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719447810; x=1720052610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4O4v3oTH5yhuGGA5CG0CRKCcEGuOpA81lZvmbZ2npc=;
        b=Grh9kd7s9VACYihDiHpV2AXryKnwbXmHz6s3GZJHQTPezZTIPLY3DnaO+qu8sn6NJY
         Tug/RTX1dEUhU97OzGf6uzR4gGvLYO96uc36OLmKHNajd1YvK2wub7fq+fhCeJRIDqnw
         9Q9/b1wwpNculNczvcXsTN/VymDScow6/BPMY9oNc4k+fUd1B2i0AHclq/7qKUEmpvop
         3fy1ZSNHcOq/3mdVYDUcsJVHAIba2wNs4FZk+F66FrI8l7EbBE0VNxyoadQR3zFyF35s
         nBBVsuEWjZjQ7d8eF21JqTA0uMlGO3PuNQie9cF8a9sFmOy5/RipUG0yttBoi3qMqllL
         jP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719447810; x=1720052610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4O4v3oTH5yhuGGA5CG0CRKCcEGuOpA81lZvmbZ2npc=;
        b=BFB7RQjVlQcjizqOH/ORQxPDPHd4DmXaFkn2tIBrIBRq/ssjWHm4V/puE2cEY/npcp
         t84iXs7rJ9VExr1cNFEk6J4tlwJSXq2rJkNpoPpIyeiKiP+dg172bpBOiTSDQcs5bQ8O
         nhQgC4M2mfaExtXwe3lNGEgKPuEKg4AseX8bcdhF5NaaW4cnOtd4XXpeZQlz20pwupj8
         UNKXhJvCy3wa+W6CI6yAaHS3SeTgqqZGFehnHlhwIovYYqO0vG2SRMpJtAGNmcJN3xFj
         w/JycpQacov5JsznjZVlXmBiM9dWXtb+wT0vi5HtSzVE/nSs38O649+lJ04t+DztustI
         G1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhqSopG8x3r31MbeOViLnMsy1nOF6LbaSxD6/K6fNVRGCuUjy8yXNXFQYKp1gad0PZne8R4P+ZG8ivRT6kzv4rbGtiW7vvT4OHLFvL3Ndp3R9+yLOFs9P15DrUx2P/kLRShAeSFGqu9StO4w==
X-Gm-Message-State: AOJu0YwAGsRK56jVpDhtSocBboGZ8xYZuxacc+nGhaW4GAwnfSTH6XmQ
	U55SSuXgpoS8iLjyyau+tPC+v9uRqPlPMYS8j5t+7c+zc/jadox77UAoCgpGopyhMwMF0FcZx92
	a2O2EMMj/lOQN+kSIu8/S69LdXdP6ng==
X-Google-Smtp-Source: AGHT+IGIBDv9X5GNWfMqDluMIqpUDUOXw9OhHZYFzvb0LpeWdG2/E0UsRSPvarB0AfOc7fO0/Fsj9Di8fn4PcnIm3Nk=
X-Received: by 2002:ac2:4c8c:0:b0:52c:9ae0:beed with SMTP id
 2adb3069b0e04-52ce18526ecmr8722081e87.52.1719447809281; Wed, 26 Jun 2024
 17:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626084406.2106291-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240626084406.2106291-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 27 Jun 2024 08:23:18 +0800
Message-ID: <CAGWkznFxkm5DihSGDy9W-aSmtS2kU3_db9Ex-ZygMGDm_DEeeg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: introduce gen information in /proc/xxx/smaps
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop yu.zhao

On Wed, Jun 26, 2024 at 4:46=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Madvise_cold_and_pageout could break the LRU's balance by
> colding or moving the folio without taking activity information into
> consideration. This commit would like to introduce the folios' gen
> information based on VMA block via which the userspace could query
> the VA's activity before madvise.
>
> eg. The VMA(56c00000-56e14000) which has big Rss/Gen value suggest that
> it possesses larger proportion active folios than VMA(70dd7000-71090000)
> does and is not good candidate for madvise.
>
> 56c00000-56e14000 rw-p 00000000 00:00 0                                  =
[anon:dalvik-/system/framework/oat/arm64/services.art]
> Size:               2128 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                2128 kB
> Pss:                2128 kB
> Pss_Dirty:          2128 kB
> Shared_Clean:          0 kB
> Shared_Dirty:          0 kB
> Private_Clean:         0 kB
> Private_Dirty:      2128 kB
> Referenced:         2128 kB
> Anonymous:          2128 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> Gen:                 664
> THPeligible:           0
> VmFlags: rd wr mr mw me ac
> 70dd7000-71090000 rw-p 00000000 00:00 0                                  =
[anon:dalvik-/system/framework/boot.art]
> Size:               2788 kB
> KernelPageSize:        4 kB
> MMUPageSize:           4 kB
> Rss:                2788 kB
> Pss:                 275 kB
> Pss_Dirty:           275 kB
> Shared_Clean:          0 kB
> Shared_Dirty:       2584 kB
> Private_Clean:         0 kB
> Private_Dirty:       204 kB
> Referenced:         2716 kB
> Anonymous:          2788 kB
> KSM:                   0 kB
> LazyFree:              0 kB
> AnonHugePages:         0 kB
> ShmemPmdMapped:        0 kB
> FilePmdMapped:         0 kB
> Shared_Hugetlb:        0 kB
> Private_Hugetlb:       0 kB
> Swap:                  0 kB
> SwapPss:               0 kB
> Locked:                0 kB
> Gen:                1394
> THPeligible:           0
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  fs/proc/task_mmu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f8d35f993fe5..9731f43aa639 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -408,12 +408,23 @@ struct mem_size_stats {
>         u64 pss_dirty;
>         u64 pss_locked;
>         u64 swap_pss;
> +#ifdef CONFIG_LRU_GEN
> +       u64 gen;
> +#endif
>  };
>
>  static void smaps_page_accumulate(struct mem_size_stats *mss,
>                 struct folio *folio, unsigned long size, unsigned long ps=
s,
>                 bool dirty, bool locked, bool private)
>  {
> +#ifdef CONFIG_LRU_GEN
> +       int gen =3D folio_lru_gen(folio);
> +       struct lru_gen_folio *lrugen =3D &folio_lruvec(folio)->lrugen;
> +
> +       if (gen >=3D 0)
> +               mss->gen +=3D (lru_gen_from_seq(lrugen->max_seq) - gen + =
MAX_NR_GENS) % MAX_NR_GENS;
> +#endif
> +
>         mss->pss +=3D pss;
>
>         if (folio_test_anon(folio))
> @@ -852,6 +863,10 @@ static void __show_smap(struct seq_file *m, const st=
ruct mem_size_stats *mss,
>         SEQ_PUT_DEC(" kB\nLocked:         ",
>                                         mss->pss_locked >> PSS_SHIFT);
>         seq_puts(m, " kB\n");
> +#ifdef CONFIG_LRU_GEN
> +       seq_put_decimal_ull_width(m, "Gen:            ",  mss->gen, 8);
> +       seq_puts(m, "\n");
> +#endif
>  }
>
>  static int show_smap(struct seq_file *m, void *v)
> --
> 2.25.1
>

