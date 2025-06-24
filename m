Return-Path: <linux-fsdevel+bounces-52737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEC3AE6177
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E6F407336
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F35283C82;
	Tue, 24 Jun 2025 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P4pt91vt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6322820A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758719; cv=none; b=W9Lf7yFQwU5uFAoayzlJDbVDNOIPWa3CzWTsEl4gSvTyESb+B7l52tn8lS1v6lLoB5yT/S4ojBhAJCgkFPza49jVZCa/jdA2KUCeCzvPK/M0aFGMcYpBSOGRRYhnuL8GveBYBlOOExfS6Vcd0QCDEHSHI0pzNzQJyOajn4fb1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758719; c=relaxed/simple;
	bh=3ggjFNl0YiUcZwHZCzVY2fLaZl2eqqSvLjxPcrQQ5iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QdybBQUknojAQv1k/3OCbzZcEnkWmgExzLV17TTkufrynOelmkO/pisZLEZC1HuqJQzM+/PACKlaRmrq4onAXIloUSELKd6Ck+ckkcLtC3NxQgRspVhE0/7FGkVSzj38fsBPFPmM46PisuGFRt81cQfW+P1mcXRgL5DT/KEpwZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P4pt91vt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so194521f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 02:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750758715; x=1751363515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mCMEAjfRu5oUF/8uWMFtpH6cgk/kkkTfVrjbmLL8XJI=;
        b=P4pt91vtdnJ66d1BkubJS+uWK4DRIYFFhkZHdEaoXlPOGy9GgKEfKlO12+d/LEnA7f
         U0WGM7X5gf+2OnkSyf8sBW9U1A0dy/A2zFoKG7A0YuQM1Xw33oH9o+pz9MP/fE5Bpxf6
         zMmhczrpG2M78946/NPxrMbEAS3W2KLK/iJ/TS5wZs4eJk1BMdZPI3lXoVGuXc1nieyw
         l6TD2z6PQcKbdGoMoKXsqKYuLK2I4ary2qYxin0/xfv+xGrXz75fK23BT8dDyFKwppSW
         HAf/NIPE49jKWcgPVQmvKQ6+EQOyp5X4YQxNM4sWAzh2rerOPCaxU2zPNLY6DTsdiWsg
         Aaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750758715; x=1751363515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCMEAjfRu5oUF/8uWMFtpH6cgk/kkkTfVrjbmLL8XJI=;
        b=pn7GeDlJ5BQMGoFwv8/axLb6vTAr6IJhMAQRkkViBRmXSRq2CJlncp1BZ+6Sr2QyhI
         yHoRUpU1NASVH/K3/IijRdoO/ftv4CSogIpoM800abg0IWiICKtTosgWWZNVrgWl5Gvr
         Zz8Kt5urxqSjD/C0uN0Fe/FK0bv+bH5Gi/cOmO+lTpWY77Wo+1OgBApLxftSiAVyK3y9
         tgQSAXearFgPBbiLWRVc0OfLlHOC45L27YOLNfvIguJ1G9Li7RsXR1RKkONLdTSqjyDd
         sc1OHT7YGtDawYoQKQ5ut1Y8IFIU+I/T1flyln0uLQNBGLQj6yBU32i2fQpm2gturoHt
         7XCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHXR8fYi9XcS1SBZFGOLU3T4afa9lxJYKSPqU5IBKTf+kVQip0f4K8BvLgqnPqA5ns3xG5GnYtBcetD2S4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5oh2//pXGIaKtciWKbPy4dKHctnYrm5epODzokR0Tak8PrzLD
	mKOSo11PBsZSjpX9En38IZKCBWDWcoEuPziRYjVXBlDu0q4NvMRavpjdjm+PjTsuCqU=
X-Gm-Gg: ASbGnctwekYhoAzZsZt3SPDu9nU4Me5b6WF0TsBdex03wSCCalFpHi/0wrVjd60nyGp
	OUkM1FRnoMIfsTcpAdAJYJdO0CCOEPoLMNDTG5bL1BO4tCvBnCZWz05bYzAZbSf9DoIMtEh6u4S
	QUCoPvR4DVVaZjOw79i/p9+qekMwe0pntg4jyX2fWmh6EZwWm1KqpL138OHGmj+SPmh8Wu6ZIRr
	3oxTcm9hdhCx7IxYien7H3/g0PhCFKj/j7QNW73y8v78bXlsUw2V2K/OErxNoLG7eCuPswqk045
	MxBNrpt6wAZQdwyDWh2LhDU5adfpyD4Pgdh4scynSVxhObx/Ww/a4zrbVki0hnqA/isAiqP9Ly0
	wB+vBUg/uQQhMoASDE7xWnCYL
X-Google-Smtp-Source: AGHT+IFsuTvDUHmwiflUkrAvnHqrLlFxtwWqNkQoNZHM87eDeSw6YeebvIDXbtNpDWjsXgce3SdntA==
X-Received: by 2002:a5d:5f4b:0:b0:3a1:fe77:9e1d with SMTP id ffacd0b85a97d-3a6d12c1848mr13619681f8f.16.1750758715062;
        Tue, 24 Jun 2025 02:51:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f11easm102204355ad.84.2025.06.24.02.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 02:51:54 -0700 (PDT)
Message-ID: <abe98c94-b4e0-446b-90e7-c9cdb1c9d197@suse.com>
Date: Tue, 24 Jun 2025 19:21:50 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <20250623-worte-idolisieren-75354608512a@brauner>
 <aFldWPte-CK2PKSM@infradead.org>
 <84d61295-9c4a-41e8-80f0-dcf56814d0ae@suse.com>
 <20250624-geerntet-haare-2ce4cc42b026@brauner>
 <8db82a80-242f-41ff-84b8-601d6dcd9b9d@suse.com>
 <20250624-briefe-hassen-f693b4fe3501@brauner>
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
In-Reply-To: <20250624-briefe-hassen-f693b4fe3501@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/24 18:43, Christian Brauner 写道:
[...]
>> It's not hard for btrfs to provide it, we already have a check function
>> btrfs_check_rw_degradable() to do that.
>>
>> Although I'd say, that will be something way down the road.
> 
> Yes, for sure. I think long-term we should hoist at least the bare
> infrastructure for multi-device filesystem management into the VFS.

Just want to mention that, "multi-device filesystem" already includes 
fses with external journal.

Thus the new callback may be a good chance for those mature fses to 
explore some corner case availability improvement, e.g. the loss of the 
external journal device while there is no live journal on it.
(I have to admin it's super niche, and live-migration to internal 
journal may be way more complex than my uneducated guess)

Thanks,
Qu

> Or we should at least explore whether that's feasible and if it's
> overall advantageous to maintenance and standardization. We've already
> done a bit of that and imho it's now a lot easier to reason about the
> basics already.
> 
>>
>> We even don't have a proper way to let end user configure the device loss
>> behavior.
>> E.g. some end users may prefer a full shutdown to be extra cautious, other
>> than continue degraded.
> 
> Right.


