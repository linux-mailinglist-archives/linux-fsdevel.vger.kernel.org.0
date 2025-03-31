Return-Path: <linux-fsdevel+bounces-45387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8DA76F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0221887E79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2D321ADD4;
	Mon, 31 Mar 2025 20:43:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11B21ABB1;
	Mon, 31 Mar 2025 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453837; cv=none; b=WKWbPis6b/zYzVhfDgAOuyfepKCOcSj9JisLdriUSJhd7zsvSx6RTuIFHzLcQeJY8uqoGyEZWz5oJjhR/mpSb2hBD8aHH2FlYMY6JyxUSJjqn1qNWdoqZtCw2zmsIAzcfv9mz2IHA7g8CHTsnW2n3P9GSXPu2tlfhG9SD5rbAy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453837; c=relaxed/simple;
	bh=++q1fQSaUm04WKm2ABfC/h8vviCQUodLv8BzFGlOgZQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TJMA3lN75wP1KXHUhW7CbYUgwKjrpr62bLzrDzsAylzhK1I7dS67/5lu53rW/wTSS3vGcun4GRr/SFCnZCFzpSFb9kGgx13bCuuVTKN8iXFNOrpeu1YQ1GQAac5pkvLD0MIvpv6l/5WvYOVNL+y6y4ESbn90diwAioLg/F9JolA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [192.168.1.104]
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.97.1)
	(envelope-from <jaco@uls.co.za>)
	id 1tzLyy-000000006Dc-3m7n;
	Mon, 31 Mar 2025 22:43:45 +0200
Message-ID: <ffeb7915-a028-40d8-94d0-4c647ee8e184@uls.co.za>
Date: Mon, 31 Mar 2025 22:43:42 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jaco Kroon <jaco@uls.co.za>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer
 size.
To: Joanne Koong <joannelkoong@gmail.com>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, miklos@szeredi.hu, rdunlap@infradead.org,
 trapexit@spawn.link
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
 <20250314221701.12509-3-jaco@uls.co.za>
 <CAJnrk1YqO44P077UwJqS+nrSTNe9m9MrbKwnxsSZn2RCQsEvAQ@mail.gmail.com>
Content-Language: en-GB
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
In-Reply-To: <CAJnrk1YqO44P077UwJqS+nrSTNe9m9MrbKwnxsSZn2RCQsEvAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

Hi,

On 2025/03/31 18:41, Joanne Koong wrote:
> On Fri, Mar 14, 2025 at 3:39 PM Jaco Kroon<jaco@uls.co.za> wrote:
>> Clamp to min 1 page (4KB) and max 128 pages (512KB).
>>
>> Glusterfs trial using strace ls -l.
>>
>> Before:
>>
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 616
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 624
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 624
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 600
>> getdents64(3, 0x7f2d7d7a7040 /* 25 entries */, 131072) = 608
>> getdents64(3, 0x7f2d7d7a7040 /* 1 entries */, 131072) = 24
>> getdents64(3, 0x7f2d7d7a7040 /* 0 entries */, 131072) = 0
>>
>> After:
>>
>> getdents64(3, 0x7ffae8eed040 /* 276 entries */, 131072) = 6696
>> getdents64(3, 0x7ffae8eed040 /* 0 entries */, 131072) = 0
>>
>> Signed-off-by: Jaco Kroon<jaco@uls.co.za>
>> ---
>>   fs/fuse/readdir.c | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
>> index 17ce9636a2b1..a0ccbc84b000 100644
>> --- a/fs/fuse/readdir.c
>> +++ b/fs/fuse/readdir.c
>> @@ -337,11 +337,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
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
>> +       if (desc.length < PAGE_SIZE)
>> +               desc.length = PAGE_SIZE;
>> +       else if (desc.length > (PAGE_SIZE << 7)) /* 128 pages, typically 512KB */
>> +               desc.length = PAGE_SIZE << 7;
>> +
> Just wondering, how did 128 pages get decided as the upper bound? It
> seems to me to make more sense if the upper bound is fc->max_pages.

Best answer ... random/guess at something which may be sensible.

> Also btw, I think you can just use the clamp() helper from
> <linux/minmax.h> to do the clamping

Thanks.  Not a regular contributor to the kernel, not often that I've 
got an itch that needs scratching here :).

So something like this then:

345
346     desc.length = clamp(desc.length, PAGE_SIZE, fm->fc->max_pages << 
CONFIG_PAGE_SHIFT);
347     order = get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
348

Note:  Can use ctx->count here in clamp directly due to it being signed, 
where desc.length is unsigned.

I'm *assuming* get_count_order will round-up, so if max_pages is 7 (if 
non-power of two is even possible) we will really get 8 pages here?

Compile tested only.  Will perform basic run-time test before re-submit.

>> +       order = get_count_order(desc.length >> CONFIG_PAGE_SHIFT);
>> +
>> +       do {
>> +               folio = folio_alloc(GFP_KERNEL, order);
> Folios can now be larger than one page size for readdir requests with
> your change but I don't believe the current page copying code in fuse
> supports this yet. For example, I think the kmapping will be
> insufficient in fuse_copy_page() where in the current code we kmap
> only the first page in the folio. I sent a patch for supporting large
> folios page copying [1] and am trying to get this merged in but
> haven't heard back about this patchset yet. In your local tests that
> used multiple pages for the readdir request, did you run into any
> issues or it worked fine?

My tests boiled down to running strace as per above, and then some basic 
time trials using find /path/to/mount/point with and without the patch 
over a fairly large structure containing about 170m inodes.  No problems 
observed.  That said ... I've done similar before, and then introduced a 
major memory leak that under load destroyed 100GB of RAM in minutes.  
Thus why I'm looking for a few eyeballs on this before going to 
production (what we have works, it's just on an older kernel).

If further improvements are possible that would be great, but based on 
testing this is already at least a 10x improvement on readdir() performance.

> [1]https://lore.kernel.org/linux-fsdevel/20250123012448.2479372-2-joannelkoong@gmail.com/
Took a quick look, wish I could provide you some feedback but that's 
beyond my kernel skill set to just eyeball.

Looks like you're primarily getting rid of the code that references the 
pages inside the folio's and just operating on the folio's directly? A 
side effect of which (your goal) is to enable larger copies rather than 
small ones?

Thank you,
Jaco

