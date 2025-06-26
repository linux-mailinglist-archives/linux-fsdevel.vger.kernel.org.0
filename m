Return-Path: <linux-fsdevel+bounces-53047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E26AE9455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 04:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052541C41E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F751F12E9;
	Thu, 26 Jun 2025 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPQfaBWE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CE224F6;
	Thu, 26 Jun 2025 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905746; cv=none; b=T4OUixTJqmQur2yeT9EJL4pDzEz44aBp/Qr2mXYQZztYuRqNOveArjU74Uqih0evGnCJ9jI1egC02wzsrg9PVHaFmKfldtbdu6vrJ0OgxGBHoNBtxLnZhRrrZ2sKR2UIacMejVVNg1QP1J1HK2xe0/ZMnuSwryp4Oi9h8XeoyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905746; c=relaxed/simple;
	bh=od6P6pmOSXxNT727X5ed5nqh/+UXRwgTwbz0gpLU9MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY5DwyacTgnCI8HtFEVMRzC0DzNg8DhvcD+9Qm5wl9rEjPdOJwwuYWRhAVbN3wQ8+imn7T6CNqyiCIg99JWV784j0s0I7vLfBKC4B4HWHKTvOFX19qznFiI7/9R2y/l932Av1NKEApbyDX9HbAAx5aMgl1Uq6zAR0xb5mYVK6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPQfaBWE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d412988b14so53158385a.3;
        Wed, 25 Jun 2025 19:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750905744; x=1751510544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=od6P6pmOSXxNT727X5ed5nqh/+UXRwgTwbz0gpLU9MQ=;
        b=bPQfaBWEmiYT075vpsvayhgbkldu7kh5H84jRZtMAEc2TOgzESLihptGUyA7vAukd4
         ZAg1Lu/dS4nxDs/8HRHXWyBIgqWL3k/9i3wcZgTKWd/UICKuW1hMfoRAES7hQedXi8Z2
         L51ojSsdvEyE+eTryIW5HOgOyt8uywUPz8B5jaXz7imb7MvjDYZWmmuqe5MPMsr1HSoC
         pSJKKllCmXmYwk86uMqCEW5qft+RVaCd5VUEazBxvq438U488RAk3lZV+9fpN1URg/Yi
         7My/a5Jv0ts9Jrsn1z582PsCWGeCwjllsZWgo+SqmkpPlhJLKn8a0CpVM+pdUdfRqxsc
         Bkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750905744; x=1751510544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=od6P6pmOSXxNT727X5ed5nqh/+UXRwgTwbz0gpLU9MQ=;
        b=BwLKVsERe5TnIhe0MSjOC5d/UHGQQXM76I0x0oDA8ZLI/ms/2rTtQ/KORcd/nLV8uy
         4/eNtCpPprieDaR0DwdZ5c9lBLaLrqVQLGq+sdOmD+q6jo6rEOY9R+ceNMhVOq7qNURK
         Dgdz+9DZl0GextdoauUrW8KEYz0iC+PWEC27YwGwk6LT/zq6QHZG91ZG/TkyT+h7bpfs
         2Icy28267GERctm48vsBNxyEmxuKgdjPAHRtq3UN/bKz6yiTRgW2Jk77umo475/SUb6j
         Db4qio1YI0pMTBiKOxU3UkNQRKBe1wmVZsL/fibXdUYUDf5y3RIepUmsua56rspo8nU7
         4R7w==
X-Forwarded-Encrypted: i=1; AJvYcCUbqYaezGl2yxstNRsoUP+ultkI5vn1lI3nwLky2ic7rMsDRIVdLj6iW/QiM7WZE9vZ1ASmv7FNjxewhWIV@vger.kernel.org, AJvYcCWiEAowxCRMKT3ccL2BmGPu8wa61/qzptbdsa6WCfv8S5p1lrhOSSZ4z+FB0J6AoiT5CQ+tpvt6YtmrHs5m@vger.kernel.org, AJvYcCWtkJB0OXvKkZwLhu58Vit3vVUpuyUY1Ox0k5tivZBGs2NjXrNgtgeZxUvbAg+6Bvn3Pt3HQg36BZSz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmj1lz+GFt290SuVHIcFLVxktkxCiVok5wVKj0sa9kyuUcsSrq
	w1Q5NJWv4EBRH2TCFfS6bQPovJB5lyKq+FHA24qC4baT2rin6MbKlx55yv/IRWDTqTkEyg2ubV8
	/E/tePAXcgIGzWQGZ2rozMsXytyk5cy0=
X-Gm-Gg: ASbGncsJcW5G9jD19BqwYHVk60VTwRwKYp3ynT1QpKyzctT90Cwk5W6050DhGk5QGkg
	5S5PSwDjjzq6k4xjC+yfsuCljeF5Y5xIzyF+Yweo2W5MwKsp7B6VsSADGZXOgi7FyJBK9gp0L44
	gnxeb2bup3uSlLXpGa9Xw09mahOH/A+eGuJgPdC6hK+si4
X-Google-Smtp-Source: AGHT+IESVy3V/n5VkLw86F20P5j1fnT7XdSirSPKlNbvL+IPuoLHuUJiiWnuFFgJTKm0pqp4XqQwdE2Y+JeaDXYNWNE=
X-Received: by 2002:a05:620a:6844:b0:7d0:9c51:498a with SMTP id
 af79cd13be357-7d4296d2f5amr667522985a.13.1750905743658; Wed, 25 Jun 2025
 19:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFqyyUk9lO5mSguL@infradead.org> <51cc5d2e-b7b1-4e48-9a8c-d6563bbc5e2d@gmail.com>
 <aFuezjrRG4L5dumV@infradead.org> <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org> <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
 <aFvkAIg4pAeCO3PN@infradead.org> <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
In-Reply-To: <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 26 Jun 2025 10:41:47 +0800
X-Gm-Features: Ac12FXwGQp7NN8Rq2OfqUZAlxy-GMLdddRaKYMN-0KtPUqnI-UrmaksSbjAnY6U
Message-ID: <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
To: Jeff Layton <jlayton@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, david@fromorbit.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, yc1082463@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 10:06=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Wed, 2025-06-25 at 04:56 -0700, Christoph Hellwig wrote:
> > On Wed, Jun 25, 2025 at 07:49:31AM -0400, Jeff Layton wrote:
> > > Another idea: add a new generic ioctl() that checks for writeback
> > > errors without syncing anything. That would be fairly simple to do an=
d
> > > sounds like it would be useful, but I'd want to hear a better
> > > description of the use-case before we did anything like that.

As you mentioned earlier, calling fsync()/fdatasync() after every
write() blocks the thread, degrading performance=E2=80=94especially on HDDs=
.
However, this isn=E2=80=99t the main issue in practice.
The real problem is that users typically don=E2=80=99t understand "writebac=
k
errors". If you warn them, "You should call fsync() because writeback
errors might occur," their response will likely be: "What the hell is
a writeback error?"

For example, our users (a big data platform) demanded that we
immediately shut down the filesystem upon writeback errors. These
users are algorithm analysts who write Python/Java UDFs for custom
logic=E2=80=94often involving temporary disk writes followed by reads to pa=
ss
data downstream. Yet, most have no idea how these underlying processes
work.

> >
> > That's what I mean with my above proposal, except that I though of an
> > fcntl or syscall and not an ioctl.
>
> Yeah, a fcntl() would be reasonable, I think.
>
> For a syscall, I guess we could add an fsync2() which just adds a flags
> field. Then add a FSYNC_JUSTCHECK flag that makes it just check for
> errors and return.
>
> Personally, I like the fcntl() idea better for this, but maybe we have
> other uses for a fsync2().

What do you expect users to do with this new fcntl() or fsync2()? Call
fsync2() after every write()? That would still require massive
application refactoring.

Writeback errors are fundamentally bugs in the filesystem/block
layer/driver stack. It makes no sense to expose kernel implementation
flaws to userspace, forcing developers to compensate for kernel-level
issues with additional syscalls.

Most users neither have the patience nor should they need to
understand the deepest intricacies of Linux kernel internals. The
proper fix should happen in the kernel=E2=80=94not by pushing workarounds o=
nto
applications.

--=20
Regards
Yafang

