Return-Path: <linux-fsdevel+bounces-48537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9191AB0B5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962B79E5DF6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FF26FDB4;
	Fri,  9 May 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E180233e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9B268C69;
	Fri,  9 May 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774848; cv=none; b=NdfSxMlDyn71ub9yf8XKtVYpPexIFIzu2axlL4BLGkc3ZOLRGrun+xuUNkBYJDyJyoVCa/Warz8fXxh4De2B9Mu17ki5pcMoCpZw7mM8I5a+/87vVjacLtSoWjB8oF+to1h7QxayJaXe/SmyL5qBv+t5dTUVz7HQij3NVHNUCfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774848; c=relaxed/simple;
	bh=sF+l/Su/FKNCiHc8D4tahkB87Ma85XqHIbLh5HRLms8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFfaO/UjDKuHIEvOhnTULvcCE13kfTS987HBVMYlNRa7wu2h9yToxg4Fe3ihq0DdJYsJ8cdwAWqK287eRNSvX5AXeyQgE1AOfi2j+bl69ULmFZTBjiXHkgCP88COSWCsJrWq1jLwaBpWQxlFME1e1AOfIXd4JudurAF9Es379NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E180233e; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso2970787a12.1;
        Fri, 09 May 2025 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774844; x=1747379644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1OB41sQf8ynBo+UI5/B7jyn8L+nDm3mXtK1jucH+hg=;
        b=E180233eEd06imLF5lU/Sppo4obUwrqI3FtLXN+IettMn5aF+2AjAPDfhvHCpdUC/v
         YV7UPatWgZWP44hMLrxyMlrfrYA/d5VW75VAoVbi+2x8mc4Tia/uXehcUQR0RjdS1s28
         tmN0bbdFHRnukHX2n2fAqU25b3EMvxmQjlYWKx0HsLPCNiFerHDBqyIHtaeF9NF4yreQ
         6vE9JpVr2vrKivKMw5H4o8Qcg+R+FjMqGgDtkquny8ZPMuT2DbXGc+uEqf9iCuYNvmsR
         4w9mC5HiSsVgLQ3CNx2q1rGwpXkPpB9kH6wadrrtUPB7j/GDvrJ8Tq/pe33z4iKoD/G6
         nCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774844; x=1747379644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1OB41sQf8ynBo+UI5/B7jyn8L+nDm3mXtK1jucH+hg=;
        b=bnJcGByWMNiu8BY/Kdf44L2xWq31vnDDJF8JnnuQrnXNnA8RIAPjbBNuA66ap4wTV0
         /OsZk9veER05jNGlP0443xBGCOz3PW6UUXCqksEPRGTQyGWXiFFpk0Z4NS5T1wPAmaT2
         436HZBqablTTmIfe2heuEa7qdZuT+RP3RROgg/cFfd2BUiGYrKUCQrxLiXHQtQ6j4lpB
         yg8WZvn9a/rJJgee9DBo3d3T65cUnY52mr18tSQY8GclYcYUWjI2+1PvZKrGVBZIGaXV
         ehSW81kw8dJOKeNlUw7NTRfEbjMOkMLp8fPagGaJUuiuVJ4IlhU4veBHl9UjWquzFNXY
         6UbA==
X-Forwarded-Encrypted: i=1; AJvYcCWkfQ6cJZ/TAu+bDXvD1YngqZbDqtYaZdhwvmXtXGWJU2DrMTWEnnPvNc4+jhidOiHygfOmP/pVifBSEXl3@vger.kernel.org, AJvYcCXl4fjsqwgEn2Vn3Ajldz4HByOn+p528i0kQmwRZdqnQizDxVligqL+MlkVzE7Ot6kosY9Yxp9JJhCnYjo3@vger.kernel.org
X-Gm-Message-State: AOJu0YzROc96+B+gY8UFra1EaUhvct0kuNFF/uQygL3Zvo8hQtDn5rIx
	mCGCVH5Zu1NDStnEBtMOXGyae8E1v/ow6ekRFFaREVSoJv7ZoaYaiTnj8vU9+5qgiDE9RC2KYO2
	rw2plVuWS2pxBY0q3EVGRpELIATPVMXISMFxE0g==
X-Gm-Gg: ASbGncuWjK+gKA/abqDqtG5RRJyxJlor9gLfPMlKXhe/mcFwNN5Bxee0bSCUEEfXi2C
	EcC8AX5F2ZsdAiJoeMvNBOFfZhbbU2G5cXIz5MXaR1xt5yNpsxOCc1jyGT4WxQWU7Quyyj+puSU
	+SQFBIislVZEaJ62mE86JOgS2EKuyuW6pd
X-Google-Smtp-Source: AGHT+IEVaaz4NfCHhCSoP1YL0pA38Z8+vCWVX/DZvNdcMVkTOt4ie8bCUCtPypJw8dUhJeuUstFuqjuDpIhrHmHwHhE=
X-Received: by 2002:a17:907:d30a:b0:ac7:3817:d8da with SMTP id
 a640c23a62f3a-ad2192b5b2dmr279751866b.52.1746774844001; Fri, 09 May 2025
 00:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-3-393761f9b683@uniontech.com> <CAC1kPDOdDdPQVKs0C-LmgT1_MGBWbFqy4F+5TeunYBkA=xq7+Q@mail.gmail.com>
In-Reply-To: <CAC1kPDOdDdPQVKs0C-LmgT1_MGBWbFqy4F+5TeunYBkA=xq7+Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 09:13:52 +0200
X-Gm-Features: ATxdqUEG-keV8q1wCW1PP-Dpy9E6g3Yhgf2XjhP43U3-8YOIid3ozknRGaTVDgo
Message-ID: <CAOQ4uxj09fwcrSmx674M2yivGF5hqCdHEbS4yXx+YnGSm-Z=-A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fs: fuse: add more information to fdinfo
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:40=E2=80=AFAM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Fri, May 9, 2025 at 2:34=E2=80=AFPM Chen Linxuan via B4 Relay
> <devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
> >
> > From: Chen Linxuan <chenlinxuan@uniontech.com>
> >
> > This commit add fuse connection device id, open_flags and backing
> > files, to fdinfo of opened fuse files.
> >
> > Related discussions can be found at links below.
> >
> > Link: https://lore.kernel.org/all/CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0Q=
N_KvP6ZOe2KVBw@mail.gmail.com/
> > Link: https://lore.kernel.org/all/CAOQ4uxgkg0uOuAWO2wOPNkMmD9wqd5wMX+gT=
fCT-zVHBC8CkZg@mail.gmail.com/
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > ---
> >  fs/fuse/file.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 754378dd9f7159f20fde6376962d45c4c706b868..1e54965780e9d625918c22a=
3dea48ba5a9a5ed1b 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -8,6 +8,8 @@
> >
> >  #include "fuse_i.h"
> >
> > +#include "linux/idr.h"
> > +#include "linux/rcupdate.h"

These are not needed.

> >  #include <linux/pagemap.h>
> >  #include <linux/slab.h>
> >  #include <linux/kernel.h>
> > @@ -3392,6 +3394,21 @@ static ssize_t fuse_copy_file_range(struct file =
*src_file, loff_t src_off,
> >         return ret;
> >  }
> >
> > +static void fuse_file_show_fdinfo(struct seq_file *seq, struct file *f=
)
> > +{
> > +       struct fuse_file *ff =3D f->private_data;
> > +       struct fuse_conn *fc =3D ff->fm->fc;
> > +       struct file *backing_file =3D fuse_file_passthrough(ff);
> > +
> > +       seq_printf(seq, "fuse conn:%u open_flags:%u\n", fc->dev, ff->op=
en_flags);
>
> Note: The fc->dev is already accessible to userspace.
> The mnt_id field in /proc/PID/fdinfo/FD references a mount,
> which can be found in /proc/PID/mountinfo.
>
> And this file includes the device ID.
>

True, but the direct reference to conn here does not hurt.

> > +
> > +       if (backing_file) {
> > +               seq_puts(seq, "fuse backing_file: ");
> > +               seq_file_path(seq, backing_file, " \t\n\\");
> > +               seq_puts(seq, "\n");
> > +       }
> > +}
> > +

With unneeded includes fixed feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Please wait before posting v4 to give other developers and Miklos
a chance to review v3.

Thanks,
Amir.

