Return-Path: <linux-fsdevel+bounces-66428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4186C1EA33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0EE19C29F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF75331A7E;
	Thu, 30 Oct 2025 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LKPmOFtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93A330B2C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807227; cv=none; b=d6twlPiqlxObYQdEr5V9zLIXAbw/8uugm9c5yBK6KAIJ82LVnOTMHD183KILio/pt5NeKz2NhLR33AHTCI2va/j2aCgYXUq64Xe+iVeCBV1nayOd+t4QDs79jPq/thMwIhE0EsNR5wDvpt+UDqjNIBq8+KmBYeRH1SphIZThKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807227; c=relaxed/simple;
	bh=qXHx/nT/qZjdrxmThc3MLeYmmngjwAmO4ugSN42nCY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NufucFnHvg+9Ka3/Y1pph09og8lNc8Ygy/5Cmh4Nb4Zpwsa+sZAqOA0l97HqILvtNvFmMti2UnpYbQNzB10qXitik1Q2JKl01GX0DJhQoz1zCBHAM/OqCZgiwCvSpL0eUBYQ1PEpJ4owbrjUEKhpsQ2IdY/GWYxuljTF425+MkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LKPmOFtR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-426fc536b5dso406510f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761807222; x=1762412022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spaiIJRDeLO8qql3bA4ah50+w7VcfliYUjhE/5FZ+4M=;
        b=LKPmOFtRHgudKWQ8MjmGjAuDVzuvQsIyRWZaSbIFopmL20gMfZ+pW39gduNoCHl1eF
         SZiJgOX+Vr+ihFxh79BohaT82CfbH9Q/3vBgI1W7v5FtO/oqOnR6uvdHBBIpFJl2pWLK
         btRAZ0Uf1EGq7m8oN70+NNoBYO0KSPkii5tl3X/eXe01kpYt49gL3JGg0/OkU9FCEEie
         ERAHd8OHuxt/+w6B25khsnhHEXQR+tCrqM903GoRlY8A3RgK+AhOXvqMKEs6nWLIyba+
         PZxxwErEOYi3RWz7EV8k4S958V0kFTEgzsc76Ptu6hR+LhNbP/P2b9g7CsJTvVz9hACs
         PRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807222; x=1762412022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spaiIJRDeLO8qql3bA4ah50+w7VcfliYUjhE/5FZ+4M=;
        b=YlK1atxifMr07Xt67EvS37FF4yLRBvFLFfGfx3eX+N9x/lQlT4Xwh5YI8nOIMS6eW5
         3CryfL//O4bfY06NmBh7AT/b7uWuyrFCIX/fxcoLIx9iX/Xg851S06hVWP1TkA1J9lAx
         38nMvdrL3p0BTCTaK/OEf3awLdxVPIx9/Qh++ET+LV+X2rrRfxP4ilTzPM3JyiTCXSPe
         Tb6EG6yXAnG8CltbY9NQ7BoomTI1d36YOXYJb0QMdaqp/KCP6s0EmrXun5P1kpumLEiG
         nLfmZvahlSuC1QKItsAYjMvRIjfzkhJiA5ti3NdcpZvNJSdib0sizPKhyJfNTVR5txxI
         JDHw==
X-Forwarded-Encrypted: i=1; AJvYcCWVByy8A6cwghw5TRY1MPzFdMajjWFIoH8mSQguV/B6A3IPZWWn3bZb0gEIfamttjsD9yKpGOc3rSHA3oPD@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfO1xgbb8C997uk2G7drXqJyK8kBxFg2xvAAUXq+XQOA7rw3+
	+HGjv1betztYUuV55G6kChPY5vVBdhsw9Aj21MTNoq6wlbS89xaHxA9AxhQgnQIJYvY=
X-Gm-Gg: ASbGncuJg9ltw4GelCxknrLfbxIK2CkXrt9NSpMTi7TVZWVQDIlwBntoWW33vVCmGUN
	Igw/LSTy+WPiMYmduZoy+I+T/X3f/Yb1WpAE3anOaeqgyMjjvcQjq8pDCO20FtY7xfwiEQw8vzk
	1zBamMKwN+RHklLg9I7FoZHH1gjut5MkpODU8qAkw+a+VN2ALVx0qNjhdwI3D8b3RY3L/AEUswL
	pwpFKf5kjW9K3BpUpOkL31ggqoyDngrwhk5bO2lJnL3kBQe1N2Us4uPtFy8b8RsOnLR0RkyYL0a
	TL34e3oVBudG5jKUevBClTsFR2+3rDV3bHOpSP6vHiasTpNvFgzzE8I+b5iZunYB2pBZdJJcCgE
	ay0yGn2DVMi1+2atDa5BULwWMlTIu7eckamRxG/TaLZSt3ocNq0LhAe4x5bYKnhNN9WCQRuGLy3
	ZIB6ChIyosAP48CLm6IRgeaw1WOcWa
X-Google-Smtp-Source: AGHT+IGuyA1xrlmXYXQ1Yx0rW63y51Ujb1gDH99TS1bXYeBdhPsZDhgqJaLMAea312NaYFO3cs4sPA==
X-Received: by 2002:a05:6000:18a9:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-429aef75eb2mr3899135f8f.6.1761807222300;
        Wed, 29 Oct 2025 23:53:42 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a427684bddsm14144800b3a.31.2025.10.29.23.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:53:41 -0700 (PDT)
Message-ID: <a44566d9-4fef-43cc-b53e-bd102724344a@suse.com>
Date: Thu, 30 Oct 2025 17:23:32 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de>
 <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
 <20251030055851.GA12703@lst.de>
 <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com>
 <20251030064917.GA13549@lst.de>
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
In-Reply-To: <20251030064917.GA13549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/30 17:19, Christoph Hellwig 写道:
> On Thu, Oct 30, 2025 at 05:07:44PM +1030, Qu Wenruo wrote:
>> I mean some open flag like O_DIRECT_NO_FALLBACK, then we can directly
>> reutrn -ENOBLK without falling back to buffered IO (and no need to bother
>> the warning of falling back).
>>
>> This will provide the most accurate, true zero-copy for those programs that
>> really require zero-copy.
>>
>> And we won't need to bother falling back to buffered IO, it will be
>> something for the user space to bother.
> 
> So what is your application going to do if the open fails?

If it can not accept buffered fallback, error out.

If it can, do regular open without direct IO flags, and may be even open 
a bug report to the project, questioning if they really need direct IO 
in the first place.

Thanks,
Qu

> 
>>
>> Thanks,
>> Qu
> ---end quoted text---


