Return-Path: <linux-fsdevel+bounces-41231-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38179A2C9E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07561666A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A451922E0;
	Fri,  7 Feb 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TPX5wL0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408A718DB0C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 17:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948409; cv=none; b=ql/i1QJFw/36ZOvVtOjQTqi8wj8Vr2B27NGsV87uTvzwy9dpHTPTOIoW2kt/ZNjY4lOqdV2hoIotcVDTsE8wDQ4kmyBvHgIZSd30vX3UU+8156sDjqc+x2VHIPczxNtu07MNZOOwke8wZdbKbK9gkjmx5YUTUXTBRKYojPWDqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948409; c=relaxed/simple;
	bh=vYa/QabUjlyWvNl+i7qgROWmEQ0CtJkSoevEwKuBbxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qt04tM24M+T2xx9JWTariHJmK+0OJXHHFiC3RIb0y0I13A1Z8Sje3lBTz4VJGvaAwoLsWuADZhBQeOfdSJ5qsqpMiBgk3Iwv8oi0dhoxGqwW1X+11i3f9kAnVaeijFkEFFN83sBndi1FVMBByx7KIR0s2RZBfxdubcDYi0Jf5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TPX5wL0y; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-84cdb6fba9bso172665839f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738948406; x=1739553206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZtNoiwfFj5sgCdbLuzIEUfenJAboj+8BFhovUJcxew=;
        b=TPX5wL0y93/3sNHKdVKfBln5PmDEFpZqoo2CZ7j82WWrUuX3j0WmKyuduCHBX/lv1O
         6xREaY3O/MF1+qNMLXUxzNLYFm07wE7PP3O/H2bQzbL3PsNTuyF1H60hLFDq3awE3mRY
         wvGCHCbvZZwPExutwx9JbzbNfa1eZNa0QoSOWzguJZwPCpYotDnraqLN2wxbsM/wARxk
         XG6x060yCBDkNQuNTCK9ltWVz3/2i367RC5NsK9WO9FatT6xSZA9VOI7oh/vZfGv4uYx
         FKja/aVza8qnhtlbXmrDBcyXopiAPa7X2yMde0Ji4K2dFIvsBawdwpUxAeQOoRLTJYaW
         CyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948406; x=1739553206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZtNoiwfFj5sgCdbLuzIEUfenJAboj+8BFhovUJcxew=;
        b=Nl2O8BcxspaBpDMoS0O2LHbzCRPpV4CGw2rP9+fQJD0hA6vD6RsVA9pDOF829AEA4A
         8TBCVMgXQSZ+DxeiWoEVAnIpWm9tbHpOYpmBeH2OLVajROYjqa1QsoEYyRixZfSPjLFF
         Kesh++KcP02dc5ETlyMCAH2I48t0p57x2QPcyffC9hKbInx+UNThbhXkiahmE3T+OPti
         pmNRmhJHZKaHrB9o+f8K9PePRRzzgq2fFctST/SuEcvyZlps0+ASY+AH0PLASJf6NvgE
         eqL8bieBsVujEXXsLnIq/Imp8vx2CTV3c113RH8eNeMhvp+pCCmIVJ7IPdVJST1FoL3H
         4mVA==
X-Gm-Message-State: AOJu0YxgJwVKtp24o/oJ5NvpzQ4CZoaZiuCX81wXbyU1T63xsuA2DLn1
	x7QSVxmeEt6ui8/qrGkAr9T8kBmdygs50nv5qhzG5RAlEYhLuJ+v51eJFffaFoDC9WMbmWG0U5Z
	C
X-Gm-Gg: ASbGncul9eBgzEdXOUmNEIx7yDIfFAKH0yBB5O8IcZM9TKZhPSIt2rnxVrSVIm1E+qn
	bHRXghuKPc9dkJpHvPRBYpjFVJb8CefCsJVIygCxKTwV76NaFRjg4V1kGfPmfume5AAG7XShhf2
	sAUJRUOFMeucXhWkhMwGdEMets0WDorfnp+dxqZ93eV00vSJ7kbMesovg3FRV+G3OinBDlfjS/a
	FoXUI/oq2CgsadZzR7JwOoAIWe2/MxXohuTLlkqimIcV5F1JdIrc0HgGlwXQwiBPMzWQbjYmGnm
	Z+GCXZly7+M=
X-Google-Smtp-Source: AGHT+IF5Ztcfat9CIeu5dpJKcjs3QOwLyAAmh/VvQ8pBnoebwEDW1W8nLOXNPh48stnHAu8gCIOY4g==
X-Received: by 2002:a05:6602:368e:b0:84a:7906:21e3 with SMTP id ca18e2360f4ac-854fd8b2547mr485445039f.7.1738948406320;
        Fri, 07 Feb 2025 09:13:26 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfb343b6sm827725173.142.2025.02.07.09.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 09:13:25 -0800 (PST)
Message-ID: <7e4e9eae-5dc6-40e3-9501-c6c7328b3fb5@kernel.dk>
Date: Fri, 7 Feb 2025 10:13:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] io_uring/epoll: add support for
 IORING_OP_EPOLL_WAIT
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20250204194814.393112-1-axboe@kernel.dk>
 <20250204194814.393112-10-axboe@kernel.dk>
 <a48b35ed-b509-40a3-ad00-4834872bb39c@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a48b35ed-b509-40a3-ad00-4834872bb39c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 5:38 AM, Pavel Begunkov wrote:
> On 2/4/25 19:46, Jens Axboe wrote:
>> For existing epoll event loops that can't fully convert to io_uring,
>> the used approach is usually to add the io_uring fd to the epoll
>> instance and use epoll_wait() to wait on both "legacy" and io_uring
>> events. While this work, it isn't optimal as:
>>
>> 1) epoll_wait() is pretty limited in what it can do. It does not support
>>     partial reaping of events, or waiting on a batch of events.
>>
>> 2) When an io_uring ring is added to an epoll instance, it activates the
>>     io_uring "I'm being polled" logic which slows things down.
>>
>> Rather than use this approach, with EPOLL_WAIT support added to io_uring,
>> event loops can use the normal io_uring wait logic for everything, as
>> long as an epoll wait request has been armed with io_uring.
>>
>> Note that IORING_OP_EPOLL_WAIT does NOT take a timeout value, as this
>> is an async request. Waiting on io_uring events in general has various
>> timeout parameters, and those are the ones that should be used when
>> waiting on any kind of request. If events are immediately available for
>> reaping, then This opcode will return those immediately. If none are
>> available, then it will post an async completion when they become
>> available.
>>
>> cqe->res will contain either an error code (< 0 value) for a malformed
>> request, invalid epoll instance, etc. It will return a positive result
>> indicating how many events were reaped.
>>
>> IORING_OP_EPOLL_WAIT requests may be canceled using the normal io_uring
>> cancelation infrastructure. The poll logic for managing ownership is
>> adopted to guard the epoll side too.
> ...
>> diff --git a/io_uring/epoll.c b/io_uring/epoll.c
>> index 7848d9cc073d..5a47f0cce647 100644
>> --- a/io_uring/epoll.c
>> +++ b/io_uring/epoll.c
> ...
>> +static void io_epoll_retry(struct io_kiocb *req, struct io_tw_state *ts)
>> +{
>> +    int v;
>> +
>> +    do {
>> +        v = atomic_read(&req->poll_refs);
>> +        if (unlikely(v != 1)) {
>> +            if (WARN_ON_ONCE(!(v & IO_POLL_REF_MASK)))
>> +                return;
>> +            if (v & IO_POLL_CANCEL_FLAG) {
>> +                __io_epoll_cancel(req);
>> +                return;
>> +            }
>> +            if (v & IO_POLL_FINISH_FLAG)
>> +                return;
>> +        }
>> +        v &= IO_POLL_REF_MASK;
>> +    } while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
> 
> I haven't looked deep into the set, but this loop looks very
> suspicious. The entire purpose of the twin loop in poll.c is
> not to lose events while doing processing, which is why the
> processing happens before the decrement...
> 
>> +    io_req_task_submit(req, ts);
> 
> Maybe the issue is supposed to handle that, but this one is
> not allowed unless you fully unhash all the polling. Once you
> dropped refs the poll wait entry feels free to claim the request,
> and, for example, queue a task work, and io_req_task_submit()
> would decide to queue it as well. It's likely not the only
> race that can happen.

I'm going to send out a new version with the multishot support dropped
for now as it both a) simplifies the series, and b) I'm not super
convinced it can be sanely used. In any case, it can be left for later.
Once I do that, please take a look at the ownership side and let's
continue the discussion there!

-- 
Jens Axboe

