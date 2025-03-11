Return-Path: <linux-fsdevel+bounces-43715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFE9A5C401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 15:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07083B50F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125B1D514E;
	Tue, 11 Mar 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUpQ1fQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA23237701
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703837; cv=none; b=Q4btK70CLYMDmadDYn1mS3r+vbbeye0ks9+hOqKkMjXEYn5hlkYOEH8Djmh6gQ5e/8JmoROhqjy2hDh4+RSecesCX3zJMerISMCfgX4yu3casXWE44U+CauuavQYr3inne3BZjXg5lNWsdwVMuIGMyEI54Qw6eHOs9mJ4yiGdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703837; c=relaxed/simple;
	bh=HxykoG6xNdnvLr3P6GSoxUNR86/CbI9HrZ+sCVMNUAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVY1rYJl2BZhEOvfmNTNIyLW5kOKccZsfGAGT6cttbn5E/Ooz32ZmgSbuYUz11QhCxthhrfokyfXW01/O+JNcAkrBbbubTFVvoo1Avpq9dg+uaX2HLJ1FjqUO6MdR/hf2nObSAGqn59xEcgDEzQqyKwpgHqMyvNd5aHAwofhoao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUpQ1fQJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2b10bea16so265816066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703834; x=1742308634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svxKIDRT3Kb7eAMZEb1N1l4m5wu9uJL8REG1UUG/0yE=;
        b=gUpQ1fQJNfASL0JwlN033g2F1/WI56U3C48bNphrgDtTzc84jxDOINAscjhZJXCcX3
         N/DTHGUb+RoFRohOWrl9X5nY/osvIQoZ/VfKGziMztk16RuuBzWfp07wrlIY+kUZBoIR
         3+/ZqYZP9fP2MKNewro89WyuhAdpN9WXCRz8iH69BjiRgMyH1udgUR5ToJbWrkj572CP
         EZmYoZaLFnwo2vJfQtPAIC87lZnG3727UBSU+bFzFHcS+RtJvHjYb3cIEGZBXLJ/b0L0
         F3joLpw8F/nTwCMroz1AukLOKen1R9kcBU2JWy9TvcAHdmxaJM4YHTNAdFELa2y0VTHO
         xCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703834; x=1742308634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svxKIDRT3Kb7eAMZEb1N1l4m5wu9uJL8REG1UUG/0yE=;
        b=FJOmZAmbAejNOKDpWgVK2x7PfSAFj4ZoWmFWc8ffEApbx/6I6CrYAfIW4Vg9scxE7n
         WWAaHOmm5Y2F5Vy18OTGkmZYYsTKS8ad2fDIr4oP6F0Gf7Rx4CX2YC2ukzLd1muGtZzZ
         a3D1wZy/ey5ORUzUaiVIDG0CtXcEXLFgHkRZBJ1xpDi+vD5MA53dHpHsXNEWlPEVUyOU
         JjjGE0SqBMwyK8+kOccXoK+dhvPjdNf5psTkYqGBoWw/Ehe0heKgRZCgGXpUfzCcZsZy
         rF6/CcBH8hxN3337PifA2wWFPVlELRQQj3U70V/eFuDTcDg7jZ8gkWLar/PoQSFOmeTH
         j6sg==
X-Forwarded-Encrypted: i=1; AJvYcCVSffChNjRHFySQdeN2aTcf0ClNrw5fJ2k+/JWK0vZPD06G3N/aDav3iSXO73OSSeaiIu3RsNS4BntYLHmn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0o8OgsMExPZYC/2Sfj0c1Ns1tCXQXb42tIb1nYfE8x7g8CvP
	dez8unExMA3LyoPwxnwKLcfzS3lcvYBi4Kh30SKa/4hlTbfGxpfAT7l6aqkcWrPjlA9rAdq+bBx
	aOIr9rJ/gQG3lohy1TUmo0NjqGOQ=
X-Gm-Gg: ASbGncsqFmjc2I/2qBBCzOayYnIruWBY5bAs8BguqoM+3BU0BocjGBWnzj2NI8EPOVS
	HltC+yfZ912VCuhHvDA9zULRRnuJ4qeFYX7sd9dfDBhAQzKbFrYfoLrmzoz6beiS+9JcP+PEw3z
	UdOPeujOYgRAiWbyleb62cANVm2g==
X-Google-Smtp-Source: AGHT+IEhgsUwtx8B3t+G5I7EKANSdqGqBgWaNRu1x3GPRnN57zuOK7yF0dBQD4PgOkRBb/lCTdCmIC5/Z4v6zn75PyY=
X-Received: by 2002:a17:906:e248:b0:ac2:7cf9:7193 with SMTP id
 a640c23a62f3a-ac27cf9735emr1279341366b.48.1741703833450; Tue, 11 Mar 2025
 07:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311114153.1763176-1-amir73il@gmail.com> <20250311114153.1763176-2-amir73il@gmail.com>
 <a4e89300-f2ba-429f-98e0-1b136189b7e6@lucifer.local>
In-Reply-To: <a4e89300-f2ba-429f-98e0-1b136189b7e6@lucifer.local>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 11 Mar 2025 15:37:01 +0100
X-Gm-Features: AQ5f1Jot3mFwAJhU-q_yavEzpISeSVHa9VTK3k0o07533mwgAs0ZJc0ueN0hQYo
Message-ID: <CAOQ4uxi_M4DZydxq=nWrj=Z3z++Xh5ULe0Xcta58YP72h39OuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsnotify: add pre-content hooks on mmap()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 1:34=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Mar 11, 2025 at 12:41:52PM +0100, Amir Goldstein wrote:
> > Pre-content hooks in page faults introduces potential deadlock of HSM
> > handler in userspace with filesystem freezing.
> >
> > The requirement with pre-content event is that for every accessed file
> > range an event covering at least this range will be generated at least
> > once before the file data is accesses.
> >
> > In preparation to disabling pre-content event hooks on page faults,
> > change those hooks to always use the mask MAY_ACCESS and add pre-conten=
t
> > hooks at mmap() variants for the entire mmaped range, so HSM can fill
> > content when user requests to map a portion of the file.
> >
> > Note that exec() variant also calls vm_mmap_pgoff() internally to map
> > code sections, so pre-content hooks are also generated in this case.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x=
4aw275patsb3krkwuq573yv@o2hskrfawbnc/
> > Suggested-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  mm/filemap.c |  3 +--
> >  mm/mmap.c    | 12 ++++++++++++
> >  mm/util.c    |  7 +++++++
> >  3 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 2974691fdfad2..f85d288209b44 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3350,7 +3350,6 @@ static vm_fault_t filemap_fault_recheck_pte_none(=
struct vm_fault *vmf)
> >  vm_fault_t filemap_fsnotify_fault(struct vm_fault *vmf)
> >  {
> >       struct file *fpin =3D NULL;
> > -     int mask =3D (vmf->flags & FAULT_FLAG_WRITE) ? MAY_WRITE : MAY_AC=
CESS;
> >       loff_t pos =3D vmf->pgoff >> PAGE_SHIFT;
> >       size_t count =3D PAGE_SIZE;
> >       int err;
> > @@ -3370,7 +3369,7 @@ vm_fault_t filemap_fsnotify_fault(struct vm_fault=
 *vmf)
> >       if (!fpin)
> >               return VM_FAULT_SIGBUS;
> >
> > -     err =3D fsnotify_file_area_perm(fpin, mask, &pos, count);
> > +     err =3D fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos, count);
> >       fput(fpin);
> >       if (err)
> >               return VM_FAULT_SIGBUS;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index cda01071c7b1f..70318936fd588 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> >  #include <linux/memfd.h>
> > +#include <linux/fsnotify.h>
> >
> >  #include <linux/uaccess.h>
> >  #include <asm/cacheflush.h>
> > @@ -1151,6 +1152,17 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long,=
 start, unsigned long, size,
>
> I kind of hate that we keep on extending this deprecate syscall. Is it
> truly necessary here?
>

If my understanding of remap_file_pages() is correct then no new regions of=
 the
file are being mapped - so no, my bad - the pre-content hook is not
needed in this case.


> >               return ret;
> >       }
> >
> > +     if (file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
>
> Is there a circumstance where file =3D=3D NULL here? I mean get_file()
> literally dereferences a field then returns the pointer, so that'd be a
> null pointer deref?
>
> Also I'm pretty sure it's impossible possible for a VMA to be VM_SHARED a=
nd
> !vma->vm_file, since we need to access the address_space etc.
>
> > +             int mask =3D (prot & PROT_WRITE) ? MAY_WRITE : MAY_READ;
> > +             loff_t pos =3D pgoff >> PAGE_SHIFT;
> > +
> > +             ret =3D fsnotify_file_area_perm(file, mask, &pos, size);
>
> All other invocations of this in fs code, this further amplifies my belie=
f
> that this belongs in fs code.
>
> > +             if (ret) {
> > +                     fput(file);
> > +                     return ret;
> > +             }
> > +     }
> > +
> >       ret =3D -EINVAL;
> >
> >       /* OK security check passed, take write lock + let it rip. */
> > diff --git a/mm/util.c b/mm/util.c
> > index b6b9684a14388..2dddeabac6098 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/processor.h>
> >  #include <linux/sizes.h>
> >  #include <linux/compat.h>
> > +#include <linux/fsnotify.h>
> >
> >  #include <linux/uaccess.h>
> >
> > @@ -569,6 +570,12 @@ unsigned long vm_mmap_pgoff(struct file *file, uns=
igned long addr,
> >       LIST_HEAD(uf);
> >
> >       ret =3D security_mmap_file(file, prot, flag);
> > +     if (!ret && file && unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
> > +             int mask =3D (prot & PROT_WRITE) ? MAY_WRITE : MAY_READ;
> > +             loff_t pos =3D pgoff >> PAGE_SHIFT;
> > +
> > +             ret =3D fsnotify_file_area_perm(file, mask, &pos, len);
> > +     }
> >       if (!ret) {
> >               if (mmap_write_lock_killable(mm))
> >                       return -EINTR;
>
> You've duplicated this code in 2 places, can we please just have it in on=
e
> as a helper function?
>
> Also I'm not a fan of having super-specific file system code relating to
> HSM in general mapping code like this. Can't we have something like a hoo=
k
> or something more generic?
>
> I mean are we going to keep on expanding this for other super-specific
> cases?
>
> I would say refactor this whole thing into a check that's done in fs code
> that we can call into.
>
> If we need a new hook, then let's add one. If we can use existing hooks,
> let's use them.
>

fsnotify hooks and logic have traditionally been contained in fsnotify.h
wrappers much like the security_ hooks.

For the page fault hooks, Linus asked for the FMODE_FSNOTIFY_HSM
condition to be very visible and explicit, but I suppose there is no reason
for not having a fsnotify_mmap() wrapper here.

> Also, is it valid to be accessing this file without doing a get_file()
> here?

Caller of vm_mmap_pgoff() should have a reference on file.

> It seems super inconsistent you increment ref count in one place but
> not the other?

By other place do you mean in remap_file_pages()?
There, the file reference is coming from vma->vm_file and hook is called
outside mmap lock.

Thanks,
Amir.

