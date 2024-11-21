Return-Path: <linux-fsdevel+bounces-35449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF499D4E16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 14:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5045F281727
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 13:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9471D90D4;
	Thu, 21 Nov 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSSjFQqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382A1D515F;
	Thu, 21 Nov 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196902; cv=none; b=m05Jc2IrRIYoimQcmqC6Z1vx/BDj+mDt9BUxDGuer8vWxWWIV0CZ3ju25nYTlgP+jeP0p71wKklKQuDBcT2suXNV5TWgzzUh48w0C1n/wX7UG/6MkbJV8JRbD04PwZVapeXMJPrJEix3NRZP1vpgoWKf/r843iqiRYkzI5hpp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196902; c=relaxed/simple;
	bh=5zSFbDgpXPxHjrjKF2WpJdqNClJXYVH2mbS60X2jYSA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCpQYNuaZzvDPSnU04XUFTOabB3cIxEf6MqQFJOXpby8h+ltdJ/238Cyx1+Rm0OAbOoYMtLcKY3S3AExhLtFalfH+aErkrmUOgctkP0BNvypgk3BjYSfsiGs+YE04iRHedun3fS3aKTTd2/c4XuyB8h80e5gpk48gwThgCCp5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSSjFQqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1438DC4CECC;
	Thu, 21 Nov 2024 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732196902;
	bh=5zSFbDgpXPxHjrjKF2WpJdqNClJXYVH2mbS60X2jYSA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DSSjFQqrUE3i9v1G2PAl+yY/gRJ+UqVFd3R63T8DJJOPbgCFvtkf3Zi0b/Btrj3Z/
	 RDsIgWoQpTgkIGrkyR3svFUf+arZRd53zFtF6CsqxSoe0EknQSf9M3G/2aaOsbNdZo
	 1zXMZOjQ63euRwvjddl/RQynjuKtYputDZAW5n0WkKlH19tJY5rKjsb6/GmBEwaWqb
	 6Z3mZzs3t15fsgcFAIj0NDaglgodGRx3mHiYG/unmohdNqmVACuPGMp6ysFUf+YHWY
	 hfd7c7Xj2kZL3Rgzs4BRzfzFL1Xc/qlAmNJT6C/vUnLvNwtcyTAbXizpR1Kyj19xDn
	 oaS7TVXekOdKw==
Message-ID: <a559fe60e88bb444f04ff60b066bd78a018c7495.camel@kernel.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>
Cc: Song Liu <songliubraving@meta.com>, Jan Kara <jack@suse.cz>, Song Liu
 <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team
 <kernel-team@meta.com>,  "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,  "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "viro@zeniv.linux.org.uk"
 <viro@zeniv.linux.org.uk>,  "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,  "repnop@google.com"
 <repnop@google.com>, Josef Bacik <josef@toxicpanda.com>, "mic@digikod.net"
 <mic@digikod.net>, "gnoack@google.com" <gnoack@google.com>
Date: Thu, 21 Nov 2024 08:48:18 -0500
In-Reply-To: <CAOQ4uxhSM0PL8g3w6E2fZUUGds-13Swj-cfBvPz9b9+8XhHD3w@mail.gmail.com>
References: <20241112082600.298035-1-song@kernel.org>
	 <20241112082600.298035-3-song@kernel.org>
	 <20241113-sensation-morgen-852f49484fd8@brauner>
	 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
	 <20241115111914.qhrwe4mek6quthko@quack3>
	 <E79EFA17-A911-40E8-8A51-CB5438FD2020@fb.com>
	 <8ae11e3e0d9339e6c60556fcd2734a37da3b4a11.camel@kernel.org>
	 <CAOQ4uxgUYHEZTx7udTXm8fDTfhyFM-9LOubnnAc430xQSLvSVA@mail.gmail.com>
	 <CAOQ4uxhyDAHjyxUeLfWeff76+Qpe5KKrygj2KALqRPVKRHjSOA@mail.gmail.com>
	 <DF0C7613-56CC-4A85-B775-0E49688A6363@fb.com>
	 <20241120-wimpel-virologen-1a58b127eec6@brauner>
	 <CAOQ4uxhSM0PL8g3w6E2fZUUGds-13Swj-cfBvPz9b9+8XhHD3w@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 12:19 +0100, Amir Goldstein wrote:
> On Wed, Nov 20, 2024 at 10:28=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> >=20
> > On Tue, Nov 19, 2024 at 09:53:20PM +0000, Song Liu wrote:
> > > Hi Jeff and Amir,
> > >=20
> > > Thanks for your inputs!
> > >=20
> > > > On Nov 19, 2024, at 7:30=E2=80=AFAM, Amir Goldstein <amir73il@gmail=
.com> wrote:
> > > >=20
> > > > On Tue, Nov 19, 2024 at 4:25=E2=80=AFPM Amir Goldstein <amir73il@gm=
ail.com> wrote:
> > > > >=20
> > > > > On Tue, Nov 19, 2024 at 3:21=E2=80=AFPM Jeff Layton <jlayton@kern=
el.org> wrote:
> > > > > >=20
> > >=20
> > > [...]
> > >=20
> > > > > > Longer term, I think it may be beneficial to come up with a way=
 to attach
> > > > > > > > private info to the inode in a way that doesn't cost us one=
 pointer per
> > > > > > > > funcionality that may possibly attach info to the inode. We=
 already have
> > > > > > > > i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's=
 always a tough
> > > > > > > > call where the space overhead for everybody is worth the ru=
ntime &
> > > > > > > > complexity overhead for users using the functionality...
> > > > > > >=20
> > > > > > > It does seem to be the right long term solution, and I am wil=
ling to
> > > > > > > work on it. However, I would really appreciate some positive =
feedback
> > > > > > > on the idea, so that I have better confidence my weeks of wor=
k has a
> > > > > > > better chance to worth it.
> > > > > > >=20
> > > > > > > Thanks,
> > > > > > > Song
> > > > > > >=20
> > > > > > > [1] https://github.com/systemd/systemd/blob/main/src/core/bpf=
/restrict_fs/restrict-fs.bpf.c
> > > > > >=20
> > > > > > fsnotify is somewhat similar to file locking in that few inodes=
 on the
> > > > > > machine actually utilize these fields.
> > > > > >=20
> > > > > > For file locking, we allocate and populate the inode->i_flctx f=
ield on
> > > > > > an as-needed basis. The kernel then hangs on to that struct unt=
il the
> > > > > > inode is freed.
> > >=20
> > > If we have some universal on-demand per-inode memory allocator,
> > > I guess we can move i_flctx to it?
> > >=20
> > > > > > We could do something similar here. We have this now:
> > > > > >=20
> > > > > > #ifdef CONFIG_FSNOTIFY
> > > > > >        __u32                   i_fsnotify_mask; /* all events t=
his inode cares about */
> > > > > >        /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > > > > >        struct fsnotify_mark_connector __rcu    *i_fsnotify_mark=
s;
> > > > > > #endif
> > >=20
> > > And maybe some fsnotify fields too?
> > >=20
> > > With a couple users, I think it justifies to have some universal
> > > on-demond allocator.
> > >=20
> > > > > > What if you were to turn these fields into a pointer to a new s=
truct:
> > > > > >=20
> > > > > >        struct fsnotify_inode_context {
> > > > > >                struct fsnotify_mark_connector __rcu    *i_fsnot=
ify_marks;
> > > > > >                struct bpf_local_storage __rcu          *i_bpf_s=
torage;
> > > > > >                __u32                                   i_fsnoti=
fy_mask; /* all events this inode cares about */
> > > > > >        };
> > > > > >=20
> > > > >=20
> > > > > The extra indirection is going to hurt for i_fsnotify_mask
> > > > > it is being accessed frequently in fsnotify hooks, so I wouldn't =
move it
> > > > > into a container, but it could be moved to the hole after i_state=
.
> > >=20
> > > > > > Then whenever you have to populate any of these fields, you jus=
t
> > > > > > allocate one of these structs and set the inode up to point to =
it.
> > > > > > They're tiny too, so don't bother freeing it until the inode is
> > > > > > deallocated.
> > > > > >=20
> > > > > > It'd mean rejiggering a fair bit of fsnotify code, but it would=
 give
> > > > > > the fsnotify code an easier way to expand per-inode info in the=
 future.
> > > > > > It would also slightly shrink struct inode too.
> > >=20
> > > I am hoping to make i_bpf_storage available to tracing programs.
> > > Therefore, I would rather not limit it to fsnotify context. We can
> > > still use the universal on-demand allocator.
> >=20
> > Can't we just do something like:
> >=20
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 7e29433c5ecc..cc05a5485365 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -627,6 +627,12 @@ is_uncached_acl(struct posix_acl *acl)
> >  #define IOP_DEFAULT_READLINK   0x0010
> >  #define IOP_MGTIME     0x0020
> >=20
> > +struct inode_addons {
> > +        struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > +        struct bpf_local_storage __rcu          *i_bpf_storage;
> > +        __u32                                   i_fsnotify_mask; /* al=
l events this inode cares about */
> > +};
> > +
> >  /*
> >   * Keep mostly read-only and often accessed (especially for
> >   * the RCU path lookup and 'stat' data) fields at the beginning
> > @@ -731,12 +737,7 @@ struct inode {
> >                 unsigned                i_dir_seq;
> >         };
> >=20
> > -
> > -#ifdef CONFIG_FSNOTIFY
> > -       __u32                   i_fsnotify_mask; /* all events this ino=
de cares about */
> > -       /* 32-bit hole reserved for expanding i_fsnotify_mask */
> > -       struct fsnotify_mark_connector __rcu    *i_fsnotify_marks;
> > -#endif
> > +       struct inode_addons *i_addons;
> >=20
> >  #ifdef CONFIG_FS_ENCRYPTION
> >         struct fscrypt_inode_info       *i_crypt_info;
> >=20
> > Then when either fsnotify or bpf needs that storage they can do a
> > cmpxchg() based allocation for struct inode_addons just like I did with
> > f_owner:
> >=20
> > int file_f_owner_allocate(struct file *file)
> > {
> >         struct fown_struct *f_owner;
> >=20
> >         f_owner =3D file_f_owner(file);
> >         if (f_owner)
> >                 return 0;
> >=20
> >         f_owner =3D kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
> >         if (!f_owner)
> >                 return -ENOMEM;
> >=20
> >         rwlock_init(&f_owner->lock);
> >         f_owner->file =3D file;
> >         /* If someone else raced us, drop our allocation. */
> >         if (unlikely(cmpxchg(&file->f_owner, NULL, f_owner)))
> >                 kfree(f_owner);
> >         return 0;
> > }
> >=20
> > The internal allocations for specific fields are up to the subsystem
> > ofc. Does that make sense?
> >=20
>=20
> Maybe, but as I wrote, i_fsnotify_mask should not be moved out
> of inode struct, because it is accessed in fast paths of fsnotify vfs
> hooks, where we do not want to have to deref another context,
> but i_fsnotify_mask can be moved to the hole after i_state.
>
> And why stop at i_fsnotify/i_bfp?
> If you go to "addons" why not also move i_security/i_crypt/i_verify?
> Need to have some common rationale behind those decisions.
>=20

I don't think we would stop there. We could probably move several
fields into the new struct (i_flctx comes to mind), but that should
probably be done piecemeal, in later patchsets.

The bigger concern is that this is only helpful when inode_addons is
needed for a fraction of inodes on the system. i_security might not be
good candidate to move there for that reason. Anyone running with an
LSM is going to end up allocating one of these for almost every inode,
so they might as well just keep a pointer in struct inode instead.

We also need to be cautious here. This adds extra pointer indirection,
which could be costly for some uses.
--=20
Jeff Layton <jlayton@kernel.org>

