Return-Path: <linux-fsdevel+bounces-67383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3205C3D823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 22:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EA0188F074
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB962DAFAA;
	Thu,  6 Nov 2025 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Shz3ZEzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14B27B34D
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464752; cv=none; b=MnuGxO0qKEIaxj7SiAN9Zfp0PTciBqVjC9gk+SO2FxrHJm4y0BL2c8FsRO8St93DRrtT+uv0zU5xGMJ7/y2vnq8Kq9LzZ1ut96Y1G6ZdZ0YinM+IzFN2BM+FHZwiziDrJg8itbvbDigssf/RIGbMZsaT3uh74x6oSBI/2TA/mNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464752; c=relaxed/simple;
	bh=fecFx/t7L8vvCJRCQbKPNNG2J+WblOy8POjq0I2U5jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwwfkitU5auWS4KCw4T3UTJm3kslHWfdL+AlK5j4jKrccRFNPvPs84D7CjDKZZD89HN5Yonz+H1ZmWK8vVxuH7yRpWTX8ukTYaxE6rqbUrtrz0Qh9+lQvKKL9nhGJ+hvlsaFUSZX22hlpGlbRVoOAkJpGnxZT0zcXrJycVwzcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Shz3ZEzz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so157583a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 13:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762464749; x=1763069549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zhq7i3Ootp6TCl4bpOuk7N8zjrt6NTyMMkOo5kF2FY=;
        b=Shz3ZEzzqdz6jmtFAujrz52MRjWoMTvpwjT5ThnjJOsBEfXJb4Q1eZJuZH0nA8nG7M
         VH3GiQ6pJAzwbIDnaOK92DQtW6UKWvu30CQJsjUDY3FJ8mr80K6jrzkXnkoOYjOQsL9F
         2IXJk/WcLr/qiKOKYPJnKFuDlBQ1pwSrASqSdtFm60RH8TFosSPoH3g+o2pwmESM9kp+
         rRb7TcobQVx9wxEkzDeijeqr3FyIMKV1t+SYdCt8271ywogIWv4GHeBxqCzkgBt5WZpz
         uNznHdfOXUr+wlUfTI/1Mz/A1lqdzfdY0vpdBd8ls9OBzFzVdhs/BmgJvnB3wr5jP8Bd
         vSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464749; x=1763069549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zhq7i3Ootp6TCl4bpOuk7N8zjrt6NTyMMkOo5kF2FY=;
        b=tD5s6mVT5cfp7Y/JZDoZKlVtsSiAA2cv/d2K3/H2MbPumDMBjAfPcmeaHxGvKPUVr4
         RewAlOblX+RqriyJNhgxD9uR7NRZmuxIlwCJrvL5Yo7+CkdHjuw+7NwBljWRyHU/3mpa
         9BQrGv/klW7sj6xsW41MDIkoAOxkG3yG7z9c0cn4LeNmhPqB1rc4XEE2iAlP6I8kDkQS
         j+bvqPaD3jTO6Uy1HAGlp2F0RB6BJ+35p9ymZqleXcFr7Od3DgR4H9qT4qb7cnMMloa6
         LtykPCd20lF/FzrsixqXyQs4LnrGaUlnpcPo6cAOOKTG/mbJbvcwih6zAPoPVtGiuqgc
         ZgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGjTk5hq832tKtCpXRTzQypg6nLizDNECnaBnz8jKBgRG1jq42DEDRbGsU+DO/mi6HlT00KC/dmHSGUhvd@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjPHwYjDqGiLVp8PCAu+Pgyojk4ww1UovSu92zKlwvOZYE6bM
	bV+D9n6kqkGgCU92JHJ0IxWBHuTJ3/h5fkkEHHqlX9fTeW2l5M3AUgpo5tUEo/hIv54=
X-Gm-Gg: ASbGncus9FSkPU/WvX43ItKO5y4Qy+6WBT23NyK23DQyZbaV8VkdEYOEDJxAfu5ql8Y
	sfp7gk39JmOrKpYk/1v8D9GWVrnuObCcAWVW27XDgEGDL+cqYKEpwXwmUEE4MkUdIDHCY1UH0GN
	nVwUDpzdp2Jv49MTNWJNguoWTsuaU6GZr4nLj2IZFxNkSI7ZdFvRc9A5nvs5saJnNtE0pQMv3nR
	6S8gmcpRDil+nF22+rRYeVV/twS8PtpTGSCke+eF/ogC8RdgXBL/KswzPas+u9Tw7BV9GBrsTs0
	1tkLKeLKk+84j3xKEvp6O5nM4SLX4LXkulmd1WKS5B3vGgwRYM4vyWoxSiExeHF7ZoesaUtQg8f
	QsgxyStsj7pPKCvkDLHR8K84TRDmA0qNf78Uw+sVKxD5wfXhJiMSxWaNa6tQ0Vv6owxBoPbzRmh
	ICH5OY9p0HCkmXJtF8WAJS5IrpeyXyZYwEm3Wpcqg=
X-Google-Smtp-Source: AGHT+IHzIsrey2y+zYqsQwavARwdNkTyJaxf6mCPs5Ou4Qh+P1VO4BJT1ebwB3JFVG1wc1sXWrzzYw==
X-Received: by 2002:a17:907:1c08:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b72c08dc7e9mr72882166b.2.1762464748541;
        Thu, 06 Nov 2025 13:32:28 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d168sm37955495ad.36.2025.11.06.13.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 13:32:27 -0800 (PST)
Message-ID: <a43fd07d-88e6-473d-a0be-3ba3203785e6@suse.com>
Date: Fri, 7 Nov 2025 08:02:23 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Why generic/073 is generic but not btrfs specific?
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
 <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
 <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
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
In-Reply-To: <06b369cd4fdf2dfb1cfe0b43640dbe6b05be368a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/7 07:41, Viacheslav Dubeyko 写道:
> On Fri, 2025-11-07 at 07:28 +1030, Qu Wenruo wrote:
>>
>> 在 2025/11/7 07:10, Viacheslav Dubeyko 写道:
>>> Hello,
>>>
>>> Running generic/073 for the case of HFS+ finishes with volume corruption:
>>>
>>> sudo ./check generic/073
>>> FSTYP -- hfsplus
>>> PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC
>>> Wed Oct 1 15:02:44 PDT 2025
>>> MKFS_OPTIONS -- /dev/loop51
>>> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
>>>
>>> generic/073 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
>>> (see XFSTESTS-2/xfstests-dev/results//generic/073.full for details)
>>>
>>> Ran: generic/073
>>> Failures: generic/073
>>> Failed 1 of 1 tests
>>>
>>> sudo fsck.hfsplus -d /dev/loop51
>>> ** /dev/loop51
>>> Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
>>> Executing fsck_hfs (version 540.1-Linux).
>>> ** Checking non-journaled HFS Plus Volume.
>>> The volume name is untitled
>>> ** Checking extents overflow file.
>>> ** Checking catalog file.
>>> ** Checking multi-linked files.
>>> ** Checking catalog hierarchy.
>>> Invalid directory item count
>>> (It should be 1 instead of 0)
>>> ** Checking extended attributes file.
>>> ** Checking volume bitmap.
>>> ** Checking volume information.
>>> Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
>>> CBTStat = 0x0000 CatStat = 0x00004000
>>> ** Repairing volume.
>>> ** Rechecking volume.
>>> ** Checking non-journaled HFS Plus Volume.
>>> The volume name is untitled
>>> ** Checking extents overflow file.
>>> ** Checking catalog file.
>>> ** Checking multi-linked files.
>>> ** Checking catalog hierarchy.
>>> ** Checking extended attributes file.
>>> ** Checking volume bitmap.
>>> ** Checking volume information.
>>> ** The volume untitled was repaired successfully.
>>>
>>> Initially, I considered that something is wrong with HFS+ driver logic. But
>>> after testing and debugging the issue, I believe that HFS+ logic is correct.
>>>
>>> As far as I can see, the generic/073 is checking specific btrfs related case:
>>>
>>> # Test file A fsync after moving one other unrelated file B between directories
>>> # and fsyncing B's old parent directory before fsyncing the file A. Check that
>>> # after a crash all the file A data we fsynced is available.
>>> #
>>> # This test is motivated by an issue discovered in btrfs which caused the file
>>> # data to be lost (despite fsync returning success to user space). That btrfs
>>> # bug was fixed by the following linux kernel patch:
>>> #
>>> #   Btrfs: fix data loss in the fast fsync path
>>>
>>> The test is doing these steps on final phase:
>>>
>>> mv $SCRATCH_MNT/testdir_1/bar $SCRATCH_MNT/testdir_2/bar
>>> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir_1
>>> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
>>>
>>> So, we move file bar from testdir_1 into testdir_2 folder. It means that HFS+
>>> logic decrements the number of entries in testdir_1 and increments number of
>>> entries in testdir_2. Finally, we do fsync only for testdir_1 and foo but not
>>> for testdir_2.
>>
>> If the fs is using journal, shouldn't the increments on the testdir_2
>> already be journaled? Thus after a power loss, the increments on
>> testdir_2/bar should be replayed thus the end user should still see that
>> inode.
>>
> 
> Technically speaking, HFS+ is journaling file system in Apple implementation.
> But we don't have this functionality implemented and fully supported on Linux
> kernel side. Potentially, it can be done but currently we haven't such
> functionality yet. So, HFS/HFS+ doesn't use journaling on Linux kernel side  and
> no journal replay could happen. :)

That's fine, btrfs doesn't support (traditional) journal either, since 
its metadata is already fully COW protected.

The journal-like part is called log-tree, which is only utilized for 
speeding up fsync() so no full fs sync is needed (which is super 
expensive for btrfs)

That's the reason why btrfs' fsync() is super complex and Filipe spent 
tons of his time on this field, and it is btrfs that exposed this problem.


But if HFS+ on linux doesn't support metadata journal, I'm afraid you 
will need to go the hard path just like btrfs, to manually check if an 
inode needs its parent inodes updated during fsync.
> 
>> To me this looks like a bug in HFS logic where something is not properly
>> journaled (the increment on the testdir_2/bar).
>>
>>
> 
> This statement could be correct if we will support journaling for HFS+. But HFS
> never supported the journaling technology.
> 
>> Finally, if you're asking an end user that if it is acceptable that
>> after moving an inode and fsync the old directory, the inode is no
>> longer reachable, I'm pretty sure no end user will think it's acceptable.
>>
> 
> As far as I can see, the fsck only corrects the number of entries for testdir_2
> folder. The rest is pretty OK.

So it means the nlink number on the child inode is correct. I guess 
since testdir_2 is not the directory where fsync is called, thus its 
number of references is not updated.

With journal it will be much easier, but without it, you have to iterate 
through the changed inode backrefs, and update the involved directories 
one by one during fsync(), just like btrfs...

> 
>>> As a result, this is the reason why fsck.hfsplus detects the
>>> volume corruption afterwards. As far as I can see, the HFS+ driver behavior is
>>> completely correct and nothing needs to be done for fixing in HFS+ logic here.
>>
>> Then I guess you may also want to ask why EXT4/XFS/Btrfs/F2fs all pass
>> the test case.
>>
> 
> So, ext4 and xfs support journaling. Maybe, it's interesting to check what is
> going on with F2FS, FAT, and other file system that hasn't journaling support.

IIRC F2FS also support journals.

For VFAT the test case is rejected due to the lack of journal support.

On the other hand, if HFS+ doesn't support journal at all, you may want 
to add hfs/hfs+ to _has_metadata_journaling(), so that the test case 
will be skipped.

But still, since this test case already leads to fsck error reports, it 
is worthy some improvement to avoid such problem.

Thanks,
Qu

> 
> Thanks,
> Slava.


