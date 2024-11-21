Return-Path: <linux-fsdevel+bounces-35476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C145E9D5290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815E5280F10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF081BD9EC;
	Thu, 21 Nov 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0yHcDlb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AF6F06B;
	Thu, 21 Nov 2024 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213895; cv=none; b=p7O7J/CzbaA3ePPHsGz00v+KDIhg2N1G7GoG3IJ1kI7yoXGCxS/xgB9440gvG25UXuPMMefDW/SiT7iDuyH8Mb7Kw+AScry14W64QqGMzFG8SVMZVWVqfL+tCnVy63LutHbXLv59Tj38xQSN9w58Y6hcXSKgM6L+vs1BlStnzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213895; c=relaxed/simple;
	bh=qdbfLHjBwQXwAfjuDYTl015HlQfcIC0oOpXKyWa83GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WktoHMRrNIuOAmjexzhuVXlnDxQj8j6DglS8Qwiez2rriVU6I5wWS//+ThKXIo+JXkPe49QjO6Cq3qvvroOOAuPqRwj59VGAG9KkZvincmaR4vpOkgQZzUzm4l3jk2fqUOoquqCBXVDMzAHf4DXMyF5XELbXG5NhSlcRZ5+xYrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0yHcDlb; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso22746001fa.2;
        Thu, 21 Nov 2024 10:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732213891; x=1732818691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8sUkGeUy2sHCwOUXx/YOFYIvJypbi+uhVMOVlCFTao=;
        b=F0yHcDlb422+aZSjUcx9eMUZB0mgRAbhoILJmlkHlHKrh6sh2j/aP01yCkKWZQ/sOe
         WNMAUqiQXMsOeCgM3ngWcWcd9xZRC/uSZgAAaDEmDrpKE3+hXvaVmiBB3uV0C1nboPao
         UyBAmX0FKgs9lgZmj7sTpA6s23bhpOzzmGVhXHeXcBMgkH8u+uK9RklhWLDMqDsX/CD/
         WmazcvwbIFbmKfsr1hb8Y2dgZmA76ckGi+1p2GVIq7sJoe/J3r2YZP1foj+I5CUfq8ly
         dMpiBtkX3V6o87kABWPBRXUYzhPTapHPnAgQPn98uFKa01Em/EeN5VS+aINu4yCabC52
         7KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732213891; x=1732818691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8sUkGeUy2sHCwOUXx/YOFYIvJypbi+uhVMOVlCFTao=;
        b=V83Edf4RujgOHWJz65bTPWB6t9zQhSzw9MsCiG3JambCIojgpKSbrf8jBesHHY/J1K
         eMmL5VxVxFmUlBIngCD27/w3RW6RsWe4Nd7xLKeKmwF+ekwYRJd00ODP4iZURXTi0S89
         tE6iIN5UAlMqqMzoMXfEgxrqZZF4wrQ1BNQJ8MOX9wN9SRphm/THvHgKDcDx3n6qnBgs
         mBlyr/cg50oD12ruIoPKiS+b6HpQk3ouswt0VryJ3HUdHUii1s775FVkroPiIAXHHLDi
         Rp2ifyNrDJa/1JX8zvBfdFuiKrRyu3EJfaIXbHquF/6Zb2iMImxa/Z9+shbjcrOv2not
         WDgw==
X-Forwarded-Encrypted: i=1; AJvYcCUG+8+BH/kgv6eAMD7jk+hdl6V/A4fYxp3n1+O83+O9q9EBNhPPQ+t7dXad/AdPCmYjOloeO7z4+nbnrw==@vger.kernel.org, AJvYcCWMdixVCwzIo8RvFtms+CKsqUd+N/Y2w0ITptzQrP3NiaWxvQAIKkLq9YOTCrGkdRVn8bAVSxCquqbFm37lGg==@vger.kernel.org, AJvYcCWWzmOf+fisE6DD2r50w2tW8leSSiovtAXZglabkpf1tiWlGCDyS5RF1jG0JoscqCGaG1RmPVRUuU9xrQ==@vger.kernel.org, AJvYcCXRB4srf9aSp9l+Gg+3dxwfxDoS9XHzVxduwEL/6puwhMrXeg77A3t7f2kMwJnt8WOLgvSUJ3VCTi4O@vger.kernel.org
X-Gm-Message-State: AOJu0YwDt3K0LPfAgOA5I4ApOOYvlzOy5uIUYNK6I+mUE43xZtSwck1i
	a/NX4Z1aACGbtbWMqi+8wjtm1FGT4zoc5HEt1Vu9pXKtYEdUlbGhQOnnB9kt5nGK8PHra/z5nVA
	EKlIzLiROx3KBjxJE3NtzTEylahM=
X-Gm-Gg: ASbGncs6si7rQ4EAWjscDolS9LQAJtiCKxHK2RC6/lwz+a4Mkjj3w14Z6kB4SDFHXYw
	HpMsmvhqNd/tm6a/Y8Pl192npcFWOI0c=
X-Google-Smtp-Source: AGHT+IEldLUO8T8htIjF2AQfaERgaC4UTkjSuef9nnywzNlaBFoQgol0xShwH40QKISC70XNYyKYcQsEtPoJAUUnBXU=
X-Received: by 2002:a2e:be9e:0:b0:2ff:59dd:9242 with SMTP id
 38308e7fff4ca-2ff8dcb1d15mr80129191fa.35.1732213891042; Thu, 21 Nov 2024
 10:31:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com>
 <20241121104428.wtlrfhadcvipkjia@quack3> <CAOQ4uxhTiR8eHaf4q0_gLC62CWi9KdaQ05GSeqFkKFkXCH++PA@mail.gmail.com>
 <20241121163618.ubz7zplrnh66aajw@quack3>
In-Reply-To: <20241121163618.ubz7zplrnh66aajw@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 19:31:20 +0100
Message-ID: <CAOQ4uxhsEA2zj-a6H+==S+6G8nv+BQEJDoGjJeimX0yRhHso2w@mail.gmail.com>
Subject: Re: [PATCH v8 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
To: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 5:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 21-11-24 15:18:36, Amir Goldstein wrote:
> > On Thu, Nov 21, 2024 at 11:44=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 15-11-24 10:30:23, Josef Bacik wrote:
> > > > From: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Similar to FAN_ACCESS_PERM permission event, but it is only allowed=
 with
> > > > class FAN_CLASS_PRE_CONTENT and only allowed on regular files and d=
irs.
> > > >
> > > > Unlike FAN_ACCESS_PERM, it is safe to write to the file being acces=
sed
> > > > in the context of the event handler.
> > > >
> > > > This pre-content event is meant to be used by hierarchical storage
> > > > managers that want to fill the content of files on first read acces=
s.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Here I was wondering about one thing:
> > >
> > > > +     /*
> > > > +      * Filesystems need to opt-into pre-content evnets (a.k.a HSM=
)
> > > > +      * and they are only supported on regular files and directori=
es.
> > > > +      */
> > > > +     if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> > > > +             if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
> > > > +                     return -EINVAL;
> > > > +             if (!is_dir && !d_is_reg(path->dentry))
> > > > +                     return -EINVAL;
> > > > +     }
> > >
> > > AFAICS, currently no pre-content events are generated for directories=
. So
> > > perhaps we should refuse directories here as well for now? I'd like t=
o
> >
> > readdir() does emit PRE_ACCESS (without a range)
>
> Ah, right.
>
> > and also always emitted ACCESS_PERM.
>
> I know that and it's one of those mostly useless events AFAICT.
>
> > my POC is using that PRE_ACCESS to populate
> > directories on-demand, although the functionality is incomplete without=
 the
> > "populate on lookup" event.
>
> Exactly. Without "populate on lookup" doing "populate on readdir" is ok f=
or
> a demo but not really usable in practice because you can get spurious
> ENOENT from a lookup.
>
> > > avoid the mistake of original fanotify which had some events availabl=
e on
> > > directories but they did nothing and then you have to ponder hard whe=
ther
> > > you're going to break userspace if you actually start emitting them..=
.
> >
> > But in any case, the FAN_ONDIR built-in filter is applicable to PRE_ACC=
ESS.
>
> Well, I'm not so concerned about filtering out uninteresting events. I'm
> more concerned about emitting the event now and figuring out later that w=
e
> need to emit it in different places or with some other info when actual
> production users appear.
>
> But I've realized we must allow pre-content marks to be placed on dirs so
> that such marks can be placed on parents watching children. What we'd nee=
d
> to forbid is a combination of FAN_ONDIR and FAN_PRE_ACCESS, wouldn't we?

Yes, I think that can work well for now.

Thanks,
Amir.

