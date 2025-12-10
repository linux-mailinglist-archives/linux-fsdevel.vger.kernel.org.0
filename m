Return-Path: <linux-fsdevel+bounces-71084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 183D8CB444A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FB04302AE0F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 23:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0D28CF49;
	Wed, 10 Dec 2025 23:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjDUghot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3847C3081DB
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409248; cv=none; b=k9mjxOjtWmOBoVc59WzfQXNKmqAoEn5HtQcNIpNgiM3vawcG1ZywmI2yQEGS4yH/lQ1kS8O35RfU5ixIHWfxQTAAWSqEL6IjJQSlIJzNK/rqzx+aeHqt+mYfpx0nILNs6ox3xU+SZ7Jvk8TQIH7q3MMSXft6tes3HL+mpuai7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409248; c=relaxed/simple;
	bh=DoXwjGhLfQ6O0INuzypaERYkTOf/Xfv/Nd6aB7ZCJdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHm1VlphXebpfdAweH27QZjYJhuYrzW/Iq3HurmKCmD3bTsGcdL9ql8gOTTsncO55QLshQRTjyY6Yy0eAeuR+Nsd/HprqtGUDSGeP/tfjftAjGl13QRPqXL4wua3IkeJX6F3ZxNYYvlrzq0AblQ1pCGSbTOEotZ75NYMwQnZumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjDUghot; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7a02592efaso44565366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 15:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765409237; x=1766014037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN8NB55nHLjC7gpWBKUqwQHD/ijjW2pyznq7L+gzEBA=;
        b=mjDUghotvfQHHofL0ySlW69FXHaaBhLm0/vh5YQBkcG6jIxhaezuZlI3bqe98Bf/Mz
         8S7vE1ZTemOHpVF0RtA5yRcMzc5ahxPwZj7LWEOQ5rsq0bLL8yz0UhEK6pEy9uy2kX6a
         nfAunq7Km4D4vdD6aRmQBiD+bhnIYBDgYjely3e6dc6JlhpQL3nK9hC7tAcvF8kpuOXA
         l4w48DUcudJXRjXbaPzMve8t66H1NnleikB1pAvrXsPSi3Hjyb1YiK+H22YC5+79Ht0d
         YgQHR8cg2EfcP2GMI1ky3pXaaunF3FnRcf63tWANhnfUQ+52s+WLCQCvTNq0e+dVT8wY
         Xe7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765409237; x=1766014037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lN8NB55nHLjC7gpWBKUqwQHD/ijjW2pyznq7L+gzEBA=;
        b=DjjEkPnOePWTkiZFqT7Ua52eLT8CAag1k3S+v+R+WkePLkgfrmLD5YUvE9g6C2QkZe
         8GO1utwhOMOCTyerMSmGBemx4AmdQZRxvS/Dxng/1tn1a0iGMYDxm5gJMpkW4wxHBeLa
         lk38MLQy0JirZckHWGwN4BpMl7+LzIkDA7F8EKgD2+ULdTncJWhUyxb8z8KdGf118ofm
         9UT/VDbhtXHSxqD68ZYlpk6rTs+JTIscHM6jvhjPN1tT/qCsNKyiPlpntjIYCVyk85iC
         MQ71i8pj+DkLZQcWxfoSMItkLVt0GpfJdfxMcJEdr8ty7Zu0yAWaBknbTqCW+anSl6wX
         ERtA==
X-Forwarded-Encrypted: i=1; AJvYcCX42WhOR+ofMQv/dO+bzsn2gdS1rxxSKKjNvlMdyiO5/lV7mfAv3KLZubY//MRSH0psLimpAe1tA2pYePBj@vger.kernel.org
X-Gm-Message-State: AOJu0YyH/l/ZF0bnhODv9lOtbsgvjk0rG5+KrvY0FM2GleGM386h7L0L
	pSNI9t2Kt9sXRaiRgjhm7BnBcb920Gkc20BM3lMb8k3gMnV0RA+iutrldxINdE4QLgjt0Yo8Wx/
	8izACFZ5padtCHjSXA9W0Rgm5P0AZHn0=
X-Gm-Gg: ASbGncsYlTb32mXokMc3UXZ8FHZ9OzNdmq8YG9ZzSUAkQEvwBu+Y2eK8JZwj2SymeJP
	Vmxhtq+Xzzu+nGFueJrQg4DnfLGrVt/e9EgDzFANWWVg35uSqpvGz3kZ3XUCo/wrd8oh5hYVUk5
	YYvhhvOWQFIYNo2zMGm2RYAxu+68WWgTkT8fkC5ijpm6r0W4tAxjZr/QwFRZ7SLBlG7SO5vtNiS
	MeHy9SURLEbrE10JK5P7E/VqQSNjaF9bGthWTWAWJQHPK/TF1VNB0w/iVqgyXenL7F/KL0v6gJu
	K7LFNCZt+ZVdaao6i7lbbFNm7FbyJVKYCXaqAA==
X-Google-Smtp-Source: AGHT+IHGEOnQKiygEwmbu2JK8/4cUAiCBQ0NcgrrJh0q1P/i3d91XhaklIYwZdtfdem+xPxGhzLd1L0bXLJ/uH2w/bA=
X-Received: by 2002:a17:907:7e8e:b0:b79:cb08:30e with SMTP id
 a640c23a62f3a-b7ce8493888mr430540266b.58.1765409237245; Wed, 10 Dec 2025
 15:27:17 -0800 (PST)
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
 <wqkxevwtev5p77czk2com5zvbbwcpxxeucrt7zbgjciqxjyivx@c7624klburuh>
 <CAGudoHE+WQBt4=Fb39qoYtwceHTWdgAamZDvDq1DAsAU9Qh=ng@mail.gmail.com> <20251210211404.GA1712166@ZenIV>
In-Reply-To: <20251210211404.GA1712166@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 11 Dec 2025 00:27:05 +0100
X-Gm-Features: AQt7F2pNJpaKIuw-0r1AjqkA5nkXEMZ029EnBmE2VhFHHI9ULnRkiIkxrv0pxNs
Message-ID: <CAGudoHEF6O-xR7B2F=6-Gy7t78FvH_f_0YcbmQM9gQAwthFpAA@mail.gmail.com>
Subject: Re: [PATCH for 6.19-rc1] fs: preserve file type in make_bad_inode()
 unless invalid
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>, brauner@kernel.org, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:13=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>
> On Wed, Dec 10, 2025 at 11:24:40AM +0100, Mateusz Guzik wrote:
>
> > I'm delighted to see the call is considered bogus.
> >
> > As for being able to assert on it, I noted the current flag handling
> > for lifecycle tracking is unhelpful.
> >
> > Per your response, i_state =3D=3D 0 is overloaded to mean the inode is
> > fully sorted out *and* that it is brand new.
> >
> > Instead clear-cut indicators are needed to track where the inode is in
> > its lifecycle.
> >
> > I proposed 2 ways: a dedicated enum or fucking around with flags.
> >
> > Indeed the easiest stepping stone for the time being would be to push
> > up I_NEW to alloc_inode and assert on it in places which set the flag.
> > I'm going to cook it up.
>
> You are misinterpreting what I_NEW is about - it is badly named, no
> arguments here, but it's _not_ "inode is new".
>
> It's "it's in inode hash, but if you find it on lookup, you'll need to wa=
it -
> it's not entirely set up".
>

Comments in the hash code make it pretty clear. The above is a part of
a bigger picture, which I already talked about in the 'light refcount'
patchset or whatever the name was.

The general problem statement is that the VFS layer suffers from a
chronic lack of assertions, which in turn helps people add latent bugs
(case in point: make_bad_inode() armed with asserts on state would
have blown up immediately and this entire thread would have been
avoided).

One of the things missing to create good coverage is reliable inode
lifecycle tracking. Currently *some of it* can be determined with some
of the flags in ->i_state, but even there are important states which
are straight up missing, notably whether the filesystem claims the
inode is ready to use *or* not ready at all (not even in the hash) is
indistinguishable by ->i_state. Trying to figure it out by other means
is avoidable tech debt. Bare minimum denoted states have to
distinguish between just allocated, creation aborted, ready to use, in
teardown and finally torn down.

An important part is validating whether inode at hand adheres to the
API contract when the filesystem claims it is ready. For example
->i_mode has to have a valid type set, but syzkaller convinced ntfs to
let an inode with invalid mode get out, which later resulted in a warn
in execve code because may_open() did not apply any of the checks to
it. This is the kind of a problem which can and should be checked for
before the inode is allowed to be used.

Another benefit is that some of the state can be pre-computed. For example =
this:
 static inline int do_inode_permission(struct mnt_idmap *idmap,
                                        struct inode *inode, int mask)
  {
          if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                  if (likely(inode->i_op->permission))
                          return inode->i_op->permission(idmap, inode,
mask);

                  /* This gets set once for the inode lifetime */
                  spin_lock(&inode->i_lock);
                  inode->i_opflags |=3D IOP_FASTPERM;
                  spin_unlock(&inode->i_lock);
          }
          return generic_permission(idmap, inode, mask);
  }

... will stop setting the flag as this aspect will be already sorted
out. There is another crapper of the sort in vfs_readlink and one can
suspect more will show up over time.

Back to lifecycle tracking, I_NEW could change semantics to mean "this
inode *is not* ready for use yet". unlock_new_inode() already serves
as a "this inode *is* ready for use" indicator, it just happens to not
be mandatory to call. Another routine could be added for filesystems
which don't use the hash to cover that gap.

Then for filesystems which *do* use the hash the entire thing is transparen=
t.

> A plenty of inodes never enter that state at all.  Hell, consider pipes.
> Or sockets.  Or anything on procfs.  Or sysfs, or...
>

So whether I change the meaning of I_NEW or add another flag, I will
still need to patch these suckers to do *something* on the inodes they
create.

That's not the whole story, but should be enough to convey what I'm gunning=
 for.

This will also have a side effect of giving I_NEW a more fitting use.

