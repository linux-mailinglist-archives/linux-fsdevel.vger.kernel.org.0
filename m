Return-Path: <linux-fsdevel+bounces-19295-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B98C2F60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 05:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A3B1F22FE4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 03:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B2336AFE;
	Sat, 11 May 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muABUdTn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AFF21A04
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398560; cv=none; b=pkNQw9g4cDS5Jtq0YVPgf4lY9n47w4hNoBQbHbxV3r3PHR13KnYoAIP30+25zG+rF6S15ARcETPk/IVKzHuBuGMUea0LRbOU9YoV6m4pnIhMHfe3XmQfI1g3zDXt9uduM7ES26codHkfihI+I89D5jfNtZ7DC9y/fVDtLnI6bPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398560; c=relaxed/simple;
	bh=IDP/rY++hD8RmPhJVHOEg5UnqeQK60KQ54KquaEz2Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQLVvCZwMY/tuwJSVIGQjqMO5EmDH6yjgqzXO8qp42fWGn7hMZ5OloVefmNj5o9UAWKoXIfvadOzuYFtFK6XnU2N4FgEmRNwThXhUI4OMVaRyh2JWbcK7pub+u6js0wSDj8wwX1T3L9nLx3lTYxKZnckTdX+qm65Ou/nCY8lJwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muABUdTn; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-69b44071a07so22978966d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 20:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715398558; x=1716003358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaotNW2LEy9BzCuFETB98GJB0Ph8OvWtMinR+5ahdUo=;
        b=muABUdTnW3ZTpnMbNRoUjy0/oHv51pVmNTmxAIrjVGBr/cithJwejfHj6cfw5ZBOc0
         Vm/QNO9FAmyLXAjMIrwezJIKV5zlO8qJpfYNFH2wdi46Uag+A+5uq2h7weRrS4gCEzn6
         +PeAT03A8dcx+UPf3aHOirrhwjr8bi7H8JFKlHU13R88n6AV48jHbE4hzQm10l28yv9Y
         dkh7naE6yBUYEd50MXW3wcTxU+P6pN0XQQIQ6WgQaLFrB0k9QVg3HjzFVg51dqBPCSJi
         cpfAl+FFedzYBdD+Z3uSuvCknJ2klOe7fFpY/xobLKdFj9lPccb3jD3hp33+3N6dATA5
         3CmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715398558; x=1716003358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaotNW2LEy9BzCuFETB98GJB0Ph8OvWtMinR+5ahdUo=;
        b=HqO6gmxDncFQUTcI7v74TGyedkDL5oDnft1P/iEBJCTnuzp977mxolExIhoAqeHwir
         fBWeajMlQQORx7wF+3B6KDWuJgs8Q3WWR0D6fJ8gX3fchgFh7Yso3bV7RfWh7HQYzvto
         afRx0vTDHBruD3aJCqdPL7ieDZfwxLguna50LcZyAqpHO0YZN5Jfqk0Ptpaoj4USi/ZU
         qKtduLerR2rkWoMzfCod9IzUEgrD9zK1NTCjGphWhzeVyKXCcoogEVSynWUPxERX1e8t
         OphXzIbzXimVco0TyoWBrnP+sCzS0TXFcX5LJ8223mvnOSVRzITQdT7oRwXTQe4zZO47
         I10Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfCyYOdDrrz9V4CWCXIWFwrbFU/VSQHHQ70J4HoxFBFjwiAqJr1COAdixYxciQ+YQ4buLShLeYwq6W44vlyDrimrhUDUgLgw0fMoo0hA==
X-Gm-Message-State: AOJu0Yx4FBR7Sml4bdpEhp11VBdhqURh8u0NDKxhIifuRGRWbXBjJ60w
	tBeuxZbZnPr26nP46Egs/We2jqvzrw+qB39z1h5pqfzIT/MADEg59KWjR/Da6mf01dV3EOSOaFW
	yiZ9nJWBjsJgS07p0xOquPbJvKGg=
X-Google-Smtp-Source: AGHT+IEW5KRNnjhlh3n4H6eg67FvC3ukIHZtd6YAHbRB/B/OMf/3iylyQBT2DM7EgTnriDTcHo68S5PAod7EBeCn/68=
X-Received: by 2002:a05:6214:5f02:b0:6a0:a9dc:b117 with SMTP id
 6a1803df08f44-6a1680bf323mr50790996d6.0.1715398557792; Fri, 10 May 2024
 20:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
In-Reply-To: <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sat, 11 May 2024 11:35:21 +0800
Message-ID: <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 10:54=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, 10 May 2024 at 19:28, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > We've devised a solution to address both issues by deleting associated
> > dentry when removing a file.
>
> This patch is buggy. You are modifying d_flags outside the locked region.
>
> So at a minimum, the DCACHE_FILE_DELETED bit setting would need to
> just go into the
>
>         if (dentry->d_lockref.count =3D=3D 1) {
>
> side of the conditional, since the other side of that conditional
> already unhashes the dentry which makes this all moot anyway.
>
> That said, I think it's buggy in another way too: what if somebody
> else looks up the dentry before it actually gets unhashed? Then you
> have another ref to it, and the dentry might live long enough that it
> then gets re-used for a newly created file (which is why we have those
> negative dentries in the first place).
>
> So you'd have to clear the DCACHE_FILE_DELETED if the dentry is then
> made live by a file creation or rename or whatever.
>
> So that d_flags thing is actually pretty complicated.
>
> But since you made all this unconditional anyway, I think having a new
> dentry flag is unnecessary in the first place, and I suspect you are
> better off just unhashing the dentry unconditionally instead.
>
> IOW, I think the simpler patch is likely just something like this:

It's simpler. I used to contemplate handling it that way, but lack the
knowledge and courage to proceed, hence I opted for the d_flags
solution.
I'll conduct tests on the revised change. Appreciate your suggestion.

>
>   --- a/fs/dcache.c
>   +++ b/fs/dcache.c
>   @@ -2381,6 +2381,7 @@ void d_delete(struct dentry * dentry)
>
>         spin_lock(&inode->i_lock);
>         spin_lock(&dentry->d_lock);
>   +     __d_drop(dentry);
>         /*
>          * Are we the only user?
>          */
>   @@ -2388,7 +2389,6 @@ void d_delete(struct dentry * dentry)
>                 dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
>                 dentry_unlink_inode(dentry);
>         } else {
>   -             __d_drop(dentry);
>                 spin_unlock(&dentry->d_lock);
>                 spin_unlock(&inode->i_lock);
>         }
>
> although I think Al needs to ACK this, and I suspect that unhashing
> the dentry also makes that
>
>                 dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
>
> pointless (because the dentry won't be reused, so DCACHE_CANT_MOUNT
> just won't matter).
>
> I do worry that there are loads that actually love our current
> behavior, but maybe it's worth doing the simple unconditional "make
> d_delete() always unhash" and only worry about whether that causes
> performance problems for people who commonly create a new file in its
> place when we get such a report.
>
> IOW, the more complex thing might be to actually take other behavior
> into account (eg "do we have so many negative dentries that we really
> don't want to create new ones").

This poses a substantial challenge. Despite recurrent discussions
within the community about improving negative dentry over and over,
there hasn't been a consensus on how to address it.

>
> Al - can you please step in and tell us what else I've missed, and why
> my suggested version of the patch is also broken garbage?
>
>              Linus


--=20
Regards
Yafang

