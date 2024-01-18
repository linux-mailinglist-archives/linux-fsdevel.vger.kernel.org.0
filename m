Return-Path: <linux-fsdevel+bounces-8264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176C831D21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C281F234FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD628DDA;
	Thu, 18 Jan 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pA0p/dlO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DE241E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593736; cv=none; b=T2cZs38O74+TvOZv2NKntyd4SpBnbWXUyazgRvu/ObE4hmUt1OVpY1uHr4l+HCvbg/H4TuTcx1gP4LDExFAzO3kNtvr998OIM8URrP7VCdJH4t9H8pIZIl0XGUCTy5VCWu8mECHiPrX7uJS2z4eGqs8Y5BZKVMAb8Ze1/Vr0F0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593736; c=relaxed/simple;
	bh=7/CWAjx5zfqKJ2XKGA+zCddsRmnknHYAn2kIAh+LnQ8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=hg0q2Q0GmtWt+5kF6QkFpfgxvaqV5yu2VVBWFSzOaLflZeimtU7dnO7fDBdnHV7U0zNRDPUKWdRiNHMTpQB90ueBGGtU/IGKGWciHW/jJQG414SCdl+N668MK1ul2spNth25xvqgf9BpjT8vpQ8KlOG2fW88y04rQrLsksqqXGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pA0p/dlO; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso10366339f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 08:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705593733; x=1706198533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hto2SU4R3yAYwp81hj4Efa1CV18LRXcWhBAicey50VM=;
        b=pA0p/dlOaP2FLSI44v0AjlgWAVOgEyKcTWu8IOUO2YH36DKCcbcsz6UKV7Jz56eAJQ
         lWB4G+eIglQweQQs9NCTkpgRtdD8ZWuSxRmjKxtsCZ7Z86oiv4GNkwhTarMlcOfb3ClU
         5djgNM3TKg+5fx7Sbxw5+SEF+tS1FaOipUaUhYQdL19XON7Sm6iNDBzXr1TF3S1Fls/z
         ijvpDFaeozNURh2Z3nw8cIczsu/kFMYHAYg14q/f/TI2Utx345vvNuTqcdLOlFurjmEF
         m+pro5/EmM0yjCAXPROBAsYybd4VDPBU+kfEYieY+zr6QGNtC2n+WfPEEeW65/FB/mjU
         WvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705593733; x=1706198533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hto2SU4R3yAYwp81hj4Efa1CV18LRXcWhBAicey50VM=;
        b=plvO5f1vuQ4pHx+SosL7D8rzPTjZQeO5W0+K+w9NnfGkQfE88QV0OLkyH4ywKNrFUf
         a4eB3b8iQU3qlOEleQmmv7Izi6FUKWAqlA2Bwqh+jOpOBswviESsHqK+Hdp8LsWBVvco
         tjJwVE2r/dSazua0FW4LX3JPXm6uL5aKBRQuLQNkHdfvHnEECitbT/gKb1S5I/6hd6Rw
         hnsm5BnqKOnZKLd951U5DNoQ8ildPKEBvNb5rGrlNtIpESoHSyivBhVxqVj3Dm6d6gPM
         oQOGLyk3IGvUIobjLOPCykjrOXZG9Rp+ZTKKjBAp51/5zfQm3ZYwNrpdAEsCNJrDFb3Z
         OuKg==
X-Gm-Message-State: AOJu0YyZA7Bxdjr0uKBImhd2NLKagSepYXErX+bndHaQNGsDY4OqeXHN
	MXnJ/cCaL7sqk8EVH7sLwuCShkpV8X3rx44mbKQywKajFfRulcRZSR/UjdQHFpw=
X-Google-Smtp-Source: AGHT+IFnCgCMwuQLn+46tpajB2tVEuF0J1Am5tT3Fme1GmHSkQ6lEQkASyB/fJpRQd7Vv/I6DjrRlQ==
X-Received: by 2002:a05:6e02:20ef:b0:360:2a3:7e5f with SMTP id q15-20020a056e0220ef00b0036002a37e5fmr1936347ilv.2.1705593733508;
        Thu, 18 Jan 2024 08:02:13 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s11-20020a02cc8b000000b0046e7578c703sm1061800jap.21.2024.01.18.08.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:02:12 -0800 (PST)
Message-ID: <fab1b4da-cbe6-49d6-9159-29fb405ca64f@kernel.dk>
Date: Thu, 18 Jan 2024 09:02:11 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Content-Language: en-US
To: Rich Felker <dalias@libc.org>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Christian Brauner <brauner@kernel.org>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
 <CAG48ez39WNuoxYO=RaW5OeVGSOy=uEAZ+xW_++TP7yjkUKGqkg@mail.gmail.com>
 <a9d26744-ba7a-2223-7284-c0d1a5ddab8a@kernel.dk>
 <20240118155735.GS22081@brightrain.aerifal.cx>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240118155735.GS22081@brightrain.aerifal.cx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 8:57 AM, Rich Felker wrote:
> On Mon, Aug 31, 2020 at 11:05:34AM -0600, Jens Axboe wrote:
>> On 8/31/20 9:46 AM, Jann Horn wrote:
>>> On Mon, Aug 31, 2020 at 5:32 PM Rich Felker <dalias@libc.org> wrote:
>>>> The pwrite function, originally defined by POSIX (thus the "p"), is
>>>> defined to ignore O_APPEND and write at the offset passed as its
>>>> argument. However, historically Linux honored O_APPEND if set and
>>>> ignored the offset. This cannot be changed due to stability policy,
>>>> but is documented in the man page as a bug.
>>>>
>>>> Now that there's a pwritev2 syscall providing a superset of the pwrite
>>>> functionality that has a flags argument, the conforming behavior can
>>>> be offered to userspace via a new flag. Since pwritev2 checks flag
>>>> validity (in kiocb_set_rw_flags) and reports unknown ones with
>>>> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
>>>> don't support the new flag; the error is reported and the caller can
>>>> decide how to handle it.
>>>>
>>>> Signed-off-by: Rich Felker <dalias@libc.org>
>>>
>>> Reviewed-by: Jann Horn <jannh@google.com>
>>>
>>> Note that if this lands, Michael Kerrisk will probably be happy if you
>>> send a corresponding patch for the manpage man2/readv.2.
>>>
>>> Btw, I'm not really sure whose tree this should go through - VFS is
>>> normally Al Viro's turf, but it looks like the most recent
>>> modifications to this function have gone through Jens Axboe's tree?
>>
>> Should probably go through Al's tree, I've only carried them when
>> they've been associated with io_uring in some shape or form.
> 
> This appears to have slipped through the cracks. Do I need to send an
> updated rebase of it? Were there any objections to it I missed?

Let's add Christian.

-- 
Jens Axboe



