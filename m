Return-Path: <linux-fsdevel+bounces-20551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7108D5106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 19:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91461F23EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CF045BF9;
	Thu, 30 May 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iC2aOt45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E78D433C2
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090129; cv=none; b=iqgg43pmxdF30Q+aQQfXShmuHiHsCRAkjpOSt32JEqEpXmZYK06WfJzQRqKaWcLgMl/UdJHj+FGDzodl1ytbD4HJKevogCH/ngFWc+61XxLZlaOvAmRPMsU3iiz+UPwXsdwm6tdWXF5dHrFHzPKJyA6+cJYRwOOzmbBeSQvG93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090129; c=relaxed/simple;
	bh=2lPnRGCabtvLAsqan6zBE8Cs4Xij9m2S35HQuAAGOXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfHk9FlANPGKYsGNF1XPS+z601IFjq0xftHZYP8vpbS2xxJeJrUhrF5cqQ/wpi3YJYPsq1936XEcnl4iZPfps0MaSt0h2UxxvtuKfolcS9HNNZ3xSAUDeTJsHk0c0DI5JKBpmdi5yEiY4uQ1/P9UQ0vj/C8Irz2GM90uYsZ7KZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iC2aOt45; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c9bcd57524so106336b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717090127; x=1717694927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7B6fY/Fjz7QmAOYRBLWDUgsv4maBPzpvLfJEUMOCdE=;
        b=iC2aOt45DiBt1i5iLb9B8MQagCGBQMLF6lWhUoazsIZMQCeirBh+0gx5RBKHjtsA0E
         Amu2iq8B0euJfTw3/Vx61dKuLXC0cu6eR7Ih7dyLuVqghe37psUKFiM4iR7jH6lXlac/
         gYCqkBria7xLDTKr8IzzjxTkq7JFgSxP7813uQYE3w3+ALrr8jzhv4Q6TtPgcroIZZ1M
         3XkrBpEzs4bx3tcLyre0udnUUprihrZBoD3O20v8M0ffrR9PSs0qwksSUideW2G8hNj9
         s4zj89epbJjTjjTy+qrkXg1JEnHX1D94azf+iA/wFC4duNqJrjfAK2BzFr3FMpP1v/to
         7CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717090127; x=1717694927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7B6fY/Fjz7QmAOYRBLWDUgsv4maBPzpvLfJEUMOCdE=;
        b=YR/CpaKG/mvy6WDzOi4ZPEPxaoMJb5IxzRV5F6Ou8dr7EWC9JoWH9TLmGppByj2dAb
         errlo8KQnapU5UUBmYWSDIryjgsmrv+zWeMPy2WnDqq3W/67ULQqxZkYDZB4m8IjSdZU
         sOOb5JzDhacXuQnP9k+D9kBxu1/kPq2uFECbsOpNxvp25Q+dsFvlOoW0CSf6TpmSLwtD
         m2ZKBSAz+RLYkpPXzteFlP45nXGlNa+K6GbY715AajH1bqN4Vs97o3BFrj9HzQ1Gmube
         m7v9GZUFDt1HzDvXKRCGfDr5kybeKUKaiNKqfgcil+N2tcDJTGLC4XSg9UR+0nqj77Z5
         DYjw==
X-Forwarded-Encrypted: i=1; AJvYcCWv2Pm96lCgUN27CWzXmMvRXsAaI5AGl8cyHcCaf0XQ4n4CsXpaCivsPokbSLLCeBIzCEuY5dU9Lqg0/+coz61pA9Z6FCzFd7X7HURlYQ==
X-Gm-Message-State: AOJu0Yz7qspwFLEN/qOWj3IAebFMidzFEfSn4F7dtgSBTeM0FPBQWOfl
	f1sW8VvnvIf8YQOVM+g3PNVLgB9EyrssCR9/V/2vxCmoeQf6DDP/MHh1/s+E7tc=
X-Google-Smtp-Source: AGHT+IEHT9XTg52xPtEdpxEcEsqX1knua+mi9ziTWOWwL12bZiZ68gB1TKYCLWuHZfBOwir9FouWNQ==
X-Received: by 2002:a05:6808:308a:b0:3c8:4cc6:4f0c with SMTP id 5614622812f47-3d1dcd40887mr3101730b6e.5.1717090125759;
        Thu, 30 May 2024 10:28:45 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1e19da2desm26747b6e.8.2024.05.30.10.28.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:28:45 -0700 (PDT)
Message-ID: <360b1a11-252d-48d9-a680-eda879b676a5@kernel.dk>
Date: Thu, 30 May 2024 11:28:43 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/19] fuse: fuse-over-io-uring
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Bernd Schubert <bschubert@ddn.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrei Vagin <avagin@google.com>, io-uring@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <5mimjjxul2sc2g7x6pttnit46pbw3astwj2giqfr4xayp63el2@fb5bgtiavwgv>
 <8c3548a9-3b15-49c4-9e38-68d81433144a@fastmail.fm>
 <9db5fc0c-cce5-4d01-af60-f28f55c3aa99@kernel.dk>
 <tpdo6jfuhouew6stoy7y7sy5dvzphetqic2tzf74c47vr7s5qi@c5ttwxatvwbi>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tpdo6jfuhouew6stoy7y7sy5dvzphetqic2tzf74c47vr7s5qi@c5ttwxatvwbi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 11:16 AM, Kent Overstreet wrote:
> On Thu, May 30, 2024 at 10:21:19AM -0600, Jens Axboe wrote:
>> On 5/30/24 10:02 AM, Bernd Schubert wrote:
>>> From our side, a customer has pointed out security concerns for io-uring. 
>>
>> That's just bs and fud these days.
> 
> You have a history of being less than responsive with bug reports, and
> this sort of attitude is not the attitude of a responsible maintainer.

Ok... That's a bold claim. We actually tend to bug reports quickly and
get them resolved in a timely manner. Maybe I've been less responsive on
a bug report from you, but that's usually because the emails turn out
like this one, with odd and unwarranted claims. Not taking the bait.

If you're referring to the file reference and umount issue, yes I do
very much want to get that one resolved. I do have patches for that, but
was never quite happy with them. As it isn't a stability or safety
concern, and not a practical concern outside of the test case in
question, it hasn't been super high on the radar unfortunately.

> From what I've seen those concerns were well founded, so if you want to
> be taking seriously I'd be talking about what was done to address them
> instead of namecalling.

I have addressed it several times in the past. tldr is that yeah the
initial history of io_uring wasn't great, due to some unfortunate
initial design choices (mostly around async worker setup and
identities). Those have since been rectified, and the code base is
stable and solid these days.

-- 
Jens Axboe


