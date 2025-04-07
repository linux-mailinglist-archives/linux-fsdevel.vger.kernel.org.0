Return-Path: <linux-fsdevel+bounces-45907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92EA7E85A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 19:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B88C3B9706
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F522CBFA;
	Mon,  7 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU4Tf64N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8922839A;
	Mon,  7 Apr 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046991; cv=none; b=g5W0iZX9C+RZaPacGJZSALOWPIkkwYGOtJjzZ8MPD94FmoGKMCNzgJRI84bTKFQnrv4X2oO4vF+EDdQSEFUoDMRYrzjupSCvJEwHA9gSXsKghvUO4i0QXiiwvZc04/Vc0vDx2Zf8SnS8zv69RZw2koSVprhAgF/SW0bELXrNiPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046991; c=relaxed/simple;
	bh=4psbfQ0+xtdgkMP8AkN/dMbVmSHGCs80nffXYJ4DnTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZCXrHs5cef/VwkJLi0TSLvSUTI0Yfo9EFGM6VbVcVu8Wa5ms121W5tdxITI/cIG/hgFNqLHPV2LmQzqYNW/COw6gNNDHMMz8yGkNlX1DehDFzcLUxJmotG/CMmdG8vPZ5gGJ8oyaXaCZ49xnDuXEs9m0fwQLl9XtybXBH8doU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU4Tf64N; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso29694875e9.0;
        Mon, 07 Apr 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744046988; x=1744651788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QfAVWYxeBG/ZP6eGSXkzfSFJe0M/8UDNl8FMmsW9Ss=;
        b=RU4Tf64N9sw2kfyAHNz4oLg/2VB3UVI1lZUyBUjbJwNNpNEuBwkOqqy+Xmh+SnZwHm
         YD7vxset0LC8LI7TQGCHdvUWVo7AwkzkM57ts2RMOp9ki1knH0oCmQDCiky5+ZgFQcpd
         Tu7BpXSViwAaHWaBOisRySsKhbpCsMbbdl5bjcpmctjtSFZeMj5v6dtgIwlyopvDpdyQ
         IQ1qkjNrnVMFPwyOExtL4rwKGo8iq3iIUntwInzCceB9vM1KR4QDaBHMUSwEcrBWGppu
         uzmjmArUMgKOucB46kuurrdB8ZJNbfEyDfmFrSGYXwbHLyywfK0FZVAgxJ17zLaQuTmJ
         vHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744046988; x=1744651788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QfAVWYxeBG/ZP6eGSXkzfSFJe0M/8UDNl8FMmsW9Ss=;
        b=H7gnjOHw0XECMro1YHDKkPaczBa2h7Ia7TUcJREHJ221eAKLVHOUvpv2fJI2NOX+vx
         NtNauj7GPvrpN0yg/kIa7q/Mepb7EQFgSEO5GiExMP+nWRop5RmZPvdNcb/SSNT87kCn
         SqeTprZCoFyGKsooK0i7IyWX3fy42zk+gxRz1ETry3oltslmwJzW0Kn1C19nR9Qy8yus
         auuZtSg2pnUl/v6gPSGPjfgzALlPT1SjXGL6AtL1QXrfzwshW7rjmoFRQNLC50lgW1FD
         UWr+oz4/g+xBHkcqjx8vNwE7Vu1bVPmjxZtrajHR7ISUu4xL/CwsxP3ZSP79L1wBnNf1
         nT7w==
X-Forwarded-Encrypted: i=1; AJvYcCUQqEO2ly9mPXTNMvE/D1d+kCSJsWMcyzdVfdppxIbDIAB597BEnryw8uGkXG6ncLNY6NUxDAun+6RjpeD+@vger.kernel.org, AJvYcCVIFaoO/5sdV7UI8GcKqNKF39xpF+LX4p1YgMDRb+1gmJiIGGT0AX7mIbhOHwIGfRRDsa+HIW8b@vger.kernel.org, AJvYcCXx70B6fNj7xD7ii4NNBezUpOzEVscaf0fCDXKf5Whsa+AlT/9JHwJ3f1o5YK7tX93WjCi9r12Ozjb6iR/3@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpQSGg6LMUK9Twnrmi8eF8uYxd2YVq3YXhh65TDt5xeKGfBGy
	P1cvJPshZYvI+mJmsjgyGsvmIJ4ODzVxlTepyBkCzikyh4gADd+x
X-Gm-Gg: ASbGncv1FM/+mqdrLrz/UebN1qPBWyycSVqDrNJkZeFG0038STYl5si7uLBD7LKLhd6
	HLGO+uPflb4cCYpPC1M2XH9bS+YijKEeXSuXr7023VAyVD+tsTIVA5zwOmkB8yg0RP3wuEhsjo0
	2cCVmqaNDYOlv7gGOHmrD1w4gHGUfBP87s5Dc9nNU1NDXjSag9ZD4TUF/w47mZsJREhyRu6Oz+H
	6Rkma9uBBgQnHL599O/w9pTT3lCCAODin6oquHoH7SVy1w2fToYdPFDn9x/VvomtJu6axoKy8nl
	gYzIPMiI3BPwrVenwtfpD2g45yomHsHppyUev2pp1LQqnQ2vVqkjgnN0ImZ8bgxIcZCT0DgnCSY
	OEIAqikua/g==
X-Google-Smtp-Source: AGHT+IGUbfih/iQ+l6sjRy87j7KU4X6gtlajZs7U5kLH/vsvvC6ZHonIgU2tfATxdwusWZ6tk4rfUg==
X-Received: by 2002:a05:600c:b89:b0:439:8e95:796a with SMTP id 5b1f17b1804b1-43f0e5ecd21mr3000325e9.13.1744046987794;
        Mon, 07 Apr 2025 10:29:47 -0700 (PDT)
Received: from [192.168.0.33] (85.219.19.182.dyn.user.ono.com. [85.219.19.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ea8d16049sm128812205e9.0.2025.04.07.10.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 10:29:47 -0700 (PDT)
Message-ID: <eb465a29-623b-48e4-b795-201a30ae9260@gmail.com>
Date: Mon, 7 Apr 2025 19:29:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
To: Christian Brauner <brauner@kernel.org>,
 Cengiz Can <cengiz.can@canonical.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org,
 dutyrok@altlinux.org, syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh>
 <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh>
 <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner>
 <20250407-kumpel-klirren-ad0db3c77321@brauner>
Content-Language: en-US
From: Attila Szasz <szasza.contact@gmail.com>
In-Reply-To: <20250407-kumpel-klirren-ad0db3c77321@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Christian,

It was Greg who moved this CVE under the kernel.org CNA territory:

https://lore.kernel.org/lkml/2025032402-jam-immovable-2d57@gregkh/

This thread was kicked into gear by Salvatore from Debian, who asked 
whether there was a mainline fix. There wasn’t one upstream, I think, 
primarily due to your assessment.

Meanwhile, the distros wanted to protect their users and fix that gaping 
64k heap buffer overflow with a one-liner boundary check. Canonical did. 
I believe they wanted to help Debian do the same.

They assigned a CVE -with the ID you are seeing- for Canonical Ubuntu Linux:

https://github.com/CVEProject/cvelist/commit/a56d5efc25a561c94ccf296fceaab2a01dc4bc01

It seems Debian initially dropped the config option altogether — a 
reasonable decision I personally agree with — but later reverted the 
change after someone from SuSE pointed out that it’s still required for 
PowerPC, PPC64, and apparently some Apple hardware:
https://salsa.debian.org/kernel-team/linux/-/commit/180f39f01cb9175dc77e8a5e27b78b5d1537752e#note_598347

Still, I think the distros were just trying to do their jobs. Something 
that it seems we might both agree on.

On 4/7/25 19:15, Christian Brauner wrote:
> On Mon, Apr 07, 2025 at 12:59:18PM +0200, Christian Brauner wrote:
>> On Sun, Apr 06, 2025 at 07:07:57PM +0300, Cengiz Can wrote:
>>> On 24-03-25 11:53:51, Greg KH wrote:
>>>> On Mon, Mar 24, 2025 at 09:43:18PM +0300, Cengiz Can wrote:
>>>>> In the meantime, can we get this fix applied?
>>>> Please work with the filesystem maintainers to do so.
>>> Hello Christian, hello Alexander
>>>
>>> Can you help us with this?
>>>
>>> Thanks in advance!
>> Filesystem bugs due to corrupt images are not considered a CVE for any
>> filesystem that is only mountable by CAP_SYS_ADMIN in the initial user
>> namespace. That includes delegated mounting.
>>
>> Now, quoting from [1]:
>>
>> "So, for the record, the Linux kernel in general only allows mounts for
>> those with CAP_SYS_ADMIN, however, it is true that desktop and even
>> server environments allow regular non-privileged users to mount and
>> automount filesystems.
>>
>> In particular, both the latest Ubuntu Desktop and Server versions come
>> with default polkit rules that allow users with an active local session
>> to create loop devices and mount a range of block filesystems commonly
>> found on USB flash drives with udisks2. Inspecting
>> /usr/share/polkit-1/actions/org.freedesktop.UDisks2.policy shows:"
>>
>> So what this saying is:
>>
>> A distribution is shipping tooling that allows unprivileged users to mount
>> arbitrary filesystems including hpfsplus. Or to rephrase this: A
>> distribution is allowing unprivileged users to mount orphaned
>> filesystems. Congratulations on the brave decision to play Russian
>> Roulette with a fully-loaded gun.
>>
>> The VFS doesn't allow mounting arbitrary filesystems by unprivileged
>> users. Every FS_REQUIRES_DEV filesystem requires global CAP_SYS_ADMIN
>> privileged at which point you can also do sudo rm -rf --no-preserve-root /
>> or a million other destructive things.
>>
>> The blogpost is aware that the VFS maintainers don't accept CVEs like
>> this. Yet a CVE was still filed against the upstream kernel. IOW,
>> someone abused the fact that a distro chose to allow mounting arbitrary
>> filesystems including orphaned ones by unprivileged user as an argument
>> to gain a kernel CVE.
>>
>> Revoke that CVE against the upstream kernel. This is a CVE against a
>> distro. There's zero reason for us to hurry with any fix.
> Before that gets misinterpreted: This is not intended to either
> implicitly or explicitly imply that patch pickup is dependend on the
> revocation of this CVE.
>
> Since this isn't a valid CVE there's no reason to hurry-up merging this
> into mainline within the next 24 hours. It'll get there whenever the
> next fixes pr is ready.
>
>> [1]: https://ssd-disclosure.com/ssd-advisory-linux-kernel-hfsplus-slab-out-of-bounds-write/

