Return-Path: <linux-fsdevel+bounces-8303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243183296E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 13:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C53B227BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jan 2024 12:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178D4F1FB;
	Fri, 19 Jan 2024 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3Gpnp77"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FC4F1E9;
	Fri, 19 Jan 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705666792; cv=none; b=uq9EnKDFDQDVDnDGTLI0ClDOja15mlQwJ4uDffelMZL++wH2hBKm/VPGpiO4SeTUXtzDpeUGsaFeoHqB4k2P68eFCDzu8HHZxaNT5UUQb12uJIQdcMvMLl8Vw/IrbzJvVeI9KVusJK/ZGPqSuKsWJP9xrFwooOgsws4lQUqUA8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705666792; c=relaxed/simple;
	bh=i+n/61kgcWXkxPHcQA/07eg6ZlpXHzcB6n/jUClBaxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=El5jjCBb5XILyov9XOnorg/DmQI3rx3xSDFtFKErdYbdyED3UeGpfZ21u1j4ukWIqNjQRpZre80qX+8FDFBETLrB9MQiXXbiuh1NsvmOhw92Y7uqD2B584dIhOat7Wml0Hn0JPaQeqz814SqxGOjtGke2X9GUfEzG64tgF1dH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3Gpnp77; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6818a9fe3d4so3486266d6.0;
        Fri, 19 Jan 2024 04:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705666789; x=1706271589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPPT+g6/vYfGybVNL7MiSin3lpq9T6t1bR8kIbX9sOA=;
        b=G3Gpnp77o6hQIBP/kcM1/KVR0rgDQ0DpB6weUNeTeUQKLz0z/3nFxdGGqNNZRhFmaT
         qq26TZm09bCCuC6lK+q9p1I8D/h9HPD6Dau1VaNLghgKQSSVWgJ4a+YTdD0VX4+BY1DR
         +iRiThQ46pmihEiFmGIeFAu1601fotsmDii0FTmIUKzoswkCAoAFJQJD7AblxsIglgG7
         j+gNHWXgng3wdJkT/ww6OMnH4CqM5FsYGKHbttarlg+nC29V6SzfA2WJv3mT7Q8DFLxu
         yUu4BIqYorYvmQZ3GbGIzBfJAG/e40MxXAlFOZHwzqVQTe9FsfUfEE8UWQfOQwJo1+Ls
         WHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705666789; x=1706271589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPPT+g6/vYfGybVNL7MiSin3lpq9T6t1bR8kIbX9sOA=;
        b=QSSV044kYRs1vr2L0/oou8e/tWIIejCAkZG+nOqzaZkwe0MkLZ4PxPTzGJZHbpRyc8
         oJbvL1T+JE7o+7OxaMSKHakQufTBpZcgGY2e7J4juSOA7IpgC5VW9/q/yvm85wPLk5Zf
         Bv/ijx3/LgPwKw+HE0K8sC+Y6qWKkgeUEZIecXHLesZpMF/jH2KiaqKjGt/bLMkoVJHs
         CG5VMAsvL8aNkTfsoChHDmqhniDch31RD5Bya8iGgZQgnYjAr5/+vvtyJOEpRTn7kuP9
         +CVC776I0mNEbJ0M1wQ0nRMAHNtfiW7r4A50SJ/dOpabjpTsY6VyOkuxk9TCP3yG/orV
         pW5w==
X-Gm-Message-State: AOJu0Yx7Zwlkt2/osr8XDlkTjlfBErpAk9sBRTZ7l8Kegd8/6PG7bDv0
	OQjHd4lz5BIcHSXp6lUdXnJC/CtoOmSqXJN8xZ4ZNueYFFuGFhIg9mbD7V9cEETzvGMXwuRdblP
	Am7/7EbtvK2N9qClpQO64drfITkU=
X-Google-Smtp-Source: AGHT+IEFwpuBF1HdsF/5uYHgYZTKeoyCK3qVffO/KRZKfseiCB5bxwA/RuVC3vQ0nJZ72hZQDb1QDYYpb5VHo16JstU=
X-Received: by 2002:a05:6214:21c4:b0:681:86ff:ebb with SMTP id
 d4-20020a05621421c400b0068186ff0ebbmr2796964qvh.9.1705666789546; Fri, 19 Jan
 2024 04:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119101454.532809-1-mszeredi@redhat.com> <CAOQ4uxiWtdgCQ+kBJemAYbwNR46ogP7DhjD29cqAw0qqLvQn4A@mail.gmail.com>
 <CAJfpegteroc6yJAmjh=MaqZOO9Q7ZJfg5BgMJFN3wdHGZK6gGw@mail.gmail.com>
In-Reply-To: <CAJfpegteroc6yJAmjh=MaqZOO9Q7ZJfg5BgMJFN3wdHGZK6gGw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jan 2024 14:19:38 +0200
Message-ID: <CAOQ4uxhVwnhOLxbfAjeGkwXA2iOz=-BXZNKUtY29UN_zTDtfCg@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: require xwhiteout feature flag on layer roots
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:20=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 19 Jan 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > @@ -577,6 +580,8 @@ static int ovl_dir_read_impure(const struct path =
*path,  struct list_head *list,
> > >         INIT_LIST_HEAD(list);
> > >         *root =3D RB_ROOT;
> > >         ovl_path_upper(path->dentry, &realpath);
> > > +       if (ovl_path_check_xwhiteouts_xattr(ofs, &ofs->layers[0], &re=
alpath))
> > > +               rdd.in_xwhiteouts_dir =3D true;
> >
> > Not needed since we do not support xwhiteouts on upper.
>
> Right.
>
> > > @@ -1079,6 +1090,8 @@ static int ovl_get_layers(struct super_block *s=
b, struct ovl_fs *ofs,
> > >                 l->name =3D NULL;
> > >                 ofs->numlayer++;
> > >                 ofs->fs[fsid].is_lower =3D true;
> > > +
> > > +
> >
> > extra spaces.
>
> Sorry, missing self review...
>
> > Do you want me to fix/test and send this to Linus?
>
> Yes please, if it's not a problem four you.
>

ok. queued.

Thanks,
Amir.

