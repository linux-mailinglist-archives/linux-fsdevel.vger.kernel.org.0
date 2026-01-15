Return-Path: <linux-fsdevel+bounces-73865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C06D221F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 03:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DDC230142ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 02:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45962765C3;
	Thu, 15 Jan 2026 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEsBLu9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43962749D5
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768444179; cv=none; b=gyIfC+q8Ra2v347oJ2AZZZjCJg0Ki6lEj1K79DS+aBXkAtiRp+usoPhTWTm3bAca2krccrtQmHLTxH7isH7lwecLuxJT6fgw16FN6fiNJxgzWzaNQLxKpcK6aQymCIvhkCfY5EgIRbCHemRatcegH/CC38WcGFsXolUbcsahA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768444179; c=relaxed/simple;
	bh=diUja6qM5LyOCPUrVQXbYOfqEDBoswsd2xlg68Uo98I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bonRD3Snydkur6bUdWzunQ4aIOvlKERn1STyI7wUdKJyhi4ORzCpcuqla3xA8Kk7cvmSU+kM4zAfaCh5LDMTq6TzSSgZpKgzpa4TOtE5IhtSLPCWsde/4LvhvHpq7gVPAUuQb0PvGC2815fjfQlkIz1ksLTuegEEYepMT3FFPQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEsBLu9y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee1939e70bso4867341cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 18:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768444177; x=1769048977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2CTAC4LVLivjh8dGHfy49XRcPMr6NuyZg3n2gNjayk=;
        b=eEsBLu9yOMmDqzX7xLQQ/EMMqetihvRXzJY98DA8VkjlZL0WDhN0jb2W7MkL9a4T5f
         NPIN4IIZ7sMPB1lFNgiNabiWQZH48aPs7MAzdx3hqy3Dpqb0hOaZ8uWkbA7pkMg1afyS
         SucI+4FCslAjRD8lZ7bmB2f5maGND6ojsMXs3Q4Hsp3/sL/ETbSiU80O5cnvmQo1Q8Qg
         rrlY5MrKsU/IF3A01vxbA3omKX28POGdPaUncPwkPKvhXesE1Ookok4ozn+GaS1mhP9r
         0oiFA7I6RyKeuTYl6pOSTR7OnXzKKnIBe9L/+yb4W1BzHtLUldsIWRtZV1uouBVMw1tS
         wiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768444177; x=1769048977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2CTAC4LVLivjh8dGHfy49XRcPMr6NuyZg3n2gNjayk=;
        b=M1xyWCxk29IbyFZ10qAku0JKPKM1C9UdV0QN66fALqNqegp8o0HaVaiYuZqLppplMR
         +bQiFnMtuV6bNnOJBxpo0sAFKjZp4Qnv4dS2hp6tiSP9o8/GU2gkwA8/sbQy3Hc+8yDe
         J7LILPx+FEtXa4VvjCZbzunzsH/2WzzYmjN+m6+7dW3sz6dXEhLMdFkhTcBoyYvxo+VU
         oP/IQzJr0mFSQ+gli+ORQ8JzCUcHfDfsko7qi/ijFSv/OIGLBUYLpUrE3zlTNCpUgen0
         kTlM6c5zvOcQEP7ZBuEXbKoIg+f3EQwMkOeN3rZgAPAouRitkSbkFonwxNZoqzMMmYVn
         CwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrz0RniFEhrTCLtv8UFhReqUJfat2+f4qbl4ripO9ozrVQ3MMvbIsVdUoHE3yRcVTWc5DlnAejs/ZVbQgl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hRoUvX+GiVse41kFlOprKKwnqtWuRoed4pnbpcotAANIqcpa
	cqJxhnOBSDdXW6XCwvFh2hoFifYk48hk03G8Zmp57fh9mlEJ9+chiw2r7/CSO1hPJQbw633iZM3
	KyS07Al1YyN4/EFcbMUk65zph8JnnB9Y=
X-Gm-Gg: AY/fxX4aD+YbvABa23zueZSZBII18l0/s8XKZWJC8vrZ1LI4pDEa5gjuivT1dwcsfJi
	+RIwAsxLzCHPRCx3Lp7gMqudMXOBwgWK3qaH5XC7RTKVSX5lzPwCURUykNo37++Cekky5+noIU7
	2f6fY+Z9JnLbTNZ3XHGP/iJWaxRE1NqbaFHQm0c08uuKCR8IDQg4O0epVPVAzoqNXzAf+E0nA77
	buox3wAL+SPmDqjsHa+/+XnLFG6Cv6JqDtnh+MM3JUXSPocntbMB32iswT8nB2IslQFyQ==
X-Received: by 2002:ac8:5d09:0:b0:4ff:a9d2:d070 with SMTP id
 d75a77b69052e-5014a9914c3mr51252701cf.71.1768444176871; Wed, 14 Jan 2026
 18:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com> <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
In-Reply-To: <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Jan 2026 18:29:26 -0800
X-Gm-Features: AZwV_QhbKRfLBwcnKblMSJhbC8elHNceBuFEk_zw_EfFxErRGm43U9gEQ4mn-7g
Message-ID: <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 10:27=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> The discussion about compound commands in fuse was
> started over an argument to add a new operation that
> will open a file and return its attributes in the same operation.
>
> Here is a demonstration of that use case with compound commands.
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
>  fs/fuse/file.c   | 110 +++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  fs/fuse/fuse_i.h |   7 +++-
>  fs/fuse/inode.c  |   6 +++
>  fs/fuse/ioctl.c  |   2 +-
>  4 files changed, 107 insertions(+), 18 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 53744559455d..c0375b32967d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -152,8 +152,66 @@ static void fuse_file_put(struct fuse_file *ff, bool=
 sync)
>         }
>  }
>
> +static int fuse_compound_open_getattr(struct fuse_mount *fm, u64 nodeid,
> +                                     int flags, int opcode,
> +                                     struct fuse_file *ff,
> +                                     struct fuse_attr_out *outattrp,
> +                                     struct fuse_open_out *outopenp)
> +{
> +       struct fuse_compound_req *compound;
> +       struct fuse_args open_args =3D {};
> +       struct fuse_args getattr_args =3D {};
> +       struct fuse_open_in open_in =3D {};
> +       struct fuse_getattr_in getattr_in =3D {};
> +       int err;
> +
> +       compound =3D fuse_compound_alloc(fm, 0);
> +       if (IS_ERR(compound))
> +               return PTR_ERR(compound);
> +
> +       open_in.flags =3D flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
> +       if (!fm->fc->atomic_o_trunc)
> +               open_in.flags &=3D ~O_TRUNC;
> +
> +       if (fm->fc->handle_killpriv_v2 &&
> +           (open_in.flags & O_TRUNC) && !capable(CAP_FSETID))
> +               open_in.open_flags |=3D FUSE_OPEN_KILL_SUIDGID;
> +
> +       fuse_open_args_fill(&open_args, nodeid, opcode, &open_in, outopen=
p);
> +
> +       err =3D fuse_compound_add(compound, &open_args);
> +       if (err)
> +               goto out;
> +
> +       fuse_getattr_args_fill(&getattr_args, nodeid, &getattr_in, outatt=
rp);
> +
> +       err =3D fuse_compound_add(compound, &getattr_args);
> +       if (err)
> +               goto out;
> +
> +       err =3D fuse_compound_send(compound);
> +       if (err)
> +               goto out;
> +
> +       err =3D fuse_compound_get_error(compound, 0);
> +       if (err)
> +               goto out;
> +
> +       err =3D fuse_compound_get_error(compound, 1);
> +       if (err)
> +               goto out;

Hmm, if the open succeeds but the getattr fails, why not process it
kernel-side as a success for the open? Especially since on the server
side, libfuse will disassemble the compound request into separate
ones, so the server has no idea the open is even part of a compound.

I haven't looked at the rest of the patch yet but this caught my
attention when i was looking at how fuse_compound_get_error() gets
used.

Thanks,
Joanne

> +
> +       ff->fh =3D outopenp->fh;
> +       ff->open_flags =3D outopenp->open_flags;
> +
> +out:
> +       fuse_compound_free(compound);
> +       return err;
> +}
> +

