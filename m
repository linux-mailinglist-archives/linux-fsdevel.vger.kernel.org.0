Return-Path: <linux-fsdevel+bounces-17552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D008AF8FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 23:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF94EB2782A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE4143888;
	Tue, 23 Apr 2024 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="nmQU4JJf";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="W4jem5C6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC420B3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Apr 2024 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.218
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908329; cv=pass; b=dnQHzWSS+fv7fcecSQ/eDcMcTHEGozL8dFw8mksbhHDW5GjGYXpuJwWXdh+tSc/6pJJTtdRRn54PlUukp/09j2u9Xsr3SDBqN/+8Z3GpiAGyl0k+ni5D+pOomkf9JWXeJf6WLTSHbYEOaQiGuxJgkpGtal5OkC2FpErgUq5vHmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908329; c=relaxed/simple;
	bh=Zk5njJSVJa074qupboCbzMWQwLFpVYWpJz1hq7jPNIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b22H6CDEErgVTaaEszsEqqbFvaJHU4LpX573XEluC6BdMx23WTMT8ic3Yrg2rpIwBS5iJm+wn+HieflAlFFDp1k4sovlHUlcPZp0M5WGkDZbZ8hHcvL4nl+eo2abioLLbX4JIEtsh9XlijKUywVUZEASHJt+fvAsUy3jDP3rtPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=nmQU4JJf; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=W4jem5C6; arc=pass smtp.client-ip=81.169.146.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713908324; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JCYbZwGu9AgW2prGR7oq8RdGFuKIBqpaoIHHIFp/o0t1Wv6pHPMTEQxjqYoX5Oitkd
    mcc1XW/x6bO6elu5FtqjO6+MpJ6xItmR2THxwNRrXdMGf/I93Mi2ql0W1p+IH0pMOMSQ
    LokuzkohD2uR7xV704sJvdqK79szLV32n4I4vsz2ZkbZlmYEUKOtZxlNdxPYHSeeDlD4
    ypC9FXvOk0rQfeGeZVSbjB4lxRavehbM9tSoj9yb2QQ2tKYkKkAPX7s/SZnh9ZuB2oCI
    aE0pKKCzFsyVULXp4eHpnOJZLCUHK+0B1u9nFEKeEtqGmP7EzWF052OcMi1j8u/oTU1R
    dSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713908324;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fMIc8ZZP0KaBdMmo//JfV9xAkzBPVEo9lwsDsR/39Ws=;
    b=AOE5Jd8hptYde1NLUiTxTCWxU9pjZTEajoaItUlMU64mQl0fd4LEidjY9Z0cq3mEcB
    ZPeVQztnt25toGxkmOTXYvGjuKP1ad+IVKhm9AM48wgk/t7dep1+TVTxJNnsJjigCn6T
    euZ6duEZ06fefS+Hcmp/UcKuFxzf98xqkFKT9kNexP7rcwbGq7mo76/7m9/9gNfMP8b5
    LZ6xbR/EMADBmisciEqvU2PIVKW87zznGGVj4PbGZ5F6BHYN9h7XNU/hdG9jLN1PcXqE
    v371lAqbxvVBUaiRSysTo7TtFqQg8aDKT8mZH0oCguOmzTmImBRddtzp5FWMrBQusWFH
    9zGw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713908324;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fMIc8ZZP0KaBdMmo//JfV9xAkzBPVEo9lwsDsR/39Ws=;
    b=nmQU4JJf5CUWOC7qCeKPKlUeuw9weaU7cSXdtR/ZviNvbQ0QrztDoIFvBy3wMQMvqR
    rKFxfZmU7BqPsZyv5jPbZkePsbrPXfk2ml0JO37snxFXj73qTlUos1YRx8L31Yr4A5DP
    HmuD4Bh4Z3+WG6StWbGTnyCkBaW7jAop36NV1AK3JWk+DIFpaI2m2w7h32W4b2d7/WzM
    JY9c0wNooycDsJz/fvviZMidyq7fikkjA6XtOky16iN8Ubw7b7AmqxKaiDf5+yyo8fh+
    LqIyW+xa5T4aZnoHBJmOVaDiGKk0aVa/vH8gaQz86uL9fLebycJ6laX5PThMcX2iDs3g
    r7Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713908324;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=fMIc8ZZP0KaBdMmo//JfV9xAkzBPVEo9lwsDsR/39Ws=;
    b=W4jem5C6CatIkWd+l3DvW1/HVKfLkVDRDZWa6PUWex/Z20WuQ/rXOTwnAF45iKsSqt
    FETOm5qe1MvHICJ8WqDw==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkQW4xSV/VuPAs06jowu1ddU/LM/lzJb1ov/T2gg=="
Received: from [IPV6:2003:de:f746:1600:32c9:e069:ee89:9310]
    by smtp.strato.de (RZmta 50.5.0 AUTH)
    with ESMTPSA id 2e087803NLci2Kn
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 23 Apr 2024 23:38:44 +0200 (CEST)
Message-ID: <d862407f-640a-4fa0-833d-c2fa35eff119@infinite-source.de>
Date: Tue, 23 Apr 2024 23:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EBADF returned from close() by FUSE
To: The 8472 <kernel@infinite-source.de>, Miklos Szeredi <miklos@szeredi.hu>,
 Antonio SJ Musumeci <trapexit@spawn.link>
Cc: linux-fsdevel@vger.kernel.org
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
 <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
 <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de>
 <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link>
 <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de>
 <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link>
 <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de>
 <CAJfpegv1K-sF6rq-jXGJX12+K38PwvQNsGTP-H64K5a2tkxiPA@mail.gmail.com>
 <9f991dcc-8921-434c-90f2-30dd0e5ec5bc@spawn.link>
 <CAJfpegsJ47o=KwvW6KQV5byo7OtmUys9jh-xtzhvR6u8RAD=aA@mail.gmail.com>
 <692a9f0b-9c2b-4850-b8bc-48f09fe41762@infinite-source.de>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <692a9f0b-9c2b-4850-b8bc-48f09fe41762@infinite-source.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23-04-2024 15:38, Miklos Szeredi wrote:
> On Tue, 23 Apr 2024 at 15:24, Antonio SJ Musumeci<trapexit@spawn.link>  wrote:
>
>>   From the write(2) manpage (at least on Ubuntu):
>>
>> "Other errors may occur, depending on the object connected to fd."
>>
>> My argument has been that this note is defacto true generally.
> Yes.

In some places we do rely on error codes having exactly the documented meaning
and no other. E.g. fcntl(..., F_GETFD) failing with EBADF is treated as fatal,
other codes are not.
Or openat(..., O_NOFOLLOW | O_DIRECTORY) returning ENOTDIR is trusted to mean
that the file is in fact not a directory and can be unlinked instead of rmdir'd

>> The specifics of this thread stem from close() returning EBADF to the
>> client app while talking to a FUSE server after the open() succeeded
>> and, from the point of view of the client app, returned a valid file
>> descriptor. Sounds like a bug in the FUSE server rather than something
>> FUSE itself needs to worry about.
> Return value from close is ignored in 99% of cases.  It is quite hard
> to imagine this making real difference to an application. The basic
> philosophy of the linux kernel is pragmatism: if it matters in a real
> world use case, then we care, otherwise we don't.   I don't think a
> server returning EBADF matters in real life, but if it is, then we do
> need to take care of it.

Current Rust versions unwind if closedir() is not successful since
directories aren't writable and aren't expected to have writeback
errors. That's what lead to this thread.

If that had returned an EIO that would have been annoying but
would clearly point at unreliable storage. If it returns
EBADF that is more concerning because it could be a double-close or
something similar within the process clobbering FDs.

>> This is not unlike a recent complaint that when link() is not
>> implemented libfuse returns ENOSYS rather than EPERM. As I pointed out
>> in that situation EPERM is not universally defined as meaning "not
>> implemented by filesystem" like used in Linux. Doesn't mean it isn't
>> used (I didn't check) but it isn't defined as such in docs.
> ENOSYS is a good example where fuse does need to filter out errors,
> since applications do interpret ENOSYS  as "kernel doesn't implement
> this syscall" and fuse actually uses ENOSYS for a different purpose.

Yes, we use ENOSYS a lot for feature detection. Bogus ones would result
result in loss of performance and minor functionality.
Due to old docker seccomp filters returning EPERM instead of ENOSYS
on filtered syscalls we sometimes also have to treat EPERM like ENOSYS
on syscalls where EPERM is not documented as one of the valid return codes.

Also, "not universally defined" is not relevant, we consult a platform's
manpages to understand platform-specific behavior, not just the posix ones.

So if linux implements its fuse client in a way that propagates arbitrary
error codes to syscalls for which the linux-specific documentation says that only
a certain set of error codes with specific meanings would be returned then
either the documentation is wrong or those errors should be mangled before
they bubble up to the syscall.


