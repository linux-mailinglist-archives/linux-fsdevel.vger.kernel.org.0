Return-Path: <linux-fsdevel+bounces-47507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B224FA9ED5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B444188BF13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EC25EFB6;
	Mon, 28 Apr 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVNEWYAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D621FF603
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745834321; cv=none; b=Hnx2RQ8SFHJRWIMVx6qjSZKMmLUgCUbqAoeitAIxOcZUyQBFV7oshratNXjAlN9gheig7JVqXxRcVtKW0Rt2f5bc9mzvOHy1zij5Wcac85tGHtEoSiAcvGzk+whcFdvypyNHdMZeuFc49le18AftsOiuGI+Y4ZaGoBzizs7mpNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745834321; c=relaxed/simple;
	bh=XtmfWinvkqRmFbA+vdlnJwaIxoZ6o+3WHY9QrPt1yFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCTERshvNdhi/QvXp+KtZiIDbiHNXGgzqKElcz0Pjw2m9SP4UpXtVnPcZGiF2Y2WN16rJfNa8MJt9GIMFwsFy+zLw+Xjx49b8HFMUJYDJ8cEBGTugP7y23EJNGdNm0zCy3JnDB4H28kpam9z4HzNx1Gx6d4WAiWJIn67LvWl6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVNEWYAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD483C4CEE4;
	Mon, 28 Apr 2025 09:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745834320;
	bh=XtmfWinvkqRmFbA+vdlnJwaIxoZ6o+3WHY9QrPt1yFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVNEWYAYkUuR7ZM5Zj6XigXZ4LirVyzWM7wH2Eneh85fhOitPuk6hUz4Hhmdp8kpd
	 LnkEZ/1OE8IJxyJCvXWEILGEOyiH0tdtTmIIOFpS+bLGk9xASw71uTOW5bhWQ2LO4T
	 pgfFPKgz7GMhRLfhtpYVCdUlRid3EhNm4VxuzUPdBEkDocL3+0D9uWKZhs5AlQ/G44
	 SIV/IyuPK5RVNtIXFA6QPamd48aAiwMUGOze5m5tIo4aKMnTNQ2Pfk8SJpaZl9Q7E6
	 KC1iM9LCJ/wd+WE/ejs/1N6pMKkRoWLrsRnm0E5c8Ob0QnjTxh1pONlsBz3qGSKj7x
	 r56D+Iwotn7cA==
Date: Mon, 28 Apr 2025 11:58:37 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and
 getxattrat(2)
Message-ID: <20250428-fortpflanzen-elektrisch-93cfdde43763@brauner>
References: <20250424132246.16822-2-jack@suse.cz>
 <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
 <20250425-fahrschein-obacht-c622fbb4399b@brauner>
 <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>
 <CAGudoHF_h0Yg9pp9LqG0CKaqZDJgAjA9Tp+piJ0aMO+V9iFXBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHF_h0Yg9pp9LqG0CKaqZDJgAjA9Tp+piJ0aMO+V9iFXBg@mail.gmail.com>

On Sat, Apr 26, 2025 at 09:30:25PM +0200, Mateusz Guzik wrote:
> On Fri, Apr 25, 2025 at 3:33 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 25-04-25 10:45:22, Christian Brauner wrote:
> > > On Thu, Apr 24, 2025 at 05:45:17PM +0200, Mateusz Guzik wrote:
> > > > On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> > > > > Currently, setxattrat(2) and getxattrat(2) are wrongly handling the
> > > > > calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...) and
> > > > > fail with -EBADF error instead of operating on CWD. Fix it.
> > > > >
> > > > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > ---
> > > > >  fs/xattr.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > > index 02bee149ad96..fabb2a04501e 100644
> > > > > --- a/fs/xattr.c
> > > > > +++ b/fs/xattr.c
> > > > > @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
> > > > >           return error;
> > > > >
> > > > >   filename = getname_maybe_null(pathname, at_flags);
> > > > > - if (!filename) {
> > > > > + if (!filename && dfd >= 0) {
> > > > >           CLASS(fd, f)(dfd);
> > > > >           if (fd_empty(f))
> > > > >                   error = -EBADF;
> > > > > @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
> > > > >           return error;
> > > > >
> > > > >   filename = getname_maybe_null(pathname, at_flags);
> > > > > - if (!filename) {
> > > > > + if (!filename && dfd >= 0) {
> > > > >           CLASS(fd, f)(dfd);
> > > > >           if (fd_empty(f))
> > > > >                   return -EBADF;
> > > >
> > > > Is there any code which legitimately does not follow this pattern?
> > > >
> > > > With some refactoring getname_maybe_null() could handle the fd thing,
> > > > notably return the NULL pointer if the name is empty. This could bring
> > > > back the invariant that the path argument is not NULL.
> > > >
> > > > Something like this:
> > > > static inline struct filename *getname_maybe_null(int fd, const char __user *name, int flags)
> > > > {
> > > >         if (!(flags & AT_EMPTY_PATH))
> > > >                 return getname(name);
> > > >
> > > >         if (!name && fd >= 0)
> > > >                 return NULL;
> > > >         return __getname_maybe_null(fd, name);
> > > > }
> > > >
> > > > struct filename *__getname_maybe_null(int fd, const char __user *pathname)
> > > > {
> > > >         char c;
> > > >
> > > >         if (fd >= 0) {
> > > >                 /* try to save on allocations; loss on um, though */
> > > >                 if (get_user(c, pathname))
> > > >                         return ERR_PTR(-EFAULT);
> > > >                 if (!c)
> > > >                         return NULL;
> > > >         }
> > > >
> > > >     /* we alloc suffer the allocation of the buffer. worst case, if
> > > >      * the name turned empty in the meantime, we return it and
> > > >      * handle it the old-fashioned way.
> > > >      /
> > > >         return getname_flags(pathname, LOOKUP_EMPTY);
> > > > }
> > > >
> > > > Then callers would look like this:
> > > > filename = getname_maybe_null(dfd, pathname, at_flags);
> > > > if (!filename) {
> > > >     /* fd handling goes here */
> > > >     CLASS(fd, f)(dfd);
> > > >     ....
> > > >
> > > > } else {
> > > >     /* regular path handling goes here */
> > > > }
> > > >
> > > >
> > > > set_nameidata() would lose this branch:
> > > > p->pathname = likely(name) ? name->name : "";
> > > >
> > > > and putname would convert IS_ERR_OR_NULL (which is 2 branches) into one,
> > > > maybe like so:
> > > > -       if (IS_ERR_OR_NULL(name))
> > > > +       VFS_BUG_ON(!name);
> > > > +
> > > > +       if (IS_ERR(name))
> > > >                 return;
> > > >
> > > > i think this would be an ok cleanup
> > >
> > > Not opposed, but please for -next and Jan's thing as a backportable fix,
> > > please. Thanks!
> >
> > Exactly, I agree the code is pretty subtle and ugly. It shouldn't take
> > several engineers to properly call a function to lookup a file :) So
> > some cleanup and refactoring is definitely long overdue but for now I
> > wanted some minimal fix which is easy to backport to stable.
> >
> > When we speak about refactoring: Is there a reason why user_path_at()
> > actually doesn't handle NULL 'name' as empty like we do it in *xattrat()
> > syscalls? I understand this will make all _at() syscalls accept NULL name
> > with AT_EMPTY_PATH but is that a problem?
> 
> Is there a benefit for doing it though?
> 
> I think the entire AT_EMPTY_PATH and NULL thing is trainwreck which
> needs to be reasonably contained instead. In particular the flag has
> most regrettable semantics of requiring an actual path (the NULL thing
> is a Linux extension) and being a nop if the path is not empty.
> 
> The entire thing is a kludge for syscalls which don't have an fd-only
> variant and imo was the wrong way to approach this (provide fd-only
> variants instead), but it's too late now.
> 
> user_path_at() always returns a path (go figure). Suppose it got
> extended with the fuckery and some userspace started to rely on it.
> 
> Part of the benefit of having a fd-based op and knowing it is fd-based
> is that you know the inode itself is secured by liveness of the file
> object. If the calling thread is a part of a single-threaded process,
> then there is the extra benefit of eliding atomics on the file thing
> (reducing single-threaded cost). If the thing is multi-threaded,
> atomics are only done on the file (not the inode), which scales better
> if other procs use a different file obj for the same inode.
> 
> Or to put it differently, if user_path_at() keeps returning a path
> like it does now *and* is relied on for AT_EMPTY_PATH fuckery, it is
> going to impose extra overhead on its consumers.
> 
> Suppose one will decide to combat it. Then the routine will have to
> copy path from the file without refing it and return an indicator
> what's needed -- path_put for a real path handling, fput for fd-only
> in a multithreaded proc [but then also it will need to return the
> found file obj] and nothing for a fd-only in a single-threaded proc.
> 
> I think that's ugly af and completely unnecessary.

I'm not going to debate AT_EMPTY_PATH with NULL again. This particular
hedgehog can never be buggered at all (anymore).

The fdsyscall() and fdatsyscall() is an ancient debate as well. In
principle for most use-cases its possible to get away with openat(fd,
path) and then most other system calls could very likely just fd-based.

So one could argue "fsck fdatsyscall()s" and refuse to add them. That of
course will ignore everyone who doesn't want to or cannot open the file
they want to operate on which is not super common but common enough.
O_PATH won't save them in all cases because they might need a file with
proper file_operations not empty_fops set.

The other thing is that this forces everyone to allocate a file for
every operation they do and returning it to userspace and then closing
it again. It's annoying and also very costly for a bunch of use-cases.

Ok, so the other option is that we just merge fdsyscall()s whenever
someone needs to really not be bothered with passing a path and we also
merge fdatsyscall() whenever someone needs to be able to lookup. I
personally hate this and I'm sure we'd get some questions form Linus why
we always merge two variants.

But ok we'd probably handle the fdsyscall()/fdatsyscall() split
gracefully enough by separating pure fdsyscall() vfs_*() helpers and
fdatsyscall() vfs_*() helpers and come up with a scheme that doesn't
lead to too much fragementation in how we handle this.

And that is at the core of the issue for me:

(1) We try to reduce the number of helpers that we have internally as
    much as possible.
(2) We try to reduce the number of special paths that code can take as
    much as possible.

This is vital. It is a long-term survival and sanity question. Because
we have again and again observed endless fragmentation in the number of
helpers and number of special-cases. They will keep coming and someone
needs to understand them all.

The price is high, very very high in the long-term. Because if we don't
pay close attention we suddenly end up with 10 helpers for the same
thing, 5 of which inexplicably end up being exported to 15 random
modules of which 5 abuse it. So now we need to clean this up - tree
wide. Fun times.

Same with special-cases.

So yes, there's a trade-off where taking the additional hit of an atomic
or refcount is done because it collapses a bunch of special-cases into a
single case. And that may have an impact on some workloads. If that gets
reported we always try to figure out an acceptable solution and we
almost always do.

Your work is actually a good example of this. You _should be_ (note the
_should_) a pain in our sweet little behinds :) because in some sense a
lot of your requests are "If we make this a special-case and add a tiny
helper for it then we elide an atomic in this and that condition for the
single-threaded use-case.". So you are always on the border of pushing
against (1) and (2). That's fine and your work is great and needed and
we seem to always fine a good way to make it acceptable.

