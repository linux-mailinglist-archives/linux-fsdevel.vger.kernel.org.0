Return-Path: <linux-fsdevel+bounces-74305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 229D9D392E4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F04CA3015AA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9836329BDBF;
	Sun, 18 Jan 2026 05:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQcUNGji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287081946C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768713847; cv=none; b=ndCX0vNuox5oYElqX1U0MTmUTOqUBWc19zDrddhNi4m8MQYs3bGidx/oArO39Csx16Rcz1vkwqY4kdquigYvyrVzvSiQgL0gDNLou3jUBpvSyTSldC6qPm8lypl9sd3lRzVzUgKZGxvPC3sVq3NUCqKwgjZsEU6suUViGoGa0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768713847; c=relaxed/simple;
	bh=9fl3e2YCpxlLE25trOysHuVIKtI8wyRz96+uGmaG4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4DtzRnA/Ias8eKXEO1gPKZ47NmAV5TYm9kjQW+7GtnST2Zq6YcUTKzxl5Ekcab5GF57YrDpOQB+Kwtf69B7dy33LnnwlLAmwR4qajw94fidSfZPQC9EDIW7/6QvP3/FRiGn+wArGmHUcObMN2BPWPriQMy/1jOvq4LVkzpvctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQcUNGji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E62C4AF09
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768713846;
	bh=9fl3e2YCpxlLE25trOysHuVIKtI8wyRz96+uGmaG4CE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RQcUNGjiVcVFwuhPjXYeoNRYMDIb+bHoySgwmPLztw21icOVyHQpupVJnDL2S1kry
	 1gGPys4+/XXA/zEDfNTSvVpTqHa6sXoQ4mzobJj2AeR2q9FFH9whcZskvW3iDcEznX
	 OV7lediiZUmsF1lXAUqN9vkG2nwJsAJAXi7d2nZNGl4Kt8r+SN2OXaEysaBzC4AQew
	 97pkOU3xYbPt2of5+zy+b7Eck2ltEp/Q0kepePqdr2eCtYTLyBxO+AbNCiRWti+QcT
	 wOkCSp+INvW7srQA6JGo02lOl9tX3tIDTjHXk1yOSa19O+TQJPcLRm/JnjXB5KMG+4
	 A9mM5SD07JV/w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b876798b97eso530531266b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:24:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwpjJOqBcQUvWcZFiKxsVbB7W52RGiae+H0j2avf6G6HW4ureB2
	ygC89uFlU5sNbx+GzRfTvpKf1+cBs2wqgpfcH1sNxZYHUNdHraAqWc5rtJTvkiEtpkYIXvg41I2
	LMWBj58/AUX0e0oC7A9i98+9luMZfc2w=
X-Received: by 2002:a17:907:7b9a:b0:b87:695f:d2a8 with SMTP id
 a640c23a62f3a-b879324b8c8mr672476466b.55.1768713845353; Sat, 17 Jan 2026
 21:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114121250.615064-1-chizhiling@163.com>
In-Reply-To: <20260114121250.615064-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:23:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ri1KJ_kmPLJWeCh5A0Sf0OLKtmbvq5EEFJ=2=e51c6g@mail.gmail.com>
X-Gm-Features: AZwV_QjwPoDh3Pax5z2mIWYADlgJKtXzOcGrldWhc-GN1xyxg8nvi3W5zbZECUA
Message-ID: <CAKYAXd-ri1KJ_kmPLJWeCh5A0Sf0OLKtmbvq5EEFJ=2=e51c6g@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Enable multi-cluster fetching for exfat_get_block.
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 9:13=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> This patch series significantly improves exFAT read performance
> by adding multi-cluster mapping support.
> The changes reduce get_block calls during sequential reads,
> particularly benefiting small cluster sizes.
>
> - Extends exfat_get_cluster() and exfat_map_cluster() to handle multiple =
contiguous clusters
> - Adds buffer head caching for FAT table reads
>
> Performance results show ~10% improvement for 512-byte clusters (454->511=
 MB/s)
> and reduced get_block overhead from 10.8% to 0.02% for NO_FAT_CHAIN files=
.
>
> All criticism and suggestions are welcome :)
Applied them to #dev with Yuezhang reviewed-by tag.
Thanks!
>
>
> Changes in v3:
> - fix overflow in exfat_get_block, only patch 10 and 13 changed
> - add review tag for all patches except patch 10 and 13
>
> Changes in v2:
> - Cache the last dis-continuous cluster
> - Continue collect clusters after cache hit
> - Some cleanup.
>
> V2:
> https://lore.kernel.org/linux-fsdevel/20260108074929.356683-1-chizhiling@=
163.com/T/#u
> V1:
> https://lore.kernel.org/linux-fsdevel/20251226094440.455563-1-chizhiling@=
163.com/T/#u
> rfc:
> https://lore.kernel.org/linux-fsdevel/20251118082208.1034186-1-chizhiling=
@163.com/T/#u
>
> Chi Zhiling (13):
>   exfat: add cache option for __exfat_ent_get
>   exfat: support reuse buffer head for exfat_ent_get
>   exfat: improve exfat_count_num_clusters
>   exfat: improve exfat_find_last_cluster
>   exfat: remove the check for infinite cluster chain loop
>   exfat: remove the unreachable warning for cache miss cases
>   exfat: reduce the number of parameters for exfat_get_cluster()
>   exfat: reuse cache to improve exfat_get_cluster
>   exfat: remove handling of non-file types in exfat_map_cluster
>   exfat: support multi-cluster for exfat_map_cluster
>   exfat: tweak cluster cache to support zero offset
>   exfat: return the start of next cache in exfat_cache_lookup
>   exfat: support multi-cluster for exfat_get_cluster
>
>  fs/exfat/cache.c    | 149 ++++++++++++++++++++++++++++----------------
>  fs/exfat/exfat_fs.h |   7 +--
>  fs/exfat/fatent.c   |  61 +++++++++++-------
>  fs/exfat/inode.c    |  52 ++++++----------
>  4 files changed, 157 insertions(+), 112 deletions(-)
>
> --
> 2.43.0
>

