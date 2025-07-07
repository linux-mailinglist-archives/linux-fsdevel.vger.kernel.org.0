Return-Path: <linux-fsdevel+bounces-54193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73471AFBE7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A7D7A3123
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD112749E6;
	Mon,  7 Jul 2025 23:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b2PAma9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99621F4626
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751929457; cv=none; b=fnJNbq4EhGUYAUS9Ecro7jo7hySsLl9TGFl8m1UZovLU5At0GP4iHUWDDZTl7Evl9CnXI4SCEB6WERfifXUREVJBbSWVuhOHWHQfJPo9G2laI5jlYLLetN5A4L/c2RfdFunjqXsjG7A+a6d30y973mA6hZP2RZM5aoC+YTK5x3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751929457; c=relaxed/simple;
	bh=iTcscXLpiNPkLALp2XqDRTyYaj6XRnBYFsKRM+hRvp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcESDhK51DprV4iwdrhn/9tTuwSXGclfRAcbl5k6ERotZEo9PkrAtQ5KzLZqP1pYIz1rUnIYPzGRcd7kpgPqBFQeY5csln3qL1UNGAhY/wLlGjfbvw+DDnoMuleyT7Y55xd4N8H7B0tVpJPL20ZeLXweEvnmqMFDk5lFeo9wprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b2PAma9x; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2479177f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751929454; x=1752534254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iKJ3IWaVesX53YBHi2MAXOtjvL7dHq4KVlTeOhgVcrY=;
        b=b2PAma9xgxSovs/6UCOeUOSFf29YA5Gnc2RsgdAfljqDjsp0A3uJhW8vad/CtUzc/C
         YBzv1QGRH9ZZ4Jm59Pz+vn8bF0R3vyZat+SGyuUc8VVVJpZ+ZlkOcX/Bsd5RC/HzlCQx
         5xLzFlat9zaqgA/8RtETgaeAwtP1qU0iCxDkke8fcDY2byXPKu0ptPsnNr449ZKHKOK8
         tvOfFyL/ryRu4vspu5O57OnmP4d/RrSAPsGdZJ7vZW7CH4/H+WVBcIk14/YCX57EGgMP
         zTU1NIVZ8VssG2yPUfAtMNiRFjqE/0tAjh+7RVAKLmZcKBk+RWSctimdx8MNYnpWniez
         LEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751929454; x=1752534254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKJ3IWaVesX53YBHi2MAXOtjvL7dHq4KVlTeOhgVcrY=;
        b=WWYnLXchbV1keCgaHXBio4QPnK/thSQyxCj1mXL2S1MGOdi+s72VD7KpPPycNfQuww
         EDsvIRjXSA6+78hhC63jZf8Ono7wvKVIphpj0t0R/DMkt+ViaQbPToDSj0yL76jF6kEk
         iUdN9t1BK9s6Hx0/3CzAnQCWjpap84WU53Ka1Gc4VW/1zR6I4AWvVJVn4kBDM4YBFcRI
         IksIQ0lGh4CXJEFTS/z0Y96ZFD9y/qIQ6PeFqmtd1R8AOwahDBFekCXHetHSBCgqyNFk
         s6fIKaGYgfg52xelYFrsQAyk1gy29D+cvNFTc1xwFjUcY538MWK2/ffIzEv2ynEysDah
         M8lg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Bq69E+/XvmXZaklHGMsO81EtkjpJrWrneHNyJ2Q6rJR1YjDvUToSexgo//Qqk04yLHeHbMfAGbuMHFlZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwgZlbfmpVxPdxPFcGFsq9+dNQ/apsBrctjMrztyQGorYA6qXrf
	UV1w+HAUE+Cwty0SFjNRWNzPnYJg02gFWUTfVYR5SovNFpp45Fo+uuBCXzvsSe92qbI=
X-Gm-Gg: ASbGncuMZp4GXvZyildnDUGdjWRsZFHHFxo16g6kibiZE5NbxIOSTNRQldLpazrumz/
	+0Fw+SRWFpG6Vebl5+5rgjk8svdJJlZvFJXH3jXNE19pJS2wQ7e+Jh/+zuxk/vzp4fiP00jdZwo
	+SXUpiMkPCAxfufI58y+xi3nkrfDSywSpDRUW/V84Xiu0AxTy3GB3/HkOMCHF+nE0q7Al/KNSg9
	dq+neI+r+nS4r4Za/dXv8xZMnxbxXvSynZRNjReOsYiSelchbsf/uyxOO//ZQduW+L3vgHr5v9x
	2/mzwKw4HKIy26jiQ5uUQDgm8VPDnUS6GbDPp4qa7u95Wrc2FkZ17r9b4Pzfy23bhJ2u5gqjGtm
	PIPVqVsK+YzJjAg==
X-Google-Smtp-Source: AGHT+IGattlpWjGt+2o+RMaSUgOSTRf8EPzXLwte5tyvRPcnP3BvyHxs2B7miIWwAIZD2rhaeoH/YQ==
X-Received: by 2002:a5d:64e7:0:b0:3a4:ddde:13e4 with SMTP id ffacd0b85a97d-3b4964ee263mr10740028f8f.58.1751929453847;
        Mon, 07 Jul 2025 16:04:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431edb8sm101139545ad.50.2025.07.07.16.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 16:04:13 -0700 (PDT)
Message-ID: <eac924e4-fb2e-42fd-979a-4a0829f67377@suse.com>
Date: Tue, 8 Jul 2025 08:34:09 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] btrfs: implement shutdown ioctl
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
References: <cover.1751589725.git.wqu@suse.com>
 <5ff44de2d9d7f8c2e59fa3a5fe68d5bb4c71a111.1751589725.git.wqu@suse.com>
 <20250705142230.GC4453@twin.jikos.cz>
 <6642f8b5-d357-4fb6-a295-906178a633f9@suse.com>
 <20250707205125.GI4453@twin.jikos.cz>
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
In-Reply-To: <20250707205125.GI4453@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/8 06:21, David Sterba 写道:
> On Sun, Jul 06, 2025 at 01:07:19PM +0930, Qu Wenruo wrote:
>> 在 2025/7/5 23:52, David Sterba 写道:
>>>> +static int btrfs_emergency_shutdown(struct btrfs_fs_info *fs_info, u32 flags)
>>>> +{
>>>> +	int ret = 0;
>>>> +
>>>> +	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
>>>> +		return -EINVAL;
>>>> +
>>>> +	if (btrfs_is_shutdown(fs_info))
>>>> +		return 0;
>>>> +
>>>> +	switch (flags) {
>>>> +	case BTRFS_SHUTDOWN_FLAGS_LOGFLUSH:
>>>> +	case BTRFS_SHUTDOWN_FLAGS_DEFAULT:
>>>> +		ret = freeze_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
>>>
>>> Recently I've looked at scrub blocking filesystem freezing and it does
>>> not work because it blocks on the semaphore taken in mnt_want_write,
>>> also taken in freeze_super().
>>>
>>> I have an idea for fix, basically pause scrub, undo mnt_want_write
>>> and then call freeze_super. So we'll need that too for shutdown. Once
>>> implemented the fixup would be to use btrfs_freeze_super callback here.
>>
>> It may not be that simple.
>>
>> freeze_super() itself is doing extra works related to the
>> stage/freeze_owner/etc.
>>
>> I'm not sure if it's a good idea to completely skip that part.
>>
>> I'd prefer scrub to check the frozen stage, and if it's already in any
>> FREEZE stages, exit early.
> 
> I have working prototype for pausing scrub that does not need to exit,
> so far I've tested it with fsfreeze in a VM, I still need to test actual
> freezing for suspend purposes.

Not sure how would you test with running scrub and freeze, but please 
enable lockdep for the potential reversed lock sequence related to btrfs 
specific locks and s_umount/s_writers.rw_sem.

But I guess we should have a test case utilizing freeze and scrub.
Especially that fsstress doesn't include freeze, thus we have to 
manually do scrub and freeze (maybe with fsstress at the background).

We need such test case no matter if we allow scrub to be paused/canceled.

Thanks,
Qu

