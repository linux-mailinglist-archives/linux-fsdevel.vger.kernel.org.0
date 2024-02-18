Return-Path: <linux-fsdevel+bounces-11949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA5A8596AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 12:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE5E1F21623
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA263123;
	Sun, 18 Feb 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UL0yoRdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAE37169
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256026; cv=none; b=bPmGpLS0e3KOVDnnLRnTcr0xQMWUwGCJs3t0z+u+hrQ9xWTC16VrSf7Er3Ue106kI7eQHVc3NlpMvXKWG2yKN683um427GTcesnO6U4JR+JbSFzlJCNe6qSbEXOEVpCVrWCWA3q5wL/wVupcqXk3idawG3KvyT29Y81XExndMHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256026; c=relaxed/simple;
	bh=VYkeWAKrKIjY45/x96C9Fhcx7xtc5xfa/W2lkOj8eIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8IwUpzV/GUljXeXSFiPPgwAiMWc5fNimo1CE+d1dIgPF1gmwRczW5IqRAzMY/SMxJcCjayvFiTt8e9o+6aUyv92F5boD4LvbZ1d3c/NZvqNEPOyF6R1Jg1AD3MzjLhorWD9OCk3fuHfBTp7j6SAHaEbFUiNyD3omFcsT1yBfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UL0yoRdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C9C433F1;
	Sun, 18 Feb 2024 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708256025;
	bh=VYkeWAKrKIjY45/x96C9Fhcx7xtc5xfa/W2lkOj8eIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UL0yoRdZw1PM2rHp7onGVqCX16iTZJ7X+TREubL5e2JwBV2k8RRrsNGghvnQOT6gp
	 NFmkEnYDS3KN2T0uPOM6PL4Y7pyKePwq6aDzJ8iJS3ARjS6RPmHt2P48yDhNOc0/wS
	 v9FMoQk/3bEenUFoLHoMJKMiYpHrobHpT1BzlAyC7xZA7Ohp0dadxkiGZKQLxVvCbu
	 k/A1Hg9lrHmpWs1WKF2yNEtHHJFj7kLC6VU7hRyzS9aDBNpz2cIfihTMIi6E6hlSbj
	 LBktbpgGZo9i45FWhw1Gs6oq9QgCZYKcJnKDcwDuzktZD1cSDz7+SsQ6DhLBnSQvH0
	 /aZQ2N6JzxAjg==
Date: Sun, 18 Feb 2024 12:33:41 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240218-anomalie-hissen-295c5228d16b@brauner>
References: <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
 <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240218-gremien-kitzeln-761dc0cdc80c@brauner>

On Sun, Feb 18, 2024 at 12:15:02PM +0100, Christian Brauner wrote:
> On Sat, Feb 17, 2024 at 09:30:19AM -0800, Linus Torvalds wrote:
> > On Sat, 17 Feb 2024 at 06:00, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > But I have a really stupid (I know nothing about vfs) question, why do we
> > > need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
> > > can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?
> > >
> > > IIUC, if this pid is freed and then another "struct pid" has the same address
> > > we can rely on __wait_on_freeing_inode() ?
> > 
> > Heh. Maybe it would work, but we really don't want to expose core
> > kernel pointers to user space as the inode number.
> 
> And then also the property that the inode number is unique for the
> system lifetime is extremely useful for userspace and I would like to
> retain that property.
> 
> > 
> > So then we'd have to add extra hackery to that (ie we'd have to
> > intercept stat calls, and we'd have to have something else for
> > ->d_dname() etc..).
> > 
> > Those are all things that the VFS does support, but ...
> > 
> > So I do prefer Christian's new approach, although some of it ends up
> > being a bit unclear.
> > 
> > Christian, can you explain why this:
> > 
> >         spin_lock(&alias->d_lock);
> >         dget_dlock(alias);
> >         spin_unlock(&alias->d_lock);
> > 
> > instead of just 'dget()'?
> 
> No reason other than I forgot to switch to dget().
> 
> > 
> > Also, while I found the old __ns_get_path() to be fairly disgusting, I
> > actually think it's simpler and clearer than playing around with the
> > dentry alias list. So my expectation on code sharing was that you'd
> 
> It's overall probably also cheaper, I think.
> 
> > basically lift the old __ns_get_path(), make *that* the helper, and
> > just pass it an argument that is the pointer to the filesystem
> > "stashed" entry...
> > 
> > And yes, using "atomic_long_t" for stashed is a crime against
> > humanity. It's also entirely pointless. There are no actual atomic
> > operations that the code wants except for reading and writing (aka
> > READ_ONCE() and WRITE_ONCE()) and cmpxchg (aka just cmpxchg()). Using
> > "atomic_long_t" buys the code nothing, and only makes things more
> > complicated and requires crazy casts.
> 
> Yup, I had that as a draft and that introduced struct ino_stash which
> contained a dentry pointer and the inode number using cmpxchg(). But I
> decided against this because ns_common.h would require to have access to
> ino_stash definition so we wouldn't just able to hide it in internal.h
> where it should belong.

Right, I remember. The annoying thing will be how to cleanly handle this
without having to pass too many parameters because we need d_fsdata, the
vfsmount, and the inode->i_fop. So let me see if I can get this to
something that doesn't look too ugly.

