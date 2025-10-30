Return-Path: <linux-fsdevel+bounces-66413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D65C1E509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 05:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EA734E4D34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 04:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C492DC33B;
	Thu, 30 Oct 2025 04:00:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE821DF97F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796841; cv=none; b=AUcx+wwn5xylc4IxxMvOJZMSPADtevjsaGBHS4NT5kCVeU5Qstyhzgh3gOoKvU4sy46bmRbCMrFxVGAomqDOhjbQRnvAxY0OWpvroifEBCWVo79f3COiqi84WkG605NXAMVY8c33i/PizH39jrHrxc2bIfFdjl6HCK4+RU99RgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796841; c=relaxed/simple;
	bh=OPqga+jPvzjiv0t7E/GuszX8kP8cT705M59xu+M/iJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4cznysVHVvo6+fYtI4f9cVKBiUhCa5fWsE+7C3wQAOevzDj8qJVtB7wNn2TOHPZHRghQGVltfGmq479uwyebUYNcDyH3Tk0CndLyB0J5InHiY6l6qm1mvfwq+MkomqnieW0F5GvfkgDjBV4u6X7Nrwd7OTxmTFUbqgzncaEsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8a84ba42abbso66422085a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 21:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796839; x=1762401639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7UkojjVw8iM7ylju2DINYd3+c72O+36Bo2eWT6QfKQ=;
        b=cGCQAb2tCiz6JWGEfyhQ/VienKwnwUtZttqV7am9o3oyiAKfe8SGnrcMUdUH8EldZQ
         Mn7qCmYftCffyyEw1WdIxGsRdythy1CNLQWZJe40tqlqDDTTgywYwOxLyiiKzyTVkpCH
         oUj49xPL3kHm4SAtEqaNi7aA23RtC7lI93to8TTSXoO7Ba18EZlqBjdy0KoTloOWiLsB
         2ixsGiS8j7FkOZ3jvQl6QOmStGaEU9P0X4tQG6G/lDkOkhbYW8n9WGV3GL7BxFInerGQ
         uqJJ92SuuR22xCTyHJOVRMgx36Z77fe6ylSPSMVlen2UYTwl3q6hYTTPsfNnTrdxZK9o
         4m1w==
X-Forwarded-Encrypted: i=1; AJvYcCXAeTjNQsEA+yl4uhs5LVNVqRmsZ0SgT3Nf4/BHoyQM9P/7G33M6bbq5vnV8JPaeVNSqdyXBLMRFPwoiA8B@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1HrsfCcUpZ/DAJo+wlu8YsL4f11dxZ8vo7vHE1kLRK0zK+re
	Kv4R53xGT0gKzSMO+2hcaufpy53CvpbAUJ1I8XKMxm74CQO4Td5AQRx7GX8c/b/me/k67lh/ptQ
	QoOMte9jjvL+oZMtOpwmWHTCRF5/p9as=
X-Gm-Gg: ASbGncu57n/Qp5V1g781lF7Q/XhbLAxKA09KlGj/IqBjoEV2uEAkNY4Wav0pRV+gH5a
	OOO/JQbdgHM4enks/BIZN6q4BmmoT9+BFsZiiLhjTXnQQU+QbgI/ks8IjZswBWQVcRZwwWWL8iz
	Y3OvUNE0Bd1g/3C84BEzTNBomq2m+IeoGwGD3nwi6/tAo+QNfQP0+QYm/6iOOnPOM683MdA108l
	fQkpv9+sasOOTS6Kf09J9EW0kfSSlhSqmrUeaDv+5DpeMHlPxYMEoXleA+WAYXbmYNKFeUQp10W
	ePpdlCYLV3u2cwhtXS4JG/OBPbo=
X-Google-Smtp-Source: AGHT+IHKRNW9sNDGCaX61D0IJSW//S9X5fcnVpi2KVH8DIVv8SCmHI0Nvj5CkCvxgW//clbJrEgQFB4JLZk0JktmY2M=
X-Received: by 2002:a05:620a:3915:b0:811:33d6:1aca with SMTP id
 af79cd13be357-8a8e34d3881mr764987085a.1.1761796838904; Wed, 29 Oct 2025
 21:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030014020.475659-1-ziy@nvidia.com> <20251030014020.475659-3-ziy@nvidia.com>
In-Reply-To: <20251030014020.475659-3-ziy@nvidia.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 30 Oct 2025 12:00:27 +0800
X-Gm-Features: AWmQ_bmug-ryKCzBbavCMxdeQ4VhZPQSA41Fu9mlb8w6XWO_CcoeHvXWOnYu5Oo
Message-ID: <CAGsJ_4xWOhG5dfVZ2XmmVcXDPicRKiBB__=3W6Z9umXjn4M-Ww@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/memory-failure: improve large block size folio handling.
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com, 
	kernel@pankajraghav.com, akpm@linux-foundation.org, mcgrof@kernel.org, 
	nao.horiguchi@gmail.com, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Yang Shi <shy828301@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:40=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> Large block size (LBS) folios cannot be split to order-0 folios but
> min_order_for_folio(). Current split fails directly, but that is not
> optimal. Split the folio to min_order_for_folio(), so that, after split,
> only the folio containing the poisoned page becomes unusable instead.
>
> For soft offline, do not split the large folio if its min_order_for_folio=
()
> is not 0. Since the folio is still accessible from userspace and prematur=
e
> split might lead to potential performance loss.
>
> Suggested-by: Jane Chu <jane.chu@oracle.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  mm/memory-failure.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..acc35c881547 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
...
> @@ -2294,7 +2298,16 @@ int memory_failure(unsigned long pfn, int flags)
>                  * page is a valid handlable page.
>                  */
>                 folio_set_has_hwpoisoned(folio);
> -               if (try_to_split_thp_page(p, false) < 0) {
> +               err =3D try_to_split_thp_page(p, new_order, /* release=3D=
 */ false);
> +               /*
> +                * If splitting a folio to order-0 fails, kill the proces=
s.
> +                * Split the folio regardless to minimize unusable pages.
> +                * Because the memory failure code cannot handle large
> +                * folios, this split is always treated as if it failed.
> +                */
> +               if (err || new_order) {
> +                       /* get folio again in case the original one is sp=
lit */
> +                       folio =3D page_folio(p);

It=E2=80=99s a bit hard to follow that we implicitly use p to get its origi=
nal
folio for splitting in try_to_split_thp_page(), and then again use p to
get its new folio for kill_procs_now(). It might be more readable to move
try_to_split_thp_page() into a helper like try_to_split_folio(folio, =E2=80=
=A6),
so it=E2=80=99s explicit that we=E2=80=99re splitting a folio rather than a=
 page?

Thanks
Barry

