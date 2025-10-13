Return-Path: <linux-fsdevel+bounces-64019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF9CBD63D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 22:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 323254FAD6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A230ACFD;
	Mon, 13 Oct 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A050GTO/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AC4309DC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387962; cv=none; b=eEDGHDK8FyUxzyeX6M3juy0VAG4MwWMqNbp6+rKp2VupL8Anb3yk9wH/6jZnExWp8VobIaJRfn6u1XY0B4oIvlrJrCu7f7z9ae1oon9/al7Bw5g/X78UaD8gQZvj8fhSUdrLHFFBGqB1V1GCUecyLEIvWazOKsBvOrc/5Jnz0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387962; c=relaxed/simple;
	bh=DxBfGhh2/+HUO/+PM3P0ICetsG5JgKa7Tc70QypA8nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgW5gl3vhoJd7P0J6b9Gfx4coXR7dOsXxO88fGF3j9qncxAFKDd08ckJA9GFVavVuSH/eLHSbEYku/82UYq8Mhuxoo5feUoqj06ScqMmLcKsMlQkotRoT0YHhJPhy77cXhBT4d0N+zJ6G1W2LwreTzSAswoOmuXTYtCPs9Nocs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A050GTO/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4257aafab98so3937380f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760387958; x=1760992758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k/5lJurlyuxJdcFqWY2oR5aDpcqghsFG3DOY1t5I0NM=;
        b=A050GTO/G48qQSzFrZR1uA1zzcKq+yAMFmiDPpEfrUhfr9PlJHDx4DLJ1Nv30uB/5s
         0CJA1MYxQRTz4PT7INjrObPH9QJFK3vuRK5/s4pLDYom1nIF3IpGzoAuovcvInG+YGJH
         3hOcQuECju1MRko7UhD7DfdnrvRRJHF5ubrIBe9fukdMSJ0dY6YODPCr3GACckk3/3zL
         QspMseMqqOQrPEzC8Ts5PUyPSmr4ya9ZCCar5zDb5CA1geCkruYQor8rjOdU1spx9TAI
         qX6ySIoVwaWX5egIwsqcydm5B1DkqO7fOR/7fQ0tL0hNyaw1Dx58lc0AC7Fb8vQFA0Ge
         jNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387958; x=1760992758;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/5lJurlyuxJdcFqWY2oR5aDpcqghsFG3DOY1t5I0NM=;
        b=oRyng6GdJQMVoTPoYqWjP/LPjjzF9CzRSKakLHEp0q0I+goC9pCpzGtobOCuKJmFMN
         T9gi94ujT5xaSXG9HA9KdsrOge7LwUAlKzk5O3I7laO7ME3lTgRMnaugzrSIVB01iM0O
         Zps4krDWWO2oMrwGS9PcEIjppgNO34A8RIZFsLL46XlHI+rgWw36z/wmp8Q5lmxJmLBd
         AYVpT7qaM58idrbt746dMOoLcBl6VUrwmL/pzwyQgCdMIh4LKtEfNWxs9owEcaphf33t
         +bWoH0jcrC2a61opGe00hePKXwyIfjCKcemjgvURpItXMPHOXnsyxhcWbP685mGHbkZw
         PI6g==
X-Forwarded-Encrypted: i=1; AJvYcCXn+dZRL7ZKRGe50D2/uK29+GiT5PmB9M4FLbuiQw6hAu72tEBca3p4QbsLubBI/r2HneRqM/FX54tskP6A@vger.kernel.org
X-Gm-Message-State: AOJu0YxctAu0DTa1N0zY+g6O6juc1b6En8mkBlCPeroQdrbIBw74nbaw
	KOjD1y3XDt2D1SKRi/yyIi4llIUrcz/aSCClEhJ/qDmPsb7HEoRhiTWAbw8c6y4yR38=
X-Gm-Gg: ASbGnct5kN9WCm3WnhZvhqd/W0cCbpaErJlhdCR3art/K391o4njOehiS7FcSVdFC5G
	+zmpVhhZItiOAuNcDNyBQ5di+BpF+VzloWNc3hlrnjS1DCReM1WL+9psaDmmAjnhL4pbbH7NYDC
	EQLmcVBHkkljrhDtME4MmT5qZ3pr73DCFZqtZr/ZXc0QVQaMZrV3cOMf5efwb/Z85+F8lyErmBh
	JME/870LRIVVhofuMl5l4zRt0nVsYUqnfF4QOPkYdH6rSVIUWFmZYKoURaLq8DDGtOZ09tRUyvt
	Elc535Ngo+/uKFtf8JgpYrWCNBW/SEYtDxtjlOjvgP7haWInMq3C2muFu9t9wPxTMDiVdJ9mp/T
	eazCxpxlZ004HHx45T0IAKAnVOlTOPPIhJGXstd36KDif8wMws1oFRwyJ4BTXhVMfPSQUWlddfS
	HVkw1Q
X-Google-Smtp-Source: AGHT+IGMdD+E2aO2EwT0qAEpmLi1UhygjOb3pvX5IYujCEBYFY1rakmFjq7tZyH5ePG8KKlWBZFcHQ==
X-Received: by 2002:a05:6000:186f:b0:426:d734:1378 with SMTP id ffacd0b85a97d-426d734141bmr5265784f8f.4.1760387958076;
        Mon, 13 Oct 2025 13:39:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd83dcbsm12522237b3a.83.2025.10.13.13.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 13:39:16 -0700 (PDT)
Message-ID: <737baeb0-93cd-4018-9013-c86c662a608e@suse.com>
Date: Tue, 14 Oct 2025 07:09:10 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <cda26765-066d-4e4f-bd8e-83263f1aee82@wdc.com>
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
In-Reply-To: <cda26765-066d-4e4f-bd8e-83263f1aee82@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/13 21:44, Johannes Thumshirn 写道:
> On 10/13/25 11:05 AM, Qu Wenruo wrote:
>> - Remove the btrfs part that utilize the new flag
>>     Now it's in the enablement patch of btrfs' bs > ps direct IO support.
> 
> But then we potentially have code merged without a user. I think it is
> better to have the btrfs patch in the same series and merged via the
> same tree.
> 

It's fine, and in fact that already happened, for the remove_bdev() 
callback.

So I'm more or less fine with that, as long as we have a proper plan to 
add the initial user.

Thanks,
Qu

