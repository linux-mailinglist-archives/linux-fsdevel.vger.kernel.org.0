Return-Path: <linux-fsdevel+bounces-49680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799ABAC0E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3174E16DC1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C984D34;
	Thu, 22 May 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ntw5I5/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426418D;
	Thu, 22 May 2025 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924262; cv=none; b=Nj+hlpJrgrU6WUVe6bIAnZFDSsaJM6twsd9khOQLe2DAPgoI14ca7vZAXoy3ZJfWHZB8pD/BDd0e9Sm+g83HVUAxro/g74yZIdMJW2CIxuChH0r5GtyZtcMuTmANnANylJ7nP5BDwGuK9spZJ7MAQwW3gqa5FVIJHjQc8wvkCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924262; c=relaxed/simple;
	bh=C9mANWO2tdGkGj480hOqWKG9tNJZfDQRa/cIhE8aKJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTvQCL8nuoqQZdfuiYQPfosCSp8poA6DCj8lO+jZqycvzusOXgkeG1FmVehg2XF0+579oBjIF8UhCLPbEK8n2/LD/EL3LFAEgC4drpVftNwQiEqs9B1cWDaZDNwkJo5X7IQIjXHlNPEoP/inABPUe4vJoFsmIOss513t8q/jDuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ntw5I5/f; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+3Mw7r352YWmBhSYbtfbfaCHLhpUHTjWUILN3KGvHyk=; b=ntw5I5/fikOH+2IgfTv5T8QO6+
	Jr0K/oqnbFt74A5UZD5v39dZcTgk74FrA6c7+WmFkGtrvBBGWExTvyuMTN8mCbyixGHdHcEjGB68L
	MAhvUPs9pBckRFI98UKsXiBvKZGy7UliSC5O+MXtFerJHXalmnl4WCFHNn9WBvremOddtxujtRQXg
	Nt2xo/hCrFPnIoR6WRaaxf+6flqJjGqgEu0sEfkPntDKZu88+abnqpklIQBkn0WacrBf7BzeNNXco
	Bg0sobQjjbWMEOPVcoHXvr6gQSr3QE9+O9/02Nm4MIq5e3+35L8yYaFrWc448Wb4w8OGDYtMEbVKA
	Cgt/FBuA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uI6wf-00Bkgt-4D; Thu, 22 May 2025 16:30:53 +0200
Message-ID: <35eded72-c2a0-4bec-9b7f-a4e39f20030a@igalia.com>
Date: Thu, 22 May 2025 11:30:48 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ovl: Allow mount options to be parsed on remount
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org
References: <20250521-ovl_ro-v1-1-2350b1493d94@igalia.com>
 <CAOQ4uxgXP8WrgLvtR6ar+OncP6Fh0JLVO0+K+NtDX1tGa2TVxA@mail.gmail.com>
 <20250521-blusen-bequem-4857e2ce9155@brauner>
 <32f30f6d-e995-4f00-a8ec-31100a634a38@igalia.com>
 <CAOQ4uxg6RCJf6OBzKgaWbOKn3JhtgWhD6t=yOfufHuJ7jwxKmw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxg6RCJf6OBzKgaWbOKn3JhtgWhD6t=yOfufHuJ7jwxKmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 22/05/2025 06:52, Amir Goldstein escreveu:
> On Thu, May 22, 2025 at 8:20 AM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Hi Christian, Amir,
>>
>> Thanks for the feedback :)
>>
>> Em 21/05/2025 08:20, Christian Brauner escreveu:
>>> On Wed, May 21, 2025 at 12:35:57PM +0200, Amir Goldstein wrote:
>>>> On Wed, May 21, 2025 at 8:45 AM André Almeida <andrealmeid@igalia.com> wrote:
>>>>>
>>
>> [...]
>>
>>>>
>>>> I see the test generic/623 failure - this test needs to be fixed for overlay
>>>> or not run on overlayfs.
>>>>
>>>> I do not see those other 5 failures although before running the test I did:
>>>> export LIBMOUNT_FORCE_MOUNT2=always
>>>>
>>>> Not sure what I am doing differently.
>>>>
>>
>> I have created a smaller reproducer for this, have a look:
>>
>>    mkdir -p ovl/lower ovl/upper ovl/merge ovl/work ovl/mnt
>>    sudo mount -t overlay overlay -o lowerdir=ovl/lower,upperdir=ovl/
>> upper,workdir=ovl/work ovl/mnt
>>    sudo mount ovl/mnt -o remount,ro
>>
> 
> Why would you use this command?
> Why would you want to re-specify the lower/upperdir when remounting ro?
> And more specifically, fstests does not use this command in the tests
> that you mention that they fail, so what am I missing?
> 

I've added "set -x" to tests/generic/294 to see exactly which mount 
parameters were being used and I got this from the output:

+ _try_scratch_mount -o remount,ro
+ local mount_ret
+ '[' overlay == overlay ']'
+ _overlay_scratch_mount -o remount,ro
+ echo '-o remount,ro'
+ grep -q remount
+ /usr/bin/mount /tmp/dir2/ovl-mnt -o remount,ro
mount: /tmp/dir2/ovl-mnt: fsconfig() failed: ...

So, from what I can see, fstests is using this command. Not sure if I 
did something wrong when setting up fstests.

>> And this returns:
>>
>>    mount: /tmp/ovl/mnt: fsconfig() failed: overlay: No changes allowed in
>>    reconfigure.
>>          dmesg(1) may have more information after failed mount system call.
>>
>> However, when I use mount like this:
>>
>>    sudo mount -t overlay overlay -o remount,ro ovl/mnt
>>
>> mount succeeds. Having a look at strace, I found out that the first
>> mount command tries to set lowerdir to "ovl/lower" again, which will to
>> return -EINVAL from ovl_parse_param():
>>
>>      fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = 4
>>      fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0) =
>> -1 EINVAL (Invalid argument)
>>
>> Now, the second mount command sets just the "ro" flag, which will return
>> after vfs_parse_sb_flag(), before getting to ovl_parse_param():
>>
>>      fspick(3, "", FSPICK_NO_AUTOMOUNT|FSPICK_EMPTY_PATH) = 4
>>      fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
>>
>> After applying my patch and running the first mount command again, we
>> can set that this flag is set only after setting all the strings:
>>
>>      fsconfig(4, FSCONFIG_SET_STRING, "lowerdir", "/tmp/ovl/lower", 0) = 0
>>      fsconfig(4, FSCONFIG_SET_STRING, "upperdir", "/tmp/ovl/upper", 0) = 0
>>      fsconfig(4, FSCONFIG_SET_STRING, "workdir", "/tmp/ovl/work", 0) = 0
>>      fsconfig(4, FSCONFIG_SET_STRING, "uuid", "on", 0) = 0
>>      fsconfig(4, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
>>
>> I understood that the patch that I proposed is wrong, and now I wonder
>> if the kernel needs to be fixed at all, or if the bug is how mount is
>> using fsconfig() in the first mount command?
> 
> Maybe I am not reading your report correctly, but as this commands works:
> 
> mount -t overlay overlay -o remount,ro ovl/mnt
> 
> and the fstests that call _scratch_remount() work
> I don't think there is anything to fix and I do not understand
> what is the complaint.
> 
> Thanks,
> Amir.


