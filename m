Return-Path: <linux-fsdevel+bounces-36159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324D9DE9F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB75B213A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA401146D76;
	Fri, 29 Nov 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0TFO5BA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8726140E34
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895567; cv=none; b=CtyCIVKCrL+VYxZYdUUwXrF/VlhiUoQ0mpQ13Fs2fS+eWFj4hr75pI9crWOSAw3PI0NpVgtsvHUpcVXlBbiy1PcNtWlASIDmU+XXlOoocoGb7fnmocLIoTSQRqL/tXShgOYIBVxhX7+54JhkDsDdTvdwazhwmhaoKdlM4Qaudco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895567; c=relaxed/simple;
	bh=7EP1G8Uk3MEoliseXxGE21pmFfzbjkjjBqJ59GoFNmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXZsHh219VO+KIwSbd48SBVacT8OPGuGp1FXPUeYSlbfjc+fJrX7rB4jZc4baotN8UOYhSNCS0n7FaAstrov8pD5r5uLHbtrLookqCJWVy27VJ9cwkxLdvMvD+FD/001Em1p6JtdUGzwPPOhAmmUEDrXPhwYvanC9Hpwe+hX35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0TFO5BA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so33339161fa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 07:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895564; x=1733500364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWDt30RIXaY5j3OIiNxaeUbyHdQvZ7yzoJvsTe+k04g=;
        b=P0TFO5BA6jSN7Y+SJD5D9wqDIqCgW+i7H/5Z7Om/z2YFuzz85aSH64co30n3lXXSo0
         4AoV1asOdBmvgP94TXe2SveCPvIr8TSuknVl1ch5QkmNFWAl5Qp9JUozukkMu1wTcKQK
         KeYSwBgu/iwhXWnED1koQzriR0j6uRkNs2y28PGVPOELxTF6ajmOCzLHT7G2gkVNf1zh
         LOmdL2rjUPMLriWzHgpeGnPMyJ0G7mr9q6M4YA7Ra7ff73gogad0VP0450HObIVmW9fD
         9OMLKfb7SIxnehM9aPRl83d+aEieyiv8Mk8p9SdwJ3lS/VDILPxQ/zRSRXisfklYFWdv
         /LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895564; x=1733500364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWDt30RIXaY5j3OIiNxaeUbyHdQvZ7yzoJvsTe+k04g=;
        b=C7hpq9euoPy3UJl4rXooqu886AVRib/fzdDerUzZnfOOcf9aX1//qRfb3yVA5oh07O
         z3GujHKQl06y1kerEnNBa24XlI+yCGfYz8oSlfcguLJOO3VkKW9LxCozpZD9wamSWUr/
         B7uG1MVRE3YvJ89x4ZZ5d4TP4ID622vUqaJ0EB5P3sDoxL+AApNzLoolxt0BPQIu52ry
         opBHd5NF82A34xMoYkjBdI7aFBMq3fcOi6tfjqg+YoxUP6297g0HoOpPPYqMOuG+na5x
         mP5VKeyBSiUDLtVwmt+HWrlUqWYr+3F/RjS1iTXbOslbL/MML2wLqP8Z/OyyFcMgA5uM
         H1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXHm9FVfc0ZvdE90Qq5spjADa5I5CnKIIxLPDlgcPArkrEzoxxO7ReSp4KpvCrLELYfOGr6NsqqtYCxBh0z@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCfDMJeEG+0hhs/a0HZwkN3GPYD9MWARVKpRVJdhbKJnsM0rr
	vSEqJyxFbcco+ZQPoWmQ5tYZ+tXJmvu13fWDynxsQlal+/LaUMcZQZEPAGOR4lNzJpYBIPamMEC
	ADr6MSdwSe7lV8DAGfQHcs6MSgdM=
X-Gm-Gg: ASbGncsdw9vF5nfBUfXBNCPFwQ3Nhx6RoOeq162ft+gjXrZhgdzH8QY33WdcGW1ACUG
	c4ylSSxZI8j1o1LwG8EYJu0mpi46+1Tw=
X-Google-Smtp-Source: AGHT+IH8Z6N3uxyDLkWNEQ25/QMDMaZslx/2OPR4BwfFoKYbfe7+jtD3iaIJ/efyeae9UnEGsFx7ye2ED9o6BXxgPZc=
X-Received: by 2002:a05:651c:2119:b0:2ff:a8dc:6fb8 with SMTP id
 38308e7fff4ca-2ffd5fcc1f1mr110471221fa.8.1732895563422; Fri, 29 Nov 2024
 07:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128142532.465176-1-amir73il@gmail.com> <wqjr5f4oic4cljs2j53vogzwgz2myk456xynocvnkcpvrlpzaq@clrc4e6qg3ad>
 <CAOQ4uxiqbSFGBoCzg44t4DM=uvJ3zbev_wbSot4i5C8jQW_t7Q@mail.gmail.com>
 <CAGudoHEgjTq6RTmcenUcZUaRuzkAm8WiCCbakqbUMa5AeT84fg@mail.gmail.com> <CAOQ4uxg6yZxTVMvkbvk5UW627dy2jOzX0+ssjzv6pHXLBKShPQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg6yZxTVMvkbvk5UW627dy2jOzX0+ssjzv6pHXLBKShPQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 29 Nov 2024 16:52:30 +0100
Message-ID: <CAGudoHGzfjpukQ1QbuH=0Fot2vAWyrez-aVdO5Fum+330v-hmA@mail.gmail.com>
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched files
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:57=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Nov 28, 2024 at 6:00=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Thu, Nov 28, 2024 at 5:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 3:34=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.=
com> wrote:
> > > > so this depends on FMODE_FSNOTIFY_HSM showing up on the file before=
 any
> > > > of the above calls and staying there for its lifetime -- does that =
hold?
> > >
> > > Yes!
> > >
> >
> > ok
> >
> > In this case the new routines should come with a comment denoting it,
> > otherwise the code looks incredibly suspicious.
>
> How's this:
>
> /*
>  * Do not prevent write to executable file when watched by pre-content ev=
ents.
>  *
>  * (*) FMODE_FSNOTIFY_HSM mode is set depending on pre-content watches at=
 the
>  *     time of file open and remains for entire lifetime of the file, so =
if
>  *     pre-content watches are added post execution or removed before the=
 end
>  *     of the execution, it will not cause i_writecount reference leak.
>  */
>

Looks good, thank you!

--=20
Mateusz Guzik <mjguzik gmail.com>

