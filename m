Return-Path: <linux-fsdevel+bounces-18766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DDD8BC2FD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB302817D8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21E6CDD0;
	Sun,  5 May 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w4/h85cP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62375FDA5
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714932287; cv=none; b=EGxovP84EmHEslQU3gWQpF4dKlbTwlSNZgBjm7lWKHc4018VzlmNDg1TLqILpnh/tSOGuEe1VTvmZRqxz/y/LkhBK5sCyr2xZx5P9BMNwapN0c00JVAGhaCsj6TOsW4Gc5rmEktTZ9Bb6Lct9a1qe6vfOLP/0sg4Ufr2O7fmtSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714932287; c=relaxed/simple;
	bh=MvgFEIdHJtRnDvyKBZhufXdImvNjTp+dD0weVzheZjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9+jCNyBonbOT2ufUK4yqOSMGY3Kf2GFrIh6ROU+vS68idfRFsHwsTSepwAL1+e/weSHvtbGW90QWwIcf4iInwFCinkJW/99lZWvNNU4TV3BsmwqHnHJtbxZjzkbg4O+FTABk0W88PafQQD/N78Pw8YeJq7in8pDM42tNeML3GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w4/h85cP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ec400f9afdso3523615ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714932283; x=1715537083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mE6ET/wemNoj1wnsoN5H46vn2H9jFrdPiFfXm3O1q/E=;
        b=w4/h85cPoz9JrKVApFfzhwqyTk3hafzehD2XG7NNtSIJkUN6u2EfIyUUtNpf9SG2yL
         W6rdALus2jNJXXvwjvuJ2YTV3zYJdblncEoF1uPLQnao+u8nh1XX1PhOUsQmFsR14I4W
         MC1Umr7tv0fgbJv1+sUuAzexxKG8j0Uj6G57/BMOdrmG69VYAhAmV/BbzdpOTlDReEkf
         mJx+YNH5SKRZWCOs6stpErBvVEiEsfx7qfzIwwNWCG07N+gsyJtt+usEjJaQFxA8kU3P
         lZftFf0JTUkH9nuom4Fw3Va4yeUEtyb+U356wx0/ujdiep7C/KvDYPIRxp/cZcrzb9Hy
         bvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714932283; x=1715537083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE6ET/wemNoj1wnsoN5H46vn2H9jFrdPiFfXm3O1q/E=;
        b=iLMtbOLbrLkSMOTZp85WG9otLatkCBNFsSe4vWqTPttsWG7u7ZwHQm0Bk7WvszIsvK
         gBRg0WBuQWZ+cKoAoBtw9M0ANPdx7YRghGxLOU9s2UEExTvLs1TUkMh3ZMqDepAmEBPj
         hqSeh0COkr1QAVRvTIlrfh0rM3iFzBmYzQbthbrWjB8+nldKNHC3mDMmbXKQyVDoGn3F
         dCT5AllJUagiPg91clo4465rSG9f6R7UXARs5CijD4ev0fq4vDGf85EqryIhWYs/D3I/
         C2YlriAuwZ2w8qojv1NKvhxu5KN3n51/9T66Ue+ntzmGdBFfg+H62v3Uc+G4mBsRXCgr
         e8IA==
X-Forwarded-Encrypted: i=1; AJvYcCXEWzv9qyjoQmpTKUj9fN9steMwELIdassuUSgztS6mZyWrNw+qkaE5fCxKE1a4HNWJV+rjO7eWHbL2+OzXDT1qwT9dI43s16SPGXrXFg==
X-Gm-Message-State: AOJu0YyLtm8UyYrD9XjmJCkKXRTkuiRy86H1ycZSexgO6UoycUBGVpxV
	4yb/VYK0LELQTtoOKJXnyebJ8EWECmTPILTeky+33LA/iMZcpw0Gb7pPWs/tIyw=
X-Google-Smtp-Source: AGHT+IGWjfUE/TDqZn5+tc9zv5WMH1AwiF3VlKR+EV8RVaOEHMWP8GFvz9bqpeX6sGO+oAr45ebqrg==
X-Received: by 2002:a17:902:d2d0:b0:1e8:4063:6ded with SMTP id n16-20020a170902d2d000b001e840636dedmr11260813plc.1.1714932282996;
        Sun, 05 May 2024 11:04:42 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b001eb03a2bb0asm6700128plh.53.2024.05.05.11.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 11:04:42 -0700 (PDT)
Message-ID: <be4fe24b-daa4-40af-806b-40db570e37b2@kernel.dk>
Date: Sun, 5 May 2024 12:04:40 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] epoll: be better about file lifetimes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, jack@suse.cz,
 keescook@chromium.org, laura@labbott.name, linaro-mm-sig@lists.linaro.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, minhquangbui99@gmail.com,
 sumit.semwal@linaro.org,
 syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <CAHk-=wgMzzfPwKc=8yBdXwSkxoZMZroTCiLZTYESYD3BC_7rhQ@mail.gmail.com>
 <20240505175556.1213266-2-torvalds@linux-foundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240505175556.1213266-2-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/24 11:55 AM, Linus Torvalds wrote:
> epoll can call out to vfs_poll() with a file pointer that may race with
> the last 'fput()'. That would make f_count go down to zero, and while
> the ep->mtx locking means that the resulting file pointer tear-down will
> be blocked until the poll returns, it means that f_count is already
> dead, and any use of it won't actually get a reference to the file any
> more: it's dead regardless.
> 
> Make sure we have a valid ref on the file pointer before we call down to
> vfs_poll() from the epoll routines.
> 
> Link: https://lore.kernel.org/lkml/0000000000002d631f0615918f1e@google.com/
> Reported-by: syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> Changes since v1:
> 
>  - add Link, Reported-by, and Jens' reviewed-by. And sign off on it
>    because it looks fine to me and we have some testing now.
> 
>  - move epi_fget() closer to the user
> 
>  - more comments about the background
> 
>  - remove the rcu_read_lock(), with the comment explaining why it's not
>    needed
> 
>  - note about returning zero rather than something like EPOLLERR|POLLHUP
>    for a file that is going away

I did look at that 0 return as well and agreed this is the right choice,
but adding the comment is a good idea.

Anyway, patch still looks fine to me. I'd word wrap the comment section
above epi_fget() wider, but that's just a stylistic choice...

-- 
Jens Axboe


