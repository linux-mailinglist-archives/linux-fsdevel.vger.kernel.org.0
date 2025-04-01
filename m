Return-Path: <linux-fsdevel+bounces-45460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37087A77E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFF218876E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430A20551D;
	Tue,  1 Apr 2025 15:04:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05030204F6C;
	Tue,  1 Apr 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519847; cv=none; b=VWMHQ3MbTSlBskKhFpGI5TCxcwPxsTuFdLLlKhufvjXei9N9kdrUiVoJW+kxvlhWKE81TJdfHBOEM3rdyZIt7LONvwSOIcFa+mCTNM4stthSZGEyvva3qFO72WZxwI0rFWPj9LjTFwmgHKNOCbimLjgu/taN1O5GC0Wijt0udHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519847; c=relaxed/simple;
	bh=yz+KC0MZYAVIyHKkNfgOY8bsYCGbBDmOgRSvkOEcW7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfsWKGijaVqhM2vgcQiZdIGvHU3W1IgySifWNQOvlrtEN94IVXTXCgzdWXokP2Vw6SfuPbHFwZ8sByJZeUeIRXxMjC00Zh5HtvpsBDmuRPnBF2LJ9ZCbgmLeyoN8mckS6PEhQFXhvKR5sdMhliBWJUmP5mchf9A2OKgEsLZjQJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.42.36]
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <jaco@uls.co.za>)
	id 1tzd9e-0000000084B-1Qlx;
	Tue, 01 Apr 2025 17:03:54 +0200
Message-ID: <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za>
Date: Tue, 1 Apr 2025 17:03:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer
 size.
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 joannelkoong@gmail.com, rdunlap@infradead.org, trapexit@spawn.link,
 david.laight.linux@gmail.com
References: <20250314221701.12509-1-jaco@uls.co.za>
 <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za>
 <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
Content-Language: en-GB
From: Jaco Kroon <jaco@uls.co.za>
Autocrypt: addr=jaco@uls.co.za; keydata=
 xsBNBFXtplYBCADM6RTLCOSPiclevkn/gdf8h9l+kKA6N+WGIIFuUtoc9Gaf8QhXWW/fvUq2
 a3eo4ULVFT1jJ56Vfm4MssGA97NZtlOe3cg8QJMZZhsoN5wetG9SrJvT9Rlltwo5nFmXY3ZY
 gXsdwkpDr9Y5TqBizx7DGxMd/mrOfXeql57FWFeOc2GuJBnHPZQMJsQ66l2obPn36hWEtHYN
 gcUSPH3OOusSEGZg/oX/8WSDQ/b8xz1JKTEgcnu/JR0FxzjY19zSHmbnyVU+/gF3oeJFcEUk
 HvZu776LRVdcZ0lb1bHQB2K9rTZBVeZLitgAefPVH2uERVSO8EZO1I5M7afV0Kd/Vyn9ABEB
 AAHNG0phY28gS3Jvb24gPGphY29AdWxzLmNvLnphPsLAdwQTAQgAIQUCVe2mVgIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAILcSxr/fungCPB/sHrfufpRbrVTtHUjpbY4bTQLQE
 bVrh4/yMiKprALRYy0nsMivl16Q/3rNWXJuQ0gR/faC3yNlDgtEoXx8noXOhva9GGHPGTaPT
 hhpcp/1E4C9Ghcaxw3MRapVnSKnSYL+zOOpkGwye2+fbqwCkCYCM7Vu6ws3+pMzJNFK/UOgW
 Tj8O5eBa3DiU4U26/jUHEIg74U+ypYPcj5qXG0xNXmmoDpZweW41Cfo6FMmgjQBTEGzo9e5R
 kjc7MH3+IyJvP4bzE5Paq0q0b5zZ8DUJFtT7pVb3FQTz1v3CutLlF1elFZzd9sZrg+mLA5PM
 o8PG9FLw9ZtTE314vgMWJ+TTYX0kzsBNBFXtplYBCADedX9HSSJozh4YIBT+PuLWCTJRLTLu
 jXU7HobdK1EljPAi1ahCUXJR+NHvpJLSq/N5rtL12ejJJ4EMMp2UUK0IHz4kx26FeAJuOQMe
 GEzoEkiiR15ufkApBCRssIj5B8OA/351Y9PFore5KJzQf1psrCnMSZoJ89KLfU7C5S+ooX9e
 re2aWgu5jqKgKDLa07/UVHyxDTtQKRZSFibFCHbMELYKDr3tUdUfCDqVjipCzHmLZ+xMisfn
 yX9aTVI3FUIs8UiqM5xlxqfuCnDrKBJjQs3uvmd6cyhPRmnsjase48RoO84Ckjbp/HVu0+1+
 6vgiPjbe4xk7Ehkw1mfSxb79ABEBAAHCwF8EGAEIAAkFAlXtplYCGwwACgkQCC3Esa/37p7u
 XwgAjpFzUj+GMmo8ZeYwHH6YfNZQV+hfesr7tqlZn5DhQXJgT2NF6qh5Vn8TcFPR4JZiVIkF
 o0je7c8FJe34Aqex/H9R8LxvhENX/YOtq5+PqZj59y9G9+0FFZ1CyguTDC845zuJnnR5A0lw
 FARZaL8T7e6UGphtiT0NdR7EXnJ/alvtsnsNudtvFnKtigYvtw2wthW6CLvwrFjsuiXPjVUX
 825zQUnBHnrED6vG67UG4z5cQ4uY/LcSNsqBsoj6/wsT0pnqdibhCWmgFimOsSRgaF7qsVtg
 TWyQDTjH643+qYbJJdH91LASRLrenRCgpCXgzNWAMX6PJlqLrNX1Ye4CQw==
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-report: Relay access (ida.uls.co.za).

Hi,

On 2025/04/01 16:40, Miklos Szeredi wrote:
> On Tue, 1 Apr 2025 at 16:29, Jaco Kroon <jaco@uls.co.za> wrote:
>> After:
>>
>> getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) = 6696
>> getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) = 0
> This looks great.  But see below.
>
>> Signed-off-by: Jaco Kroon <jaco@uls.co.za>
>> ---
>>   fs/fuse/readdir.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
>> index 17ce9636a2b1..a13534f411b4 100644
>> --- a/fs/fuse/readdir.c
>> +++ b/fs/fuse/readdir.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/posix_acl.h>
>>   #include <linux/pagemap.h>
>>   #include <linux/highmem.h>
>> +#include <linux/minmax.h>
>>
>>   static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>>   {
>> @@ -337,11 +338,21 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>>          struct fuse_mount *fm = get_fuse_mount(inode);
>>          struct fuse_io_args ia = {};
>>          struct fuse_args_pages *ap = &ia.ap;
>> -       struct fuse_folio_desc desc = { .length = PAGE_SIZE };
>> +       struct fuse_folio_desc desc = { .length = ctx->count };
>>          u64 attr_version = 0, evict_ctr = 0;
>>          bool locked;
>> +       int order;
>>
>> -       folio = folio_alloc(GFP_KERNEL, 0);
>> +       desc.length = clamp(desc.length, PAGE_SIZE, fm->fc->max_pages << PAGE_SHIFT);
>> +       order = get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
>> +
>> +       do {
>> +               folio = folio_alloc(GFP_KERNEL, order);
>> +               if (folio)
>> +                       break;
>> +               --order;
>> +               desc.length = PAGE_SIZE << order;
>> +       } while (order >= 0);
>>          if (!folio)
>>                  return -ENOMEM;
> Why not use kvmalloc instead?
Because fuse_simple_request via fuse_args_pages (ap) via fuse_io_args 
(ia) expects folios and changing that is more than what I'm capable off, 
and has larger overall impact.
> We could also implement allocation based on size of result in dev.c to
> optimize this, as most directories will be small, but that can be done
> later.

This indeed sounds interesting and would be great, but again, beyond 
what I'm capable of doing at this stage.

Great insights.

Thank you.

Kind regards,
Jaco


