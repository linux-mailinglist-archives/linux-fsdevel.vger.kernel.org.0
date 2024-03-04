Return-Path: <linux-fsdevel+bounces-13553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E0870BE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 21:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B52283373
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692591079D;
	Mon,  4 Mar 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="u9LAcnIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C422E54D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585619; cv=none; b=HHKQ0/ZfmTargRxH5ucbe77id48zyQchzyCKAPpa/RQQ3ZS0LkbzJxoVDf00TluES3NJatumzq/xWVEaRwngPiY9bGa1Jr1z5k1FVW7aohHQ9u713Njay8en1xP8RgMcvqIOYR3HycTewxtF/qlGVohwW73znm4ecjf1pnQYaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585619; c=relaxed/simple;
	bh=DgKavsA85fHRI/A2Xu/QYBjb/sHID9ZOaQyjgq9v73Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLwEanYQd7LPFf1+iyoFtaXJ9bFhNQEzG5K5k08dC3TrD70m53eYSxl8yiOpmHmqTNCCEpd23u1SJYRTR6sQKL+Zcz8+emcO+oflkA6a1WXtPdNZ7Yfo7+w7uXVEU6NqtRH9FMtPtz7nd8DmnNkXQUuSad3nwroJh6vHHpK+zSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=u9LAcnIZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60858cfbc98so2208267b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709585616; x=1710190416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UaiFPeljKQTnnuDl9y1nPNnYywTRghw1tefyhALlBkA=;
        b=u9LAcnIZdBHdLpKpAwpcYnYoVPmOVOutvtwSmZUdpzjvaBbh93RgHZxHJ4VWHA48Sw
         WME2VQMWSfMqcmYaSDo8mXLAH9BH6aFZFxjxtK6wC8ALGhV8SjXMQEawnC/C6UIdXV+0
         IvuAaDLyizNFPK+J2cOoOjIWrlPwLc3KhqWG+V0ISNs22BYML0VQhWm7EyLeNd8rgXvh
         yvs44DT40t2WADfS2AX8lkiIxYsWjSZ7jsBZXf9HtCeZrIZJrrPvfRmRsKdtYiNiH7vK
         pr47jb/gcEQTE1qdqK6qSsRnOGU5xXk46+8lt7+fYDsvmu922I2vB0ND93vv0WTDW2hF
         2wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585616; x=1710190416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaiFPeljKQTnnuDl9y1nPNnYywTRghw1tefyhALlBkA=;
        b=oLc/RwqffclkqJmKcvLFXZmLP5LAkGXcSFmhy2qpamCDneLyGBmJ6X1YLjGP/MJ99x
         Q7BaBJwHzKDgkzcnFL8NGTpRR9wyn+BzjJYEgnVrsGne5DzFXO27GuO4FA3hrB7HLnys
         CsSYUUy0GV6EviwVulxe4mvnAuh1nAJe55WYtxfn1oXNvFPCSLeh6tONq1ReHPV+sYzO
         KuMNnHqVxRif9qdVE98K2hNxbmau1FAt9ISzpPMo7KxpMYNi7roWvIeKOVENN4P2apP6
         ymccbnc9ky1Eo77dwxvCiAKOxfSqZdBdtufz37Jwh8gZXsZwyqrdzGjWFeGuTxTdUPSn
         KT/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGH4TGzhtZVfkQtxthdmt/d2qvxCqjblAf678J3afkXMuIDLQOWF3vG7RE+VzYkLIrtKBspWVlwWg/ulrF9+zeTt0ut+dDpYCB/2cX6Q==
X-Gm-Message-State: AOJu0YzP6k7J13LTQlzDqldALJbU+ascoPZyaZt+LxlyhGuK3JZQC5fx
	9SHDwv/4RcEVZ5/JIQUPvdC60DcB+G9p2BnCsbSp2bXDmkCeKhLT36lArWhlgDQJOcwavPTRz7X
	Q
X-Google-Smtp-Source: AGHT+IEn6Isdmp/elK7/SXYEAztI+sNFtGSfVwsMN8V+Bu0638zU06OmxXF05jr9h3XT4WDbgKVRwQ==
X-Received: by 2002:a05:690c:338c:b0:609:552:2fcb with SMTP id fl12-20020a05690c338c00b0060905522fcbmr8538455ywb.3.1709585616620;
        Mon, 04 Mar 2024 12:53:36 -0800 (PST)
Received: from ?IPV6:2600:380:9e4e:d529:fa8c:33a4:688a:83e? ([2600:380:9e4e:d529:fa8c:33a4:688a:83e])
        by smtp.gmail.com with ESMTPSA id u125-20020a816083000000b006078f8caa68sm2842990ywb.71.2024.03.04.12.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 12:53:36 -0800 (PST)
Message-ID: <c4da881c-db33-4cf8-ae5f-fea81aba1f6d@kernel.dk>
Date: Mon, 4 Mar 2024 13:53:34 -0700
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
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Avi Kivity <avi@scylladb.com>,
 Sandeep Dhavale <dhavale@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, stable@vger.kernel.org
References: <20240215204739.2677806-1-bvanassche@acm.org>
 <20240215204739.2677806-2-bvanassche@acm.org>
 <20240304191047.GB1195@sol.localdomain>
 <73d9e8a1-597a-46fc-b81c-0cc745507c53@kernel.dk>
 <20240304204916.GD1195@sol.localdomain>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240304204916.GD1195@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 1:49 PM, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 01:09:15PM -0700, Jens Axboe wrote:
>>> If I understand correctly, this patch is supposed to fix a memory
>>> safety bug when kiocb_set_cancel_fn() is called on a kiocb that is
>>> owned by io_uring instead of legacy AIO.  However, the kiocb still
>>> gets accessed as an aio_kiocb at the very beginning of the function,
>>> so it's still broken:
>>>
>>> 	struct aio_kiocb *req = container_of(iocb, struct aio_kiocb, rw);
>>> 	struct kioctx *ctx = req->ki_ctx;
>>>
>> Doesn't matter, they are both just pointer math. But it'd look cleaner
>> if it was below.
> 
> It dereferences the pointer.

Oops yes, was too focused on the container_of(). We should move them
down, one for clarity and one for not dereferencing it.

>>> I'm also wondering why "ignore" is the right fix.  The USB gadget
>>> driver sees that it has asynchronous I/O (kiocb::ki_complete != NULL)
>>> and then tries to set a cancellation function.  What is the expected
>>> behavior when the I/O is owned by io_uring?  Should it perhaps call
>>> into io_uring to set a cancellation function with io_uring?  Or is the
>>> concept of cancellation functions indeed specific to legacy AIO, and
>>> nothing should be done with io_uring I/O?
>>
>> Because the ->ki_cancel() is a hack, as demonstrated by this issue in
>> teh first place, which is a gross layering violation. io_uring supports
>> proper cancelations, invoked from userspace. It would never have worked
>> with this scheme.
> 
> Maybe kiocb_set_cancel_fn() should have a comment that explains this?

It should have a big fat comment that nobody should be using it. At
least the gadget stuff is the only one doing it, and we haven't grown a
new one in decades, thankfully.

-- 
Jens Axboe


