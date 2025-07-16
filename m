Return-Path: <linux-fsdevel+bounces-55085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A6B06CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 06:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B985E1AA6F51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 04:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B302701DC;
	Wed, 16 Jul 2025 04:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dyv/n9N9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0622222AF
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752641713; cv=none; b=fzx2MGhbXotVv9Pf+frP/QAOTkue9Y9PwtQkShEZqratMGjXfHJ3RSzGgzkYbJ6uCIB4TmZTWs/vQHnvXpmqP+xXC19bPpFmwJJRe6rj77Sk8v7Dgw+HsLmSVDh5U/6BgTjeC9XBIKpHPTtrYwGsfp2HmC2L4YzBELXuLeBckkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752641713; c=relaxed/simple;
	bh=45NxbtcOjwFhJ4qOXbqzqQkutCIkkby9chlQhSzNg/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S5JqTMGJFKlJk+RUTZA/GqIaa5SqwTxYbb8JvHU9dn4/mc/NwsXEhcx6HPAKo4/g0ZXV2sAMxfe1F1ClKagcuHtUCsLJaUz1tAlI7ajhgSCLmQWYhAg9U4nAuXFdFG8oe/ZnJ1mNfFp37t+OrvJgvZsgJUjnptgVTrF8d1zxwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dyv/n9N9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a54700a46eso3850566f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 21:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752641710; x=1753246510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KUlf376OMv1XrkJW2oCmSZAdKifpL8InJUYTeCpUwoM=;
        b=dyv/n9N9YYWACOOxs0zyxdDDrg3oqKlU2iu5gZ9PpPKSvZFRNsGa3XOWCI4zEgM+A9
         eGYV/+m5irv6b8jISMbxiMUAFfkirqYOmByO7JLblO451RnY0w/SZRrWnYVrhiAnvLJj
         Wi/UUZQhFvWOKeig1HeCrtIfBSZladMiRAbL2+f3pg9AV8FyvBBXi+B/ifpUCFcohWog
         tSXqg26HY6iGnjrPN2OKa1gTSzl6DKydYfsjEn0O+cF8yzSFiBhXKZYqiMb94irIJgIy
         hCeYtuBsFkJoHtTseEqgmS+Adcs2sQyV/Flp0DUZmaerBji0bnHNV6eF/G7idzsMvW/u
         yHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752641710; x=1753246510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUlf376OMv1XrkJW2oCmSZAdKifpL8InJUYTeCpUwoM=;
        b=mXJF27kdJ91UyK80PU7EPonk31FyVI2WuisCbBqePa8t0VB+XkRH6vCWnX8JObmQjR
         WtpDf7pY78xNPUnRQc0poDqqZn5koTkX7uPwHcQACw/65bCZ3jn21DEbbTopeSvODdDZ
         YlT2hUgkMRGR523OWk/yUVoSzrGkPKfcGqs1CtU2yoCi/NTMy43XYYo6ZI7Y/innFzko
         4JsZAQeqJ0th4CY2gd75HoK07aRHlyKReyJWY5TZGMJhrk+/KLMDjNcaZJ1D6e2lPJ3a
         v9hBFvHa1q8e538EUx7WA6Q7U/Xo/z1B1Ki0F9Stp8QpV4O//aXRhdBZpffk9DMRWrmR
         fD6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+F21TjaDxpL8mFCDgsZn+j3xfhwO/TE3zStJOPp1oirXaUxlmXB7GwM9UdDXM7uq+Ov5/BVGPGodez2mU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mdvNsR/GLc6O3R8DN4vA3qmeFdv3YFLBkZKoTZmgs7KpEEr6
	6EgbBW/OIH1KSedKuNfKmLG/KxwTntieD51qE7FjGOZTYw2KyJmLQHBf134ktxJ9S1A=
X-Gm-Gg: ASbGncuhIMKXxB5Mhwdt/zWpaSkf2RNdO0TMomgl4EQwhAL927Su+G5w8saexPalltC
	5DQo3h8on9rhvn4eW2dTINZKUHm5ppGcVzX/guQXHOVGyylh7+OcpidcF8ecdyQ2feg1wnZXvUb
	YFsmLTsPYT1+Y7XF7EczOkhfs++NFlgjBQq6l283xkulfW9iQDb8SsAyjKtGh0EcGgpL3+MYc8n
	g9chDWA+zX7EqeKu/MhdJuo7DMzA4re2+mpL74kfG5+rbH/AyAfVa72JVM+8Iw52wSXgwTKbuMy
	yA9vBV4QiLEdN8Hqi8jPn7+wcLqrHPpgjCmlyo3TN65jpYM6qqxVmo63DKU8IC0viqh5ZBjBLnG
	YyGFJGa1f8qWiUSHbeMXf6y5gz6gfGSoidvl5c4sKNHwabs9h+Q==
X-Google-Smtp-Source: AGHT+IGQoacjNokIlv9kK4wCibwhRBT2cyuhZxnrQDEDj6ZSWUyIJyb34LpzcuPXzslTfEZGpbv7Yw==
X-Received: by 2002:a5d:5f50:0:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b60dd54803mr1041332f8f.18.1752641709469;
        Tue, 15 Jul 2025 21:55:09 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ec6b4cda5sm11051963b3a.108.2025.07.15.21.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 21:55:08 -0700 (PDT)
Message-ID: <b43fe06d-204b-4f47-a7ff-0c405365bc48@suse.com>
Date: Wed, 16 Jul 2025 14:24:58 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compressed files & the page cache
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
 David Howells <dhowells@redhat.com>, netfs@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
 <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
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
In-Reply-To: <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/16 10:46, Gao Xiang 写道:
> ...
> 
>>
>>>
>>> There's some discrepancy between filesystems whether you need scratch
>>> space for decompression.  Some filesystems read the compressed data into
>>> the pagecache and decompress in-place, while other filesystems read the
>>> compressed data into scratch pages and decompress into the page cache.
>>
>> Btrfs goes the scratch pages way. Decompression in-place looks a 
>> little tricky to me. E.g. what if there is only one compressed page, 
>> and it decompressed to 4 pages.
> 
> Decompression in-place mainly optimizes full decompression (so that CPU
> cache line won't be polluted by temporary buffers either), in fact,
> EROFS supports the hybird way.
> 
>>
>> Won't the plaintext over-write the compressed data halfway?
> 
> Personally I'm very familiar with LZ4, LZMA, and DEFLATE
> algorithm internals, and I also have experience to build LZMA,
> DEFLATE compressors.
> 
> It's totally workable for LZ4, in short it will read the compressed
> data at the end of the decompressed buffers, and the proper margin
> can make this almost always succeed.

I guess that's why btrfs can not go that way.

Due to data COW, we're totally possible to hit a case that we only want 
to read out one single plaintext block from a compressed data extent 
(the compressed size can even be larger than one block).

In that case such in-place decompression will definitely not work.

[...]

>> All the decompression/compression routines all support swapping input/ 
>> output buffer when one of them is full.
>> So kmap_local() is completely feasible.
> 
> I think one of the btrfs supported algorithm LZO is not,

It is, the tricky part is btrfs is implementing its own TLV structure 
for LZO compression.

And btrfs does extra padding to ensure no TLV (compressed data + header) 
structure will cross block boundary.

So btrfs LZO compression is still able to swap out input/output halfway, 
mostly due to the btrfs' specific design.

Thanks,
Qu

> because the
> fastest LZ77-family algorithms like LZ4, LZO just operates on virtual
> consecutive buffers and treat the decompressed buffer as LZ77 sliding
> window.
> 
> So that either you need to allocate another temporary consecutive
> buffer (I believe that is what btrfs does) or use vmap() approach,
> EROFS is interested in the vmap() one.
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Qu
>>
>>>
>>> So, my proposal is that filesystems tell the page cache that their 
>>> minimum
>>> folio size is the compression block size.  That seems to be around 64k,
>>> so not an unreasonable minimum allocation size.  That removes all the
>>> extra code in filesystems to allocate extra memory in the page cache.
>>> It means we don't attempt to track dirtiness at a sub-folio granularity
>>> (there's no point, we have to write back the entire compressed bock
>>> at once).  We also get a single virtually contiguous block ... if you're
>>> willing to ditch HIGHMEM support.  Or there's a proposal to introduce a
>>> vmap_file() which would give us a virtually contiguous chunk of memory
>>> (and could be trivially turned into a noop for the case of trying to
>>> vmap a single large folio).
>>>
>>>
> 


