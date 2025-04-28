Return-Path: <linux-fsdevel+bounces-47524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9438AA9F4F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E367A17FF16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F626B2D2;
	Mon, 28 Apr 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHOjEbWu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41478F54
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855471; cv=none; b=l3+oshAiUe3PsJ3MRfZskkkBszYSBvEPRI0gvYE1euSJc1M78VOfruS3q8CQJxr/1n9uSudY4OMSIGBSStuWNW81Rp3WDUR19CN1T60H81t0RzEQYfZCLaVRLHUf2AIZ9QG1CubxFYPaBi8qqEKCXM/CRy00Zwd8+gEbo26hIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855471; c=relaxed/simple;
	bh=pfklE0F1SVhBghWOdCZNbtC7aOlEjze6zdRhSRHI88g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVYEKg3GuNHrAQ8pqTFncfSwszNiXK7hTVhep/hGM3Zs4WRDX/odqGD7FhcMw1cNY0f1NEsbCRRMyT2aKkIyYb3gJXc1K5ezNeMTl10d4K+Dt7QdkkT5gklW3ZkbkQm1zuxCBvF+dvlDTJ6qQqmbR3LpVjYgDedEVF5iWDfHCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHOjEbWu; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso7215028a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745855468; x=1746460268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH5ohwLmyaZzDCCM5MoQyHMDhrZnPuIBhBeAUqE2dZ8=;
        b=lHOjEbWub+ah1JGSOvG5Hn6HH7cOhkK74tZ4lx4kdnBbGLFsw4kAbqjXdPEy5KAQUu
         jpLB2BRAFye1eIV4ezgCX9dT06Nfcj3cX1LwD66eZEF+7KxP71pCfCeGCBi6xq70SwJs
         UgEwHxUJeKuiNNFor2vFf8hUI9wAUmW+O1Xs1A6MLnFsfqcOMrOLQyn9d8cnXPPkcL51
         e+Sr5AA3GZjI5pSjWCWwQSRm410vPEVHyI9VubQRmLg0HT8Axp/TH0G6UXCoCNTdfI2q
         G88K5QilUYA57pyYSIMXuu6VQwtNhpfw//n1j2JKbcrIpJi8/zLasbJ94Lmn3hMDfk8O
         ox1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855468; x=1746460268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KH5ohwLmyaZzDCCM5MoQyHMDhrZnPuIBhBeAUqE2dZ8=;
        b=hVMBX8fa56i8xGvePR1IrxHfcgBWlxGG2diRzEi9YLf8yc1utwzPbx9GezM/nqdRFI
         3J4xRz2+xkWnQXtoS/BV1HyQQnLMv6aN12OW6ad/HrapLoDCm8Zym248h7SZbXhsaK/f
         MdBXpSTOBHxl8hDaYp3qAwVXv9pvEoaqFBFzKvucUhP4+xkk7b5xk4RnH8lPvzAfUR1l
         ebSn2x8SvWR1Ke+pTMmpgCXvhFpcQSLEVwB5JNpbTUkLJnwcJ4LvKYKqhHgHr+d6OZxe
         TuH7zgA1bRGjeAV57/bQ5oNy8DcVNuEr+DbHMfLTO1Vez5ACPywwzfnAyVThL1c78/DW
         v2eA==
X-Forwarded-Encrypted: i=1; AJvYcCXsg1ByRseIRrSimNeyjDzQQ93UPhA2ieweocWiRbWc07jJxcO1eOFQbVCPZhPhz7abQeJPp4LMZyXlV2Gh@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxL+7raNoStFqDhl1O0ulUpQAFifGlaCaCdKwfZ0Fp0tqNZrr
	jAFO1YR8EV7w9qKoUe52zlBfHgdbMZ25qIgN/hYFcaWUPrY2qVx6QEO7ktOziOsj22Enpu9CXkq
	SZoTdPfdJb1TtLiwnHW8DxuCR5ok=
X-Gm-Gg: ASbGncu4b3H/1TUE7hP2cdVUREBadhPjgEdGjq9AXnVAeTz9uKlMkAsHOQpTkcLT6+G
	PqEAKPTdWnMlG1c+j8jH9FL+6BTrc/MwAfXRK4xHDZTOQGC361yNcqMRTr+swKmjPZoOE5LHHeO
	6bDbl1T2OpaKvazcoA0mkz
X-Google-Smtp-Source: AGHT+IFzMKAcBs495p53fjBY1i1MQWtY8bA8JprBDv+UUPl5c7lpe/gSSlHi9JOGxW8qdJ9KH0NGnVuFKeA2ez3c+AA=
X-Received: by 2002:a05:6402:2707:b0:5f6:25d6:71dd with SMTP id
 4fb4d7f45d1cf-5f83801c89bmr153383a12.0.1745855467222; Mon, 28 Apr 2025
 08:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424132246.16822-2-jack@suse.cz> <uz6xvk77mvfsq6hkeclq3yksbalcvjvaqgdi4a5ai6kwydx2os@sbklkpv4wgah>
 <20250425-fahrschein-obacht-c622fbb4399b@brauner> <a3w7xdgldyoodxeav6zwn3dkw6y4cir6fdhftopo3snrpgbjoz@zvz4vny63ehf>
 <CAGudoHF_h0Yg9pp9LqG0CKaqZDJgAjA9Tp+piJ0aMO+V9iFXBg@mail.gmail.com> <20250428-fortpflanzen-elektrisch-93cfdde43763@brauner>
In-Reply-To: <20250428-fortpflanzen-elektrisch-93cfdde43763@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 28 Apr 2025 17:50:55 +0200
X-Gm-Features: ATxdqUHhHDX5-gN9x2g2l8I4KLgb3HyJzhYMN9PfN2lkdhdPnnu2PVc9Nv3poOE
Message-ID: <CAGudoHFQ5jVTwbFgJO5qEVyQynbd7ueY2xrcCEqJ_d+72vVTpA@mail.gmail.com>
Subject: Re: [PATCH] fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:58=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Sat, Apr 26, 2025 at 09:30:25PM +0200, Mateusz Guzik wrote:
> > On Fri, Apr 25, 2025 at 3:33=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 25-04-25 10:45:22, Christian Brauner wrote:
> > > > On Thu, Apr 24, 2025 at 05:45:17PM +0200, Mateusz Guzik wrote:
> > > > > On Thu, Apr 24, 2025 at 03:22:47PM +0200, Jan Kara wrote:
> > > > > > Currently, setxattrat(2) and getxattrat(2) are wrongly handling=
 the
> > > > > > calls of the from setxattrat(AF_FDCWD, NULL, AT_EMPTY_PATH, ...=
) and
> > > > > > fail with -EBADF error instead of operating on CWD. Fix it.
> > > > > >
> > > > > > Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
> > > > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > > > ---
> > > > > >  fs/xattr.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/xattr.c b/fs/xattr.c
> > > > > > index 02bee149ad96..fabb2a04501e 100644
> > > > > > --- a/fs/xattr.c
> > > > > > +++ b/fs/xattr.c
> > > > > > @@ -703,7 +703,7 @@ static int path_setxattrat(int dfd, const c=
har __user *pathname,
> > > > > >           return error;
> > > > > >
> > > > > >   filename =3D getname_maybe_null(pathname, at_flags);
> > > > > > - if (!filename) {
> > > > > > + if (!filename && dfd >=3D 0) {
> > > > > >           CLASS(fd, f)(dfd);
> > > > > >           if (fd_empty(f))
> > > > > >                   error =3D -EBADF;
> > > > > > @@ -847,7 +847,7 @@ static ssize_t path_getxattrat(int dfd, con=
st char __user *pathname,
> > > > > >           return error;
> > > > > >
> > > > > >   filename =3D getname_maybe_null(pathname, at_flags);
> > > > > > - if (!filename) {
> > > > > > + if (!filename && dfd >=3D 0) {
> > > > > >           CLASS(fd, f)(dfd);
> > > > > >           if (fd_empty(f))
> > > > > >                   return -EBADF;
> > > > >
> > > > > Is there any code which legitimately does not follow this pattern=
?
> > > > >
> > > > > With some refactoring getname_maybe_null() could handle the fd th=
ing,
> > > > > notably return the NULL pointer if the name is empty. This could =
bring
> > > > > back the invariant that the path argument is not NULL.
> > > > >
> > > > > Something like this:
> > > > > static inline struct filename *getname_maybe_null(int fd, const c=
har __user *name, int flags)
> > > > > {
> > > > >         if (!(flags & AT_EMPTY_PATH))
> > > > >                 return getname(name);
> > > > >
> > > > >         if (!name && fd >=3D 0)
> > > > >                 return NULL;
> > > > >         return __getname_maybe_null(fd, name);
> > > > > }
> > > > >
> > > > > struct filename *__getname_maybe_null(int fd, const char __user *=
pathname)
> > > > > {
> > > > >         char c;
> > > > >
> > > > >         if (fd >=3D 0) {
> > > > >                 /* try to save on allocations; loss on um, though=
 */
> > > > >                 if (get_user(c, pathname))
> > > > >                         return ERR_PTR(-EFAULT);
> > > > >                 if (!c)
> > > > >                         return NULL;
> > > > >         }
> > > > >
> > > > >     /* we alloc suffer the allocation of the buffer. worst case, =
if
> > > > >      * the name turned empty in the meantime, we return it and
> > > > >      * handle it the old-fashioned way.
> > > > >      /
> > > > >         return getname_flags(pathname, LOOKUP_EMPTY);
> > > > > }
> > > > >
> > > > > Then callers would look like this:
> > > > > filename =3D getname_maybe_null(dfd, pathname, at_flags);
> > > > > if (!filename) {
> > > > >     /* fd handling goes here */
> > > > >     CLASS(fd, f)(dfd);
> > > > >     ....
> > > > >
> > > > > } else {
> > > > >     /* regular path handling goes here */
> > > > > }
> > > > >
> > > > >
> > > > > set_nameidata() would lose this branch:
> > > > > p->pathname =3D likely(name) ? name->name : "";
> > > > >
> > > > > and putname would convert IS_ERR_OR_NULL (which is 2 branches) in=
to one,
> > > > > maybe like so:
> > > > > -       if (IS_ERR_OR_NULL(name))
> > > > > +       VFS_BUG_ON(!name);
> > > > > +
> > > > > +       if (IS_ERR(name))
> > > > >                 return;
> > > > >
> > > > > i think this would be an ok cleanup
> > > >
> > > > Not opposed, but please for -next and Jan's thing as a backportable=
 fix,
> > > > please. Thanks!
> > >
> > > Exactly, I agree the code is pretty subtle and ugly. It shouldn't tak=
e
> > > several engineers to properly call a function to lookup a file :) So
> > > some cleanup and refactoring is definitely long overdue but for now I
> > > wanted some minimal fix which is easy to backport to stable.
> > >
> > > When we speak about refactoring: Is there a reason why user_path_at()
> > > actually doesn't handle NULL 'name' as empty like we do it in *xattra=
t()
> > > syscalls? I understand this will make all _at() syscalls accept NULL =
name
> > > with AT_EMPTY_PATH but is that a problem?
> >
> > Is there a benefit for doing it though?
> >
> > I think the entire AT_EMPTY_PATH and NULL thing is trainwreck which
> > needs to be reasonably contained instead. In particular the flag has
> > most regrettable semantics of requiring an actual path (the NULL thing
> > is a Linux extension) and being a nop if the path is not empty.
> >
> > The entire thing is a kludge for syscalls which don't have an fd-only
> > variant and imo was the wrong way to approach this (provide fd-only
> > variants instead), but it's too late now.
> >
> > user_path_at() always returns a path (go figure). Suppose it got
> > extended with the fuckery and some userspace started to rely on it.
> >
> > Part of the benefit of having a fd-based op and knowing it is fd-based
> > is that you know the inode itself is secured by liveness of the file
> > object. If the calling thread is a part of a single-threaded process,
> > then there is the extra benefit of eliding atomics on the file thing
> > (reducing single-threaded cost). If the thing is multi-threaded,
> > atomics are only done on the file (not the inode), which scales better
> > if other procs use a different file obj for the same inode.
> >
> > Or to put it differently, if user_path_at() keeps returning a path
> > like it does now *and* is relied on for AT_EMPTY_PATH fuckery, it is
> > going to impose extra overhead on its consumers.
> >
> > Suppose one will decide to combat it. Then the routine will have to
> > copy path from the file without refing it and return an indicator
> > what's needed -- path_put for a real path handling, fput for fd-only
> > in a multithreaded proc [but then also it will need to return the
> > found file obj] and nothing for a fd-only in a single-threaded proc.
> >
> > I think that's ugly af and completely unnecessary.
>
> I'm not going to debate AT_EMPTY_PATH with NULL again. This particular
> hedgehog can never be buggered at all (anymore).
>
> The fdsyscall() and fdatsyscall() is an ancient debate as well. In
> principle for most use-cases its possible to get away with openat(fd,
> path) and then most other system calls could very likely just fd-based.
>
> So one could argue "fsck fdatsyscall()s" and refuse to add them. That of
> course will ignore everyone who doesn't want to or cannot open the file
> they want to operate on which is not super common but common enough.
> O_PATH won't save them in all cases because they might need a file with
> proper file_operations not empty_fops set.
>
> The other thing is that this forces everyone to allocate a file for
> every operation they do and returning it to userspace and then closing
> it again. It's annoying and also very costly for a bunch of use-cases.
>
> Ok, so the other option is that we just merge fdsyscall()s whenever
> someone needs to really not be bothered with passing a path and we also
> merge fdatsyscall() whenever someone needs to be able to lookup. I
> personally hate this and I'm sure we'd get some questions form Linus why
> we always merge two variants.
>
> But ok we'd probably handle the fdsyscall()/fdatsyscall() split
> gracefully enough by separating pure fdsyscall() vfs_*() helpers and
> fdatsyscall() vfs_*() helpers and come up with a scheme that doesn't
> lead to too much fragementation in how we handle this.
>
> And that is at the core of the issue for me:
>
> (1) We try to reduce the number of helpers that we have internally as
>     much as possible.
> (2) We try to reduce the number of special paths that code can take as
>     much as possible.
>
> This is vital. It is a long-term survival and sanity question. Because
> we have again and again observed endless fragmentation in the number of
> helpers and number of special-cases. They will keep coming and someone
> needs to understand them all.
>
> The price is high, very very high in the long-term. Because if we don't
> pay close attention we suddenly end up with 10 helpers for the same
> thing, 5 of which inexplicably end up being exported to 15 random
> modules of which 5 abuse it. So now we need to clean this up - tree
> wide. Fun times.
>
> Same with special-cases.
>
> So yes, there's a trade-off where taking the additional hit of an atomic
> or refcount is done because it collapses a bunch of special-cases into a
> single case. And that may have an impact on some workloads. If that gets
> reported we always try to figure out an acceptable solution and we
> almost always do.
>
> Your work is actually a good example of this. You _should be_ (note the
> _should_) a pain in our sweet little behinds :) because in some sense a
> lot of your requests are "If we make this a special-case and add a tiny
> helper for it then we elide an atomic in this and that condition for the
> single-threaded use-case.". So you are always on the border of pushing
> against (1) and (2). That's fine and your work is great and needed and
> we seem to always fine a good way to make it acceptable.

Well it's not my call to make, moreover is not a good convo to have
over an e-mail either, so I'm just going to make few remarks and drop
it.

I don't out of control helpers for the syscalls are inherent to
special casing fd-only operation. In my experience dealing with VFS
$elsewhere what actually gets in the way of long term maintenance is
poor assert coverage and weird internal helpers (where the real magic
happens), not some entry point.

Also note my proposal above with refactoring getname_maybe_null
*reduces* special casing by whacking a corner case of a NULL name
landing in the real lookup.

That said, looking at this again, I think the cases which already
explicitly special case fd handling would end up cleaner than they are
right now with a helper taking care of it. I still disagree
user_path_at() should be that helper though (to not disturb the
current consumers).

so something like this perhaps (names not binding):
struct user_path_state {
    struct path *path;
    struct file *fp;
    int flags;
};

struct user_path_state ups =3D user_path_state_init();
err =3D user_path_lookup(....., &ups);
if (err)
    goto bad;
err =3D magic_work_based_on_path(ups->path, ....); /* path is secured,
maybe refed or maybe relying on the file obj */
user_path_cleanup(&ups); /* mandatory call to clean things up */
if (!err)
    err =3D copyout(.....);
return err;

then user_path_cleanup() knows what's up.

btw, in the name of maintenance, I think part of the problem is the
notorious NULL checks everywhere, which prevent asserting on the
consumer knowing what they are executing (for example in path_put).

--=20
Mateusz Guzik <mjguzik gmail.com>

