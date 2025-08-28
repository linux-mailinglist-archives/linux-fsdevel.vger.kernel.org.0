Return-Path: <linux-fsdevel+bounces-59497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B785AB39E38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 15:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD02B1C231D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E933112A3;
	Thu, 28 Aug 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ2lO4ul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D78462
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386612; cv=none; b=ibaKAsJbCuHbRusphwwEb29mhKr3EToNT45vXCePcn7iRL3unixap+Nv/VdZ2yOe2p2CULWtnXO5/j+XY0VNI6Ahv+8NOKZJtot9wNREFj/KeXr601rVXCV7wqJErH/ygZ7KB7/pw3ln6lrzspN+4V7LD78IO+upkmCPNj2uhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386612; c=relaxed/simple;
	bh=B7vY5a5H/CInYqJt3S24qZ65QHmNPkp8bcIjXkboFdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCukDcxKhHR9Bc/+BS3rHHlwrULqLWHL/r/dvOMXESwwWsZONI85ZGP3WfkOZGbsmHlgJ5Q4P9FK/BWjvUMJxo8kHa8a1Z0NcuICQB7kpqvNy9QDs79l3FiMVPm9JlQ6kASxv/waM2P8TsMpGGP9h+VxPnWNg5Gd2ujjhaS/Krg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJ2lO4ul; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756386610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90wtLT1gWYZG2gBfKcj8oevBzd0M21miokyeOqpFe+c=;
	b=WJ2lO4ulmewKbetU15b5SPI2f2xxxyqCKrjUiLB0pUFoDGrbs7b9AVqp5K8Fc8Ct5t/9ow
	rhpZqgMaf8p9l0sVKab650pU6kQ/+tak907gYSta7XeOF8imKdNU+ST2tOtvhx4pO/0x8L
	sKsi40zMpu3rqlAYy1xg8+DaQgSr1y0=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-O_HctyAWMcSlTloEgujSVQ-1; Thu, 28 Aug 2025 09:10:08 -0400
X-MC-Unique: O_HctyAWMcSlTloEgujSVQ-1
X-Mimecast-MFC-AGG-ID: O_HctyAWMcSlTloEgujSVQ_1756386608
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71ff15cdbbcso11596527b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 06:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386608; x=1756991408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90wtLT1gWYZG2gBfKcj8oevBzd0M21miokyeOqpFe+c=;
        b=xIkFftwHIevzlPLzbRZfQRRUovDghMCD6Um6YaUr54M7WwpVT0PBrggfOAzY047zOS
         Fwdem+YfIYfFXtkzFv19iLMuvWnezWsKPaxgJEO+bHOC4jCEfxkLTcBNsMKjTFy0ze6/
         hpcHVO6ixFf8QGjpglEr6OG+92l/zPvxYJPgB4gBcQ049QZWJ9rDTsScdj3oguYT8Mu4
         bjrbVkcQocejtzlcib4GtlmyrfNqZV4pFEaH0ZYtGbKZdX6QyCuR/P8EEqtOa0MGD7bW
         Z7YOBNorf7Fgp5BGI9M8Vt2E26tbKd1bmQL9diH88IOENXz6fCV+tm4s5goRGff9GjKh
         Jg0g==
X-Gm-Message-State: AOJu0Yyv5xgjtexOvY2o6p1MSR66LrfolBE84KRsnzUluwloeVHY4YTD
	f1DoqtpzCxbvZQt3I5Difwj5u3Y7K0RQ5PP37NlVjJ5xXUJNhNtTbu5dGfOqpoc/uISwq+EiJ0U
	1PPwzUcfeMelTAj4bb9brWKQ06UKfq94CUOth3PbfnpJUPcY7I6EOuelYiQdMVlzT5reT24T93f
	v442mwy25EMBB8oH/c3zeZ0wivB449/zKzrdAk9Lh62A==
X-Gm-Gg: ASbGncuqLZuG3rge9nMcMTlUgUsVhKHYyyrjXI/J6elysttFfQOdVs3tmcPAIV90qLg
	R1hgoOC2IzbtAZld3mI2KQIyanCA3lpAQ7l0MhHzDtKJnztLaCxj8Dq1On18I6uTvAdIWgT6tku
	bwxO19taPb4H/801Dz+1ABeS0=
X-Received: by 2002:a05:690c:18:b0:71c:40c9:b0fd with SMTP id 00721157ae682-71fdc3c877dmr280548947b3.30.1756386607922;
        Thu, 28 Aug 2025 06:10:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9cvp64PrgzJm3SC4KUHEinEm4nxXqVvYYVLlPzidErRQrBhiT0zmFEeALnAFM5p9w5aOb+JAEj3NTfCV0r5c=
X-Received: by 2002:a05:690c:18:b0:71c:40c9:b0fd with SMTP id
 00721157ae682-71fdc3c877dmr280548557b3.30.1756386607422; Thu, 28 Aug 2025
 06:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827110004.584582-1-mszeredi@redhat.com> <CAJnrk1b8FZC82oeWuynWk5oqiRe+04frUv-4w9=jg319KvUz0A@mail.gmail.com>
In-Reply-To: <CAJnrk1b8FZC82oeWuynWk5oqiRe+04frUv-4w9=jg319KvUz0A@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 28 Aug 2025 15:09:56 +0200
X-Gm-Features: Ac12FXxydRRa6iZbxdaY4gj_YsFZhzLF1aUTppwfoN-JpyA0C857YyyLzTHE-yg
Message-ID: <CAOssrKe9qPTGh6ghkLX+Gngsd-ro5JUw79Syxrnyy9U0Q8nQdg@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: allow synchronous FUSE_INIT
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 12:57=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:

> I wonder if we should make the semantics the same for synchronous and
> non-synchronous inits here, i.e. doing a wait for
> "(READ_ONCE(file->private_data) !=3D FUSE_DEV_SYNC_INIT) &&
> READ_ONCE(file->private_data) !=3D NULL", so that from the libfuse point
> of view, the flow can be unified between the two, eg
> i) send sync_init ioctl call if doing a synchronous init
> ii) kick off thread to read requests
> iii) do mount call
> otherwise for async inits, the mount call needs to happen first.

Do you suggest that libfuse should ignore the return value of the
sync_init ioctl?

That doesn't work, because old kernels will return an error on read
from an uninitialized fuse dev.  Also if kernel now blocks before
mount, that might break some odd server that expects an error.

> > @@ -2233,8 +2253,8 @@ static ssize_t fuse_dev_write(struct kiocb *iocb,=
 struct iov_iter *from)
> >         struct fuse_copy_state cs;
> >         struct fuse_dev *fud =3D fuse_get_dev(iocb->ki_filp);
>
> Does this (and below in fuse_dev_splice_write()) need to be
> fuse_get_dev()? afaict, fuse_dev_write() only starts getting used
> after fud has already been initialized. i see why it's needed for
> fuse_dev_read() since otherwise the server doesn't know when it can
> start calling fuse_dev_read(), but for fuse_dev_write(), it seems like
> that only gets used after fud is already initialized.

Yeah.

> > @@ -2610,6 +2630,19 @@ static long fuse_dev_ioctl_backing_close(struct =
file *file, __u32 __user *argp)
> >         return fuse_backing_close(fud->fc, backing_id);
> >  }
> >
> > +static long fuse_dev_ioctl_sync_init(struct file *file)
> > +{
> > +       int err =3D -EINVAL;
> > +
> > +       mutex_lock(&fuse_mutex);
> > +       if (!__fuse_get_dev(file)) {
> > +               WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
>
> Does this still need a WRITE_ONCE if it's accessed within the scope of
> the mutex? My understanding (maybe wrong) is that a mutex implicitly
> serves as also a memory barrier.

Mutex does act as a barrier, but __fuse_get_dev() does an unlocked
read, so this WRITE_ONCE is to balance that.  I'm not a expert in this
area though.

>  If not, then we probably also need a
> WRITE_ONCE() around the *ctx->fudptr assignment in
> fuse_fill_super_common()?

Possibly.

Thanks,
Miklos


