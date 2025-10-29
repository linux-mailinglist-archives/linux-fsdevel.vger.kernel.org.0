Return-Path: <linux-fsdevel+bounces-66194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECF5C18D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 630E84F337B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766531196D;
	Wed, 29 Oct 2025 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LWh7pNr5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146917B425
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724857; cv=none; b=iadLTyZw8MUVCuYn/Aimfnhg3pM9pXJ7W080uMLNiFHLJTpyXCHrIdDbMoVO/PSyuEI/EGI5w2F/VD7CJ2CprDrro0S329owB/FQsiqkCyqHykbaoMD8DzfJy571Nw0Y5D0sd7HYKlRk7l3Ruwxdz7NrnPhAH47h14ceFsVoYrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724857; c=relaxed/simple;
	bh=tBJZ3HJ8ciRcJJddyTgiuc+XKcVC9a37YekCUT4BDkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXDS6bxJwHTk31aSAxRoZVjJWqmODTAaThs7ltnteTyh3VawAgmnn+IHGj2sMLb1IV4vuke/q/WDfimSOpnudMYHkp4FdmL8bE6BeTu0y3kjwueZlS5WAtqr/oJ25sgAUewwJJCM/+FNKNhFcCFXO/s0tb+7IxZF2lSAlE4T/Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LWh7pNr5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so4989531f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761724854; x=1762329654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w2I4oIDEgha+JKq5ggh6xH44+LbD3YSbxaxWlQsm7/0=;
        b=LWh7pNr58wA/MB9NR39uRBicW8YPVwa/OMEguge7P3cQ+B+DRLh3qwM6k6J/lSPA7T
         47U9yj2SYFV01SbAiinoxA/Yk55vdhXl5X1To1qvtlEZOMsevKeJqhCrRGmK68DCzdtM
         Jyb6V3PP2GY80SBT9Wk+sACxeSf2Ql11pOBc+79NQY5EqOUg24psHRiAlYXood1OGrss
         ke70zmvsMs1wl3AKGHgxlfviYhvCHmDuqwwylz21M2AlVw8vltxwEnPzAGscIbmoWsq+
         AS5C2TyPDcyS/iJqkoDbr6ENa/eMd8OU27nogDTXFY5HJRxvpPjITzojDLG9Mtp634ja
         /dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724854; x=1762329654;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2I4oIDEgha+JKq5ggh6xH44+LbD3YSbxaxWlQsm7/0=;
        b=bcVIjgUpGLrQQIWVPP8/n9q486t4O13VmvaCPNo5ugdsd+RsuIUho1ijmlDOpIKY/q
         XBz3Su3uDos7u5LeO0wllpqCu12veAMk8mkdkcBS+Jh1nhIk6NQJmHw5rz9TO4zgnlBf
         Nzb5nt9MpTjucx31mC/fGbNvbsS9X34929eJqmYkLzxtqRAnDJfabxRoq3ETrqnxqYcP
         E7VzZwQtbuAd1jeqSgNLSzfdS1VdUv92Jtjx3wN6Dv2BIs3ynlUH9bvswGexNOyeXG7l
         ftrHlYsunKw2nre9Ji8Bpg6ViQKvDi6hXXJPIYUqLchPnVOe1nyohLVvMcognNw8mgSC
         mfAg==
X-Forwarded-Encrypted: i=1; AJvYcCVPvKOhHa9/Zv61+wxBq1VL8N1wpTnT8b+u+CtDNuOw7/tVstEYqdCE6+Y1uZDaK1svtiaQ4eDXnN0hRbph@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdSVT/TMHEIz8B7knk4OJ57DBT9h6JU36UQGi1IFy/GX7+lJ/
	EW5RCYdddkz8QdVAxJKxsRW36MuDb0/uKcZPgTM7I6d1tLd0qIVcWtoqe0Q+3CT5gbo=
X-Gm-Gg: ASbGncu5HXRRJBCCzWRAE/wx1rewltqsIx5nPuhzbimq+czzTNjGi38q09Q0o8Al4cm
	IDLgjOcFbanZY3m6J6yfDswSt1JV2s2AtKa6JNBm5cvX6rA97FaUk6ZAwr2NRJECtq8N1FNSXiW
	+8mn8ES/a2NylNmcZTTAGwblEIa39kuvqcN3Oyop1loM2TR0MMDic9x+r36b3ju9e1mOsXzEll/
	eH2E2YspniTJZuTJcXG8h4nm7Ul8q24df0L1gwNWuj9FLAHPXs4/JEQeLv8LpL71GW2nwMD/Bk3
	VakLCEA50C+C8Ffz1oQgKPssRjuSUVP7YAqPwy7NMir7tQJE7O9nhbYqrA5XcsBRS4NFTQVW0yq
	92ganIhalq5nSZ3bXRVGT242gQsajUjMl65m0JFCf1LOnsmBskE0OSLFpw1wUf/Ki0vFIIeKJvK
	WD1T2pkuIs12faLiu9YhRtbICKJcaL
X-Google-Smtp-Source: AGHT+IF9VbipR1M7jQ4wDYs7uqUVS6gAJ5V5n7XFh2vcGZhp4i9Ea1wpbXFsAWERTl5MkuZG4zC3og==
X-Received: by 2002:a05:6000:24c1:b0:427:492:79cd with SMTP id ffacd0b85a97d-429aefd6a64mr1153576f8f.41.1761724853542;
        Wed, 29 Oct 2025 01:00:53 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402ec82sm14463901b3a.21.2025.10.29.01.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 01:00:53 -0700 (PDT)
Message-ID: <d5d33754-ecd3-43f0-a917-909cd1c2ab3e@suse.com>
Date: Wed, 29 Oct 2025 18:30:47 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20251023135559.124072-1-hch@lst.de>
 <20251023135559.124072-2-hch@lst.de>
 <20251027161027.GS3356773@frogsfrogsfrogs>
 <c4cc53b4-cc1a-4269-b67c-817a0d7f3929@suse.com>
 <20251029074450.GB30412@lst.de>
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
In-Reply-To: <20251029074450.GB30412@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/29 18:14, Christoph Hellwig 写道:
> On Tue, Oct 28, 2025 at 08:11:21AM +1030, Qu Wenruo wrote:
>> I'm wondering who should fix this part.
>>
>> The original author (myself) or Christoph?
> 
> Whoever resend it next :)
> 
> Unless you want to, I'll happily take care of it.

I'm totally fine if you can take care of it.

> 
> Any comments on my tweaks in the meantime?
> 

Patch 2 and 3 look good to me. Thank for catching the missing pos/length 
checks.

If you like you can even fold the fixes into this one.

Thanks,
Qu

