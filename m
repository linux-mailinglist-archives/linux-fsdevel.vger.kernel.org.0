Return-Path: <linux-fsdevel+bounces-36544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7919E592A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 16:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F213F2866AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841321D592;
	Thu,  5 Dec 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbb/hXUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E721C17A;
	Thu,  5 Dec 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410884; cv=none; b=XNjCSfQTCevxFAUYSWGxQnrXe72Q4qcHBAM6QEjim6xb1N4oFdCbwrivNifK/ebv1QVj5YTNTjg4YRNecglHNqKP6dA0KN52Rbkj4VYWKZtGDqvqWmP/qG0qdOPYnlFihgADTqGWVE322um/RgsKU9RADbzhAwOZrd/UFfopu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410884; c=relaxed/simple;
	bh=32+CJqDKBBYrano28xI9iTislDBNNftxRAma1GTarWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hbxu74wBEAhwLAL203ZHYFon5rIB96SmoBfMe6g9RU79f8sm4RfzMbLfnRhXtIe/WGMHW54WkOZafLAkFi8lw7edRtbnJXNitcAebZ0h2sIFXrLIG6w1WJuIoP6IgV/h5fi1mMSH/UofOngx4gNSmh/9QX2g9aygeIcjvLq8DcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbb/hXUJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5366d3b47so158023666b.0;
        Thu, 05 Dec 2024 07:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733410880; x=1734015680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN9wur985IhwLsPry0rLDiupeRbIGyxtPRWJvIg6Gcg=;
        b=fbb/hXUJVzCxIF2WKuDYowfviMzq/AKJkJGHOM2t/Lh2zlqW4GFBOyMkrp0RA0l22A
         1/adLOo+PmfF4Rb4gPkolx1JJWV5LSxt10DHeAzfdtNQ59hzcRPZUAfNfOyjN5aLRID/
         HfeIivbQByvNoJuywjwZcRowYs+dtL4cdH/HTrsXaSVhNGU1ky7PuT1peCD88MoewJRb
         WhyMaedRV3J7bRbVNHB3Uksitfv9kE7G4qOyPFQOPV3US5mOePfFx1W+O2tTt9rP49If
         YVenDoU50p3AScVK5XkDFHgwFVkBLFDEpapgfYNB9ZM8NSd9qse1eEuxVltyaTYmelcM
         YAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410880; x=1734015680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN9wur985IhwLsPry0rLDiupeRbIGyxtPRWJvIg6Gcg=;
        b=PUdKfWsyD0ogGb9VYwEvte8FSAew0dEa/q3DFbf8NWhdIoWuWHf6dTnUnwryWlTC57
         tudaNa+kiLZgp+pqLvid4OD+VgZnfkVJA74PLFiFvebdMtwANL5FvPJT+yUw02kdHih1
         wDTV4smsZp54Y3UavKiVQ+v4L/RJlndBGO75vHpkZW8otK/+lLqbXCdhU48gIHnXOO2J
         y/PFxAHHC9/0OuZWXRGYao1Xl4oWcfGOkQysN88foSMJt8c6uPgs9Wzc9g7EICgbzVn6
         SWCqDmVggQp+mLQM25AcpI3N9dhMfKJeymKQUmTg1wmojVabQ5GeLjPEeMDw82y02roS
         C0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMD6gYzvdyapHhO/n676hL+0huCjpi4tXqdO3v8evRzMqa1/ENJewduQsjRp+ugqAzYTgJOyqSaDB3E54E@vger.kernel.org, AJvYcCWb8LCU6Nza3BmrlQTh/UDBFbR3O5HdzD9nAP4eAf404NELIy98Imkav/ouXYVZ1PBv80yRAr3YzaRMWgZa@vger.kernel.org
X-Gm-Message-State: AOJu0YzcrTP04jP2Zh0Gt4NuXpaa7RoAA0X5DCMAR3fw9R1nsXK9uW06
	Ghi+aB1Go7Pkma2xB2a4EiFde+xXo4Z4Xo5BbMerOpH/ZMogjWegDU+xgGQAyEJmbuQPqbNiwbm
	UYZoXRJMKQNBCrddd2SMD4nZ/5cc=
X-Gm-Gg: ASbGnctqOP94+dVsxA5O95JKVQ9QfQE9n2DnYP4eKpfGkARhXiYp5sUHBVTOj4n8ErX
	yInGXPArFmWwdU5/rmPC+xJmNJXe7Hg==
X-Google-Smtp-Source: AGHT+IHmGVFTKO1q2awLANMc/E5GvdovTMTgmHHx18KdhQ42DT9+Ay9A56bSFJ8AqpYL6ahFCdvAJ4nE81a2JO3+cJk=
X-Received: by 2002:a17:906:3caa:b0:aa6:1afe:b248 with SMTP id
 a640c23a62f3a-aa61aff0be8mr343868566b.57.1733410879840; Thu, 05 Dec 2024
 07:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205144645.bv2q6nqua66sql3j@quack3>
In-Reply-To: <20241205144645.bv2q6nqua66sql3j@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 16:01:07 +0100
Message-ID: <CAGudoHGtOX+XPM5Z5eWd-feCvNZQ+nv0u6iY9zqGVMhPunLXqA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: Jan Kara <jack@suse.cz>
Cc: paulmck@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:46=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 05-12-24 13:03:32, Mateusz Guzik wrote:
> > See the added commentary for reasoning.
> >
> > ->resize_in_progress handling is moved inside of expand_fdtable() for
> > clarity.
> >
> > Whacks an actual fence on arm64.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> Hum, I don't think this works. What could happen now is:
>
> CPU1                                    CPU2
> expand_fdtable()                        fd_install()
>   files->resize_in_progress =3D true;
>   ...
>   if (atomic_read(&files->count) > 1)
>     synchronize_rcu();
>   ...
>   rcu_assign_pointer(files->fdt, new_fdt);
>   if (cur_fdt !=3D &files->fdtab)
>           call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
>
>                                         rcu_read_lock_sched()
>
>                                         fdt =3D rcu_dereference_sched(fil=
es->fdt);
>                                         /* Fetched old FD table - without
>                                          * smp_rmb() the read was reorder=
ed */
>   rcu_assign_pointer(files->fdt, new_fdt);
>   /*
>    * Publish everything before we unset ->resize_in_progress, see above
>    * for an explanation.
>    */
>   smp_wmb();
> out:
>   files->resize_in_progress =3D false;
>                                         if (unlikely(files->resize_in_pro=
gress)) {
>                                           - false
>                                         rcu_assign_pointer(fdt->fd[fd], f=
ile);
>                                           - store in the old table - boom=
.
>

I don't believe this ordering is possible because of both
synchronize_rcu and the fence before updating resize_in_progress.

Any CPU which could try racing like that had to come in after the
synchronize_rcu() call, meaning one of the 3 possibilities:
- the flag is true and the fd table is old
- the flag is true and the fd table is new
- the flag is false and the fd table is new

Suppose the CPU reordered loads of the flag and the fd table. There is
no ordering in which it can see both the old table and the unset flag.


--
Mateusz Guzik <mjguzik gmail.com>

