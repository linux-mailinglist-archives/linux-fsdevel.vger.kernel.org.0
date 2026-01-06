Return-Path: <linux-fsdevel+bounces-72542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B4CFAC44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 20:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF2CB315E04F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 19:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286D2F9D98;
	Tue,  6 Jan 2026 19:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZdw9btf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D32E719E
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727960; cv=none; b=mFurR155IjCpHKNgRf4nOVMsFM4HwulpmrSK+NQc//jA54x1Ahw7j85GpKI5C0iwLdCfDqRMYEknAp8X+2SGmbnjgE3aqavH8c6obaJ9tqQSX7WKhovX/8FajCrobk//8T/CDE8mK4i4+Ai8B5e6JnF1Tlnt78h4dL8vBbITGWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727960; c=relaxed/simple;
	bh=eoBCBjo/KSoxejYCD1xX6+n5o2xGH1pTIUXqFKAPS2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lftT4BJxxAHzdE5/18HA3QXr5PRZ+6dhuPWfTiFvIoYrCgQXPa977v3kYW9fgEsH1Yq77PK1aVYQlYxG3ReSOPjcfGatBzdB8EMOd+Qt6EKPm4YPnFQOHWcLiVQBzJZoRIxdUECVBSH/vHHZaoWhUSkUsHSeFHtMZpSMg9/FAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZdw9btf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43246af170aso101138f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 11:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767727956; x=1768332756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5ExmjzRt11H31bMlKYOhViS+00PGFmBw8wszOB9k6Y=;
        b=nZdw9btfuv3XQUvIVfi/FzVIQK3dk7N+yTg60Els58NGPsP5awU6F3ho+N1Br7RfmQ
         fZOKw//NcKiVWtIxRGlh59PWq3z+67uid4TzjBchTVHhfWFMhQHyyCIem6hqp55W+PT1
         azX8P2mQELdF3C3g8UXxpQ15KKO5hzOvGpfA+AHTbjTJW9YOgqaMqO5fB252HDy79cKc
         dJzB38kohFI3dlIU79m2LkEKWYRtLfVdJcL5EeexmEy7wWUsf/+qOvMEWjTdI32MP5QB
         8ZJ75PG0RCyRljpP0PlnvpgDsblrOLHvpLxey4PgrAPmvc/yVW++uXaR8Bg2zLSDxCjo
         JgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767727956; x=1768332756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A5ExmjzRt11H31bMlKYOhViS+00PGFmBw8wszOB9k6Y=;
        b=i4I1LosVD/gkg3cJijxSntjl8zGky1zJaXDJOe1yiBJT9+zVYS6uqq3Vd0WhJxpv/u
         4FoDHI6HUt++An8wUvoEFWSx+cZdf/3hCaf8TGZ7ZSPbzniAivND3dIMoWkJfIW3gnmU
         COFUK5ULSwfFSfke8C/smeBi0iEZi7mHAT7J1lFDXj7m4a4/nRpm/mCXv0sGLlnYJ2gx
         IJGKJnm/Vnx7Hy2wnqi0uoSHDA11FBvkZYWlFt/zGLy319G93JuxB9CSaBf0bcRm75Eu
         I3tPJg1jdDqlFokUbpZnjvK/7L60wZARfeDC4zgCA9Oo6q6BHBCyEw6yYFnf/KNA/4wQ
         8gIA==
X-Forwarded-Encrypted: i=1; AJvYcCWmfMcX5OQFcIk7yLHBTQotThYNJphmmxsJ8//LPfH/oy+Ki32qrMdzJjQK30MmJdI8zsvOFjBVVHm18rr1@vger.kernel.org
X-Gm-Message-State: AOJu0YxX23tiF/YnexgxuUQ2QPp4yWVbDHlJwHZRsh0ESy5/BqCrQiWL
	dEpA6hJLa32YwvevVm1n+e5zQT/CEj+tS9oD0h27ZtAqFBuoTaFB4wtN
X-Gm-Gg: AY/fxX6qmjRfk3fEwUYlYxvuVq203kt5/RJ1CBx/GP757n09dUxx5ECMHCh5624e7t0
	WtUJMUTp2ETUK8lfWFxOte/s4jiXP6T8FGXuigMcUqJqE11b3u8E5p1RJSYQehR4kv2S1a5Q/nw
	ibhT4p1jSCIZOEYJ7OgCGODMKkk/I69tGkAeOwdtTFvjZR1GzFxlmQI+uKe3hsoQsduSpeTay4P
	nnSLfyAnnuxLghBfhLtn5z/baX5TXHv/ZhJFCq8LyvkAHze1wGlkY13sJEWXG5R1IMdtqfBxuHn
	6/hu0H+l8ghtYN4eaEpdbgwV6dEkYESxPajQnLKxC3ziZU4llswZP3I5+j4PcRNnSBUs7VQ0pHN
	w79gVOsk0GUsZXqzMcVlyVLGr5epQkUE2YHjP7/msKKBQGWjDgxzJ7QYC+qPkNmdFUhLiRRDtEG
	iNugdfimuRL7ZQeDG7aTXnumc0qNj6nEvcIhdMSyW2wKN1dR53yMphiQl5uJmGEKnz6Ng8ou9Zz
	BiBRfpIPHfOXWlbhE3a4mQNULlUmYcFE49SGm6MBvE5OdhFde2WpVRmf5/PQIQV
X-Google-Smtp-Source: AGHT+IFIh4UFL5ktKvizijTqM9ls5ooe70zcSXJi12HfQ2Im3m/BSeK/gwa0FGVa9q2qDIVhMmmdpg==
X-Received: by 2002:a05:6000:3104:b0:431:cf0:2e8b with SMTP id ffacd0b85a97d-432c3778e47mr273696f8f.29.1767727956009;
        Tue, 06 Jan 2026 11:32:36 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e6784sm5933503f8f.19.2026.01.06.11.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 11:32:35 -0800 (PST)
Message-ID: <275fdece-d056-4960-a068-870237949774@gmail.com>
Date: Tue, 6 Jan 2026 19:32:32 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 10/11] io_uring/rsrc: add dmabuf-backed buffer
 registeration
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 David Wei <dw@davidwei.uk>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <b38f2c3af8c03ee4fc5f67f97b4412ecd8588924.1763725388.git.asml.silence@gmail.com>
 <aVnGja6w4e_tgZjK@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aVnGja6w4e_tgZjK@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/26 01:46, Ming Lei wrote:
> On Sun, Nov 23, 2025 at 10:51:30PM +0000, Pavel Begunkov wrote:
>> Add an ability to register a dmabuf backed io_uring buffer. It also
>> needs know which device to use for attachment, for that it takes
>> target_fd and extracts the device through the new file op. Unlike normal
>> buffers, it also retains the target file so that any imports from
>> ineligible requests can be rejected in next patches.
>>
>> Suggested-by: Vishal Verma <vishal1.verma@intel.com>
>> Suggested-by: David Wei <dw@davidwei.uk>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
...
>> +	dmabuf = dma_buf_get(rb->dmabuf_fd);
>> +	if (IS_ERR(dmabuf)) {
>> +		ret = PTR_ERR(dmabuf);
>> +		dmabuf = NULL;
>> +		goto err;
>> +	}
>> +
>> +	params.dmabuf = dmabuf;
>> +	params.dir = DMA_BIDIRECTIONAL;
>> +	token = dma_token_create(target_file, &params);
>> +	if (IS_ERR(token)) {
>> +		ret = PTR_ERR(token);
>> +		goto err;
>> +	}
>> +
> 
> This way looks less flexible, for example, the same dma-buf may be used
> on IOs to multiple disks, then it needs to be registered for each target
> file.

It can probably be done without associating with a specific subsystem /
file on registration, but that has a runtime tracking cost; and I don't
think it's better. There is also a question of sharing b/w files when
it can be shared, e.g. files of the same filesystem, but I'm leaving it
for follow up work, it's not needed for nvme, and using one of the files
for registration should be reasonable.

-- 
Pavel Begunkov


