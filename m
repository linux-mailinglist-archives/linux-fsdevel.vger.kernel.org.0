Return-Path: <linux-fsdevel+bounces-64078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC68BD7580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438AF423F6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3547630CDB1;
	Tue, 14 Oct 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IVGS5Vgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1930CD9A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417743; cv=none; b=gKef+qk2I9H898GfZjoOi0TihHWcVDrw9z1kQMsuVFnUZNN/n2r/Z1HX11deiRE0/wNtQ0bHXu6QzWi1+hDlQn9c7bz5KW2BIWea/WCaWs0U/YXXFYkuHgrybZt/yeYyQP8UCk0ENvX0O1Ddb0+vJB5LXqnuqIuVevf96ilCgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417743; c=relaxed/simple;
	bh=VPhpVFbQBsJa0uDcQCZ2WXYujh2s2dYEdK+H07NdtnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahV+xJzNwifdgIKWYDlClJbYkx1IKV1Cd10kkXwrZ5CimBQOJm3oZ0K/jdtzKiK2Lvd176IxevgRdGeQTH/GMU0seqD94uwYdVjnfVRiXH1wK9Y0T9eTWf1t8MXbFzbWoA3bEwatvMkHZMZitFexcIEgJu73rxsOxwSYVN8xqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IVGS5Vgd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3866097f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 21:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760417739; x=1761022539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OuRR4HM/Tq0zE9Q9qfR9j2/5ZKN0yyFSQeDH1SzScS8=;
        b=IVGS5Vgdr12vtM7vsNo8FR+YqlCkkuejL96xS5WDmiH00dbNpwrUemCVhEdUqExLJm
         3O6HcztmtZQ5oSfRposEo8zeCOPHmo3AOQTMUo+4LLIikwWs7Q7pTp3aEeTQa7COThVj
         B1d0B3wSmwhTej2ZrCVuXRbwiocCg6LQcn1OKFd1s4s2/rBLwD/ai0ISiLL4bB/kBXO/
         2HUSFKTVYvf7qCE737sIZtQhNTu9wKRiNOqpOICojSsc4Xd2c/NZKTD9urJChJVqMTye
         4Y/SSkzKyuAEI6upPNQ89X7qAedtvFJRLsan5x+YmuMdWqdExdScf2gf7CLk6Fxzt3WT
         W0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417739; x=1761022539;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuRR4HM/Tq0zE9Q9qfR9j2/5ZKN0yyFSQeDH1SzScS8=;
        b=llf+Q/KKeL2hoZnwm5b2fQejiYNu1bbi9ydSvjLBPfFH0n6mDYisrts9p14c6AEes6
         swc3SGnFNL05jiujxZv4Fns/MhSuMv3eK64Hyg14YEjmNF3SOoGiS09gwCD08nt8rvkM
         1vwgV5mWEp5t8jJymrDk/Owa+iCHljjC8D0T3ufZi7/t7uJttwSnpgyQ2dCv+s+GjQJC
         QtyawnUM0qWlTbtTSQLsJt06k6PGaWg6MlA5AcIbAu9QSHRe2w6upuIpp4W3CEL8mpgb
         YgecAWSnGwzBUHBL3sMVrvSZm8zcHi3n5IP2Nk6fG6yzcymQrohDrjFZ/yKx/YsW2sSj
         /vnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEX/yvEC+aF71elDKxkXEUt+DhYqe/raI3XNmY3H698U66LvR5mOQSPhqgW7gx109u35Nk/kUBPDBTvFR8@vger.kernel.org
X-Gm-Message-State: AOJu0YyOK5HBOkKizviXbK/bL/ei+d6oXEX9U2luS5pOZqsIxOx/xEQB
	72ErNzejz9eK2cb1kK/ZuEAhC7PQ/i3o8t1f+142mWNoyzy3E/Pp9q18292s5UBYW9TZqmsHxv2
	JRqbl
X-Gm-Gg: ASbGncv6pP9Kaw+hC+stypOCR/6/BLWYmytMULlkwoL+lCAsIREBZU1SA3WaAPFNiKZ
	ayNjP+COEhBDTKFrGWT5HoRjKPuZM8bKTzNxrLradcsy9gtpDIMvPwe18e3XQNtb4eJlfs2aNFx
	uUsKhmNXV4nF2tlzCu/Wc2pxyB24yNwwFEP1wisnRqrh9pLPBSY6+fGgdB46QAxFfXAF/iu78uj
	vp6eQOYiGXVJrJoiRf2zGRlYJDfynN7t37M0S8hScvEIfYWzkYNSAiIoT5MVcPN0jG3Y8JjYaZL
	J/Rhfz0S/bjRv6kN37I2aHOFO0ihD2XwKB5HXUb9ylcPC0N77NgOuXAxT+/9d6J2RaChGE21WwD
	qPZmw0lF5legLgZpwHaU44QiOcWUB+fJIwcometqNvlJdfNSB7uJD9Z3ChpriHqZV2C76sBM/bM
	jRS0NP
X-Google-Smtp-Source: AGHT+IEa6oT+J6JgllW/T27rHWkHsP9KH7yULtWakf1OtcsDunxs6VTM1FzatF4Amm77K/fp3Jm9GA==
X-Received: by 2002:a05:6000:41cc:b0:426:d55e:7229 with SMTP id ffacd0b85a97d-426d55e78f2mr7606823f8f.17.1760417739463;
        Mon, 13 Oct 2025 21:55:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df8ea31sm10650897a12.42.2025.10.13.21.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 21:55:38 -0700 (PDT)
Message-ID: <5a9e8670-c892-4b94-84a3-099096810678@suse.com>
Date: Tue, 14 Oct 2025 15:25:31 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-btrfs@vger.kernel.org, brauner@kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <aO3TYhXo1LDxsd5_@infradead.org>
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
In-Reply-To: <aO3TYhXo1LDxsd5_@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 15:06, Christoph Hellwig 写道:
> On Mon, Oct 13, 2025 at 07:35:16PM +1030, Qu Wenruo wrote:
>> - Remove the btrfs part that utilize the new flag
>>    Now it's in the enablement patch of btrfs' bs > ps direct IO support.
> 
> I didn't really suggest removing it, but splitting it into a separate
> patch in a two-patch series.

Oh, sorry, I just kept the btrfs part into the enablement patch, and 
that enablement patch requires quite some other code that is only 
submitted but not yet even merged into btrfs development branch.

Thus I didn't really want to send it right now.

>  We could probably even move everything
> through the btrfs tree for 6.18 to get the fix in.

Unfortunately that may not be that easy. Either we merge it early, 
meaning just this change + using the new flag in btrfs.
But that means it makes no real change at all, as bs > ps direct IO is 
still disabled.

Or we wait for the btrfs sub-block checksum handling patchset merged, 
then with the full bs > ps direct IO enablement.
But that also means we're waiting for some other btrfs patches.
There are already too many btrfs bs > ps patches pending now.


I'd prefer to get this merged through iomap tree, then utilize it in 
btrfs tree later.
Just like what is going on with the remove_bdev() super block callback.
(VFS change is merged in v6.17, but btrfs will only merge it through v6.19)

Thanks,
Qu

>  It's just important
> to keep infrastructure and user separate if you have to e.g. revert the
> btrfs part for some reason, but we have another user in the meantime.
> And I plan to use this for zoned XFS soon.
> 
>> +	/*
>> +	 * Align to the larger one of bdev and fs block size, to meet the
>> +	 * alignment requirement of both layers.
>> +	 */
>> +	if (dio->flags & IOMAP_DIO_FSBLOCK_ALIGNED)
>> +		alignment = max(alignment, fs_block_size);
>> +
> 
> This looks much nicer, and thanks for the explanation!
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>


