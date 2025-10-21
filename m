Return-Path: <linux-fsdevel+bounces-65005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C44BF8FCC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 23:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5266E3BE48C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60723EA9B;
	Tue, 21 Oct 2025 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YDFDSA63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD9296159
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083796; cv=none; b=BPftvwfO3cRGRbGyUL9I1apfgFNEx/dx6uu6fuf39M9YrzH72pfJASvnofWH0r16uC65xYwi7ana5AKAhf6AJNUhMRmT0dHA86xKnPBPYdIlBgntP0zXj6SVQLysGMpRmHmwDiUgEDnOdipJ438c46pvS70rnrfEF0fiZZOgops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083796; c=relaxed/simple;
	bh=MeNPP0WuIPcWIHdRSJ3vKJ7ugvK066t7SqZqxAZ0rSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES9T+7IojStxMl0MAx3hvz+U7cgQ0Ym+DLQaGv7pTgJgqcxpLipqq3WM9IYV1Zcui2+Q075g4ae77USol6GhZeBivTxKBJ8RGnNjdur96RUzYqOuqeT6W9OCDL5BLWxR5CKOyOT8PAqW3CtjBY9k1MvDYBUtEOV5z7/LcOyiWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YDFDSA63; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-92c781fd73aso611035239f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761083791; x=1761688591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ucx9J08VCBpffk3av9PP/PElDMAilTHxpOCdPfI4F4=;
        b=YDFDSA63xazT0ChnxAh0ZhNK5JOhtJSJTfUBnGOU9pl3T74yTrUd+R4VkZhuQL01Mi
         LQ/mTjVF83H1LyJdBQrcbXvHyC0oJzMhjyecYioQU7Ec1u5qz1vX2fDzua8yoWxfDC5c
         gtZcxo0Ua8WaeZ/KMlYfsA+q/mrNnblqhcEqP5Q28het/a141HaOq2WicF1IkUM7k70r
         AKaAmBBuChHZorLjEqjGE0vmbubepZvUBmHmKu8Vw/f0Ic81jT323s2lKc007D00pSTU
         gV+l9rLJgVNN67Ys92qUqvRa/BQ0OsOXiyC2c5ljpSkOwpHgKha2LtcmUeVbglpWycV0
         J/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083791; x=1761688591;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ucx9J08VCBpffk3av9PP/PElDMAilTHxpOCdPfI4F4=;
        b=q294RXFyy7nh1ihhhMFdRoKM4AcXGy9sMsbM6eOEmoSVoLYiB1UdsENSHTWWLRnx2O
         ISQvtiD7F2kUtPsXMtH8ThzX/SK59+vU9H55cI8BwW5W5UBkJmMRZO9SrsqnJkM6OPTM
         cS/IjkTjgy8ekXXNbuCsb5tLcEQAb+M1ytg1xkXsEAGUL993jaalL2ek8Uy5h31+bV9f
         5mF4zd3g95MNmE+aHAcubPYvzowtO6bEiiKfObXof5nqbcMSCyTV16vf1br5OT0EUoeQ
         uoVDUUuzqGUM2rEcKz3dwIT7yEOupt3nLZs6lZM47hKzkL0IsZnKsWiLhZWiKxhKiYyx
         7cDA==
X-Gm-Message-State: AOJu0YyBRvtg+O8yxe73Fk6FBik8Qg61tjsXozX7AyXZERAQQUzmRhig
	c/s25gkv4NgI7URXgUb0iV5i2rFNZ62P1RkZFXX0zJ4mqzo7sf9vRPlafqaVJTZn7nM=
X-Gm-Gg: ASbGncuw0OzgphRVRmXEz4e5Wh8QO55m8iXJLl3iEnZ7/S+N4a3r0YgGaF+/cI8TkkO
	CEzc/La1jnKrOQvYWzE6TmWSXK+Y+li42cat6UKumsiOMjiJUfw8NTDk1N8nD6T4lY/1jLqdFmc
	IMLWJK7ZDzSw7QL9F1o2+cHEmQOIHk/KyzNzkQKgyhjCfgGCUqySbLpFdO+49akT1Grl4Sl0vFM
	Zao11Hs8upgZPThIX4Go/33H/EDIh7wC8ejNevcWCqP3ggfB/rRVFW4+v6g1y5Dawi5x7KOHwmD
	q4/KNOHyYv6exg/2MHcBJT8WDKPLPwPgkENAli0t43fHow56qJpDFxMAq5CQZLEEsA+q63j+amW
	zRjh2z6SsRC/1jGLX+nAicreqr7zinujNu8zLgwc7j1XbcqVq2qREPA4h5gT6Il+QcMvxsvWzzw
	==
X-Google-Smtp-Source: AGHT+IF7Z42mi/bOtyAxwHz77szmdJTA1eHtHsGlT/asVO/pdEonRwjqwjdSsVPp/CJd9oeiIJpLSg==
X-Received: by 2002:a05:6602:2dcc:b0:93e:8359:73e3 with SMTP id ca18e2360f4ac-93e83598057mr2421940039f.9.1761083791624;
        Tue, 21 Oct 2025 14:56:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9792679sm4306940173.61.2025.10.21.14.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 14:56:30 -0700 (PDT)
Message-ID: <fa59bbce-cde5-4780-a18c-1883c3f9ebf9@kernel.dk>
Date: Tue, 21 Oct 2025 15:56:29 -0600
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251021-io-uring-fix-check-systemwide-io-uring-enable-v1-1-01d4b4a8ef4f@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/25 2:31 PM, Bernd Schubert wrote:
> Add check_system_io_uring() to determine if system-wide io_uring is
> available for a FUSE mount. This is useful because FUSE io_uring
> can only be enabled if the system allows it. Main issue with
> fuse-io-uring is that the mount point hangs until queues are
> initialized. If system wide io-uring is disabled queues cannot
> be initialized and the mount will hang till forcefully umounted.
> Libfuse solves that by setting up the ring before replying
> to FUSE_INIT, but we also have to consider other implementations
> and might get easily missed in development.
> 
> When mount specifies user_id and group_id (e.g., via unprivileged
> fusermount with s-bit) not equal 0, the permission check must use
> the daemon's credentials, not the mount task's (root) credentials.
> Otherwise io_uring_allowed() incorrectly allows io_uring due to
> root's CAP_SYS_ADMIN capability.

Rather than need various heuristics, it'd be a lot better if asking for
fuse-io_uring would just not "hang" at mount time and be able to recover
better?

There are also other considerations that may mean that part of init will
fail, doesn't seem like the best idea to me to attempt to catch all of
this rather than just be able to gracefully handle errors at
initialization time.

-- 
Jens Axboe

