Return-Path: <linux-fsdevel+bounces-53438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD10AEF11D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56C81BC5638
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FD224337D;
	Tue,  1 Jul 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VlkR6qYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A981465A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358653; cv=none; b=Khi70AX7wjKQCxsUAHg8hC1KhbFuXz92FCVMWKPb69sxAQMyV0ZemSwjGabpt0DUrqNmUKOxEDq6uRKhxslKMINX/bwdfz0a7jBK5cFhaU3EDa/NYbL+qFKsGwnuCjPvtaI26fjrIdYyme63oKzqeJIKCE2pficAJh1ClvnSShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358653; c=relaxed/simple;
	bh=jFVPizjC1SJlnLk2SyZjJwYurv2Ok3UhbdoJwg+tdkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hW14PZ14hw8gkuDZGmGgI9hyl22IWN4qghBzctd1iBIsFXJbQKRwSxrWcnMOAma1fteGzXmc59i8hvbiTqi28UIH1aHR55l9+Xc76YEJ1Q098H+nefetplIAzqbqMI1ndWclKxmhxBCtFDfj1e4zC3YljTK8IFUMbxVh6Ti/1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VlkR6qYw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453643020bdso46438635e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751358650; x=1751963450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9/bQAEZcF0mBIWfmGiF+sYNUM1oOuQ28vDEPiWDOuPs=;
        b=VlkR6qYw87QTrFCUm1I3xSkjfO+Zxt43UCSgsVZfovf2VN5RiKAZhOeInkzEHOKYhV
         W6bmT5+Kn0byrfSh1tBLUI1FvGsuTy4CUelEgOU4I191DIkjJ1qoedNm+0jryhfziDhF
         SvckcSj9EE3pdKjb3a7zbCaw50eR3c9N+chMOp6s0SE9DMO9ubGSRMGlDWlDCFz2olSk
         OdqBc8T8VF5C5/Ai+eHcNVFdi5ucgrbTKc6tOr8dWIhmXD6PLOzLdeqZXsG1f7njFJz/
         66OrosF/XsVbVxzQnh/zop8yjhXmO67/RwLVKeWl2AV/tQRTSe9msbojndOPtqZGNxTj
         1IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751358650; x=1751963450;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/bQAEZcF0mBIWfmGiF+sYNUM1oOuQ28vDEPiWDOuPs=;
        b=vS/uB+GWGDwRxQtIXnVa9Q0r8mpctqBk+ocBJHMGf1RfQf3H+E0nJbD6RayCJuOnVt
         XNSp96YJVyAxNwvx1hP3fhNvFL9lTydvkRYm6xXK5xzG7Cudn4Scs0lkV0at6ZmQa6IK
         5JmyF9U7R1VmCAlrxxFKNUYwna0pnauodXCQFA5kEXJKzaz9xNtCUDYyvamFBRUIFzrW
         Bry8QPvhbegnRMw1g3NU07a9+LqR9ekRBJxyqKxO8/xE5i3yZvGDDYGeh4H1vRFG1XGH
         FOM48pKKB7XJccLdsDOI9U7UU1hmLghEMCB7738mWTnvY5Tn/sv1EuTWzTBjb9KZBa8O
         LgOA==
X-Forwarded-Encrypted: i=1; AJvYcCWCeqUiGykkjYXcz1tKoS1zTy7vx8Vn13a8iDie/4Ikub8oXrTI7Cmb3T15k7l1PPqMSGY2Bx9KTYhOcvKK@vger.kernel.org
X-Gm-Message-State: AOJu0YzrExM2bqv1ONInKhBo+zClOO+6ymx6HDKpmiMpRt5QJGuTCN4U
	UAKcrJzEBmt7uykUOUw5KZ6XBwiA9MJWTqLJp3iGS85bwgaWDaWRvM5HT1m6nbcTFAc=
X-Gm-Gg: ASbGncsYlWoV7AE3FhMh8yTB6X7wYYGh09Q4zPsDJX2ojYulT3x6iKVQ82GS1FrJw1E
	GEp7F27piDcxUHrVBxKXW7G74+yabUz1ULWp4L4ViiBR1KhP64St3ozeDocJ5lPC6VRRqR1CeLn
	t5uT1OXfdnYnknk8OHL9hWN8PAMeMmuFBB8a4z3u/ZpoBdfi2mVI/HYK0G6ICk3Dvr4bFfGUWBs
	RrLSMkhwtEIP5AbrvGVPc1hAmP8TNvPFBwE0Jgegqk39eY5yKyiT0tQDDf4/lOPynvYjEsK1p8m
	VpmfRETc+AmhTqtYVTtGUtDqHhuQloXNW7vlZfkKpCroVgABGZNv/Ev6IbMuNC0jMhxkWrdpZxY
	McX0c3CxDGvn5MJjxHkUF/6gM
X-Google-Smtp-Source: AGHT+IHSkw6RSzLG3Mq8vgCv2qJnzOh7XFAbsxGFSLxdm1LXyo0ZldU763ptRnon5RRq20HSfPQKTQ==
X-Received: by 2002:a5d:5f49:0:b0:3a5:5270:a52c with SMTP id ffacd0b85a97d-3a8f302a206mr13378986f8f.0.1751358649523;
        Tue, 01 Jul 2025 01:30:49 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31beab2sm10083514a12.47.2025.07.01.01.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 01:30:49 -0700 (PDT)
Message-ID: <c6ef9cda-3fc5-4531-9586-f22914607d53@suse.com>
Date: Tue, 1 Jul 2025 18:00:40 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] btrfs: implement remove_bdev super operation
 callback
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
References: <cover.1751347436.git.wqu@suse.com>
 <5c1f7441e3e2985143eb42e980cdcf081fdef61e.1751347436.git.wqu@suse.com>
 <d0d7243d-4254-41a3-85c6-887f9fb0db36@oracle.com>
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
In-Reply-To: <d0d7243d-4254-41a3-85c6-887f9fb0db36@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/1 17:51, Anand Jain 写道:
> 
> 
>> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
>> +static void btrfs_remove_bdev(struct super_block *sb, struct 
>> block_device *bdev)
>> +{
>> +    struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>> +    struct btrfs_device *device;
>> +    struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
>> +    bool can_rw;
>> +
>> +    mutex_lock(&fs_info->fs_devices->device_list_mutex);
>> +    device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
>> +    if (!device) {
>> +        btrfs_warn(fs_info, "unable to find btrfs device for block 
>> device '%pg'",
>> +               bdev);
>> +        mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>> +        return;
>> +    }
>> +    set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
>> +    device->fs_devices->missing_devices++;
> 
> Where do we ensure that the block device wasn't already marked as
> missing? If there's no such check, could missing_devices end up
> exceeding total_devices?

Right, I'll change the device number related changes behind a 
test_and_set_bit(), so that we won't double accounting the missing device.

Thanks,
Qu>
> Thanks, Anand


