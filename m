Return-Path: <linux-fsdevel+bounces-38483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2347A03265
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 23:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598721885C47
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DF1E1A08;
	Mon,  6 Jan 2025 22:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JxIZAVBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9B1E0DD9
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200815; cv=none; b=hR8lWoVQw+DxpSOkBI2aqqjAKLx7LcUaHQjNzR6LLfVJa3LweLaCuK+T/44ptFbX/0ie9xw8TSMzzmbcC4ZQoEkDnZ23wJ8ZYlsyk5WCbjC0DV+ppdcs2ym+xtpisMfgHkllU6QYSJVgqff0ukKIhpmIRQoux05D1egX7XLnpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200815; c=relaxed/simple;
	bh=v8rpy6PG0nq0UvnObT6Q3zfeQ5hF+sVeTC2y0RSQkzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWB1jh91Z4vbeVzCQrsXEVRGZ1Njr0/yXljxW82ryGsa4SN46m+KXG6FKDfoMj4qitK08gGVwrSlDtoGZsbo8D37+QfwOPy2tZipSAqBaZ/O5SH5pbMzraa/UKpg/ylrCHaT4XDbADh7Bn8R+oicHZfS+1ErN0C9K/OMzHNyQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JxIZAVBS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaecf50578eso390008766b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 14:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736200811; x=1736805611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+XQHlzH0IPMSSYa20ZvXqUmjwG8STbttCyRRBx8b3bo=;
        b=JxIZAVBSNDccZKcjxg22l2MwpVSo0Z47cTMrZpfbk5Ffe/TxEjwQl8rDvPpSiTaKIL
         mG7ntLIswoX2pKcFxKBARBSMaMr8YDJmLt8d1WLpOT/+0zuyfZzz5oxup+RR52Yw+1P+
         Y+6gaJIu78wr1FE2ry36n2R6Wqvftl2O6GNCNMM0/ANYxV8mR9fAER2rpJdcioxWMuQX
         fPqPyhJiuCMvU70CtB3GV+KtbDDqhK9pc95T/NcYSWDFvp6Rh0ZFp+9q1KZqQe/0ZGry
         1JMMzXleBAcwuRa5GOOjTIoJkBbcjVD3iRhF/N+TFbW9EZtjopkIBuuTdVDr2evFQCet
         Tegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736200811; x=1736805611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XQHlzH0IPMSSYa20ZvXqUmjwG8STbttCyRRBx8b3bo=;
        b=tnqdZROLbK//UTB/OaLZ5XSgpe1vulXgQSX0cfQMXNF1/yBt3zRmopa9/yR9M75c9L
         7dMxWd1NYDmg7EAgMsM39KZK1gjWGXDfhK6Tpt1CdfvacBZhGMJOZiRAk+VdFSEte98L
         hFyxyYElbgwow36RbqHK8uXdG1ollCkD9MgzLW6czfVgBid/HJM2TleAgnDESyjEuX7Z
         4VIBKP+fp1XWBVGDcy52GMBNrIPCxXOxVcts1kaiD2Qs4c+EcndUSMPLkVxdcBCxtaqB
         c0C00+oM+0NaJ0u6+tkXMokpZ/17Ax0fbvMKMN+7foiFbxolWkjz1dI6PTkeYmylZCkl
         1oFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQkg2PKI1v76UhNiGMvxjGagrA8HDopZ4XPqg1amAC00d54SXol6P1kfnn+wTwiJEyHrzJ169yPciU222M@vger.kernel.org
X-Gm-Message-State: AOJu0YycEMHshY82Cz6u9aun1ycsBiQo6sugpexnjwOwvX5ZEWKdXpw9
	BOa/hITqM9hsEzkRiVarm3RILacgIHorFq0a0+wjhZKDx94PFEsCAdWVmDg0pL8=
X-Gm-Gg: ASbGncsU7N/xsJTbxxs8VLi6FJl6HTjW3IIYh3KWds0O+X5GXB82cGxnU20GjFNyT01
	M+OFajUvpYnvXeJyH5DZwV/iBgjisdMi7dcPyLKmA02qFaTC+on/Ai6XSobK3jzLOuj7BXi+eM4
	6QRBga2smJbb+ao4USV93v8riHT78QiMX1e4HtVAOMWeihT6KRS05WWOpsovwNGd7KHu5gtyx5j
	L5nwgzGMIwVebcQDCy/GCR9McnpLuYj/JH98vX4hQmmtb/gMF2tru+rl3YZj7poBthZ1AdjwrdL
	ziT+1Ort
X-Google-Smtp-Source: AGHT+IF9ihUF/Sp0+6lwDc7T1klzmbkyJFfCNzLLW/oMyVOGu6o3Fy0UFA8ZvofC9ZeihZnm3Q6JFA==
X-Received: by 2002:a17:907:180b:b0:aae:e948:1bab with SMTP id a640c23a62f3a-aaee9481c0amr3804059466b.36.1736200810595;
        Mon, 06 Jan 2025 14:00:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d4474sm299039235ad.142.2025.01.06.14.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 14:00:09 -0800 (PST)
Message-ID: <1d0788af-bbac-44e6-8954-af7810fbb101@suse.com>
Date: Tue, 7 Jan 2025 08:30:05 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mnt_list corruption triggered during btrfs/326
To: Daniel Vacek <neelx@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, linux-fsdevel@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <ec6784ed-8722-4695-980a-4400d4e7bd1a@gmx.com>
 <324cf712-7a7e-455b-b203-e221cb1ed542@gmx.com>
 <20250104-gockel-zeitdokument-59fe0ff5b509@brauner>
 <6f5f97bc-6333-4d07-9684-1f9bab9bd571@suse.com>
 <CAPjX3FcG5ATWuC1v7_W9szX=VNx-S2PnFSBEgeZ0BKFmPViKqQ@mail.gmail.com>
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
In-Reply-To: <CAPjX3FcG5ATWuC1v7_W9szX=VNx-S2PnFSBEgeZ0BKFmPViKqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/7 08:20, Daniel Vacek 写道:
> On Sat, 4 Jan 2025 at 23:26, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2025/1/4 21:56, Christian Brauner 写道:
>>> On Wed, Jan 01, 2025 at 07:05:10AM +1030, Qu Wenruo wrote:
>>>>
>>>>
>>>> 在 2024/12/30 19:59, Qu Wenruo 写道:
>>>>> Hi,
>>>>>
>>>>> Although I know it's triggered from btrfs, but the mnt_list handling is
>>>>> out of btrfs' control, so I'm here asking for some help.
>>>
>>> Thanks for the report.
>>>
>>>>>
>>>>> [BUG]
>>>>> With CONFIG_DEBUG_LIST and CONFIG_BUG_ON_DATA_CORRUPTION, and an
>>>>> upstream 6.13-rc kernel, which has commit 951a3f59d268 ("btrfs: fix
>>>>> mount failure due to remount races"), I can hit the following crash,
>>>>> with varied frequency (from 1/4 to hundreds runs no crash):
>>>>
>>>> There is also another WARNING triggered, without btrfs callback involved
>>>> at all:
>>>>
>>>> [  192.688671] ------------[ cut here ]------------
>>>> [  192.690016] WARNING: CPU: 3 PID: 59747 at fs/mount.h:150
>>>
>>> This would indicate that move_from_ns() was called on a mount that isn't
>>> attached to a mount namespace (anymore or never has).
>>>
>>> Here's it's particularly peculiar because it looks like the warning is
>>> caused by calling move_from_ns() when moving a mount from an anonymous
>>> mount namespace in attach_recursive_mnt().
>>>
>>> Can you please try and reproduce this with
>>> commit 211364bef4301838b2e1 ("fs: kill MNT_ONRB")
>>> from the vfs-6.14.mount branch in
>>> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git ?
>>>
>>
>> After the initial 1000 runs (with 951a3f59d268 ("btrfs: fix mount
>> failure due to remount races") cherry picked, or it won't pass that test
>> case), there is no crash nor warning so far.
>>
>> It's already the best run so far, but I'll keep it running for another
>> day or so just to be extra safe.
>>
>> So I guess the offending commit is 2eea9ce4310d ("mounts: keep list of
>> mounts in an rbtree")?
> 
> This one was merged in v6.8 - why would it cause crashes only now?

Because in v6.8 btrfs also migrated to the new mount API, which caused 
the ro/rw mount race which can fail the mount.

That's exactly why the test case is introduced.

Before the recent ro/rw mount fix, the test case won't go that far but 
error out early so we don't have enough loops to trigger the bug.

> 
>> Putting a list and rb_tree into a union indeed seems a little dangerous,
>> sorry I didn't notice that earlier, but my vmcore indeed show a
>> seemingly valid mnt_node (color = 1, both left/right are NULL).
> 
> The union seems fine to me as long as the `MNT_ONRB` bit stays
> consistent. The crashes (nor warnings) are simply caused by the flag
> missing where it should have been set.

That also means the mnt_flag needs to be properly protected, at least 
with the same level of mnt_list/mnt_node.

But a lot of time such flag is atomically accessed using 
test/set/clear_bit(), without the same level of lock protection.
So my current uneducated guess is, there is a race window where the flag 
and member got de-synced.

Thus it's not as safe as a non-unioned member.

Thanks,
Qu

> 
> --nX
> 
>> Thanks a lot for the fix, and it's really a huge relief that it's not
>> something inside btrfs causing the bug.
>>
>> Thanks,
>> Qu
>>
>> [...]
>>>>>
>>>>> The only caller doesn't hold @mount_lock is iterate_mounts() but that's
>>>>> only called from audit, and I'm not sure if audit is even involved in
>>>>> this case.
>>>
>>> This is fine as audit creates a private copy of the mount tree it is
>>> interested in. The mount tree is not visible to other callers anymore.
>>>
>>>>>
>>>>> So I ran out of ideas why this mnt_list can even happen.
>>>>>
>>>>> Even if it's some btrfs' abuse, all mnt_list users are properly
>>>>> protected thus it should not lead to such list corruption.
>>>>>
>>>>> Any advice would be appreciated.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>
>>>
>>
>>


