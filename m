Return-Path: <linux-fsdevel+bounces-69875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE9CC89732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1082B34A0C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A231ED88;
	Wed, 26 Nov 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrRzVqce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709F31C567
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155319; cv=none; b=YFCetTkXwtjuoJeJq3SabR3qvWkBInieAjYaFV1R04EM1FspxRqv15cAfSQDgUDLHSEgrGyW9uqFtM/BPziajM8gRp+11WA6VGuF64Oy1s73v/wYrgmGjkBtsgR/YjAHrZcZgeu8VlxSOFdHqscwKC4p/Sdh21UGf7ocCqSbsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155319; c=relaxed/simple;
	bh=9C2/NcVvxt77/Yvodh6sQQ91tjV62bpYwTZQswBcUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shDpjgext0guqUrkOipILSw09Bynx5E4qI+W7dWoammHIIlYydK6wntXj/qyyokiJqL6hgFbhRL2CsoxKrh8VjjLSxpKqYeRaRknGurpKfN/uL8p6phTY5gepmrZHZg1es9O7MX+Qj3nMj396qBPEdy55GcOgHa2QRGBeR7pDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrRzVqce; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5e1fde1f014so1122683137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764155315; x=1764760115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AY2VIxT/dP2zuoIFV4agaRzfXW2PN18+pOYnpq4lu8=;
        b=FrRzVqcePfu5JwvhG3ZHfWKuSCBMUoiTE1M5a61ltF6Tt5E0Agpsut92xfLdvlRCB1
         Q9JRflN+6uRQsWArNCGVRyf43EUW4Me20mUbl+S+JrCCk+3OfpamB4S+liBzlm1JJp1Y
         om7nhRmF1Lxxyo0bP9Ob365wwCmBF4b8rV4E89WMkH7WXmQz6eJ3w54fWY1Qq8JIFYEE
         DmYP+YN5tISvv2JSiVCjeB+NRwXgySVgz7j9p8deX3SnMS5Ri1fDVLev45KkJXot1r3y
         UB81ZQosinKeHS8XylSfbJ4BOGvg2tC/Q3Iopp5vQUBO8mtfVgGQO3YV646Tehd66lwy
         zRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764155315; x=1764760115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AY2VIxT/dP2zuoIFV4agaRzfXW2PN18+pOYnpq4lu8=;
        b=OiHBgZ3fePR9zSohAa4nCVxwAZYLzGYLBr1QiJh+rhPTjgAFvr0cKpE6aS4x8O9HjN
         HLRXnGjohjGXKrfQwHJMArsZbRnlkeY5QSml2luN9gHW9cQnKC55RBC8k8SlIVfoM9+t
         C0BnVEr9v4nT2o1Itf1RMUKtc2EQrSxG2ro/gBBLhiPy2i/JRphTmihD1WTFJwJGAEYH
         eVruJz29m0vOAdkfFdaG8+1XrRuEBztuFIc5+JkRHAX46ft3BPAOeiF3jxbKGdW4yWPa
         ERd0bJ7zh52SXIxTUcqelcthP3uXzdCjpcqQrtu01buaskJvKP6/y+8X0OuPsf7CMked
         uTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUFoFte6C0wqNcldFlCpfo+6jA4+bqYpxd2XceOyfYC5W52kJvrwAOGEwuYnWixV12aYyBUacmprVulx1P@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJvfnH7vWNji2Ky/B5I6W+zjUvWWkoTf/2/zuGgh+dkT+EUf+
	Nsy+8S8Bt1LnnNjxIFjC6vzxbbggDkx1YWpNkHhtVwacvekyWOkp0nG9byRbXiEMrW97Jzbe9fh
	/uNw+mAMjuJdfxXUUFuX+JZIjGgREkLw=
X-Gm-Gg: ASbGncvIuERhuJZmoejX5w9kflfdTR2HeqLdToKCCekY3Yan0NX1zBHzOvi5/XLGnic
	EKdiDcUy/zoksqeDRgj7wEakT3fu15FbYP98jLNII1fS5sxrXCGoSM2KOW5Gl+xyKbRKqk0wjDH
	734T2ZbD0Duz6Qoo80LkCzJ1raH5RsVK5ywP2ATnomVTP8BH198rKOOFjSiDV1J0gqm2UxuyaF0
	LNg/ARRt1YWkONl6Yrm98I/YmKUaJtf5uhAf0VgTmgO4YPmjc4a5EdUUg+hZskjGzkH3g==
X-Google-Smtp-Source: AGHT+IFyeGO9PCJAArYeLtA1vX9hBXW0orN309Zq4TLy61tzphZeZ6pHB9w2iCTvgTRkhX0dfeBF1Lynujv3elQnrKg=
X-Received: by 2002:a05:6102:a4e:b0:5db:3111:9330 with SMTP id
 ada2fe7eead31-5e1de3c0e97mr6296792137.27.1764155314876; Wed, 26 Nov 2025
 03:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-1-4dd56e7359d8@kernel.org> <lhu7bvd6u03.fsf_-_@oldenburg.str.redhat.com>
In-Reply-To: <lhu7bvd6u03.fsf_-_@oldenburg.str.redhat.com>
From: Eugene Syromyatnikov <evgsyr@gmail.com>
Date: Wed, 26 Nov 2025 12:08:19 +0100
X-Gm-Features: AWmQ_blH6F5dTImS9T2yEKSQi7mTbsqdURayo9P3HSzLI7PhinkAeFA2QqkHgpo
Message-ID: <CACGkJdun_DfF8VRXHRazyZn+dVqiHwKD2Ys9L0Oh-Znr-2d_dQ@mail.gmail.com>
Subject: Re: Stability of ioctl constants in the UAPI (Re: [PATCH 01/32]
 pidfs: validate extensible ioctls)
To: strace development discussions <strace-devel@lists.strace.io>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	Lennart Poettering <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org, 
	libc-alpha@sourceware.org, "Dmitry V. Levin" <ldv@strace.io>, 
	address-sanitizer <address-sanitizer@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:19=E2=80=AFAM Florian Weimer <fweimer@redhat.com=
> wrote:
>
> * Christian Brauner:
>
> > Validate extensible ioctls stricter than we do now.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/pidfs.c         |  2 +-
> >  include/linux/fs.h | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index edc35522d75c..0a5083b9cce5 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -440,7 +440,7 @@ static bool pidfs_ioctl_valid(unsigned int cmd)
> >                * erronously mistook the file descriptor for a pidfd.
> >                * This is not perfect but will catch most cases.
> >                */
> > -             return (_IOC_TYPE(cmd) =3D=3D _IOC_TYPE(PIDFD_GET_INFO));
> > +             return extensible_ioctl_valid(cmd, PIDFD_GET_INFO, PIDFD_=
INFO_SIZE_VER0);
> >       }
> >
> >       return false;
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index d7ab4f96d705..2f2edc53bf3c 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -4023,4 +4023,18 @@ static inline bool vfs_empty_path(int dfd, const=
 char __user *path)
> >
> >  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *it=
er);
> >
> > +static inline bool extensible_ioctl_valid(unsigned int cmd_a,
> > +                                       unsigned int cmd_b, size_t min_=
size)
> > +{
> > +     if (_IOC_DIR(cmd_a) !=3D _IOC_DIR(cmd_b))
> > +             return false;
> > +     if (_IOC_TYPE(cmd_a) !=3D _IOC_TYPE(cmd_b))
> > +             return false;
> > +     if (_IOC_NR(cmd_a) !=3D _IOC_NR(cmd_b))
> > +             return false;
> > +     if (_IOC_SIZE(cmd_a) < min_size)
> > +             return false;
> > +     return true;
> > +}
> > +
> >  #endif /* _LINUX_FS_H */
>
> Is this really the right direction?  This implies that the ioctl
> constants change as the structs get extended.  At present, this impacts
> struct pidfd_info and PIDFD_GET_INFO.

Well, some classes of ioctls are indeed designed like that (drm comes
to mind), but I agree that it is something that preferably should be
decided at the initial interface design stage (including the
constants, for example, evdev is probably a good example of handling
them), as otherwise there will be userspace code that assumes that the
size doesn't change.

> I think this is a deparature from the previous design, where (low-level)
> userspace did not have not worry about the internal structure of ioctl
> commands and could treat them as opaque bit patterns.  With the new
> approach, we have to dissect some of the commands in the same way
> extensible_ioctl_valid does it above.
>
> So far, this impacts glibc ABI tests.  Looking at the strace sources, it
> doesn't look to me as if the ioctl handler is prepared to deal with this
> situation, either, because it uses the full ioctl command for lookups.

strace usually handles this opportunistically, but indeed ioctls which
don't have fixed size across kernel version require additional care in
terms of handling, decoding, and printing.

> The sanitizers could implement generic ioctl checking with the embedded
> size information in the ioctl command, but the current code structure is
> not set up to handle this because it's indexed by the full ioctl
> command, not the type.  I think in some cases, the size is required to
> disambiguate ioctl commands because the type field is not unique across
> devices.

In terms of disambiguation, one needs to look at the fd in question,
and even that is oftentimes not enough (again, in drm, one needs to
figure out what driver backs a specific fd in order to determine the
ioctl semantics properly).

> In some cases, the sanitizers would have to know the exact
> command (not just the size), to validate points embedded in the struct
> passed to the ioctl.  So I don't think changing ioctl constants when
> extensible structs change is obviously beneficial to the sanitizers,
> either.
>
> I would prefer if the ioctl commands could be frozen and decoupled from
> the structs.  As far as I understand it, there is no requirement that
> the embedded size matches what the kernel deals with.
>
> Thanks,
> Florian
>
> --
> Strace-devel mailing list
> Strace-devel@lists.strace.io
> https://lists.strace.io/mailman/listinfo/strace-devel



--=20
Eugene Syromyatnikov
mailto:evgsyr@gmail.com
xmpp:esyr@jabber.{ru|org}

