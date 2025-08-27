Return-Path: <linux-fsdevel+bounces-59385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4352BB3850B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF96C3AE174
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7EF1D5154;
	Wed, 27 Aug 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EqmoFEq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8919994F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305210; cv=none; b=YqiPm12aRHSaJVmmbZThyQ1wJE4qP87xWST9fyfoXMADFeayBUcpgugj1KvG0G3vZHucppQ/X+JV3ssShJ7j9rvqWK7qac0tY8ERaG2ruIL2WwVNJsrdDP/id4gyFw6K915UekkvgymJRuKXc7XNa1w2byoNWNcx2eFhxGne60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305210; c=relaxed/simple;
	bh=sldAhQQpmLk8JfPQ/X/+f6FvtcyWfPIoIRD3vqVION0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxqFNDYbug5n7ZV/DsrQd5miiYsVrOMc6N78AtRPZT2yDAwlhv7G/TgNAmEwHf7K7CBVNv/8VuK8veLycAJqRUnUXTnvKdYMhU8TRWloHaePXQjD3DbRUYvPZFIbZhKybwWMtev/KkYghrjiprVoIOBL+rPx/Rl4uPMuSkg8LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EqmoFEq4; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-88432efaf45so88129739f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756305208; x=1756910008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuXTvGJMiWGFlmLyQyXukPdAfvRayni7TOXCI1oEsiI=;
        b=EqmoFEq41KGQNhGdLYTS0SQP41vUPjT42sofrhJQjgGRicuyrAqkPEap+DyoFF19pw
         1c9PyODXgCiZMBQmPd3zYMyNTuqLYdPqhfN2NysBZ910QNr+Z6HrawSj4SDITlWHjxhh
         3YcEMjbPtEQu40l73qiIl0r0fmG46LxoohVOMPxeaUppaQbj8C5VH5plK4dwY0EfT3wl
         QJwpBTTH+rY3b9BNvoms7WzmDj0r+IoHU8L4lLBDoc9GctiyZ+wVTeHVtfth28kG5Jef
         rMyEPivKoxFWTbhMn3NyyZp3Ges/1TKkyKCL51N06VCEp8i4ZSuTMzTTbcr541Sz8gpZ
         OZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756305208; x=1756910008;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuXTvGJMiWGFlmLyQyXukPdAfvRayni7TOXCI1oEsiI=;
        b=HBJ4v9h1C2WIHbJCo3Y+ax5THvhqTtokA7vMa3cCkF+JzyKAMTn1KiR6abxWRRBcq3
         bDcYslrplK+OHIeqmauKTa26lgiiSqSt2TTd/2XM2aJw+zdRCpt3VBgjXavCRefaFhfv
         YHiUEYotT+xZ68ahTlyfgh3W4pREdww5Vjnp/FQnon08KIBcqlwoyoJGsGeKnUhiQiWL
         ed9a0Nk7HusODc608fTxK0HfdRtndqR6oSeVukaVMN1Ej6O8TYeX3G0I7BFNstlaP4yR
         nWSzvq4l8k2VHJWhDwjTIjl4W4t2MhA1zsQpsg3cTxkkPyxnYIWLQA0kZbYdASmZ7xAU
         Q7yg==
X-Forwarded-Encrypted: i=1; AJvYcCWa5nVM1+0gU7JEk+zYl/QTRmRjAnThydY7zcmQVjCG7kdYZSwTu4qCo7XERZ4p2JkTOoRWSfAxp+PUkwE1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7Vn4hmT+av4s1ALtv/3IDQ4fj3mn+iorUXBQGbxNL5V7+dPS
	0PddupN185fdV3xywVrY/uBjSpThw7hhtyoRnRuz0HkFGsE66PM/VTpEx7uMigFSsVE=
X-Gm-Gg: ASbGnctttjgsD+FQcvtDoYhm1+tDNGcja/LvboxwkLRfCdx6EUHHj9MvqehAHy0rrf8
	itd9fMFqFhL0cRwBQ4RtWY7V5TTRZu2DodnzGMk3MAURnV3HG/Iz01wuKd7tm16c+QHKIOYm2hM
	rMnLrBQmvY4W54LhzEDoleDuaJIaeogLau+7AXzsoTZWN676hfL2v9ENSUAN0puh8W6RoDtMrqW
	Bp48XPBW6aQyiB0zg3/UuuyOoIufoBYPzw2qgtG0PGhDH4CHx4IdaSyFKc8f2QZ15NSVpdGat2a
	O3tn4tEAKyOiBdTLtkwAEeXW8lXs1YXimVTI68l234esqytea8jGVeJT1CoyHawCWIVV090eYyH
	Oq38D/3zfpYSIxeJ83QOVJKLAuF39lu1S6LoibSqJ
X-Google-Smtp-Source: AGHT+IFhCDX+vznxC1PeElLem/u1bc5IXLzc0em6nOpMfx2mbDcc4ih3vaywDiYCZarP1Vk6NBlZyA==
X-Received: by 2002:a05:6602:6215:b0:886:f821:a575 with SMTP id ca18e2360f4ac-886f821a5cdmr567026339f.1.1756305207920;
        Wed, 27 Aug 2025 07:33:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886c8f0c68asm849331339f.11.2025.08.27.07.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 07:33:27 -0700 (PDT)
Message-ID: <a7006be1-fcb0-4132-88c1-0b23bc6d642b@kernel.dk>
Date: Wed, 27 Aug 2025 08:33:26 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] loop: use vfs_getattr_nosec for accurate file size
To: Theodore Ts'o <tytso@mit.edu>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Rajeev Mishra <rajeevm@hpe.com>, linux-block@vger.kernel.org,
 Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250827025939.GA2209224@mit.edu>
 <274c312c-d0e5-10af-0ef0-bab92e71eb64@huaweicloud.com>
 <20250827143136.GA2462272@mit.edu>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250827143136.GA2462272@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 8:31 AM, Theodore Ts'o wrote:
> On Wed, Aug 27, 2025 at 11:13:13AM +0800, Yu Kuai wrote:
>> This is fixed by:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=block-6.17&id=d14469ed7c00314fe8957b2841bda329e4eaf4ab
> 
> Great, thanks!  Looking forward to this landing in linux-next (since
> it showed up in my automated linux-next testing laght night).

Sorry about that, the patch was queued for linux-next on my end on Monday.
Surprised it isn't there already - in any case, it will be soon.

-- 
Jens Axboe

