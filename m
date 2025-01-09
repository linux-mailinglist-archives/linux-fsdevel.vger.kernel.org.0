Return-Path: <linux-fsdevel+bounces-38764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8815AA0837A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 00:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BFC168E48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 23:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A75F205E31;
	Thu,  9 Jan 2025 23:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fc0ns/NQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FC1A3042
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736465450; cv=none; b=sxANt2YAlxRtSbcu6fh1l1hUIPiooNaE0vK3qMa/x9Q2KEAHxsWXnZ6dEPYBUHb+E2vYqM0YsEY+BY0T5w7WopMwo2J7U7nAK6rpRPnH6djnJQwIfVHf3rQ61ESwcKudZ/iBdRh6stwDPsvu9lNAKlYf4D9JN2gr8nKMubvWkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736465450; c=relaxed/simple;
	bh=UpMNwCROTPytB89Go1vVNVd3IF6Jih3eqQ8f0eDpzVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5O/SQHC7IXLL/EAgPfDOAvFIJgY4THAGLs8qgc7p4dxEOuFKNy+IWnA+EYXjAxrqnyKxIvJIh7Q0I4nIMLu8aJGjwvAUZVInSLHY9suIKBsM2LwwiES4aje413+qGXkEGfYAm0oo8Wj69w2Db+ejTN4PhqjiZREUS+g796obYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fc0ns/NQ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eb9b58fbb5so185164b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 15:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736465448; x=1737070248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a18oevnEucgCDx6bBf7yHFor/s+iMuzlm6FkFyc3Lik=;
        b=Fc0ns/NQsXVzjbuTp9/lCnXStg5T1NzhMVrqFMvJ90wNGRDjn4FsynM1pbY8ax9ohq
         0cjcgoCbfM5NywZDzQaIIo/OEtFGs+I6nD+KW4H/NlNt1z214Cv8HZn9yYrYMa14j0eh
         o31v88GGjlsUejdo95tVao3leSvt/TaVIfeL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736465448; x=1737070248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a18oevnEucgCDx6bBf7yHFor/s+iMuzlm6FkFyc3Lik=;
        b=J5jgb4YARClcE3V/ZlXmiuoAEqr+9Ter58703pJXxO6DKthAGO2AusAo4S8ujdb0Bu
         52Day2nUC7UlHbgsSnCV9T1eQMez/r+4HYalR2MNjzhM+lWjDIYt+eEB3GzhMEVJKJsJ
         mU8TCHF6Z6ZM2bu84ny86BgsrHXb04uQa4YevQ1XA2yR95JPLGSIVOwB2533bcWdwXds
         f9Iuoran8g0bPm2dCEVBkKMmRAqJbuasVnisCSZHG2y6Eo2GCG9ThaC1mJIvBhWEWSJx
         wSHMRJvfPt3/tJvHNBbx0TcIc2dRNwxpTVcV3EItfCZxm/pBkbkI/274aZvhrjOA1d2b
         xY0A==
X-Forwarded-Encrypted: i=1; AJvYcCUAU+oq9piXWlK/reJSp0IsVmnf+KJf/+3OS1whqKt35l36LeDMGtlFXAfDdWVFPiBHKuTNZMSE2WC55MOb@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcCUfYEpE1kBcnSErPJ781kuq8Hyb4nkJxlj6iN1GfPxzoNYh
	5633nF3dIoo4zTWw1/7kgRUvocKUzQUZkcOdeiun6R5Dz3JLEZ9xYZbHhnns2gN6/AOC3b9L/0w
	2+wNdjmbfq4Gs0UUxNkWnN3EbLbDUd9jTtI70
X-Gm-Gg: ASbGncsX3D89KyS7BlripayJSBnoxXaMlOiBeW8zZgZs8XNej86ssV8v6wxJ5cluMhU
	U5hot3aObpnPZn4u4dK8rQwPtCZoyW5jXqvH20bKKixonefjD969N4tYEAJ9lLlha28QfTIo=
X-Google-Smtp-Source: AGHT+IEzileaiSuyqihvKvLEPVBKwZNLmUlTfSZtcNAalK8SQS6cuyRBZqK/FZwJ0UES4ILr+5ux06GeHIfQZftSFQM=
X-Received: by 2002:a05:6870:2f09:b0:296:c3e9:507c with SMTP id
 586e51a60fabf-2aa068f2745mr1715691fac.10.1736465448237; Thu, 09 Jan 2025
 15:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook> <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
In-Reply-To: <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 9 Jan 2025 15:30:36 -0800
X-Gm-Features: AbW1kvaedR60IMurOyQMRhonOrvU2ElsItuQAytr0oRgCxIGr2Lw0F1I98J-zKA
Message-ID: <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:06=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Jan 06, 2025 at 04:44:33PM -0800, Kees Cook wrote:
> > On Mon, Jan 06, 2025 at 10:26:27AM -0800, Jeff Xu wrote:
> > > + Kees because this is related to W^X memfd and security.
> > >
> > > On Fri, Jan 3, 2025 at 7:14=E2=80=AFAM Jann Horn <jannh@google.com> w=
rote:
> > > >
> > > > On Fri, Dec 6, 2024 at 7:19=E2=80=AFPM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrot=
e:
> > > > > > +             if (is_exec_sealed(seals)) {
> > > > >
> > > > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's =
execution?
> > > > > I've not tested this scenario so don't know if we somehow disallo=
w this in
> > > > > another way but note on write checks we only care about shared ma=
ppings.
> > > > >
> > > > > I mean one could argue that a MAP_PRIVATE situation is the same a=
s copying
> > > > > the data into an anon buffer and doing what you want with it, her=
e you
> > > > > could argue the same...
> > > > >
> > > > > So probably we should only care about VM_SHARED?
> > > >
> > > > FWIW I think it doesn't make sense to distinguish between
> > > > shared/private mappings here - in the scenario described in the cov=
er
> > > > letter, it wouldn't matter that much to an attacker whether the
> > > > mapping is shared or private (as long as the VMA contents haven't b=
een
> > > > CoWed already).
> > > +1 on this.
> > > The concept of blocking this for only shared mapping is questionable.
> >
> > Right -- why does sharedness matter? It seems more robust to me to not
> > create a corner case but rather apply the flag/behavior universally?
> >
>
> I'm struggling to understand what you are protecting against, if I can re=
ceive a
> buffer '-not executable-'. But then copy it into another buffer I mapped,=
 and
> execute it?
>
preventing mmap() a memfd has the same threat model as preventing
execve() of a memfd, using execve() of a memfd as an example (since
the kernel already supports this): an attacker wanting to execute a
hijacked memfd must already have the ability to call execve() (e.g.,
by modifying a function pointer or using ROP). To prevent this, the
kernel supports making memfds non-executable (rw-) and permanently
preventing them from becoming executable (sealing with F_SEAL_EXEC).
Once the execve() attack path is blocked, the next thing an attacker
could do is mmap() the memfd into the process's memory and jump to it.

That is the reason I think we could tie this feature with
non-executable-bit + F_SEAL_EXEC, and avoid a new flag. This approach
leverages the existing memfd_create(MFD_NOEXEC_SEAL) function and
related sysctl for system level enforcement. This makes it simple for
applications to use the same function and ensures that both execve()
and mmap() are blocked by non-executable memfd. There is a small
backward compatibility risk for this approach, e.g. an application
already uses MFD_NOEXEC_SEAL but chooses to mmap it as executable, but
I think such a user case is strange to support.

If we're okay with using F_SEAL_FUTURE_EXEC, then share/private don't
matter, as the threat model explains. This flag's generic naming also
suggests it could apply to regular files in future. However, if this
flag is intended solely for shared memfd, it should be renamed to
something like F_SEAL_SHARED_MEMFD_FUTURE_EXEC_MAPPING. I don't think
this is the intention, right ?

LSM such as selinux is another option to consider, maybe it is a
better place to implement this? because  selinux policy provides
system level control and enforcement, which the current implementation
lacks. If we end up having a selinux policy for this later,  wouldn't
that obsolete this feature ?

-Jeff

