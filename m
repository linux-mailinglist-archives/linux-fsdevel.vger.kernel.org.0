Return-Path: <linux-fsdevel+bounces-41390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC76CA2EC1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304A2188558D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0357F1EF0AE;
	Mon, 10 Feb 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFK8Z3u7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B3D14B08C
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188903; cv=none; b=ZepNHh/JNQJY9Xwlg4gCmwaVr64jLxhUemD+J3LhgjeKmqkQIix/WVVZzk0wHu606wFiUEN8JVn7zTanSSVd+Fbc97UG11Pb1ylihcGwHUEETdrhLmLR7sY100GqTjoYpsvL7RfP2yrl6LTvzgSZNJLUzQ/wcvUu8wUkLI8zx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188903; c=relaxed/simple;
	bh=8tYC4IyRUQdHWD/F6HDmI9lDP9UEJk8l1l2Vs93JIck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJbr44WJwQBCXtIpL+J+woveSwVKt33Tfi7Fzv7DVpkVnYMsuRc3GDdyDC8WXBxEBY/OrfL1bekEzhVW41LFNbMLufTIXyvQnGVJiYrofk+Z2VTBIgdjGNjcRGAWoeR6+w5Lr6LA2I9tdGGgGCqnTSxn+Yx6sGZQRGUZ9UQQZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFK8Z3u7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487B5C4CED1;
	Mon, 10 Feb 2025 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739188902;
	bh=8tYC4IyRUQdHWD/F6HDmI9lDP9UEJk8l1l2Vs93JIck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFK8Z3u7E1GMH/y8GJaylBDnBiyBCR5iat7ATYDMIOuowS6Ea90gSo0gcudUON7YQ
	 N+qo/0T8fETjsuv/lH5enn2Jt9ktsVLb6txIqWFMhVvnhlaKOk3vhwnJfSdZgEEVOI
	 IpZ3IksrxQYxL4mYC4srPJY/kqOGBpG4dOzKEQHGfBEdutahCZ3og1ZgbgY8NNagrH
	 XqwJo1CKb+4eioZrPFAGHBnIOJn6mZ7M2FQYF8sFzt3f2FDzpnlNN3HLbrqlqWotkq
	 X/oujOSIFBYP/vY6ZYG/dD9/p8oFLhtuaw92KfGCyh9V5XyXqGP9E8JSY3XSIzowPc
	 UhnIVQwIcBbpg==
Date: Mon, 10 Feb 2025 13:01:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
Message-ID: <20250210-urfassung-heerscharen-aa9c46a64724@brauner>
References: <20250207-daten-mahlzeit-99d2079864fb@brauner>
 <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
 <CAGudoHGGW0BZcqyWbEV7x3rtQnRCkhhkbHNhYB0QeihSnE0VTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGGW0BZcqyWbEV7x3rtQnRCkhhkbHNhYB0QeihSnE0VTA@mail.gmail.com>

On Fri, Feb 07, 2025 at 05:42:17PM +0100, Mateusz Guzik wrote:
> On Fri, Feb 7, 2025 at 4:50 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 07-02-25 15:10:33, Christian Brauner wrote:
> > > Before 2011 there was no meaningful synchronization between
> > > read/readdir/write/seek. Only in commit
> > > ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> > > synchronization was added for SEEK_CUR by taking f_lock around
> > > vfs_setpos().
> > >
> > > Then in 2014 full synchronization between read/readdir/write/seek was
> > > added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX")
> > > by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> > > for directories. At that point taking f_lock became unnecessary for such
> > > files.
> > >
> > > So only acquire f_lock for SEEK_CUR if this isn't a file that would have
> > > acquired f_pos_lock if necessary.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > ...
> >
> > >       if (whence == SEEK_CUR) {
> > > +             bool locked;
> > > +
> > >               /*
> > > -              * f_lock protects against read/modify/write race with
> > > -              * other SEEK_CURs. Note that parallel writes and reads
> > > -              * behave like SEEK_SET.
> > > +              * If the file requires locking via f_pos_lock we know
> > > +              * that mutual exclusion for SEEK_CUR on the same file
> > > +              * is guaranteed. If the file isn't locked, we take
> > > +              * f_lock to protect against f_pos races with other
> > > +              * SEEK_CURs.
> > >                */
> > > -             guard(spinlock)(&file->f_lock);
> > > -             return vfs_setpos(file, file->f_pos + offset, maxsize);
> > > +             locked = (file->f_mode & FMODE_ATOMIC_POS) ||
> > > +                      file->f_op->iterate_shared;
> >
> > As far as I understand the rationale this should match to
> > file_needs_f_pos_lock() (or it can possibly be weaker) but it isn't obvious
> > to me that's the case. After thinking about possibilities, I could convince
> > myself that what you suggest is indeed safe but the condition being in two
> > completely independent places and leading to subtle bugs if it gets out of
> > sync seems a bit fragile to me.
> >
> 
> A debug-only assert that the lock is held when expected should sort it out?

Good idea. Let me reuse the newly added infra:
VFS_WARN_ON_ONCE(locked && !mutex_is_locked(&file->f_pos_lock));

> 
> > > +             if (!locked)
> > > +                     spin_lock(&file->f_lock);
> > > +             offset = vfs_setpos(file, file->f_pos + offset, maxsize);
> > > +             if (!locked)
> > > +                     spin_unlock(&file->f_lock);
> > > +             return offset;
> > >       }
> > >
> > >       return vfs_setpos(file, offset, maxsize);
> 
> btw I ran this sucker over a kernel build:
> 
> bpftrace -e 'kprobe:generic_file_llseek_size { @[((struct file
> *)arg0)->f_mode & (1 << 15), ((struct file
> *)arg0)->f_op->iterate_shared, arg2] = count(); }
> '
> Attaching 1 probe...
> ^C
> 
> @[32768, 0x0, 2]: 9
> @[32768, 0x0, 1]: 171797
> @[32768, 0x0, 0]: 660866
> 
> SEEK_CUR is 1, so this *does* show up.

Thanks for the perf.

