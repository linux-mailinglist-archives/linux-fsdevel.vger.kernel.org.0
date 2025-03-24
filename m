Return-Path: <linux-fsdevel+bounces-44926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7AA6E678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 23:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A790C18961B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 22:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E11EEA33;
	Mon, 24 Mar 2025 22:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jUG+VDmU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA519D897
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854551; cv=none; b=QiuHgE4fQxya2hkB4Y4LAQwU1DeyMZiOCZR8JqWYIWyOwYX6UojUG0+p9gD0oBZfpubZd7r05oLIbrEQVkdrnZX0UMu3djFSsAxRgXWTQzDiAxUaAC6UluekxRzk3Ax/f4wIvDO9495EjMmqCKNbmxHnrqk25IDDfizfCLiV6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854551; c=relaxed/simple;
	bh=e/r4Zlp/KHSwdvwEkIA042d1FAjKutPhBALAVYylnJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKMO2WWYWCMkqzjsaOIowtoNGtGYykynjaWX5C/LfIqxBEvI7OuqmaHHh00aARH7bgpUewVfd8tl/9Xpyy0IH279kNeaq1X9n6lNHnEI+1YoWwI6pnR1HNVkXfpl1HdhbPoIxxZL7Ons4MvQVyQ4az73sgKJCcdQNNSlxKSTu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jUG+VDmU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso21438116d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Mar 2025 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742854547; x=1743459347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqCK4xrieYy8rHSMdxk0HMnzbYnnEsVe7CVfVt5N210=;
        b=jUG+VDmUNoV0CH8XZxglb+ZpiOmq6NTrnjn+9mGZk00XjGehUgWMMLN+rYUWvYx6NP
         l1kPyDiDtgYgjAW4sUcyJ3caT0rHiDGn8RnmDz1dUvUqqP5ju7kFmVHCstGnWI3FmmKT
         NMFuXGPjwDhRL6/+YQ4cMEQkFghCjC9vpI1kY7omXtgKRck8SuW52gdq/wydMlsyJBJs
         6LM6SMGIXqKJjJGCosKlBwNNTBHM9fSw91zKT0V6Rl+wpnTzal9Cz0xfpB+T7RLG76+Q
         Q5bUxTO1kDqkIuXYubFDC8b20zipg2RXfzctIMfshfQJ9bPxJKdKfm5tAw/UsykCwE3I
         2Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854547; x=1743459347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqCK4xrieYy8rHSMdxk0HMnzbYnnEsVe7CVfVt5N210=;
        b=E0DxuMgKYOoIqtGcBfpeWVcqeiFB2yQIcf5CiDh3uEEmyDa6CJh9eUJyUOXLt4jLuD
         EZfpCi9ik46b3Sxo4z+wAJLs+8BKfe48qfrsNen/szmMSIFR83r5auUwlcpZoRRCLx9o
         CrJd0kzraOKd+wHIYOML7zP//6eB5reKtJITH7BeW1S4md3wSZlSXXoPeIQMO1HwFMUW
         THUfqqE+Qd3Lki1ISolkPDANPDmBA0rPSQVtsbkHKEhd6gxfU55DTL8VtpD65iWPtA8y
         DgB9ed4NFfy6P8t0JsTf+aqn13qyHpn+5ijt45Z7aOalPq+EWq/YPNkZ6WlD12fSRaKz
         7jTA==
X-Forwarded-Encrypted: i=1; AJvYcCWhypQTusER6yeMfMVnwUEiZ2Sa+uprj17jyC4ZZnwEIFiRtnKDOO4/3sT6cXP7WtYbV/wF+Lnp+rDP4kPS@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVOFvjmTeL9tkEl8ev91sXZ3qx4gc8BmQzJUgb4/g210d7hz/
	qtgl6cCjiecYO/xu80enLZ5oVnBNvFgknfFBtXcZUoqXLMgtAaaFPf59uTehivtjQadVVf1K2Co
	NKxU=
X-Gm-Gg: ASbGncu2e83YyV5PMhQzmmIc+I166CXYHTLWd5bSDc4ZhuTsf+zaXH4opAM3/sRV0Ng
	9kENewjRGECdmg41FWJsdkU8yABtlWLUsGr3R6FkTKKZBIMGvZEiRKABy+oPgRD8gg46g0gtYz+
	ASQugPTeGoYLBnsLEP9XgJPjby5Pi8/znxZ9QloFpMek4/mst2SufnB+FPV7iqMHhlIvfpW7etP
	OtpSI5/MPT1ib4XhNO3yvqBC5nhoVaFNC3sOyKh6UsSM9ZVD1kYfpNlOEpm65i1A5dLfrvyAKRj
	A3b1w9W8tgHymdyZnPal8Gnn/yojNM3U/1h22LgWpuJOHs8qXw==
X-Google-Smtp-Source: AGHT+IEQMqkj+FtpcZxgGtU488+dXoq+VgOKiN+59B24M1O2EfiLKvd38B84Qx7Els7TCQbDEjBbUQ==
X-Received: by 2002:a05:6214:f65:b0:6ea:face:e33f with SMTP id 6a1803df08f44-6eb3f2bad2emr231217546d6.3.1742854547178;
        Mon, 24 Mar 2025 15:15:47 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f51esm49592736d6.26.2025.03.24.15.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:15:46 -0700 (PDT)
Message-ID: <fc0f1f19-f7e6-45d8-abff-a98305ce5bb7@kernel.dk>
Date: Mon, 24 Mar 2025 16:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/for-next 1/3] pipe: Move pipe wakeup helpers out of
 splice
To: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
 hch@infradead.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-2-jdamato@fastly.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250322203558.206411-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 2:35 PM, Joe Damato wrote:
> Splice code has helpers to wakeup pipe readers and writers. Move these
> helpers out of splice, rename them from "wakeup_pipe_*" to
> "pipe_wakeup_*" and update call sites in splice.

This looks good to me, as it's moving the code to where it belongs.
One minor note:

> +void pipe_wakeup_readers(struct pipe_inode_info *pipe)
> +{
> +	smp_mb();
> +	if (waitqueue_active(&pipe->rd_wait))
> +		wake_up_interruptible(&pipe->rd_wait);
> +	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> +}
> +
> +void pipe_wakeup_writers(struct pipe_inode_info *pipe)
> +{
> +	smp_mb();
> +	if (waitqueue_active(&pipe->wr_wait))
> +		wake_up_interruptible(&pipe->wr_wait);
> +	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> +}

Both of these really should use wq_has_sleeper() - not related to your
change, as it makes more sense to keep the code while moving it. But
just spotted it while looking at it, just a note for the future... In
any case:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

