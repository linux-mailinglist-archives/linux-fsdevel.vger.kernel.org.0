Return-Path: <linux-fsdevel+bounces-73128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D2D0D04F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 07:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E92301B139
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB32727FA;
	Sat, 10 Jan 2026 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q0d8oJRi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C550095F
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768024981; cv=none; b=CdLjktraYO4QaVgbPgGZSKAqAvHKuMPcT+b5oUVaCbBdPkbhyZ+sjszmRu3Zd+/QLoFlZ8qQII9KJkv3aaGCypNVVhHAsvFviqtctozBSup9reCYQT4ooSsMPEJkexYxQj+rcnu4KCD0SyM7ABOOOtzCvGJOqRLiy4PJsjxxayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768024981; c=relaxed/simple;
	bh=9gcB4Ds05QWrIsTsT1YYdOrmvu4BQJGs5/AMrFPQUPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlY/URlEezbJBhrXjuiPAAVVTujbv2ZvtjQY5UaPAuS+DhC1SCH0IQaJbY0FvJYxxMjtFXYQIqfPtuT8ynp+G8IsUUz44+Xe6GeM/IzvDDtGbEMDa0l4+gxd/Tlsil20JrjS2o5/QpczFmCWlb2dFePnjjXXi6gxE+nPcM7RLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q0d8oJRi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so48807965e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 22:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768024978; x=1768629778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VxHown53krzjOwZe3U6q2Q9luXHEQPHiDEX+U4zC7CE=;
        b=Q0d8oJRi2JbrgMvZigNljinNPj6lF5DcPY+WmRb3/94HQ+kAoC3jjtChmDIdssysy9
         TRmHNx8h2blKvExb/6BQm+tmUF83hZPA7IjnnjtFbAyqIoWh+2oDrtWei4M6fo9y9ot1
         tDJ9FOauMWnOZhE0QdY9USnRgShJpQ/RuTF+yDhLVn0OcQrouCumJWc9AvVAh2acNErv
         Jy7wmrIGi9WRkbhEBn9jK8+2BprVx25lW9lBjSXBfgfEZDAIY8a8odqtGz7uEH1wcH+s
         9Kxi6B4X9kDdTwYjdBNTIlWjZOpNMEDxwWwFK7ysDuYyQNo6cVq+JnNn6rtm/qCE8Wr5
         aPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768024978; x=1768629778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxHown53krzjOwZe3U6q2Q9luXHEQPHiDEX+U4zC7CE=;
        b=dZrRTR9ouWTEYwypwxh724urH9WF1CtVVU4zTlzIw7NK5KWzE9z5Kixmm6NKfwoU7r
         hpZu541Iz4wY7KHXYOluxEEvQt0gJYXORdFtDLITZH50Sb7azZofgfzsgOLng3bbboXB
         I+3addtnZkqDo3/N70aXTzdZmn1EuSvRg6KZ98SlAdmaYNyy1J+8WIbMzLU0YTZ9PDMc
         B23+4RhakVNG2G6GbG6RkUWmHbuwZp3iILTYbfDjp+3lkMRNSiK82v+Dsf9GQQi8Ty0i
         LqXfLDtkK+IhAQBkXluAlO2p05HXjdbjJefsgLp32vLMztgYD34V/gC7Lm1z3QG90OWl
         Vi0g==
X-Forwarded-Encrypted: i=1; AJvYcCWWBx/tOA8veUakPE4k7Rfe0BPJjCEwRQoB6tFOgy0i+nl+mEVnIbaRlberW5sre8TFmkN1K7DdZdEBB1Sg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VCZUXW1va/gEmaLmauGyx3A74cxhGFNMDU+ChHfgmpmfaULY
	VEOJxnAWpTK/5bFDVrcBqQiqJDwVd7HtZJIIOO9haY7z3sibT4WCUF96OG27KesJLfw=
X-Gm-Gg: AY/fxX7lEXNqx0drw71zDCjfQSHw/HJgk4QQuxEg3cBLLXHx9HnlSA9dftW+qjgWcho
	zKdf0jIzbxgFsnYiD8skP8VRKxsrPJsTprB6sXnVq6jvnqdfgxxNYZQNUReUe5CvX5zcYrhKh+y
	2adY1wEwhajSl5lFTqAvU/kzhU4vxSzIFNmFrfQQ2fDFhHWKr8uh/0qGz5H/UG22d2KrswPNdOt
	vmRZr9pmL4ztrPs2BbsSDVo3SDZZx8xg7VrNo4jfwY0cr8oxbBXQARN2n1Qx3PCJfPLHn5VRZUy
	lPm8MVoU3LTqE8aiV7kjBraQAG3gG/bm+jcXo3MKbg910MazunXgxSzEohBIfspZjZB4wyD3O+4
	sMgNdC0mhpXWXdzEWMUHzwfiKBmfabhp4n2sdfUVWsDZC1PWReTsWi5yscZ7nOVItLtSTh/ZyFb
	P/ZrTKMKLWxxGzzgao5f37HXFdReJbmgfkrGnACqY=
X-Google-Smtp-Source: AGHT+IG8jynb28B5RBnK/iq2PKqzT29mdzDBcrn1Ajaub9mVTEsrGxx9hQOrO5M/hLH9/kxs2BArzg==
X-Received: by 2002:a05:600c:3110:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47d84b41176mr135338145e9.36.1768024977815;
        Fri, 09 Jan 2026 22:02:57 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e8010sm12164251b3a.52.2026.01.09.22.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 22:02:57 -0800 (PST)
Message-ID: <38777db8-f90b-4437-988d-558231747750@suse.com>
Date: Sat, 10 Jan 2026 16:32:52 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] btrfs: use bdev_rw_virt() to read and scratch the
 disk super block
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1768017091.git.wqu@suse.com>
 <829db7e054cd290b5aed0b337cd219da128ac0e7.1768017091.git.wqu@suse.com>
 <aWHqFJfzD9QeaKkS@casper.infradead.org>
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
In-Reply-To: <aWHqFJfzD9QeaKkS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/10 16:26, Matthew Wilcox 写道:
> On Sat, Jan 10, 2026 at 02:26:19PM +1030, Qu Wenruo wrote:
>> Furthermore read_cache_page*() can race with device block size setting,
>> thus requires extra locking.
> 
> What?  There's supposed to be sufficient locking to prevent this.
> Is there a bug report I can look at?

The comment of read_cache_page_gfp() already mentions that invalidate 
lock is required, but we didn't hold inside btrfs, and it's already 
fixed now, nothing to be worried from mm side:

https://lore.kernel.org/linux-btrfs/tencent_A63C4B6C74A576F566AA3C0B37CE96AC3609@qq.com/

This report and fix just reminds me to finally push the series to get 
rid of read_cache_page_gfp() completely.

Thanks,
Qu

