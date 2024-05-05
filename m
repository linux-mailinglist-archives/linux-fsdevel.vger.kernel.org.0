Return-Path: <linux-fsdevel+bounces-18764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC1B8BC2D6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 19:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9371C20E52
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF358ACC;
	Sun,  5 May 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZSmH6zb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5734084D
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714930288; cv=none; b=V7uMddGrJbd4fj7DyvJmyO2OtmPuA8oJTS98QiuK91hnBdWuI+cyTJWv5hkgU2+gSoL2U4Op+mSgo/xr6B5SfhLAW5PIeJu4nefIWgWoMm9/8aLVEbpYD2sLos+XyaPmI3d2RIkbhNXvicUCoJKbTudkI2H/bN3MJ7H4JAh90zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714930288; c=relaxed/simple;
	bh=Xp6I8FdY/0gKMh+YqcCCNneHVsMFWZdpSaQbd9ikMJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKEvyPUJ+Qkc4E/dcifzQmUVdi3xBYbWBJKcjQmxD+P3pnpc0WQUeFkeVNnQcZOK+j7ZPZicajgb+VH+QHhDENNHtJ14OWb8gXzRlpxnh2kIOy+4XXjuTQrF89QA+dRjtQm+C/OL97qw4PKktdnzMpPB7kVV8CRCguXAk507mjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZSmH6zb3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b27e960016so352854a91.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714930285; x=1715535085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Cs+A1U1SHJpevw+hi+Q4AcgLtXTFmWGtCKoa+YyyIA=;
        b=ZSmH6zb3X3WKFaYL2luJdgLRdJClSGZYwg56A5vwYjctCPSItYiPlQ8HKWBG2dMHFM
         cI65hIq0JsZwivBD7eCnN/HDqdLwcSocNAbGJEUhhh3pN0QxjIXN7TBpmNs0+F5U0A9d
         4yzfkZ7XGrjRrDsi76R4SLxguZnnM38VSaj2U0SJ5cHhHwarrE4QE2u1DgZtGc6rqe8U
         4YJwbx0sqzuoDzGOdBCDHEUIS5ZlelDqTfWZ0Hn+xNoitvcqLTqyZaJ6+aY8xBvpbVwu
         iev8y9zV6aKW3kjILTLCZEY5vogjK8uVMmzPt8TvLucPiw+Wy82NhFsqfFbl+m+Nu8Ka
         o8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714930285; x=1715535085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cs+A1U1SHJpevw+hi+Q4AcgLtXTFmWGtCKoa+YyyIA=;
        b=nfTGgmKMaKXeng92gqO0Fm2bDCChdkrKZHCoNGWI7Sco4Uu+bedc5pJ/Qn09fn/ET2
         X+Xy/Xxx4RJcPcKKpXYvoO6wiuhTE5sJvLhBY4BsbDgbQdqz7sGnYr6D8sEEiYMMmXSx
         NEEANY9s5SNs6aNS00647sHWnPaAJs2/Prk/rUs5FUzQRR/ltWxi++9vr4irWtO/hGN2
         rDWMZ0//6HUemqehX/OEbNykzJFzCfVWuq3CZNK5WBiZxen4xtxR6IuUVtR3DMJ47Ama
         q7AY+r+DDFS1NqIM5WsXkQwZdBDdO1BsdAgVfc3Q6HfdkAq96tOewWkMNNXqUrwVlyDL
         LNFA==
X-Forwarded-Encrypted: i=1; AJvYcCWpUpFFwXv9zQwSY8Cl8Yy3WlrALiXS3K+DJk677cHwG6vQLf4W82T52rCoy1wwGzmKt8ISPrE6mEuHEaQtBdyyrgQavLvSGnHymNIbwQ==
X-Gm-Message-State: AOJu0YwY3Ikce4lADYy5n1FuQvTjnhBekw23x6xMVY3LWkiaijzrxaTe
	l0TzOH55oTugoTiv3LwYkcnvcai75dUbM7ayaO9jiBSYBvG7Xf0LRLpTnRdDf+c=
X-Google-Smtp-Source: AGHT+IERglgqIQlQxZGy92cwbJYDFAAfOzd8bI+FwSdGNO4w8zW6pBYTMU1wp8NYvmMLo28t69VtUg==
X-Received: by 2002:a05:6a20:841e:b0:1af:667c:466a with SMTP id c30-20020a056a20841e00b001af667c466amr10398624pzd.4.1714930285042;
        Sun, 05 May 2024 10:31:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id ca29-20020a056a02069d00b00624e9960bb7sm1014794pgb.91.2024.05.05.10.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 10:31:24 -0700 (PDT)
Message-ID: <a64eb06c-199b-45ef-94eb-c2ae620669a0@kernel.dk>
Date: Sun, 5 May 2024 11:31:22 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Linus Torvalds <torvalds@linux-foundation.org>, keescook@chromium.org
Cc: brauner@kernel.org, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, jack@suse.cz,
 laura@labbott.name, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 minhquangbui99@gmail.com, sumit.semwal@linaro.org,
 syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
References: <202405031110.6F47982593@keescook>
 <20240503211129.679762-2-torvalds@linux-foundation.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240503211129.679762-2-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 3:11 PM, Linus Torvalds wrote:
> epoll is a mess, and does various invalid things in the name of
> performance.
> 
> Let's try to rein it in a bit. Something like this, perhaps?
> 
> Not-yet-signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> This is entirely untested, thus the "Not-yet-signed-off-by".  But I
> think this may be kind of the right path forward. 
> 
> I suspect the ->poll() call is the main case that matters, but there are
> other places where eventpoll just looks up the file pointer without then
> being very careful about it.  The sock_from_file(epi->ffd.file) uses in
> particular should probably also use this to look up the file. 
> 
> Comments?

FWIW, I agree that epoll is the odd one out and there's no reason NOT to
close this gap, regardless of how safe we currently think the existing
usage is.

I've done some basic testing with this - both to verify it fixes the
actual issue at hand (it does, crashes trivially without it), and
networking/pipe based epoll usage and no ill effects observed. Also
passes all ltp test cases as well, but I was less concerned about that
side.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


