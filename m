Return-Path: <linux-fsdevel+bounces-40227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A1A20AB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA04167C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAF1A2544;
	Tue, 28 Jan 2025 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OKUl7Q1q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C291A00F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068177; cv=none; b=R04oFbnbgP6hKVUMC4/36Dipajr72n9ETeumhkzysRX+Rx4AF9QD5K8XbKryYITWMjz2GMgsH9F5bMmPd+II89q7QAV6EKaeBnE4GM0dlFDIyssFgJ7F2UHT+VC1aQP27JDwXnfC2+PfHxjqrRMScq0OBpd6+okWlaUClKFEABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068177; c=relaxed/simple;
	bh=i4Ih4yOsCitMuKZsbd4LjFylOAQUX1g8j4CPdMxyPDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0Xmh4aqUHDvqbT665SA1ntRV53Eav21GG3EqiyQKtDaSZPCON05Ryfmjtd/TXtPOv1ZdKfZVyQ089HdoUODFqo4NTX1JMMOvxdLCgfZ7Fldh9HXmDEvhHbvFm8NGtxMr2LSy8jOXiYjNhjg3hVTKxmS5Gass+ppj6pYvc3Q+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OKUl7Q1q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd1b895541so112953056d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738068174; x=1738672974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Hjz/HBikG9/lKNWOcgvjSfQzXvtdwqalUBjRJ0K+I=;
        b=OKUl7Q1qkBRpl6L88ox9Yk92wtAsOuVo5IayOUU/hzGVgf3Rjjecryl2WT1lZFfS+E
         35FcxVpBKuvDaSdC7AJdwWVFVzBNhQqmFJAiwmz0BfFiNYgIRVTYuRuHS49codimYGWh
         YOqM3wAb0i8y6dAuFhqKpLnsBaAxtDrfuqFOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738068174; x=1738672974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9Hjz/HBikG9/lKNWOcgvjSfQzXvtdwqalUBjRJ0K+I=;
        b=o/uSOwzefuoQOOHxcNjaY29LRkSUTVFv8AMM+XaSTKzc5mxJhpAGIv6TfatWBNjKgE
         3BIS9HwPwxNmrnW69g732msLCuWJ1E6hEHdj+2kaB3V2Jc8EZxfTr1wAZ0Adq79LXBP0
         jfDi5D79HOo2o/xdwXq7ee/djfWIVEu9ZsTEjHZmYW8eFoFFRMOC9rxEq7JX8LbgnJf6
         JfEplnmGPdKkS0chuIxsli19V1NidzXgs8VC62zZ15watR66RrjJcUTAvElCkRTMZJH1
         MccdpSWfQP2/aPbMukKg5+9H3FfxoIS1av5ZAGfLM8xvrstjd23F4okyGvf2tfKyDvUO
         t2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnwXTgfyzxzOWsri1+G5SrCjr9HVhm/dtGI5/HXxmHW1+F3gGv0cJyCSakm59+hGdjYYHCn9jCmsXGClSS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6CemPb8EBjHFcQBVj71uyCvDH6hWckJLXuLBhN4KWReXnqzV
	ACTmE0TiwijBQrOR1JoXzuHLfXBdR//0DS7pn2b+Y/N5gDTWUKVHkkGfEPmiHUOQRRG1Jplf1lb
	gW/K+EiVPaKE9AHRMj9UyCXP8VDS7HltMZwr7Bw==
X-Gm-Gg: ASbGncsoVc7LAJaDpbYK0GOhUm5h4uVWdIjAEpTMr2Sm0WuZccdvqo9mlWLnonrx0/4
	xekVnQWTQFl+xJyvopSNDFCUlXehg3Zi6Lqt4K/dJTe2ftS/ziefwUfNDrtl8B0wbm+zZF18=
X-Google-Smtp-Source: AGHT+IFHqb1dD1KZwsa+gpNM1NJUXqlXL4Uhb8XNRH7U63qw4cN6AM1D6ndQnVoLZlpWFWSgCzZ1R+5zN2z1g9INqw8=
X-Received: by 2002:a05:6214:590a:b0:6d4:22d4:f5b0 with SMTP id
 6a1803df08f44-6e1b220a5abmr649661266d6.33.1738068174227; Tue, 28 Jan 2025
 04:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com> <2041942.usQuhbGJ8B@xev>
In-Reply-To: <2041942.usQuhbGJ8B@xev>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 13:42:43 +0100
X-Gm-Features: AWEUYZncrMihch-xJFLSWbspT9bam0hgksBqzvIpiATyQ_1noZ-r1ZsPAgPon9U
Message-ID: <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: russell@coker.com.au
Cc: Miklos Szeredi <mszeredi@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jan 2025 at 02:17, Russell Coker <russell@coker.com.au> wrote:

> What's the benefit in watching mount being separate from watching a namespace
> mount?

1)
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN,
AT_FDCWD, "/proc/self/ns/mnt");

This notifies on mount and unmount events in the current mount namespace.

2)
fanotify_mark(fan, FAN_MARK_ADD | FAN_MARK_MOUNT, FAN_OPEN, AT_FDCWD,
"/proc/self/ns/mnt");

This notifies on open events within the nsfs mount (proc uses a kernel
private nsfs mount, so all accesses through proc will trigger this).

The latter doesn't really make sense (these files are not openable),
but it's doable with current kernels and events on the failed opens do
get generated.

So overloading FILE__WATCH_MOUNT might work, but it is also very
confusing, since watching a mount namespace and watching a mount mean
completely different things.

Thanks,
Miklos

