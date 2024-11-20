Return-Path: <linux-fsdevel+bounces-35311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6A9D3955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0542B281C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E0E19F421;
	Wed, 20 Nov 2024 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJD6YwZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF8197A87;
	Wed, 20 Nov 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101607; cv=none; b=DRfLU2Dx+EIU5ETrhgQ8f0G2T8mFRqLsI5IJLDu5wLh0LWdlugNGxaPRMgkb4BptJ+6N3lr9mF/QRI6Ywie9OV/Rdbwtuv5Kk0QTvRFbRkA6zznE4J5qM4epU84uEv5kDI58cudECs+hbLHIcgE6Gl0UsSCvvrVpOsBKhqaOlnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101607; c=relaxed/simple;
	bh=yeFmOmmm0HmgGLHlXnstkrzyk4jwienx0zxD65heW6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIc1yCp//ba74y/VbtAvGkAqz1mcHtMiDqkq3D/KG4JpgkK4IlvtblE7y3wo7M48YtQT916MDzbVCzDwYibcSc/OMhBeB6m4Nl93W1B7SauiU3GznsaRqhedl89YjYG9Icu9y2In+/8ucL0Vi+QCba30dPVa7gBQREz4tw+4R28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJD6YwZ1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so1092036166b.0;
        Wed, 20 Nov 2024 03:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732101604; x=1732706404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQhHDDRyasWUH8XMwYCMdjoNnB2OVAyDq6YcktEdCiM=;
        b=JJD6YwZ1DrhmMLSf2AoDdWFAsv+lku5YKtS5Bq1PFutOzIgWPaUaUoD1AOtAKopkRl
         stFvzaFeubm8QInbJ2qQh4GrkRxVdddIfQE0aM+JOMRVTy/A7YKcUXzGx96g5gyh5/wj
         NnfZdSN+mhiiaslJT/ijbCZYbX9YiJFbryIrt1fM+vaH+CSlyT5HBdA3XeNfnVHyQLN8
         h6MR6bGopE0w+JucjKSUl52pTj5Rh0fERPGIfhxe8DPyuYTBB4FSQMn89iGKSxMDn7oQ
         2I999SU4MMw8l/uaPTu4fg+gwuZQR6JI67LmZ5/iTKPIT3SK9vM9c1qwQM89y4zYQkpN
         H2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732101604; x=1732706404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQhHDDRyasWUH8XMwYCMdjoNnB2OVAyDq6YcktEdCiM=;
        b=S1AA6xZGhwAHq9MMx56cVS3HVSxrMYDLYQ5lgzACLKFO676R2LQhaOjPFqh+r6/Ioo
         2Yvg3QQpliypFcZcf4xTeOpyobMm/rGyw4xBmIMoOcqVVo+Xz5CSiH2pDgtXUrDYQ8ol
         pX775xqEHkc+n5QmZQ3CH5sYFiI2g/BHOPBwCKZcjWO5Nj3knCqlklMxxbsSCNRqTlVw
         RdTMi1jwwzbuq3y+3llS7w0QuTxRLBUIj4wAigvNTSWXcWSIrhI5XLKnXNJ1Yu2eTGZ1
         YwFrGO7iYcred6Bt47qRdI5fB1kmHlxuXmqL7N01qxFeRw2gRiEUfXEcUyXMgagTcHTn
         sQVA==
X-Forwarded-Encrypted: i=1; AJvYcCU8e6mCJZ/SJkfEIr59Gs5KG8vxtJRMqVB6LkgMJkOeCTbCSKWOZrw/AxM2Iq0QskFw4VQ=@vger.kernel.org, AJvYcCWCD0d3r22ZFKzB4HVhnbvHrv67ade5dG9+l2Bjr5DZuQ73jrYjRmiukZdEZ69mrcmcX3TeWzJOM2hPJR4YUQ==@vger.kernel.org, AJvYcCWIPozCpH5UJNHh3XhZ6m/8Lwr6rZPhNcXCgeTbhjt5EDexiBe0BgZ2sN0DAZ4/PVgmHF9XW7/VHkbSjh7oU81JiI/EYsu4@vger.kernel.org, AJvYcCXnAFf6pxYVfa9N3RFiTou3zl1mC3CcHkQeSKrS+ppEN15O45I92510IKFYM3NJAf3D/7QgINOjnxexV/6E@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7ML2sLaGKG8R5ByWRRLWhfD6gt0RnZSl75jSrScM3obdIHPK
	+9niKRVBjIxbh8avfdcTPGcEOXi4IOV+02z1OOAEjKnsefiS0lx8/0Snnnm76Mk0UN1e3u0OLoS
	fBu8XDkrzWKphi76EqHKFnZwBgcU=
X-Google-Smtp-Source: AGHT+IHCbwSKEziXFTHIgb1Xrsy0GuL6SjA/eCppu4tgbUbTE0vB3Kz/tpXxmInZf6cGkBSUA4L6gQJYpQAmtNy0AZ4=
X-Received: by 2002:a17:907:2da3:b0:a9a:26a5:d508 with SMTP id
 a640c23a62f3a-aa4dd53db4bmr194834366b.9.1732101603607; Wed, 20 Nov 2024
 03:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112082600.298035-1-song@kernel.org> <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner> <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
 <20241115111914.qhrwe4mek6quthko@quack3> <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
 <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com> <20241120-wimpel-virologen-1a58b127eec6@brauner>
In-Reply-To: <20241120-wimpel-virologen-1a58b127eec6@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 Nov 2024 12:19:51 +0100
Message-ID: <CAOQ4uxhSM0PL8g3w6E2fZUUGds-13Swj-cfBvPz9b9+8XhHD3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"mattbobrowski@google.com" <mattbobrowski@google.com>, "repnop@google.com" <repnop@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>, 
	"gnoack@google.com" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 10:28=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Tue, Nov 19, 2024 at 09:53:20PM +0000, Song Liu wrote:
> > Hi Jeff and Amir,
> >
> > Thanks for your inputs!
> >
> > > On Nov 19, 2024, at 7:30=E2=80=AFAM, Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > >
> > > On Tue, Nov 19, 2024 at 4:25=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > >>
> > >> On Tue, Nov 19, 2024 at 3:21=E2=80=AFPM Jeff Layton <jlayton@kernel.=
org> wrote:
> > >>>
> >
> > [...]
> >
> > >>> Longer term, I think it may be beneficial to come up with a way to =
attach
> > >>>>> private info to the inode in a way that doesn't cost us one point=
er per
> > >>>>> funcionality that may possibly attach info to the inode. We alrea=
dy have
> > >>>>> i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's alway=
s a tough
> > >>>>> call where the space overhead for everybody is worth the runtime =
&
> > >>>>> complexity overhead for users using the functionality...
> > >>>>
> > >>>> It does seem to be the right long term solution, and I am willing =
to
> > >>>> work on it. However, I would really appreciate some positive feedb=
ack
> > >>>> on the idea, so that I have better confidence my weeks of work has=
 a
> > >>>> better chance to worth it.
> > >>>>
> > >>>> Thanks,
> > >>>> Song
> > >>>>
> > >>>> [1] https://github.com/systemd/systemd/blob/main/src/core/bpf/rest=
rict_fs/restrict-fs.bpf.c
> > >>>
> > >>> fsnotify is somewhat similar to file locking in that few inodes on =
the
> > >>> machine actually utilize these fields.
> > >>>
> > >>> For file locking, we allocate and populate the inode->i_flctx field=
 on
> > >>> an as-needed basis. The kernel then hangs on to that struct until t=
he
> > >>> inode is freed.
> >
> > If we have some universal on-demand per-inode memory allocator,
> > I guess we can move i_flctx to it?
> >
> > >>> We could do something similar here. We have this now:
> > >>>
> > >>> #ifdef CONFIG_FSNOTIFY
> > >>>        __u32                   i_fsnotify_mask; /* all events this =
inode cares about */
> > >>>        /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > >>>        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > >>> #endif
> >
> > And maybe some fsnotify fields too?
> >
> > With a couple users, I think it justifies to have some universal
> > on-demond allocator.
> >
> > >>> What if you were to turn these fields into a pointer to a new struc=
t:
> > >>>
> > >>>        struct fsnotify_inode_context {
> > >>>                struct fsnotify_mark_connector __rcu    *i_fsnotify_=
marks;
> > >>>                struct bpf_local_storage __rcu          *i_bpf_stora=
ge;
> > >>>                __u32                                   i_fsnotify_m=
ask; /* all events this inode cares about */
> > >>>        };
> > >>>
> > >>
> > >> The extra indirection is going to hurt for i_fsnotify_mask
> > >> it is being accessed frequently in fsnotify hooks, so I wouldn't mov=
e it
> > >> into a container, but it could be moved to the hole after i_state.
> >
> > >>> Then whenever you have to populate any of these fields, you just
> > >>> allocate one of these structs and set the inode up to point to it.
> > >>> They're tiny too, so don't bother freeing it until the inode is
> > >>> deallocated.
> > >>>
> > >>> It'd mean rejiggering a fair bit of fsnotify code, but it would giv=
e
> > >>> the fsnotify code an easier way to expand per-inode info in the fut=
ure.
> > >>> It would also slightly shrink struct inode too.
> >
> > I am hoping to make i_bpf_storage available to tracing programs.
> > Therefore, I would rather not limit it to fsnotify context. We can
> > still use the universal on-demand allocator.
>
> Can't we just do something like:
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7e29433c5ecc..cc05a5485365 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -627,6 +627,12 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_DEFAULT_READLINK   0x0010
>  #define IOP_MGTIME     0x0020
>
> +struct inode_addons {
> +        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> +        struct bpf_local_storage __rcu          *i_bpf_storage;
> +        __u32                                   i_fsnotify_mask; /* all =
events this inode cares about */
> +};
> +
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -731,12 +737,7 @@ struct inode {
>                 unsigned                i_dir_seq;
>         };
>
> -
> -#ifdef CONFIG_FSNOTIFY
> -       __u32                   i_fsnotify_mask; /* all events this inode=
 cares about */
> -       /* 32-bit hole reserved for expanding i_fsnotify_mask */
> -       struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> -#endif
> +       struct inode_addons *i_addons;
>
>  #ifdef CONFIG_FS_ENCRYPTION
>         struct fscrypt_inode_info       *i_crypt_info;
>
> Then when either fsnotify or bpf needs that storage they can do a
> cmpxchg() based allocation for struct inode_addons just like I did with
> f_owner:
>
> int file_f_owner_allocate(struct file *file)
> {
>         struct fown_struct *f_owner;
>
>         f_owner =3D file_f_owner(file);
>         if (f_owner)
>                 return 0;
>
>         f_owner =3D kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
>         if (!f_owner)
>                 return -ENOMEM;
>
>         rwlock_init(&f_owner->lock);
>         f_owner->file =3D file;
>         /* If someone else raced us, drop our allocation. */
>         if (unlikely(cmpxchg(&file->f_owner, NULL, f_owner)))
>                 kfree(f_owner);
>         return 0;
> }
>
> The internal allocations for specific fields are up to the subsystem
> ofc. Does that make sense?
>

Maybe, but as I wrote, i_fsnotify_mask should not be moved out
of inode struct, because it is accessed in fast paths of fsnotify vfs
hooks, where we do not want to have to deref another context,
but i_fsnotify_mask can be moved to the hole after i_state.

And why stop at i_fsnotify/i_bfp?
If you go to "addons" why not also move i_security/i_crypt/i_verify?
Need to have some common rationale behind those decisions.

Thanks,
Amir.

