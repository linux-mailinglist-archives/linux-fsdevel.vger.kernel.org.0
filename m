Return-Path: <linux-fsdevel+bounces-10492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8A484B995
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 16:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D88292B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E3134759;
	Tue,  6 Feb 2024 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcT883gW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5B133400;
	Tue,  6 Feb 2024 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233310; cv=none; b=ccRz3RER6vvJ6c2RP14VuF8JM9SmP3cTfoXBN0pIEi3Wafr0lo5yBL1i4BG8ILKXee6ZEP0OqS0BRqpnp14cMjq04HgeciNxlPkRTnoW+7YVrh39MgSVevOwEy7RB0Kq8taZpuS0nNvwM5WT624YOQxV9aOJsQSpDxwzhEYmn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233310; c=relaxed/simple;
	bh=cjRFuh4HySsEJL5gpssoyDvPMupfO57ja4ej617fdz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9TNJMZaVPkfltKbKXvpTSL03Eb1XMjF7iqIcD/lIYPGLBNj/1Vl/28Y2Swqxu1ejXBl3dbh//TVnIbzD+zWhMAG5Kwx6+a+SuxQZi2d/ha9OTCKewy0Cj+SxkJpxnBAr56TsTftS86gPg65FGxpkqv4sojlBGV+e7gM3YKaooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcT883gW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-68c2f4c3282so27493106d6.3;
        Tue, 06 Feb 2024 07:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707233308; x=1707838108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXjPK0tA1yBTpHZUPdBmW8xYy02khEq+2MG2XFsWB/U=;
        b=JcT883gWNoG0eDJvmMiPk2X5WtvZ6xYKofhgLravHd9d+ghxJvb1hJh1urjMVETTKE
         3jBeBGqG6itX+Y9Pilt6c3jBvA+1zjv+1NVwqMK5uzrlABAz1rontW9Qe6u14g75T1Mz
         duPnTlSostHXJxSOWgq/SCjiSf5QxdehdFYEFjxt1rgi4cC0g6dKhTISH4potspB8nRD
         AiMqz3Qt9YFddf2ylK4PmtKftOP0mXpGv2fA9PWjlo38RUSpgKSLjuE7eQj+3nov7nt+
         exwGcLO3DyokgVpcxUdMbH7glbjDNZ/LQKUTOO4u4EzQWD5BaF/ERWllF1+A+uIDk6nk
         vW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233308; x=1707838108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXjPK0tA1yBTpHZUPdBmW8xYy02khEq+2MG2XFsWB/U=;
        b=m/1OfWfw/aZPM4y7LLwXEYrUXoD2Cp7vtbQ4UtveA+unR4o54M4qcWj1XD9VekwqSg
         qvfyw8KTZSCaIGVuUmKhzDEQtlTMTrFBwgBN+YTdhBEJ44SR8SknEoc5UjS/T9gzJVSb
         K/byMNJ/e1VzIuqQdB4nXH+W0CSJ0akssOdsndiMWNRq0LltryqA1VvFFuKYn4pCHHE7
         /J5JByzX+b0R2dbNMxUb5hAqMTBfdacZeEZxMkQ4a+ev7XZAAhEccTPOcEFcGPX+7jau
         CwhBD8TZrUvf63B7Uc9lNw4Sg8svkrM0YE1FT9xFe0JHiPt5wn9dBaE7RBBXx8jOQQWH
         tQkg==
X-Gm-Message-State: AOJu0YwDifvKPUjY9/E0j/R66V4xb7C4GDUvhNPmOX7yE027Fqw/w19e
	sKUQ1dZgBBSOzE/KBSVFJd6vz3vdpw7upvbLYsSmFL6Kj8vJTP8wqlTlxTpP8iVSufqeSm9RsuB
	f6Di961yL+0OS3QdCq8WY6k0RhLo=
X-Google-Smtp-Source: AGHT+IGbDqlmmzBuMYeMmDEVKXuq88SUElguKySS9+DL++pjTLpNYaNUYDVCQAlYxPOkLARlrzbHZ6YlcrsB7O4hx9Y=
X-Received: by 2002:ad4:5c8e:0:b0:68c:8422:6dec with SMTP id
 o14-20020ad45c8e000000b0068c84226decmr2651121qvh.37.1707233307960; Tue, 06
 Feb 2024 07:28:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110132.1584111-1-amir73il@gmail.com> <20240202110132.1584111-3-amir73il@gmail.com>
 <CAJfpeguhrTkNYny1xmJxwOg8m5syhti1FDhJmMucwiY6BZ6eLg@mail.gmail.com>
 <CAOQ4uxhcQfR6QP=oESUvhcwXh+vwBJUL+N1_XDZ5sFGk61HWGg@mail.gmail.com> <20240202-hemmung-perspektive-d84b93c25b00@brauner>
In-Reply-To: <20240202-hemmung-perspektive-d84b93c25b00@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:28:16 +0200
Message-ID: <CAOQ4uxj08Rio4fsx7b2JmXGTnxL5wVzcy97amHgw3AvSjETopw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:55=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Feb 02, 2024 at 02:41:16PM +0200, Amir Goldstein wrote:
> > On Fri, Feb 2, 2024 at 2:19=E2=80=AFPM Miklos Szeredi <miklos@szeredi.h=
u> wrote:
> > >
> > > On Fri, 2 Feb 2024 at 12:01, Amir Goldstein <amir73il@gmail.com> wrot=
e:
> > >
> > > > diff --git a/Documentation/filesystems/locking.rst b/Documentation/=
filesystems/locking.rst
> > > > index d5bf4b6b7509..453039a2e49b 100644
> > > > --- a/Documentation/filesystems/locking.rst
> > > > +++ b/Documentation/filesystems/locking.rst
> > > > @@ -29,7 +29,7 @@ prototypes::
> > > >         char *(*d_dname)((struct dentry *dentry, char *buffer, int =
buflen);
> > > >         struct vfsmount *(*d_automount)(struct path *path);
> > > >         int (*d_manage)(const struct path *, bool);
> > > > -       struct dentry *(*d_real)(struct dentry *, const struct inod=
e *);
> > > > +       struct dentry *(*d_real)(struct dentry *, int type);
> > >
> > > Why not use the specific enum type for the argument?
> >
> > No reason, we can do enum d_real_type.
>
> Fwiw, I'm happy to just change this. No need to resend as far as I'm conc=
erned.

FWIW, I'd be happy if you do that :)
Note to move enum d_real_type definition above dentry_operations.

Please add Stefan's Tested-by to both patches.

Thanks,
Amir.

