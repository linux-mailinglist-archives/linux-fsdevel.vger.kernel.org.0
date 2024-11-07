Return-Path: <linux-fsdevel+bounces-33861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA40F9BFC68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 03:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEFC281BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E911713;
	Thu,  7 Nov 2024 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="o37u+N6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746617D355
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945398; cv=none; b=bkCPYtBJhd1qhZKRitn+VtRAYfOnuPNeDKocG92CVa403SSEa0hwVCP0h/g4Yk5/6WMgJNv6ptaxREbmO06iCbcPdrXfWD+bB7UzIAsuafg86wFG2I/mr4wQ0llW6M3QbSEenZZ9YrKXbxdD5C6iDZfPpqGV7z90H3b8K5Q83tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945398; c=relaxed/simple;
	bh=U9UwNAev20LVjIzoelIDNy9digyaRx9q0qybyVFRXUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZzsTt2eekqVe+QT4RqTaeWqCbzJLxb/FnAUsDOfDD8PYI4xZ6NeLusbi5ni1GffHVHPdolxGi4YpvK3VfIF4TheD/7QmDAHB1jcvZdfoVkQs/5uSGwIxyouvj46dfTekBtjuyyeO2P5wL67B47hh7hO+fgmhpEaewR/d5nHgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=o37u+N6W; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72041ff06a0so331927b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 18:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730945395; x=1731550195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=;
        b=o37u+N6W5u5b2gtR/PZami0YGkuUQpsCQQQEwzHS9f3Axo8vf06/YD7OxwHceCDcni
         GgUsy1fNvkpaQ5+7HkNf3OqCq8s7KjrvfGh56TLOVTGqyE3SaMrT5tqhCm5ZK4BrekFX
         el08KYfIIqcbYQpO2RCRXxj9CImDomBNJGsYFmPN4OexxtmDCf4YYQlYAtBWGlraC+TX
         erQxB8PN6CjVZhmoIpI7pZetZDkqnZr94yF2VIB4CVOqHnvIZamELJG950Rv9C2pmf0a
         GxOh6J65yKCwRohGmy+SJWTFG7/63TIfZUcnzJUT1ihbvl3zq3ajUPqAjGXiAQo4AGNp
         f/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945395; x=1731550195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5VEXH/UjVZxKSBS42OsN1z+40kpn9n52otycPhBNjg=;
        b=rzqtZQqhxn8RMlxA91tx74qrLjtvXcHZJjXLoAncAyni5Eg/OktETiL2CwuNBiA/fO
         Y4jbt/6I5IwRYcFhkmSyt8zYvjj+vg0x+nvvuhNL1KSez7PBp5n0KWm/kiHSyDJnQ+RF
         0ft2RYUjtcEZkM6XT3722ddTA3DfueNdbZvC0fFDJY2fZUpK0Vittn9YlYqSdIr53sI1
         gVYOc6XhkRINMdoc8RuL28UoVMF334H/WFZwm3XvA0E4BL/otbQRA1Fbegit3TfI7kbJ
         8dsW7mGyz8pDz7D6SrXEf/hxaGbBQxmwSEkBWHMQqYIHQsJkwmSNpStafilB8stL+nB5
         xvqw==
X-Gm-Message-State: AOJu0YzvY+ChkLM0bCV8pjXRc9AwO62djg1wIHRWXTnJd7Uss2U3d3dZ
	CsI8MEhnqoGAky4ROdGcFqgmxZlWlE15EkVnGmbYBICE3Oe3Czb+v2Ou42iTERo=
X-Google-Smtp-Source: AGHT+IE4FdVcCFM7JfMcQ3SKmd1UC6mzCGq6q6jfwTYIDNNfVDV6mTuEsMVwx/N+IlnX034mAbpOSg==
X-Received: by 2002:a05:6a00:170d:b0:71e:1314:899a with SMTP id d2e1a72fcca58-720c998d8b9mr30360940b3a.20.1730945395467;
        Wed, 06 Nov 2024 18:09:55 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a50512sm256626b3a.173.2024.11.06.18.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:09:54 -0800 (PST)
Message-ID: <e757bfa0-0c21-41d6-a072-ce85f4ea8a04@kernel.dk>
Date: Wed, 6 Nov 2024 19:09:53 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 6/9] io_uring: enable per-io hinting capability
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, bvanassche@acm.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241029151922.459139-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 9:19 AM, Keith Busch wrote:
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 0247452837830..6e1985d3b306c 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -92,6 +92,10 @@ struct io_uring_sqe {
>  			__u16	addr_len;
>  			__u16	__pad3[1];
>  		};
> +		struct {
> +			__u16	write_hint;
> +			__u16	__pad4[1];
> +		};

Might make more sense to have this overlap further down, with the
passthrough command. That'd put it solidly out of anything that isn't
passthrough or needs addr3.

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 7ce1cbc048faf..b5dea58356d93 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  		rw->kiocb.ki_ioprio = get_current_ioprio();
>  	}
>  	rw->kiocb.dio_complete = NULL;
> -
> +	if (ddir == ITER_SOURCE)
> +		rw->kiocb.ki_write_hint = READ_ONCE(sqe->write_hint);
>  	rw->addr = READ_ONCE(sqe->addr);
>  	rw->len = READ_ONCE(sqe->len);
>  	rw->flags = READ_ONCE(sqe->rw_flags);

Can't we just read it unconditionally? I know it's a write hint, hence
why checking for ITER_SOURCE, but if we can just set it regardless, then
we don't need to branch around that.

-- 
Jens Axboe

