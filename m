Return-Path: <linux-fsdevel+bounces-34387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7009C4E3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF845B25FC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0212038CF;
	Tue, 12 Nov 2024 05:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XHj4s3Hz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED3189F37
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731389511; cv=none; b=ABIPU7Dpj6dN8bZyxeRmQPJiFSpALXX6OmTsigFxbJO8a8WTopmIYOv21dcdKNlfIouL0sqiUs1EDSNJ2DvO5prUS0tG3mwBQnLmRWVZBIKH5eJJgOSAYnljjtjAA9pCkM/763ALGAGHJzOAxYgB6E4+ihxju4i9ZHeNex31yl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731389511; c=relaxed/simple;
	bh=GSuUokYARjlvz5HeFwFhYLs7AZM9K7FbQVb/uQOpJFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jf57mRXTfQXDurDaIhdOCrYt4Zfpe5WtWujdC3BSE998sL1wdLsoSplN54QMKpHDksP82OwU5UkSOcGNCLlPCS6lWCh5eU6gBM1JhXRWHOTy7geC4+sN9lPPxrscT39b44HC88A93jbDMM1VNWMAScsNILgw8ObqqlPwmOhj+q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XHj4s3Hz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso43284425e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 21:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731389508; x=1731994308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2slWMWOHvSQ3Dv+mOQBJUh3petf0L7x0YTYFKMctTo=;
        b=XHj4s3HzmvNGmk3HK6bLe0qfLKU5VVbTRPJnENrPR+6zRycuAwJuncIr0/h9J8VRo4
         YIjt2MIqx/j6+Ehb3WT+Mk6/K0CEZYH3IURd+s5V9Zi0w0bznVhyRYInYFkDpG0QrDoq
         Ypz0KjFngpevMJZ7q9Hh4KwKaWl+XwlIA3wn+ewyJ8iGR+kJM85Sv63QAA+vOwqL3Edp
         sCC86R+7Ujmk4nyyXc6No+JyaN6hKZqLcQk/a71HaQzgx9bubR0NDevaUttJEsy0VgWJ
         np0gxN8W4EXxo+ITfuYBb1fA6UKUwpYtFiQiLzT960Jls9bsJu+nk1mnXs0ohLx50a+6
         PLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731389508; x=1731994308;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2slWMWOHvSQ3Dv+mOQBJUh3petf0L7x0YTYFKMctTo=;
        b=L+2kDKwvkIsHkJnxa/QgOGNlQY/sqXJ8ZRK0kJtLVrHn8zBmH8SbauVn4fF3yQYxFB
         Wc0XDxrq3kkVqMfuI+3s0Mg9zN8dQO+mZK7cJaFjcLZKCv4KNPtU1E/9L5Q5Q54ep/yN
         Hzfc6fvoEf08xyB7FL4fSuvC85ioNI6etNffuPuc0R4xRISHrKGMdc3HAUBOaj+f23aH
         8mg8lTy22XFll7AVjQ1QVLyx6AGmJmJ99VD1Vw8EpscaqCvsDPrLI/EAQyeQqtFIC+2f
         etJiXr4Qn4EHg8YHwe4GMnouJzQNqvsuF23xJxABCMFM4N3RUe1j2CjMHmR98hCQDzvC
         afug==
X-Forwarded-Encrypted: i=1; AJvYcCVxqMmPrUs7kKXFrdD9Sq46JXAXvvDXi+vub8YZmZOHe0J2iLMEMVEayCzYeMAw6WqKkTcfwCUCuVLLpbFR@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9m368MM4RKVjVEMMePkpqxDr2oJizRxuVEfw2pxP+WqhI6EJ
	sLjmt0NCZcEe2Kk/dhrx4hGzp/+WCC5vusc/jIXfSbDVZKKm3RqhhxIrJxHKyWE=
X-Google-Smtp-Source: AGHT+IFMECw8pZMzid8H6DKjtkZFipTtaipy83dELXggkrL7U9Dnu9Mb4b2rneLz3yBUTApw9yWfvA==
X-Received: by 2002:a05:6000:4107:b0:381:f5a7:3e8b with SMTP id ffacd0b85a97d-381f5a73eb5mr8723726f8f.51.1731389507572;
        Mon, 11 Nov 2024 21:31:47 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a62bfb6sm11725474a91.43.2024.11.11.21.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 21:31:45 -0800 (PST)
Message-ID: <b595203e-c299-46f8-b79a-185276d53d89@suse.com>
Date: Tue, 12 Nov 2024 16:01:42 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-fsdevel@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
 <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
 <ZzLiBEA6Sp-P7xoB@infradead.org>
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
In-Reply-To: <ZzLiBEA6Sp-P7xoB@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/12 15:35, Christoph Hellwig 写道:
> On Mon, Nov 11, 2024 at 06:06:57PM +1030, Qu Wenruo wrote:
>>> Why?  They aren't exactly efficient, and it's just going to create
>>> more Churn for Goldwyn's iomap work.
>>
>> So it is not recommended to go the write_begin() and write_end() callbacks
>> at all?
>> Or just not recommended for btrfs?
> 
> They aren't a very efficient model, so I would not recommend to add
> new users.

No wonder no one is adding support for IOCB_NOWAIT.

> 
>> I know there are limits like those call backs do not support IOCB_NOWAIT,
>> and the memory allocation inefficient problem (it should only affect ocfs2),
>> but shouldn't we encourage to use the more common paths where all other fses
>> go?
> 
> I'd recommend to use iomap.

Definitely the way we will go in the long run.

Although I'm still struggling on the out-of-band dirty folio (someone 
marked a folio dirty without notifying the fs) handling.

The iomap writepages implementation will just mark all the folio range 
dirty and start mapping.

So I guess there must be some fs specific handling inside the mapping 
function, let me dig it deeper and check Goldwyn's work for details.

Anyway thanks a lot pointing out that the write_begin() model is already 
kinda deprecated.

Thanks,
Qu

