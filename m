Return-Path: <linux-fsdevel+bounces-28611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E165496C5ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 20:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829EA284CC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372751E1A2E;
	Wed,  4 Sep 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbW7O68X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD01E0B8C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725472915; cv=none; b=jSIlglAT0CYZioIUQpAYiw74QSkXX16+c1m/H0z4RBsHcp0JBiJO3pXulVOnbwmo/p6HL1ctHCBbWa/OgcPy4rrqVI4OIdYO5lc93Xmj/SC4zLSbEWjXs92E8SuKOVujkEqBDbucmiL7gGgTEgNhWqMNbygx4guK7jwpMvzmvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725472915; c=relaxed/simple;
	bh=kvhqnlfhsbpncUCZEiavCzg2LzA66ExExMNp1OY8eBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sL3N8Zjpn/YOieEIWIpPYor1dkp1ghsQZBjti89i9kv33T+274O6F/7IJY3faUrogkC1qZ5ywRqNkBB5MdVnm0knSroEiOOA9sqrvf6abY2cSkcLWhnnFk29AvVCTxK+me4vCXYVAKYFZODfDYEnMGCAqw1VO8XrOKRW+8Te1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbW7O68X; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82a73a81074so71126639f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 11:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725472913; x=1726077713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtTeYjj02Mtv2WzzkSyeLasv4f+WjuGZCMl+K7JYzM0=;
        b=XbW7O68XhAVyoIOcmKTdw5Ilxj7olMPKSD/W+m8mkSQ6eTMdkYM88U5EZfADMX63Kg
         M6TfB1mLDcmMzE7AeYFnneFWokQozgT/HZ6m2AbGhCcJTyvfJNvNF5SMOaAqY6X1x+xs
         pyVTLuq7KfkJ3HLxY26RuvZpKJlEBEXgrFYbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725472913; x=1726077713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtTeYjj02Mtv2WzzkSyeLasv4f+WjuGZCMl+K7JYzM0=;
        b=HnYQGGfjn9wN5sKMKf4Ud8ojPSLWqFMmnghESJjyOowcoY/FWIQ3pGPN4b5OkCsPug
         lPKWsSVJ9dm+wBV3pffqkBnkoO6rTkQswofCxih272UNg6VCPD9NRa3xLrjTSJAHBOAB
         a3BcdBi1PEcfLYRA5MvedcS6zfSJeMIwMVldj+EjheLO0sOm6j3D/OwfgyEfdDLQl84U
         jstJHtUjjgZrdeuFZLSarIFxZ/6/dyAn9YZ1Y0Tja9B8y4fCw6Pa0eHYGMZIEeZc14GF
         37v8zAN4mxWPCvi6GP5vpOyvsa1LLJvLwfgZCIVT/AtrIMDuZ9qopAaeakq2mJUx+KZa
         SpKA==
X-Forwarded-Encrypted: i=1; AJvYcCXwFlTF4Fe/XEoCx1v2LOeiNLHxoqUQIXvu6IzTw3PsMft4cHWB7XzGxDhDNBTyah2zC+zzGz75ktNVok9d@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rO+JQ7dz1hStW38s/TTd0nUgAooSfhs4ChZfAKV8UIO38puw
	HXCsL5tAxLAAsc1CFaWcsrrV+TJ0mnj9xoOyqbxe5RGKT4K9gId4Lrs1Dl3OrGI=
X-Google-Smtp-Source: AGHT+IE09d+IBeWwgHe5zjgeYzKqlOeVFBKdTyoUXo2CmM5mem85ZvAmg7ax8y1cyKmmP1BgZ4kZOg==
X-Received: by 2002:a05:6602:60c7:b0:807:f0fb:11a2 with SMTP id ca18e2360f4ac-82a11094588mr2605807839f.13.1725472912591;
        Wed, 04 Sep 2024 11:01:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a49897bsm366616139f.37.2024.09.04.11.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:01:52 -0700 (PDT)
Message-ID: <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
Date: Wed, 4 Sep 2024 12:01:50 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Michal Hocko <mhocko@suse.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
 "conduct@kernel.org" <conduct@kernel.org>
References: <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 03:51, Kent Overstreet wrote:
> On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
>> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
>>> On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
>>>> On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
>>>> [...]
>>>>> But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
>>>>> in the case of bugs, because that's going to be an improvement w.r.t.
>>>>> system robustness, in exactly the same way we don't use BUG_ON() if it's
>>>>> something that we can't guarantee won't happen in the wild - we WARN()
>>>>> and try to handle the error as best we can.
>>>>
>>>> We have discussed that in a different email thread. And I have to say
>>>> that I am not convinced that returning NULL makes a broken code much
>>>> better. Why? Because we can expect that broken NOFAIL users will not have a
>>>> error checking path. Even valid NOFAIL users will not have one because
>>>> they _know_ they do not have a different than retry for ever recovery
>>>> path.
>>>
>>> You mean where I asked you for a link to the discussion and rationale
>>> you claimed had happened? Still waiting on that
>>
>> I am not your assistent to be tasked and search through lore archives.
>> Find one if you need that.
>>
>> Anyway, if you read the email and even tried to understand what is
>> written there rather than immediately started shouting a response then
>> you would have noticed I have put actual arguments here. You are free to
>> disagree with them and lay down your arguments. You have decided to
>>
>> [...]
>>
>>> Yeah, enough of this insanity.
>>
>> so I do not think you are able to do that. Again...
> 
> Michal, if you think crashing processes is an acceptable alternative to
> error handling _you have no business writing kernel code_.
> 
> You have been stridently arguing for one bad idea after another, and
> it's an insult to those of us who do give a shit about writing reliable
> software.
> 
> You're arguing against basic precepts of kernel programming.
> 
> Get your head examined. And get the fuck out of here with this shit.
> 

Kent,

Using language like this is clearly unacceptable and violates the
Code of Conduct. This type of language doesn't promote respectful
and productive discussions and is detrimental to the health of the
community.

You should be well aware that this type of language and personal
attack is a clear violation of the Linux kernel Contributor Covenant
Code of Conduct as outlined in the following:

https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

Refer to the Code of Conduct and refrain from violating the Code of
Conduct in the future.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

