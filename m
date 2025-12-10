Return-Path: <linux-fsdevel+bounces-71049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56714CB2A32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 11:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21D730F8F1F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D402D8797;
	Wed, 10 Dec 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4tJCMod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557952D837B
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765361380; cv=none; b=fprbayquVfaR43gZDOsqx3g2/DUTmeyErzKu3VO6Wych0ULcu7SFyZN0nW6d8wrkBjsdsTekdDxfwDYu3VZSYbvkeKgYuEkptn9FSLsU8bJgjJGvmHKp3anUb3ZbuX9amDkyGV+xOOwABzm9sMM6ZcbWiw3BOzGoplBN4MmW2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765361380; c=relaxed/simple;
	bh=xaEoF0/MPh1Eb0gj5pOw4dfycGGhAAJhveDl5+6wWOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZPCSx/udGjRSDlYtu94fQmr2qkCEYK4ROr/nIMVWvlAd93n3ukgXHyfB/l/TAMxlqboimxqcCHtKdQV/dopMRI1rxNloVOlGSGz6Y6v1BtZbkljN2QhFxWFIlcdLtnFjJCvYsSkGvSLH4JY3yahWPOrBF64xYrQ/XuvzfkpzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4tJCMod; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso8152001a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 02:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765361376; x=1765966176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9fgjAsvGcj+teQCulpPi/9K/J1bj2Ob5saYqkBMaxU=;
        b=F4tJCModK3ajbl0nHqR3Y3EvAHjD03O6e0qb9ktB0s1TRj3/mFwGrrjda7leCmVMSV
         h1qqlo8Kexa9XRkwfen6Q9pE2hfqL8Hx7qLdd4D6+smDe6kAIsfKlDXBE1UcGdmSQ0nQ
         M0Qv1d/QDFFCafPMrkE7ZHq3CtTybvz3IEHQDQ6gV4n0DdMtZPewK4SvFO7c6KZfegi7
         8GmdDEyLtFGDqGicEGf8Fb46qGiYB6pobJi/JuwcNaf/gCgm+L+LLHtcsSxNPjPD7XRV
         ZuUBJmql+w4WPJ2k5ANS1yFEyyZJ/tTTeC0rqpq7uU4gPhrCCk/Z/J0mFizgKyxfK3yj
         MIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765361376; x=1765966176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J9fgjAsvGcj+teQCulpPi/9K/J1bj2Ob5saYqkBMaxU=;
        b=eOKjXFXmwirVIyzEQ2LxPo9iTPy770MZ/J/wsTR3/FnqeKYha7BsXFTafp9SSi4zyp
         i73GMn8Kmvvm4oYFOBnKe8nq5drzluxgq/cjC/MT8CTQSFvkTqfZuBiu5Inj6CyDidjb
         P1ByQZJGR8QrLpnXI7iHio9CV6uGBHFdEHxn0yo/Z22QzRgKXEPVXLknlBWShjvPe1Oa
         yqQWi6zEAeHUG/2QDwqMzRYD84NuwS/dfzn5CumXVu9ZoroF1RFNPBZwyWW+FQq3zLs6
         gP2ButXDYBAPG9L1cqgoLs/MQNMRZJJObVn4Vj6NfSSBAozg/0tBJGDxmeSCtHwG9OEG
         Te0g==
X-Forwarded-Encrypted: i=1; AJvYcCXSfFvV9KkZoU3ZpdhRrq0MIaydfCiGFGPQ8GTxzPWQ6FozUY3bG4jWvCqUxggQl/HiN5F0t1uUeXdBJaNY@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjX1iISXEWba+NNWpLgkP9FBl3BjL1sa5VhH1O7XO7bBeFNf8
	HXWjm/+ABIcgIglwzIQsO64XqiJDmjxjUdN3ColMzyNqb/nQz8ufgodjT90VLASC6a8nJEFmaOr
	ZG460I6d8BUc2uxJrABcY6bAuPHO3Iik=
X-Gm-Gg: AY/fxX7J2gbtdSi2JYXhhOc7hCWKiIULVmW/sgI/R27q1VpKUSR/yMO3vQsR4C0DVz/
	vm3XSwGWkA62wVG6H/fSZuwMkXc3EbAoTgKgeS21gchtw26xzkEayNHUWNag85X32flxIQ9MUAq
	ovGpPqBT+GaWM1q6+Ph2lYAOxwNhmOVCXfXOIf3yBXUn/VWkO0ovvTGLivkCQMh5p/eKBVXxJYB
	9m81rFExlK0/oTKQSmlQn647kLdDEjE5QDWe5yd9vPbibTB8GEHWiWVRFP7u+QZmEuR8oawu/pY
	6sZq/yywwqeAtpaBiWAKaqz8F60=
X-Google-Smtp-Source: AGHT+IGy0I3mCQplSOf+ZswsX9OB/RcBcnNDw9UAnDUOgRphx26yWqxgu0yrUaNci2TCTwlL+lER0+6G1/IfFXw3Dwk=
X-Received: by 2002:a05:6402:3586:b0:645:f758:4e1b with SMTP id
 4fb4d7f45d1cf-6496cb58613mr1935512a12.14.1765361376081; Wed, 10 Dec 2025
 02:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj>
 <6930e200.a70a0220.d98e3.01bd.GAE@google.com> <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
 <20251204082156.GK1712166@ZenIV> <CAGudoHGLFBq2Fg5ksJeVkn=S2pv6XzxenjVFrQYScA7QV9kwJw@mail.gmail.com>
 <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
In-Reply-To: <7e2bd36e-3347-4781-a6fd-96a41b6c538d@I-love.SAKURA.ne.jp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 10 Dec 2025 11:09:24 +0100
X-Gm-Features: AQt7F2qZ6vkkF7I1BojoU_QOvwPa1IH9AT3oWh2XPktR50pOPYd8c9uuGiN_zaE
Message-ID: <CAGudoHF7jPw347kqcDW2mFLzcJcYqiFLsbFtd-ngYG=vWUz8xQ@mail.gmail.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, brauner@kernel.org, 
	jack@suse.cz, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:45=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is hitting VFS_BUG_ON_INODE(!S_ISDIR(inode->i_mode)) check
> introduced by commit e631df89cd5d ("fs: speed up path lookup with cheaper
> handling of MAY_EXEC"), for make_bad_inode() is blindly changing file typ=
e
> to S_IFREG. Since make_bad_inode() might be called after an inode is full=
y
> constructed, make_bad_inode() should not needlessly change file type.
>

ouch

So let's say calls to make_bad_inode *after* d_instantiate are unavoidable.

While screwing around with inode type for bogus inodes has merit,
switching things up from under dentry is bogus in its own right and
the choice of ISREG is questionable at best -- as is the call
introduces internally inconsistent state, in the case of the original
report a dentry claiming it's a directory pointing to a regular inode.

The non-screwed way of handling this would introduce a known BAD inode
type and patch up dentries as needed as well, but that might be a lot
of churn for not that much benefit.

As is, I don't know if leaving the type unchanged is safe -- there
might be nasty cases which depend on the change.

At the same time I claim the assert I introduced is mandatory.

Absent thorough audit, I think the pragmatic way forward for the time
being is to give code a chance to assert correctness and adjust the
assert in lookup code accordingly.

Right now that's not possible since the reassignment of type happens
without the inode spinlock held. Since make_bad_inode() calls into
remove_inode_hash which takes the spinlock, it should be safe to also
take it around the reassignment.

Then code wishing to assert on type race-free can take the spinlock to
stabilize it.






> Reported-by: syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd222f4b7129379c3d5bc
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> Should we implement all callbacks (except get_offset_ctx callback which i=
s
> currently used by only tmpfs which does not call make_bad_inode()) within
> bad_inode_ops, for there might be a callback which is expected to be non-=
NULL
> for !S_IFREG types? Implementing missing callbacks is good for eliminatin=
g
> possibility of NULL function pointer call. Since VFS is using
>
>     if (!inode->i_op->foo)
>         return error;
>     inode->i_op->foo();
>
> pattern instead of
>
>     pFoo =3D READ_ONCE(inode->i_op->foo)
>     if (!pFoo)
>         return error;
>     pFoo();
>
> pattern, suddenly replacing "one i_op with i_op->foo !=3D NULL" with "ano=
ther
> i_op with i_op->foo =3D=3D NULL" has possibility of NULL pointer function=
 call
> (e.g. https://lkml.kernel.org/r/18a58415-4aa9-4cba-97d2-b70384407313@I-lo=
ve.SAKURA.ne.jp ).
> If we implement missing callbacks, e.g. vfs_fileattr_get() will start
> calling security_inode_file_getattr() on bad inode, but we can eliminate
> possibility of inode->i_op->fileattr_get =3D=3D NULL when make_bad_inode(=
) is
> called from security_inode_file_getattr() for some reason.
>
>  fs/bad_inode.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/bad_inode.c b/fs/bad_inode.c
> index 0ef9bcb744dd..ff6c2daecd1c 100644
> --- a/fs/bad_inode.c
> +++ b/fs/bad_inode.c
> @@ -207,7 +207,19 @@ void make_bad_inode(struct inode *inode)
>  {
>         remove_inode_hash(inode);
>
> -       inode->i_mode =3D S_IFREG;
> +       switch (inode->i_mode & S_IFMT) {
> +       case S_IFREG:
> +       case S_IFDIR:
> +       case S_IFLNK:
> +       case S_IFCHR:
> +       case S_IFBLK:
> +       case S_IFIFO:
> +       case S_IFSOCK:
> +               inode->i_mode &=3D S_IFMT;
> +               break;
> +       default:
> +               inode->i_mode =3D S_IFREG;
> +       }
>         simple_inode_init_ts(inode);
>         inode->i_op =3D &bad_inode_ops;
>         inode->i_opflags &=3D ~IOP_XATTR;
> --
> 2.47.3
>
>

