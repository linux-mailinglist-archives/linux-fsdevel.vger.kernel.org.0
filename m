Return-Path: <linux-fsdevel+bounces-16106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F2389843F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 11:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4F81F29C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671084D35;
	Thu,  4 Apr 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7VOYkxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7F073186;
	Thu,  4 Apr 2024 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223234; cv=none; b=lg0rDaDXcPGhYjfMgOx4Oic/wEofldqPuNAM3QV45+9rky+Fn0gaEhDkM4X+4ZqL9+/8xsdb+9duHuclGhWdjUz/BfzpcvtKd6mK0sNu6hjRMLbQd9k7MkrWCLQkstz/3VyX7BCq/XXOq1OCAmh3ZYQ2QtJ9V+PEPd3ggMn5RbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223234; c=relaxed/simple;
	bh=lJfZD0YPE4bSLnA47vSCMjB6M2AgR7foMEa5v1Pe2RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWEkgSAHjPIWL3FvWBKtx9QBLFXOQi8U9DdCaavNodF+DinImFuS7B8LOxecOh8H0BmUYMQl5o1d/3hYrSdPsxmmtVDjWNJk18U1mVlH4MWhan2xAYypAJr9FqzE3qyJduY3kSg5sg+9qmETDXgpnXGQxrlZxcrQjpZJv8z0MPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m7VOYkxw; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6992c0f6da3so3431646d6.1;
        Thu, 04 Apr 2024 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712223232; x=1712828032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWAqHn8+xECL5oeLDf6K7tfC2/a+9qCTtqqBfEwyf6o=;
        b=m7VOYkxwwBxjUxxcQ6fLpU9GxHr40i6tQxNCNexBDO5At9vrQ5xrz1px/hQG+2GIm5
         m75GBJiZtW4wL0+ZMeHN6+JHglfdezCats0tNfIbRjuWLyBdUS17UC0UJ6VcMeA9xL8j
         bNeSusabLV6LoprsUP9mO9Q3Q6Btj2Hk11Kg7oAu7qcqL2JXy5fksI7LfDH37RRL1MqU
         JQ7sIzoCglYNclPmG3roRYhFk8QdXRz0fi0GRZ7Gwlpd9Z3SOE9tVyeGh/g4C1bkLtib
         YbIDvvlmnxPbLCYb0BWhtga868wWjjEWI+LnXfD+v+WaEorbx5D4fKuvgth2IlAEvMbj
         Anyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712223232; x=1712828032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWAqHn8+xECL5oeLDf6K7tfC2/a+9qCTtqqBfEwyf6o=;
        b=cQ69E9H61ypDE72xDtSvXfQT7VbWEi4NGjmiKcOuv7X4TGWhYjTKva0m8+tZVd/y4U
         Fa/W6lqcYIVAoNpQlMEoCxqw4htagXVTHI9Z2rc9G+lZhcNnpRKMFPB4FKDMa0MpH2Vm
         /T4LFBt/o1BV8X2HR38Kf7poyFgA35ScNro3Je5vMY9t7edeuj+wbzcq7df/GGqztSIv
         56nqcY8U3wr68RwqpHpNPp2QOb4wvWLC46rx3B6rlUfkB5wAunWk51lk115MJ+9UKIaV
         RU5Te7FfyqFZ/QhSnCP8ym1eN/51yi8Ko8+v8RCjT6tP6u5i3/z5CMTXOuhPxK5Rtcgb
         aUVw==
X-Forwarded-Encrypted: i=1; AJvYcCW1PnVayE2YKfieIgQ4uZk1I3LQ1W7Ng9yfqv4Maoz4iJ1GHaEu4Y9Y8uuW8qUllrZWlTKMJSLs0mKw3vmLH9O1uVdfDDmawHrBzp/yUStXQMpWbkz+nnpXQwdbLQ9ndmA1vedDpNx5DfJFlQ==
X-Gm-Message-State: AOJu0YwF94TmcN4YGjOyLoIukokVvrq/AJ5c9jJenv/aRi/kvRtHzak3
	hMelFtZomxGYvM59FEk7yZiWpHqCCNebUoM87DU57rs1Oj8LzMBHlrybghTnWExPuJDYBziJ870
	8BN312/mL6YkXnFOcEYfdhmseHeE=
X-Google-Smtp-Source: AGHT+IGbbirhCWaHqNC+X46roF64fcTSKbRAVv7l0jg/9DDTm3zUzZN4eZR1RMq9j3HT3R///aBUWTiDFXkiTZfRLew=
X-Received: by 2002:a05:6214:411c:b0:699:1f86:e968 with SMTP id
 kc28-20020a056214411c00b006991f86e968mr1752988qvb.41.1712223231813; Thu, 04
 Apr 2024 02:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000098f75506153551a1@google.com> <0000000000002f2066061539e54b@google.com>
 <CAOQ4uxiS5X19OT2MTo_LnLAx2VL9oA1zBSpbuiWMNy_AyGLDrg@mail.gmail.com>
 <20240404081122.GQ538574@ZenIV> <20240404082110.GR538574@ZenIV>
In-Reply-To: <20240404082110.GR538574@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Apr 2024 12:33:40 +0300
Message-ID: <CAOQ4uximHfK78KFabJA3Hf4R0En6-GfJ3eF96Lzmc94PGuGayA@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:21=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Thu, Apr 04, 2024 at 09:11:22AM +0100, Al Viro wrote:
> > On Thu, Apr 04, 2024 at 09:54:35AM +0300, Amir Goldstein wrote:
> > >
> > > In the lockdep dependency chain, overlayfs inode lock is taken
> > > before kernfs internal of->mutex, where kernfs (sysfs) is the lower
> > > layer of overlayfs, which is sane.
> > >
> > > With /sys/power/resume (and probably other files), sysfs also
> > > behaves as a stacking filesystem, calling vfs helpers, such as
> > > lookup_bdev() -> kern_path(), which is a behavior of a stacked
> > > filesystem, without all the precautions that comes with behaving
> > > as a stacked filesystem.
> >
> > No.  This is far worse than anything stacked filesystems do - it's
> > an arbitrary pathname resolution while holding a lock.
> > It's not local.  Just about anything (including automounts, etc.)
> > can be happening there and it pushes the lock in question outside
> > of *ALL* pathwalk-related locks.  Pathname doesn't have to
> > resolve to anything on overlayfs - it can just go through
> > a symlink on it, or walk into it and traverse a bunch of ..
> > afterwards, etc.
> >
> > Don't confuse that with stacking - it's not even close.
> > You can't use that anywhere near overlayfs layers.
> >
> > Maybe isolate it into a separate filesystem, to be automounted
> > on /sys/power.  And make anyone playing with overlayfs with
> > sysfs as a layer mount the damn thing on top of power/ in your
> > overlayfs.  But using that thing as a part of layer is
> > a non-starter.

I don't follow what you are saying.
Which code is in non-starter violation?
kernfs for calling lookup_bdev() with internal of->mutex held?
Overlayfs for allowing sysfs as a lower layer and calling
vfs_llseek(lower_sysfs_file,...) during copy up while ovl inode is held
for legit reasons (e.g. from ovl_rename())?

>
> Incidentally, why do you need to lock overlayfs inode to call
> vfs_llseek() on the underlying file?  It might (or might not)
> need to lock the underlying file (for things like ->i_size,
> etc.), but that will be done by ->llseek() instance and it
> would deal with the inode in the layer, not overlayfs one.

We do not (anymore) lock ovl inode in ovl_llseek(), see:
b1f9d3858f72 ovl: use ovl_inode_lock in ovl_llseek()
but ovl inode is held in operations (e.g. ovl_rename)
which trigger copy up and call vfs_llseek() on the lower file.

>
> Similar question applies to ovl_write_iter() - why do you
> need to hold the overlayfs inode locked during the call of
> backing_file_write_iter()?
>

Not sure. This question I need to defer to Miklos.
I see in several places the pattern:
        inode_lock(inode);
        /* Update mode */
        ovl_copyattr(inode);
        ret =3D file_remove_privs(file);
...
        /* Update size */
        ovl_file_modified(file);
...
        inode_unlock(inode);

so it could be related to atomic remove privs and update mtime,
but possibly we could convert all of those inode_lock() to
ovl_inode_lock() (i.e. internal lock below vfs inode lock).

[...]
> Consider the scenario when unlink() is called on that sucker
> during the write() that triggers that pathwalk.  We have
>
> unlink: blocked on overlayfs inode of file, while holding the parent dire=
ctory.
> write: holding the overlayfs inode of file and trying to resolve a pathna=
me
> that contains .../power/suspend_stats/../../...; blocked on attempt to lo=
ck
> parent so we could do a lookup in it.

This specifically cannot happen because sysfs is not allowed as an
upper layer only as a lower layer, so overlayfs itself will not be writing =
to
/sys/power/resume.

>
> No llseek involved anywhere, kernfs of->mutex held, but not contended,
> deadlock purely on ->i_rwsem of overlayfs inodes.
>
> Holding overlayfs inode locked during the call of lookup_bdev() is really
> no-go.

Yes. I see that, but how can this be resolved?

If the specific file /sys/power/resume will not have FMODE_LSEEK,
then ovl_copy_up_file() will not try to skip_hole on it at all and the
llseek lock dependency will be averted.

The question is whether opt-out of FMODE_LSEEK for /sys/power/resume
will break anything or if we should mark seq files in another way so that
overlayfs would not try to seek_hole on any of them categorically.

Thanks,
Amir.

