Return-Path: <linux-fsdevel+bounces-19487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8F38C5F13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32A01F2238F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 02:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9D7A945;
	Wed, 15 May 2024 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apqn8uGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C23EBE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715739567; cv=none; b=Y2oPluFzfLP8/Nar5Y2BB4hLk65KrcDUhMJjPKUWZcrTPaAM+nUf27DDZLKd0ccAaW1lMJ50EmknOMg0W4K4++4w/3/6Knvmdz0Xh8lEB9RKbCf80LZmC809O+WGXOzr2s7Z7qDjV9Uop6rWRFyfAOuaqWlTHdZ/IP4AJ/bnz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715739567; c=relaxed/simple;
	bh=j/Ile8Kw9+k9Rqdp8TvC7AWsNojhqlfUwwpnAVpbOT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vELOuqWcItc+gzvS9WUU9aqEoHcDhTAF1BkMxoLv/tyYObrlb/tdpj6+q+yOD7PRrtvRQR5dGVi6yMe5C7RDb8di1p9XmtuIkSNdqUIlUoB7wVDkZGqY+84dgiCF5qykuhaFBxGV3yJ4dE2JM+j/OgDBbwqpFeUIEphUrb3kfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apqn8uGl; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6a0b4622ea0so19882736d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 19:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715739564; x=1716344364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cdw+G1sLb8+waoXWZRsZymA5TZ67bMyGZgB9ft+mx7E=;
        b=Apqn8uGl+fYtfyi0aTJqKIvs0u+6xR+/zI+81fa+dg9PnEJaXNozpVE0S+NeDTnSeM
         Qapv+6oRZTTDXr3t3phV61+QcD9D2rUV9bo1Y/zVIL4yJ8H1CHBh6nfSwA9emK+qp8Z3
         6l1kd2Tp4j0gIaVjd1YP9Qa9OIPh2/cpj4AHBxkbhbzBN7cDb/afvSQFNd+GYwpCwNvl
         aisPt0BUjXCd7b7QgGNiHnWFPaGLdmygruFl4i7WGTHBcHpFg/i1TXrRYn3pnfpvsjWT
         w6tueP7/fxLLMMxqPQefkzdcfOFtzkyjHGVH62p1x3evyEXrYcaCiFD+pm/HwFAnF7ei
         PNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715739564; x=1716344364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cdw+G1sLb8+waoXWZRsZymA5TZ67bMyGZgB9ft+mx7E=;
        b=Qn596U3+bmpy0RwDtcHRFhCC+JRx1+HoPTL6flVy409tiuFnOlz2FCn05knKgvfsOq
         tTEsCBiU4iTZbl0fgSAYy43NPGxuX6NXKtUwSbb7xK83qLKiE4i57+3c7HW2wn5yF/Bn
         +I4XSNrmdGz8k8u4D2m+5nrTXVMD1Vwoy+nHfdDavGAYog5qyCA84bUK8FCuQ2ydJ7Wy
         RCOGNV5SYLjse8HB4GD1WbyOy0PE9SYNk2+JBkU7B2hsHE9exstkGMzpQfPaybfM2NiS
         IOodaCmf+jhP4Htw4lNMPKorlnIJ0Y0fjPiUIfukqjsv/+nKdH8AfRDlU5Bwex1u5rc9
         h/iA==
X-Forwarded-Encrypted: i=1; AJvYcCWF9KrFfekT5yr386L1sVKtMQ+g0jaoWsOC4EWH1WhUOs0aFFiqeA1mrUvcYkNxBtILMls1Yy8sq2hGTq+Q6FBjmDGMXhD8TF1wfBI50w==
X-Gm-Message-State: AOJu0Yyiijjrr525MHZriHZn3TbGzSUlntP7/1plar9COgC3WP95Xp3F
	HnrFMGuzEQtto23KmsRWHmQ2zyOpcwq/iGFYKotLCPZvX/TeLJ45MyKo33Pd3yjTI+CqS1R5FZZ
	nse+as9mU871LVAcVyUmqENRxfn8=
X-Google-Smtp-Source: AGHT+IH1eXP8R0eHrqDyR+E6QEdCqCc/1lCCJyixw3ZgHSx/IG6hRtAqnx7RAi/2IWxNqFH8nwjIyMVn4HoUDjL606g=
X-Received: by 2002:a05:6214:5642:b0:6a0:c9e5:a15c with SMTP id
 6a1803df08f44-6a16827951cmr121069236d6.63.1715739564370; Tue, 14 May 2024
 19:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
In-Reply-To: <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 15 May 2024 10:18:47 +0800
Message-ID: <CALOAHbCgMvZR-YCJEpEHDCZVwvgASAenoCOOTTX76B_z-jasfw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, Wangkai <wangkai86@huawei.com>, 
	Colin Walters <walters@verbum.org>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 11:35=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> On Sat, May 11, 2024 at 10:54=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, 10 May 2024 at 19:28, Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > We've devised a solution to address both issues by deleting associate=
d
> > > dentry when removing a file.
> >
> > This patch is buggy. You are modifying d_flags outside the locked regio=
n.
> >
> > So at a minimum, the DCACHE_FILE_DELETED bit setting would need to
> > just go into the
> >
> >         if (dentry->d_lockref.count =3D=3D 1) {
> >
> > side of the conditional, since the other side of that conditional
> > already unhashes the dentry which makes this all moot anyway.
> >
> > That said, I think it's buggy in another way too: what if somebody
> > else looks up the dentry before it actually gets unhashed? Then you
> > have another ref to it, and the dentry might live long enough that it
> > then gets re-used for a newly created file (which is why we have those
> > negative dentries in the first place).
> >
> > So you'd have to clear the DCACHE_FILE_DELETED if the dentry is then
> > made live by a file creation or rename or whatever.
> >
> > So that d_flags thing is actually pretty complicated.
> >
> > But since you made all this unconditional anyway, I think having a new
> > dentry flag is unnecessary in the first place, and I suspect you are
> > better off just unhashing the dentry unconditionally instead.
> >
> > IOW, I think the simpler patch is likely just something like this:
>
> It's simpler. I used to contemplate handling it that way, but lack the
> knowledge and courage to proceed, hence I opted for the d_flags
> solution.
> I'll conduct tests on the revised change. Appreciate your suggestion.
>

We have successfully applied a hotfix to a subset of our production
servers, totaling several thousand. The hotfix is as follows:

diff --git a/fs/dcache.c b/fs/dcache.c
index 52e6d5f..30eb733 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2557,14 +2557,14 @@ void d_delete(struct dentry * dentry)

        spin_lock(&inode->i_lock);
        spin_lock(&dentry->d_lock);
+       __d_drop(dentry);
+
        /*
         * Are we the only user?
         */
        if (dentry->d_lockref.count =3D=3D 1) {
-               dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
                dentry_unlink_inode(dentry);
        } else {
-               __d_drop(dentry);
                spin_unlock(&dentry->d_lock);
                spin_unlock(&inode->i_lock);
        }

So far, it has been functioning well without any regressions. We are
planning to roll this update out to our entire fleet, which consists
of hundreds of thousands of servers.

I believe this change is still necessary. Would you prefer to commit
it directly, or should I send an official patch?

If the "unlink-create" issue is a concern, perhaps we can address it
by adding a /sys/kernel/debug/vfs/delete_file_legacy entry?

> >
> >   --- a/fs/dcache.c
> >   +++ b/fs/dcache.c
> >   @@ -2381,6 +2381,7 @@ void d_delete(struct dentry * dentry)
> >
> >         spin_lock(&inode->i_lock);
> >         spin_lock(&dentry->d_lock);
> >   +     __d_drop(dentry);
> >         /*
> >          * Are we the only user?
> >          */
> >   @@ -2388,7 +2389,6 @@ void d_delete(struct dentry * dentry)
> >                 dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
> >                 dentry_unlink_inode(dentry);
> >         } else {
> >   -             __d_drop(dentry);
> >                 spin_unlock(&dentry->d_lock);
> >                 spin_unlock(&inode->i_lock);
> >         }
> >
> > although I think Al needs to ACK this, and I suspect that unhashing
> > the dentry also makes that
> >
> >                 dentry->d_flags &=3D ~DCACHE_CANT_MOUNT;
> >
> > pointless (because the dentry won't be reused, so DCACHE_CANT_MOUNT
> > just won't matter).
> >
> > I do worry that there are loads that actually love our current
> > behavior, but maybe it's worth doing the simple unconditional "make
> > d_delete() always unhash" and only worry about whether that causes
> > performance problems for people who commonly create a new file in its
> > place when we get such a report.
> >
> > IOW, the more complex thing might be to actually take other behavior
> > into account (eg "do we have so many negative dentries that we really
> > don't want to create new ones").
>
> This poses a substantial challenge. Despite recurrent discussions
> within the community about improving negative dentry over and over,
> there hasn't been a consensus on how to address it.
>
> >
> > Al - can you please step in and tell us what else I've missed, and why
> > my suggested version of the patch is also broken garbage?
> >
> >              Linus
>
>
> --
> Regards
> Yafang



--
Regards
Yafang

