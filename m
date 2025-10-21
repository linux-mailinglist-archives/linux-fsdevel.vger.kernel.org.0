Return-Path: <linux-fsdevel+bounces-65008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49468BF905A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 00:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593DD56326F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080FE29A326;
	Tue, 21 Oct 2025 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="A3M1GiZA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187428000F
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761084800; cv=none; b=jwKvyJf9w+8umSxkzqQ4EYquVAfcPuOvsgsdOW1Ags5eP6Eo7/AJVqp91Q8TtXMZd6XQBID4aVqNe64lobIfjubMOP1OlaviOxb86jvwuS8FTrGZURG3IqkYVCaBvmDgswObhvKlLfzSmSfV+kG5J3BmZdFg/PSAfYEC64H+t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761084800; c=relaxed/simple;
	bh=AP7ARTOiIi5YE3ZDHSa+aBoKiMC9aHbtqHXp1+PRGU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZK9Oot1YbywgIobs77ydDTdir93A36TkgcAt9dvurclvDgHwNyKaaPQBntUmgxjNO832OVNZv8e6vltciiGlcuDcTu4O+74Y8zZ9fxBvEQjPCWw3Izy7RfrOXVIwFPoquyLKfTEplfnMg0Idp96xSFT7ni+NLOZ9ZRqQ7s9o7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=A3M1GiZA; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-940d327df21so187527639f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761084797; x=1761689597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ONz7pOY3jOdic6OCLVMtjRJ42T1jXYwo+p4gKBlKtJ4=;
        b=A3M1GiZASbGtrNPG4gcW+6toKEJJzY9cAX9EXSRxLpWQ3Cv7RBa4Q6t2KQ5/DryRDh
         Z9snBZXInZYi3mzMy049hzkayhNYRtCMy5jQKOD6RxaHZNTHF2zvm7LAOjLOSwMaeoNs
         4D2aarRlRh3kOqSNphKacg4o96c3Nh6bO5GkSf+7Ns5necm1DiDdUb8SOIlCmqx/s/fM
         604QuKFlo00Bc/rd1P6K5pgj5u7pdCBca0GCSdlOmKEQuv3dUVOTl9y6++yLigO8z/od
         JnKZvRft2WVSxhCO19LRoP5xSow5c27TB0FWEo2hwn1Ln7aauxgS/N2d1a3ozqBlolSd
         e2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761084797; x=1761689597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONz7pOY3jOdic6OCLVMtjRJ42T1jXYwo+p4gKBlKtJ4=;
        b=DnNwcI5gJp959vyGuDRr3OIC0F9cQoJtLCLRpYsVBat8V0NiqCEkPwLfwHslNtG+QW
         1dreIycl9gNyVJxBnwCRe2+ygYidkVY2uCZQsBzCPLUpyZfqqkUN7KhKZy+DgH+tXbpr
         0mxKpBHzFJCjDZdKf7ZOSRWYWoqii/Wn7MuiI980pw4tgM3LcUnVbwjuQQ73XL/mqafD
         JasvuJxA14QBDH8FRXIDgTMtlk4xD52d+O98F050BKDm8AuAwWlqSdvQom20hQ2t87gu
         ItU5qAq/QMdLEejzJC6KQgXfBHT6izI0ZZ77Psv76Nw4YPEihHTyj5woRsQ4G2bTYlN1
         K35g==
X-Gm-Message-State: AOJu0Yzd+rvsfGytv8PsKU9gp2X9Ulr/3ZLJmukaKw+HgQoGuToLrR1w
	6QHcZSybzGxlQ1QDWI0ex7chhqdNwUNjMHt6RsoanlKF3xIVY7A8S20GE0L33LOpxqs=
X-Gm-Gg: ASbGncuKcDep2tHX16ThehTYEAFrKDWa1tQmYWvC1lUXbi3ShquhM0xbx5aj0zRiplw
	ZvvtoeyCnXJq9qt6DXxykxw4f6z8NMq5g+jzjqABC64bbz/rtTb65yvasZl3xU2Drr6nQySdGnc
	k1DFleKEgxaFJpLMxr3kx7UJLbp7lFiBIBhF9AglFGGRXEqLKAdgB96fxI4z6pBzVOrGnFxFiR1
	zX5vM6vT7nF9PhKmLI4aZFSb1L3Nl/Ts1EnPkh3uwTp/oev7yy9RO2tyuLatcmCTEJsW6+U5+ox
	GIl+CSnUVCz4ixhMBOwmz2aOAUs6bCyEcr+S0OWG7DmGyltJS4jNdK7D4+AOmuYm40X9xv/uJC/
	lVldjcjF+8Ngk/H/uiM4uXI1Pt0txdmNnCyFfgN1ftjksdsJrtWYXcwbQEHQvIuxZgYUmrxrgQm
	mBz2yImiCq
X-Google-Smtp-Source: AGHT+IEfFwVGGAL/yOas7wnHXxlJFjUf/Wr7oZhJh5Elg9O/N2OEhLd0Eo0kDXBGDlNqzekk2owDaQ==
X-Received: by 2002:a05:6602:6d8e:b0:92e:298e:eedb with SMTP id ca18e2360f4ac-940ddd85445mr1138226739f.10.1761084797531;
        Tue, 21 Oct 2025 15:13:17 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866ca57bsm449885439f.14.2025.10.21.15.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:13:16 -0700 (PDT)
Message-ID: <e1b86212-7d57-4224-921c-43fd5a073ca0@kernel.dk>
Date: Tue, 21 Oct 2025 16:13:14 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fuse: check if system-wide io_uring is enabled
To: Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>,
 Joanne Koong <joannelkoong@gmail.com>, Luis Henriques <luis@igalia.com>
References: <20251021-io-uring-fix-check-systemwide-io-uring-enable-v1-1-01d4b4a8ef4f@ddn.com>
 <fa59bbce-cde5-4780-a18c-1883c3f9ebf9@kernel.dk>
 <2460d0d7-486f-4520-b691-eb189912fade@ddn.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2460d0d7-486f-4520-b691-eb189912fade@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> On 10/21/25 23:56, Jens Axboe wrote:
>> On 10/21/25 2:31 PM, Bernd Schubert wrote:
>>> Add check_system_io_uring() to determine if systee-wide io_uring is
>>> available for a FUSE mount. This is useful because FUSE io_uring
>>> can only be enabled if the system allows it. Main issue with
>>> fuse-io-uring is that the mount point hangs until queues are
>>> initialized. If system wide io-uring is disabled queues cannot
>>> be initialized and the mount will hang till forcefully umounted.
>>> Libfuse solves that by setting up the ring before replying
>>> to FUSE_INIT, but we also have to consider other implementations
>>> and might get easily missed in development.
>>>
>>> When mount specifies user_id and group_id (e.g., via unprivileged
>>> fusermount with s-bit) not equal 0, the permission check must use
>>> the daemon's credentials, not the mount task's (root) credentials.
>>> Otherwise io_uring_allowed() incorrectly allows io_uring due to
>>> root's CAP_SYS_ADMIN capability.
>>
>> Rather than need various heuristics, it'd be a lot better if asking for
>> fuse-io_uring would just not "hang" at mount time and be able to recover
>> better?
> 
> We can consider this as well. Issue is that fuse has a limit on
> background requests that is protected with a lock. And there is lock order
> to handle. Initially I didn't have this hanging mount, until I handled
> this background request limit in fuse-io-uring with the lock order. 
> I.e. when one switches from /dev/fuse read/write to io-uring lock order
> changes.
> A way to avoid that issue is to split the background request limit equally
> between queues. Although I wouldn't like to do that before fallback
> to other queues is possible - which brings its own discussion points
> 
> https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-0-742ff1a8fc58@ddn.com

In any case, I do think it's just wrong to both need to add heuristics,
and then still not be able to catch all of the cases where limitations
prevent you from initializing without hanging. That does seem like the
crux of the issue to me, and this more of a work-around than anything
else.

>> There are also other considerations that may mean that part of init will
>> fail, doesn't seem like the best idea to me to attempt to catch all of
>> this rather than just be able to gracefully handle errors at
>> initialization time.
> 
> It is still doesn't seem to be right to me that fuse advertizes io-uring
> in FUSE_INIT to the daemon, when system wide io-uring is disabled.

On the surface, I agree. But I don't think you can catch all the cases
anyway, or if you could, it'd be fragile and may change. And then it's
just a bit of false pretense. I'd just view it as a "the kernel supports
the feature", which is true.

-- 
Jens Axboe

