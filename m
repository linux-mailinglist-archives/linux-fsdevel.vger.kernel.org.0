Return-Path: <linux-fsdevel+bounces-17875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1571B8B335B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC538284391
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5F813D291;
	Fri, 26 Apr 2024 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rWsqqCr+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2A413A3E2
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714121548; cv=none; b=pkX0C6jZipFA8z794WIXCpnYK+fZ3yZOFl0KbNgpQr7Z/IIPqmukTss0lQ/tN9Zhztph0zRLeQbEtB94I8xgCTBebne9sFAX9wsShky5vHBHQ0xcZE1iI2DWd00ApVOvIBk87F0P0UmS7mup+5L/EoG8AP5fZmi4QVSnwsDW7qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714121548; c=relaxed/simple;
	bh=8d8ZoRzxM6PBtUjZL3c7tjnRzbqJejNO/8ZEK0WIKz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViQse8F2S9B3YwdqGivfB3IdK2xpNvU0YwJJkW0Pcpi4MHQVbM/GFbaX3rUfZMvkPbinT+09E4K6lgk/KioyuyVoGDC2mWDiyoynfkWs9R4tx5mk7ceSoxe1ap79dzvApOODszC04eoAzRKdPyfAI5G9BW0ZVXxAd9Sl3IhRWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rWsqqCr+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572347c2c16so2362516a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1714121543; x=1714726343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0fkv6wWFTNWgEz6ll78Ca4JYk3GwPYplTEZ0oHg/fHE=;
        b=rWsqqCr+CYOKUHjUSkO4JNdHW/yTk21yJcVk41dPDXoLW1ROzKdJGlw04FpUw++t8A
         Au2Ezb3b9FYiW2CjLemrIrkUIFuyvAM8QIch59yn6t2dV+1m8lj2rqMWSbMWbjWyVhj9
         KXeIULb5CDnE7FtxlE7jUIMSMJBsz+mK6A7nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714121543; x=1714726343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fkv6wWFTNWgEz6ll78Ca4JYk3GwPYplTEZ0oHg/fHE=;
        b=u/3b45dXYMFQaTXgJ5quabWK1bs6CWbxCn8ohid12gUYcU3Wyfz4mf4JL38rG8iGOZ
         RtjsFHMK4flwow3n+zAMs2NEr7DjazzNmaD/heChch4YLMhlh8mwt0rDHaTFgASxRRl9
         z5JfeeZdQgSPYqZiEJ/P9C+lKKLcrpSXAa0JnwbFxIPL1sVvTXTjOODnJvL07ksaJzgR
         +Cd7O1VtHFopkbfw2Fz9wWoUy53iNK2D7JGluQfnT5/R0BvvCHEMEBy6OyEVW9uK40nj
         O+l/TYDBRXf4am77etMaPus2dpdbBeytyMCLBlsn9PvcuVQe9Em1TbGii9zwc5OSeW9m
         38kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFqAwu9MC3joe78tUZmX2fykl2SijhumaJXMZQa+6JLnebdb4El9xdx1aTc/ogOt/j4vjI04JFHDgx8nGx/1YUvCke4cwWZOA72QcYBQ==
X-Gm-Message-State: AOJu0Yx7CB28XTO4ixbFDGnxlcAjOH4NE/IkzWQ9/D3Fwgmhuq/YpZvF
	lMre6WTCq053wRvs/5Gs9jVMquuv3xG3HOllvvUkNNkyOpclH1dSYffHqyFewK2P1JuVi0Zu2l6
	huYwf3iidC7TH4KT8ssebfAG9H0Cz9nUL6vvS82AeYdlb1xMr
X-Google-Smtp-Source: AGHT+IEzP+AnWzynmp0hKyqC2hgOWDa1A0KY4hC1oNymjtmEhVnsP0y31ok+p9bIEgYqfWxVu5r3tW/ToS8ZNibN3pg=
X-Received: by 2002:a17:906:378d:b0:a52:1770:965 with SMTP id
 n13-20020a170906378d00b00a5217700965mr1385843ejc.42.1714121543195; Fri, 26
 Apr 2024 01:52:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b946a20-5e8a-497e-96ef-f7b1e037edcb@infinite-source.de>
 <ff9b490d-421f-4092-8497-84f545a47e6a@infinite-source.de> <1db87cbf-0465-4226-81a8-3b288d6f47e4@spawn.link>
 <f7c97360-8f5e-45f4-876c-3dcbf9522a3a@infinite-source.de> <032cfe2c-a595-4371-a70b-f6d208974b0f@spawn.link>
 <f764ac09-bd84-41f0-847b-bc89016a4613@infinite-source.de> <aaabfbe6-2c61-46dc-ab82-b8d555f30238@spawn.link>
 <58766a27-e6ff-4d73-a7aa-625f3aa5f7d3@infinite-source.de> <CAJfpegv1K-sF6rq-jXGJX12+K38PwvQNsGTP-H64K5a2tkxiPA@mail.gmail.com>
 <9f991dcc-8921-434c-90f2-30dd0e5ec5bc@spawn.link> <CAJfpegsJ47o=KwvW6KQV5byo7OtmUys9jh-xtzhvR6u8RAD=aA@mail.gmail.com>
 <692a9f0b-9c2b-4850-b8bc-48f09fe41762@infinite-source.de> <d862407f-640a-4fa0-833d-c2fa35eff119@infinite-source.de>
In-Reply-To: <d862407f-640a-4fa0-833d-c2fa35eff119@infinite-source.de>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 26 Apr 2024 10:52:11 +0200
Message-ID: <CAJfpegsCJi5fZOhbWGht9vcoBKRxF8RmvmEao0cBqXDv4hn+ow@mail.gmail.com>
Subject: Re: EBADF returned from close() by FUSE
To: The 8472 <kernel@infinite-source.de>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 23:38, The 8472 <kernel@infinite-source.de> wrote:

> In some places we do rely on error codes having exactly the documented meaning
> and no other. E.g. fcntl(..., F_GETFD) failing with EBADF is treated as fatal,
> other codes are not.
> Or openat(..., O_NOFOLLOW | O_DIRECTORY) returning ENOTDIR is trusted to mean
> that the file is in fact not a directory and can be unlinked instead of rmdir'd

There are lot of assumptions from applications.  Fuse won't and can't
check them all.  This applies to error codes as well.

> Current Rust versions unwind if closedir() is not successful since
> directories aren't writable and aren't expected to have writeback
> errors. That's what lead to this thread.

Is that bad?  I mean can that lead to a security breach?  If not, then
it's not interesting, lets just fix the bad filesystem.

> If that had returned an EIO that would have been annoying but
> would clearly point at unreliable storage. If it returns
> EBADF that is more concerning because it could be a double-close or
> something similar within the process clobbering FDs.

So the worst thing that can happen is that a bad fuse filesystem is
able to confuse the user of an application, believing the application
is at fault when in fact it's the filesystem that's acting up?

> So if linux implements its fuse client in a way that propagates arbitrary
> error codes to syscalls for which the linux-specific documentation says that only
> a certain set of error codes with specific meanings would be returned then
> either the documentation is wrong or those errors should be mangled before
> they bubble up to the syscall.

Man pages do not say that the error list is exhaustive.  Other error
codes are almost always possible even without fuse.

Thanks,
Miklos

