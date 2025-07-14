Return-Path: <linux-fsdevel+bounces-54895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F4B04ABF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 00:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8FE1A66F31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 22:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76AA230BD9;
	Mon, 14 Jul 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5u4JKb+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA072376F7;
	Mon, 14 Jul 2025 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532458; cv=none; b=DdPX2st4HdQ8PHvmEzXeOeTDR7j+ayMNspfpqZUQIVZ9KgyPvO8vdL3aB3xloaKNO2Z9je6SWwR8I5VwJFsTs/BF0cHFQJPzenWTjALJUaGxZdNmaOWdf1tqnDrNuCNInrmjy0byUwxSpw/Dp4zglMZMhwvdg/sYoBLikaQM9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532458; c=relaxed/simple;
	bh=W6v8lbE3JTdREJrkREG+NkOzPzswYh1Vlh1TFABX1hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk1NSe3g33uj7zv4EtxggSoURIb3WxfPXaPqwY2hPTQLDNspcZLrUYriNwuRX3uBUFWce9OboEjBPEZwmu/IWfcRtYVy3PJhsmzN8rJ5mA9iWIvFdFv0fOqIJ1gAL9uMZD+vXA/e9spIevJO+kfeY9yCQeP+5l6Ag3cJ/C/vDkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5u4JKb+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32ce1b2188dso43031711fa.3;
        Mon, 14 Jul 2025 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752532454; x=1753137254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/lsfIzpS/FedAznKrsoeJxLXMye9IFP7RjuGV3Aj11E=;
        b=S5u4JKb+nrPwofZmUwHA0RTsVp59iyoMAWLvnp+CyX8iqHx0bteYMtL8k99MSoD+8C
         a5rBj9vrxK7we7feGjU4BpQhT/MsHn7GcxJLUWFq8Qc9ip/2cT0ZvD6cE/OKR9TsKyUJ
         bdbrqvrh88ohLCtThvPV+IN4Bg58mDKRkYLe6KPzoUKPV1YABFFiiOPsey2nn2X5s9FM
         XcrfpohZxwP+JOu6KlSNonVKWQFEUQZYPjgIuZrw2/nSCkO/UatyA7K4V6VTlZ10VfyA
         D2gaqH0mFfFyG7hmILBgbbdcSGxkxRNf1eplCHkOssuZtnROx2QbQmbHJpnXNIlU3XZg
         swNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752532454; x=1753137254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lsfIzpS/FedAznKrsoeJxLXMye9IFP7RjuGV3Aj11E=;
        b=L3LNscTbss+fk575zAD138LMi3So0pvmDVcymBQQCWsdI3TCooEyibRcHcF42CBQ7I
         J3Udwgj+UAJkqrye2m1RHWe4RhpuqIdwA961HMXLgNbuLXiWICbr6u2cWVN6OckQCf2R
         Kt8HWPB6OYccPUVJhlCoxgbZU1hXE3XZiyemlvAYungm1ThfHTdvD2KKBNE/RZzWLm8G
         GizkrKiotDsPUZhCTiEf0l3DQ0DjghH4/fHhZqq5U5jUmxSHESHsZrUBDbc4c2DZsflb
         vJYHXQm1Z9eD28xWj2jQTMkgw1NPm+x3LozbJWmoMyI8RdV4B1x2S/aFS2hx9jLQhTFV
         AHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWn9IwNR+MeVgqWCHqoaOqtp/ovbzlC5LBxLYhRYpca21euIBzEUbzzS3Fa+zaXFuEL0COjMXy9/eRB6XQ@vger.kernel.org, AJvYcCUsq7oTbSbYz2C49Q3mPbEw2VE9DKEGewiZC6zH9543bgSOtC1fVWoM4sQO2Mcz+Q2DbiyVCM52vfjHo+gt@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQHhetJo4ATtXGhbYP5nWi5TurFyNw+/ZrklMXA1MeS605r6R
	TY1wmlaerpkN4Q69wE2yhvampSVOM4jfB0/KBP0eXFGsnoa+CoBp5CxgaRFOYg==
X-Gm-Gg: ASbGncvzyfV8vJaBMxUQZRpQNbUmqNuWFmKQdcYCEPvFysG1XF7bV6N8UizGZZvpz0X
	NadC4pgAt0BpWiThzIOFxiHcfCY4EnlhGuqrJRQQJHXRisHMFjPUtQFsrNOEw6wQPgEbRY1sT6Z
	XypSExaUC1GHUJVTe4ga7DG1oBl3oelEM4fnB0Zizbd4slJHCbqpN8mNtXxYtvVV5jxA3Rkd3x+
	/jYZHfl7VXV30+vLC/ZCAWxw9F67sbx2tKZBFxtwls4+veWqiGFV+5/LVyjYLMbKyo5I/Q7uF6m
	Fo4B7YJlCG0K8hkumOCBWUhjq6goDYK2Oa9DDVe7TqBpvnAq+kK+9BzZ8/+FDViHeBAUmswNQ1f
	001K74ugZz5BUUFVThwsp/zdMXoQcwPh+IGjm3A==
X-Google-Smtp-Source: AGHT+IFbEs0ZIkKVf8Yeir4vPF7NLzO/D3Zi0Tryd7KVEWog+DBD5fk2bx5TP047Ps/J9OHvdNCFLA==
X-Received: by 2002:a05:651c:1a0c:b0:32b:7ddd:278d with SMTP id 38308e7fff4ca-330532d0515mr34780581fa.3.1752532453644;
        Mon, 14 Jul 2025 15:34:13 -0700 (PDT)
Received: from localhost (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-32fa294bbf3sm16610651fa.49.2025.07.14.15.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:34:13 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:34:12 +0200
From: Klara Modin <klarasmodin@gmail.com>
To: Youling Tang <youling.tang@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chizhiling@163.com, 
	Youling Tang <tangyouling@kylinos.cn>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] mm/filemap: Align last_index to folio size
Message-ID: <yru7qf5gvyzccq5ohhpylvxug5lr5tf54omspbjh4sm6pcdb2r@fpjgj2pxw7va>
References: <20250711055509.91587-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711055509.91587-1-youling.tang@linux.dev>

Hi,

On 2025-07-11 13:55:09 +0800, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> On XFS systems with pagesize=4K, blocksize=16K, and CONFIG_TRANSPARENT_HUGEPAGE
> enabled, We observed the following readahead behaviors:
>  # echo 3 > /proc/sys/vm/drop_caches
>  # dd if=test of=/dev/null bs=64k count=1
>  # ./tools/mm/page-types -r -L -f  /mnt/xfs/test
>  foffset	offset	flags
>  0	136d4c	__RU_l_________H______t_________________F_1
>  1	136d4d	__RU_l__________T_____t_________________F_1
>  2	136d4e	__RU_l__________T_____t_________________F_1
>  3	136d4f	__RU_l__________T_____t_________________F_1
>  ...
>  c	136bb8	__RU_l_________H______t_________________F_1
>  d	136bb9	__RU_l__________T_____t_________________F_1
>  e	136bba	__RU_l__________T_____t_________________F_1
>  f	136bbb	__RU_l__________T_____t_________________F_1   <-- first read
>  10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>  11	13c2cd	___U_l__________T_____t______________I__F_1
>  12	13c2ce	___U_l__________T_____t______________I__F_1
>  13	13c2cf	___U_l__________T_____t______________I__F_1
>  ...
>  1c	1405d4	___U_l_________H______t_________________F_1
>  1d	1405d5	___U_l__________T_____t_________________F_1
>  1e	1405d6	___U_l__________T_____t_________________F_1
>  1f	1405d7	___U_l__________T_____t_________________F_1
>  [ra_size = 32, req_count = 16, async_size = 16]
> 
>  # echo 3 > /proc/sys/vm/drop_caches
>  # dd if=test of=/dev/null bs=60k count=1
>  # ./page-types -r -L -f  /mnt/xfs/test
>  foffset	offset	flags
>  0	136048	__RU_l_________H______t_________________F_1
>  ...
>  c	110a40	__RU_l_________H______t_________________F_1
>  d	110a41	__RU_l__________T_____t_________________F_1
>  e	110a42	__RU_l__________T_____t_________________F_1   <-- first read
>  f	110a43	__RU_l__________T_____t_________________F_1   <-- first readahead flag
>  10	13e7a8	___U_l_________H______t_________________F_1
>  ...
>  20	137a00	___U_l_________H______t_______P______I__F_1   <-- second readahead flag (20 - 2f)
>  21	137a01	___U_l__________T_____t_______P______I__F_1
>  ...
>  3f	10d4af	___U_l__________T_____t_______P_________F_1
>  [first readahead: ra_size = 32, req_count = 15, async_size = 17]
> 
> When reading 64k data (same for 61-63k range, where last_index is page-aligned
> in filemap_get_pages()), 128k readahead is triggered via page_cache_sync_ra()
> and the PG_readahead flag is set on the next folio (the one containing 0x10 page).
> 
> When reading 60k data, 128k readahead is also triggered via page_cache_sync_ra().
> However, in this case the readahead flag is set on the 0xf page. Although the
> requested read size (req_count) is 60k, the actual read will be aligned to
> folio size (64k), which triggers the readahead flag and initiates asynchronous
> readahead via page_cache_async_ra(). This results in two readahead operations
> totaling 256k.
> 
> The root cause is that when the requested size is smaller than the actual read
> size (due to folio alignment), it triggers asynchronous readahead. By changing
> last_index alignment from page size to folio size, we ensure the requested size
> matches the actual read size, preventing the case where a single read operation
> triggers two readahead operations.
> 
> After applying the patch:
>  # echo 3 > /proc/sys/vm/drop_caches
>  # dd if=test of=/dev/null bs=60k count=1
>  # ./page-types -r -L -f  /mnt/xfs/test
>  foffset	offset	flags
>  0	136d4c	__RU_l_________H______t_________________F_1
>  1	136d4d	__RU_l__________T_____t_________________F_1
>  2	136d4e	__RU_l__________T_____t_________________F_1
>  3	136d4f	__RU_l__________T_____t_________________F_1
>  ...
>  c	136bb8	__RU_l_________H______t_________________F_1
>  d	136bb9	__RU_l__________T_____t_________________F_1
>  e	136bba	__RU_l__________T_____t_________________F_1   <-- first read
>  f	136bbb	__RU_l__________T_____t_________________F_1
>  10	13c2cc	___U_l_________H______t______________I__F_1   <-- readahead flag
>  11	13c2cd	___U_l__________T_____t______________I__F_1
>  12	13c2ce	___U_l__________T_____t______________I__F_1
>  13	13c2cf	___U_l__________T_____t______________I__F_1
>  ...
>  1c	1405d4	___U_l_________H______t_________________F_1
>  1d	1405d5	___U_l__________T_____t_________________F_1
>  1e	1405d6	___U_l__________T_____t_________________F_1
>  1f	1405d7	___U_l__________T_____t_________________F_1
>  [ra_size = 32, req_count = 16, async_size = 16]
> 
> The same phenomenon will occur when reading from 49k to 64k. Set the readahead
> flag to the next folio.
> 
> Because the minimum order of folio in address_space equals the block size (at
> least in xfs and bcachefs that already support bs > ps), having request_count
> aligned to block size will not cause overread.
> 
> Co-developed-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

I bisected boot failures on two of my 32-bit systems to this patch.

> ---
>  include/linux/pagemap.h | 6 ++++++
>  mm/filemap.c            | 5 +++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e63fbfbd5b0f..447bb264fd94 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -480,6 +480,12 @@ mapping_min_folio_nrpages(struct address_space *mapping)
>  	return 1UL << mapping_min_folio_order(mapping);
>  }
>  
> +static inline unsigned long
> +mapping_min_folio_nrbytes(struct address_space *mapping)
> +{
> +	return mapping_min_folio_nrpages(mapping) << PAGE_SHIFT;
> +}
> +
>  /**
>   * mapping_align_index() - Align index for this mapping.
>   * @mapping: The address_space.
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 765dc5ef6d5a..56a8656b6f86 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2584,8 +2584,9 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
>  	unsigned int flags;
>  	int err = 0;
>  
> -	/* "last_index" is the index of the page beyond the end of the read */
> -	last_index = DIV_ROUND_UP(iocb->ki_pos + count, PAGE_SIZE);
> +	/* "last_index" is the index of the folio beyond the end of the read */

> +	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));

iocb->ki_pos is loff_t (long long) while pgoff_t is unsigned long and
this overflow seems to happen in practice, resulting in last_index being
before index.

The following diff resolves the issue for me:

diff --git a/mm/filemap.c b/mm/filemap.c
index 3c071307f40e..d2902be0b845 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2585,8 +2585,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 	int err = 0;
 
 	/* "last_index" is the index of the folio beyond the end of the read */
-	last_index = round_up(iocb->ki_pos + count, mapping_min_folio_nrbytes(mapping));
-	last_index >>= PAGE_SHIFT;
+	last_index = round_up(iocb->ki_pos + count,
+			mapping_min_folio_nrbytes(mapping)) >> PAGE_SHIFT;
 retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;

Regards,
Klara Modin

> +	last_index >>= PAGE_SHIFT;
>  retry:
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
> -- 
> 2.34.1
> 

