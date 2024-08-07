Return-Path: <linux-fsdevel+bounces-25213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A520949DC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 04:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB31C223BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC0818FDAB;
	Wed,  7 Aug 2024 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTezE0S7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787181392
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722997808; cv=none; b=kJjJSfV2Pt6IJYyPRlmXXQM0p3dZsrfpa5qFXObTxiC+2tq2IQbFG/pw0SZW9fLyCwGvQpTErGvUwhlCGKLRYXKcyo6s7vvc7HP1egn0eIfyAa1O2QKpgyfguEKJDagtc0P+sq6RHWXL7qQEhZZAIHs88vFtLdb3GOS1TWpwcH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722997808; c=relaxed/simple;
	bh=7wCe+AgwhSEgT7ns0RM//7Xsa2RrPX5qCel6EB1PXfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GY5Zb6BBFC5sNjnO2DH6Fq0sg9OsO92wIt00nPXqj8+Rh0h5KqH0w8v2wz5d21UM4tvooFM54x7Dqyh7fYz+HtwrLBmySEVVAdwl6VU04vynZ7OUkCjJK6TKb6nRfxuxxOfRPbLQ/l+sIy6G4dXyBXQDbrWpKFmniF4Ox5azlxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTezE0S7; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d82eb2c4feso785403eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722997806; x=1723602606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjCsFoZfN2XtUjscWPYM2q0RLu1h6+WoSZv+rHhbW3k=;
        b=XTezE0S7J5yuZj2WGx78H26J26SE/j3epRaFFcRLeZ170hUQBWeANetdhWGIdEYEtQ
         aY/JeNLU8jhmz36ItUP6/OPY5oY8uGehyX3BGwVQ8dV+UjSMotdK+nlFpX/uD35tw6ci
         Gb7fy+KWQs2tvfkweks2VRzee+SuBVJPb8a7PUVCqu9gIMX7t4SGM3ORgBA+FL7rOb15
         sp/CzdsnoC0osNefX5td6h4ZxTyq3tz8O9Ui7V1K52R6tlaU2jpRdaTG5zlg63D3KPPq
         +MmsGjg9snwp5OVBGV5r72tk8ssG3V/mgZMDpVreJ7kOb4Pp58UnjgyZ6jVk/9tQZ5lU
         lpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722997806; x=1723602606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjCsFoZfN2XtUjscWPYM2q0RLu1h6+WoSZv+rHhbW3k=;
        b=d7eN1aWz+qYpnCh7vLnhVCBJb0lA53JmmJTO/BxHb1PP6fncckfqaUQEFKW0nGnP4U
         pAK97Mb4m5M554RELneNiStw2WtuF7lhc4Z/BvDiLKwe206PVmkMSWiqrQl/M3qVDFMn
         k4Tg5wCZyoH+tqNBWPvMAcGTiEIRkU7ZGvBpmD4LX28OrL+4cP0enHa/C+abZHDDasHP
         WnqBvNXbMXRGcI6SNUlI7FY1zCDqB/XY7E5amJxawS1fxC3SYSqc0eKZ8VN8lg8Vg82I
         nZL16wGWtelHjCRSJZ9rvr6/eWXYSxN1eIA7ACkKud9DCFT68VngEBoGJo0Fuyi67IxP
         puqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2lqwKVkjLQ9uR2MCXzIbWq/8FYadOIlKil+CZfJ7gTTtCpTMDNAK3PN9oZ8idG4aVVovVf/xpCEc4ytrU8FdWvg50Ufj4K3Shm6A4qg==
X-Gm-Message-State: AOJu0Yy61+5Vq0TrtM9Vb3ZZ2h1jd2KX3ANtvBZEJn1MSFpSSvfLcHJE
	VaOSYQvUF1BnFWWkSvsHIOd8zjx/Fr/5bFBumCHRSDMRe1Wo74rs97sA+YZSmGLqOr3Uygjb7x7
	EbCB/g8/w9L1IziJ5Fbah1aj+2Cw=
X-Google-Smtp-Source: AGHT+IGHxGl8k8Pw/F3sXIhLkqCZErie0MGkRf4aFOZn5Som0v+qL6uzU+6/YSKfvw3NApp/xAUoNIY0aIrW6WYBQKw=
X-Received: by 2002:a05:6358:6498:b0:1ab:86f1:25bb with SMTP id
 e5c5f4694b2df-1af3bb093acmr2696633455d.27.1722997806183; Tue, 06 Aug 2024
 19:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804080251.21239-1-laoar.shao@gmail.com> <ZrI8YlBhacGFN2Ao@casper.infradead.org>
In-Reply-To: <ZrI8YlBhacGFN2Ao@casper.infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 7 Aug 2024 10:29:29 +0800
Message-ID: <CALOAHbD_uuC=NG9Hn8eqSYRzMqEMgvsaUaRa4s+Hb5YSZDnfAg@mail.gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
To: Matthew Wilcox <willy@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 11:08=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Aug 04, 2024 at 04:02:51PM +0800, Yafang Shao wrote:
> > One solution we're currently exploring is leveraging the preadv2(2)
> > syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS ino=
de
> > lock hung task. This can be illustrated as follows:
> >
> >   retry:
> >       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
> >           sleep(n)
> >           goto retry;
>
> But that's not how you're supposed to use RWF_NOWAIT!  You're supposed
> to try it _once_ in the thread that can't block, then hand the I/O off
> to another thread which _can_ block.  Because that single thread is the
> one which does all the blocking I/O, there's no lock contention.
>
> So this is a kernel workaround for bad application design, and should
> be rejected.

They are different applications, but not different threads within a
single application.

A simple example:

  $ ps -eLo pid,comm
  1 systemd
  2 tail -f /var/log/messages.

In this case, tail is reading /var/log/messages while systemd is
writing to it. Are you suggesting we should forbid `tail -f` on Linux
servers? If you had taken the time to understand what filebeat is
doing, you wouldn't have reached this arbitrary conclusion.

--=20
Regards
Yafang

