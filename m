Return-Path: <linux-fsdevel+bounces-30911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1B98F9AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 00:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8991C216E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 22:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97201CB514;
	Thu,  3 Oct 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zacgglKi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33561C6F72
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 22:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993542; cv=none; b=NPj/I2A+hnbgtKwr/d8g1UrjjF54iLUTk4Pz2ohP2nJvZAxKSru+X3qJW7tFuSCUvutnn/f5ppo4tZP+VFO4Qg0HpAkTFH/2+G9L237X19C1Nojaoto8UzaW9cCk6xxsuhNHj5Az4EhD9l7vom27zrf0NsbBTZWnrzXffqtwc6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993542; c=relaxed/simple;
	bh=a4AdcKeTt6iaLudMXKCs6XY/L4nNm6MTDCdJdND06qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INrAauKhpwXmWPrQTzYyt6IDmBnOEvWO6QAXaG/XTlxv/giRDafhXRTsvelLQbgrHoCKeUVP1rTCPBI2AMkYfgh0KTBJrcuRUQYxQQ38ve4HpR/N8nn0ZVAdpubTZucHnuXjPILErBIDiD+yqAc/8OcsEsfDDDfSfk/HJ75CSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zacgglKi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e192a2fe6cso1159563a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727993540; x=1728598340; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UARFeoyZ3rHdhvutpLeLbLmTRofuJ6iiIPq0QcY6Mv0=;
        b=zacgglKiYJGuf0ENXqIZ5DDH9Nz12vqIFrXaW55eGEAzYfPcs4K3DvTM4kwg18kG6G
         S1T/aoJTFWqAYvZoXr/Jl9UwEDfOIWJCx+/G6kXjJQeIeBZ3IPIRKuUZaBUbkY88PV0/
         WxBN38JrclDQ1jJ+g4bI+5b5A663x+0g5+asfMLMGPlz9FMhGYcsqmoVNA6bVFZP1qub
         1atKNKKiz80nubs81sL8oFKPE11R+cbApwOine+ah06WV9x3XJMSdXFKGSCHutKylw4l
         8J/vKzhXTXHcJKiF3JazdZFkCGakUL+lCeMGapf1xgSUTjc9M5FFX5WRQke0XKUKb2u1
         y5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993540; x=1728598340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UARFeoyZ3rHdhvutpLeLbLmTRofuJ6iiIPq0QcY6Mv0=;
        b=GxcSGdEwru+lhkKiI8O8T3Jb83BE5oVsamSOqsiGh541JeOBceBxs6llJS1usweUu3
         qiAicvygy9eSeYhucX1OQEehfu2Zf/99egWwx2z/DGjjg/1Ayi0yyem41rpgIl//uXAd
         bKYzwfA6D9ivxtGUzXDHSnlrYpZPIxj5UzHI11smVZsF4ovQOXAq8aphzcMCOOOpiLbg
         FdAdNkif1Ye4/n8RZdQYJtmJXV0ulorMfDQ8fXeO5tSwaGoAZZ9V8nJE5djQOcD1VzZX
         635SZBI5+beIiohnSfVnNTRIvcV2342OmVxizzctUQdGxSe/hHP5yMHG+90hrfXQvjpZ
         TCeg==
X-Forwarded-Encrypted: i=1; AJvYcCUbKrZOHxgZFi4nAZ9/OBtiLh2Y4lhYqX9fDjtMlQ7CgUUXPaYGBOdc8AynQjpmzxMqLJhdTsRDPOZ6fvB9@vger.kernel.org
X-Gm-Message-State: AOJu0YyLCsD1/brbXh0Gsux8Vdxe1k+yEZImIK9URus5F1Zgzn0O5eNU
	UfXMFGUfEhAl300GqBYlfrTy2Cc2NGDS+6/yygcObbKxVwPmSzEwvFRkVd41lEI=
X-Google-Smtp-Source: AGHT+IHM56HG+I+buxx/PP0Ki+OL0sze0gS4TyHVsLh+P56KL+AQukx5RNv5DEf6lEpdxcaFxOgK0g==
X-Received: by 2002:a17:90b:3796:b0:2e0:8bf4:f298 with SMTP id 98e67ed59e1d1-2e1e5dcf9b1mr686996a91.0.1727993540193;
        Thu, 03 Oct 2024 15:12:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86abbc6sm4335a91.50.2024.10.03.15.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:12:19 -0700 (PDT)
Message-ID: <09db3e2a-8f39-4ac3-ab7b-a2c8addabc77@kernel.dk>
Date: Thu, 3 Oct 2024 16:12:16 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
 brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
 <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
 <20241002151344.GA20364@lst.de>
 <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com>
 <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
 <a8b6c57f-88fa-4af0-8a1a-d6a2f2ca8493@acm.org>
 <20241003125516.GC17031@lst.de> <Zv8RQLES1LJtDsKC@kbusch-mbp>
 <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <abd54d3a-3a5e-4ddc-9716-f6899512a3a4@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/24 4:00 PM, Bart Van Assche wrote:
> On 10/3/24 2:48 PM, Keith Busch wrote:
>> The only "bonus" I have is not repeatedly explaining why people can't
>> use h/w features the way they want.
> 
> Hi Keith,
> 
> Although that's a fair argument, what are the use cases for this patch
> series? Filesystems in the kernel? Filesystems implemented in user
> space? Perhaps something else?
> 
> This patch series adds new a new user space interface for passing hints
> to storage devices (in io_uring). As we all know such interfaces are
> hard to remove once these have been added.

It's a _hint_, I'm not sure how many times that has to be stated. The
kernel is free to ignore it, and in the future, it may very well do
that. We already had fcntl interfaces for streams, in the same vein, and
we yanked those in the sense that they ended up doing _nothing_. Did
things break because of that? Of course not. This is no different.

> We don't need new user space interfaces to support FDP for filesystems
> in the kernel.
> 
> For filesystems implemented in user space, would using NVMe pass-through
> be a viable approach? With this approach, no new user space interfaces
> have to be added.
> 
> I'm wondering how to unblock FDP users without adding a new
> controversial mechanism in the kernel.

pass-through already works, obviously - this is more about adding a
viable real interface for it. If it's a feature that is in devices AND
customers want to use, then pointing them at pass-through is a cop-out.

-- 
Jens Axboe

