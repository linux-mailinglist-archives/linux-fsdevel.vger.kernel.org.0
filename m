Return-Path: <linux-fsdevel+bounces-10015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8984707F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 297BDB233CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D51872;
	Fri,  2 Feb 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5qsnfEW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48285185A;
	Fri,  2 Feb 2024 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877690; cv=none; b=l2wQP1DXXqL3p+gl2qS6fisWqgt2bfGtXcWtKXfFg21rY5BTG+5drpIDCg60EFhR1tv3fPcBKuPEkXvBVu017cjcLsn5VOOJAqbAXSDlikQkj8B6P4YZqIKluy4KulCe6PsoPe7BU0TO9xFu3AmoH4vgkszmneh44KEPPi1FVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877690; c=relaxed/simple;
	bh=DqCAzuoEq74A6y7jUgvbobN9H6bLzkMScjlUWPLWvqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4fpuIUbZiNj0s1MB8MMu2iwKUDanubO8tIMD41duIqSq+fETNn06KO8fzwYfJt8q2TNQG94HYo9On7seX71DhYtJegbPKOKKzcHjudY+6Np4a+DisTMGFUCfp8tL3vr1rd7JaUTK/HeeEcQoYBEKsJI+9kS8C8W7NgHYVh009c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5qsnfEW; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6041779e75eso21781927b3.3;
        Fri, 02 Feb 2024 04:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706877688; x=1707482488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqYYnNIAPfyQp/lOLSeExWubf4maT7vMZXeoVfYiZmU=;
        b=J5qsnfEWLnitCUmPKxO6iLWIy5CmMbVBWuwddo2f/zociVkirTiAPFmOQjNGaHH1gl
         nXBOdwxN3fBKnGI+XSk4yRUKGY1Il9oOzg2krHG/vggCTzrs2HBHKi9SD+WvjIOGjSHZ
         EynRXvqoRgts51VvSc345mGm2DhaTF7w/UN8/fCcocHbZro7NYYBU2J7qlnDX4hImiW5
         A6xgCosIp++pUGXCtSxxa5rHm3u7f08WNACpjMuwVhzNBSPnwmxndg0gd6dyOGN60qE9
         2YQdGA32PaDcGi4CuPv9VqKHO0gzRYbDWTUdVITg3jCsHvjS1bXbgnJ9Xuip2Nm1+EbY
         M4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877688; x=1707482488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqYYnNIAPfyQp/lOLSeExWubf4maT7vMZXeoVfYiZmU=;
        b=xHi7QU6Ri8EE/gWDpDhSF1G0XSA5mBGOEtyMOeLJyhMtRbVxZS4el2cdvYQN5CC3YV
         w+FzNwwDHZNNOEJaEB/kzaQ8tEfPQTWkoDWb009ikHiViu2KJGWJUT2fxGWwdlGqGt19
         14khxwtZAwOQS53THpf3zfrihkPmiSxAEu+A2w2KpwwkYdpoMgwKipPdKtxXNyQwKr4U
         QV2le8NOj8cDnD2GTtCZXG1YTey5mbVjC+gtvkXvHGkaHkwt9T0x7qbsv2p+qhRU35Z9
         hM1tdCH5VIgORszepezQmQqYA/tcb58w+nvQmlAGP0MkKpW/8n3ttvRIYckILhxZ0tSR
         N/Hg==
X-Gm-Message-State: AOJu0YwZ7Ur6XTkSNqHo3GkvfN50L7QXJbTfRPuVZrFx9/J1qaFy+/lE
	3e54MgYy5dGrrGRXVRjybSd0H4d6OruX19+TVtnq0c3kWszLhnCo6cfrfd1IV0+Kn+6Nfb8FIIH
	ncfwgh2TfyiTJjf9QdH5lC+P1YGw=
X-Google-Smtp-Source: AGHT+IGUeMVcp/PMXDXbjREYVYvTsstGTRsTqgi4wfbQMeHZFLFvGC0Ppx4vqx2EtvbTOpKuSPKEvCaLYSvrbg0iDj4=
X-Received: by 2002:a81:6c56:0:b0:5ff:44e8:6df5 with SMTP id
 h83-20020a816c56000000b005ff44e86df5mr2115142ywc.18.1706877688098; Fri, 02
 Feb 2024 04:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110132.1584111-1-amir73il@gmail.com> <20240202110132.1584111-3-amir73il@gmail.com>
 <CAJfpeguhrTkNYny1xmJxwOg8m5syhti1FDhJmMucwiY6BZ6eLg@mail.gmail.com>
In-Reply-To: <CAJfpeguhrTkNYny1xmJxwOg8m5syhti1FDhJmMucwiY6BZ6eLg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 2 Feb 2024 14:41:16 +0200
Message-ID: <CAOQ4uxhcQfR6QP=oESUvhcwXh+vwBJUL+N1_XDZ5sFGk61HWGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:19=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Fri, 2 Feb 2024 at 12:01, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > diff --git a/Documentation/filesystems/locking.rst b/Documentation/file=
systems/locking.rst
> > index d5bf4b6b7509..453039a2e49b 100644
> > --- a/Documentation/filesystems/locking.rst
> > +++ b/Documentation/filesystems/locking.rst
> > @@ -29,7 +29,7 @@ prototypes::
> >         char *(*d_dname)((struct dentry *dentry, char *buffer, int bufl=
en);
> >         struct vfsmount *(*d_automount)(struct path *path);
> >         int (*d_manage)(const struct path *, bool);
> > -       struct dentry *(*d_real)(struct dentry *, const struct inode *)=
;
> > +       struct dentry *(*d_real)(struct dentry *, int type);
>
> Why not use the specific enum type for the argument?

No reason, we can do enum d_real_type.

Thanks,
Amir.

