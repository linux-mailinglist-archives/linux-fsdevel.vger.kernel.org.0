Return-Path: <linux-fsdevel+bounces-38508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F57A03485
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E0807A184C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 01:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6367082B;
	Tue,  7 Jan 2025 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZvagTuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00E22331
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213206; cv=none; b=tZr8adQS/NjPNgfL/rpV9m/7MnuxZ+5AM2hAN90GceQNJx2TgX03Icnz/S/7ZsqMPJb0OGH72w74MGP4td0DK/RM4ML/jSisvaeMAPu1b0H6lALJQpg5cPOdBe5giwHgoMPah6GZYIyxMLnoByrRj72Mnotd+hUcPYpU2Sd9kZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213206; c=relaxed/simple;
	bh=KO50LlfdJt2i4wpFMI9ThGGSdZBM4MjXb0cipiAo8Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZ+96amK2Jil26z84ulkoUDOTbqj5osNGB+ttEAMpsTqxoYTz1n1VE4lzEwXgMUyMmXvqaeZ2MXPb3axq5Ghgy6aChJRGrpRa/LK6mR0I8xYdbsECCyJ1jZIeumAAyc1mD0IjAhghyDoo9Itejhz+oF5IF5KsDd2qCzThepa6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZvagTuP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-215740b7fb8so65675ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 17:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736213204; x=1736818004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M372tjeIGF/B6j8tuFkO5rd4a50LQoTcJMIW9ilW1lM=;
        b=vZvagTuP8r+HNK6NdI850DtIW8e5+OtML0dWMCivm8BHVgkEMjYEa0haHCrLRpNKWV
         pP9L0PFBQ46BPeG0N8j2RckZ6AqwAzK31Rs0uYG8TJUvoKdonSu9YXAExIkn+9Z4P2G/
         NcMmz4bRTyGMjJSBWxnkrsVRz5RfN8AOoWdT6y99pyKjQN77xx1IZzUjupp22VtxySqZ
         EP+arA5mWDEoHkivXNDHXhzDBlilt6t+kVVSdxwRpoProZZuEyDui2MPNTtzO4vcysYj
         qialLhu1SbDXCHXRw916yaZcN0jLhy+zNYIL7KwVUeFVXcLRhMQoKkoXK7O71MdSRiZl
         FCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736213204; x=1736818004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M372tjeIGF/B6j8tuFkO5rd4a50LQoTcJMIW9ilW1lM=;
        b=P0MFCRgUgJjBuagy6DyvWLnA0GtAKrquiZKEHwwWRmStYdeUsgYbUxqEwOV+BM+1Yr
         H/DbzxWFI/8YYOZYXXbVskxUMcR3UYz54PX2DLyWTEQ8djbDG0BmUXBe5ZA7NNfOrshv
         ARcwfEvQT1RqSL8CyMHDc1zW7z3tj/N/EU2y+MFr28MnqsnsOIYS3Em7PemYwNLbN8FU
         Ap7DTxvZw011h6xcj1M4ytlGAE5MFF0nN0qLQLf4LOsF29Y4VpwbKKNwIrcBI/i9RTS3
         XYr8PG+TIF8Ew9BHFFp+fIVRL8FzYh+Xf1wzIoIqiirgU9a5yHeWpbwaGvuysO/ycXKJ
         cLyg==
X-Forwarded-Encrypted: i=1; AJvYcCVoyCLkK1nDXUMWs5x7gQld/ku8LawuhiDgk5iZp4ox5qKvISz0uPJj7SOWlUPQtqY3Fh30W3qglRTUqvQf@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDAqQ4fzUUBotae6Pgmmar/LSJhebBiOJ5MhnMBdY2RlNECYO
	lXpVwPTyjxd+e5TufU/oie8qZ0Qfiw4b/oIzQT8ojWYpZsICo8bucmsHG2XhRg==
X-Gm-Gg: ASbGncuSpxnAffMWwTNqXE5v6y/Zo05Difx5kIqfGaZ5FQ88nQbQeQCDLILE5SXCKJ1
	z2ViViMEKMoSUmh7F230TX7Elh5vzSmjP+g+zZHjCtRW6iEj0wMrRh2S4EPNwLatHypEf9sVIwe
	3SqmSmnXNMvmzzkgEclrOmq8C0pgG7Wj3ve825t9CzpIyrP7M7kzSVTwX5uDtShNZ2kmkbJOiB/
	bWvYatjtU+BQkPsimWkWPLJHInMPo8dqxQ4bKzsVUeZuCt/Pi57nEqV
X-Google-Smtp-Source: AGHT+IFUje41UqMGChKWwoUXHu8SMmzrXD2rW9ZDvE3vXGz/NkrxhtzEWY6tO9tH8NrLIu1jBzPmiQ==
X-Received: by 2002:a17:902:e849:b0:216:48d4:b3a8 with SMTP id d9443c01a7336-21a7acca8ddmr1058805ad.16.1736213202325;
        Mon, 06 Jan 2025 17:26:42 -0800 (PST)
Received: from google.com ([2620:15c:2d:3:42b3:1d33:ab4b:8279])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb70sm32188398b3a.98.2025.01.06.17.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 17:26:41 -0800 (PST)
Date: Mon, 6 Jan 2025 17:26:37 -0800
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
	lorenzo.stoakes@oracle.com, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, surenb@google.com,
	kaleshsingh@google.com, jstultz@google.com, aliceryhl@google.com,
	jeffxu@google.com, kees@kernel.org, kernel-team@android.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH RESEND v2 1/2] mm/memfd: Add support for
 F_SEAL_FUTURE_EXEC to memfd
Message-ID: <Z3yCzcpTHnW671WL@google.com>
References: <20250102233255.1180524-1-isaacmanjarres@google.com>
 <20250102233255.1180524-2-isaacmanjarres@google.com>
 <CAG48ez2q_V_cOu8O_mor8WCt7GaC47baYQgjisP=KDzkxkqR1Q@mail.gmail.com>
 <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkVmdxuETrgucYA2RucV3D4UoaPkDrXZKvLGjfEGp1-v2A@mail.gmail.com>

On Mon, Jan 06, 2025 at 09:35:09AM -0800, Jeff Xu wrote:
> + Kees because this is related to W^X memfd and security.
> 
> On Fri, Jan 3, 2025 at 7:04 AM Jann Horn <jannh@google.com> wrote:
> >
> > On Fri, Jan 3, 2025 at 12:32 AM Isaac J. Manjarres
> > <isaacmanjarres@google.com> wrote:
> > > Android currently uses the ashmem driver [1] for creating shared memory
> > > regions between processes. Ashmem buffers can initially be mapped with
> > > PROT_READ, PROT_WRITE, and PROT_EXEC. Processes can then use the
> > > ASHMEM_SET_PROT_MASK ioctl command to restrict--never add--the
> > > permissions that the buffer can be mapped with.
> > >
> > > Processes can remove the ability to map ashmem buffers as executable to
> > > ensure that those buffers cannot be exploited to run unintended code.
> >
> > Is there really code out there that first maps an ashmem buffer with
> > PROT_EXEC, then uses the ioctl to remove execute permission for future
> > mappings? I don't see why anyone would do that.
> >
> > > For instance, suppose process A allocates a memfd that is meant to be
> > > read and written by itself and another process, call it B.
> > >
> > > Process A shares the buffer with process B, but process B injects code
> > > into the buffer, and compromises process A, such that it makes A map
> > > the buffer with PROT_EXEC. This provides an opportunity for process A
> > > to run the code that process B injected into the buffer.
> > >
> > > If process A had the ability to seal the buffer against future
> > > executable mappings before sharing the buffer with process B, this
> > > attack would not be possible.
> >
> > I think if you want to enforce such restrictions in a scenario where
> > the attacker can already make the target process perform
> > semi-arbitrary syscalls, it would probably be more reliable to enforce
> > rules on executable mappings with something like SELinux policy and/or
> > F_SEAL_EXEC.
> >
> I would like to second on the suggestion of  making this as part of F_SEAL_EXEC.

Thanks for taking a look at this patch Jeff! Can you please elaborate
some more on how F_SEAL_EXEC should be extended to restricting executable
mappings?

I understand that if a memfd file is non-executable (either because it
was made non-executable via fchmod() or by being created with
MFD_NOEXEC_SEAL) one could argue that applying F_SEAL_EXEC to that file
would also mean preventing any executable mappings. However, it is not
clear to me if we should tie a file's executable permissions to whether
or not if it can be mapped as executable. For example, shared object
files don't have to have executable permissions, but processes should
be able to map them as executable.

The case where we apply F_SEAL_EXEC on an executable memfd also seems
awkward to me, since memfds can be mapped as executable by default
so what would happen in that scenario?

I also shared the same concerns in my response to Jann in [1].

> > > diff --git a/mm/memfd.c b/mm/memfd.c
> > > index 5f5a23c9051d..cfd62454df5e 100644
> > > --- a/mm/memfd.c
> > > +++ b/mm/memfd.c
> > > @@ -184,6 +184,7 @@ static unsigned int *memfd_file_seals_ptr(struct file *file)
> > >  }
> > >
> > >  #define F_ALL_SEALS (F_SEAL_SEAL | \
> > > +                    F_SEAL_FUTURE_EXEC |\
> > >                      F_SEAL_EXEC | \
> > >                      F_SEAL_SHRINK | \
> > >                      F_SEAL_GROW | \
> > > @@ -357,14 +358,50 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
> > >         return 0;
> > >  }
> > >
> > > +static inline bool is_exec_sealed(unsigned int seals)
> > > +{
> > > +       return seals & F_SEAL_FUTURE_EXEC;
> > > +}
> > > +
> > > +static int check_exec_seal(unsigned long *vm_flags_ptr)
> > > +{
> > > +       unsigned long vm_flags = *vm_flags_ptr;
> > > +       unsigned long mask = vm_flags & (VM_SHARED | VM_EXEC);
> > > +
> > > +       /* Executability is not a concern for private mappings. */
> > > +       if (!(mask & VM_SHARED))
> > > +               return 0;
> >
> > Why is it not a concern for private mappings?
> >
> > > +       /*
> > > +        * New PROT_EXEC and MAP_SHARED mmaps are not allowed when exec seal
> > > +        * is active.
> > > +        */
> > > +       if (mask & VM_EXEC)
> > > +               return -EPERM;
> > > +
> > > +       /*
> > > +        * Prevent mprotect() from making an exec-sealed mapping executable in
> > > +        * the future.
> > > +        */
> > > +       *vm_flags_ptr &= ~VM_MAYEXEC;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
> > >  {
> > >         int err = 0;
> > >         unsigned int *seals_ptr = memfd_file_seals_ptr(file);
> > >         unsigned int seals = seals_ptr ? *seals_ptr : 0;
> > >
> > > -       if (is_write_sealed(seals))
> > > +       if (is_write_sealed(seals)) {
> > >                 err = check_write_seal(vm_flags_ptr);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > > +
> > > +       if (is_exec_sealed(seals))
> > > +               err = check_exec_seal(vm_flags_ptr);
> > >
> memfd_check_seals_mmap is only for mmap() path, right ?
> 
> How about the mprotect()  path ? i.e.  An attacker can first create a
> RW VMA mapping for the memfd and later mprotect the VMA to be
> executable.
> 
> Similar to the check_write_seal call , we might want to block mprotect
> for write seal as well.
>

So when memfd_check_seals_mmap() is called, if the file is exec_sealed,
check_exec_seal() will not only just check that VM_EXEC is not set,
but it will also clear VM_MAYEXEC, which will prevent the mapping from
being changed to executable via mprotect() later.

[1] https://lore.kernel.org/all/Z3x_8uFn2e0EpDqM@google.com/

Thanks,
Isaac

