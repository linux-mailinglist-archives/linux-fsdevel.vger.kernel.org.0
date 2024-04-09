Return-Path: <linux-fsdevel+bounces-16460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5E389E031
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 18:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24981C2278A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE213D8A4;
	Tue,  9 Apr 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyjCd0W7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAE13DBB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679536; cv=none; b=HRZ5iiPFScu6GxgAj3Kni5RSyCoOGFI1EevD0Y1eUo/u2MiUEluLp2sSQ+YRzv9tf/5RdOq6gkdndsq5duwghx640+9afYMObER3FhJHa5Fyuh5uwsInjhBQ5smjLyelEaqCOOQNW9R24WnUwfkUz0hR3Tx+oZB8VOnAMBG/INI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679536; c=relaxed/simple;
	bh=CO0p+YK7KgyEhQWfSgbNED4ud13a2cNEHvB0bOG6pX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=De0jufO6VEttYNzX4O5iSxPGI6K+Y5YyVLUlqA28mPRGbFGvmVIqizlAMm9s6ZDCjzK9KKB/YMuxsr+4ndOJO74cArQqIl1AqBiqSEB4zqeByU6iqI774hrHfy9xWdtqFSzEPQ8ieYfqbvmg2Xqr66j3jSXaMnzFEd8vq5FA1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyjCd0W7; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6962e6fbf60so45546296d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 09:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712679534; x=1713284334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcUpxkvrOlvve5fPqRQfGZD9O5kSkS7ZKLRKI0qUmWk=;
        b=FyjCd0W7GZmJJMCNtokPDQntMEc/Gp27+lgk28xBX89v07hTHPBuA/LvyoxTBVl3n7
         9OszYfypsEQTEQyh5mYz7AhQJOhSPVEvbyp0qbLdjyyUxCZXzTd0TtJ65HI3+W37iJFE
         bXajHqtlm9q7TS+HNx6QraAQUVmQE+A5R4IMl+Lz4SKRjkkihbeWcttXltNkJCL9J0/e
         k/BNHg6nfiNZxKdZL2oXF2mihZU+i65A1km7vB5hVLi1gkDVMDCSRGCDEkZ5Lw/PCkut
         GAeSU2+N8nCrkCSsGkDa8wYdHQpRFJzqTVTTAEWuDx2HpR0MzTLvhER58i2z9YaJQSqO
         1uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679534; x=1713284334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcUpxkvrOlvve5fPqRQfGZD9O5kSkS7ZKLRKI0qUmWk=;
        b=aztwChTlFjRnBJ83n5LowFs2ziPqo5eaCXlCLjDi4wBnK+nS/fRw9qxWEcmS/niv6S
         TZVQkJ54qVHNdbJkfcU6PGUST6if3arj0jTmMByFAhsuWZZlp3m1F9YCgD6vPo2AXjM/
         oTQ6rfztp1xb68M4y38KJeOtVa9OtsCN+Lk1Yx+fugqDhyix+jLw/J0Dds/ChZ4BRah4
         cRm4cX4O/7xnJJwOZWHdjkTPKeqKGuuK/xvKszhtTYiQ8MbReXbRRt0DFCjWXFJFgcUV
         u9z1MtaRCn4gILJj611CkVvvVjd4GBJGb4CIMLGtOu0uA9OtjwP182Lg0/kHilsRzAJo
         TKkg==
X-Forwarded-Encrypted: i=1; AJvYcCV4uMiKfHIe2sBlVziuLEAMy4KpvdxEOnq79+uwEuVBqV9MLtQfGBRYuV4v1m881Vq5u/g8L/l3qojSYdsj8K1xFz1wTVxVQgIqR0kg0g==
X-Gm-Message-State: AOJu0YyqgnwWBuBTfL/DaPCkaSxn7VIT9hbYP8Jhm8c0lRTBDIyJf7Dv
	tr51HGxnP7BnWPrOS/rE95qTyRt+M+gL9Ep9ZKTHlLf6+VQWbBYblPJtiiZDl9/h+AIzBcpJIMR
	Wt/+jQU5a9oU8MxAwSQpQJaaBEaI=
X-Google-Smtp-Source: AGHT+IFWVhY1apzQnxWWvPRedKJdIK65r6JtsmezaqmlhMzO66LmsabZxIYPhPltLWvkBNm7Z973Nku17RN89QHxg5k=
X-Received: by 2002:ad4:5de2:0:b0:699:2782:d256 with SMTP id
 jn2-20020ad45de2000000b006992782d256mr42465qvb.11.1712679533764; Tue, 09 Apr
 2024 09:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407155758.575216-1-amir73il@gmail.com> <20240407155758.575216-2-amir73il@gmail.com>
 <CAJfpegs+Uc=hrE508Wkif6BbYOMTp3wjQwrbo==FkL2r6sr0Uw@mail.gmail.com>
 <CAOQ4uxgFBqfpU=w6qBvHCWXYzrfG6VXtxi_wMaJTtjnDAmZs3Q@mail.gmail.com> <CAJfpegtFB8k+_Bq+NB9ykewrNZ-j5vdZJ9WaBZ_P2m-_8sZ5EQ@mail.gmail.com>
In-Reply-To: <CAJfpegtFB8k+_Bq+NB9ykewrNZ-j5vdZJ9WaBZ_P2m-_8sZ5EQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 9 Apr 2024 19:18:42 +0300
Message-ID: <CAOQ4uxjtDAuMezRXCiVpBPoTXt6d5G0TWJxb=3QVCvp1+VN59w@mail.gmail.com>
Subject: Re: [PATCH 1/3] fuse: fix wrong ff->iomode state changes from
 parallel dio write
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 6:32=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Tue, 9 Apr 2024 at 17:10, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Apr 9, 2024 at 4:33=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> > >
> > > On Sun, 7 Apr 2024 at 17:58, Amir Goldstein <amir73il@gmail.com> wrot=
e:
> > > >
> > > > There is a confusion with fuse_file_uncached_io_{start,end} interfa=
ce.
> > > > These helpers do two things when called from passthrough open()/rel=
ease():
> > > > 1. Take/drop negative refcount of fi->iocachectr (inode uncached io=
 mode)
> > > > 2. State change ff->iomode IOM_NONE <-> IOM_UNCACHED (file uncached=
 open)
> > > >
> > > > The calls from parallel dio write path need to take a reference on
> > > > fi->iocachectr, but they should not be changing ff->iomode state,
> > > > because in this case, the fi->iocachectr reference does not stick a=
round
> > > > until file release().
> > >
> > > Okay.
> > >
> > > >
> > > > Factor out helpers fuse_inode_uncached_io_{start,end}, to be used f=
rom
> > > > parallel dio write path and rename fuse_file_*cached_io_{start,end}
> > > > helpers to fuse_file_*cached_io_{open,release} to clarify the diffe=
rence.
> > > >
> > > > Add a check of ff->iomode in mmap(), so that fuse_file_cached_io_op=
en()
> > > > is called only on first mmap of direct_io file.
> > >
> > > Is this supposed to be an optimization?
> >
> > No.
> > The reason I did this is because I wanted to differentiate
> > the refcount semantics (start/end)
> > from the state semantics (open/release)
> > and to make it clearer that there is only one state change
> > and refcount increment on the first mmap().
> >
> > > AFAICS it's wrong, because it
> > > moves the check outside of any relevant locks.
> > >
> >
> > Aren't concurrent mmap serialized on some lock?
>
> Only on current->mm, which doesn't serialize mmaps of the same file in
> different processes.
>
> >
> > Anyway, I think that the only "bug" that this can trigger is the
> > WARN_ON(ff->iomode !=3D IOM_NONE)
> > so if we ....
> >
> > >
> > > > @@ -56,8 +57,7 @@ int fuse_file_cached_io_start(struct inode *inode=
, struct fuse_file *ff)
> > > >                 return -ETXTBSY;
> > > >         }
> > > >
> > > > -       WARN_ON(ff->iomode =3D=3D IOM_UNCACHED);
> > > > -       if (ff->iomode =3D=3D IOM_NONE) {
> > > > +       if (!WARN_ON(ff->iomode !=3D IOM_NONE)) {
> > >
> > > This double negation is ugly.  Just let the compiler optimize away th=
e
> > > second comparison.
> >
> > ...drop this change, we should be good.
> >
> > If you agree, do you need me to re-post?
>
> Okay, but then what's the point of the unlocked check?

As I wrote, I just did it to emphasize the open-once
semantics.
If you do not like the unlocked check, feel free to remove it.

Thanks,
Amir.

