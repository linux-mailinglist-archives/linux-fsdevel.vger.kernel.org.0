Return-Path: <linux-fsdevel+bounces-50272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD4BACA4B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F99C3A5230
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3586A29B229;
	Sun,  1 Jun 2025 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MabEE4Ge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7325B1F6;
	Sun,  1 Jun 2025 23:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820846; cv=none; b=jt+2EUdcnKGo46Wbm2KWfwsFQXkIb03/LFpYXa/VxKdIrq40ky03Ahyw4dM72cBL/o8W4PIVyKbpcItQ8vsrwglchOfRDL+yy8+/n4pGfC9OppYOh42zyeryQEkq5yNv+SFi3Mpm7wT+lvP1bqqgpd61EVMsbkHI2Rp3qv02SrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820846; c=relaxed/simple;
	bh=rk0tabcEWUSi/dC9aSwcckp47FWChuCrYj4ecTRM91o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6seyRqg5ysqXYdxQtUcMpbfQBhfJrDhLIVxN4fF/HKJzyg0tv9Xc3rNhfb9El+cZye6zMJZ9Gb4cNDm2+PZCCqq11IyvynTMpFZmb1bLbYB3avaUItYpYLG9y9RRNY2A+BBC9PAmSgunteSOAyG0HJx1r8fNgY85+ekgmckg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MabEE4Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E59C4CEF4;
	Sun,  1 Jun 2025 23:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820846;
	bh=rk0tabcEWUSi/dC9aSwcckp47FWChuCrYj4ecTRM91o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MabEE4GeCqRyYjuCSJaW2MyeZmOnZq7/KJkYHa3ShOkvedUnN/QbtopQvMUbkSFWX
	 U9pNA2uwAddylgWXfHpxNECl2ajnIQ5/v7icrsi2MM37d9SHZpBFq82Jktd9Fc1h27
	 UkIp1p1hQgjXkwVzri8xvSbhmiJVbLW30b1/6xQpDis81ZIzDg1NTeQs7Lmf98/OYn
	 FLK37jCD9Mnk81LaaUQ727dlM6w35nz5D4gE8v3x5tRC9oN30+1IlVw8NGTf3ZnzJu
	 mS0fzeGAYA+HROwhLZeptu85MRvVfftPE0QZBxg1Y/f3nplmnOYw4BS1zTTvdWXEu8
	 aSepbpNk0zo8g==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a58b120bedso6582351cf.2;
        Sun, 01 Jun 2025 16:34:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuZygCQ5sWdoPCd9uDdnGuJnessFZcsy8RMALGVAY6pTfzTTjof63+ohaHnQ9NH6jCNYUBx9vEJc0z+593@vger.kernel.org, AJvYcCWg8fMxGCnFbCaeVMvEdO43J9/7bRhW57eDJNFjNOVEna5RwbUM3KLBpM4iwf43Ev+XRu83gqfIMpzlX+Ih0RrORTU1xN4M@vger.kernel.org, AJvYcCWu6B+8DyqsEmvp42Cev0ANdTyTWrELjljzi1HrPnTMAB6TSYLFPXrslnIYG3LgVkPIWr4=@vger.kernel.org, AJvYcCXpHofaKIiRqIg93oaA07lNJdCDx/NhefdPsZEwO8TPsXD8ebK7xraiATVNl4lbtVfRXrJu6eVfcxaNFIBpiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7IBHtDPyYcjHR7HinuZ/+8bGgC3gb1+1YSyzIbKxoYgoarXr
	O/ff7qABy6VGZUAw4Yo82j+r0amtlEUsCoHH/pGaWFUSGXhOuPtzIVKeYc4fO+i6IhqIgWn1+L/
	eIQS9K8ynLP0PK/oNybNbdju48AKxbSA=
X-Google-Smtp-Source: AGHT+IHOvTvmxzCnGRB15ilIwIuBdUILgcIB1Uvm7hMB6a6v7w4pR7/ko4VNimzWKkM0RBFYUda6oz0YfDOzt8wtpMo=
X-Received: by 2002:a05:622a:2289:b0:4a4:3d6e:57d4 with SMTP id
 d75a77b69052e-4a4aed5cd9emr102149661cf.46.1748820845563; Sun, 01 Jun 2025
 16:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV> <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV> <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV> <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV> <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
 <20250530.euz5beesaSha@digikod.net> <CAPhsuW5U-nPk4MFdZSeBNds0qEHjQZrC=c5q+AGNpsKiveC2wA@mail.gmail.com>
 <c2d0bae8-691f-4bb6-9c0e-64ab7cdaebd6@maowtm.org>
In-Reply-To: <c2d0bae8-691f-4bb6-9c0e-64ab7cdaebd6@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Sun, 1 Jun 2025 16:33:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW47C+FqtdHEE5YYKhjkaYLn-JbAPfo_q0fXf2FzTfiAog@mail.gmail.com>
X-Gm-Features: AX0GCFvwUwAeA88LUr4ia35HRc3kUaSu9RbQ8RV0pI3vVH27tH9vknp9Dfv46Bk
Message-ID: <CAPhsuW47C+FqtdHEE5YYKhjkaYLn-JbAPfo_q0fXf2FzTfiAog@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, brauner@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com, 
	jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 7:05=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
>
> On 5/30/25 19:55, Song Liu wrote:
> > On Fri, May 30, 2025 at 5:20=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > [...]
> >>>
> >>> If we update path_parent in this patchset with choose_mountpoint(),
> >>> and use it in Landlock, we will close this race condition, right?
> >>
> >> choose_mountpoint() is currently private, but if we add a new filesyst=
em
> >> helper, I think the right approach would be to expose follow_dotdot(),
> >> updating its arguments with public types.  This way the intermediates
> >> mount points will not be exposed, RCU optimization will be leveraged,
> >> and usage of this new helper will be simplified.
> >
> > I think it is easier to add a helper similar to follow_dotdot(), but no=
t with
> > nameidata. follow_dotdot() touches so many things in nameidata, so it
> > is better to keep it as-is. I am having the following:
> >
> > /**
> >  * path_parent - Find the parent of path
> >  * @path: input and output path.
> >  * @root: root of the path walk, do not go beyond this root. If @root i=
s
> >  *        zero'ed, walk all the way to real root.
> >  *
> >  * Given a path, find the parent path. Replace @path with the parent pa=
th.
> >  * If we were already at the real root or a disconnected root, @path is
> >  * not changed.
> >  *
> >  * Returns:
> >  *  true  - if @path is updated to its parent.
> >  *  false - if @path is already the root (real root or @root).
> >  */
> > bool path_parent(struct path *path, const struct path *root)
> > {
> >         struct dentry *parent;
> >
> >         if (path_equal(path, root))
> >                 return false;
> >
> >         if (unlikely(path->dentry =3D=3D path->mnt->mnt_root)) {
> >                 struct path p;
> >
> >                 if (!choose_mountpoint(real_mount(path->mnt), root, &p)=
)
> >                         return false;
> >                 path_put(path);
> >                 *path =3D p;
> >                 return true;
> >         }
> >
> >         if (unlikely(IS_ROOT(path->dentry)))
> >                 return false;
> >
> >         parent =3D dget_parent(path->dentry);
> >         if (unlikely(!path_connected(path->mnt, parent))) {
> >                 dput(parent);
> >                 return false;
> >         }
> >         dput(path->dentry);
> >         path->dentry =3D parent;
> >         return true;
> > }
> > EXPORT_SYMBOL_GPL(path_parent);
> >
> > And for Landlock, it is simply:
> >
> >                 if (path_parent(&walker_path, &root))
> >                         continue;
> >
> >                 if (unlikely(IS_ROOT(walker_path.dentry))) {
> >                         /*
> >                          * Stops at disconnected or real root directori=
es.
> >                          * Only allows access to internal filesystems
> >                          * (e.g. nsfs, which is reachable through
> >                          * /proc/<pid>/ns/<namespace>).
> >                          */
> >                         if (walker_path.mnt->mnt_flags & MNT_INTERNAL) =
{
> >                                 allowed_parent1 =3D true;
> >                                 allowed_parent2 =3D true;
> >                         }
> >                         break;
>
>
> Hi, maybe I'm missing the complete picture of this code, but since
> path_parent doesn't change walker_path if it returns false (e.g. if it's
> disconnected, or choose_mountpoint fails), I think this `break;` should b=
e
> outside the
>
>     if (unlikely(IS_ROOT(walker_path.dentry)))
>
> right? (Assuming this whole thing is under a `while (true)`) Otherwise we
> might get stuck at the current path and get infinite loop?

Right, we need "break" outside the if condition.

Thanks,
Song

