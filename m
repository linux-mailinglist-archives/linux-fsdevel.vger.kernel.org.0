Return-Path: <linux-fsdevel+bounces-53076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4973DAE9BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4565A5A1613
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7262609F7;
	Thu, 26 Jun 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XOoAOOy1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938323815D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934172; cv=none; b=Q3ASvTOd1yxD0tWqMpHzGfCkKnT3tn6GG+GksFo1EDVPdfISnEmFa8bYGQv/DWz5mpsDIhKDULrKex1zlzZ0y+l0uP+Uje4MAnLp1tySVr1nH7Qho0v/2DLAZEjnxWQe2wmc+DhBNYDsnxDBIz15xav0UEEah1HSf9T0A3U2Tzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934172; c=relaxed/simple;
	bh=/A6sa8DL1UYyBu6tjj/HUR9xpho+GpE+fP6xun6CJc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsmlRfkXHUHjAlUSgVEsVlGfVJW0jnk4SP4gIKR/ideM+bE4DyZQrig/j6JcOgbcWNYJBImDUQZjrRZZjFetPofpvfMya19Mssu3PA6zTqqz5KXf/0Emhqu0upMhyyXeS5z6KjXBOkNE+wo+3NAmFBEdJMiO4p4o5M9YuB30YHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XOoAOOy1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so705671f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 03:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750934169; x=1751538969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yLkc6jk+EzAHd5hKCQDVs0PdJFmo6z809gVics8Wad0=;
        b=XOoAOOy1tkRwEn1RukLrCDdBWKB512Gkw03wjhjE2cCea8Dhp6XZ9HQMI4P5K20ftb
         ioG3GDvs4ItOJFhv1xRphTizErLAFjwpmwb14domR6b7FL/a/PQ/nk50OzZrCC/VLxMN
         HCLx6DAK+YWXEY8E7x27zvxZPitlwCsRbvPfUrmZULRnGtMSQxeixBGOC5ydzyEDHBSp
         +wz0868lM17tW6sjdoj9NRXwJVZXZMcMWKstugzv2mXedlRgxAaOoahv78b5rmtQl3wO
         fr2lpLkDkS/EmC0CqmvB6751SrDodfUiNv8fdl2FScLpMkXWPQdLrbd90vrwvnNNDMll
         d2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750934169; x=1751538969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLkc6jk+EzAHd5hKCQDVs0PdJFmo6z809gVics8Wad0=;
        b=UjZIbd4r/WMq7nGOYci0pTbLliKlAWQrXGBqW9PajZL3hJrTd1oNukH6nAB7JEOtQd
         JafQr1AOandUJ/qXJIDG5wSM1MY87FCIHxFaAzbm3Pqpssx+6OaCdAJqCHggUjN7Aht4
         OM3rlVNb+XhCRV5POMC7BDO+Q3liJSr1ypmsN+kDFTkbdyP6tLNekDPe9Ap8n57RAPzp
         W/pGhPsI0YpJQNitNcVFD//m9UxnTlFdUIyvNgDqPKowG8SLCJhMxXk+N7zPNayL9Xmx
         1Q72sSoIHCUfL/KKcW/ZdjoL9MidwkM57nEajmxG8hD2fwOXI9vs9g9xzHXfu+j9CMt5
         wPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUxoEm17rAx3adhoaS7C2M1PRNmD4feYFAf6cKao5BV/JtEefh8iaM0/8foBeSCtdTtt+t3NgiBagXgcln@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aFZEqEyuK5oPzqNTlIrULVyh6Fv1exF4HD4nkibImMMIdau8
	v1ggom0eEES7dtPkAA+S1WAq9hRON0GrpE4jjQW4iZEh+xVMCx6i1eXmgACDdlkVUvc=
X-Gm-Gg: ASbGnct2nufCkU0K1hgKM4V76e/A1JLl4YMe1sR4lkzu92B2KoPX4wysa5IidxX9+wI
	yE9YJ6wh05K3QwYYsEwin4dB20TGZtUSfh8GLyaeivZVsGyJP5ktTShpkbxeppfM+OI6Zcswr0B
	BYyrlzCLCV+C3zicIIuJaYXgYn9rDf8W36hDyz0QiwBExyNlsdODzxkSVwTTkWOVg9AKZ8w7DcG
	N7JhP1M5Sedaaes5jkyEmcJfK6M5QcoTlteUaGrU7Z8soS7qb3Hxz64mvs1ST3TXaqUas3mqzOx
	WkjWb5KtBeFWPVqJHLVeEiANPxRuMPYFgv1sA7l/CV4WNdTElmIPqI2t83t5drLkomla2O+BGwc
	uGX6uFKDjmoifiA==
X-Google-Smtp-Source: AGHT+IFpvZW2kwMae4JlsvJqjHT+vCYGEckWGeWlq1I7Q8olK4DeUtFpuH7KNu6Y76l9i2TeqVHoHA==
X-Received: by 2002:a05:6000:1a8f:b0:3a6:d95c:5db with SMTP id ffacd0b85a97d-3a6ed612ab4mr5872324f8f.26.1750934168522;
        Thu, 26 Jun 2025 03:36:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d868f878sm160727925ad.184.2025.06.26.03.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 03:36:07 -0700 (PDT)
Message-ID: <95a2ff19-0525-48ef-9949-c3e585e8ed1f@suse.com>
Date: Thu, 26 Jun 2025 20:06:03 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: add a new remove_bdev() super operations callback
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
References: <cover.1750895337.git.wqu@suse.com>
 <c8853ae1710df330e600a02efe629a3b196dde88.1750895337.git.wqu@suse.com>
 <20250626-schildern-flutlicht-36fa57d43570@brauner>
 <20250626101443.GA6180@lst.de>
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
In-Reply-To: <20250626101443.GA6180@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/26 19:44, Christoph Hellwig 写道:
> On Thu, Jun 26, 2025 at 10:38:11AM +0200, Christian Brauner wrote:
>>> +	if (sb->s_op->remove_bdev)
>>> +		sb->s_op->remove_bdev(sb, bdev, surprise);
>>> +	else if (sb->s_op->shutdown)
>>>   		sb->s_op->shutdown(sb);
>>
>> This makes ->remove_bdev() and ->shutdown() mutually exclusive. I really
>> really dislike this pattern. It introduces the possibility that a
>> filesystem accidently implement both variants and assumes both are
>> somehow called. That can be solved by an assert at superblock initation
>> time but it's still nasty.
>>
>> The other thing is that this just reeks of being the wrong api. We
>> should absolutely aim for the methods to not be mutually exclusive. I
>> hate that with a passion. That's just an ugly api and I want to have as
>> little of that as possible in our code.
> 
> Yes.  As I mentioned before I think we just want to transition everyone
> to the remove_bdev API.  But our life is probably easier if Qu's series
> only adds the new one so that we can do the transitions through the
> file system trees instead of needing a global API change.  Or am I
> overthinking this?

Then let's do the transition right now.

The transition itself is pretty straightforward, just renaming and 
appending the parameter list, and keeping the old shutdown behavior.

AFAIK only btrfs and bcachefs will take advantage of the new interface 
for now.

> 
>>> +	 * @surprse:	indicates a surprise removal. If true the device/media is
> 
> surprse is misspelled here.  But I don't see how passing this on to
> the file system would be useful, because at this point everything is
> a surprise for the file system.

If I understand the @surprise parameter correctly, it should allow the 
fs to do read/write as usual if it's not a surprise removal.

And btrfs will take the chance to fully writeback all the dirty pages 
(more than the default shutdown behavior which only writebacks the 
current transaction, no dirty data pages.).


But in the real world, for test case like generic/730, the @surprise 
flag is either not properly respected, I'm getting @surprise == false 
but the block device is already gone.

So I'm not sure what's the real expected behavior here, and the new flag 
is only for future expansion for now.

Thanks,
Qu

