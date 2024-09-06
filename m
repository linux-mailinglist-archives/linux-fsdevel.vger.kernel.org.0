Return-Path: <linux-fsdevel+bounces-28839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140196F191
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A841C21176
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F80A1C9EC1;
	Fri,  6 Sep 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ1wdxeP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F391C8FD8;
	Fri,  6 Sep 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618858; cv=none; b=CGxmGf51lebeiFH4KPoEoAIk5V0+htiO/2VAJrdi1Z1k0CHVDVmlqGBb8Q+GdkEwjdb0sTCgmj55Aipofe3zWN8Fnyi2/VZ1N8wAv1iq29Oxo5ukW9B31/4WA6xRTU0N2y5yEOVOela02r3HtFq5jmNcF1rBSDLtzES0Z+KHQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618858; c=relaxed/simple;
	bh=c1fZU+TxJhO3ckN5Z8ztvzcDiY96Bvf4lSA9nL5Ac1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NSUMfXYbVTnCLIPM7xz7DT1ymAGTe1p+dZH19fOEmM14kSJe3XidNE2pvQ2u5e9w9UEkYYN2zxEdQJcs1d188fgk33Y8y7i4N3sq077aPOFGx5bQAUCRuCKCZEQIzs6L0oE0AmgjrWO29RRbgyoJnPMWEc3XLnXqKSDH30N0Yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ1wdxeP; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49bdc6e2e3dso309400137.3;
        Fri, 06 Sep 2024 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618855; x=1726223655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c7arQ1vOOTIRZc+s6ypuOjDH2RPL6P4Bh6fBBps064=;
        b=EQ1wdxePQL6/lYDXIHVSN9wFtpg8Hikh3QC3CftK8sfDalU/8t6EXjA9yIT8NoqhCX
         IDJgNWE78kZWAQqWpVQUBx9+Z2O1pqcwham45E0rfsDf00MhAd4bKCLgFmr+HL/m/dIR
         W4o+xIBuhYc+Pf/E8/qP9s4zmW5MXCMOTIHCqVpIFdmNRfMKpDQUs8m90T1DsZEv6WAi
         +3BwWonctjtRAnchzqevPogROa+9oQbUHXjuA5/rsynV6uNvtHWvZ+khXFXvqQcMka7f
         FnV6G2e509T7U1vh7Way8dBBdRuyb97qGLnQdk5kiJOZ0j7L/QF0jGYj6KgTbyKeQQAv
         GIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618855; x=1726223655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c7arQ1vOOTIRZc+s6ypuOjDH2RPL6P4Bh6fBBps064=;
        b=hp0OlwPu4OTzN6h58v8y6To1YEU9//Nre+G1lMkA0tFf13NXFaUeHEkgqitUPWdTwc
         wo9MKhSpZpNel14I1NAfzq4+w8nZVxRdJFvzrJq0IW1Y2kUQ7VQp1r+emIwH/tzL2Ic/
         4mWXkMG3jrwweopdrb916ko6yz+oadFft+lAlmdQgioG6+TbBWH2wR9ks0A8OyJB4rjl
         nMQVSKgFntTqsIsc436jxiFO8TlHhKapBDRY3ytMRCLCi5+05WRddZRO6ipTjvuwhj6v
         oDaFnT6klX09cFhBztUXJAq9+XH4W3PMrl1TF3UhftTalNa7jgHyC3pUPWuB0ECZuqQC
         OJZA==
X-Forwarded-Encrypted: i=1; AJvYcCWxpJeKLi6zcXgEn/RYvNU1rQrVVYIhjhQ0nRZVId6dWhoUbwrL52NaJom9IC5KWj15R6kkD/pE2BHj/1wt@vger.kernel.org, AJvYcCXPyROpgWRnODHFws01Cbv1GVj0b3lKE8O+END00OoBPWLt7XCxuFQZqFsqI8zjDOHnMqbiBMMozuQFGaiz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pLJ2+i+SjLd1uwtcmqilGiTS8kxgQaV1TbJ+MCmeMJnqyJkM
	O+qY6ego4rJVKzByYca2TPRRq2B8JhPwcKx/EGR8ATcYjfiRnQH0gxQzW0/s2CPbx5idStO0q+y
	ESqAV9BMLhQDVad6+eHWCZolV4Ns=
X-Google-Smtp-Source: AGHT+IGnRsvdGg2xjXX4/7DRlCP6WawHt3UxzXrnb2+YsvR6JLsq4270qn1DIEklR/jsXdB1Wbi+ozu0GKhg7WGkABU=
X-Received: by 2002:a05:6102:292a:b0:498:cdb0:1d03 with SMTP id
 ada2fe7eead31-49bde263682mr2405667137.23.1725618855133; Fri, 06 Sep 2024
 03:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906080047.21409-1-hailong.liu@oppo.com> <CAGsJ_4yAp=VF4c12soA0U5dzX-ksb3FV4UnC5e7Jtp+D6BO4iw@mail.gmail.com>
 <20240906095554.dkanjjn2yj6z3g3j@oppo.com>
In-Reply-To: <20240906095554.dkanjjn2yj6z3g3j@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 6 Sep 2024 22:34:00 +1200
Message-ID: <CAGsJ_4xd=O8pDz4_hWZ+k8Je7=y9BwnZMw=tfcprN5DaTArtjw@mail.gmail.com>
Subject: Re: [PATCH] seq_file: replace kzalloc() with kvzalloc()
To: Hailong Liu <hailong.liu@oppo.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 9:56=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> w=
rote:
>
> On Fri, 06. Sep 21:25, Barry Song wrote:
> > On Fri, Sep 6, 2024 at 8:06=E2=80=AFPM Hailong Liu <hailong.liu@oppo.co=
m> wrote:
> > >
> > > __seq_open_private() uses kzalloc() to allocate a private buffer. How=
ever,
> > > the size of the buffer might be greater than order-3, which may cause
> > > allocation failure. To address this issue, use kvzalloc instead.
> >
> > In general, this patch seems sensible, but do we have a specific exampl=
e
> > of a driver that uses such a large amount of private data?
> > Providing a real-world example of a driver with substantial private dat=
a could
> > make this patch more convincing:-)
> >
> To be honest, it's a bit embarrassing, but the issue is that my own drive=
r
> allocates 256K of memory to store data. :)
>
> Howeve I grep the __seq_open_private in drivers and found
> https://elixir.bootlin.com/linux/v6.11-rc5/source/drivers/net/ethernet/ch=
elsio/cxgb4/cxgb4_debugfs.c#L3765
> static int ulprx_la_open(struct inode *inode, struct file *file)
> {
>         struct seq_tab *p;
>         struct adapter *adap =3D inode->i_private;
>
>         p =3D seq_open_tab(file, ULPRX_LA_SIZE, 8 * sizeof(u32), 1,
>                          ulprx_la_show);
>
> ->                      seq_open_tab...
> ->                              p =3D __seq_open_private(f, &seq_tab_ops,=
 sizeof(*p) + rows * width);
> ->                              ULPRX_LA_SIZE * 8 * sizeof(u32) =3D 32 * =
512 =3D 16384 =3D order-2
> ->      if system is in highly fragmation, order-2 might allocation failu=
re.
>         if (!p)
>                 return -ENOMEM;
>
>         t4_ulprx_read_la(adap, (u32 *)p->data);
>         return 0;
> }
> So IMO this issue might also be encountered in other drivers.
>
> I should also change the comment in Documentation/filesystems/seq_file.rs=
t
> ```rst
> There is also a wrapper function to seq_open() called seq_open_private().=
 It
> kmallocs a zero filled block of memory and stores a pointer to it in the
> private field of the seq_file structure, returning 0 on success. The
> block size is specified in a third parameter to the function, e.g.::

That's correct. Additionally, we should update the changelog to specify
that 'the buffer size might exceed order-3, potentially causing allocation
failures,' as order-2 could also be a concern, using
drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c as an instance.

>
>         static int ct_open(struct inode *inode, struct file *file)
>         {
>                 return seq_open_private(file, &ct_seq_ops,
>                                         sizeof(struct mystruct));
>         }
> ```
>
> if the patch be ACKed. I will add this in next version.
>

not the authority to acknowledge this, but personally, it makes a lot of
sense from the memory management perspective. Please feel free to add
Reviewed-by: Barry Song <baohua@kernel.org>

If you plan to send a v2 to correct the changelog and documentation.

> > >
> > > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > > ---
> > >  fs/seq_file.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > > index e676c8b0cf5d..cf23143bbb65 100644
> > > --- a/fs/seq_file.c
> > > +++ b/fs/seq_file.c
> > > @@ -621,7 +621,7 @@ int seq_release_private(struct inode *inode, stru=
ct file *file)
> > >  {
> > >         struct seq_file *seq =3D file->private_data;
> > >
> > > -       kfree(seq->private);
> > > +       kvfree(seq->private);
> > >         seq->private =3D NULL;
> > >         return seq_release(inode, file);
> > >  }
> > > @@ -634,7 +634,7 @@ void *__seq_open_private(struct file *f, const st=
ruct seq_operations *ops,
> > >         void *private;
> > >         struct seq_file *seq;
> > >
> > > -       private =3D kzalloc(psize, GFP_KERNEL_ACCOUNT);
> > > +       private =3D kvzalloc(psize, GFP_KERNEL_ACCOUNT);
> > >         if (private =3D=3D NULL)
> > >                 goto out;
> > >
> > > @@ -647,7 +647,7 @@ void *__seq_open_private(struct file *f, const st=
ruct seq_operations *ops,
> > >         return private;
> > >
> > >  out_free:
> > > -       kfree(private);
> > > +       kvfree(private);
> > >  out:
> > >         return NULL;
> > >  }
> > > --
> > > 2.30.0
> > >
> > >
> >
>
> --
>
> Help you, Help me,
> Hailong.

Thanks
Barry

