Return-Path: <linux-fsdevel+bounces-35948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFF39DA088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 03:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8666516822E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0441EB44;
	Wed, 27 Nov 2024 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="royk/s+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176988C07
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 02:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732673100; cv=none; b=Ooe9nDEKOpijMFr46Cm+v3ubB5C3/KqJ9bmj/3NHA4PNaD+11wAO+JaJ1SNr4JJcPJhDmLzbXJb7Fo6x6GIiCErQ/d5oZrG0vO+hYWxALKghrGNVE7Y0pGT+ARvlJ/8/hdieJF5sggEmDZK2y6vMD1wesynohnKnBZkaDe3+rp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732673100; c=relaxed/simple;
	bh=pz0PoGBG2TGLIXRoEcAfk0ZkUBn2JaHe2n9085ZKIsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xln8MVazqDrhlx6mNvPGXPAIzfG8/yqJa5u1HTsb6MiAlbHFHO4wMVRyRxnN2biZmcyE7zy4ZPsbsc07zBsYASVsIeIxEU2j3EhFBUuxNE9ucNGXDgZRGtZjxbMNCQKM5gijB9FAGq2nW/m3Nybg4QXgJudNj2SLBh+/9d9IBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=royk/s+X; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f8b01bd40dso265885a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 18:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732673097; x=1733277897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TA2XgJnVXroms6cNVBPKOD3KfOJvAZhMOjIEuQSGkcw=;
        b=royk/s+XZhH770hfX6OuZBrBhqRe8HDU1acVmZpqOlE8zfGP/GJkIVYnWG3Oe3CZmU
         QH582yTbJa3TETrOplh6RROErEBaBDAl2kZJtbBOSGw5/69VPu8/7mLrIp4P3MYBHKe5
         KwBvER16MGaFjZ/xi5WbAOYGVJgJbDlYfA9U2LyyoUGFam0JdmUxGoSmb8Zgw/tE6hyG
         jCDU7DNakDheZbRkx7bg3/osMNIyf5CUP/XwZ+VNwHkwl6egDlcrCN+MaYj/n3mbPkHM
         871hLoZqTqzAnQRw17wbs7WAbuYllKQyEDEUm7ICAX0n9kgr00KSuZWFAW9D/88kgnEF
         5zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732673097; x=1733277897;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA2XgJnVXroms6cNVBPKOD3KfOJvAZhMOjIEuQSGkcw=;
        b=rw8wzyMQTrH0LDr6nj7zbNuT+XEOqS5fkbXYT3acWdUEtZm8Ar9xIW8c85xhqwjJsp
         EfvHzDr7bZfOjEzDrR5I4KBt3u35yHX/qxBjkjVPStEvSUyUtjNIoVS9CoOZNdklvPCG
         JuftqXoLjjfE66/y9wNX//bv/msf+hmIUAYDkdEhS0cgTKRpq0+OYFyJFJ+yMhO966pn
         /L6mG5OKk/+9dzd8UPzFjdLz+uQrr1wAj648KQr2nz3zcgRa4Lm9bMXaYaZIJJer6dUL
         eW680gOtrkREXwVI9/1Hg55dZaDXiX0VYEBIVIrBDL880Qgeuwd3RkS7aby/2Hg2D/rS
         lnnw==
X-Forwarded-Encrypted: i=1; AJvYcCU7r0JfdIXK6OMOT17zWMW6+jjqpDBR5OCKCBNS0c2mWnNsIPPOQD1+Ar369taUjuJfn3lU6/FmwcXoOo5I@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4lz7F2hLJTeAb6EN6FYxFj3HxbKWzWP1iN5L/xYaQRlQwrqa
	SgwtrhOelLgneBqg6zTI5T/j9UGu0k7KXWvoyg8exWMlArTy6gTwmlNIgpKkZKs=
X-Gm-Gg: ASbGnctRqg+L+fBLPODKH2+cP6SlpOg3unptEgrgnXPXp23SwIJb1xe2LbulWx9KWTv
	/x6t1a2M4NRVgOOdBUgqfSjrNmCJUv+XmRI57TbhpfjhBB2/7jB1Eisc6fJaCYpWkZl1e+GaCE1
	zU+b55/1v3OEZvvQZQRJizjsopzsym5mmTVLj22Fw2fSuH/w4dAyRWr3fsZaVJzVffK24lOQdHJ
	DSQ8FO8CAvXO4x6xx3lX7TU9lkaehTYbfggKm/a0N8qv2A=
X-Google-Smtp-Source: AGHT+IEGSLqkMoJQGCv7cJWbao7CN0MoMuj6jSO+T2QaJBisPZrRmSvgzRxmvtyW+14IYQvOddsosQ==
X-Received: by 2002:a17:90b:1d03:b0:2ea:4633:1a65 with SMTP id 98e67ed59e1d1-2ee097f5596mr2348297a91.12.1732673097294;
        Tue, 26 Nov 2024 18:04:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa47f90sm261661a91.14.2024.11.26.18.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 18:04:56 -0800 (PST)
Message-ID: <09429155-d611-4c95-9465-f0cc3fbcdf29@kernel.dk>
Date: Tue, 26 Nov 2024 19:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cred: fold get_new_cred_many() into get_cred_many()
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20241126-zaunpfahl-wovon-c3979b990a63@brauner>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241126-zaunpfahl-wovon-c3979b990a63@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 6:22 AM, Christian Brauner wrote:
> There's no need for this to be a separate helper.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


