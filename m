Return-Path: <linux-fsdevel+bounces-54901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33816B04C1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582B24A07C0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 23:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181EA2459E1;
	Mon, 14 Jul 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d1axMFSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545722D793
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752535205; cv=none; b=mFAYHfFpgn3TkIyodW/omRv88ot/NGBmBwllBBb+wr8jEclb9k+G2AC0hLmhmUllRvp3FEPwLM6mEMkZfD+q+lHJGgLsvs62ePhaocCD3AeFKqCowsAdg66rujZyGhNeQBvqdnRwfnOEetSahnl3YdfJkwzFznrd5bnujcEGgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752535205; c=relaxed/simple;
	bh=g58QhIZXNm6hads0EQq25lTneLDidumBG7gzXJmTcvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfZTDcriGmMihS2cEa6DFfKt0kLwMmrepmxnt86W7sXM9qgLDWI+q0JqtL7Xl6kC4VY4CpDdpkgGGGU2pvf60yTqV+G+MJTUT3GjR+GdhPjeXF6gWkr8D/MBa9AL7+c31Fg0IqRHVorwh3AhGxiFlWACJiI7xkQ7w7Ks0gIObek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d1axMFSD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-454ac069223so29624285e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752535202; x=1753140002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=it4R/RJhSP1QvHdSG8zENYDQ7NqFDavJwvs07lNEeE0=;
        b=d1axMFSDg6hJwvy/lm4V3Yfrq9XuQmc5mFYqBs9a7iViL+aLUlnlnWuWELIeMWdsa6
         +jXj7I/zLWzsjcGWyHpYWewRJmx2GDOTGBr6t8p++lFI67nWVEXMg9wevDKbZ3rTTVsx
         530uHq3uur6yCOmdITgtZHv6Dm6d+qLnsQZYfHuYBsvdSzwwUveptStjsQD8Yr2nV6u2
         7bIbywICq0yuXzoD4XPKCiIggFEbMIbkZOcLwybxrjmIq4+hrjpni+SuDnz+LoT/CRHA
         H+nqEr+1jg6rlbmTQwhdmP+2WiPeAMfMzDi08vy1PG2zzv1TWJNl9Gkxv20Bt+WIUs7F
         s9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752535202; x=1753140002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it4R/RJhSP1QvHdSG8zENYDQ7NqFDavJwvs07lNEeE0=;
        b=rPtIi13T4/+H0XpF7G62ik2TKkuCORokjCSa6VXuNAVStSx53iGzQeCDA6LJDkT1VF
         KdQIxEJq0GG/uQuKtu0AhB3/fwqEZwMeAVI93cn17xMnyCNEk4tdDFNMkgm1lcl7cEDo
         I4KmdxtAxbkWLeJvERwtbENZRerOaK3sITiOpr5YyRkVWoyHlM37tQxPFjae1ak0+CPx
         eSrj7DGvi/PThbOFquwRsUFl4yGepTqOQTQoC8YaaiqtrZkQ+X20gXhvdxlCqMWx3u43
         pgah8jrgqB5NuF1eY7unRF+seDwNtNKKosq8klj38+VbtfkbnWWrrgUbJfy/nzJuEjLJ
         x9rg==
X-Forwarded-Encrypted: i=1; AJvYcCV7MKiNBycXT/B8i1V/Br3+8DfGYoo7/9kgNjhu2E0pCfu/gGx/b8ArfwcfYSoCXJorz+xMY4xfYpqpomqf@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp8hy9VcapzelZObHjLMevcZsY6chAHCKG1G7YD4sRF2hz77gW
	eqaRd8q+nd+40CcRurmyjRvt2oMUyReTv3eZv1p2tOhNEgvMXw7gUfOOwJxGoN7yBy0=
X-Gm-Gg: ASbGncv2WF1/9AkVpfZPiS6vcQG3YTeqcOrqod/QjuFQ/AaHZxqXIT2pTUi9PcMvsve
	55sd0YGD0sgvRmgsWFnVSlq6z+abT5ykDOnn/fzCQWpH6lW5cJ82jGLCWfpkLjfwnKqvJ0gGTom
	MBce7pIgD20oiCKMY/jGqzYPHPRleWPl19dOtP5YOimghZr0v25cMDdkaajte/bBnpEjqGLPb4k
	Q6stHaildXERvClvwOV3CH34cCWCUhTsl+5GdIgQSmQgx4D8UV7Eqk+oMmxMOehGwzOo4jKed05
	eg7HErs4XM1QpZEjKqpVVKsofUwggYk2lQXiY47RLVgWu7YCw9phDPthsTzlADF3N/wzzmUmTgG
	K4Xy2ukGGVoRFhb5gYNTSEFd89HK/0O/D2qpFNwDxy7mcK/SM8Q==
X-Google-Smtp-Source: AGHT+IFscjYKxUUilLpUzMNCSIQy3L8xLj6r6UFGZLHK35q0lGZtJuvE796+41+Lh8fXoRbaA9teyA==
X-Received: by 2002:a5d:5f86:0:b0:3b5:e6bf:97b3 with SMTP id ffacd0b85a97d-3b6095203bemr1080421f8f.4.1752535201468;
        Mon, 14 Jul 2025 16:20:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8f878sm10754991b3a.166.2025.07.14.16.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 16:20:00 -0700 (PDT)
Message-ID: <c1332827-f5c6-4581-af35-aad0aec8f6ce@suse.com>
Date: Tue, 15 Jul 2025 08:49:55 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
To: dsterba@suse.cz, Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20250708132540.28285-1-dsterba@suse.com>
 <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
 <20250711191521.GF22472@twin.jikos.cz>
 <6bb8c4f4-bf17-471a-aa5f-ce26c8566a17@gmx.com>
 <a90a8a32-ea3a-4915-b98b-f52c51444aa5@gmx.com>
 <20250714-bahnfahren-bergregion-3491c6f304a4@brauner>
 <20250714190233.GG22472@suse.cz>
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
In-Reply-To: <20250714190233.GG22472@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/15 04:32, David Sterba 写道:
> On Mon, Jul 14, 2025 at 12:27:37PM +0200, Christian Brauner wrote:
[...]
> 
>>> The remaining concern is just should we do this by using
>>> ->freeze_super() callback, or do the f2fs' way by poking into
>>> s_writer.frozen.
>>>
>>> I'd prefer the later one, as that's already exposed to filesystems and we do
>>> not need extra callback functions especially when it's not widely used.
>>
>> This would be simpler. You should probably add a helper that you can
>> share with gfs2 to sample the state instead of raw accesses to
>> s_writers->frozen. I find the latter a bit ugly and error prone if we
>> ever change this. I'd rather have it encapsulated in the VFS layer as
>> best as we can.
> 
> I chose to use separate bit rather than using s_writers->frozen, which
> is what Qu prefers. I disgree with that on the API level as we probably
> should not do such direct check. A helper would be best, semantically
> teh same as the added filesystem bit.


My biggest complain about the new ->freeze_super() callback is, it's 
very confusing to have both ->freeze_super() and ->freeze_fs().

Currently only GFS2 is utilizing that, and I'm not sure if it can be 
removed or not, as it's some gfs specific lock handling.

In our btrfs case, it's really just a single bit that can also be done 
by checking s_writer.frozen, thus I don't think doing the extra 
callbacks just for that bit is really worthy.


Talking about the extra helpers to handle the access, it's valid, 
although we may have several different helpers, as each fs has different 
checks.
This makes the helper almost the same to the raw access to 
s_writers->frozen.

E.g. f2fs' gc and quota check if the fs is being/already frozen, thus 
it's the same as the btrfs's one.

But there are other call sites checking if the freezing is fully 
completed, and xfs even checks on the specific frozen stage.

So if one day we really change the s_writer->frozen stages, it will 
touch quite some fs codes anyway.

Thanks,
Qu

