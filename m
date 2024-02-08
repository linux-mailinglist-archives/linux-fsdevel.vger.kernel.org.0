Return-Path: <linux-fsdevel+bounces-10864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F19B84EC41
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 00:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A693B22BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E90D50257;
	Thu,  8 Feb 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1IrkCXVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838584F8AE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433533; cv=none; b=YmGuQ/9t0ltS+6Y+2Oszl2xseUhft74d0hfC5oW0czWYfxA3VxdGrCd6bE9e1P019+By6E+1qDN8NVSHRANDbsnHlP1Ldhl4L4XWWCj/vCP6TNIlDIDgzQrGaSriby+Xd3j/dGMpENvlujcBlmKPs9zur61I+TItUhxbkC/NVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433533; c=relaxed/simple;
	bh=qZ2xClzuL5p+h7fu7mrvoSgksEfIOnYufKIe0koe9S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GXZ9z39MFiB3t/YCRGZCTaeOH6UbZQ3D19AL8Y9oSMZv5szfcnp/W9VulrjOIPej4ATV8DSWfV0aof54fmWlQbFgDr2yns3Pxhi7sTRmIP0Wl9SIy/legEm3tppAmuXauAwftwag9Sr0JdbZtG9iVXqR7QojtCVH3QOt09XRmj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1IrkCXVr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d987a58baaso635145ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 15:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707433531; x=1708038331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffPjNufwJ6iV8hkF3yT/aqZ7uIGQXR9rbk8epQq1NG8=;
        b=1IrkCXVrHlzkjcQyXaRfq/fIQ7RCHjso8bsKCWmO6qJ2V/+Mpt73MIEU0zaDw4qvQH
         hwu6xadFXCNN1U/+VkUw0vEhba0oVwyfdqNJ2PMy0FMnnG9i7tAu384R+n+3qvctMJrN
         ren9VNqDTo5aEl95cEy0GaLu7mxLzgxBuHJvw/LpDEe1+qyOKfarv6rQ+fDB3/HBpkC+
         BNQzKxV72Dfl8kxuU/GDQhSgXwUdv4bmxdWrJSk4PjDQG5cuX74X1YIwJaC/iB84ZVj1
         LzmoCXeQk9p6BjRqmh2S2SDbpviaVW53fmTpPh6JIfuQyNNI55E/Oka027cOr3gamZuo
         Y6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707433531; x=1708038331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffPjNufwJ6iV8hkF3yT/aqZ7uIGQXR9rbk8epQq1NG8=;
        b=hC+HYQEiYAyinuYuyT/FVW+raIdxNr5fjZ558EfIxyLErHDmtTvxc2iPqe3zIt4WfD
         +P44afkj1ZbI3b/LQx3MwcHA9TsPyMjhMjJWkhOaxIcfp1IsihGQQFyEc4yHVSnP/tfa
         ZNdKJCVq6nOtyx0phn5spsvTSg276Khn5ak4IyTmaESN7TOManBaAJJZqh/co1gohnUE
         aAbcBqnSs8+Rz55IX1Usu7KSWy4VTxBjLrmrYPZALCEW76m+choQCEhyebUBepiHxCP6
         23ynHnjuXAQg27bSW/5EJyMqqTW2vZ6XK6j72ucFQePG5QN8517aCNakGO9xA/w4D17p
         mU0A==
X-Gm-Message-State: AOJu0Yw9/L4qyPPa8kvKvtVBhnEBdc4J+brB5K/21lnEIwH4c62EtQSg
	KkwNwbPQ7veejKeWa8ResNMRU4Vs4pBhPwENJzZp9rHdaEXglhbPYjcn6tdsaKM=
X-Google-Smtp-Source: AGHT+IF1EUlqCh6VgttPSq2O4/ueofQYmayJDhQp2qVdiT/beuMF1e6EjSV/hprNm0JGKQBM1Cg+ig==
X-Received: by 2002:a17:902:d3cc:b0:1d8:f06a:9b6f with SMTP id w12-20020a170902d3cc00b001d8f06a9b6fmr679499plb.1.1707433530818;
        Thu, 08 Feb 2024 15:05:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFZba6pc7ryVi+dv2sJGNhzIPcuE1eKEAMlRKUABerqP0hUxEEYDvKInj6um9+914lCa6yGHMt0wRWpLTa+NjvHq7iGvbyTQUVCCX/sE2jh6J8zhiFaWOsn+XNxGrx4QVV1VFypeSC0yDhA/iWIFBtCESEgWnxug69NnbQas014pAd1TW3RXBoiuotBKNlpiiDAkr/nO01st8Sab2a2AA+WZEzNAvxXwGfxZ3JpackiPxOVnf73WijIbcLgN6YC8Tp
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id kf13-20020a17090305cd00b001d8f393f3cfsm286457plb.248.2024.02.08.15.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 15:05:30 -0800 (PST)
Message-ID: <184bf1b2-0626-4994-85f4-41fc4f71b956@kernel.dk>
Date: Thu, 8 Feb 2024 16:05:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs, USB gadget: Rework kiocb cancellation
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Avi Kivity <avi@scylladb.com>, Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20240208215518.1361570-1-bvanassche@acm.org>
 <9e83c34a-63ab-47ea-9c06-14303dbbeaa9@kernel.dk>
 <e71501ce-6fb9-42bc-89aa-fcf5d0384c9b@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e71501ce-6fb9-42bc-89aa-fcf5d0384c9b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/24 3:41 PM, Bart Van Assche wrote:
>> Just move the function higher up? It doesn't have any dependencies.
> 
> aio_cancel_and_del() calls aio_poll_cancel(). aio_poll_cancel() calls
> poll_iocb_lock_wq(). poll_iocb_lock_wq() is defined below the first call of
> aio_cancel_and_del(). It's probably possible to get rid of that function
> declaration but a nontrivial amount of code would have to be moved.

Ah yes, I mixed it up with the cancel add helper. Forward decl is fine
then, keeps the patch smaller for backporting too.

>>> +{
>>> +    void (*cancel_kiocb)(struct kiocb *) =
>>> +        req->rw.ki_filp->f_op->cancel_kiocb;
>>> +    struct kioctx *ctx = req->ki_ctx;
>>> +
>>> +    lockdep_assert_held(&ctx->ctx_lock);
>>> +
>>> +    switch (req->ki_opcode) {
>>> +    case IOCB_CMD_PREAD:
>>> +    case IOCB_CMD_PWRITE:
>>> +    case IOCB_CMD_PREADV:
>>> +    case IOCB_CMD_PWRITEV:
>>> +        if (cancel_kiocb)
>>> +            cancel_kiocb(&req->rw);
>>> +        break;
>>> +    case IOCB_CMD_FSYNC:
>>> +    case IOCB_CMD_FDSYNC:
>>> +        break;
>>> +    case IOCB_CMD_POLL:
>>> +        aio_poll_cancel(req);
>>> +        break;
>>> +    default:
>>> +        WARN_ONCE(true, "invalid aio operation %d\n", req->ki_opcode);
>>> +    }
>>> +
>>> +    list_del_init(&req->ki_list);
>>> +}
>>
>> Why don't you just keep ki_cancel() and just change it to a void return
>> that takes an aio_kiocb? Then you don't need this odd switch, or adding
>> an opcode field just for this. That seems cleaner.
> 
> Keeping .ki_cancel() means that it must be set before I/O starts and
> only if the I/O is submitted by libaio. That would require an approach
> to recognize whether or not a struct kiocb is embedded in struct
> aio_kiocb, e.g. the patch that you posted as a reply on version one of
> this patch. Does anyone else want to comment on this?

Maybe I wasn't clear, but this is in aio_req. You already add an opcode
in there, only to then add a switch here based on that opcode. Just have
a cancel callback which takes aio_req as an argument. For POLL, this can
be aio_poll_cancel(). Add a wrapper for read/write which then calls 
req->rw.ki_filp->f_op->cancel_kiocb(&req->rw); Then the above can
become:

aio_rw_cancel(req)
{
	void (*cancel_kiocb)(struct kiocb *) =
		req->rw.ki_filp->f_op->cancel_kiocb;

	cancel_kiocb(&req->rw);
}

aio_read()
{
	...
	req->cancel = aio_rw_cancel;
	...
}

static void aio_cancel_and_del(struct aio_kiocb *req)
{
	void (*cancel_kiocb)(struct kiocb *) =
		req->rw.ki_filp->f_op->cancel_kiocb;
	struct kioctx *ctx = req->ki_ctx;

	lockdep_assert_held(&ctx->ctx_lock);
	if (req->cancel)
		req->cancel(req);
	list_del_init(&req->ki_list);
}

or something like that. fsync/fdsync clears ->cancel() to NULL, poll
sets it to aio_poll_cancel(), and read/write like the above.

-- 
Jens Axboe


