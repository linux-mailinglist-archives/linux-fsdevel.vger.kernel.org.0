Return-Path: <linux-fsdevel+bounces-38544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F4A0374F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 06:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6E01649D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 05:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603219F41B;
	Tue,  7 Jan 2025 05:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QdEDDhuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750D1419A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736227306; cv=none; b=lb8HUpg9v63SveC/V8IelIipkHEf6vPZR/FrUgAbUmdXiZjhienlkwNjSnK04tDl2BDbGVrEvaRPr+WbKMaiLLKeEgeNWPu2skx3mqCptvEUbNEcvXt211aqsJ2a3Xd43lkfPRiJsZsDAJyz1t4Sdu4KAV285bldzEC0a4GIu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736227306; c=relaxed/simple;
	bh=l0k9n+CMuIz8X3gB0i3jLHqOsRXxD3L5HHwF6j8M+I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAf3IE7ctCCZqDSNjJbwDa3ek9Y2r9s6Ejc7Jb+vmsbHeSx1RBaxtq58ldolLG2BjZWlfmYzGH7plgB7MxIWf6VaxXVhHuWtpZGS6PRkIdZo0kKrgp2qzx4NYFBftCKwf1echpFPbL0lHsj53Ezi4r8/rwdUnmOTkUxqwMi/j9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QdEDDhuc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68f1bso2723579a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 21:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736227303; x=1736832103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKwyl6OspyjnQcfr2q/vOIDXkwuARjFY2nz+F+nCUfA=;
        b=QdEDDhucnIeWolUPnWKeuxSD14KtanFPZdJPqsqO2QUtvyevPDX5ICMElJZaRfDqaC
         DI2e6gAW0nuUn3YbQcLF/40Q/dHJh2to7PdDajrJyoCNhr+rKIFye1N1CAcyhShEqbX0
         e6wwa0bAgsYtuwCNvxcXXEWyx5KUazcYivVjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736227303; x=1736832103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKwyl6OspyjnQcfr2q/vOIDXkwuARjFY2nz+F+nCUfA=;
        b=aCOSjct37/DyHJG+5Zzy6nRixPAjX4auIXlwpPkgQTr0jkfj0MmfJzfcb0rUwiLfQa
         RQuaOxp8IhwMcudyr69Zz+Vu61KdxYvPRQ0VHvUr+C5dK9P9Ayk1mXykxP64wSDdd4kW
         HEdiAn7j/89qFfvBDaMy0oiPTn2DE5sjpCzXb9ee9ivgEwCmbBYwoFtWSQTcQsiGnNvc
         NVh/DZifI4QwkJ5hllsUvgDHqFm6K4f/4E3RT80QYfCxH8/cIAX5WwwylNhGVQSUoAZ8
         Gh/1AumYnB2jC1uHww/W18B2ZvkReA0kpU9/WlKfK5HlpMScqR4zs4UmU/iVpQoPFUSN
         MYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzSE4Sf5A10Zq7sazMPxK7sWqZDlwrXiarVgSdyy2KMKn6OoYRICJreEGTn4POe9ZRyysrMDu9TpTrQ3m2@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkAT96DhLFqepHMKQp8v2idIcte7jwofF/F4v38RXiOguX320
	yw228I9MsadTH3fJzhkOBqT3HoBOCU536MtyGRrl3uywJhFNc15sumw2pbIr3kX1utydVb44Ywt
	G9cN+ZkcUvIyNUSkjyUhONmeyl+bdOpbH66Lk
X-Gm-Gg: ASbGncse7r8TIpsoQYlskCaiWGbIz32+5/X500XwDrYKE0KdZfFGzAY2baY+Znx8fCS
	wDTnk3Qk0vBphPEAS1sFpDX089cEGXxzxhtsLSZYPyAd4FIt4l9cmWKGGR2xHRZZg6JscYBw=
X-Google-Smtp-Source: AGHT+IEOY1MZJnyKNAdXNSNwfdgEXEFTpg5dwbP9keiatuo2YFaXoHoheAn4YeaED3xrB/ozQ7bs7NxX2BNTDbJdnEU=
X-Received: by 2002:a05:6402:268c:b0:5d0:ccce:34b7 with SMTP id
 4fb4d7f45d1cf-5d81ddf8113mr19983213a12.6.1736227302959; Mon, 06 Jan 2025
 21:21:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com> <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com> <Z3yCzcpTHnW671WL@google.com>
In-Reply-To: <Z3yCzcpTHnW671WL@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 6 Jan 2025 21:21:25 -0800
Message-ID: <CABi2SkUVZKjtGCJ+rvYbma4OGY_zQP2U3KtPjqVNMnAfoHxYDA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, lorenzo.stoakes@oracle.com, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 5:26=E2=80=AFPM Isaac Manjarres
<isaacmanjarres@google.com> wrote:
>
> On Mon, Jan 06, 2025 at 09:35:09AM -0800, Jeff Xu wrote:
> > + Kees because this is related to W^X memfd and security.
> >
> > On Fri, Jan 3, 2025 at 7:04=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> > >
> > > On Fri, Jan 3, 2025 at 12:32=E2=80=AFAM Isaac J. Manjarres
> > > <isaacmanjarres@google.com> wrote:
> > > > Android currently uses the ashmem driver [1] for creating shared me=
mory
> > > > regions between processes. Ashmem buffers can initially be mapped w=
ith
> > > > PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> > > > ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> > > > permissions that the buffer can be mapped with.
> > > >
> > > > Processes can remove the ability to map ashmem buffers as executabl=
e to
> > > > ensure that those buffers cannot be exploited to run unintended cod=
e.
> > >
> > > Is there really code out there that first maps an ashmem buffer with
> > > PROT_EXEC, then uses the ioctl to remove execute permission for futur=
e
> > > mappings? I don't see why anyone would do that.
> > >
> > > > For instance, suppose process A allocates a memfd that is meant to =
be
> > > > read and written by itself and another process, call it B.
> > > >
> > > > Process A shares the buffer with process B, but process B injects c=
ode
> > > > into the buffer, and compromises process A, such that it makes A ma=
p
> > > > the buffer with PROT_EXEC. This provides an opportunity for process=
 A
> > > > to run the code that process B injected into the buffer.
> > > >
> > > > If process A had the ability to seal the buffer against future
> > > > executable mappings before sharing the buffer with process B, this
> > > > attack would not be possible.
> > >
> > > I think if you want to enforce such restrictions in a scenario where
> > > the attacker can already make the target process perform
> > > semi-arbitrary syscalls, it would probably be more reliable to enforc=
e
> > > rules on executable mappings with something like SELinux policy and/o=
r
> > > F_SEAL_EXEC.
> > >
> > I would like to second on the suggestion of  making this as part of F_S=
EAL_EXEC.
>
> Thanks for taking a look at this patch Jeff! Can you please elaborate
> some more on how F_SEAL_EXEC should be extended to restricting executable
> mappings?
>
> I understand that if a memfd file is non-executable (either because it
> was made non-executable via fchmod() or by being created with
> MFD_NOEXEC_SEAL) one could argue that applying F_SEAL_EXEC to that file
> would also mean preventing any executable mappings. However, it is not
> clear to me if we should tie a file's executable permissions to whether
> or not if it can be mapped as executable. For example, shared object
> files don't have to have executable permissions, but processes should
> be able to map them as executable.
>
> The case where we apply F_SEAL_EXEC on an executable memfd also seems
> awkward to me, since memfds can be mapped as executable by default
> so what would happen in that scenario?
>
> I also shared the same concerns in my response to Jann in [1].
>
Apology  for not being clear. I meant this below:
when
1> memfd is created with MFD_NOEXEC_SEAL or
2> memfd is no-exec (NX)  and F_SEAL_EXEC is set.
We could also block the memfd from being mapped as executable.

MFD_NOEXEC_SEAL/F_SEAL_EXEC  is added in 6fd7353829ca, which is about
2 years old, I m not sure any application uses the case of creating a
MFD_NOEXEC_SEAL memfd and still wants to mmap it as executable memory,
that is a strange user case.  It is more logical that  applications
want to block both execve() and mmap() for a non-executable memfd.
Therefore I think we could reuse the F_SEAL_EXEC bit + NX state for
this feature, for simplicity.

> > > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > > index 5f5a23c9051d..cfd62454df5e 100644
> > > > --- a/mm/memfd.c
> > > > +++ b/mm/memfd.c
> > > > @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struc=
t file *file)
> > > >  }
> > > >
> > > >  #define F_ALL_SEALS (F_SEAL_SEAL | \
> > > > +                    F_SEAL_FUTURE_EXEC |\
> > > >                      F_SEAL_EXEC | \
> > > >                      F_SEAL_SHRINK | \
> > > >                      F_SEAL_GROW | \
> > > > @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm=
_flags_ptr)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static inline bool is_exec_sealed(unsigned int seals)
> > > > +{
> > > > +       return seals & F_SEAL_FUTURE_EXEC;
> > > > +}
> > > > +
> > > > +static int check_exec_seal(unsigned long *vm_flags_ptr)
> > > > +{
> > > > +       unsigned long vm_flags =3D *vm_flags_ptr;
> > > > +       unsigned long mask =3D vm_flags & (VM_SHARED | VM_EXEC);
> > > > +
> > > > +       /* Executability is not a concern for private mappings. */
> > > > +       if (!(mask & VM_SHARED))
> > > > +               return 0;
> > >
> > > Why is it not a concern for private mappings?
> > >
> > > > +       /*
> > > > +        * New PROT_EXEC and MAP_SHARED mmaps are not allowed when =
exec seal
> > > > +        * is active.
> > > > +        */
> > > > +       if (mask & VM_EXEC)
> > > > +               return -EPERM;
> > > > +
> > > > +       /*
> > > > +        * Prevent mprotect() from making an exec-sealed mapping ex=
ecutable in
> > > > +        * the future.
> > > > +        */
> > > > +       *vm_flags_ptr &=3D ~VM_MAYEXEC;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > >  int memfd_check_seals_mmap(struct file *file, unsigned long *vm_fl=
ags_ptr)
> > > >  {
> > > >         int err =3D 0;
> > > >         unsigned int *seals_ptr =3D memfd_file_seals_ptr(file);
> > > >         unsigned int seals =3D seals_ptr ? *seals_ptr : 0;
> > > >
> > > > -       if (is_write_sealed(seals))
> > > > +       if (is_write_sealed(seals)) {
> > > >                 err =3D check_write_seal(vm_flags_ptr);
> > > > +               if (err)
> > > > +                       return err;
> > > > +       }
> > > > +
> > > > +       if (is_exec_sealed(seals))
> > > > +               err =3D check_exec_seal(vm_flags_ptr);
> > > >
> > memfd_check_seals_mmap is only for mmap() path, right ?
> >
> > How about the mprotect()  path ? i.e.  An attacker can first create a
> > RW VMA mapping for the memfd and later mprotect the VMA to be
> > executable.
> >
> > Similar to the check_write_seal call , we might want to block mprotect
> > for write seal as well.
> >
>
> So when memfd_check_seals_mmap() is called, if the file is exec_sealed,
> check_exec_seal() will not only just check that VM_EXEC is not set,
> but it will also clear VM_MAYEXEC, which will prevent the mapping from
> being changed to executable via mprotect() later.
>
Thanks for clarification.

The name of check_exec_seal() is misleading , check implies a read
operation, but this function actually does update. Maybe renaming to
check_and_update_exec_seal or something like that ?

Do you know which code checks for VM_MAYEXEC flag in the mprotect code
path ?  it isn't obvious to me, i.e. when I grep the VM_MAYEXEC inside
mm path, it only shows one place in mprotect and that doesn't do the
work.

~/mm/mm$ grep VM_MAYEXEC *
mmap.c: mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
mmap.c: vm_flags &=3D ~VM_MAYEXEC;
mprotect.c: if (rier && (vma->vm_flags & VM_MAYEXEC))
nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
nommu.c: vm_flags |=3D VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

Thanks
-Jeff




> [1] https://lore.kernel.org/all/Z3x_8uFn2e0EpDqM@google.com/
>
> Thanks,
> Isaac

