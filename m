Return-Path: <linux-fsdevel+bounces-40572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80579A2547C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71DF16271E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED6E1FBEB3;
	Mon,  3 Feb 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2SgwLNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D51FBC86
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571786; cv=none; b=aYUhGFvr73hOTBVs6xBLq6Pirq/nZRJGRmU5o2qjFIwjiWrQlgmqYbPDX0rTLwrNTYCJttm62Z+3ZHSO1u554OyRgeuPukG9HpswokCKA5aF8oX/X8a2ZXGqXaSiOuFQYEMJgX2DDXkdXQZXFPze0gAHBgcaOf5QU3YHqgZzL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571786; c=relaxed/simple;
	bh=BFuRgvpk9Ikt8mYWi/LPsGZ/S41lOj1GXBt37WO9iaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umTPcONAN+vKqZQQQDgn6sDOAc6BJtCnhENQf/Myf18j4RMfMudIE3l2wsUBuaUijCh1ns4WRIiviKWslJleOh6ubllutqpp6W6Xi76AG6NXRULItGgj/vDZRYl6mYLDzIIkGswqtBVfDsRd6fl+3ZfJCL3YSzT2v9xhRyiSMPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2SgwLNX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38a34e8410bso1988674f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2025 00:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738571783; x=1739176583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jqAlTEwav17I8RuBsiv4sqCdYRrJ7WOllLr3rsZc9+c=;
        b=Q2SgwLNX2kpoztvjkLNOO8OVd7c67a48+JPQKHgYd96ShVJP1itFlOK+eS+Y0RqdHR
         6hec/8tY/6jPwzKcSAnLd2e+UKOEDK6Hn6sUyV0dkf5JHbHk1TGGsKOXIPTMGhYfO5/i
         WT0v7xFt8l0LrHYLaZH/EeWIeKV2chTMJ5spryzxTqw47bUurTmiM7yQPLSUSAM2K1vf
         coHF+biEAReclc+74mmqPWj1ro3g7386cE15flzcGOXKwT+kU3A34EHf8ASJIMTtNya6
         +evHbyWHHnQ9Uc42x/gT5qPAwcEE3ARMl9tNdZC3Oa9pFx30KMNudDta/LuGrGws48XG
         KjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738571783; x=1739176583;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqAlTEwav17I8RuBsiv4sqCdYRrJ7WOllLr3rsZc9+c=;
        b=KZFGwRG2pkcuG5b4jGwj9R2Hjh1Yvr1s/x/UddClCnQCn2LYDd66bcUAxLfDhbVYao
         zu6WrlqC2b1uOwOutimLl/C3ErzEC878gL3rH9d2OC3fD3Z3qWJjaGaIMNyHNFqWFwx3
         e6CHJ7RzWCokWt58aRLS8cUoi8T2d53MvuwLeQy/ELtPmAVQ5fREvNTKdVo1r3/zL5H7
         CSuszdAocAiZ09zifOSRm1K2TILLMxMkl6Wb+EZtuKvhCH/9uUEi0vUZbwis8zQnjyyf
         ZD+zdw6NpsOIEUhd2YZW/cWnaObgakqX7bCLnhb6LC5FX5sTy2Co8GXEzdN+LldO0Kwe
         n9eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrxvWnh10ZCK/DRsOdX8HcIE8Q25Hcl9RMKgcsHg+R/IkqSyCW/B5vSRC3P5YbTm/hhydcXGb06wZu2Re5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WeMe9C8DdFt87Iat/0m9eybKqiVd3xAT6Vw87AZ6WYiKT5jK
	RDL1DWtLjQ2VnMRqs4/pUvOMSi7gAyGQ0Crm18eCFvPb1T62m2f8XVeKvYDepVQ=
X-Gm-Gg: ASbGnctQl/fIaZp/1VGiW1HEKrAJfk1De/07yZ452UfhSgasDOkdB6JVCHeoIMHQITK
	MKsuqsGacbGu/DmLVIGX8EcGwVDN6y4n1Cw8ypgeEkciBKc2ecgwnuDWlfJ5GI2zdmEhOZEH0SG
	P69KjGA1KJeLxi6zodbURsXzzjjQ2BdIaJ9K+7LWI1PFg7LLUt0w43kH84ZgLN4hlHju9FNog8y
	aQ7R0602AAZIFUanOSKxXSQHTwyY1GvGJmqSh+9XRnt9169cKQUzoV5oJriSKwIBRAaXtpx4o8+
	vb5pmQAIoU87xxBIZg6/aT0nDsENDv72hv0HSoz95cI=
X-Google-Smtp-Source: AGHT+IExiCnr5bhzGChI/EAcZsdE4WZTkN1CKPEFyjA/pkaaGS3fOIRYJD3Somr3OcHZ61kIy6L4pg==
X-Received: by 2002:a5d:5f56:0:b0:38a:36a5:ff81 with SMTP id ffacd0b85a97d-38c520a3440mr19499172f8f.40.1738571782709;
        Mon, 03 Feb 2025 00:36:22 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f830a3d74esm3719298a91.2.2025.02.03.00.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:36:22 -0800 (PST)
Message-ID: <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
Date: Mon, 3 Feb 2025 19:06:15 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: "hch@infradead.org" <hch@infradead.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org> <Z6B-luT-CzxyDGft@infradead.org>
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
In-Reply-To: <Z6B-luT-CzxyDGft@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/3 19:00, hch@infradead.org 写道:
> On Mon, Feb 03, 2025 at 08:26:33AM +0000, Matthew Wilcox wrote:
>> so this is a block layer issue if it's not set.
> 
> And even if the flag is set direct I/O ignores it.  So while passing
> through such a flag through virtio might be useful we need to eventually
> sort out the fact that direct I/O doesn't respect it.

The example I mentioned is just an easy-to-reproduce example, there are 
even worse cases, like multi-thread workload where one is doing direct 
IO, the other one is modifying the buffer.

So passing AS_STABLE_WRITES is only a solution for the specific case I 
mentioned, not a generic solution at all.

But I would still appreciate any movement to expose that flag to virtio-blk.

> 
> Locking up any thread touching memory under direct I/O might be quite
> heavy handed, so this means bounce buffering on page fault.  We had
> plenty of discussion of this before, but I don't think anyone actually
> looked into implementing it.
> 

Thus my current plan to fix it is to make btrfs to skip csum for direct IO.
This will make btrfs to align with EXT4/XFS behavior, without the 
complex AS_STABLE_FLAGS passing (and there is no way for user space to 
probe that flag IIRC).

But that will break the current per-inode level NODATASUM setting, and 
will cause some incompatibility (a new incompat flag needed, extra 
handling if no data csum found, extra fsck support etc).

Thanks,
Qu

