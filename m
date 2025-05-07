Return-Path: <linux-fsdevel+bounces-48408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA5AAE73D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9821890624
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2C28C03E;
	Wed,  7 May 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBLZblBv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C528C011;
	Wed,  7 May 2025 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746637007; cv=none; b=a/kAkOR3i+sCLbA6QFhgY5ZMxrVSbuz9kSeOdK6tWcTk4MrYGeaM+4IszjJicZgyRxAu4unocIMTiVZ+JWSLLsHNsLeQ+V6UiCz8Jzkn/+uzJWp5ZrlXbJA1H6wtaVq3nW5V7LPDnoOXHRuvSAbq/qiohK8QzQMPeULy166SrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746637007; c=relaxed/simple;
	bh=M8hqAuafWKlzWJxl30NzD8kz2WfTnQJN5wvmWCfhGHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg0ioNPfQAG4gxt/qWUtcHM4zigwcm/rdiOjU42kJ/xoGDobtjz8KIU6eEGF/s1aTAvJIuZIrpsEuRQWheXxMSwSsBlZlptzkY6R5xiN6JAS+9vX5ADrBsdIhMelJ7NBjlF1FXkc/Xuxi4Ns2EEa9kY+f0wHRZYnHf8nGzrsVeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBLZblBv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so78171a12.0;
        Wed, 07 May 2025 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746637003; x=1747241803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbQgJe6mi5e6seyWphPc3GG0/Me0mvQbZgaUQ7DeMw0=;
        b=hBLZblBvjG82ts+k2aQmeNrFpJ6XBrHI1a8xJcyyMWJ2kHwtDDnz6HCOWKVcmwk3ui
         RN4mst1cB6zVJnHLj4irmEctSd35enY1+yICotU/NlfwnMtPmXY1rglGs3Z1CleocP45
         L0CckTNgS9wK64lp0xQoqSloVoFXgzpq6ncNn+ibyeDYpkWDLrq7UwVKNH8pwqZJ643s
         s4CEzYsTIx8KpaWEtpJFjNNrQqavykrrBea3GQISCkjuS8Zmpt7lh0wY8eGWVGGfZ4ZT
         79yt7gHyPFD411bFRIvBr6MG+s8plnM51lL2aXfmRFT3xds8HRw68S8VNCGGVR03Snke
         3oOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746637003; x=1747241803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbQgJe6mi5e6seyWphPc3GG0/Me0mvQbZgaUQ7DeMw0=;
        b=JM5U0vfi384nL+hUVPVWAocJn1AGSRiZidHxgVrMYoToFYgXWMZzhGhmQnZrLlUBQA
         RogDIVaTGf9tCHZIrgByX5+ZNa+svAkWmgcwFsjb8UPUlfdMXG9AgF6Ipb1bDk0KW0RO
         SRWcMRje5dq8XugVTf3bZhVxVi2nklsa1RHMDdsgugR97b1r50jqL26P8lA4UJbVRF2Q
         D1UKh7gee2jXfuiTX0piq5QmmFsiRl3piooiZgSgY9EqF3Wu+R2bavFlXK9+glsVxvGP
         GnezcdjhMNYniBb9ujEFQ2oxvwz58yCnTvS4j9twz7Bh15RboB7votFEbTJrnAjPSwdF
         d86Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCh0VEcnAzjbYqdKmW89sgwEbtup4ZG4w16Z0T+r13hOmMetMgEvsxBG0phdbPWQr+UaYHIimbfs9Jnf+d@vger.kernel.org, AJvYcCVtFoDc1fqegfS71bwhOFwEMuIsBLC8GYWN1JqHVzFgnMRb8kpvc7OEJDqYY0uPWjZMTfTLJwGti788Xcmq@vger.kernel.org
X-Gm-Message-State: AOJu0YxGlMJiZxxal4Yxlg76tbdDjby9mSjSN6ZSl6DVFLzMydIIeWNF
	CP19MCXnRVX2IuNDwwB/DOUlS+vTDSXVODS6eDtSNNwIFw6dS6OdkkLzfKwgtX5S7B7wnrcriQZ
	m5zFWQhOyAlPvf70sc1HC8mUlQH4=
X-Gm-Gg: ASbGncsWGD3gFDznOqpPsMmr6S1nJz/6C9JSdUUmliEuAMK1NKHBNkT0mMT16CNQn8b
	YkQTx4pW8hACYDiUb+7FKge6jI9vXYb3uZShAc0vILaChdYp4ZBGxNTbx0Q/bTn5y5ZZBjviWtd
	HDeK7amBLlOBykRmS5a6OPMg==
X-Google-Smtp-Source: AGHT+IEpiSm+Lms2NGKnrMl4I9FeMG7u5NOy/L1fcvTs161jhL2q8timDPhGlcJ+3eXzBu017BBrz9g29yNfLxIjetw=
X-Received: by 2002:a17:906:fe0c:b0:acb:b9db:aa22 with SMTP id
 a640c23a62f3a-ad1e8978112mr379989066b.0.1746637003080; Wed, 07 May 2025
 09:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507032926.377076-2-chenlinxuan@uniontech.com>
 <CAOQ4uxjKFXOKQxPpxtS6G_nR0tpw95w0GiO68UcWg_OBhmSY=Q@mail.gmail.com> <CAC1kPDP4oO29B_TM-2wvzt1+Gc6hWTDGMfHSJhOax4_Cg2dEkg@mail.gmail.com>
In-Reply-To: <CAC1kPDP4oO29B_TM-2wvzt1+Gc6hWTDGMfHSJhOax4_Cg2dEkg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 7 May 2025 18:56:31 +0200
X-Gm-Features: ATxdqUEbY-81fyoPFOCtlc2Ubdm-cLABAOgs-Dxmf27FuHMDDx780lEoG71SZYY
Message-ID: <CAOQ4uxgS3OUy9tpphAJKCQFRAn2zTERXXa0QN_KvP6ZOe2KVBw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: fuse: add backing_files control file
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 2:34=E2=80=AFPM Chen Linxuan <chenlinxuan@uniontech.=
com> wrote:
>
> On Wed, May 7, 2025 at 7:03=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > On Wed, May 7, 2025 at 5:29=E2=80=AFAM Chen Linxuan <chenlinxuan@uniont=
ech.com> wrote:
> > >
> > > Add a new FUSE control file "/sys/fs/fuse/connections/*/backing_files=
"
> > > that exposes the paths of all backing files currently being used in
> > > FUSE mount points. This is particularly valuable for tracking and
> > > debugging files used in FUSE passthrough mode.
> > >
> > > This approach is similar to how fixed files in io_uring expose their
> > > status through fdinfo, providing administrators with visibility into
> > > backing file usage. By making backing files visible through the FUSE
> > > control filesystem, administrators can monitor which files are being
> > > used for passthrough operations and can force-close them if needed by
> > > aborting the connection.
> > >
> > > This exposure of backing files information is an important step towar=
ds
> > > potentially relaxing CAP_SYS_ADMIN requirements for certain passthrou=
gh
> > > operations in the future, allowing for better security analysis of
> > > passthrough usage patterns.
> > >
> > > The control file is implemented using the seq_file interface for
> > > efficient handling of potentially large numbers of backing files.
> > > Access permissions are set to read-only (0400) as this is an
> > > informational interface.
> > >
> > > FUSE_CTL_NUM_DENTRIES has been increased from 5 to 6 to accommodate t=
he
> > > additional control file.
> > >
> > > Some related discussions can be found at:
> > >
> > > Link: https://lore.kernel.org/all/4b64a41c-6167-4c02-8bae-3021270ca51=
9@fastmail.fm/T/#mc73e04df56b8830b1d7b06b5d9f22e594fba423e
> > > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhAY1m7ubJ3p-A3rSuf=
w_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com/
> > >
> >
> > remove newline
> >
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > >
> > > ---
> > > Please review this patch carefully. I am new to kernel development an=
d
> > > I am not quite sure if I have followed the best practices, especially
> > > in terms of seq_file, error handling and locking. I would appreciate
> > > any feedback.
> >
> > Very nice work!
> >
> > >
> > > I have do some simply testing using libfuse example [1]. It seems to
> > > work well.
> >
> > It would be great if you could add basic sanity tests to libfuse
> > maybe in test_passthrough_hp(), but I do not see any tests for
> > /sys/fs/fuse/connections.
> >
> > I also see that there is one kernel selftest that mounts a fuse fs
> > tools/testing/selftests/memfd
> > maybe that is an easier way to write a simple test to verify the
> > /sys/fs/fuse/connections functionally.
> >
> > Anyway, I do not require that you do that as a condition for merging th=
is patch,
> > but I may require that for removing CAP_SYS_ADMIN ;)
> >
> > >
> > > [1]: https://github.com/libfuse/libfuse/blob/master/example/passthrou=
gh_hp.cc
> > > ---
> > >  fs/fuse/control.c | 129 ++++++++++++++++++++++++++++++++++++++++++++=
+-
> > >  fs/fuse/fuse_i.h  |   2 +-
> > >  2 files changed, 129 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> > > index 2a730d88cc3bd..4d1e0acc5030f 100644
> > > --- a/fs/fuse/control.c
> > > +++ b/fs/fuse/control.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > >  #include <linux/fs_context.h>
> > > +#include <linux/seq_file.h>
> > >
> > >  #define FUSE_CTL_SUPER_MAGIC 0x65735543
> > >
> > > @@ -180,6 +181,129 @@ static ssize_t fuse_conn_congestion_threshold_w=
rite(struct file *file,
> > >         return ret;
> > >  }
> > >
> > > +struct fuse_backing_files_seq_state {
> > > +       struct fuse_conn *fc;
> > > +       int pos;
> >
> > It will be more clear to call this 'backing_id'.
> > It is more than an abstract pos in this context.
> >
> > > +};
> > > +
> > > +static void *fuse_backing_files_seq_start(struct seq_file *seq, loff=
_t *pos)
> > > +{
> > > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > > +       struct fuse_conn *fc =3D state->fc;
> > > +
> > > +       if (!fc)
> > > +               return NULL;
> > > +
> > > +       spin_lock(&fc->lock);
> > > +
> > > +       if (*pos > idr_get_cursor(&fc->backing_files_map)) {
> >
> > This won't do after the ida allocator has wrapped up back to 1,
> > it will not iterate the high ids.
> >
> > Please look at using idr_get_next() iteration, like bpf_prog_seq_ops.
> >
> > With that change, I don't think that you need to take the spin lock
> > for iteration.
> > I think that you can use rcu_read_lock() for the scope of each
> > start(). next(), show()
> > because we do not need to promise a "snapshot" of the backing_file at a=
 specific
> > time. If backing files are added/removed while iterating it is undefine=
d if they
> > are listed or not, just like readdir.
> >
> > > +               spin_unlock(&fc->lock);
> > > +               return NULL;
> >
> > Not critical, but if you end up needing a "scoped" unlock for the
> > entire iteration, you can use
> > the unlock in stop() if you return ERR_PTR(ENOENT) instead of NULL in
> > those error conditions.
> >
> > > +       }
> > > +
> > > +       state->pos =3D *pos;
> > > +       return state;
> > > +}
> > > +
> > > +static void *fuse_backing_files_seq_next(struct seq_file *seq, void =
*v,
> > > +                                        loff_t *pos)
> > > +{
> > > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > > +
> > > +       (*pos)++;
> > > +       state->pos =3D *pos;
> > > +
> > > +       if (state->pos > idr_get_cursor(&state->fc->backing_files_map=
)) {
> > > +               spin_unlock(&state->fc->lock);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       return state;
> > > +}
> > > +
> > > +static int fuse_backing_files_seq_show(struct seq_file *seq, void *v=
)
> > > +{
> > > +       struct fuse_backing_files_seq_state *state =3D seq->private;
> > > +       struct fuse_conn *fc =3D state->fc;
> > > +       struct fuse_backing *fb;
> > > +
> > > +       fb =3D idr_find(&fc->backing_files_map, state->pos);
> >
> > You must fuse_backing_get/put(fb) around dereferencing fb->file
> > if not holding the fc->lock.
> > See fuse_passthrough_open().
> >
> > > +       if (!fb || !fb->file)
> > > +               return 0;
> > > +
> > > +       seq_file_path(seq, fb->file, " \t\n\\");
> >
> > Pls print the backing id that is associated with the open file.
>
> Does the backing id means anything in user space?
> I think maybe we shouldn't expose kernel details to userspace.
>

It means everything to userspace.
backing ids are part of the userspace UAPI - you have documented it yoursel=
f.
The fuse server used backing ids to manage access to backing files
https://github.com/libfuse/libfuse/blob/master/example/passthrough_hp.cc#L8=
55

> >
> > I wonder out loud if we should also augment the backing fd
> > information in fdinfo of specific open fuse FOPEN_PASSTHROUGH files?
>
> Or do you mean that we should display backing id and fuse connection id h=
ere?
>

This is extra and nice to have.
It can show admin which files are using fuse passthrough.
It cannot replace displaying all backing ids under connection
because server can register backing ids without using them to open files
and most importantly server can leak backing ids, which is a good
reason to kill it.

Thanks,
Amir.

