Return-Path: <linux-fsdevel+bounces-44543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BBA6A402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612E7189E61F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948DB224B01;
	Thu, 20 Mar 2025 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9SH1Se0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9007482;
	Thu, 20 Mar 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467545; cv=none; b=ArKZPjMItVwHDAWEENL8eEawD9JV/TDkdyHxrWTLEf8blzszMPXp6HRWDZGt6vCW/28f35eclfsJFfhZp4/79zZKRWOOH5aqw9+a3mJAVirjN8BJVm95k3ibosL89yMMCK3Q6kOKdRi0Kmk3aIn6DrM2WFNh2d7KslPt3j8KMOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467545; c=relaxed/simple;
	bh=CQRvnqo/OIGXmbGJKfYMBDG6e62wvoNjBK2uoAkIXQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=dfaquALgV5v434SrvjhyGfYwHoSWyGZSEhDm0p00v1fRmM/p0g4H8zcUzK1+1VLyUGbEvMnYvKTLlBN2oVe4mYagfjGbSHRhaN5+FI1pepDUVnQjDD6INrQ6Z/3Ef+MGrs4T7XGpiF6nY1Jux/F/hm1dZGQgzWHtN9WCj0ouByo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9SH1Se0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so125624966b.2;
        Thu, 20 Mar 2025 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742467540; x=1743072340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wu2qFMonGPrgHGmqn+23t9IhepY6HpevAK0T3D5ofOE=;
        b=W9SH1Se0tzc5ytz0y+BgIsppAP80yDOtK1OcuIyGoKHK5McDMvZugteJfrf3QU0ABm
         B0Xa+qE78Hs6MOHFTPz0+Hi7Kj67QNC32qrTozteR1lRTqQ6j1EhA9QriMD7FfF9hVDs
         pkJZTS/ckjYmGsDfdUElfdmJLjf0ODtrLdKrMPbvsZ4Z3zXfa8Vbizv/+bNzQCP7bTPs
         fp6S5fZgZ3S5z63R/FkgqzvXbp4ZbhErqxCSxMKqqqZt4L1o+DgaKoWlwr4Tva6NSfM+
         4Tok9AkoihT2dh8cihN54dQKyp39Xuz1TL4eMFmZaoW9UZL0aPfMZoQ7rXX9+tjOGlT8
         e5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467540; x=1743072340;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu2qFMonGPrgHGmqn+23t9IhepY6HpevAK0T3D5ofOE=;
        b=g6Ld72hN6HIL168bL+EP7cu/dmgh5ZH/HntFTdyomb3BHo/HvuRG9LpIq/gzo63Kwc
         av4FR4KDasFyaM2EPG3J2u1nxZImavo1w8ONsQ4nTG//5iqMOW+Zahu+gKr5Z/h7MVzy
         giAa8kZ5V3zSXCyG+QIjk69GbW5K63rbrlXYxfmYcNmTSaI0FeOQgEGEIE9OEpEUutlB
         FDN3IrE6fukeY/BNKubkJrX/LlP5JpNXQDmXQMUMotevbmR55hNnwcbJYr4MzLyHj8/2
         dWgnpSXehu95ZAEHjXMHr+g/JxMUf9c4vXnP5ZNAYETCC43isTPh51EKMXag3VbIsIX2
         U5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUDIeKkCTLBv2+MEtuIKOFoLTg0l1EItLB8ypvAyG1EJ3NOpTA0+T+0Fzw2SW77bTwG/DehSSCy@vger.kernel.org, AJvYcCV9g5AuerfB8Uxj8/iWJD23ZtI/5TFLmuV/40UAvgIJnKMbdxQ4BlFaxuHcJwFrv8gO1dOV3cXD6j6Iwg==@vger.kernel.org, AJvYcCVCfPJh461ikYSTh8b/2BFUtSKo8YrYMVpWPhaKezjCh4bQp1uyrEfbXRuSNx7YC8R/ROhXczlM+1JDxvk1ClT7@vger.kernel.org, AJvYcCVQjajVVBmoC5Ogh94GmVHsmsU0oQc64/syNya3HQlIzIQeuQcRgxCz+ZeL/P9c6CrO5Z7kO3pW7tfpveVl3w==@vger.kernel.org, AJvYcCXCiYSj/69cXxUdOlDgApOWDWW7DYuh545xtwp90gdpy6Loy5fiIZsSUR5DOW6EPFN6EKftq4Jfjyrjfwoi@vger.kernel.org, AJvYcCXlpFSUJRhTweB9lE1ixOyklwo/zFQEYTLanmz/+Y72sMaU/Ju0SLau/OQFIN0ymjtoX65tDKW/z+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKB5GGXSmwX6Rs46JL6G4yHMJ31cCKHg/FntUZHXrxtzuqM3/s
	BRrMNu95CV6rHBy7MNMtNgkC1A+20fYHsKQKlbo73szCPm2QhcsnXua54w==
X-Gm-Gg: ASbGncsWHYOz87Zfu57dzpe3Lg2WQbRBR1KNraabSF1V+J9/LIwjoZxMqISA8Yl9k3C
	2pRDrNgNYD1ohcxMy5UEzPHFBRXL/xQHIWn41uQFO5OjWVrFcLNoKmVuP4Uwo3zxfPKRhOAC3n7
	SMjTgkxdUQxH2JHqtSUMdmGdKTkxHN270V2J59O2XtSzN8rLmBKO3Vvcl1Hzxv8QNZI6x9mn/Q0
	OiLJ6FzkKs3fzq5FdfFh0DFKVFY6jmie1x6H2T4vitEjmKr6YOBFpE4SMyTiXxgsu2Bi5dcu+PF
	pSlQU+OVspGW+pb7x5GrQ/NLqktAvY9FlbCIlUlQ8Xjl8+KYjfiqB/3wGHItpURJeSoFDtZz9eX
	3sw==
X-Google-Smtp-Source: AGHT+IGBL9AnC6ZQjzhuCI4g1r8h2sdfYy3s1KoFQvorGxx8LXkr1BFrXgmvhJrixYKJRPzgzvC0DA==
X-Received: by 2002:a17:906:d7cb:b0:ac3:c7bd:e436 with SMTP id a640c23a62f3a-ac3c7bde4damr497034866b.51.1742467540085;
        Thu, 20 Mar 2025 03:45:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:5148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aebb0sm1164606466b.10.2025.03.20.03.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:45:39 -0700 (PDT)
Message-ID: <fbcd759e-2453-4570-a2a0-c9ad67ae9277@gmail.com>
Date: Thu, 20 Mar 2025 10:46:35 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Stefan Metzmacher <metze@samba.org>, Jens Axboe <axboe@kernel.dk>,
 Joe Damato <jdamato@fastly.com>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org, shuah@kernel.org,
 sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
 akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <dc3ebb86-f4b2-443a-9b0d-f5470fd773f1@kernel.dk>
 <356ce660-fc2e-4016-a0d9-6896936669c2@samba.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
Cc: David Wei <dw@davidwei.uk>
In-Reply-To: <356ce660-fc2e-4016-a0d9-6896936669c2@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/25 19:15, Stefan Metzmacher wrote:
> Am 19.03.25 um 19:37 schrieb Jens Axboe:
>> On 3/19/25 11:45 AM, Joe Damato wrote:
>>> On Wed, Mar 19, 2025 at 11:20:50AM -0600, Jens Axboe wrote:
...
>> My argument would be the same as for other features - if you can do it
>> simpler this other way, why not consider that? The end result would be
>> the same, you can do fast sendfile() with sane buffer reuse. But the
>> kernel side would be simpler, which is always a kernel main goal for
>> those of us that have to maintain it.
>>
>> Just adding sendfile2() works in the sense that it's an easier drop in
>> replacement for an app, though the error queue side does mean it needs
>> to change anyway - it's not just replacing one syscall with another. And
>> if we want to be lazy, sure that's fine. I just don't think it's the
>> best way to do it when we literally have a mechanism that's designed for
>> this and works with reuse already with normal send zc (and receive side
>> too, in the next kernel).
> 
> A few month (or even years) back, Pavel came up with an idea
> to implement some kind of splice into a fixed buffer, if that
> would be implemented I guess it would help me in Samba too.
> My first usage was on the receive side (from the network).

I did it as a testing ground for infra needed for ublk zerocopy,
but if that's of interest I can resurrect the patches and see
where it goes, especially since the aforementioned infra just got
queued.

> But the other side might also be possible now we have RWF_DONTCACHE.
> Instead of dropping the pages from the page cache, it might
> be possible move them to fixed buffer instead.
> It would mean the pages would be 'stable' when they are
> no longer part of the pagecache.
> But maybe my assumption for that is too naive...

That's an interesting idea

> Anyway that splice into a fixed buffer would great to have,
> as the new IORING_OP_RECV_ZC, requires control over the
> hardware queues of the nic and only allows a single process

Right, it basically borrows a hardware rx queue and that
needs CAP_NET_ADMIN, and the user also has to set up steering
rules.

> to provide buffers for that receive queue (at least that's how
> I understand it). And that's not possible for multiple process
> (maybe not belonging to the same high level application and likely

It's up to the user to decide who returns buffers back (and how to
sychronise that) as the api is just a user mapped ring. Regardless,
it's not a finished project, David and I looked at features we want
to add to make life easier for multithreaded apps that can't throw
that many queues. I see your point though.

> non-root applications). So it would be great have splice into
> fixed buffer as alternative to IORING_OP_SPLICE/IORING_OP_TEE,
> as it would be more flexible to use in combination with
> IORING_OP_SENDMSG_ZC as well as IORING_OP_WRITE[V]_FIXED with RWF_DONTCACHE.
> 
> I guess such a splice into fixed buffer linked to IORING_OP_SENDMSG_ZC
> would be the way to simulate the sendfile2() in userspace?

Right, and that approach allows to handle intermediate errors,
which is why it doesn't need to put restrictions on the input
file.

-- 
Pavel Begunkov


