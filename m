Return-Path: <linux-fsdevel+bounces-31246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD2993629
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C96282DA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3551DDC35;
	Mon,  7 Oct 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1BrJF12T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9254132111
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325626; cv=none; b=Jrtz9Kt4UOdCBFbfe25p7phmRt+kAxOhWQ+chaSHttGfAKgQXDdq3R6kqBqXPgif1MmIjY1Rz41JL63TLodELtXHXelmYaiUpgqer7HbiJTnpzypMOSTKIbpIRg2SOqRmsYz0ZTsJhBwL8mWcy18XLDp7WIZ6oTDA+oT2VFmrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325626; c=relaxed/simple;
	bh=uPnOz8oYDJjrvBUaD25yi+xjE2XYM35iRidKrrPUnI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDOAZWOZjc/cNCASOTECsi6g3+1xA3TRUgEhGi/3QJrWJBY9O7uF6Nb3hSRpCWBkTSV/n13MaZqW57O0rP0pFpPNmMWJ5WhFkC893r5Ihc/GDOSNa+Ix4/WZbySEEsyMIr5XJvxtmwsdGdsu6uLskgzduHKvqkBNG1GaNzgVOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1BrJF12T; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a33a6c3102so13777605ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728325623; x=1728930423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxrnObm0BNDzoFIuAPxsLMa6K6BQSMTEdRxzlKh9FjQ=;
        b=1BrJF12TkcpX6c13/jn73x+3+9cwHf7C/xmv5cZWGjt+CY4qw9TraMZviLJZwzg8uT
         BiWoyaxcIpUSMuMQ+7Ee8r8rScEllf01eGCuuwlaO2oqWnsFmI4KjiILpPpk8SYVYRQn
         WRMXpRC6WIYcubv/k8Zo6Ptvt/T0fLrEFpukxCs/1Kme5ir47KkQKaJSDvVNlNPWwxqN
         fyuS0lSNXCThgj1wDsnwb1FINNgkwLKWiZqkuFViIIgdnwf5k50kNFm3ifKy4VYangSv
         YX/lfxkT450vfWWNbHEmn0+pf1b67Z8YXhZe7P+DBWQCxSB/1pTqWE2dbtxY/+9yAZif
         SZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325623; x=1728930423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxrnObm0BNDzoFIuAPxsLMa6K6BQSMTEdRxzlKh9FjQ=;
        b=quuN34YRVeNNTSvYo5BeUXvbzc0V/JRYjX6HkAXY3gupHE6+OYOr2lUXWOd1fwgKT1
         Ccl3zbSzgt/4BMJW9lJNlUgbjtmIGJzwLwDCiWhQgT6ZXSu3/NUgJ6TF6BLn+mMGgNxR
         R25JAYuSQR7yHmuSPO2D9pgtZs+ooYwnJVHJFL5wxAqXTcG+HMq88UZOwVVbkGRKJXnJ
         yq5xPdmM81o+eIf6kBArDZIQd1Mxykap7U2X4krYnZe8g7DcKZzNM9AbAdhL/5m0Uo+R
         AQu8y4bg5HjMHts19xo9sQMQGfFNicD75v6bKev4h3aOl79SO+i5E9GDp+K6dwV7bydF
         pdrA==
X-Gm-Message-State: AOJu0YwYZ0Balll5tcK1VjuViQgGhb12a74J4R6cpL+wb7/LMiKe+9Na
	Rutyo1j5Br9OsVljr84KxyAJ82hnZBo3DLtOEaREIYlA4BkhMsg4laQ9ytzJCSs=
X-Google-Smtp-Source: AGHT+IFMnnsd1Zrr0GTeY88yH4igfTcqd+VLGHUrMWdnSVvTWYH7gT5DJWlR/5RrMQ4ZzdYwe5UR9Q==
X-Received: by 2002:a05:6e02:138b:b0:3a0:9c04:8047 with SMTP id e9e14a558f8ab-3a38af22d53mr5028195ab.6.1728325622963;
        Mon, 07 Oct 2024 11:27:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a868b95sm14404745ab.69.2024.10.07.11.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:27:02 -0700 (PDT)
Message-ID: <ccfe92d7-0874-4e0d-bb79-c1df7eb0b302@kernel.dk>
Date: Mon, 7 Oct 2024 12:27:01 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fs: introduce file_ref_t
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 8:23 AM, Christian Brauner wrote:
> As atomic_inc_not_zero() is implemented with a try_cmpxchg() loop it has
> O(N^2) behaviour under contention with N concurrent operations and it is
> in a hot path in __fget_files_rcu().
> 
> The rcuref infrastructures remedies this problem by using an
> unconditional increment relying on safe- and dead zones to make this
> work and requiring rcu protection for the data structure in question.
> This not just scales better it also introduces overflow protection.
> 
> However, in contrast to generic rcuref, files require a memory barrier
> and thus cannot rely on *_relaxed() atomic operations and also require
> to be built on atomic_long_t as having massive amounts of reference
> isn't unheard of even if it is just an attack.
> 
> As suggested by Linus, add a file specific variant instead of making
> this a generic library.
> 
> I've been testing this with will-it-scale using a multi-threaded fstat()
> on the same file descriptor on a machine that Jens gave me access (thank
> you very much!):
> 
> processor       : 511
> vendor_id       : AuthenticAMD
> cpu family      : 25
> model           : 160
> model name      : AMD EPYC 9754 128-Core Processor
> 
> and I consistently get a 3-5% improvement on workloads with 256+ and
> more threads comparing v6.12-rc1 as base with and without these patches
> applied.

FWIW, I ran this on another box, which is a 2-socket with these CPUs:

AMD EPYC 7763 64-Core Processor

hence 128 cores, 256 threads. I ran my usual max iops test case, which
is 24 threads, each driving a fast drive. If I run without io_uring
direct descriptors, then fget/fput is hit decently hard. In that case, I
see a net reduction of about 1.2% CPU time for the fget/fput parts. So
not as huge a win as mentioned above, but it's also using way fewer
threads and different file descriptors. I'd say that's a pretty
noticeable win!

-- 
Jens Axboe

