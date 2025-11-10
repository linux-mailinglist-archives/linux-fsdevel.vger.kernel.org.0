Return-Path: <linux-fsdevel+bounces-67728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DEBC485BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CA2F4EEDE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A813A2D73BD;
	Mon, 10 Nov 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AC9XHANc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E222688C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795854; cv=none; b=S3D+bfhNQoBr0r6YMziVJHehC3c/G7C+JiE0VoRSHCZwY/BGeENBdQ6FT3HzmQem/a9VZpoh+E8lm/F187YOza66pPazBCl9yuCb/i55FVsbYUiyRE77AxQJes+vhotVo6gUhUZpHCTpSjmnO8qMfo++crgsT6E+I+g6cLK5G1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795854; c=relaxed/simple;
	bh=troxVhxfQBVjFwf8LpZkj4v60KJWpcZ7GG8KqeA3sP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnefUfYzXEleAXMXHRoZc6kzVKktBqsGw56sKzlaMwFqhnSxBT47hZeYkSJMa9ViEiljiTBUy+cvcZCoSOGzewQQBnQqFfZpgPj/EAF5Di0pyPEGN3NpDJcyFXLt4rh3gHHrtBZMY0jrjMQcTeRCszjxQGXfVAMZo1EGnD6iRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AC9XHANc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-782e93932ffso2717876b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 09:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762795851; x=1763400651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBupVcckmVz5Ln4jfPWyUolTVnASsByCuaOtA4I7qvo=;
        b=AC9XHANc7Jv98OiD1RAbXbgghzmw1fEwG+S7ohAbVKTZWl40zZDYQxjQT60E0kzVgF
         0lDK3EhNyqlXgP46+IyQtHB8hn5TTuyX8hGN7aPnqGaC/cZ/twGlZbKdZ4mHsmjIMj2m
         9B235fBEy+69JEIZbjZKnmzi0oot5veGPLpqdFnhs6N0L6Z4WRAY3bOc2sWGobkCepm7
         29F+ut8qbkM9nIyouH+e9sIriR42Kmct4jI6zyyL2LV5cRdCJE9MZ2KaCcj1YONMjG0N
         BLlTXjRo6B8D1sl2IY0/xH6nDtCVzbGhLx6JTNf/sUskbrDXyIOTzOZLSIPdvJK0aHUy
         HwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795851; x=1763400651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBupVcckmVz5Ln4jfPWyUolTVnASsByCuaOtA4I7qvo=;
        b=X6Pp7Kfnr5rlLJmMIyKm5mnsdkvm5HE6DsXJ0sopdG7BOnzGpbqjg467RHhChhcwFr
         qcqozkoHT+Vvl7C7f32OX/njfomp+s3oTjVScL8RsYfWHy6CFnWX2PWgbob2TD11h94V
         JnDVN0Cet9XF1Sj1tnrYEVclbZ5vzKNct6VpVfmOZIeRR/JMgTV0+jkAqOGgc+Hr5Rsv
         24gkwVMSTQ1INdqsNw48SvFULhoBi2g1TPTxK9Ug83VFhk5/pJlb0U/OCc/H2DPWDqO4
         3zYRGYSmn2X58ZpxD14ZX+4ATUJvu3CSI8PhcDrKxTo6uTW+tDQ3UdWwrDjMKu2nskAU
         N+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWTVclZEfDF4a3Q//YY2XZ/qUNWpfcfPHG4brmLG24qCIXxe4I1OejdSFp22qfooTgqNLfijG2vi51bIa0m@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+tkxKHMY4cNylpQzX8WOattqibLKSVkt4gskjAl/Pi70mw8Lw
	SyAxizthrbuObEJ/c5SIb5QO9pK9GTelqLsn2e0slutSpT6XE0F4s7T1Yi7yYtLEFndw6uLAfkU
	9SH9/TJX3MVdMmIXKqgzPFqvDFKQyW0c=
X-Gm-Gg: ASbGnctEvF2qQW5lXvqLj9TMexHkZZziw6X6AexnZm3b6f0jD04e9KeiHozWZ8uWFll
	c72TBvIPRPJ0ozWxHMKcD3QNedS3TF4FlCzmu/S6AsMd1S7ipDnbyvpSGsk9/66LWa3dOQemjb6
	R+vPnFX8XVHLtc5lH8jcbpFkgHAvmGNsiwyb6ry7i5pn1V0KEiATsOx1Pqo2Q2wEanMu2hoporq
	nP8I9hhg6sx1yovzxaCQWxdfU/2VuH0JNI/XyfIsdC+rz8T7W4159hCNbp8
X-Google-Smtp-Source: AGHT+IG1vzxlgOlG9RofPIQ8HXS/TzZg0c7M7/gWC0zTYmT64xMp8LfK4tDIRftHYt3f+PSr3BPp3nPvSQoI3SsCuMA=
X-Received: by 2002:a17:90a:ac0e:b0:343:747e:2cab with SMTP id
 98e67ed59e1d1-343747e31a5mr6285125a91.8.1762795851107; Mon, 10 Nov 2025
 09:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106005333.956321-1-neilb@ownmail.net> <20251106005333.956321-12-neilb@ownmail.net>
 <CAEjxPJ528Ou4dvRwHo+kXjWreGicda8BOXkQRvq3vMED6JQKOQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ528Ou4dvRwHo+kXjWreGicda8BOXkQRvq3vMED6JQKOQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 10 Nov 2025 12:30:39 -0500
X-Gm-Features: AWmQ_bndNmWOI1mokvMjGbHl4ympSya5-SIjECF6vpxPVypYlN3NvFXLixarZ1U
Message-ID: <CAEjxPJ6-BXRntLqNRJxveAbwHmC2EB9YYg7f4hLD9T2g-H3fzw@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] Add start_renaming_two_dentries()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:08=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Nov 5, 2025 at 7:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
> >
> > From: NeilBrown <neil@brown.name>
> >
> > A few callers want to lock for a rename and already have both dentries.
> > Also debugfs does want to perform a lookup but doesn't want permission
> > checking, so start_renaming_dentry() cannot be used.
> >
> > This patch introduces start_renaming_two_dentries() which is given both
> > dentries.  debugfs performs one lookup itself.  As it will only continu=
e
> > with a negative dentry and as those cannot be renamed or unlinked, it i=
s
> > safe to do the lookup before getting the rename locks.
> >
> > overlayfs uses start_renaming_two_dentries() in three places and  selin=
ux
> > uses it twice in sel_make_policy_nodes().
> >
> > In sel_make_policy_nodes() we now lock for rename twice instead of just
> > once so the combined operation is no longer atomic w.r.t the parent
> > directory locks.  As selinux_state.policy_mutex is held across the whol=
e
> > operation this does open up any interesting races.

Also, I assume you mean "does NOT open up any interesting races" above.

> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > ---
> > changes since v3:
> >  added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
> > ---
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 232e087bce3e..a224ef9bb831 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_f=
s_info *fsi,
> >         if (ret)
> >                 goto out;
> >
> > -       lock_rename(tmp_parent, fsi->sb->s_root);
> > +       rd.old_parent =3D tmp_parent;
> > +       rd.new_parent =3D fsi->sb->s_root;
> >
> >         /* booleans */
> > -       d_exchange(tmp_bool_dir, fsi->bool_dir);
> > +       ret =3D start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->boo=
l_dir);
> > +       if (!ret) {
> > +               d_exchange(tmp_bool_dir, fsi->bool_dir);
>
> I would recommend an immediate goto out if ret !=3D 0; we don't want to
> silently fall through and possibly reset ret on the next
> start_renaming_two_dentries() call, thereby ultimately returning 0 to
> the caller and acting as if nothing bad happened.
>
> >
> > -       swap(fsi->bool_num, bool_num);
> > -       swap(fsi->bool_pending_names, bool_names);
> > -       swap(fsi->bool_pending_values, bool_values);
> > +               swap(fsi->bool_num, bool_num);
> > +               swap(fsi->bool_pending_names, bool_names);
> > +               swap(fsi->bool_pending_values, bool_values);
> >
> > -       fsi->bool_dir =3D tmp_bool_dir;
> > +               fsi->bool_dir =3D tmp_bool_dir;
> > +               end_renaming(&rd);
> > +       }
> >
> >         /* classes */
> > -       d_exchange(tmp_class_dir, fsi->class_dir);
> > -       fsi->class_dir =3D tmp_class_dir;
> > +       ret =3D start_renaming_two_dentries(&rd, tmp_class_dir, fsi->cl=
ass_dir);
> > +       if (ret =3D=3D 0) {
> > +               d_exchange(tmp_class_dir, fsi->class_dir);
> > +               fsi->class_dir =3D tmp_class_dir;
> >
> > -       unlock_rename(tmp_parent, fsi->sb->s_root);
> > +               end_renaming(&rd);
> > +       }
> >
> >  out:
> >         sel_remove_old_bool_data(bool_num, bool_names, bool_values);
> > --
> > 2.50.0.107.gf914562f5916.dirty
> >

