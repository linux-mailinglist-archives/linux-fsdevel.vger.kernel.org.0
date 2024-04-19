Return-Path: <linux-fsdevel+bounces-17312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEC8AB50D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F711C20D2D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3D13AD02;
	Fri, 19 Apr 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="DQloX9p6";
	dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b="J5xrVNj5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64486137C32
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551244; cv=pass; b=Ejh7pR+9sQKUbT0boozFOH8x98LC+8sphLUBZnBNuwlt/U9sN7rWxCbu1TotNpCeQ0s/4mjhGhVIL9aFwKk5bX7qUF1KAdqo9mPnsCK2l9FsSNwM18kCkPdMqRkGtzO89Rd3xURwFf2FxyLf+kKEsd4ObDgW5q75u8qpsFvFfbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551244; c=relaxed/simple;
	bh=ACz8z3sVNffGIIg7kitOrdOLHJvtIBXqmE2zM9VdQu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/JzHDmwVqJWZq9hWJmy00/o1q65Fkc4fh5xuyWWNIjznK0VqPzFfFxToaxFEXR8imtLKzRTBQ0URhF8AC7V4TneLXTRpl09mNgwWasoGaAjBT4hIukkX8SA1fjW8HbqhEXSJcu79EGigtpZO5oCZlBINebULjGPe4B/YnDilaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de; spf=none smtp.mailfrom=infinite-source.de; dkim=pass (2048-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=DQloX9p6; dkim=permerror (0-bit key) header.d=infinite-source.de header.i=@infinite-source.de header.b=J5xrVNj5; arc=pass smtp.client-ip=85.215.255.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infinite-source.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infinite-source.de
ARC-Seal: i=1; a=rsa-sha256; t=1713550868; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=poAzqxGrXpjM+zVMo/gWq0/lkIowWySh7wOBLLTxR9SG5up3nv3fooOrqkItc39rJy
    Pbv7Idp1rqPTAlnWnVTVSysq+EACSZ/Yfc66QmcQz44LPGTAr5z897R9bXdNy2e4HNBg
    5w+n0pXgi8WWiaKSiAAe7g2Ghqv/qJNKC1JZXFY52ULxfq8/m2MVpK9Ra67nbnLjnatj
    RtGBNzsJBu0rGd9qqlTK8qsJvozURCgFfI+gZnV6S2pb/iD6I+xwhM2dkaigarhWchlw
    mxuV3hRmAM0FwUlWcZl1Qo73o8VuRwXTNiD50GkTwBiT6EtrMGf0de7Pp8r6Svp/UCQO
    OLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713550868;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=ACz8z3sVNffGIIg7kitOrdOLHJvtIBXqmE2zM9VdQu0=;
    b=FmmJabsD7pk9yLc7Ed//q1G3WjZWscrDEqt79pHqZzQx6N0IXRibZNpLBSnCDRxKY3
    s/Z+vs8KE4L4FQZaqY0bvobVF9TtfL3rj0cn3GtaSq1oP0nzitM5dAbUsHuLIIPhruLf
    yudG0KpXVt7mAlLH81+Q5gezQYlBf+p5sIId8qxdt4AGurp0BaqnEdT3972vtqZcPYxJ
    GQYpjm98+pqack4q3uPKOU8ePfXCyKTeazR7fDXNJBXy6QK3OOhDfzHxLUFBS5guybI1
    AmCjJaRe44VmRbY7101UKMWldLYOCZgPN1QTQ7IWGzJcxp8bew4/NzTUR2Uj/tKQEP0u
    C8lQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713550868;
    s=strato-dkim-0002; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=ACz8z3sVNffGIIg7kitOrdOLHJvtIBXqmE2zM9VdQu0=;
    b=DQloX9p6CYrH88XtU0mZ/D25xEssfQrrALWeCQ72WA6dWsIwuCqQs8CTc/po1mSDZ4
    fveA6IYT31Tp8RCp7YT2IpBHhV4bDXJVRK4nMyZBkFIGRm7LhtRIA41R1N/28ES+sYNi
    nezDZ+k6T+DJLDgE99+cwoHimHJbdH6bYhB7cEo6Dc/KXEPk6RMunTtuwsUzOcEK2teZ
    rD8jH1zDOipUm+qplbFbHYkHHC7PlskmpAfkz18+MPMuta8hQ83duFITIEcRpJrlvpp5
    HJ3sDVzcwNsGrWCR8tk3j3KGEGUB3Wqy4YC9netbpt+DfruJUleVYTiuK0xdELVsVev5
    eLzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713550868;
    s=strato-dkim-0003; d=infinite-source.de;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=ACz8z3sVNffGIIg7kitOrdOLHJvtIBXqmE2zM9VdQu0=;
    b=J5xrVNj5AIi6sYwvSPjxmtRU9LCRlYDlXCm3LUq2XQQlV1/UJQTjQqMKXOLlqSg8Q1
    n9YOu/IPRHjUnpnLA3Bg==
X-RZG-AUTH: ":LW0Wek7mfO1Vkr5kPgWDvaJNkQpNEn8ylntakOISso1hE0McXX1lsX682SOpskKNgu1kdYDoVY8GeBx+iRAUrg=="
Received: from [192.168.0.119]
    by smtp.strato.de (RZmta 50.3.2 DYNA|AUTH)
    with ESMTPSA id 26f4d103JIL8yh2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 19 Apr 2024 20:21:08 +0200 (CEST)
Message-ID: <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de>
Date: Fri, 19 Apr 2024 20:18:54 +0200
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
 <0a0a1218-a513-419b-b977-5757a146deb3@infinite-source.de>
 <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link>
Content-Language: en-US
From: The 8472 <kernel@infinite-source.de>
In-Reply-To: <8c7552b1-f371-4a75-98cc-f2c89816becb@spawn.link>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19-04-2024 13:42, Antonio SJ Musumeci wrote:
> On 4/19/24 01:55, The 8472 wrote:
>> On 19-04-2024 05:30, Antonio SJ Musumeci wrote:
>>> I can't see how the kernel could meaningfully know of or limit errors
>>> coming from the FUSE server without compromising the nature of the
>>> technology. So in that sense... yes, it is intentional.
>> File descriptor numbers are not a FUSE-managed resource, so I was hoping
>> it would reserve error codes that are documented to signal incorrect
>> access to that resource and convert external errors to another code (e.g. EIO).
>> This would then signal that the file descriptor itself was valid but the underlying
>> resource encountered an error while performing the operation.
> Anything can be a FUSE managed resource by proxy. [...]

I'm referring to the slots in the file descriptor table of a process (A) that is opening
a file on a FUSE filesystem. Whether a slot (FD number) is occupied or not
is between the kernel and that process, not the server (S).
Imo the kernel should only return EBADF when the process accesses an FD
that is not in its table, which tends to be a fatal error in multithreaded
programs.

If S internally accesses invalid file descriptors that has no
bearing on the state of the FD table of A. From A's perspective
some sort of IO error occurred in the underlying storage system
while releasing the FD, but it did use a valid file descriptor.

> [...] There are a number of
> situations where FUSE itself return errors but the largest surface area
> for errors are from the FUSE server. And the server needs the ability to
> return nearly anything.

I'm not talking about what the server is allowed to return. I'm referring
to which errors from the server get bubbled up verbatim through syscalls on
files that are a FUSE mount.
Is it necessary to pass through arbitrary FUSE errors, especially EBADF,
when a processes closes a file that's backed by fuse?

This shouldn't happen:

|openat(AT_FDCWD, "./fuse-test/foo", O_RDONLY|O_CLOEXEC) = 5 close(5) = -1 EBADF (Bad file descriptor)|

> Errnos are not *really* standard. They vary by
> kernel release, different OSes, different libcs, different filesystems,
> etc. As I pointed out recently to someone the use of EPERM to mean a
> filesystem doesn't support "link" is not defined everywhere. Including
> POSIX IIRC. And given FUSE is a cross platform protocol it shouldn't,
> within reason, be interpreting any errors sent from the server (IMO).

FUSE can send any errnos it wants over its client-server protocol.
But the kernel could still translate them to error codes that don't
have a documented meaning for a specific syscall.


