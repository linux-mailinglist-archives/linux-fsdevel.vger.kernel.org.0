Return-Path: <linux-fsdevel+bounces-51643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2204AD98BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jun 2025 01:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F50B3B5D5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 23:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E72727F7;
	Fri, 13 Jun 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GRFim5Pq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF4230274
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749857770; cv=none; b=XPT2zbdTxzzy8LryhHyRrQBuZYxpvNyPB/omD3PI4I2MuZ6zofff8t5dtMJP5Yd7Mw/ElCCMj8qlfm0OCelwireP6tfrBhPSfRdEFUvvD2wv8LATo6fAB0H+WIeZiJCi2WweiOJ9MuXd8LtmeD63yb0eMMdsaAE8GS0TxxbZiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749857770; c=relaxed/simple;
	bh=DBwed/fb86PWripX90nf5OxMpz/FHIZwVx3hl5aHUh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlbT2AMu6LMYF2bCWDPmEEGcmBRqsoUGyhEZC2MzoJ4D0k1dtdkrnsHspPcuhTyYwhnFye+pm83gyWgD7Mo57WZlDBAjPLGWLHdQm+O+QDzKuG0ktA+GsHARIB2m07Q5wOfQFKuL15v7gK3Lt50aM1SFaAY4qlu20MNVxvErWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GRFim5Pq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a525eee2e3so2116354f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749857765; x=1750462565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NVtgqO8zaWnU1b+7C4UHw0GV4RrIwCYVPwYAxMGrkpo=;
        b=GRFim5Pqik2dN3xyrJUktpIYR4w5t5uB+FK/2CEESxFWXLfFfojv0rsqUdBMA3M38l
         aTqnp3llch0WRz2dE9s1xquN1Ct9M9DJPbY/KwmRbSFUTeY5DwsVUS8jhGSnmwihY5o1
         XrUDegilbRKEFd7hvZVpYaFIlyBv56GbJXL54tMxLzwQQN6Y5FuQL679AMA8IQhqIt5M
         wtrxjZd8MK9zgopAwzLfVNIRJolyOhKh1zEERn7HGv69YnOSZJn8JNo+UxP3q0FBhsW5
         vhT9rNwzJlAJxCgi7U8kc6+zoCPx3PKE+3etbN2AbxAv03H9EodCGgQsqW9TsEI+4UMH
         w6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749857765; x=1750462565;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVtgqO8zaWnU1b+7C4UHw0GV4RrIwCYVPwYAxMGrkpo=;
        b=ubDCRkIWwF4TatkppzNpPchwiA3CK4Bolc5BvxIBSgOF1OAxUBig3qimA4aW62E1Mj
         9jbMpFjHlKosRuEbdcV+RTkTfnwnSe7mJUCYia8uYPmWWX447igsIJYgJeoWlFfgmRHR
         Q8c14Z/utyCwUMgsE/Yu+TzZEExvnCjXf1CJHnvTz3kklW4T/5HNDOVCoJS+/eBqXG2G
         u/sActQ/M9ogl/8HKoEEFHaGI/qCnvjgq+CnamS2KRLxaiCUDyYI8DOMoRnFJYHllbMq
         qxMM6oa9TSWieBvVhQPOvvGCwi4Df1lnLgnbN5BKiCRP4JTGajeLQh1ZLusP9uKoUB55
         dPDg==
X-Forwarded-Encrypted: i=1; AJvYcCWh78z093nr+S/m49vzGVqkTn7v4zx9OBjJc0LAJ4gpd8VzwXChEbxE+3rNNVq5mGSgYQqUMbFL5C8pT1BV@vger.kernel.org
X-Gm-Message-State: AOJu0YxzixV3LHQjB4yuvqUTn+eP5g5QAiVD+MLe+61zdJlj+5Hhojl3
	YHN1RJUzYcJLE3UDZ2bKbt3WhK0c/Ru9Cg4zePd4mp7bSOUBqjerWyeyFs1+z/glx8M=
X-Gm-Gg: ASbGncs8CAZoT/4bwci1XyocHKo4wfkS8fWVRr4gzm4LvN4vorq9QKgGlsEdeJI6eTn
	Wtfju7AXYTpmFFkO4s6uyyFX9W51yu0a/cAbUC+yAeUfrHYpzb1FuTiKFvhRJ5WRLRugpyLuTto
	9GlpyoVQGgbnjCRxxyV5KcEVbaJK4xoF3zEf14HqYeKC9uSHxsGrDIr6AsaTuweuI+KELqYFuoD
	in+JydmymUirID5oS3gVEzYjeqTxXnOmRPEy6ukuysm+5FFKmY72lujMU016b+1NW37e/vuR/Ol
	pjgLD4x5oK8x1YI476E7eCIjfi5DAjtUqUUyuNej/j8Ludk6/xhR5O2E6EdeJta4cuNFJLYmD77
	/5LImOknrx0cNYw==
X-Google-Smtp-Source: AGHT+IECtYVp7pAC34bACKnVVTNEA8V9tp+DqFZNljmtmFTIXW24136P6HkrdjurIr5cXOFpdqctLg==
X-Received: by 2002:a05:6000:420c:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3a572e92ff4mr1251315f8f.48.1749857765407;
        Fri, 13 Jun 2025 16:36:05 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1639f97sm1990092a12.6.2025.06.13.16.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 16:36:04 -0700 (PDT)
Message-ID: <375ecc77-7a5f-4baf-a6ec-fc7e8dc02bfb@suse.com>
Date: Sat, 14 Jun 2025 09:05:58 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: Convert test_find_delalloc() to use a folio,
 part two
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Chris Mason
 <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250613190705.3166969-1-willy@infradead.org>
 <20250613190705.3166969-3-willy@infradead.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250613190705.3166969-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/14 04:37, Matthew Wilcox (Oracle) 写道:
> Replace the 'page' variable with 'folio'.  Removes six calls to
> compound_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/btrfs/tests/extent-io-tests.c | 32 +++++++++++++++++---------------
>   1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index 8bdf742d90fd..36720b77b440 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -111,7 +111,7 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	struct btrfs_root *root = NULL;
>   	struct inode *inode = NULL;
>   	struct extent_io_tree *tmp;
> -	struct page *page;
> +	struct folio *folio;
>   	struct folio *locked_folio = NULL;
>   	unsigned long index = 0;
>   	/* In this test we need at least 2 file extents at its maximum size */
> @@ -152,23 +152,25 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	btrfs_extent_io_tree_init(NULL, tmp, IO_TREE_SELFTEST);
>   
>   	/*
> -	 * First go through and create and mark all of our pages dirty, we pin
> -	 * everything to make sure our pages don't get evicted and screw up our
> +	 * First go through and create and mark all of our folios dirty, we pin
> +	 * everything to make sure our folios don't get evicted and screw up our
>   	 * test.
>   	 */
>   	for (index = 0; index < (total_dirty >> PAGE_SHIFT); index++) {
> -		page = find_or_create_page(inode->i_mapping, index, GFP_KERNEL);
> -		if (!page) {
> -			test_err("failed to allocate test page");
> +		folio = __filemap_get_folio(inode->i_mapping, index,
> +				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> +				GFP_KERNEL);
> +		if (!folio) {
> +			test_err("failed to allocate test folio");
>   			ret = -ENOMEM;
>   			goto out;
>   		}
> -		SetPageDirty(page);
> +		folio_mark_dirty(folio);

Crashing immediately when loading the module.
(Need CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y)

[   20.626710] BUG: kernel NULL pointer dereference, address: 
0000000000000000
[   20.628812] #PF: supervisor instruction fetch in kernel mode
[   20.630648] #PF: error_code(0x0010) - not-present page
[   20.632156] PGD 0 P4D 0
[   20.632893] Oops: Oops: 0010 [#1] SMP NOPTI
[   20.634052] CPU: 6 UID: 0 PID: 622 Comm: insmod Tainted: G 
OE       6.16.0-rc1-custom+ #253 PREEMPT(full)
[   20.636879] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   20.638321] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
unknown 02/02/2022
[   20.640524] RIP: 0010:0x0
[   20.641290] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   20.643075] RSP: 0018:ffffc90001587c88 EFLAGS: 00010246
[   20.644519] RAX: ffff88810b144670 RBX: 0000000000000000 RCX: 
0000000000000001
[   20.646490] RDX: 0000000000000000 RSI: ffffea0004128200 RDI: 
ffff88810b144670
[   20.648496] RBP: ffff88810b144500 R08: 0000000000000000 R09: 
ffffffff83549b20
[   20.650524] R10: 00000000000002c0 R11: 0000000000000000 R12: 
0000000000000000
[   20.652642] R13: ffff88810b1443a8 R14: ffffea0004128200 R15: 
0000000000001000
[   20.654778] FS:  00007f2e60e99740(0000) GS:ffff8882f45e2000(0000) 
knlGS:0000000000000000
[   20.657158] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.658980] CR2: ffffffffffffffd6 CR3: 00000001040b9000 CR4: 
00000000000006f0
[   20.661219] Call Trace:
[   20.662057]  <TASK>
[   20.662757]  btrfs_test_extent_io+0x17a/0xf40 [btrfs]
[   20.664266]  btrfs_run_sanity_tests.cold+0x84/0x11e [btrfs]
[   20.665839]  init_btrfs_fs+0x4d/0xb0 [btrfs]
[   20.667380]  ? __pfx_init_btrfs_fs+0x10/0x10 [btrfs]
[   20.668883]  do_one_initcall+0x76/0x250
[   20.670098]  do_init_module+0x62/0x250
[   20.671359]  init_module_from_file+0x85/0xc0
[   20.672586]  idempotent_init_module+0x148/0x340
[   20.673900]  __x64_sys_finit_module+0x6d/0xd0
[   20.675074]  do_syscall_64+0x54/0x1d0
[   20.676167]  entry_SYSCALL_64_after_hwframe+0x76/0x7e


Furthermore, the error handling of __filemap_get_folio() is incorrect.
That function returns either a valid folio, or an ERR_PTR(), no more NULL.

This applies to all folio calls like filemap_lock_folio() too.

Thanks,
Qu

>   		if (index) {
> -			unlock_page(page);
> +			folio_unlock(folio);
>   		} else {
> -			get_page(page);
> -			locked_folio = page_folio(page);
> +			folio_get(folio);
> +			locked_folio = folio;
>   		}
>   	}
>   
> @@ -283,14 +285,14 @@ static int test_find_delalloc(u32 sectorsize, u32 nodesize)
>   	 * Now to test where we run into a page that is no longer dirty in the
>   	 * range we want to find.
>   	 */
> -	page = find_get_page(inode->i_mapping,
> +	folio = filemap_get_folio(inode->i_mapping,
>   			     (max_bytes + SZ_1M) >> PAGE_SHIFT);
> -	if (!page) {
> -		test_err("couldn't find our page");
> +	if (!folio) {
> +		test_err("couldn't find our folio");
>   		goto out_bits;
>   	}
> -	ClearPageDirty(page);
> -	put_page(page);
> +	folio_clear_dirty(folio);
> +	folio_put(folio);
>   
>   	/* We unlocked it in the previous test */
>   	folio_lock(locked_folio);


