Return-Path: <linux-fsdevel+bounces-63494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 612A3BBE347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A3704E2B16
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B5C2C375E;
	Mon,  6 Oct 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boEiDFdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCF2D2491
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758312; cv=none; b=oIbe4v061wru3YYCyrlJqog0J91vM1UfIcFsDVCQzXz05vZcpIhC+msSFZO2eqy4SDvPpSCfnC/NhDjHCYB0tlzNJHeFsh1IA7jF7DETp4kP9EOjgQ0XIxJTvzFFZYkA24otFF6SGJn7TnFW7HfBbalNctRCSTby/+U6WAXUzWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758312; c=relaxed/simple;
	bh=gY7Cn0R4j+C/xwAHqXy0vJMKwmEkQ6eYzuuBQMAJA+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQGNRCtXTHC2FpIvh86/HoE6bCNF3MPzN16ZzTjmNGvuXE8XMjE5jN2hiJh384Q+JU6sQAFoD5PEuKwzbXDZlnAcyN7up5+gyS2/pTh7dfBQRGJGtPSaBzHMj+/ayVWdr2oxZPKSk8lSAxoFBjtshck62JoeUQ/Ltmz/loffnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boEiDFdW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72e565bf2f0so55211677b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759758310; x=1760363110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Dd+0F85GMq0hM6baKNKYaOpWODHWFkc8dJOJcvzgTI=;
        b=boEiDFdWZHHln+EkAvNcsacP54pU8mzHIPHWgfL7/u1lHux/xLTXhnVlptnMYuJYrg
         Q6qWxtE9qPavVUN7Yx9s4/QnvZGZdMO7iw3LVYTfXUsbX66b0gXMvJsaFoJ9TMFAb/wt
         I+RT9MsR2Dn/gPZfdo7cdnKo8fV0SoTiGJUgeQtdp7xtDCMbdEMDEGJL+hwUQZWynGyK
         H59SeYbA5eb1CeKfpoPnkcIV24oSNyIS4VB5J6jkthUkIcqDn2zVfZnvjMpJZvvKd/iT
         MFSTrFbPEXdQ7sv8mhvbm9uidDh7TrFvXASoEfEYNyrrMU30kLSxH+wTxBlr7cTiiXhp
         sczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758310; x=1760363110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Dd+0F85GMq0hM6baKNKYaOpWODHWFkc8dJOJcvzgTI=;
        b=mkjYhG0eUOVQVAKZ/dnmRASraNjjSP03w1ZtsIYRxUyZBbiVaM8zAo+dFXOXxADlkO
         /lhX1+PSq233DwUZ6aNJa4yJqxjO2qKLe1OV5MnfE20lughXc1M3bAOEkZcwC+mkeh/7
         //C4f3j5ratDCKwO8jpPEsY5HlJ8J4F734NnDqMMswSEuZ9XZy/VjUw5FPUw5i++94zA
         Y3f3T2OkUGEA4mAhmCmuH1hNuuMlUxHY1EBPHmxAvPI658qGKoXu5Wh6L9WyZXQ4ERHz
         tsrDltM0PX8O1Nm6CFjaXtYnnznLDE6hzRNIlCZOMmHfg4ULQQHU/U4L37ApRJ3oOcKA
         Clvg==
X-Forwarded-Encrypted: i=1; AJvYcCXux5yIMTPwLJdvLTK+HIOspMIJj4Ro8BouLRI56CCVSl1jX8xmv4a4qqerc2JXBUx9mWxDZSsZHiW4cZ2n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SW9ZxGjfIQhGttJEUyKUHwhw0lJGHy2wZHgH/njz9tCezYUu
	e8OC2Gy02pVy0JWrqPiTxcCIWj11/ljMpwTXz0OgplzSCaXeSZwww+MiNwRtT+MyNuwUF15jwJw
	AHzZ+5Ra7ybC5H26yqqyvuu+X0xHAuRah8Q==
X-Gm-Gg: ASbGncvhvZkzN+JqBEnFJSvHBCBJ4OeQKugq952sBiaFpgMQH4Ykz6ctTfO4vzC1C3i
	1f4V+fKL8B0R0/hedZu76fnOGX93iHZkqOTQsbGlGaUiAQyFfgpk90UFLHrR3nraFnO7oF0cXMx
	ugHf17DhdIfN+kUkprBqeMB3jwWLmLsnEogY7pY7aWQ+QpV0iY7CSqLKj5nVWgw9SKKAm80xPe/
	+G41wlmSa6UZZzBEcSAWHmZQSq6ma80byGVyCAu+dx948mqJR1s9CHrYKsWBH/QYw==
X-Google-Smtp-Source: AGHT+IHQwe+SGELlw17QoqUaDR48CNJzbFKCXDf24eF0PDCKb0qGt1k9M3lm6p2y0fByz0S88DfeYE4HF56d4946CUA=
X-Received: by 2002:a53:ba44:0:b0:636:5ea:a88a with SMTP id
 956f58d0204a3-63b9a0ddd2cmr8692889d50.32.1759758309634; Mon, 06 Oct 2025
 06:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006103852.506614-1-luca.boccassi@gmail.com>
 <2hg43wshc3iklydtwx25ulqadzyuldkyi6wylgztzwendi5zhw@kw223cxay7qn>
 <CAMw=ZnR6QMNevxtxWysqi5UkDmbD68Ge=R5cVAxskqtmhb5m5A@mail.gmail.com>
 <bywtfrezkfevzz7y2ecq4w75nfjhz2qqu2cugwl3ml57jlom5k@b5bebz4f24sd>
 <CAMw=ZnSZmW=BFbLLSKsn7sze-FXZroQw6o4eJU9675VmGjzDRw@mail.gmail.com>
 <rleqiwn4mquteybmica3jwilel3mbmaww5p3wr7ju7tfj2d6wt@g6rliisekp2e>
 <CAMw=ZnTDw59GqW-kQkf1aTEHgmBRzcD0z9Rk+wpE_REEmaEJBw@mail.gmail.com> <2025-10-06-brief-vague-spines-berms-pzthvt@cyphar.com>
In-Reply-To: <2025-10-06-brief-vague-spines-berms-pzthvt@cyphar.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 6 Oct 2025 14:44:58 +0100
X-Gm-Features: AS18NWDRQ4-uECnyKD_NRVG1xEcLayj4FX-gUnSa68oTI5fxVqr5Z_z4LyCUsx4
Message-ID: <CAMw=ZnQki4YR24CfYJMAEWEAQ63yYer-YzSAeH+xFA-fNth-XQ@mail.gmail.com>
Subject: Re: [PATCH] man/man2/move_mount.2: document EINVAL on multiple instances
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 14:41, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2025-10-06, Luca Boccassi <luca.boccassi@gmail.com> wrote:
> > On Mon, 6 Oct 2025 at 12:57, Alejandro Colomar <alx@kernel.org> wrote:
> > >
> > > Hi Luca,
> > >
> > > On Mon, Oct 06, 2025 at 12:46:41PM +0100, Luca Boccassi wrote:
> > > > > > > >  .TP
> > > > > > > > +.B EINVAL
> > > > > > > > +The source mount is already mounted somewhere else. Clone it via
> > > > > [...]
> > > > > > > > +.BR open_tree (2)
> > > > > > > > +with
> > > > > > > > +.B \%OPEN_TREE_CLONE
> > > > > > > > +and use that as the source instead (since Linux 6.15).
> > > > > > >
> > > > > > > The parenthetical in that position makes it unclear if you're saying
> > > > > > > that one should use open_tree(2) with OPEN_TREE_CLONE since Linux 6.15,
> > > > > > > or if you're saying that this error can happen since that version.
> > > > > > > Would you mind clarifying?  I think if you mean that the error can
> > > > > > > happen since Linux 6.15, we could make it part of the paragraph tag, as
> > > > > > > in unshare(2).
> > > > > >
> > > > > > I meant the former, the error is always there, but OPEN_TREE_CLONE can
> > > > > > be used since 6.15 to avoid it. Sent v2 with this and the other fix,
> > > > > > thanks for the prompt review.
> > > > >
> > > > > Hmmm, I see.  Why not use open_tree(2) and OPEN_TREE_CLONE before 6.15?
> > > > > The syscall and flag existed, AFAICS.  I think we should clarify --at
> > > > > least in the commit message--, why that version is important.
> > > >
> > > > It was just not supported at all, so it would still fail with EINVAL
> > > > before 6.15 even with the clone.
> > >
> > > Thanks!  What's the exact commit (or set of commits) that changed this?
> > > That would be useful for the commit message.
> > >
> > > > Would you like me to send a v3 or would you prefer to amend the commit
> > > > message yourself?
> > >
> > > I can amend myself.
> >
> > Sorry, I am not a kernel dev so I do not know where it was introduced
> > exactly, and quickly skimming the commits list doesn't immediately
> > reveal anything. I only know that by testing it, it works on 6.15 and
> > fails earlier.
>
> If I'm understanding the new error entry correctly, this might be commit
> c5c12f871a30 ("fs: create detached mounts from detached mounts"), but
> Christian can probably verify that.
>
> Just to double check that I understand this new error explanation -- the
> issue is that you had a file descriptor that you thought was a detached
> mount object but it was actually attached at some point, and the
> suggestion is to create a new detached bind-mount to use with
> move_mount(2)? Do you really get EINVAL in that case or does this move
> the mount?

Almost - the use case is that I prep an image as a detached mount, and
then I want to apply it multiple times, without having to reopen it
again and again. If I just do 'move_mount()' multiple times, the
second one returns EINVAL. From 6.15, I can do open_tree with
OPEN_TREE_CLONE before applying with move_mount, and everything works.

