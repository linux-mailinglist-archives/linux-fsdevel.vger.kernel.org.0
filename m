Return-Path: <linux-fsdevel+bounces-8778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45C83AE5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06379B26455
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D6E7CF22;
	Wed, 24 Jan 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuLxy4sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF167C094
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113263; cv=none; b=n+3PL5ARHYmEHaolm0KoCmywEXl81ESZO8xk/KPvjHGqzMgBGoIbrX8ThoJfiDlr8N7OftOemLgZRAj7Up6qB3w/oetR/GqP0ygPJwZwTjFhD7tpHR5x2cxuOqTEKn3XADmTGqguQqqB2qHgkZgAu8NAzXedL6f18GuT9sL4Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113263; c=relaxed/simple;
	bh=aSXiYlENoWhTK98ZIrBdW6y00Tq/AIbV1nmB92cQ4YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmg5vWWNj9du4wU/DhwLLhyaN5AoZ7GNCqMknC2Fx67VDcf6GWPp/U/HEOukybQleAehu+kCF81JCa8fqe8vs8tg/eYT0Ce7tA/zfoecYhmRd4f2u83T6lD4+Sbnfh3GrfWmWJXbwTndZZsWEpoJ0yWHzDqjQkZwixOCU63qOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuLxy4sv; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6860ff3951aso22988806d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706113261; x=1706718061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlMp6IAd63lTrPbKTk5TjHeCGVSZadhrOKCMPKVncLc=;
        b=MuLxy4svDy26r0KvCwJd6Ywa7EgNIO/p9ZG4m0g1nfv/X/TxxkxmO2+3VbcwrxzlZW
         lYhAHoLFYn08y8UfYLuDqjXWEd8EZT/CVOXLIf0l1sqAag62GQmoEEAHi3AsHzUHOpKc
         fEaf/dkaocLmO1Y0ym6I/e75pvryPiM0o3qIV5BfrWviGVRi/o2kL7VQ/r71o49ZRyMp
         pjrPSeyvf/e7/lR3S8/scKeHDIU+6kjUK5rbMofLWUNHhFG8QVcFYp7pLBmQ4M0aknxh
         Hykhu+9h5LSz0vc0ZmwOqEvJSny+raA4wz+eFos0lSUcU8sU83xEfNwyZKVjS+uo5o/a
         oDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706113261; x=1706718061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlMp6IAd63lTrPbKTk5TjHeCGVSZadhrOKCMPKVncLc=;
        b=c7fW3Wd/rOU92qDfOOyfzlvbdb4mWE3JO4NqlIs7Qa2wCJRyTbMPNKEsvb0BGEmpk5
         H34ygcDOfVRiVn2mqVT+eTSBnuZyQhuQRKXk4+KM8P6HEUzsoVX2+p/yoVX1eL126N/g
         Ze1jd7BFx7/i0tqkADGmVv87LDPc9ulhI6n3i7+uV5nQZMJ4F+5QBNEbwtTBsb290F1G
         awdAaYAD4LMz1vhGFOOCW+94PzbuQDvPdOwNZia6mZNBDvTKW7dr9reAHLGMoEy7SdAq
         cpri0kKwLCqTvSOc3z15nPiCdrK5oQdWcrEhME4UGH3PZw808GjKD7lD3ZLM+MKSTw/m
         7+0Q==
X-Gm-Message-State: AOJu0YwIyn2EGYQ/U2G4Jq632AqxZNCCpbNQDJSeyqt9mXzsjIMk0uHX
	JD3pn9/mHv8xlkcRFlIB4nldhei4U1qAKIvbDFkgcBIlfUSuYiVsf8UxIUgDwMz9h/fhvK7G27o
	z0XO6ZxNe1qNwvt2oX586LhW9QWM=
X-Google-Smtp-Source: AGHT+IGfn2c8F07PQ2lg/K3DgODWiNF06NQ+kbS7UK2E8U7KU1bkbKyqDvi1sQIz+fgqkWe065u6PxjjSxqDO1aKZuE=
X-Received: by 2002:a05:6214:f6b:b0:681:937f:6e68 with SMTP id
 iy11-20020a0562140f6b00b00681937f6e68mr3188179qvb.63.1706113261324; Wed, 24
 Jan 2024 08:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113247.758848-1-amir73il@gmail.com> <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com> <20240124160758.zodsoxuzfjoancly@quack3>
In-Reply-To: <20240124160758.zodsoxuzfjoancly@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jan 2024 18:20:49 +0200
Message-ID: <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:08=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 16-01-24 14:53:00, Amir Goldstein wrote:
> > On Tue, Jan 16, 2024 at 2:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 16-01-24 13:32:47, Amir Goldstein wrote:
> > > > If parent inode is not watching, check for the event in masks of
> > > > sb/mount/inode masks early to optimize out most of the code in
> > > > __fsnotify_parent() and avoid calling fsnotify().
> > > >
> > > > Jens has reported that this optimization improves BW and IOPS in an
> > > > io_uring benchmark by more than 10% and reduces perf reported CPU u=
sage.
> > > >
> > > > before:
> > > >
> > > > +    4.51%  io_uring  [kernel.vmlinux]  [k] fsnotify
> > > > +    3.67%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > > >
> > > > after:
> > > >
> > > > +    2.37%  io_uring  [kernel.vmlinux]  [k] __fsnotify_parent
> > > >
> > > > Reported-and-tested-by: Jens Axboe <axboe@kernel.dk>
> > > > Link: https://lore.kernel.org/linux-fsdevel/b45bd8ff-5654-4e67-90a6=
-aad5e6759e0b@kernel.dk/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Jan,
> > > >
> > > > Considering that this change looks like a clear win and it actually
> > > > the change that you suggested, I cleaned it up a bit and posting fo=
r
> > > > your consideration.
> > >
> > > Agreed, I like this. What did you generate this patch against? It doe=
s not
> > > apply on top of current Linus' tree (maybe it needs the change sittin=
g in
> > > VFS tree - which is fine I can wait until that gets merged)?
> > >
> >
> > Yes, it is on top of Christian's vfs-fixes branch.
>
> Merged your improvement now (and I've split off the cleanup into a separa=
te
> change and dropped the creation of fsnotify_path() which seemed a bit
> pointless with a single caller). All pushed out.
>

Thanks!
Amir.

