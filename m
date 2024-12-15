Return-Path: <linux-fsdevel+bounces-37432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9D9F2202
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 04:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE7247A087E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Dec 2024 03:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B39454;
	Sun, 15 Dec 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4trGbL1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0880979D2;
	Sun, 15 Dec 2024 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734232255; cv=none; b=epbDGFu77nyY4i/lVgdbzB7bJ/TfRaPskjaK21j1SEsYpRtjwiKYrR7ELcUme+j+GRn/nINIVLKgDlvU0k2HSYw13nzkTdo6vrZETNe+RtWB09CHvv2kmh76g6AlyEvsJn5c0+uPJUKk8C3jRopbTthhr/QQ0ChAOLmx76n6i0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734232255; c=relaxed/simple;
	bh=IizuzCgImeBZsiKbSoTeAlUg+T712L5odw9MCAKyUIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxumSIVwnnr1kewgdgZT3+NvFTHHECykDd6o/+GGYzHlLp+RghFL6J5gq6xTVq2HOct5Cd3c2jSZ9pSwxcHHlQk6tDEWwC52LQJbeYwWQUvhzs9M5UINKKN6TjmuLxc+FoIkCV7+JKLhxcaCdpB6n596OLBCxBf7PFwrEv1jL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4trGbL1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8f916b40bso48100246d6.3;
        Sat, 14 Dec 2024 19:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734232253; x=1734837053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAg9Dt17My/poSoH2lviKlhhmYoW3u3q6pccNlEuOo8=;
        b=C4trGbL1Q7mNPrdAoSzct4pJNCkcKAFBXz0HQG2yb6aIzZqexkWGOUdVuXb/gqvMcI
         qLEAcMtt3cnnJRCROEaaiYGjEHqNtw4rzNJaEC0Q3SDjus9kwyBBUXFLobvSHCqlAAje
         lsjDDrwgfO1DYHczKBi4j9phBun4qdVp40SSmLXj8e04b7aYLf1QVjTc21xEuHanUU+7
         uyQiZ3D69VHcM/R36n6xcExByOtPbEZ/as4ghEj+nE67PSU5OOJeUeg2v7LWS9WqTsQz
         OeEDBaossU70OLv8iCq3P9+QOhjAVWeR/QK/jfwbRgUHjb5KK8bYSKbXHuLekTKiw2n4
         SGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734232253; x=1734837053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAg9Dt17My/poSoH2lviKlhhmYoW3u3q6pccNlEuOo8=;
        b=aE+t8WlIeJDbkKwnm5gDpVDYybH649G5fHawQntfcjh7O8aBFmcwqfrldLEOdcxVG6
         X4ICArlrcMcn2ELKZwf/dkbmR/qEa70nDMHGa9NXlcmjfTF9SJj+QD48sQRzm5alAWjy
         9oL5e+uJY0jtU9HpaPuQhODPwiL1EqxQogUFte/y3+IX/+lkR7dzqU1OvIWeUWa0cXwF
         1zi4i2P7j41JCL9dGrIFYdZnkBDo2bfqwcmMi9bHIvOqZU2jAof9yuVi2YceANg4Yh8y
         21F2GP7ppMgI38pV0e+MTf55dsPyxd6Fxtwjm7O4S78GtFQ+MB2p7Eupg92JNMKF5zD0
         BJQg==
X-Forwarded-Encrypted: i=1; AJvYcCVry0ad5HgD+sB1lTktxj45DNHAMyWo3rxthN4navLwvtz/2mQaHuUIH7f2odDFBs7X6gaySn0bI5k6ryom@vger.kernel.org, AJvYcCWiJ9mM8cN2TLaeN7ebV07CP/aNDwLCNnbuWURQGmg82lcvV9VwmHwccOJZ2k7NFxvRoKSKbg1i@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+iJFiYwv47fwoA6AJkwWIabU4YzFr9SzPES381ahH/k7geBm
	fNzFjZMq1cHUfkcwnLvargnuOy5rYn+vna0TSTV+SYEjrzT23RKucO5p532PUL3hXFe3VG8NTpW
	+v6ebWlqcwot+p/r+U9JRok8yd7s=
X-Gm-Gg: ASbGncvVEuRujPV+OgwX3iUK1ZtGRpe42qsc29/Za3hVmr98dHvrP3yzGa9Ab7xekQ2
	llpKD5pCNnm3I5edg2iJ8CGbaJCgiugtkTgIsFOE=
X-Google-Smtp-Source: AGHT+IFeP/0vYFVff+ko43d8W5hG2jzmDAJOPoSV/2Ia3Km3xVaOa6aGqs9rkpo+RFoGcHGxCIySFjTVwuXobAIAyK8=
X-Received: by 2002:a05:6214:cca:b0:6d8:8f3d:4d82 with SMTP id
 6a1803df08f44-6dc969a9b19mr119280226d6.46.1734232252887; Sat, 14 Dec 2024
 19:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206083025.3478-1-laoar.shao@gmail.com>
In-Reply-To: <20241206083025.3478-1-laoar.shao@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 15 Dec 2024 11:10:17 +0800
Message-ID: <CALOAHbAGOwax+LOo0weyesA=9XfY3hDwUHqunz=24Viu=pjy5g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/readahead: fix large folio support in async readahead
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@redhat.com, oliver.sang@intel.com, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 4:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> When testing large folio support with XFS on our servers, we observed tha=
t
> only a few large folios are mapped when reading large files via mmap.
> After a thorough analysis, I identified it was caused by the
> `/sys/block/*/queue/read_ahead_kb` setting.  On our test servers, this
> parameter is set to 128KB.  After I tune it to 2MB, the large folio can
> work as expected.  However, I believe the large folio behavior should not
> be dependent on the value of read_ahead_kb.  It would be more robust if
> the kernel can automatically adopt to it.
>
> With /sys/block/*/queue/read_ahead_kb set to 128KB and performing a
> sequential read on a 1GB file using MADV_HUGEPAGE, the differences in
> /proc/meminfo are as follows:
>
> - before this patch
>   FileHugePages:     18432 kB
>   FilePmdMapped:      4096 kB
>
> - after this patch
>   FileHugePages:   1067008 kB
>   FilePmdMapped:   1048576 kB
>
> This shows that after applying the patch, the entire 1GB file is mapped t=
o
> huge pages.  The stable list is CCed, as without this patch, large folios
> don't function optimally in the readahead path.
>
> It's worth noting that if read_ahead_kb is set to a larger value that
> isn't aligned with huge page sizes (e.g., 4MB + 128KB), it may still fail
> to map to hugepages.
>
> Link: https://lkml.kernel.org/r/20241108141710.9721-1-laoar.shao@gmail.co=
m
> Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/readahead.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Changes:
> v2->v3:
> - Fix the softlockup reported by kernel test robot
>   https://lore.kernel.org/linux-fsdevel/202411292300.61edbd37-lkp@intel.c=
om/
>
> v1->v2: https://lore.kernel.org/linux-mm/20241108141710.9721-1-laoar.shao=
@gmail.com/
> - Drop the alignment (Matthew)
> - Improve commit log (Andrew)
>
> RFC->v1: https://lore.kernel.org/linux-mm/20241106092114.8408-1-laoar.sha=
o@gmail.com/
> - Simplify the code as suggested by Matthew
>
> RFC: https://lore.kernel.org/linux-mm/20241104143015.34684-1-laoar.shao@g=
mail.com/
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 3dc6c7a128dd..1dc3cffd4843 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -642,7 +642,11 @@ void page_cache_async_ra(struct readahead_control *r=
actl,
>                         1UL << order);
>         if (index =3D=3D expected) {
>                 ra->start +=3D ra->size;
> -               ra->size =3D get_next_ra_size(ra, max_pages);
> +               /*
> +                * In the case of MADV_HUGEPAGE, the actual size might ex=
ceed
> +                * the readahead window.
> +                */
> +               ra->size =3D max(ra->size, get_next_ra_size(ra, max_pages=
));
>                 ra->async_size =3D ra->size;
>                 goto readit;
>         }
> --
> 2.43.5
>

Andrew, could you please drop the previous version and apply this
updated one instead?

--=20
Regards
Yafang

