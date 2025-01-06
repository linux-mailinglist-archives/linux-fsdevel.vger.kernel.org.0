Return-Path: <linux-fsdevel+bounces-38463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2799A02F1A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEF5163490
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE351DEFD6;
	Mon,  6 Jan 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xj2SGU2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182E1DE8A3
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184923; cv=none; b=DoA6QcXg9tp8Hyhzg+ZeBbPi7ipwVXtSPBMeX6JiuusvuLTeGJSJkDCXRkBHw6oJ4jLdUpre8MGfPfsG1G04G6h0d+KD0rzWqZFYawhtmmrIJKAJgsnJe5P1he8bU7TgkG19fV7UqUbNVSqm9JTfOgU/PesW05EJaktxlf74ghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184923; c=relaxed/simple;
	bh=8BEZwuWRp3CLOKaQlLqswK7jHoXgsvrQnBN+biv/YfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jdspvtr9lgZaIHS7dw3FgT6hf551DWX27d9Tv1Pvhc40DytrJPPzdXCmEnqZQYir8w0bo4Y6i+dRSul9d9I6S9HkQgcz5uCj3uC6BqcGdw0RaABG8NWbgmDNos8XwsQegp/PJg7dQu4fk86/KZTXFI/KAqe7zNr7qmcv1ph4C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xj2SGU2D; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29fd8fed5bcso1305274fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 09:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736184921; x=1736789721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKp7aPmOTHvMER9QV0OoIt9TQh4BPYke1ArM9VzzgAw=;
        b=Xj2SGU2D9dTVOOOJYlckrGQrutsOZAC602S4YfG7tsAarm4jTzc2Kiq5hoblOhFRWE
         RzsFw6RPJhtBc4UGknFQsXRWgC4ewQlf6Gfon52165mFVF9zYVmliEfF5SZNOA/NVfge
         7ABu8q51foOKSt+v4Apt28/rncAZwqXicPbcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736184921; x=1736789721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKp7aPmOTHvMER9QV0OoIt9TQh4BPYke1ArM9VzzgAw=;
        b=jg/xmnL9Ff3jt0i+KRgujH8EKlBk+3lrIY6AnyDFZMVRijIm9xGZoqHCPP2kzz+HGf
         nZD/PCUd+7wD3wF8IjeLwSpatksXptks8yf+GlQqJ6TNYFFpLopFYEFm/mwcUpcr6E6J
         tEKFayhZcRJSxyCMMIRTTl1oq31s6Gu6ZpdSXE348ucQ7PXVW6NEyWjiY3Y2mqhFcagf
         yOeIrG2FuIfl6yqIpKFRKd9uZnPh2mfFxkjqohx2DRq1OMIpYgJEoYeYaJA7UigU5FFn
         FVR7BzQqJx3WrOaaW3aBnxSO/ezUUCQfxxJd0wEh4aTw6hHQPEcM61bWuRi4mDIesr/R
         qVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCViGyrV7lh8ZM+KKtEvKGwdLwLyjkFqG2DzKN+iGsgBM9mq5Yq1F00QukT1aw5FV3a/jDRO5ansYvwMd90V@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwGfCA425UCs9iEgChA8XOW/1nQ8ZOjOJkcCGnFnh/pk3K44K
	NuT61oqs/qtYQwYLJQWxj+shFJsRovM9zPHag503N7b3xRTbxSuos9sxG6B3+hIBg5OJl44b+sA
	+ZpEg88BtUw8RY26zJ5rCnvqzX4L6U2ksMx1I
X-Gm-Gg: ASbGncvCdsJO7Hu7tobunRJtGgtw5bodOq8/BqrwdSHHDFIGMMh/XeOzTpgFfJun8C3
	v+HpIdhwubXWl7Pqm7F0H0LNVhGcd5Tx8eVh41w5jXMqOMTmF/CRY7YAmaZfiOFuDsGc=
X-Google-Smtp-Source: AGHT+IFKUMHqJMC7OwYbzyAXF8vzNPgoUNTgojG07VvQbtPqbUNXWJfoqydAkiw3Lx9C8McHpEeXmpt31qs2elbcKE0=
X-Received: by 2002:a05:6870:9a21:b0:29e:49f7:f456 with SMTP id
 586e51a60fabf-2a7fb16cf2amr10241213fac.7.1736184921130; Mon, 06 Jan 2025
 09:35:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com> <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
In-Reply-To: <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 6 Jan 2025 09:35:09 -0800
Message-ID: <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
To: Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, lorenzo.stoakes@oracle.com, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, surenb@google.com, kaleshsingh@google.com, 
	jstultz@google.com, aliceryhl@google.com, jeffxu@google.com, kees@kernel.org, 
	kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Kees because this is related to W^X memfd and security.

On Fri, Jan 3, 2025 at 7:04=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Jan 3, 2025 at 12:32=E2=80=AFAM Isaac J. Manjarres
> <isaacmanjarres@google.com> wrote:
> > Android currently uses the ashmem driver [1] for creating shared memory
> > regions between processes. Ashmem buffers can initially be mapped with
> > PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> > ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> > permissions that the buffer can be mapped with.
> >
> > Processes can remove the ability to map ashmem buffers as executable to
> > ensure that those buffers cannot be exploited to run unintended code.
>
> Is there really code out there that first maps an ashmem buffer with
> PROT_EXEC, then uses the ioctl to remove execute permission for future
> mappings? I don't see why anyone would do that.
>
> > For instance, suppose process A allocates a memfd that is meant to be
> > read and written by itself and another process, call it B.
> >
> > Process A shares the buffer with process B, but process B injects code
> > into the buffer, and compromises process A, such that it makes A map
> > the buffer with PROT_EXEC. This provides an opportunity for process A
> > to run the code that process B injected into the buffer.
> >
> > If process A had the ability to seal the buffer against future
> > executable mappings before sharing the buffer with process B, this
> > attack would not be possible.
>
> I think if you want to enforce such restrictions in a scenario where
> the attacker can already make the target process perform
> semi-arbitrary syscalls, it would probably be more reliable to enforce
> rules on executable mappings with something like SELinux policy and/or
> F_SEAL_EXEC.
>
I would like to second on the suggestion of  making this as part of F_SEAL_=
EXEC.

> > Android is currently trying to replace ashmem with memfd. However, memf=
d
> > does not have a provision to permanently remove the ability to map a
> > buffer as executable, and leaves itself open to the type of attack
> > described earlier. However, this should be something that can be
> > achieved via a new file seal.
> >
> > There are known usecases (e.g. CursorWindow [2]) where a process
> > maps a buffer with read/write permissions before restricting the buffer
> > to being mapped as read-only for future mappings.
>
> Here you're talking about write permission, but the patch is about
> execute permission?
>
> > The resulting VMA from the writable mapping has VM_MAYEXEC set, meaning
> > that mprotect() can change the mapping to be executable. Therefore,
> > implementing the seal similar to F_SEAL_WRITE would not be appropriate,
> > since it would not work with the CursorWindow usecase. This is because
> > the CursorWindow process restricts the mapping permissions to read-only
> > after the writable mapping is created. So, adding a file seal for
> > executable mappings that operates like F_SEAL_WRITE would fail.
> >
> > Therefore, add support for F_SEAL_FUTURE_EXEC, which is handled
> > similarly to F_SEAL_FUTURE_WRITE. This ensures that CursorWindow can
> > continue to create a writable mapping initially, and then restrict the
> > permissions on the buffer to be mappable as read-only by using both
> > F_SEAL_FUTURE_WRITE and F_SEAL_FUTURE_EXEC. After the seal is
> > applied, any calls to mmap() with PROT_EXEC will fail.
> >
> > [1] https://cs.android.com/android/kernel/superproject/+/common-android=
-mainline:common/drivers/staging/android/ashmem.c
> > [2] https://developer.android.com/reference/android/database/CursorWind=
ow
> >
> > Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> > ---
> >  include/uapi/linux/fcntl.h |  1 +
> >  mm/memfd.c                 | 39 +++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index 6e6907e63bfc..ef066e524777 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -49,6 +49,7 @@
> >  #define F_SEAL_WRITE   0x0008  /* prevent writes */
> >  #define F_SEAL_FUTURE_WRITE    0x0010  /* prevent future writes while =
mapped */
> >  #define F_SEAL_EXEC    0x0020  /* prevent chmod modifying exec bits */
> > +#define F_SEAL_FUTURE_EXEC     0x0040 /* prevent future executable map=
pings */
> >  /* (1U << 31) is reserved for signed error codes */
> >
> >  /*
> > diff --git a/mm/memfd.c b/mm/memfd.c
> > index 5f5a23c9051d..cfd62454df5e 100644
> > --- a/mm/memfd.c
> > +++ b/mm/memfd.c
> > @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct fi=
le *file)
> >  }
> >
> >  #define F_ALL_SEALS (F_SEAL_SEAL | \
> > +                    F_SEAL_FUTURE_EXEC |\
> >                      F_SEAL_EXEC | \
> >                      F_SEAL_SHRINK | \
> >                      F_SEAL_GROW | \
> > @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_fla=
gs_ptr)
> >         return 0;
> >  }
> >
> > +static inline bool is_exec_sealed(unsigned int seals)
> > +{
> > +       return seals & F_SEAL_FUTURE_EXEC;
> > +}
> > +
> > +static int check_exec_seal(unsigned long *vm_flags_ptr)
> > +{
> > +       unsigned long vm_flags =3D *vm_flags_ptr;
> > +       unsigned long mask =3D vm_flags & (VM_SHARED | VM_EXEC);
> > +
> > +       /* Executability is not a concern for private mappings. */
> > +       if (!(mask & VM_SHARED))
> > +               return 0;
>
> Why is it not a concern for private mappings?
>
> > +       /*
> > +        * New PROT_EXEC and MAP_SHARED mmaps are not allowed when exec=
 seal
> > +        * is active.
> > +        */
> > +       if (mask & VM_EXEC)
> > +               return -EPERM;
> > +
> > +       /*
> > +        * Prevent mprotect() from making an exec-sealed mapping execut=
able in
> > +        * the future.
> > +        */
> > +       *vm_flags_ptr &=3D ~VM_MAYEXEC;
> > +
> > +       return 0;
> > +}
> > +
> >  int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_=
ptr)
> >  {
> >         int err =3D 0;
> >         unsigned int *seals_ptr =3D memfd_file_seals_ptr(file);
> >         unsigned int seals =3D seals_ptr ? *seals_ptr : 0;
> >
> > -       if (is_write_sealed(seals))
> > +       if (is_write_sealed(seals)) {
> >                 err =3D check_write_seal(vm_flags_ptr);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       if (is_exec_sealed(seals))
> > +               err =3D check_exec_seal(vm_flags_ptr);
> >
memfd_check_seals_mmap is only for mmap() path, right ?

How about the mprotect()  path ? i.e.  An attacker can first create a
RW VMA mapping for the memfd and later mprotect the VMA to be
executable.

Similar to the check_write_seal call , we might want to block mprotect
for write seal as well.

> >         return err;
> >  }
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >
> >
> >
>

