Return-Path: <linux-fsdevel+bounces-54866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C82B043A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3591628D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947425BF00;
	Mon, 14 Jul 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0hu0jm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8125EF97;
	Mon, 14 Jul 2025 15:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506443; cv=none; b=bX2wOzePSc2f3HPoyRE5pXcMpyxaARjUieVmym/GfgLH4DTvQNNmTFLpUmRI+C/Tp7VtlnVpbrUCPGLRLJS1accsBnLt1LI1IMJkECt84plYZVjTbvYPyYaoStRAJ5U6B2Q62xnexcG4FcyBrtyvWj+ES+dDKlVuYjzy6OVY7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506443; c=relaxed/simple;
	bh=w8yIuroAMnEWNp0xpGtNuejB1xxN9tyTnR/TyVEUJwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiNaxxA+z349Ch+wG/b9rZaC5lIjgfw9R7xDejzR0hy1Qd0TvKVCnut6zfDtmIOZB83IAgYauVZy8ZObkSUFaPHyCiejPhetjU68Vb2xNAq3mlEjYMf6SNqKTPkSuS7tBRsDfPYDlOkKb5gIwkbzeZO78hrvWVUH8oUXkyUB4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0hu0jm+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3b37207easo909553266b.2;
        Mon, 14 Jul 2025 08:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506439; x=1753111239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8yIuroAMnEWNp0xpGtNuejB1xxN9tyTnR/TyVEUJwU=;
        b=P0hu0jm+oXF7iWI5FQkybgIEIQWUftHgI10h3OYL3L8/BpA7LZpFD1cm4Oc3ayDkQs
         NynXe4UmQzWBxs6sQG4YC8bzh0YQk67hE8OAxItxbS2/ZFQlDtMQnNlPbd/rfe5YKXhY
         /DtsdfqcL2yCvVbJjk8JWAogM/GYzn4GHHl+jyvgTsWHo+dwL0qwygeWDE98x/nNwyux
         p3Ph6yzhqGnAR/hmNw0IP/EXZH0sNu4K4CqUHf0aGr/RqpqCdxIpvKebmEA3EXBqIUpC
         IsV9Pu1RgKffMwxTTdR5kTAAGEfydgY/qX8sB3lhjRpdpvZxF/lNzXrE6hjxs/YGJ576
         h62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506439; x=1753111239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8yIuroAMnEWNp0xpGtNuejB1xxN9tyTnR/TyVEUJwU=;
        b=N+XFK91Cf/aN+OZnrGmH1t5/kXZBtHnl4OUnEyaMACO14Ify/V02D5YxUe3FzHXY09
         6UP1VHShj9TLYasVrOeRCjqlSJQsRSNgFFxx2tlkkCBYbHsIk1Cw8ulFvFyU9ZuDGiZV
         RPwVPkEYtt1IJu+LlfenfeVgEwdl8BJxTxgrzX2UN+fiK+R2k3tP3q9nijp1g9VYM0iO
         sAPQi90COHpqcZ6zst47CsNIjOEPMRTHwoTGwgx0rtcNLJYwXfr616QsKxNO/ABekBTz
         TcFcyNLdYqcKwCYQiEdZxK60aK24vu83jN3iOmWe+5ZivgwXD1GgRvfuf94GHK9wynQp
         yGZw==
X-Forwarded-Encrypted: i=1; AJvYcCVfSuRGNNSMpnwglyr5XFdv0ogOFoNNCKistcwFU4f7sVEARNfA+why8V8O6EjjxDEqMRhAgyyCC6/ia7pk@vger.kernel.org, AJvYcCXB7RXEe1mW3aMgP7kN793tci9yPcx8Xe9n+64ZnUBhIUnTh5veqfb0rWpsJlEv7bUlhqYAjOiEoxubuKvs@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8Tj7WZ+3PrwSV8mapu5ZSDi6RdunoF22R7yJtpeMP9nlHE4/
	tS99XaodBx0o8RzK2kEcO7Mo6fQ8QX0WvONCdKe3TAtZ8TrTweV1VN4hjgMP3x3RLqlcspeMoun
	+MyyW+g/3Kj0Sev6CH5PcM8D/RKdMpGE=
X-Gm-Gg: ASbGncsxG1ZOYA2dWBUHv7WGBY51fGuKtsf4MoEGbA/DfWzWBw84BfV3OK0q5wZw5pO
	pzaq8bydglpE3kmEYmeaiC/zhT7dR199Z7kA2kDaAmsOauH5mNQ0SGyScpOJRofk/RLxS8TsWyZ
	hBDIIpIjK0noH082UQgi0Iz1q+nxbrrg2GgRfCVaFHaJp+Yy8AWlfeJnK+spGfF/wcIv9lpydpT
	bCym7Q=
X-Google-Smtp-Source: AGHT+IH5gxxIyH8BxjlVhhwEHs+gK4c7sKZ518Sc5dvHxLwRknxS4HYfdScvhR3138xCN4KJhxNmzgYYknbEh4Klyks=
X-Received: by 2002:a17:907:3e95:b0:ae0:c6fa:ef45 with SMTP id
 a640c23a62f3a-ae6fbf96592mr1420110266b.41.1752506438919; Mon, 14 Jul 2025
 08:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
 <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com> <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 14 Jul 2025 17:20:27 +0200
X-Gm-Features: Ac12FXzImhTUDU8baou1w212yjhq4x1yw7swEeof5D-mpHYhROsVNfiACipSgiI
Message-ID: <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 10:29=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Thu, Jun 19, 2025 at 9:50=E2=80=AFPM Paul Lawrence <paullawrence@googl=
e.com> wrote:
> >
> > Hi Amir,
> >
> > Thank you for your detailed reply. My intent with this patch was to see=
 if there
> > was interest (a definite yes) and to see what path would best get us
> > to our common
> > goal.
> >
> > I'm thinking the best approach is to start with your ops_mask API. In
> > fact, that solves
> > the biggest single problem with my future patch set, which was that it
> > was going to be
> > huge and not realistically divisible, since you need everything for
> > directory passthrough
> > to work without the mask. Your way allows us to proceed in nice
> > logical steps, which is
> > much, much better. Thank you for that suggestion.
> >
> > So my follow-up question is: What can I do to help get the
> > foundational patches you
> > wrote upstreamed?
>
> Well you can always take them and re-shape them and post them
> to see what the maintainers think and address the feedback.
> But I can try to beat them to shape myself to at least post v1.
>
> >
> > In the meantime, a few thoughts on your comments. (Note that one of
> > the beauties of
> > your suggestion is that we don't need to agree on any of this to get
> > started - we can
> > discuss them in detail when we get to the specific ops that require the=
m.)
> >
> > 1) Yes, let's use backing_id. I won't mention that again.
> >
> > 2) The backing path per dentry comes from the way dentry_open works.
> > If we are going to
> > attach a file to a lookup, we have to put something into the
> > fuse_dentry or the fuse_inode.
>
> There is already fuse_backing *fb in fuse_inode.
> I don't understand why anything else is needed for implementing
> passthrough dir ops.
>
> > This makes more sense once you see points 3 & 4 below - without them,
> > we have an open
> > file, so why not just use it?
>
> We need to make the code simple enough.
> Not add things that are not needed.
>
> >
> > 3) A cute idea that we had that seems to work is to allow negative
> > dentries as backing
> > dentries. It appears to work well - for instance, a create first looks
> > up the (negative) dentry
> > then creates the file into that dentry. If the lookup puts a negative
> > dentry as the backing
> > file, we can now just use vfs_create to create the backing file.
> >
>
> That sounds like trouble.
> Overalyfs effectively implements passthrough dir ops.
> It doesn't keep negative backing dentries, so I doubt that this is needed=
.
>
> > This means that only FUSE_LOOKUP and (I think) FUSE_READDIRPLUS need to=
 have
> > the ability to accept backing_ids. I think is is both more elegant
> > conceptually, simpler to
> > code in the kernel *and* simpler to use in the daemon.
> >
> > 4) Having to open a file for it to be passed into a lookup is
> > problematic. Imagine
> > readdirplus on a large folder. We would need to open every single
> > backing file, and it
> > would stay open until the dentry was removed from the cache.
>
> We are talking about opening a O_PATH fd at lookup.
> The daemon does not need to keep this O_PATH fd open,
> although production daemons today (e.g. virtiofsd) anyway
> keep an open O_PATH fd per fuse inode in cache.
>
> Maybe it is a problem, but I am not convinced that it is, so
> maybe I need more details about what problems this is causing.
> If you are going to pin the backing inode/dentry to cache, then most
> of the memory resources are already taken, the extra file does not add
> much memory and it is currently not accounted for in any process.
>
> >
> > Both of these suggest that rather than just passing a backing_id to FUS=
E_LOOKUP
> > and FUSE_READDIRPLUS we should be able to pass a backing_id and a relat=
ive path.
> > This is where the idea of putting the backing path into the fuse
> > dentry comes from.
> >
>
> Sorry this is too much hand waving.
> I still don't understand what problem attaching a backing path to every d=
entry
> solves. You will have to walk me through exactly what the problem is with
> having the backing file/path attached to the inode.
>
> > I don't *think* this creates any security issues, so long as the
> > relative path is traversed
> > in the context of the daemon. (We might want to ban '..' and traverses
> > over file systems.)
>
> Sorry you lost me.
> I do not understand the idea of backing_id and a relative path.
> passthrough of READDIRPLUS is complicated.
> If you have an idea I need to see a very detailed plan.
>
> > Again, these are details we can debate when the patches are ready for
> > discussion.
> >
> > But again, let's start with your patch set. What are the next steps in
> > taking it upstream?
> > And which are the next ops you would like to see implemented? I would
> > be happy to take
> > a stab at one or two.
> >
>
> I can post patches for passthrough getxattr/listxattr, those are pretty
> simple,

Spoke up too soon.
passthrough of getxattr is only allegedly simple - that's before realizing
the complexity of passthrough of get_acl (see ovl_get_acl()).

> but I am not sure if they have merit on their own without
> passthrough of getattr, which is more complicated.
>
> Also I am not sure that implementing passthrough of some inode ops
> has merit without being able to setup passthrough at lookup time.
>
> I will see if I can find time to post a POC of basic passthrough of inode
> ops and setup of backing id at lookup time.
>

I did not get far enough to post a POC, but I did get far enough
to test inode ops passthrough.

This branch [1] has patches that implement passthrough for readdir
and getattr/statx.

I mostly wanted to demonstrate that you do not need to invent any new
infra to support passthrough of inode/dir ops - all the infra is already
there just waiting for a richer API to setup inode ops passthrough
at lookup time and implement the different passthrough methods.
I hope that this is clear?

I ran into an ABI compatibility issue with extending the fuse_entry_out
lookup result, which is also being used in struct fuse_direntplus,
so for the demo, I worked around this problem by setting up the
iops passthrough on first GETATTR.
The ABI compatibility (with existing binaries) is solvable but requires
more work.

In this demo passthrough_fs [2], when run with arguments
--readdirpassthrough --nocache
the first GETATTR on every dir/file sets up a permanent
backing inode for the fuse inode and all the following GETATTR
calls are passed through on this inode (until drop_caches).

Readdir is also passed through, but because passthrough
of LOOKUP is not implemented, it is not a clear win to use
readdir/getattr passthrough in comparison to readdirplus.
Hence, there is no justification to post these patches on their own.
But you can use them as a basis for your work.

If you have any questions, don't hesitate to ask me.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fuse_passthrough_iops/
[2] https://github.com/amir73il/libfuse/commits/fuse_passthrough_iops/

