Return-Path: <linux-fsdevel+bounces-64552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D525BEBC20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284FC3BAFBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75647354ADA;
	Fri, 17 Oct 2025 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SqSVlWl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE852620E4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734305; cv=none; b=P4gjo3CMd1GQB7okGdlxEqOmZV2Jti6qBdx/m/BY1NopBxA8hgqiHcYU3WyduyE0odB+WiogyxiNN1sFIOQNcm3J+3rtuo1He6y3pN9aP38jk/oqjXIB0LDwi5bboaLmA5yPsiiBG9/NORr007+Hob9o1T5CudGIoY2DfaeOQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734305; c=relaxed/simple;
	bh=vL7y5BK/Z7rzXcE255Yb+t5mWwQvzc0R4RWiu4lYENU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/eX7dlmhDRHyDlDIlDHdbpmIj9gIq062FWHa6TlOa1zazkBdQWqKA63WUGTWIgv+XuiH+PoTpCMvJDHJcb4Gg6VU4ItmkeQKqH5M2+rI/i6PKRbTYj9Ey/6vIF8ODQLpNAvEuIwIW1twvJJh8sH79pVOciujtZIs/r1oQtUDyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SqSVlWl7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so1178867f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760734302; x=1761339102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H1aXZ0jZfn9HlJa0HWEu3AHHLkyWLP1uGfd165omN0Q=;
        b=SqSVlWl7DsNGmg/sIp46WqNfp5HLl/nwp07ax7+vKeCCNOOlNNzJ67QqJaWKJxH3gk
         uO34/RAsjF1PfpkZctTkhy8Fp6GBrRp5RXdpan4C5XCVXL3pFke03mZLYrx11OfjZxyV
         RAsaN+EPC67C1oWiaCROZnyAZ4JDNgUe0oEUPmly7FuOQMmx+yAkjf62oO+A8OEs9elO
         8jd3CPTQVl1icGV3aIXMc8cJebclsS0na5o2DTLEaa/2QMyFsjheFPjZg9AmEyk46Ox+
         X7aeHkeiZZ4NHbb48fuK31ryqlvJG0nHdzd6ZTiRoLm9BvcT5c/Ykrm5Wf3wIN8sr0cK
         8DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734302; x=1761339102;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1aXZ0jZfn9HlJa0HWEu3AHHLkyWLP1uGfd165omN0Q=;
        b=XCiDD+QCCNBtGnkfPNsu52zL/AUqolBlx1RikJe0uxAtMrzwm1MVDbmDn0tEBpR8XK
         Kl12Xaq+2Ydm5eL5ciW2AQycKemlLuIl2W5H9Y+95gs+91b9T400mv0slckZ4irhdza9
         r0sc3w6KAdUMwKF3IzNH4gqtdypxWMsGo62CwZ63mEKArO2Z1eWoSIMakSh5FmLBqMuW
         +Cb7ye9ygDnEdobcfjaqSz0HplaKuiV73cnmZvkHIlLzR6AJrS6zyaxUiMzpfhEd/ual
         6niuUHj/0WJoVhbXEH0kvSapxHrS5CybpZV4ohxtu93bb/CgqOu0vTNu71qIBIxFxqib
         OJBw==
X-Forwarded-Encrypted: i=1; AJvYcCXCVmEgDxeWOcbp7o0rVNnQQbe70M6R4onoqSVHHrojt/zoCNxN4NF8kkDjUmmxFXSnUO6f6BOMVu3ffZrj@vger.kernel.org
X-Gm-Message-State: AOJu0YwJhAprdSQDzkxWQDQEixCOgtYBZKzK31z4IsLjclPKNr/BkcW2
	32vD8R3lUUgn6q4nglZNg9axa77TKrMhHwpHsuBUDuNvRwiXOgIgU+zfMOj6P0DDQkM=
X-Gm-Gg: ASbGncs2yIETjk7DuAMY5sP9l2JfmuDbxRyNTRLdxuKm+ThC8xvfmzPHKMB1/98NTIn
	yneG0FCB6U6uB4piQLvDmYXxAmmxGY3ECTI2QSRKIDZ6n1p5VZardGtFvY9oZ794iUJdhRn/iGR
	eKeCPe+p9QL3Zq+1Rg2L4kZKrQqyjZmAFDT7+OEgpRDCMq8MY6agpXn8jcXnCS9nO8PQfuGJw3F
	AoTOUh+ucTEsdwoJ3AJfYhurgTGi3Aj7lp+dYSlu3g7mWLq1YSPUJWaLt9WpDlE2Rdd3emCLu+E
	1w4daDnZRJvKALKQJ0HkfzSrbdZ9uSkahKVSpQ1SxJY3Z9zkQDt0E7Vw3ato/k07WvDwfR10vaX
	bs216ywFn5E86e0nj1Af150BkWAJkrNPj6WN2BY3Zk2n8ICx6EgfzCswOlUzQ9Li7zzklPQNdIK
	vfOKTamMzdt0Jo0C8oYS5MkLbdjhs1x84IS8HHcH8=
X-Google-Smtp-Source: AGHT+IHupydN5GPDZj2QaS35grCd3GNFRBZq3UVfx4GwbQX8d+VwEv/fpWhZFHmVd6D40q0GylcCWQ==
X-Received: by 2002:a05:6000:1a8e:b0:410:3a4f:1298 with SMTP id ffacd0b85a97d-42704d86b8fmr3647679f8f.15.1760734301872;
        Fri, 17 Oct 2025 13:51:41 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301211besm486393b3a.68.2025.10.17.13.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:51:41 -0700 (PDT)
Message-ID: <316d0c07-7785-44ca-8f07-6c1a365c91e9@suse.com>
Date: Sat, 18 Oct 2025 07:21:36 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Long running ioctl and pm, which should have higher priority?
To: Andrei Borzenkov <arvidjaar@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Askar Safin <safinaskar@gmail.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
References: <3a77483d-d8c3-4e1b-8189-70a2a741517e@gmx.com>
 <20251017103932.1176085-1-safinaskar@gmail.com>
 <0d2eb0c9-9885-417f-bb0a-d78e5e0d1c23@gmx.com>
 <CAA91j0XHt30mqDhgzWnvjbE-iGi3nS1BB1rgZy0Z6mSOT64Abg@mail.gmail.com>
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
In-Reply-To: <CAA91j0XHt30mqDhgzWnvjbE-iGi3nS1BB1rgZy0Z6mSOT64Abg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/17 21:16, Andrei Borzenkov 写道:
> On Fri, Oct 17, 2025 at 1:43 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2025/10/17 21:09, Askar Safin 写道:
>>> Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>> But there is a question concerning me, which should have the higher
>>>> priority? The long running ioctl or pm?
>>>
>>> Of course, pm.
>>>
>>> I have a huge btrfs fs on a laptop.
>>>
>>> I don't want scrub to prevent suspend, even if that suspend is happening
>>> automatically.
>>>
>>>> Furthermore the interruption may be indistinguishable between pm and
>>>> real user signals (SIGINT etc).
>>>
>>> If we interrupted because of signal, ioctl should return EINTR. This is
>>> what all other syscalls do.
>>>
>>> If we were cancelled, we should return ECANCELED.
>>>
>>> If we interrupted because of process freeze or fs freeze, then... I
>>> don't know what we should do in this case, but definitely not ECANCELED
>>> (because we are not cancelled). EINTR will go, or maybe something else
>>> (EAGAIN?).
>>>
>>> Then, userspace program "btrfs scrub" can resume process if it
>>> got EINTR. (But this is totally unimportant for me.)
>>
>> The problem is, dev-replace can not be resumed, but start again from the
>> very beginning.
> 
> What happens if there is a power failure? We are left with two devices
> that are part of btrfs. How does btrfs decide which one is good and
> which one is not?

That's restartable. There is an item in the root tree indicating the 
process.

But canceled one will remove that. And we can not keep it without a 
running replace.
That will open a window where writes are not properly duplicated and 
cause problems.

> 
>> As the interrupted dev-replace will remove the to-be-added device.
>>
> 
> In case of power failure it has no chance to remove anything.
> 
>> Scrub it self is more or less fine, just need some extra parameters to
>> tell scrub to start from certain bytenr.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Also, please CC me when sending any emails about this scrub/trim bug.
>>>
>>
>>
> 


