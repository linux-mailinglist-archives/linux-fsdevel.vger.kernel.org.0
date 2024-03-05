Return-Path: <linux-fsdevel+bounces-13641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E8E87247D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 17:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD71C25193
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D447DF5B;
	Tue,  5 Mar 2024 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xXfnP33J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC0D268
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656784; cv=none; b=VWcQq8iHP1Hm+wVJq2LYhsVjndq6OAmHVrdiPC5HJ78NrV2Q9Qxd2JMHY09Yi8LN7VszY2d10uIknUUWavCHvJBn83hXHQmxqLt0eQpOBJsAVbb2TrDVQAmvQUp/5y70/cScbsUCuGQdj1s+1OIjCNQbP+or5s7VEgrB58XzDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656784; c=relaxed/simple;
	bh=v8n6C/x7YN6DIQ+jMZ6n/yz9ciW7yWFqnt+WpoorFd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpKs4gEhLK3EoH6tPJXFFiTVYWQelFyIAmt15Yd/4MErtB7XpnSmve3nsbe61cX2boPNVrWSOkzu1AJIV0NDldzHOECgoATuwscx+QlJujoIwC2FnNVOLm6VQim8JbtpF/Fhm+cz4GXv3VBVLT1/XkG3iz6IZLyMnMqDVC+sX0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xXfnP33J; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e5769aa0b3so1270126b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709656782; x=1710261582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OA9jQLC4dwIGmYm8IP8YPIWjYwFgrRL6SgiiIMUwgk8=;
        b=xXfnP33JIJzNhJ7VqgmcIhrn5S2y47Ber7hcjIGY00JXwGUXVR4IT08IhFIEIjAZKr
         UOccuT3vCNJkGuFxOAWHHAZ3TlzwXPWD+r5DJ+GL2LG9aUUmQrnjcr9QQPb16DgLpTkJ
         cw5dEgZB1t6fgDPR1YAfQlWbz7SWwoThdLF7xYCGGCvJnHQSEIC2C7+5wpLndL0Af6Xx
         qQJCbIParz6555SVFXzcqW2ZgtPdVxndJ4TqxcAPu2qetL6S7UUjUca/HU9qfpD3f4Ab
         DOou0dD5WR+Fze0aHsG5nVEo4Dh93UFymoS/X9Go+t4hwDPSGvNEa1Y9ZKBGW+uDfFrq
         W5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709656782; x=1710261582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OA9jQLC4dwIGmYm8IP8YPIWjYwFgrRL6SgiiIMUwgk8=;
        b=eaGfzEwXzftsWAhvuXHePBhETcrBz5SrhMiWXX3oy3EqMzOu9xmYo2HHpmdFfr4LdI
         g/oC0k/skic0UUV2fNolc2jmVpZElcXkdd4feCbW5dp++fAil0sBaVyNOfF2p8v8qwyB
         Pw0p5uIDJC+RhyE1DhsNp7cdWz2wHiDsOE8P9PoLsNdo7AWbbYGNn8saWi+MksxA3lhw
         7flKGGqpRtILQCmDnDT1zghNKof1jZjO49/FYzpR1QZvHz1vLK1HWlDovBL8+8/rzchW
         8FtTfmo4ocDl0Ml+4/2EWSpQgmiwAIe86vTnqSIHaTba5qg7ZNLPggEpBF+QH320EsmI
         wamA==
X-Gm-Message-State: AOJu0YzdPo7DUKEbE8GiYxq5ICNJHz2lXdnGxuDN/7rW6UNFC/SaIReZ
	tIbYOpQZf/4W8g0XMLwrcr/uinU7sfPx70b2h1ofAFXpLsKfz0nObPhGicA+HNw=
X-Google-Smtp-Source: AGHT+IEZZmdBTuGELgE5G3mET+Y5Q03hb/dCXOp8iblHOZ8cZ2iYyO9OCe8v6bCQwp8Fq5KTziHDaA==
X-Received: by 2002:a05:6a00:1823:b0:6e6:4578:e309 with SMTP id y35-20020a056a00182300b006e64578e309mr1115104pfa.0.1709656781866;
        Tue, 05 Mar 2024 08:39:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d4-20020a056a00198400b006e4fc1b1881sm4134950pfl.24.2024.03.05.08.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 08:39:41 -0800 (PST)
Message-ID: <db1a16d1-a4c2-4c47-9a84-65e174123078@kernel.dk>
Date: Tue, 5 Mar 2024 09:39:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump: get machine check errors early rather than
 during iov_iter
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Tong Tiangen <tongtiangen@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, Guohanjun <guohanjun@huawei.com>,
 David Howells <dhowells@redhat.com>, Al Viro <viro@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240305133336.3804360-1-tongtiangen@huawei.com>
 <20240305-staatenlos-vergolden-5c67aef6e2bd@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240305-staatenlos-vergolden-5c67aef6e2bd@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/24 9:33 AM, Christian Brauner wrote:
> On Tue, 05 Mar 2024 21:33:36 +0800, Tong Tiangen wrote:
>> The commit f1982740f5e7 ("iov_iter: Convert iterate*() to inline funcs")
>> leads to deadloop in generic_perform_write()[1], due to return value of
>> copy_page_from_iter_atomic() changed from non-zero value to zero.
>>
>> The code logic of the I/O performance-critical path of the iov_iter is
>> mixed with machine check[2], actually, there's no need to complicate it,
>> a more appropriate method is to get the error as early as possible in
>> the coredump process instead of during the I/O process. In addition,
>> the iov_iter performance-critical path can have clean logic.
>>
>> [...]
> 
> I'll send this together with two other fixes we have pending.

For what it's worth, checking the two patches, it's basically the one
that Linus sent. I think it should have a From: based on that, and I
also do not see Linus actually signing off on the patch, though that
has been added to this one.

Would probably be sane to get this one resent before applying, properly
done.

Missed that in the first look...

-- 
Jens Axboe



