Return-Path: <linux-fsdevel+bounces-19881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567058CAE05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A21F236DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25C763F1;
	Tue, 21 May 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+HMpBh/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084E275817
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716293774; cv=none; b=dD6wy52ekGSeeZ0+4OgVk/KLjBjYbg7BB5a5HkRU+cH1Ydc4ipeizfjBhO81vAU4zAzw8QgA2F5OW4U6hhdk6LLEIQFzPSDy0zfM/B1jdC25cVqbJb8u3gkDSZLLifosW6Zi+pgCudzYg1zTcdZG7s2nd0xTspMPgGIQWpSHoEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716293774; c=relaxed/simple;
	bh=AYUDW7gKCj2tScxPw+ctm51rzLfE/5y1iZjAvPSWOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNLbEzqMekenp1Doo5sgWWIy/zTLvCb/DbM1lG4RCfn7loY7kosHhIVWNbvDiRSKakUqVxcB57vdfFqwv0NADlqcNkxkC1i+QDlIshipyV33PE4FvfmE88n33PZhXOT/kOa3+vUhbb4cynFr8JZQIAb6z0HdTRuNrzuEzluJSAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+HMpBh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D705C32786;
	Tue, 21 May 2024 12:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716293773;
	bh=AYUDW7gKCj2tScxPw+ctm51rzLfE/5y1iZjAvPSWOVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+HMpBh/WMt9fPO2J+2ePM+30KDoPtjDyOoKmTDz2YBwdPMwIHTokKNVQmoKH8Tf7
	 I8CgQro5KeBkzEMhlr+EmJBvLL5RGDKp0MLxqnUPe8odxG79rIE3prfdjk0wlP+dX9
	 FRoLtWssphKhES9Z9M7B/5yYbDna3Zt10oWdDOTlH18TV303a7HJ9C5rl9fCvP/Xjj
	 jY4kV6DG4/iGzIsVa4wMoFPJYaj9YvnG/jkzuSaPJNHNBkLP8D2D+CvHR+on34Slzw
	 pGBAaYM+64sJBi4z3kOTrZFp8YG6LfSmg/Oeko3VtvMf0yPuKXU5axx+Bm9gFN+L9Q
	 zbPVVRyjbnS+A==
Date: Tue, 21 May 2024 14:16:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240521-haarscharf-liebt-ccf94a240c32@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
 <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org>
 <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>

Sorry for the delayed reply. I was attending LSFMM last week. Including
travel that basically amounted to a week of limited email time. Catching
up on things now.

On Fri, May 17, 2024 at 01:07:43PM -0700, Linus Torvalds wrote:
> On Fri, 17 May 2024 at 00:54, Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> >          inode->i_private = data;
> >          inode->i_flags |= S_PRIVATE;
> > +       inode->i_mode &= ~S_IFREG;
> 
> That is not a sensible operation. S_IFREG isn't a bit mask.
> 
> But it looks like 'anon_inode' traditionally had *no* type bytes at
> all. That's literally crazy.

Yes, it's pretty wild and I had long discussions about this before when
people told me it's impossible for st_mode to have no type. A lot of
low-level software isn't aware of this quirk and it's not something I
particularly enjoy.

> Doing a 'stat -L' on one in /proc/X/fd/Y will correctly say "weird
> file" about them.

Oh yes, it also broke assumptions in systemd and some other software
which had code related to stat() that assumed it could never see an
empty file type in st_mode.

> What a crock. That's horrible, and we apparently never noticed how
> broken anon_inodes were because nobody really cared. But then lsof
> seems to have done the *opposite* and just said (for unfathomable
> reasons) "this can't be a normal regular file".
> 
> But I can't actually find that code in lsof. I see
> 
>                  if (rest && rest[0] == '[' && rest[1] == 'p')
>                      fdinfo_mask |= FDINFO_PID;
> 
> which only checks that the name starts with '[p'. Hmm.
> 
> [ Time passes, I go looking ]
> 
> Oh Christ. It's process_proc_node:
> 
>         type = s->st_mode & S_IFMT;
>         switch (type) {
>         ...
>         case 0:
>             if (!strcmp(p, "anon_inode"))
>                 Lf->ntype = Ntype = N_ANON_INODE;
>             break;
> 
> so yes, process_proc_node() really seems to have intentionally noticed
> that our anon inodes forgot to put a file type in the st_mode, and
> together with the path from readlink matching 'anon_inode' is how lsof
> determines it's one of the special inodes.

strace does that too but strace updated it's code fairly early on to
accommodate pidfs. I had searched github to check that
anon_inode:[pidfd] wasn't something that userspace relied on and other
than strace it didn't yield any meaningful results and didn't surface
lsof unfortunately.

> 
> So yeah, we made a mistake, and then lsof decided that mistake was a feature.
> 
> But that does mean that we probably just have to live in the bed we made.

Yes, we likely do.

> 
> But that
> 
> > +       inode->i_mode &= ~S_IFREG;
> 
> is still very very wrong. It should use the proper bit mask: S_IFMT.
> 
> And we'd have to add a big comment about our historical stupidity that
> we are perpetuating.
> 
> Oh well.
> 
>                Linus

