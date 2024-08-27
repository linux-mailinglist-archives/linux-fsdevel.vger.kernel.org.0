Return-Path: <linux-fsdevel+bounces-27419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB0696158B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B321F24141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F71CC8A3;
	Tue, 27 Aug 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCkoa9HF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E854767
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780089; cv=none; b=ifB9r+J9KcZXXxo4vEuunIccWRm6krwSqK3URxjQT+hg0Qq8zIQgQcQsCxckjZNPoXHtOlki0LXicTc9JT03Ey5QCykrNHSD/11XwB023dICD+Gg662mA0hm3ZvuDsvk1LaGZ0IgO+nAvjtjeGCLSfUvDfkjcsvTPi52m8mZf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780089; c=relaxed/simple;
	bh=sKCXupEb2kheZgsZWeSc5tmf8YuTVfzvmes8iYPFMcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGPDVSHIca4ofVOnhR4MWbxsFgVaqarVa5m3elk1FGZF7I7R3Tuo1PrShV0ZksGc4c7V+nbzAkf7EWtFpHpYZo+h9xLgpAwIUqqbETZJUHZHC8RPTbYNsZDpRbGWNbcPL0F7TD2iEpwnpDz5h8GclbzZVSE6xitaWNd8b8Rr9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCkoa9HF; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1df0a9281so355275785a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 10:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724780087; x=1725384887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/64mMcUViNA1K+v2j+vqDSuPO6YcZUAV9leSECKmRpw=;
        b=VCkoa9HFRW/nCJ8YivTHZnqhcn6olwsJ1CVu4z+QEksaIzS7m5dnKkyHwOIEmzPbnH
         w6c+QrQwgzTqTS9YQGBI6n9bOQ3G6t+kfOZlt7G6R5wryOaNwLy7ECi5d8hc1bjmXGyG
         weSmKkoGHqKO1R1xzP3gOcv2oDUschqx6y5Ift2FPWMM26cJTk7IpbYhLHhW5V4vO9Nw
         B8EVpmf9/acmMu/eTcJJXHSwrEHIASMU7GWc68P+ycPoh6yX5OUvc973CoT8VlDOE8Ba
         7gMpPpJCc0jcNuXSoUqOlaZkTg+lBnigRUK6GUFvnKWe+SQcrriZ84yeE0oZ1LB/Ezgc
         eDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724780087; x=1725384887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/64mMcUViNA1K+v2j+vqDSuPO6YcZUAV9leSECKmRpw=;
        b=XgeRl+bKO2qNhhdNu/mxt54ynBxRIG+5Ez0gg5I3WjmnKBAQzSPtTjQAKWOOUx6VFo
         LbvJKaUCUA3duzMHbOpF3HzKZMdJLPSQUr4QJLfeqd5nK2ySxIYj1AILh+wocUh77V2/
         XcUxZl53ZlnImXrvMDSF56EZGyifYMyQgB78zKRaujUssEKzJdefsQT/nbrXom+KWSYl
         bCR4xyQ4UDX1uer3VP14C8/4BQQKixeRrcqM2F216KCon5AIpZZloojbLGge9y5tuDC/
         qiz6YCj4PFphiAy9ETBBqs7ekEMupUtEzpEIf1vNRvxjSh0C+guFr1utaox2xntd3vW5
         qBdg==
X-Gm-Message-State: AOJu0YzCV5D+lMdN68OlmPUvrV2ULGcr+WjuSW9OkNI0+FE7rPU8D/R7
	j8YavlxG/y0r0n7+ClN3ZDejK6QMQYrNJjQwITZuDGYIEeM3GsssSUMAhp4oc5xcFTwg6LnqHsH
	ssEYe5hlV753AC3YCgL0VNiVYSa6WG8Foe78=
X-Google-Smtp-Source: AGHT+IHG1LNggkzrbyLp4epLYbHN3o1Gn0fTgSfqPZJhM9g1cMse1FL+8pUF3PmaE8qXbPFtZhvVMo2ZMl3mWt2dob4=
X-Received: by 2002:a05:620a:4448:b0:7a1:c40d:7575 with SMTP id
 af79cd13be357-7a6896ed92bmr1664495785a.17.1724780086959; Tue, 27 Aug 2024
 10:34:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
 <CAOQ4uxi=9WpKFb24=Hha_mwj9=bsj9qxiv0f0Z-FMfuBRCvdJA@mail.gmail.com> <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
In-Reply-To: <CAOw_e7bMbwXzv00YeGw2NjGDfUpasaQix40iXC2EcLHk=n2wTA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Aug 2024 19:34:36 +0200
Message-ID: <CAOQ4uximem-HV4fCYPFMm9wANntKY4XjBGo8=y2zAMciq-5YOQ@mail.gmail.com>
Subject: Re: FUSE passthrough: fd lifetime?
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:32=E2=80=AFPM Han-Wen Nienhuys <hanwenn@gmail.com=
> wrote:
>
> On Tue, Aug 27, 2024 at 3:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, Aug 27, 2024 at 11:42=E2=80=AFAM Han-Wen Nienhuys <hanwenn@gmai=
l.com> wrote:
> > >
> > > Hi folks,
> >
> > Hi Han-Wen,
> >
> > For future reference, please CC FUSE and libfuse maintainers
> > and FUSE passthrough developer (me) if you want to make sure
> > that you got our attention.
>
> Sure. Who is the libfuse maintainer these days?

Oops, forgot to CC Bernd.

>
> > > I tried simply closing the backing FD right after obtaining the
> > > backing ID, and it seems to work. Is this permitted?
> >
> > Yes.
>
> awesome!
>
> > BTW, since you are one of the first (publicly announced) users of
> > FUSE passthrough, it would be helpful to get feedback about API,
> > which could change down the road and about your wish list.
>
> For full transparency, I just work on the go-fuse library for fun, I
> don't have direct applications for passthrough at the moment. That
> said, I have been trying to make it go faster, and obviously bypassing
> user-space for reads/writes helps in a big way.
>
> > Specifically, I have WIP patches for
> > - readdir() passthrough
> > - stat()/getxattr()/listxattr() passthrough
> >
> > and users feedback could help me decide how to prioritize between
> > those (and other) FUSE passthrough efforts.
>
> It's been useful in the past to defer all file operations to an
> underlying file, and only change where in the tree a file is surfaced.
> In that sense, it would be nice to just say "pass all operations on
> this (open) file to this other file". Go-FUSE has a LoopbackFile and
> LoopbackNode that lets you do that very easily, but it would be extra
> attractive if that would also avoid kernel roundtrips.
>
> For flexibility, it might be useful to pass a bitmask or a list of
> FUSE opcodes back to the kernel, so you can select which operations
> should be passed through.

There is an ops_mask in my WIP patches:
https://github.com/amir73il/linux/commits/fuse-backing-inode-wip/

>
> The most annoying part of the current functionality is the
> CAP_SYS_ADMIN restriction; I am not sure everyone is prepared to run
> their file systems as root. Could the ioctl check that the file was
> opened as O_RDWR, and stop checking for root?
>

Donno. It's a challenge. Will need to think about it.

> If you are proposing to do xattr functions, that means that you also
> will do passthrough for files that are not opened?
>
> Right now, the backing ID is in the OpenOut structure; how would you
> pass back the backing ID so it could be used for stat() ? IMO the most
> natural solution would be to extend the lookup response so you can
> directly insert a backing ID there.

Yes, that's the idea.
The WIP demonstrates a different lifetime for the backing inode
that could persist from lookup to evict, but the lookup response was
not extended yet.

>
> I made a mistake in how I treat opendir/readdir in the high-level
> go-fuse API. Until that is fixed, I cannot use passthrough for
> readdir. That said, part of making FUSE filesystems go fast is to
> amortize the cost of lookup using readdirplus. That wouldn't work with
> readdir passthrough, so it may not be that useful.
>

This is indeed a challenge.
I'll need to see how to deal with it.

> So in summary, my wishlist for passthrough (decreasing importance):
>
> 1.  get rid of cap_sys_admin requirement
> 2. allow passthrough for all file operations (fallocate, fsync, flush,
> setattr, etc.)
>

Thanks for the feedback!
Amir.

