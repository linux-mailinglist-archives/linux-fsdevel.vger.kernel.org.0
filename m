Return-Path: <linux-fsdevel+bounces-55970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BFB111E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5184D5A1D5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8832222A1;
	Thu, 24 Jul 2025 19:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwGR8K4l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56069443;
	Thu, 24 Jul 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386704; cv=none; b=bD4OzcYFzDBaEE674rfkUTwuj5/6dUL3kGJ8Zul/UIUQle8fMFxaDjzvfr35RkPKWOpBw1TotfPyDi++Gof9OjVYAHT9Y9dWoQfOVLq4WqZWcZ7YLXmMvRBNBJU9viv4AiCwLyZnk5Zn4ciAiLcO3wtNafgReFUZAIEg1fp1C5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386704; c=relaxed/simple;
	bh=Aw4tKkf7vnFAyiPYG1UxauwwJZix8GEIGwPUv2Otdl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEYLR/PjVjZ7S0hfCt14OpxA4gWXS1rlRFAKNGPuup4CuMRlKrZZz6YlrhuVh4aG770yWHlpq6l1qD9gGvKFuWTjWCE8qkCnktdo0Skj0Nc9ssdMLm/MmX0cYVFuvmXU5lrlmn0iNyjSZJ4RylkgQoob3RHL45sJp9lBzFeN9Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwGR8K4l; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso221517866b.1;
        Thu, 24 Jul 2025 12:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753386701; x=1753991501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw4tKkf7vnFAyiPYG1UxauwwJZix8GEIGwPUv2Otdl0=;
        b=EwGR8K4l5xbS9Pa6aBpKHcvLwlMF0RK8w8uFICMRSZ02Ao/gddN9c3W8P+ZhAg8xT9
         nfnLg1M161f+ri2ucRD0TQpbMEC4Vbpy8SgD1A1blUvXANMmO+jwueTO6YxXbk1ElZzE
         VcPfycKNyXaLDXwPkng+M/nKvvnTd5UI2JGlXz3wIbsoQ2VPvvToXHnGHsIOBb9dPeA7
         vj7d2bvrt6IughVhx5mGamogDFsSUBCoR602wWIRBQ3Q5uSDUTrxJTyfoefwv2Zgi488
         VHCOJht2MiYzGq6kUJc1UR2p/iRkgnT1eEd+HDoMp+MW0oLU4rXtGqADbszhgilWzY0e
         n3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753386701; x=1753991501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw4tKkf7vnFAyiPYG1UxauwwJZix8GEIGwPUv2Otdl0=;
        b=NjTdlaAb0o1bP9c3suWwH5tBE20BldK1zNXyUU3jpIyYL0hy4Rg/5qLrMwIk0OkPEU
         bucx5OeU+1ovPEp2VuJihu1rSItlqx3A80FW5x/Y+asHbiuUYiGkCumUDzr0nLbz27/u
         PJgs7Bl9f+h2/gex24/jrxGiY3QNNCvndkeOPk5LiWTr13/z7VIIXTvoGmpNPToDd0vl
         /23xHixyRPJ9zY1KaRyhuTZkaAJpqIpQAgMm4+zWsO0xi+j+r057KkB4SZKDZg8mLVCX
         ecSAEfYoMgf+WNTsoTLiWRMUmjEQExCCvt3GvSSQatNn9IDs1eGzJtr9qxjyt5aKVzHP
         cUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKtrcAHBMtrMy2n3nwwTkwiEWPfw77TtJF+Hs3/2Padu+vaDXrHOwwYNX70EW4LsZpM7KfiNnYkSJA/VyV@vger.kernel.org, AJvYcCW1+IPIFk9PitDZzPHMBpul/pBJVvqN7TFl4R+G81VNABbuCT9FEQNUO8fyhbWwziwAVwHvqvead+H+n+Ds@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxnMviiqsNLKLL37NwFGq6tKs2VggFt0P6/NnF3bynS2JC3Z3
	KcJ6tKQL5YB/IynV1CcDA/rlL2un11/dDyMC/4CdnK2dluwJ4bCWdmLhMyDOPNFuVTDMqJxkTC6
	JxrrxiGJRpFHT6/Yyy1lajPWnarbsfWM=
X-Gm-Gg: ASbGncs0g38LeKatbPgn55oiFLVoOtgnTYrQB6r2j0zt0SagYf1jAVof/CkNISudRRI
	nxznahMwopo1BP0/xW5QYfGzCURVduYt/vQgDTIqFrmT8hhN8HlVB/rz8mSkl4bNEF+8BKvOQBV
	pVzsVunzl3M73ZxfmJ7mTTKaNbwr5AG69fquknO5JDTp2+2YiT9h9VJe1Ro3fumklxe/QmCwes/
	ok+kaQ=
X-Google-Smtp-Source: AGHT+IEpfMgrZQTYrobwW6AEICMyWuvU/Pdswxst/8Sh09FzJvr8Lysgrd7kM9WjvU+6lB8ItwbEaV+/GIn+aEnHeQY=
X-Received: by 2002:a17:907:6d11:b0:af2:4238:167 with SMTP id
 a640c23a62f3a-af2f8e514b0mr858092066b.48.1753386700624; Thu, 24 Jul 2025
 12:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
 <CAOQ4uxgaxkJexvUFOFDEAbm+vW4A1qkmvqZJEYkZGR5Mp=gtrg@mail.gmail.com>
 <CAL=UVf707OokQUuhzbvrweFziLVmiDD3TFs_WG2hRY0-snw7Wg@mail.gmail.com>
 <CAOQ4uxhUK6EeCUZ36+LhT7hVt7pH9BKYLpxF4bhU4MM0kT=mKg@mail.gmail.com>
 <CAOQ4uxjX1Cs-UYEKZfNtCz_31JiH74KaC_EdU07oxX-nCcirFQ@mail.gmail.com>
 <CAL=UVf5W9eJF4FL6aRG4e1VoFWg8jj4X4af=j-OGdU=QxmPuwA@mail.gmail.com>
 <CAOQ4uxgqS0cK6ovwjMjSFndiFBUP1Z9ZXdAoCJayeo4W00nGLg@mail.gmail.com> <CAL=UVf7zTcmd32jgQStXFWKGpUGXLPqX19uPx_Xzqm_k7QGj0Q@mail.gmail.com>
In-Reply-To: <CAL=UVf7zTcmd32jgQStXFWKGpUGXLPqX19uPx_Xzqm_k7QGj0Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 24 Jul 2025 21:51:29 +0200
X-Gm-Features: Ac12FXxiJANvpe4AMDenrADvZ3QSdEpsM7KQsI3L2jOvx5X-Xgv0jEoHkBgsAk4
Message-ID: <CAOQ4uxhmA862ZPAXd=g3vKJAvwAdobAnB--7MqHV87Vmh0USFw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Paul Lawrence <paullawrence@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 8:30=E2=80=AFPM Paul Lawrence <paullawrence@google.=
com> wrote:
>
> > FUSE_CREATE already returns two out args.
> > How were you planning to extend it?
>
> Excellent point. However, FUSE_CREATE (and FUSE_TMPFILE) already has
> fuse_open_out as the second argument, so the backing_id can be passed
> in there. Does that sound acceptable? I'll admit that at first this
> seemed clunky to me, but the more I think about it, the more natural
> it seems - create is really an open, so it follows that paradigm, and
> the new paradigm is used only for FUSE_LOOKUP.
>

Yes, you are right. FUSE_CREATE already has backing_id anyway.

> FUSE_READDIRPLUS is harder, it seems to me. We would need to break ABI
> compatibility - I can't see any sane alternative. A clean way would be
> to have a FUSE_READDIR_PASSTHROUGH opcode. This implies that there's a
> flag FUSE_PASSTHROUGH_MASK covering all of this new functionality
> which would also enable this new opcode. (It could, alternatively,
> change the behavior of FUSE_READDIRPLUS but I suspect no one is going
> to like that idea.)

Let's leave readdirplus for the very end.
It's not very important for the first version IMO.

>
> Does this seem reasonable?

Yes. sounds good to me.

Thanks,
Amir.

>
> Thanks,
> Paul
>
>
>
>
> On Wed, Jul 23, 2025 at 9:53=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, Jul 22, 2025 at 11:13=E2=80=AFPM Paul Lawrence <paullawrence@go=
ogle.com> wrote:
> > >
> > > I spent a little time with these patches. I wrote my own to set the
> > > backing file at lookup time by adding an optional second out struct.
> >
> > FUSE_CREATE already returns two out args.
> > How were you planning to extend it?
> >
> > > Is there a reason we should not do this? It seems the most natural
> > > solution.
> > >
> > > After a while, I began to wonder if what I was planning was actually
> > > the same as your vision. I decided to jot down my thoughts to see if
> > > you agree with them. Also I was confused as to why you were adding th=
e
> > > ability to set backing files to GETATTR.
> >
> > It is a demo. It demonstrates that passthrough can be set up sooner tha=
n
> > open time. It was not my intention to keep it this way.
> >
> > > So here are my notes.
> > >
> > > Design of fuse passthrough for all operations
> > >
> > > Goal:
> > >
> > > When a fuse filesystem implements a stacking filesystem over an
> > > underlying file system, and a significant fraction of the calls will
> > > simply be passed to the underlying file system, provide a mechanism t=
o
> > > pass those calls through without going to user space. This is
> > > primarily to enhance performance, though it might simplify the daemon
> > > somewhat too.
> > >
> > > Current state:
> > >
> > > Currently passthrough allows a backing file to be set at file open
> > > time. If a backing file is set, all read/write operations will be
> > > forwarded to the backing file.
> > >
> > > Design:
> > >
> > > Add ability to set backing file on the found inode in response to a
> > > positive lookup. This file might be opened with O_PATH for performanc=
e
> > > reasons. The lookup api would be modified to have an optional second
> > > out struct that contains the backing file id. Note that we will use
> > > the backing file ioctl to create this id to remove any security
> > > concerns.
> > >
> > > The ioctl will also take a 64-bit integer to define which operations
> > > will be passed through, the operations mask. This will have one bit
> > > for each of the existing FUSE_OPERATIONS, at least the ones that act
> > > on inodes/files.
> > >
> > > Then when fuse fs is considering calling out to the daemon with an
> > > opcode, fuse fs will check if the inode has a backing file and mask.
> > > If it does, and the specific opcode bit is set, fuse fs will instead
> > > call out to a kernel function in backing.c that can perform that
> > > operation on the backing file correctly.
> > >
> > > Details:
> > >
> > > Question: Will it be possible to change the mask/backing file after
> > > the initial setting? My feeling is that it might well be useful to be
> > > able to set the mask, the file not so much. Situations would be (for
> > > example) a caching file system that turns off read forwarding once th=
e
> > > whole file is downloaded.
> > >
> >
> > Generally, enabling passthrough from a point in time until the end of
> > inode lifetime is easier than turning it off, but also there are many
> > dependencies between passthrough ops and inode state so it will
> > require a lot of care to enable *some* operations mid inode lifetime.
> >
> > > FUSE_OPEN will, if the backing file has been set, reopen it as a file
> > > (not a path) if needed. This is whether or not FUSE_OPEN is passed
> > > through.
> > >
> > > If FUSE_OPEN is passed through, user space will not get the chance to
> > > assign a file handle ID to the opened file. It will still be possible
> > > to pass FUSE_READ etc to the daemon - the daemon will still have the
> > > node id and be able to read data based on that.
> > >
> >
> > Not sure I understand what you mean, but we do support per file opt-out=
 of
> > passthrough with FOPEN_DIRECT_IO even when the inode is already
> > set up for passthrough.
> >
> > > FUSE_LOOKUP can return a 0 node id, but only if *all* operations on
> > > that node as marked as passthrough.
> >
> > Not sure why this is but I will be open to understanding.
> > Will need an elaborate design of the inode lifetime in this case.
> >
> > >
> > > Suggestion: During FUSE_LOOKUP, if FUSE_GETATTR is set in the mask,
> > > ignore the passed in attributes and read them from the backing file.
> >
> > My patches already implement that when GETATTR is in the mask.
> >
> > >
> > > Random, non-exhastive list of considerations:
> > >
> > > FUSE_FORGET can only be marked passthrough if the node id is 0.
> > >
> > > FUSE_CREATE returns a new node id and file handle. It would need the
> > > ability to set backing files.
> > >
> > > If FUSE_LOOKUP is marked for passthrough, then looked up inodes will
> > > be prepopulated with a backing O_PATH file and a mask will all bits
> > > set.
> > >
> > > FUSE_RENAME takes two nodes and names, and moves one to the other. If
> > > one is passthrough and one is not, there is no obvious way of
> > > performing a rename. Either fall back to copy/delete or return EXDEV
> >
> > Good question.
> >
> > My patches were meant to provide you the basic infrastructure to enter
> > this playground and show that you do not need backing dentry/inode
> > beyond what is already available.
> >
> > I hope this is enough for you to start experimenting and sending RFC pa=
tches
> > with design doc!
> >
> > Thanks,
> > Amir.

