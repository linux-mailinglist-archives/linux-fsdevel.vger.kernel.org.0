Return-Path: <linux-fsdevel+bounces-25726-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DA94FA2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4478B215A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 23:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A688198858;
	Mon, 12 Aug 2024 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k92TLkQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06E170A0D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723504738; cv=none; b=ou18Hv67RhfW4egGFwyUMYJR5dmpEXgG8iJ20llg0ZXK9+9080k0m252E+HkghQnG+b09zlkHl8qaqdWQodeOp5iX6S3MCR5Uhs+oImyqUlPBM3NZ5Dz12Gw4aSKAbusYsX1sc2VLWMZvpOYraMpvhs9fC+Re/7vfb9k0AR7KCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723504738; c=relaxed/simple;
	bh=tsyZrCAK/aC/uRYWq5mw7qNdF0yjulzPLJe3RvYzrJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTfmZfTwnuz78j8xlC8Frf3LJE3XW3uiiDev3DGjUsKvDE20tSYDSkFn718qwq9IjZ1bsFgJyAa/DKikVY/u0b9c2kebPsIkOFZELBc4r7NVbVQKbGnKwFAryGzBAvVKVJRm+7PC3J+jdBArhClLLcv97DHXZ3Hp/p4+Y3QdJdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k92TLkQ9; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db18c4927bso2934104b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 16:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723504736; x=1724109536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooN8kDkM1+vG6HKf7SINt07FBCR22ZuWLQcZxnCRgo4=;
        b=k92TLkQ9Z3NT8QBRpmmvsAtkUggSpE7CWMLqKe8GFRts8Yviqqd6mZoxBAh9kjpfGR
         s91K5UGjh0XccenFH+Fjuq3EFhM4UzxJHjNZzaDQ7ZqaBtjW0qoUpVDMyVW2iZ1Hl85a
         axzoAkE0/JPXt5+h/58amt/Mr6VgechSsk8C+vuHcUYLGKO9yTk4i/VJ9fc8sg7iDxQB
         XtjIH+pl3JZgd0yQDyIPPiIMCRiDRIgvPjx2yD1o7KOKRsADwFiykE5FY+MmgiA9TZS2
         pUtcMTWcu2FYyPaXY5h7CoAJTU0bT+5xCZB2/9WEHC56BsKaVPAEHt4EPmbCYQBHDJQw
         ZVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723504736; x=1724109536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ooN8kDkM1+vG6HKf7SINt07FBCR22ZuWLQcZxnCRgo4=;
        b=mxO+lCNBtPrDBYru2liM6Xx6e1GZCDRD3Jt4YKaVV7WAAniWt1Zg7sMkeS0cWJAhCD
         kXAeze+Bo7KHhcI1ChTkCBDViEbiYbZY3mJUH8VIIoaF2ifdVakyKwvSGStjH08EEtLm
         lPregJB3l17R86S5QPr79lSv264Q2DiNVGWYBJYjSO+jiG1fi1YjqMKAeWCTDZVkU3rb
         0mXOAIrGZ1Y951VfC7HKClXynVssrOP4ccNUQqitxs5PSyyQoEkciA/loMpmH87gS3VX
         Pnla8drsrUMnRQeIvU3ZikSPoBeQIreigvsrFX3EAS28mdKuMUkJ5LS8d/lYFVp/GVVT
         CUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmlXntr69Jw7tzhFceQMj404JUmbsn2zZC/TCZyCvf/mU/t/W1OygynnaVl0Ufi4BUEyUH0b9qIT32Zh2F@vger.kernel.org
X-Gm-Message-State: AOJu0YymvpFuYJ1laWoidWosnqd1607FuhEfbimzzrj06x7zHKKRJNeo
	n+O6/5wi9HF6Bc24lUZ0dghB9y8uQWVByGQOaEsK3ERkzKc1Uw9a0s32wli7yTtFxTgfos/1SE6
	Q2Dp+Lw7h242EvVxygmH8EvfKCDvLUQ==
X-Google-Smtp-Source: AGHT+IED3niTdZnzK61z0Bbi46xs0NtBCKiW3ugGi875z0ib7ILr8X/j01TCoSyablHsXGLYc89w9x5WhVeZElXRqiA=
X-Received: by 2002:a05:6808:1990:b0:3d6:363b:eb2 with SMTP id
 5614622812f47-3dd1eee19eamr1877997b6e.33.1723504736473; Mon, 12 Aug 2024
 16:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808190110.3188039-1-joannelkoong@gmail.com> <CALOAHbCOBy66VQVBax4BEnGaadaq3x=8_GSBc2OXJQ1WOntvkw@mail.gmail.com>
In-Reply-To: <CALOAHbCOBy66VQVBax4BEnGaadaq3x=8_GSBc2OXJQ1WOntvkw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 12 Aug 2024 16:18:45 -0700
Message-ID: <CAJnrk1ax+ds9P3Y3X8xbAEN=56KMCLAEfkuWie+7KT=i1wew-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] fuse: add timeout option for requests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 7:33=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Fri, Aug 9, 2024 at 3:02=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> >
> > This patchset adds a timeout option for requests and two dynamically
> > configurable fuse sysctls "default_request_timeout" and "max_request_ti=
meout"
> > for controlling/enforcing timeout behavior system-wide.
> >
> > Existing fuse servers will not be affected unless they explicitly opt i=
nto the
> > timeout.
> >
> > v2: https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joan=
nelkoong@gmail.com/
> > Changes from v2:
> > - Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd=
)
> > - Disarm timer in error handling for fatal interrupt (Yafang)
> > - Clean up do_fuse_request_end (Jingbo)
> > - Add timer for notify retrieve requests
> > - Fix kernel test robot errors for #define no-op functions
> >
> > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joan=
nelkoong@gmail.com/
> > Changes from v1:
> > - Add timeout for background requests
> > - Handle resend race condition
> > - Add sysctls
> >
> >
> > Joanne Koong (2):
> >   fuse: add optional kernel-enforced timeout for requests
> >   fuse: add default_request_timeout and max_request_timeout sysctls
> >
> >  Documentation/admin-guide/sysctl/fs.rst |  17 ++
> >  fs/fuse/Makefile                        |   2 +-
> >  fs/fuse/dev.c                           | 197 +++++++++++++++++++++++-
> >  fs/fuse/fuse_i.h                        |  30 ++++
> >  fs/fuse/inode.c                         |  24 +++
> >  fs/fuse/sysctl.c                        |  42 +++++
> >  6 files changed, 303 insertions(+), 9 deletions(-)
> >  create mode 100644 fs/fuse/sysctl.c
> >
> > --
> > 2.43.5
> >
>
> Hello Joanne,
>
> I have tested this version, and the crash no longer occurs. Thanks for
> the update.

Thank you for rerunning your test on this version, Yafang! And thanks
again for providing your crash logs in v2 - they were very helpful.

>
> --
> Regards
> Yafang

