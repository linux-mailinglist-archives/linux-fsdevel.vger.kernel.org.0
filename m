Return-Path: <linux-fsdevel+bounces-50117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF2AC85B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35E516BE18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 00:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02733987;
	Fri, 30 May 2025 00:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI/DRy1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841F2907;
	Fri, 30 May 2025 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748565749; cv=none; b=RQG34tAbtTJKzdcIldK4+HtVBq7Q5TAWKLwon60qKSAcZqWW0O7XIKjPUjEzCFGHw6xslRJ7Ux9tjS29YezKtXR+tYAc0DJQuwXoXBY6671dmOxeKDJaxpGm1aEqEGEEn71HcY5pHtscu4GH66B9wGXBiwS4UvomguTa8quFwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748565749; c=relaxed/simple;
	bh=7bEkvTOnQCSK2sw2Na277q6zkrloQhkHZ3+iRT9SH4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7XFfqOcwFfRZWBXxN0n5/g7nJ1N41evUU5bJguY/yduopH5NzUjMDhbUmzUwf3CAkQgBeG4L8hkkV3t/KLoKbHHaGoV4IMZaHWXgI95qpeFzuModGI9AnZXI1edk8cW2uZVgdmHZT9D8J/YgGsBP0ml7a2Y6kNDuGXZ24UUxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI/DRy1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB180C4AF09;
	Fri, 30 May 2025 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748565749;
	bh=7bEkvTOnQCSK2sw2Na277q6zkrloQhkHZ3+iRT9SH4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GI/DRy1TUmCvGHwjRyvzfAQQ9MFa+h9Qei6mR2XNBpi2YOZnwSghcXI+oa95zFwI3
	 TNe1MYRk5qIVX2dr9XDoA/T1MFltSgFDvYu7d53RiTVLN9T1E5oTShrKV3o7WqkBn3
	 tpaEz9VYjuVfgk9r5nXFQMxpkbKA+sKe+Nvjl5EGKMlT9/bySFixL0SH8pHx5b4b15
	 No76H0/t7fTQLk/ja6zXXOQkTSs7cZLAtHNc+k/1GkJO4oxd3Ki1B1slWiOX/rycMp
	 z4WjhK6E6A81eNOBOBPDZd64UT+x32HLh+W9pMxRzdUl15UXJUGDbKbXuNArNQ8K22
	 npCmnaNWSLZnQ==
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476a720e806so13277411cf.0;
        Thu, 29 May 2025 17:42:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWFp4sOvERXOYlerA/l/gDMg6ehSp46oqsPmmizurDXPWHvg6uvPdGlSRa0SIyRQrZidw=@vger.kernel.org, AJvYcCUxk1ZLRdTG13ZmcWZgaNTeInhjqRWrH0yoo5XCgEHR3h9LT3C8hFpQDsJierDGhtmCdvOgLFpazuyBztF3@vger.kernel.org, AJvYcCVfPyjeFlL+sI/Rnjg/9+x0qMhKKYmjr/w6mYRs0NromghybUcPKIcLVjzNMof1bMzDbZU2ZIRYkdpWJE/+biw4ghCHYEl0@vger.kernel.org, AJvYcCW+rdiuov63382NWrc3r3e7Jp8ufcsog7R0YqzEpavdKTqFr31Z9BI6P5LSy0drLsYhvTrUqAG00UZ6QjcySA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Lt9wvlgScQ2CWjsIjRaY4+MvaJa/KsJBWCtoDePtvjYjRHnc
	ce1dkxxCHIbG1OX15MH+n3LVxdg99At2ANTjdwiecdAFXLfh39nKotEp0WqoRJuX2C6UZs19ubQ
	I1LmNj5kjCPIV4E2YANu3JbvcMi6Kcrg=
X-Google-Smtp-Source: AGHT+IGGGJvTIObZ60heIR5yqNHLAS2YoqnPZNzVO/6WrFAaaJsKljhGnZyGkTVQZnuSXcgLVahmSs4v22gHvONGMaY=
X-Received: by 2002:a05:622a:1c14:b0:4a4:2f43:fb4e with SMTP id
 d75a77b69052e-4a440010735mr31040801cf.3.1748565748062; Thu, 29 May 2025
 17:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV> <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV> <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
 <20250529201551.GN2023217@ZenIV> <CAPhsuW5DP1x_wyzT1aYjpj3hxUs4uB8vdK9iEp=+i46QLotiOg@mail.gmail.com>
 <20250529214544.GO2023217@ZenIV> <CAPhsuW5oXZVEaMwNpSF74O7wZ_f2Qr_44pu9L4_=LBwdW5T9=w@mail.gmail.com>
 <20250529231018.GP2023217@ZenIV>
In-Reply-To: <20250529231018.GP2023217@ZenIV>
From: Song Liu <song@kernel.org>
Date: Thu, 29 May 2025 17:42:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
X-Gm-Features: AX0GCFvdxMXrtmIn1lcuA6IWSFQd3Sx1TkLEWLyJGOYk7DtqDvgz8-KgHXA52OQ
Message-ID: <CAPhsuW6-J+NUe=jX51wGVP=nMFjETu+1LUTsWZiBa1ckwq7b+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 4:10=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, May 29, 2025 at 03:13:10PM -0700, Song Liu wrote:
>
> > Is it an issue if we only hold a reference to a MNT_LOCKED mount for
> > short period of time? "Short period" means it may get interrupted, page
> > faults, or wait for an IO (read xattr), but it won't hold a reference t=
o the
> > mount and sleep indefinitely.
>
> MNT_LOCKED mount itself is not a problem.  What shouldn't be done is
> looking around in the mountpoint it covers.  It depends upon the things
> you are going to do with that, but it's very easy to get an infoleak
> that way.
>
> > > OTOH, there's a good cause for moving some of the flags, MNT_LOCKED
> > > included, out of ->mnt_flags and into a separate field in struct moun=
t.
> > > However, that would conflict with any code using that to deal with
> > > your iterator safely.
> > >
> > > What's more, AFAICS in case of a stack of mounts each covering the ro=
ot
> > > of parent mount, you stop in each of those.  The trouble is, umount(2=
)
> > > propagation logics assumes that intermediate mounts can be pulled out=
 of
> > > such stack without causing trouble.  For pathname resolution that is
> > > true; it goes through the entire stack atomically wrt that stuff.
> > > For your API that's not the case; somebody who has no idea about an
> > > intermediate mount being there might get caught on it while it's gett=
ing
> > > pulled from the stack.
> > >
> > > What exactly do you need around the mountpoint crossing?
> >
> > I thought about skipping intermediate mounts (that are hidden by
> > other mounts). AFAICT, not skipping them will not cause any issue.
>
> It can.  Suppose e.g. that /mnt gets propagation from another namespace,
> but not the other way round and you mount something on /mnt.
>
> Later, in that another namespace, somebody mounts something on wherever
> your /mnt gets propagation to.  A copy will be propagated _between_
> your /mnt and whatever you've mounted on top of it; it will be entirely
> invisible until you umount your /mnt.  At that point the propagated
> copy will show up there, same as if it had appeared just after your
> umount.  Prior to that it's entirely invisible.  If its original
> counterpart in another namespace gets unmounted first, the copy will
> be quietly pulled out.

Thanks for sharing this information!

> Note that choose_mountpoint_rcu() callers (including choose_mountpoint())
> will have mount_lock seqcount sampled before the traversal _and_ recheck
> it after having reached the bottom of stack.  IOW, if you traverse ..
> on the way to root, you won't get caught on the sucker being pulled out.

In some of our internal discussions, we talked about using
choose_mountpoint() instead of follow_up(). I didn't go that direction in t=
his
version because it requires holding "root". But if it makes more sense
to use, choose_mountpoint(), we sure can hold "root".

Alternatively, I think it is also OK to pass a zero'ed root to
choose_mountpoint().

> Your iterator, OTOH, would stop in that intermediate mount - and get
> an unpleasant surprise when it comes back to do the next step (towards
> /mnt on root filesystem, that is) and finds that path->mnt points
> to something that is detached from everything - no way to get from
> it any further.  That - despite the fact that location you've started
> from is still mounted, still has the same pathname, etc. and nothing
> had been disrupted for it.
>
> And yes, landlock has a narrow race in the matching place.  Needs to
> be fixed.  At least it does ignore those as far as any decisions are
> concerned...

If we update path_parent in this patchset with choose_mountpoint(),
and use it in Landlock, we will close this race condition, right?

>
> Note, BTW, that it might be better off by doing that similar to
> d_path.c - without arseloads of dget_parent/dput et.al.; not sure
> how feasible it is, but if everything in it can be done under
> rcu_read_lock(), that's something to look into.

I don't think we can do everything here inside rcu_read_lock().
But d_path.c does have some code we can probably reuse or
learn from. Also, we probably need two variations of iterators,
one walk until absolute root, while the other walk until root of
current->fs, just like d_path() vs. d_absolute_path(). Does this
sound reasonable?

Thanks,
Song

