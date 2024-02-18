Return-Path: <linux-fsdevel+bounces-11948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1115485969B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9699B281E10
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFC85101A;
	Sun, 18 Feb 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZkx2w+s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781850A72
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708254906; cv=none; b=HmXVA9mB6u4abP2qRcI/NY2aqj7hEZf5IBou/gjr3sxc6Snxzih6V1veo7mMPtfgsFiSRh+v4BTZGfG6ZNU6v07lqv2FmMrz6c7APrpIA3+seuAY0GDRDRsrgoEgEPGozSn663Qzco6PscVYVrbkhI31D5c+3/2Cn3U9+ycmOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708254906; c=relaxed/simple;
	bh=7UlvmKreWNEGr7Z8KBrMXc69yuMOsgWMyV056s9poRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2jn2B/bzH1UffxyzU6sUu0o9492DEmdD/URvcBb63+aAYk/W+PkZdmNxkQyBV5Y32EZg+xGUrD/jMwWrabvGwlS83Syz5eX0uvTCemsIpeIdoL3qPj1wVsVBs2/ndFE2Oy+n1ZddbtRskRehkYUDbJMV3/hnIGbNrEcTSVk6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZkx2w+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA21EC433C7;
	Sun, 18 Feb 2024 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708254906;
	bh=7UlvmKreWNEGr7Z8KBrMXc69yuMOsgWMyV056s9poRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZkx2w+sNHaovZNdW1vy455VkYK71VqHuy8MIGgjT0qOBhBDQoLDK+fRbFwwpf5Kf
	 FvsoNXQJNqhyVXUcWNeF/1G5/p6Rcgf8k9D4uKnckpntfKs6Z8yO/lq1OuJh+PXva0
	 tVVUGnbaS4Nm0qaPn7JXh7PBf4LvOa7Xvb3HS/uYpxMhZ36kceLSRdga9xMbSTJYRp
	 YQgMLmB1uJdnDHAW0k57o2OeTZ9HxX4fpVaut2G+yStmSIlYbUN+BE83fKZqa91VOC
	 rXppSWDJ5cIreHE7uR/0E4HW+BCmbHaZ8H5iRwhNtnaAQj/4FestxXWCHIKlNoM+Pr
	 18GG8pkkguUpg==
Date: Sun, 18 Feb 2024 12:15:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
 <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>

On Sat, Feb 17, 2024 at 09:30:19AM -0800, Linus Torvalds wrote:
> On Sat, 17 Feb 2024 at 06:00, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > But I have a really stupid (I know nothing about vfs) question, why do we
> > need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
> > can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?
> >
> > IIUC, if this pid is freed and then another "struct pid" has the same address
> > we can rely on __wait_on_freeing_inode() ?
> 
> Heh. Maybe it would work, but we really don't want to expose core
> kernel pointers to user space as the inode number.

And then also the property that the inode number is unique for the
system lifetime is extremely useful for userspace and I would like to
retain that property.

> 
> So then we'd have to add extra hackery to that (ie we'd have to
> intercept stat calls, and we'd have to have something else for
> ->d_dname() etc..).
> 
> Those are all things that the VFS does support, but ...
> 
> So I do prefer Christian's new approach, although some of it ends up
> being a bit unclear.
> 
> Christian, can you explain why this:
> 
>         spin_lock(&alias->d_lock);
>         dget_dlock(alias);
>         spin_unlock(&alias->d_lock);
> 
> instead of just 'dget()'?

No reason other than I forgot to switch to dget().

> 
> Also, while I found the old __ns_get_path() to be fairly disgusting, I
> actually think it's simpler and clearer than playing around with the
> dentry alias list. So my expectation on code sharing was that you'd

It's overall probably also cheaper, I think.

> basically lift the old __ns_get_path(), make *that* the helper, and
> just pass it an argument that is the pointer to the filesystem
> "stashed" entry...
> 
> And yes, using "atomic_long_t" for stashed is a crime against
> humanity. It's also entirely pointless. There are no actual atomic
> operations that the code wants except for reading and writing (aka
> READ_ONCE() and WRITE_ONCE()) and cmpxchg (aka just cmpxchg()). Using
> "atomic_long_t" buys the code nothing, and only makes things more
> complicated and requires crazy casts.

Yup, I had that as a draft and that introduced struct ino_stash which
contained a dentry pointer and the inode number using cmpxchg(). But I
decided against this because ns_common.h would require to have access to
ino_stash definition so we wouldn't just able to hide it in internal.h
where it should belong.

> 
> So I think the nsfs.c code should be changed to do
> 
> -       atomic_long_t stashed;
> +       struct dentry *stashed;
> 
> and remove the crazy workarounds for using the wrong type.
> 
> Something like the attached patch.
> 
> Then, I think the whole "lockref_get_not_dead()" etc games of
> __ns_get_path() could be extracted out into a helper function that
> takes that "&ns->stashed" pointer as an argument, and now that helper
> could also be used for pidfs, except pidfs obviously just does
> "&pid->stashed" instead.
> 
> Hmm?
> 
> Entirely untested patch. Also, the above idea may be broken because of
> some obvious issue that I didn't think about. Christian?

Yeah, sure. Works for me. Let me play with something.

