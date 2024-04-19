Return-Path: <linux-fsdevel+bounces-17280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84798AA8D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 09:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161451C209E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 07:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814EA3D961;
	Fri, 19 Apr 2024 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="JI+Qmtds";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="gcEOWisU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD033B298
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510123; cv=pass; b=IoXd5B3VuJM7+INIKWTxDEtJP0HpYf8hDSF3a2JE0+3igpiasvFLxxQ77l1WmnLg6/3ugyhzc6rojI9ILWnF89V4gOAoe34uk/EHy4S5V76BxM+1w22qn0ajVe6nCzKZCQLlf16kpRT9kAlKgY0qvxWGaBYVEIxTjnutknYTGps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510123; c=relaxed/simple;
	bh=o17oYHwx/obd9bk6csiFAsqDPpAW3IkTzE3U18i4GHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kb+9NgKHoO80Axh0ZQDHqAfoHvwg0mownWExMSoB35Nf5iEfanPKMMhAisfNIwP/53DBgTgLfPOFlLpMvEexuRcKTIx/2wC1N/zol4L0w4xeIG1dxdGbkpHGdOBYQD+eEApuqz1w1lky4mUKE5luYo3SFVKf0j0du/9h9Tezi2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=JI+Qmtds; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=gcEOWisU; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713509751; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PmcggyX4+VPh39KftaaGQWDSQK1q0lQGkbcF2bMsAh+MLksWVe2a+Q+Wl9aM0IWfET
    e0kpWDFOYcCkWjchcsqrHtgHqoLIUFD/vWOncwcpTRjCzloxl6bGFzFP/id5w8k5EMcE
    xfUfr3ANObI3kXvVvxny2lZxg3bkUKczyobiLWqOp0bZckJGn72CMKbrxZRXbJ9fzvRc
    ALZ3bvtDhJdmuOBMTv16HWjw/MvNA2QgPU5oC90jaWSwm34Ln7QOdLDL+GyhnE7zJkz4
    YjsZa2lGZKP+Perf2CEnZc454zqOOL13q79GG+6VTsg9X3023BEBPZZ4jHVsEC+Y9Z6V
    MAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713509751;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=o17oYHwx/obd9bk6csiFAsqDPpAW3IkTzE3U18i4GHk=;
    b=Sd6RTFNMI3Kut/BfvmRhompojJcvxE7OozwHQ4byklrt9q0SnQsdedDWonhPIF3jmi
    f7CAxY5D2gDoybeP5l9DuO8Eq/YMVaOdFYbkRANMVUePPx3jU6dRgySQbKpFbaJVrH3T
    xzOnnQThSq7zV6fuA5W06yhH5vtR55ELpc319Cj6GB1sD35Tm49n9KQVl+QAZkEe7IjW
    AIZwxWzMBksJy3htESGvqBgNlBJ3kY0V25x6GyE/r2WdFLRyfZoxpW0P4ftAHSty0nae
    zOw+4U/+nMrV4M7a8t/FxPwd/jyofKevODQNZmNq5dDxATJxxFa8/TxcjI8KBmOp1r/5
    n5qQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713509751;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=o17oYHwx/obd9bk6csiFAsqDPpAW3IkTzE3U18i4GHk=;
    b=JI+Qmtdsrla7/AVKxgyLANgjNSn6WA72MiZpeXOkb1BL3bBaU4s6Yq9cZOSiC3WikG
    hlrxzMjq5E8erRTuicDFeGHxHInNKrjK/TAFwSib/foJSYgjy9CLmlXwoX6hXLmAo2TI
    yeNRMZ7TaRjmklnotdGG41RmwuFrlQud/E4lJspSuQY1pNkwwmeC5mzbn0mvgxZ/30nZ
    ZryJlhDruyJRq4oSy32DY8iNupi0U8bUlKCrZFcRA9oBwiu1SZ3SF245Fwk4pANBFTBV
    vtHStPl69E2knWmssmLz/giCUJV5MmK9hTqL3svbknECgXBQNl/7P1RqaturktZbHXrP
    eY5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713509751;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=o17oYHwx/obd9bk6csiFAsqDPpAW3IkTzE3U18i4GHk=;
    b=gcEOWisUKrc4rkYJXORT0Dms5i7+eKpZ6WCVmcdTVuOj+mrcyAm7j7j2u3fuXCqwNh
    GU2txNVbK17shuNvbUCg==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1vdp7pXN2ayNAkQW4xSV/VuPB8g/jrf+fgOZAiP5qKuiDjps0="
Received: from [IPV6:2003:de:f746:1600:cb3:28a:2d4e:f26f]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id 26f4d103J6tpw0Z
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 19 Apr 2024 08:55:51 +0200 (CEST)
Message-ID: <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de>
Date: Fri, 19 Apr 2024 08:55:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EBADF returned from close() by FUSE
To: Antonio SJ Musumeci <trapexit@spawn.link>,
 The 8472 <kernel@infinite-source.de>, linux-fsdevel@vger.kernel.org
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <fcc874be-38d4-4af8-87c8-56d52bcec0a9@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19-04-2024 05:30, Antonio SJ Musumeci wrote:
> On 4/18/24 17:10, The 8472 wrote:
>> Hello, first time mailing the kernel mailing lists here, I hope got the right one.
>>
>> I'm investigating a bug report against the Rust standard library about error handling
>> when closing file descriptors[0].
>> Testing shows that a FUSE flush request can be answered with a EBADF error
>> and this is surfaced to the close() call.
>>
>> I am asking if it is intended behavior that filesystems can pass arbitrary error codes.
>>
>> Specifically a EBADF returned from close() and other syscalls that only use that code
>> to indicate that it's not an open FD number is concerning since attempting to use
>> an incorrect FD number would normally indicate a double-drop or some other part
>> of the program trampling over file descriptors it is not supposed to touch.
>>
>> But if FUSE or other filesystems can pass arbitrary error codes into syscall results
>> then it becomes impossible to distinguish fatally broken invariants (file descriptor ownership
>> within a program) from merely questionable fileystem behavior.
>> Since file descriptors are densely allocated (no equivalent to ASLR or guard pages)
>> there are very little guard rails against accidental ownership violations.
>>
>>
>> - The 8472
>>
>> [0] https://github.com/rust-lang/rust/issues/124105
> I can't see how the kernel could meaningfully know of or limit errors
> coming from the FUSE server without compromising the nature of the
> technology. So in that sense... yes, it is intentional.

File descriptor numbers are not a FUSE-managed resource, so I was hoping
it would reserve error codes that are documented to signal incorrect
access to that resource and convert external errors to another code (e.g. EIO).
This would then signal that the file descriptor itself was valid but the underlying
resource encountered an error while performing the operation.


