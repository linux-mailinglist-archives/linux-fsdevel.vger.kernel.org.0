Return-Path: <linux-fsdevel+bounces-13664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991778729DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7ED28D238
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB06012CDBC;
	Tue,  5 Mar 2024 21:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XgGmz+yD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098C12B177
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675741; cv=none; b=bpAIlfOtJxC91lpw5STNk6kbS3UpOkR9M6uNRdn8FOH48neVaDSL9ds+RqM7huJaOu+g1XyN0w7k2FnHTiKlEKaK0ILRKoT9fMRv2T+ddnYeiDOB9r3d7SLu+PQzgHHuv7YcEBgkuibwOhph2lpVGuDvOAMWQP6OQc6HAXKn6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675741; c=relaxed/simple;
	bh=HvTsGXLIwEz4WybzEWfgvxshqRvP2qTfB4R+8famH+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYLMS2vQBJws6kgWecPh/hc5DTqVG+HmvQnMkdW4pB75IRpVHU5C/Ztj2v6kIYEOQyFsF6c2vnVDGd/LoXex6RpZgMM9gZ9/y6VX0Mz5+HJWzl2YHmkHig1xiCqdQjPyYtF2rlSH2d0FIkiAoJmGkc1NFXcsAIc/NJ+FO+aYC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XgGmz+yD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1db9cb6dcb5so18653605ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709675738; x=1710280538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5hAuOk9zgGm5wIFfI92u0pmPCRFeBG7RcQwtBDNtBU=;
        b=XgGmz+yDD+fJZWqeoqV2u+5Waq/mPSKmRArT90JwryIEOvQvn9ajrYRm6KGnN26GBI
         MITXDmR991C6iJC1Qsy0mikguOYMxGMGXVb8wMovM9mR52GSS7zlkmx6kiYLy4SoNIJa
         qVP/VbINcCGSGaiTDJF4HsMppnnDpGQpKvSnxshkHkb7xttazhWIJD07Y5rCmRTbixjF
         c+/wSr3vDusgQzvl8IPfdZcnuEhdtu92Fa+JRWdKbsD061BeZSNPZzljfITEyaMRFS2n
         KKYT41v90292E6xDAW5zvPjN36HDIfo5uvoP62U9GE3hszcN/v98UBq04usrLmLsfk0c
         VGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709675738; x=1710280538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5hAuOk9zgGm5wIFfI92u0pmPCRFeBG7RcQwtBDNtBU=;
        b=mNDses4bTw2DFCSkTP32/xT6I9ry3YMFB53nXatipHSqiXGWItZ4CfK7aIFLim+OCB
         iOxe33QR3pFAE+iyKFg0ASyJjhJ7MxHApgo0qhP5vvNAHHj1LOD+KW8jr3gZbtBm7UH7
         gAmu6b1r74to9Q3KY/+KdH2An1JSbVs1CI7VuWA1jGp8CoxQOcndbS0MeQMIf7XVpJH5
         6WsTqUX4rLWtYkTdga4toSub11SmJqfBYaohjZwc9A/Sm5qUky+nrCnX0FF7ksNd5EIr
         YXrrjAIaQtserOiwyQYHFiBJPIH32e/4IYJasL3jaxmYIUTWALDaP5NIg/ph/BNr8Ngc
         fI0w==
X-Forwarded-Encrypted: i=1; AJvYcCUOoe7rYDjdV53dorARYodgHyXRI3FO+rY5TTOENkINNz7oKwskeyqsbleNeLFCrTrxWdZysY+jEarNgsRUH1Gv0ifD3hxfkVWBpCOrAg==
X-Gm-Message-State: AOJu0YyNuWCb/J2TvvrxCjZeLk40X4WaLIzvix4Y1bQaHoYF2+B0NN6y
	YdFkmHWWmy0dzph6l1w7KQ1p3l4+s/o8zPeHiVayWPlJ3LL580/wklFTDAgiW/c=
X-Google-Smtp-Source: AGHT+IFp9kaHg7brG++xPHTmEs9ulUnnOabRScwYUO14f3saTvYrpZu4D7+wcsuYTZSd53DsjyrfUQ==
X-Received: by 2002:a17:90a:d78d:b0:29b:4dab:efaf with SMTP id z13-20020a17090ad78d00b0029b4dabefafmr1801084pju.4.1709675738424;
        Tue, 05 Mar 2024 13:55:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a858200b002997a5eea5bsm9972188pjn.31.2024.03.05.13.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:55:37 -0800 (PST)
Message-ID: <e2c57d81-5ba8-452e-adb2-560cac366746@kernel.dk>
Date: Tue, 5 Mar 2024 14:55:36 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fs/aio: Restrict kiocb_set_cancel_fn() to I/O
 submitted via libaio
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <90c96981-cd7a-4a4c-aade-7a5cfc3fd617@acm.org>
 <b36536cd-c62b-4b86-aef7-fddd3eb282a1@kernel.dk>
 <94dd9db1-6025-4cd0-93b7-40d55a60efc4@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <94dd9db1-6025-4cd0-93b7-40d55a60efc4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 1:43 PM, Bart Van Assche wrote:
> On 3/4/24 12:21, Jens Axboe wrote:
>> On 3/4/24 12:43 PM, Bart Van Assche wrote:
>>> As far as I know no Linux user space interface for submitting I/O
>>> supports cancellation of read or write requests other than the AIO
>>> io_cancel() system call.
>>
>> Not true, see previous reply (on both points in this email). The kernel
>> in general does not support cancelation of regular file/storage IO that
>> has submitted. That includes aio. There are many reasons for this.
>>
>> For anything but that, you can most certainly cancel inflight IO with
>> io_uring, be it to a socket, pipe, whatever.
>>
>> The problem here isn't that only aio supports cancelations, it's that
>> the code to do so is a bad hack.
> 
> What I meant is that the AIO code is the only code I know of that
> supports cancelling I/O from user space after the I/O has been submitted
> to the driver that will process the I/O request (e.g. a USB driver). Is

Right, we never offered that in general in the kernel. Like I said, it's
just a hack what is there for that.

> my understanding correct that io_uring cancellation involves setting the
> IO_WQ_WORK_CANCEL flag and also that that flag is ignored by
> io_wq_submit_work() after io_assign_file() has been called?

No, that's only for requests that go via io-wq, which is generally not
the fast path and most workloads will never see that.

For anything else, cancelation can very much happen at any time.

> The AIO code
> supports cancelling I/O after call_read_iter() or call_write_iter() has
> been called.

...for the above hacky case, and that's it, not as a generic thing.

-- 
Jens Axboe


