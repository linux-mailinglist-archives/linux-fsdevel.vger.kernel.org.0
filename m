Return-Path: <linux-fsdevel+bounces-38304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D89FF198
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 20:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB616265C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3281B0422;
	Tue, 31 Dec 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QelWW9Fp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861571A2C0B
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735673920; cv=none; b=jTCAeiUq0mYWy7idTl+MkbMdEXKOW/YjLvzuXFk4KzaDUG4VVOe2Ls4ek+a5GvXReZBRcCtZ3WaxvFkfbc751u2LcZk6iYr7L/k5HTcAKQRttgGcBcxhMsBZubooRpgY222VGbKlERNrnEAllVB0uiCTZAlr4ki6O4kGiF3j5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735673920; c=relaxed/simple;
	bh=S6SHi/u4tc00nXT9iEVnJsQvTdlaIbqdZrdUu8oFXp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGcejO2PrfDNIzybRxSL6C5/lUwHmZ7fbUdcYDsj0ed/eZ14mttM/7V9cX9CItJUgP85ECkdDc+LYO7juDQAQtN9r9uGSWH5Thg1FROx8OkRHrb63SVXV4kwYsPfEUkLa/PEEBSMkXEcVnq7Ngkdn5snqtBuL7c/ov9SYdfwjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QelWW9Fp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa6a618981eso1692593266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 11:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735673916; x=1736278716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sdJcAYSET8NoDs3C+Yvx1lUTBNZCtlSJkdQ7vJDaRmg=;
        b=QelWW9FpBoN8wteoLOZKfiK6qZZBgdIUQwPq1Bbh8ZeoidjiRxdmdNYBFJM5nb/0vk
         Rn14Rof9DP2ny3L/c8NMbU7nLNi0Jj/umnxclO2X41e94tfRdYOQ3DeKfwcx44L7chcc
         oXrLm32zkjBaM9YtKAkPGLOMMchloxXriP+2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735673916; x=1736278716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdJcAYSET8NoDs3C+Yvx1lUTBNZCtlSJkdQ7vJDaRmg=;
        b=ld2e8vXgDHeRdAHv20lOI/wqwktxcDoYoxFDbxOf5W+mgebOhKLIUbaz2nikXoDjSW
         vuMN1tqDpcJ9Vrjd0L89/3UjbWIb9WLXjMWtvtw1E3kJTP7Csj7BcCKRXG5Ay8xZcXNj
         8/Y6khsy2s+FUtH/fXKLInafYw48CSOjspvK6RRR3/sz+4JUpK2xKhdXhI0PRcx+nCXP
         j3eRrFfuR7PMbzk93ltW9uVt381wDaNdEOFR6t2qCvYVUYNHU1XfJMCpFTcekupG3gDj
         knb1q5QCvXYGC/iftfCIpjJqNNFWr+2+5hn6D0+HZEhIktITeb4BB+ULQONzcjyi2qJJ
         DDgA==
X-Forwarded-Encrypted: i=1; AJvYcCWDMT2DuJ9AmN5IougcIG1mC+ZZbJMSAEVwFbll+P2n4nwI8HTG+kSbdoL+CHjRCJdVG99R4ww2Ewnpu/+D@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoUCOrWmDY8q4k/NZufuEM/jHwq4poMc5MJHVCtKLKmtvTSce
	ghNn8PdG1HupTZFvThiY3H+JxXmD9SV/eTitiNIjJiWaxZS9MppuGOwiJl33ImiExVuYZ9l/wYX
	ZCPM=
X-Gm-Gg: ASbGncsJiw2+VMArlwKb1UEaVH4XXl80VCbsFEzWk0IenEeOUzUQ12KZN6TjkVGcSRW
	waWl+OFdl5XSSWTdvnhM2RMacDEeiFf7RWCGMCGOfDTywXtu1sNDDk+qfE85hemTX4+DbVosrSc
	xArtKdyLfgICXnU5KtMsZUw86qX2HkiABt0tM1BNepImrewiX9lSGFeI0M/vjCthl7AWGO8gNZW
	GhZR6LNV4rGL2G8+bMkabv3nOXudlEnl0mnd8tbxN8m8jfz2zKPvO8aCdw58+1jYv/c4XI64G2Y
	+LP+QlX+XGj2VMrkqQG6F+Zg/vTRhqw=
X-Google-Smtp-Source: AGHT+IHHI2xv8xOaoZuJVpv6qmz6XCYvKagu2/kBHsv9TVUU7BBGZTbsRJX/xtzsw1dVAzDfiJUfOw==
X-Received: by 2002:a17:907:96a4:b0:aab:7507:7a94 with SMTP id a640c23a62f3a-aac2ad84badmr3759982266b.16.1735673916567;
        Tue, 31 Dec 2024 11:38:36 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a49fsm16199438a12.15.2024.12.31.11.38.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 11:38:35 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso549022166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 11:38:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY/RzgkM6DWMlN2+fk5lFSXq4DzBcwAaiSj++VQFsMe3x1QxbfNUk9rCqHeeSh0vIWM0U70fAuhwfihqzQ@vger.kernel.org
X-Received: by 2002:a17:907:360b:b0:a99:f6ee:1ee3 with SMTP id
 a640c23a62f3a-aac334f624amr4462682666b.43.1735673914276; Tue, 31 Dec 2024
 11:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230153844.GA15134@redhat.com> <20241231111428.5510-1-manfred@colorfullife.com>
In-Reply-To: <20241231111428.5510-1-manfred@colorfullife.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Dec 2024 11:38:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjST86WXn2FRYuL7WVqwvdtXPmmsKKCuJviepeSP2=LPg@mail.gmail.com>
Message-ID: <CAHk-=wjST86WXn2FRYuL7WVqwvdtXPmmsKKCuJviepeSP2=LPg@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Oleg Nesterov <oleg@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 1vier1@web.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Dec 2024 at 03:14, Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Should we add the missing memory barriers and switch to
> wait_queue_active() in front of all wakeup calls?

If we *really* want to optimize this, we could even get rid of the
memory barrier at least on x86, because

 (a) mutex_unlock() is a full memory barrier on x86 (it involves a
locked cmpxchg)

 (b) the condition is always set inside the locked region

 (c) the wakeup is after releasing the lock

but this is architecture-specific (ie "mutex_unlock()" is not
*guaranteed* to be a memory barrier (ie on other architectures it
might be only a release barrier).

We have "smp_mb__after_atomic()" and "smp_mb__after_spinlock()", but
we don't have a "smp_mb__after_mutex_unlock()".

So we'd have to add a new helper or config option.

Anyway, I'm perfectly happy to get these optimizations, but because of
historical trouble in this area, I want any patches to be very clearly
documented.

Oleg's patch to only wake up writers when readers have actually opened
up a slot may not make any actual difference (because readers in
*practice* always do big reads), but I like it because it feels
obviously correct and doesn't have any locking or memory ordering
subtleties (and actually makes the logic more logical and
straightforward).

                Linus

