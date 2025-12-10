Return-Path: <linux-fsdevel+bounces-71050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F7CB2ACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 11:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45BEB306293D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D5430C61C;
	Wed, 10 Dec 2025 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFrpb8ql"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA09930BBB7
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765362296; cv=none; b=WjV1M4mDnD+RZUeDualnggNmp0SdTJuSYZtwepn6QcflGxdw0J4ks329cTS8QdDl8QLq7tp6Ws+wpSEeIfmoFC6BE/NyeLYLsc0wRVNnSuuutKGFcnxCWZPP/kR86TyT5mkEuRSqoxobQrLXxupWlXamJzwd7D06eX+NvLqVBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765362296; c=relaxed/simple;
	bh=r+vy0LMi82R2BUM1yK86rqPVTcipj/cKQMTf3dYcyIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgmZcTUfdF2oAWBf7VeGPQ58yLfPwQgZIDYgS5oMkJKGHw2MI65y2LTEV1bxeA8zWq7tcwN5wdTUm/VjJHIUj4wMzet5jKAfA4ZqDSiCS3gnxy+FBdfyGZheoCSYU7iJbuXTyd0/Adr4n9aJUyjxT3Du/3iW1AytgOWhLI88QJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFrpb8ql; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64979bee42aso259779a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 02:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765362293; x=1765967093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Lo0wFsbpVQLfwuxKUYQ/LLAiQLMRFPL6gEZj+B7ncw=;
        b=dFrpb8qlf+cQIiDKCGKFdeoRYm9LBMPkpdU5kAK15b+s5fZf/jeqD1y8wAH+yYEhk2
         9LSIn2oATqoUIe2i6f9PwXmE2n+FuMbbroRwtWhq+dnQkCcaUpHrTsuygXBvfUXWMzU4
         BqQQz+evP+LSXrUCeYlzylBuGU0TmGuoVMwQA/WXzjk7QN0h6D7QTVfjnJqP03mIhgU9
         GXtezyq9IAAh4h6MgMgIVCTN3VwsyxwhR1k7K9mGL6zhuAktWeLIt33u9V96ff7d5bHG
         CTvikexZ7rhu4V32nGXm69nkxIRW9jirRT9PiptalPKu2C+mPc6CooxARHKur9oATxzl
         z9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765362293; x=1765967093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Lo0wFsbpVQLfwuxKUYQ/LLAiQLMRFPL6gEZj+B7ncw=;
        b=cONvGW7eqBi8Yu6Dvif/j66PiOojaBCElYctvZYANw1vue8FbxxbCzTmnEkRNOXl5D
         z45cYzddYo2UOS1H8inQ0EZ8lEpmqOgPayeY4Y437/rSmEDaUg5VEMalpNOPI9/gYZO8
         M/pZxmiVJWo4ecw07w3fRgfZ5Hb2TKe7ZjNlTazXUU3f27MWliCMKNCbEwYKTtSM6mlM
         CNPHFcrdTOKHhzL0RLmgqxGgX/yESh745vh+AIjUytAH/mMuInms4pmPmYv6RWWaz1++
         i84Alu00OuGSLXw88GcS+2TXcDKHl5Ix6XNh4JPG+aaGTB80Wb7wLnGu33jnMHUr20XV
         ig7w==
X-Forwarded-Encrypted: i=1; AJvYcCUMWafE90iqpdyOmV0SqvxwvPJtsY7017Mo6FotrNqFVkEuApuDEnIitgQIwvceu99U1IBzvvNy/vBOKVBY@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVi3l/2HaWPDdTAqHaqbpqvAOOR3SswehjBqUPs5wimYiCw+h
	DAkg/M3E2sufDpdODT+tVb9+YpNbEs+TFxTbsq0tvg99qXpwGbQJUY/MiyWXiEH20l+sVQu2ntd
	pGSQquR6ySYTVOGIZFsj3SEJSNFZVsE8=
X-Gm-Gg: AY/fxX7hbp34/UgEqilF35IGR/uzt+5jb1Kfitl8+/JrlnzoAYt7PjFR3AS2gRnu6yf
	DwRJNtTLTaxBVeMZVMXGDFGGEkiUUcnA/Txv9RIk9BePv541edCTZdR68oK9Z1ynk79aLJ4MssC
	mcMIk1nuK7NiZOhlSt4OYcHVgeXBXZkD+PZzcOObqBB1+KiPbmpgPKmiwm28ZwxP6MDAf9SO1Ov
	bdcQ/0I8djzfMgxig7+Vq9KUsRk5rm6c2vIzwRfEW9kuRzbWq4TbKS/Iu09Wn0cIH1HkAKdRO37
	Ibpn+GaVQO+8tr3MEQLKEpH2ySU=
X-Google-Smtp-Source: AGHT+IGh0V1SLPMtWrM+nr6WwjoDlENWs63Ye611oRRjOwteB4jPAcTAU/jcmHCf0kVYdFZx/68puELQo9yKVW9DG4A=
X-Received: by 2002:a05:6402:146c:b0:641:5a28:54ad with SMTP id
 4fb4d7f45d1cf-6496c95cee6mr2016371a12.0.1765362292879; Wed, 10 Dec 2025
 02:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com> <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV> <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp> <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
In-Reply-To: <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 10 Dec 2025 11:24:40 +0100
X-Gm-Features: AQt7F2q-uNrRAVoauEFd4XTyV4S-mPwsCxbyFQVeAlCJKxVRp8bleN0QcDz9Ek0
Message-ID: <CAGudoHE+WQBt4=Fb39qoYtwceHTWdgAamZDvDq1DAsAU9Qh=ng@mail.gmail.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
To: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, brauner@kernel.org, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 11:09=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 10-12-25 18:45:26, Tetsuo Handa wrote:
> > syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> > introduced by commit e631df89cd5d ("fs: speed up path lookup with cheap=
er
> > handling of MAY_EXEC"), for make_bad_inode() is blindly changing file t=
ype
> > to S_IFREG. Since make_bad_inode() might be called after an inode is fu=
lly
> > constructed, make_bad_inode() should not needlessly change file type.
> >
> > Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3Dd222f4b7129379c3d5bc
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> No. make_bad_inode() must not be called once the inode is fully visible
> because that can cause all sorts of fun. That function is really only goo=
d
> for handling a situation when read of an inode from the disk failed or
> similar early error paths. It would be great if make_bad_inode() could do
> something like:
>
>         VFS_BUG_ON_INODE(!(inode_state_read_once(inode) & I_NEW));
>
> but sadly that is not currently possible because inodes start with i_stat=
e
> set to 0 and some places do call make_bad_inode() before I_NEW is set in
> i_state. Matheusz wanted to clean that up a bit AFAIK.
>

[ most unfortunate timing, I just sent an e-mail with an assumption
that make_bad_inode() has to be callable after the inode+dentries got
published. :> ]

I'm delighted to see the call is considered bogus.

As for being able to assert on it, I noted the current flag handling
for lifecycle tracking is unhelpful.

Per your response, i_state =3D=3D 0 is overloaded to mean the inode is
fully sorted out *and* that it is brand new.

Instead clear-cut indicators are needed to track where the inode is in
its lifecycle.

I proposed 2 ways: a dedicated enum or fucking around with flags.

Indeed the easiest stepping stone for the time being would be to push
up I_NEW to alloc_inode and assert on it in places which set the flag.
I'm going to cook it up.

> Until the cleanup is done, perhaps we could add:
>
>         VFS_BUG_ON_INODE(inode->i_dentry->first);
>
> to make_bad_inode() and watch the fireworks from syzbot. But at least the
> bugs would be attributed to the place where they are happening.
>

Note the assert which is currently tripping over is very much
necessary for correctness as the new routine skips checking the type
on its own.

Thus the issue needs to get solved for 6.19.

Trying to weed out all of the make_bad_inode callers is probably too
much for the release cycle.

So I stand by patching this up to a state where the lookup routine can
reliably check that this is what happened, should it find a non-dir
inode and doing a proper fix for the next merge window.

>                                                                 Honza
>
> > ---
> > Should we implement all callbacks (except get_offset_ctx callback which=
 is
> > currently used by only tmpfs which does not call make_bad_inode()) with=
in
> > bad_inode_ops, for there might be a callback which is expected to be no=
n-NULL
> > for !S_IFREG types? Implementing missing callbacks is good for eliminat=
ing
> > possibility of NULL function pointer call. Since VFS is using
> >
> >     if (!inode->i_op->foo)
> >         return error;
> >     inode->i_op->foo();
> >
> > pattern instead of
> >
> >     pFoo =3D READ_ONCE(inode->i_op->foo)
> >     if (!pFoo)
> >         return error;
> >     pFoo();
> >
> > pattern, suddenly replacing "one i_op with i_op->foo !=3D NULL" with "a=
nother
> > i_op with i_op->foo =3D=3D NULL" has possibility of NULL pointer functi=
on call
> > (e.g. https://lkml.kernel.org/r/18a58415-4aa9-4cba-97d2-b70384407313@I-=
love.SAKURA.ne.jp ).
> > If we implement missing callbacks, e.g. vfs_fileattr_get() will start
> > calling security_inode_file_getattr() on bad inode, but we can eliminat=
e
> > possibility of inode->i_op->fileattr_get =3D=3D NULL when make_bad_inod=
e() is
> > called from security_inode_file_getattr() for some reason.
> >
> >  fs/bad_inode.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> > index 0ef9bcb744dd..ff6c2daecd1c 100644
> > --- a/fs/bad_inode.c
> > +++ b/fs/bad_inode.c
> > @@ -207,7 +207,19 @@ void make_bad_inode(struct inode *inode)
> >  {
> >       remove_inode_hash(inode);
> >
> > -     inode->i_mode =3D S_IFREG;
> > +     switch (inode->i_mode & S_IFMT) {
> > +     case S_IFREG:
> > +     case S_IFDIR:
> > +     case S_IFLNK:
> > +     case S_IFCHR:
> > +     case S_IFBLK:
> > +     case S_IFIFO:
> > +     case S_IFSOCK:
> > +             inode->i_mode &=3D S_IFMT;
> > +             break;
> > +     default:
> > +             inode->i_mode =3D S_IFREG;
> > +     }
> >       simple_inode_init_ts(inode);
> >       inode->i_op =3D &bad_inode_ops;
> >       inode->i_opflags &=3D ~IOP_XATTR;
> > --
> > 2.47.3
> >
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

