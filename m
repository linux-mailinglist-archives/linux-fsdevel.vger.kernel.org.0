Return-Path: <linux-fsdevel+bounces-53593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318F8AF0AC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 07:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BF5446953
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 05:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146821F1301;
	Wed,  2 Jul 2025 05:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OIN8OM2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD460B8A
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jul 2025 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751434684; cv=none; b=VuyJIzqAsoiY6Ps6L7y5KM93kemGDFzjlbkM2p/ThE6k/2Eg8qrn3vFFjqP9jdjXtB/KSZA+qCA3B9Qn8DKLIVuS5u5iofk2lbfCgzqqgENrxwZtn6eSSm4p/yJVkpWohXmpSsymFL84MolpHALYgXBzuSftDE7cHCW18xx96nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751434684; c=relaxed/simple;
	bh=b4jYhBLaJVWS8uCLTTvFGVkJv0bteHOKXi+J5IzUiHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/Nm393WgyVTYtvr7nwM/jnVNeCy5oUO4/s02uEebGQW0bj4CG6WRNsjtF5kEGTF1xrxAQ/JMTXVRw21qN2mIG+AaKNVaA07O7mSvzl3gc4u5wmwCNRZRAqka6S7Zsi67FSYjyQiXgKdiaUI6Zw3Zb+8JH5rqiQY/1CNzsqxe6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OIN8OM2L; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a77ffcb795so64164741cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 22:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1751434682; x=1752039482; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XBw4HF7qWDcXJbgwvgqT6jgJQFstUmKnuwkt3nojl78=;
        b=OIN8OM2LvfCfeppp1blKo4zz/zy9cmevcQIaJ35ew16/rePFm5GyPHBvq52DM6O0dQ
         QhMlYrCDozus4YFg6mFJX3h3A2WjGwP2KrqHOzo4TTtll9dn39FfYC5kQ3fuaN/TBSyf
         RxZllTUwZ/orTxmsAsmzxZx+J4CuUxLoTYB2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751434682; x=1752039482;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBw4HF7qWDcXJbgwvgqT6jgJQFstUmKnuwkt3nojl78=;
        b=Yl9Y6qYYIHCfbFWMqmIckcO4AgVo5sBfZjkw/Cr0HCvWsIC/FxkMSAEvBw+aXv2t0G
         J1HSG7gqzfRSzZCcHoJC0YV+c0GDw02tylzICEUhLv7x9YEIFokZFuTkHiflYdgHtqw8
         77DBUpV7YcQUbPU9nvL6h5SUe+b7+RhNj+9Pkizv5QkRu06Euut1CTdwFq5ModTcRAB2
         Soom5AixP9duLVywRe7h82l49fcGLpkTZ1z345jlaKXynrgZk9TCMwAt2SQ+wEEgf/PO
         xvAP6OORH3fRzOjyKoqovXABiXbt6JeWY3ukVoAfrX+9XU7zUbY5BRlEAVOJJAeBd8Cv
         Q7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWym357vc8f9Rgrg7FPHckGA10/tNosvQq4qREaWBXV5jaQxRgW/Yd+Px5cWx0tMJw6D0Y1RROnW/6hTwPw@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdV98C9qANRYcNExt8ssbOhl5QMpSSWzVHf/xqTAUAQjUAVHY
	3T4JdFBEHRHMsp7XLIELAd/1QIlSW8zkU5+PGw8WMnUUjRVBFRtEuYm6xcLM7p9GgG0RQ8Y561O
	rqRS6DzwymxS9O1N1Fm7GrmJtcInTC4/YU0soMZWijg==
X-Gm-Gg: ASbGnctg4Wtxg4YBm8fuDZNgCDPX8E1O22M+tWZFlONbh4hlQ8LBlB7IvFzeFhcelaC
	nfsqU2BwQ80cxWQ9zQSwJg8d7ybHvH4DsZ7O2Wcp/rST/MOR2FlE+PcrafT6Vbv6suKmuGvrmOR
	WuDs0IdFcv971+Zx9DnGkrpUinpbDUPFcY8U85n3G1nwbuKK6o7Sp6w/tOmagkYjhjQOdYIP0Vj
	BaV+HN7eYYx1Fk=
X-Google-Smtp-Source: AGHT+IF8xAcXBcrSYEe9Ba8cdGjOrU848zSeBK/Ng3+OTDZ69YucBQEbh5zW/k8ND8IcNbh6AVxqSBsNCfOLuuhGP7Q=
X-Received: by 2002:a05:622a:1827:b0:4a7:face:ce10 with SMTP id
 d75a77b69052e-4a976a13b4amr29650981cf.31.1751434681962; Tue, 01 Jul 2025
 22:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610045321.4030262-1-senozhatsky@chromium.org> <20250610045321.4030262-2-senozhatsky@chromium.org>
In-Reply-To: <20250610045321.4030262-2-senozhatsky@chromium.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Jul 2025 07:37:51 +0200
X-Gm-Features: Ac12FXzLD6BJxilx6zyt-xoL-NaGTq-9HFVDoqCZzsuZQN3zCETTYbd9SUoGWps
Message-ID: <CAJfpegvVojwCaoTkdGcP_LJT8q-m6_VMyxciKoFFXFVvuDW-SA@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] fuse: use freezable wait in fuse_get_req()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Tomasz Figa <tfiga@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Jun 2025 at 06:53, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Use freezable wait in fuse_get_req() so that it won't block
> the system from entering suspend:
>
>  Freezing user space processes failed after 20.009 seconds
>  Call trace:
>   __switch_to+0xcc/0x168
>   schedule+0x57c/0x1138
>   fuse_get_req+0xd0/0x2b0
>   fuse_simple_request+0x120/0x620
>   fuse_getxattr+0xe4/0x158
>   fuse_xattr_get+0x2c/0x48
>   __vfs_getxattr+0x160/0x1d8
>   get_vfs_caps_from_disk+0x74/0x1a8
>   __audit_inode+0x244/0x4d8
>   user_path_at_empty+0x2e0/0x390
>   __arm64_sys_faccessat+0xdc/0x260
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Applied, thanks.

Miklos

