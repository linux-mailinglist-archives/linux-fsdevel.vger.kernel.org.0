Return-Path: <linux-fsdevel+bounces-19917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE1C8CB25C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76782822FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0FF147C71;
	Tue, 21 May 2024 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq2IK6AX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6E14291A;
	Tue, 21 May 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309759; cv=none; b=I7yiqe7q+eB3VHyntlhLLwFrGwk3pzXhR/WAj8sydlpKnDDZaFnW58uODwuGtLoy51zNjD/l2oQqrpMBCW8qB2zCX26QOX2DS568VSKp1lT6vrRzcXVUkBjZP5hYqYI+qgTaCVQTNzE6GP0SviwpnYgzCnpA62aOBw9qhCSRZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309759; c=relaxed/simple;
	bh=b3vJYeq2c/Fy9GBJ9NFMGIQ1sY8Bu/WdYlNzn1s5Gg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/fr8M5QeTZPhjFY5v7ZbOIvK6PS8wZesY/+sS7/pQGUJWDaVc7Yfysem8ys7tAHY3U53rfuvz+vvQQ2D+8sNtwZwSZhVxlo8OiuVL9RSTyjBnp2Z24y3WG+rH/DySF7sg8OkrllJTA95DK4Z9E9OmGT6jGxQjWeefYQcevY9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq2IK6AX; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f361af4cb6so436536a34.3;
        Tue, 21 May 2024 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716309757; x=1716914557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3vJYeq2c/Fy9GBJ9NFMGIQ1sY8Bu/WdYlNzn1s5Gg8=;
        b=fq2IK6AXX4nv+RPz1i1r41qNyzRkItjKpFFUfr7bQnTOSCkj7BTuBHnaXUr0tHqB3u
         2lWrY5MtUwDy/39XIfMAk1oRew5JiCELgrDMkDkgJKTO7121itL1hNCVMlI/qrj0C+vp
         mBBPH5VJRby2vReEZ2w9XGoNA7rccEtpaZvgWp+tMS6f5jq4dhFP/LmOarQfWPqs4Hjv
         VXJOvAbCOTR0WI6ljI66x//ufm7Rdizi86pr3p+R1XqyfbkAFWpCLevCLW1GWb+8C9Z4
         oGtXg1dvPiJjcLi0dF4rEcEPuSGFSBIvMdYkUhl3jO1PJ1QqGYedA0KSqzTNLWCVHtrK
         59sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716309757; x=1716914557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3vJYeq2c/Fy9GBJ9NFMGIQ1sY8Bu/WdYlNzn1s5Gg8=;
        b=ck6jBph3wrT36i6ehSa2EZSybzNnZ9qIwFh6X39bPpzi9iah0zqO86R+ZMJEr+ovx5
         ThTHj0faiVK1nsLujeEXwvcOPGygotoVBptX0McA6evbLmREZkwZC+wZyOlRJajcNWg/
         yr5Um+2MbCFdRuNeZoclVe6myzo6nUxN5U8Z4FsLE0mc4x2XS7VaWtgGLtKfgxAlj16D
         HEl05LhP/Y10UvYvk5MD5WiQ4qn4lGqQb4erKc8ONfR4dFJ6uPInsR0dCmXVlCu85Mzs
         p1VGiMTpd/g/Vif38l3BaWyJI6SAf4jOe+NmP7oxoXNlAVlXlekzgUZr3kfkjDQ6PBli
         a/jA==
X-Forwarded-Encrypted: i=1; AJvYcCWNs/nHDez8xJtzw2FrUYrYLtVZic7jNH/NsAm/jxFlQLYHYSv6SqYejKTBERXiLYh48IWGBm4+7gk77A06Zu5UbRsCEskcGvX3gWZ1zTe+GYtEjE6ZbOQtoHixSSPy0kA7ySrgdSt8nQ60ao7S5bOa9uZBxd2+WlXB4H4yoQfwGjXLQ6Kw9w==
X-Gm-Message-State: AOJu0YyGOmBiGnooQ58lCA76T7aw9T7pQrwO18LYnanjGMGe+/IN9t2C
	5vRuNU9TcxMemmV0yshK4DljIyWtKWM56s76oQ+LLYWOxiHlKxaMSIrDU0uLGpIjEQn9GBcinB+
	fUVfhu1ICzwWj2JCpXTw1tw/hxh0=
X-Google-Smtp-Source: AGHT+IFVFIsEpDpaEBEW3QKQFxNBTB3wyzGGSV9GszInZywIc5OPzc/pYM52Mn5aPmPMog3xsBZ4s3rtmI0vyqROLdE=
X-Received: by 2002:a05:6870:13d4:b0:233:5557:c6a2 with SMTP id
 586e51a60fabf-24172c4da6dmr37618771fac.34.1716309757190; Tue, 21 May 2024
 09:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520-exportfs-u64-mount-id-v1-1-f55fd9215b8e@cyphar.com>
 <20240521-verplanen-fahrschein-392a610d9a0b@brauner> <20240521-patentfrei-weswegen-0395678c9f9a@brauner>
 <d225561221f558fe917e5554102394ce778a3758.camel@kernel.org>
In-Reply-To: <d225561221f558fe917e5554102394ce778a3758.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 May 2024 19:42:25 +0300
Message-ID: <CAOQ4uxhbOzzawKeCNSCbFtPZAfiZFDXCqK4b_VSXeNyHxpbQsw@mail.gmail.com>
Subject: Re: [PATCH RFC] fhandle: expose u64 mount id to name_to_handle_at(2)
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2024-05-21 at 16:11 +0200, Christian Brauner wrote:
> > On Tue, May 21, 2024 at 03:46:06PM +0200, Christian Brauner wrote:
> > > On Mon, May 20, 2024 at 05:35:49PM -0400, Aleksa Sarai wrote:
> > > > Now that we have stabilised the unique 64-bit mount ID interface in
> > > > statx, we can now provide a race-free way for name_to_handle_at(2) =
to
> > > > provide a file handle and corresponding mount without needing to wo=
rry
> > > > about racing with /proc/mountinfo parsing.
> > > >
> > > > As with AT_HANDLE_FID, AT_HANDLE_UNIQUE_MNT_ID reuses a statx AT_* =
bit
> > > > that doesn't make sense for name_to_handle_at(2).
> > > >
> > > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > > ---
> > >
> > > So I think overall this is probably fine (famous last words). If it's
> > > just about being able to retrieve the new mount id without having to
> > > take the hit of another statx system call it's indeed a bit much to
> > > add a revised system call for this. Althoug I did say earlier that I
> > > wouldn't rule that out.
> > >
> > > But if we'd that then it'll be a long discussion on the form of the n=
ew
> > > system call and the information it exposes.
> > >
> > > For example, I lack the grey hair needed to understand why
> > > name_to_handle_at() returns a mount id at all. The pitch in commit
> > > 990d6c2d7aee ("vfs: Add name to file handle conversion support") is t=
hat
> > > the (old) mount id can be used to "lookup file system specific
> > > information [...] in /proc/<pid>/mountinfo".
> > >
> > > Granted, that's doable but it'll mean a lot of careful checking to av=
oid
> > > races for mount id recycling because they're not even allocated
> > > cyclically. With lots of containers it becomes even more of an issue.=
 So
> > > it's doubtful whether exposing the mount id through name_to_handle_at=
()
> > > would be something that we'd still do.
> > >
> > > So really, if this is just about a use-case where you want to spare t=
he
> > > additional system call for statx() and you need the mnt_id then
> > > overloading is probably ok.
> > >
> > > But it remains an unpleasant thing to look at.
> >
> > And I'd like an ok from Jeff and Amir if we're going to try this. :)
>
> I don't have strong feelings about it other than "it looks sort of
> ugly", so I'm OK with doing this.
>
> I suspect we will eventually need name_to_handle_at2, or something
> similar, as it seems like we're starting to grow some new use-cases for
> filehandles, and hitting the limits of the old syscall. I don't have a
> good feel for what that should look like though, so I'm happy to put
> that off for a while.

I'm ok with it, but we cannot possibly allow it without any bikeshedding...

Please call it AT_HANDLE_MNT_ID_UNIQUE to align with
STATX_MNT_ID_UNIQUE

and as I wrote, I do not like overloading the AT_*_SYNC flags
and as there is no other obvious candidate to overload, so
I think that it is best to at least declare in a comment that

/* 0x00ff flags are reserved for per-syscall flags */

and use one of those bits for AT_HANDLE_MNT_ID_UNIQUE.

It does not matter whether we decide to unify the AT_ flags
namespace with RENAME_ flags namespace or not.

The fact that there is a syscall named renameat2() with a flags
argument, means that someone is bound to pass in an AT_ flags
in this syscall sooner or later, so the least we can do is try to
delay the day that this will not result in EINVAL.

Thanks,
Amir.

P.S.: As I mentioned to Jeff in LSFMM, I have a patch in my tree
to add AT_HANDLE_CONNECTABLE which I have not yet
decided if it is upstream worthy.

