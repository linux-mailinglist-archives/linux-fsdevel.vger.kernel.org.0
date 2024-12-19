Return-Path: <linux-fsdevel+bounces-37881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C79F8728
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 22:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34B416F365
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7EE1C07EC;
	Thu, 19 Dec 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4eyt0AO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932C1BD01D;
	Thu, 19 Dec 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644174; cv=none; b=aareMW5RqcFPmI5bKxbeETqBn7UFbBm4Zdo7pJcSHXyEyJafePYmNy/eHl8bIUy1lPzR2zPyuBEaxAmd0BG/wbjGV7cWL3FAr/45JewP9kRr1y1qS3YwjHxS3u7GfDYhNlHtcgNUk6AvY/n/pFyCs6m6CwpJI5IuRL9cdyJAbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644174; c=relaxed/simple;
	bh=sTfDykp5xshdR0+wdkJ7lcY3IDCzznF6avmv598s5Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGIMCBld7E0cTt8rEqG+iLPD/FQzu7WZBMxe+P7i/4ReWNTlSGPyNr6x1HoM8mNRbG6JoKBS1kufc77CcL2ovij6KHfF3PPxs6uT9D7IVqqbDnYfwwPZOh+3iwvzcaMD4BtrNnnKewhYjtuKhK31NYlYecNamBt8jrF1y6IsWsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4eyt0AO; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467a8d2d7f1so9499561cf.1;
        Thu, 19 Dec 2024 13:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734644171; x=1735248971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkpsDXCBqdSlrvvzseNsW4LqmbzJse7fVIj7xYcto+A=;
        b=H4eyt0AOIPrPmme9nIphK7iwkXPTOf+hYvorVOu+bWjRKCNh8cMnWi27pYRYfewj5K
         Ebpl3mtm7L2rxlTzq4zlhbv2xW0bgexDC9/93RVWNV01s7GHt8IyUF1YqGXdcULDVnPX
         +LEYzaxUgRduu1QOB3tAHUO9fglNQeAi3ITTpYW+mAvBaP5+26GfbTj1KjVxshLbpskh
         Pws+uZbqKeuMZO8YkCnmeAYAnYBynd7A+fQt71rz7UoZts3aQ0K+7L0OoYUcyOGZNCTY
         R0XotLPm/UaaOHL+6HTSNalRsc/0COZQ9VdfciZAceBlIjJAiz/NBUHcq1Fs0ACDV7NP
         RcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734644171; x=1735248971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkpsDXCBqdSlrvvzseNsW4LqmbzJse7fVIj7xYcto+A=;
        b=Sfg6VvHCeTK9IjopKp9oZ2IQFrKJ4GtenYHz395vRN6dqASUrTu1GZidgqpaw8ZPlj
         dMfiaqaq47JjLwzEigOGD+x3dtRQ0D/FdW8aeB/MKWzeMz/qGv4MH1JJ3pZ1JpP/spTy
         jKu+8g53QExuFB2PSSFIflBlhj7zcVCqy+NNbvaTvaUiZxTRh1MvGpu2w1YiaKNa5Ys1
         k3G/gtBfILAoxRLTL1/OOg+n9Pr+Rty4BucyEUVeEMI2fQHgec5bboKJgG/nGtqUm16q
         fXpLWdJ3KvmacqsaJCL6EnT867MfFlPVIRAfYKM64H/Y9w9Wj+WESn8BSxL5vA9biee9
         mqRw==
X-Forwarded-Encrypted: i=1; AJvYcCWhPWzpOuKV9VwkSc7KBFLlPIgYzZySAdcfDD0OPe9ThLIaJFK054Xc+Ki7RNhs+eXrIbJYZ3lzBqSd7ynJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTlzHBtFHyktE0X0L0u5vHyKE6nBLNERQoCrUj1jrH2D3OTvz
	1mHkK+ZGMmrlMkPUw2E1ha7HTfXdeSHHqPZSdDN7skglXDl1MsSij3CptCWNWF8mKXWNfxtVt2M
	kB70UxaHZy6/NdrXqdVD5wGDaYCk=
X-Gm-Gg: ASbGncuSvN/MrfqsxhLzB5o1AAGedX7eTDmzLU+mCIFjpU/BkwKOGeXWs8ueHO+ubPz
	nELlncdWK+jiMp4aaNAIuKShGpX2sAwUonh/3OUc=
X-Google-Smtp-Source: AGHT+IHMgZ8wxhUS67VT2UCJB9GRN9ICr/KTvDgmcJQpldUMHlpFyXw4edi1P0xG5/lesHhHRpQZzPDQVBN3bsBYN94=
X-Received: by 2002:ac8:58c4:0:b0:466:85eb:6123 with SMTP id
 d75a77b69052e-46a4a8cb215mr8468441cf.22.1734644171209; Thu, 19 Dec 2024
 13:36:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218210122.3809198-1-joannelkoong@gmail.com>
 <20241218210122.3809198-3-joannelkoong@gmail.com> <20241219175251.GH6160@frogsfrogsfrogs>
In-Reply-To: <20241219175251.GH6160@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Dec 2024 13:36:00 -0800
Message-ID: <CAJnrk1Y0BrFRt2mAujAzmoWRzYnoWoAJt4X6jtLh6O0CkgR4CA@mail.gmail.com>
Subject: Re: [PATCH 2/2] generic: add tests for read/writes from
 hugepages-backed buffers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 9:52=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Dec 18, 2024 at 01:01:22PM -0800, Joanne Koong wrote:
> > Add generic tests 758 and 759 for testing reads/writes from buffers
> > backed by hugepages.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  common/rc             | 10 ++++++++++
> >  tests/generic/758     | 23 +++++++++++++++++++++++
> >  tests/generic/758.out |  4 ++++
> >  tests/generic/759     | 24 ++++++++++++++++++++++++
> >  tests/generic/759.out |  4 ++++
> >  5 files changed, 65 insertions(+)
> >  create mode 100755 tests/generic/758
> >  create mode 100644 tests/generic/758.out
> >  create mode 100755 tests/generic/759
> >  create mode 100644 tests/generic/759.out
> >
> > diff --git a/common/rc b/common/rc
> > index 1b2e4508..33af7fa7 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3016,6 +3016,16 @@ _require_xfs_io_command()
> >       fi
> >  }
> >
> > +# check that the kernel and system supports huge pages
> > +_require_thp()
> > +{
> > +    thp_status=3D$(cat /sys/kernel/mm/transparent_hugepage/enabled)
> > +    if [[ $thp_status =3D=3D *"[never]"* ]]; then
> > +         _notrun "system doesn't support transparent hugepages"
> > +    fi
> > +    _require_kernel_config CONFIG_TRANSPARENT_HUGEPAGE
>
> Will /sys/kernel/mm/transparent_hugepage/ exist if
> CONFIG_TRANSPARENT_HUGEPAGE=3Dn ?
>
> Or put another way, if /sys/kernel/mm/transparent_hugepage/ doesn't
> exist, is that a sign that hugepages aren't enabled?

I just checked the logic in hugepage_init() and it looks like the
sysfs initialization is gated by a has_transparent_hugepage() check
against that config, so no, ' /sys/kernel/mm/transparent_hugepage/'
won't be there if that config is set to n. Thanks for noting, I'll
revise this check.

>
> > +}
> > +
> >  # check that kernel and filesystem support direct I/O, and check if "$=
1" size
> >  # aligned (optional) is supported
> >  _require_odirect()
> > diff --git a/tests/generic/758 b/tests/generic/758
> > new file mode 100755
> > index 00000000..b3bd6e5b
> > --- /dev/null
> > +++ b/tests/generic/758
> > @@ -0,0 +1,23 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 758
> > +#
> > +# fsx exercising reads/writes from userspace buffers
> > +# backed by hugepages
> > +#
> > +. ./common/preamble
> > +_begin_fstest rw auto quick
> > +
> > +# Import common functions.
>
> No need for ^^ this comment.  Same with 759.
>
> --D

Will remove these comments in v2.


Thanks,
Joanne

>
> > +. ./common/filter
> > +
> > +_require_test
> > +_require_thp
> > +
> > +run_fsx -N 10000         -l 500000 -h
> > +run_fsx -N 10000  -o 8192   -l 500000 -h
> > +run_fsx -N 10000  -o 128000 -l 500000 -h
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/758.out b/tests/generic/758.out
> > new file mode 100644
> > index 00000000..af04bb14
> > --- /dev/null
> > +++ b/tests/generic/758.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 758
> > +fsx -N 10000 -l 500000 -h
> > +fsx -N 10000 -o 8192 -l 500000 -h
> > +fsx -N 10000 -o 128000 -l 500000 -h
> > diff --git a/tests/generic/759 b/tests/generic/759
> > new file mode 100755
> > index 00000000..6dfe2b86
> > --- /dev/null
> > +++ b/tests/generic/759
> > @@ -0,0 +1,24 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 759
> > +#
> > +# fsx exercising direct IO reads/writes from userspace buffers
> > +# backed by hugepages
> > +#
> > +. ./common/preamble
> > +_begin_fstest rw auto quick
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +_require_test
> > +_require_odirect
> > +_require_thp
> > +
> > +run_fsx -N 10000            -l 500000 -Z -R -W -h
> > +run_fsx -N 10000  -o 8192   -l 500000 -Z -R -W -h
> > +run_fsx -N 10000  -o 128000 -l 500000 -Z -R -W -h
> > +
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/759.out b/tests/generic/759.out
> > new file mode 100644
> > index 00000000..18d21229
> > --- /dev/null
> > +++ b/tests/generic/759.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 759
> > +fsx -N 10000 -l 500000 -Z -R -W -h
> > +fsx -N 10000 -o 8192 -l 500000 -Z -R -W -h
> > +fsx -N 10000 -o 128000 -l 500000 -Z -R -W -h
> > --
> > 2.47.1
> >
> >

