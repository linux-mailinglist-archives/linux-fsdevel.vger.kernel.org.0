Return-Path: <linux-fsdevel+bounces-67380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83593C3D706
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 21:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BA218904DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 20:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C929E3016FD;
	Thu,  6 Nov 2025 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VvWnVQ1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9A301492
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462709; cv=none; b=sZx6Yc/zbvMe/PJZUb8oAxydwHnJfSsi0hakEx5OJZQeWiZxBkwRW9Y1q17tkVdbY8vgNMP2p79qjfbuaRR6cpJrYbq4gZT/8FWkv4fpheEYfvVQIEK93ZtPmUCyURS19J5Zi1nHhZ48wqa0A8YX9vdfcPye8feclmW52/EebBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462709; c=relaxed/simple;
	bh=KZhz5eQ7q/AiEupzpsmWBnryb8pI1ssE1cx2mIkFWao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQwl+itHwcjl0GJlOGCAxZ1KnRZ9GHbG/81hkILODQiOd3DDQMsqVBOmRXk/+vlSdpLOdrGPuM44M4ia3zN0Oq26jn1Gl6lKJCfCwWTfZWp2/7AVJDx3QUZ4C77R+tsThFFTZSRd9lVSWOAPvrhfoFtgnCmhgo8ujY61Uel6tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VvWnVQ1q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429c7869704so44713f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 12:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762462705; x=1763067505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao8extSo5bmFO2zc5UKdNwzzn7TqD+9Bp3jkMJaiWb4=;
        b=VvWnVQ1qVq4Iwdx6jNpHf9aEkH8ntQ3TYnIgKK+n4xJcNNLnOy/MoJpvmYfx24cE0v
         1sM5q8EDtQ3LRE2oce29wcP7sHwQ8GjMAOjzw69ZVdXgsgOH1579b4cIsEoZpf/+5Wm/
         caHPsr9u94CW5NipyDFdGQtnEA5a9dCCOm8stxRF3xbTEi3RVpAlqJfPAKKZZaWlAtWk
         liaRTdJ4h2ffLfiSu9SawhYAzw7HmOOCEkc3M06aQ2sh1PgmJV1rrbcTWa6iUfBQbL3c
         RZISm/+FGklNxWGir3lelOMZuvIWhMC6k0IoJU3tEQ/GE412fUSDUS86luhRUVOvQKIg
         T76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462705; x=1763067505;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao8extSo5bmFO2zc5UKdNwzzn7TqD+9Bp3jkMJaiWb4=;
        b=QtWzk4qGBffVNft818OFxFFHkZnBHVnWZunYHjuFDMYhDJm1K11k+/PY7wRdnLNzEX
         WDT2v23nKyE1bmflWfmBGz6D+jN59M9P89JBX/Xe45Msmsy4/jN3bjvjfEDCvDfdx9tH
         Ybsy6JyKLoy4/WjSV+PGnrd+arQWYXsihkrmH4Td2V6jZVx8Oq8AMN4zhvTQw6Tz+eC0
         PirskDknAlDMzu6dyDyoju+MjCfvDXdGdbSArrpFzwCmjKHQLnDE8LQFqxXFYn8MUEHs
         1EBi9AZcb874CADw4fjIDBm7G8DEYK4/ktU5t/MM5AOziDMG+hUbjzkmIeBjJ2pYkGZp
         RHbA==
X-Forwarded-Encrypted: i=1; AJvYcCUzTCw3oLMICtRHxuGZHG2fS4V2Gyc7S9K10Wiv/9K/Mocua7C9wNQrYK6YqNS/tOLIbZp6a2IyN4/u3NSQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtgsBH0WlmijiOOaSDvcNFCive4Bg2LsHu7g4CTg+QspQwncB
	hW5KG7ScIDSnZfH/VzBBhgFEEZDWBya26m3HIVf935nTdzf1yQkFlRAsxZrRX7WIfg4=
X-Gm-Gg: ASbGncsWePqef4IyXevElLQH/0kscb2aphoVf6yQPR5VQcRTIdI5eg95vFSEl9vDx91
	yH/OIsl7qJyHeKLafp5ilWXC5lZEcYdIFXtahqh8IrlMYs5KHj14n+Qbh/Fo3nKV+PBAREBdbWr
	S09GTbo3RkdKgo3tB5miac+Zjbg4aADvqpG+FTOL4hBUPsEhe3/UYfaJCwERNIgZGJcxB7Tctsz
	ramwqzA1RKy50X7CmDCOpadYyNWzBxMKydCRul3IVKBVK1lAWBXjde5Z0re2My7DKvEjb7qh75X
	8uVXPnN+O6dx/Ad6IZhl7r33edlsRgw7YjcEF0WlfH+dw7jdjmEX2eNoKGtJN8YRsIvBmugWnSH
	Dc+a3pjHE/jEqDw1Uza1B2oyBU+j94JdJ3fJ002IEt/eyxjSGOrnKTn6j94tHC3Hg6WU160mSec
	AifFomJdD1EAsWrfwlBbKjNffo4GhY
X-Google-Smtp-Source: AGHT+IH5MGpGQM60OmxnprGDqam5Y8Wv/zgFMjhf9oztcy5xq0ofEfq8Ahm1sFIq06k6wV7CQuNr8A==
X-Received: by 2002:a05:6000:4282:b0:426:ff46:463d with SMTP id ffacd0b85a97d-42adc68ab4amr520425f8f.2.1762462704888;
        Thu, 06 Nov 2025 12:58:24 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5c3d4sm453464b3a.61.2025.11.06.12.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 12:58:23 -0800 (PST)
Message-ID: <fb616f30-5a56-4436-8dc7-0d8fe2b4d772@suse.com>
Date: Fri, 7 Nov 2025 07:28:19 +1030
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
In-Reply-To: <92ac4eb8cdc47ddc99edeb145e67882259d3aa0e.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/7 07:10, Viacheslav Dubeyko 写道:
> Hello,
> 
> Running generic/073 for the case of HFS+ finishes with volume corruption:
> 
> sudo ./check generic/073
> FSTYP -- hfsplus
> PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC
> Wed Oct 1 15:02:44 PDT 2025
> MKFS_OPTIONS -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/073 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
> (see XFSTESTS-2/xfstests-dev/results//generic/073.full for details)
> 
> Ran: generic/073
> Failures: generic/073
> Failed 1 of 1 tests
> 
> sudo fsck.hfsplus -d /dev/loop51
> ** /dev/loop51
> Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
> Executing fsck_hfs (version 540.1-Linux).
> ** Checking non-journaled HFS Plus Volume.
> The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> Invalid directory item count
> (It should be 1 instead of 0)
> ** Checking extended attributes file.
> ** Checking volume bitmap.
> ** Checking volume information.
> Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
> CBTStat = 0x0000 CatStat = 0x00004000
> ** Repairing volume.
> ** Rechecking volume.
> ** Checking non-journaled HFS Plus Volume.
> The volume name is untitled
> ** Checking extents overflow file.
> ** Checking catalog file.
> ** Checking multi-linked files.
> ** Checking catalog hierarchy.
> ** Checking extended attributes file.
> ** Checking volume bitmap.
> ** Checking volume information.
> ** The volume untitled was repaired successfully.
> 
> Initially, I considered that something is wrong with HFS+ driver logic. But
> after testing and debugging the issue, I believe that HFS+ logic is correct.
> 
> As far as I can see, the generic/073 is checking specific btrfs related case:
> 
> # Test file A fsync after moving one other unrelated file B between directories
> # and fsyncing B's old parent directory before fsyncing the file A. Check that
> # after a crash all the file A data we fsynced is available.
> #
> # This test is motivated by an issue discovered in btrfs which caused the file
> # data to be lost (despite fsync returning success to user space). That btrfs
> # bug was fixed by the following linux kernel patch:
> #
> #   Btrfs: fix data loss in the fast fsync path
> 
> The test is doing these steps on final phase:
> 
> mv $SCRATCH_MNT/testdir_1/bar $SCRATCH_MNT/testdir_2/bar
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir_1
> $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
> 
> So, we move file bar from testdir_1 into testdir_2 folder. It means that HFS+
> logic decrements the number of entries in testdir_1 and increments number of
> entries in testdir_2. Finally, we do fsync only for testdir_1 and foo but not
> for testdir_2.

If the fs is using journal, shouldn't the increments on the testdir_2 
already be journaled? Thus after a power loss, the increments on 
testdir_2/bar should be replayed thus the end user should still see that 
inode.

To me this looks like a bug in HFS logic where something is not properly 
journaled (the increment on the testdir_2/bar).


Finally, if you're asking an end user that if it is acceptable that 
after moving an inode and fsync the old directory, the inode is no 
longer reachable, I'm pretty sure no end user will think it's acceptable.

> As a result, this is the reason why fsck.hfsplus detects the
> volume corruption afterwards. As far as I can see, the HFS+ driver behavior is
> completely correct and nothing needs to be done for fixing in HFS+ logic here.

Then I guess you may also want to ask why EXT4/XFS/Btrfs/F2fs all pass 
the test case.

Thanks,
Qu

> 
> But what could be the proper solution? Should generic/073 be excluded from
> HFS/HFS+ xfstests run? Or, maybe, generic/073 needs to be btrfs specific? Am I
> missing something here?
> 
> Thanks,
> Slava.


