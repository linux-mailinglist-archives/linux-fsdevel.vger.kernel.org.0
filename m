Return-Path: <linux-fsdevel+bounces-58895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D03B331BD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 20:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6511B21EEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAF92DAFDF;
	Sun, 24 Aug 2025 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="sZM+WYvp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B541F1527
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Aug 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756058658; cv=none; b=Kxv7jXGP8IlwIUR1qLXtnpHJsAKnkC1N7x08ekEHGYPZF8P4h4vVix0RX5A7RGwEqDim2DxoD0+bLIuipaTnhF/K0Lsm0T+zcK/jeaj8iwsxP3cSxagNx6sZ+R6wfPrX7zGM0was1EzcLEyZNiULERJfiEDO2IZU3tuFFHeNeyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756058658; c=relaxed/simple;
	bh=ey7i7bxWumWF13T+7fbSOysFDdormlbhVcwdhLRAWqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZI2klgyoreOyKRYpQ2Gj9hzJzyyr2vPyZ6FfZW7tCWWmKYopgt+E8kHJKgAe/daB/9tSjGuv9WX9u4VdoeUqwklL1NFHAwKUdL79c+Nbs9xUW0+wryxhWZgEq/7JQGaghS4B3AHb9uMJABzgg+bnH6ls6qp67FSVSJptSjSH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=sZM+WYvp; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-336763f6fb8so2124951fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Aug 2025 11:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1756058655; x=1756663455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Mqhac1pPLxOFzg/IMkWKzDuJw9zxJucMZNKxwjX8w=;
        b=sZM+WYvpq4HAYIUKnIjeFDV1hmxPY7aB7krFWSy+WWqzZSKw4zk5HyNx2hclDPkQgx
         Oa3u7fAMoP3NUGpr9l4oZuGVSiAiO6s2q9+e7JxkLqPGQftZu4VyMByjCPJpavmbK/hs
         gsXLy67Z0dTk/D0WhaN6M788Z1KkSF/mGty8r37OgZ0wPT4FxWa1s4zhe+HHd2yj43pV
         L3TN/kAurSAVeQA9AmQFkMzQdOcZJiCQf+ZmpdqWVQoL0uAftYSzTqUaEaAWM85Fsa1j
         KD3VFB/zxxoXdIcPmpDfmyX2KvtoaIfE17g6ivIs4igTTcX7rXm/Ho/jcWLkurxq9NY4
         E3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756058655; x=1756663455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0Mqhac1pPLxOFzg/IMkWKzDuJw9zxJucMZNKxwjX8w=;
        b=AWLLSm1I7SHEJX9J/leHPi9k0Y/hx9WbZ+JAH7wWOHWEOrPdnNHszdy4n2CupGRhHn
         WZXLQrhLZp9v5+ITGLKi27nO45Xyj0ohyPo+GrLtSDRDl/HIJrAtE24VuIeBKvpVAFKp
         Eb+xdEJrsvaUUEFZp6kW3tNVNA1MwOh/QXjgjz8qp2SllwLcmBaH+RPRAQtc58xxalCz
         x7bpdQoP+yYt0svOYBEziFjj3xknK+qo6k39P8XTdQV0QfG+C62Ryugt6MRmz1aInAE8
         caVylJZsVeMymj3IBaz3moTVXDCDmYzQxA+vPeqnWu06cWvXubthcx6bXHDhh6P/vpeM
         H0dg==
X-Forwarded-Encrypted: i=1; AJvYcCXfOrK2O1qRJMbRmk6lkIN8x/I7lhkMzqJwQbHAs17K0EJZzfXE691LQdYKOTm1JvRtF29r8utfYwuWI9jq@vger.kernel.org
X-Gm-Message-State: AOJu0YyVX5eM+47Gi/y/kYRg2DIDfGFSgbNkEDPXIvdJqUAEBF8ob/6X
	YOa6tBs2f/Q63Muf6XZo7cM6h8dWqGwSnz7r5K+MqNkhMiQ7Eedf8xtaZ66EHehcJ0ql4SXFbuN
	K3GQHKJhO4T6OKXpf0U8lg9idFcPOIn0ooqwdJYma
X-Gm-Gg: ASbGncs8QKfRYBL4c45dMmBtDnfgrfC+VGCY3YmFcMvdc868aXL0wgebYypt6o+QZjk
	UiNH1AxFtfHbn9J9Q7t0DC0ig/9z1fmH43yEoElWyhV+f89lE0wX4zu86bfhojupe8OWBjYe3AC
	JR4oBBNj4mJ0J7did+HflmUJScS0NxCRQKU2hXVs2kCdP2khRIxNa8kbf42445NFPzMUESI30gz
	yH5Ig==
X-Google-Smtp-Source: AGHT+IGF/dSB4zitQu9ImrlbyPFpP2+tHfFZf4y48i1CL/OIyHx/mf7kWUUcnX3b9Qxm/wZMHTZ7DH4N2k9D4qfPnxU=
X-Received: by 2002:a05:651c:1543:b0:336:54c4:22f with SMTP id
 38308e7fff4ca-33654c41142mr27882691fa.22.1756058654760; Sun, 24 Aug 2025
 11:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com> <20250824.Ujoh8unahy5a@digikod.net>
In-Reply-To: <20250824.Ujoh8unahy5a@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 24 Aug 2025 11:04:03 -0700
X-Gm-Features: Ac12FXyzTcamVk2RNr_E8bAaBJ4wpr7EwhOIwP10YoouSxxGVpZtqPO1TvhX9SM
Message-ID: <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > Add a new O_DENY_WRITE flag usable at open time and on opened file (e=
.g.
> > > passed file descriptors).  This changes the state of the opened file =
by
> > > making it read-only until it is closed.  The main use case is for scr=
ipt
> > > interpreters to get the guarantee that script' content cannot be alte=
red
> > > while being read and interpreted.  This is useful for generic distros
> > > that may not have a write-xor-execute policy.  See commit a5874fde3c0=
8
> > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > >
> > > Both execve(2) and the IOCTL to enable fsverity can already set this
> > > property on files with deny_write_access().  This new O_DENY_WRITE ma=
ke
> >
> > The kernel actually tried to get rid of this behavior on execve() in
> > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
> > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > because it broke userspace assumptions.
>
> Oh, good to know.
>
> >
> > > it widely available.  This is similar to what other OSs may provide
> > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> >
> > We used to have the analogous mmap() flag MAP_DENYWRITE, and that was
> > removed for security reasons; as
> > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> >
> > |        MAP_DENYWRITE
> > |               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 and =
earlier=E2=80=94it
> > |               signaled that attempts to write to the underlying file
> > |               should fail with ETXTBSY.  But this was a source of den=
ial-
> > |               of-service attacks.)"
> >
> > It seems to me that the same issue applies to your patch - it would
> > allow unprivileged processes to essentially lock files such that other
> > processes can't write to them anymore. This might allow unprivileged
> > users to prevent root from updating config files or stuff like that if
> > they're updated in-place.
>
> Yes, I agree, but since it is the case for executed files I though it
> was worth starting a discussion on this topic.  This new flag could be
> restricted to executable files, but we should avoid system-wide locks
> like this.  I'm not sure how Windows handle these issues though.
>
> Anyway, we should rely on the access control policy to control write and
> execute access in a consistent way (e.g. write-xor-execute).  Thanks for
> the references and the background!

I'm confused.  I understand that there are many contexts in which one
would want to prevent execution of unapproved content, which might
include preventing a given process from modifying some code and then
executing it.

I don't understand what these deny-write features have to do with it.
These features merely prevent someone from modifying code *that is
currently in use*, which is not at all the same thing as preventing
modifying code that might get executed -- one can often modify
contents *before* executing those contents.

In any case, IMO it's rather sad that the elimination of ETXTBSY had
to be reverted -- it's really quite a nasty feature.  But it occurs to
me that Linux can more or less do what is IMO the actually desired
thing: snapshot the contents of a file and execute the snapshot.  The
hack at the end of the email works!  (Well, it works if the chosen
filesystem supports it.)

$ ./silly_tmp /tmp/test /tmp vim /proc/self/fd/3

emacs is apparently far, far too clever and can't save if you do:

$ ./silly_tmp /tmp/test /tmp emacs /proc/self/fd/3


I'm not seriously suggesting that anyone should execute binaries or
scripts on Linux exactly like this, for a whole bunch of reasons:

- It needs filesystem support (but maybe this isn't so bad)

- It needs write access to a directory on the correct filesystem (a
showstopper for serious use)

- It is wildly incompatible with write-xor-execute, so this would be a
case of one step forward, ten steps back.

- It would defeat a lot of tools that inspect /proc, which would be
quite annoying to say the least.


But maybe a less kludgy version could be used for real.  What if there
was a syscall that would take an fd and make a snapshot of the file?
It would, at least by default, produce a *read-only* snapshot (fully
sealed a la F_SEAL_*), inherit any integrity data that came with the
source (e.g. LSMs could understand it), would not require a writable
directory on the filesystem, and would maybe even come with an extra
seal-like thing that prevents it from being linkat-ed.  (I'm not sure
that linkat would actually be a problem, but I'm also not immediately
sure that LSMs would be as comfortable with it if linkat were
allowed.)  And there could probably be an extremely efficient
implementation that might even reuse the existing deny-write mechanism
to optimize the common case where the file is never written.

For that matter, the actual common case would be to execute stuff in
/usr or similar, and those files really ought never to be modified.
So there could be a file attribute or something that means "this file
CANNOT be modified, but it can still be unlinked or replaced as
usual", and snapshotting such a file would be a no-op.  Distributions
and container tools could set that attribute.  Overlayfs could also
provide an efficient implementation if the file currently comes from
an immutable source.

Hmm, maybe it's not strictly necessary that it be immutable -- maybe
it's sometimes okay if reads start to fail if the contents change.
Let's call this a "weak snapshot" -- reads of a weak snapshot either
return the original contents or fail.  fsverity would give weak
snapshots for at no additional cost.


It's worth noting that the common case doesn't actually need an fd.
We have mmap(..., MAP_PRIVATE, ...).  What we would actually want for
mmap use cases is mmap(..., MAP_SNAPSHOT, ...), with the semantics
that the kernel promises that future writes to the source would either
not be reflected in the mapping or would cause SIGBUS.  One might
reasonably debate what forced-writes would do (I think forced-writes
should be allowed just like they currently are, since anyone who can
force-write to process memory is already assumed to be permitted to
bypass write-xor-execute).


---

/* Written by Claude Sonnet 4 with a surprisingly small amount of help
from Andy */

#define _GNU_SOURCE
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/fs.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc < 4) {
        fprintf(stderr, "Usage: %s <source_file> <temp_dir>
[exec_args...]\n", argv[0]);
        exit(1);
    }

    const char *source_file =3D argv[1];
    const char *temp_dir =3D argv[2];

    // Open source file
    int source_fd =3D open(source_file, O_RDONLY);
    if (source_fd =3D=3D -1) {
        perror("Failed to open source file");
        exit(1);
    }

    // Create temporary file
    int temp_fd =3D open(temp_dir, O_TMPFILE | O_RDWR, 0600);
    if (temp_fd =3D=3D -1) {
        perror("Failed to create temporary file");
        close(source_fd);
        exit(1);
    }

    // Clone the file contents using FICLONE
    if (ioctl(temp_fd, FICLONE, source_fd) =3D=3D -1) {
        perror("Failed to clone file");
        close(source_fd);
        close(temp_fd);
        exit(1);
    }

    // Close source file
    close(source_fd);

    // Make sure temp file is on fd 3
    if (temp_fd !=3D 3) {
        if (dup2(temp_fd, 3) =3D=3D -1) {
            perror("Failed to move temp file to fd 3");
            close(temp_fd);
            exit(1);
        }
        close(temp_fd);
    }

    // Execute the remaining arguments
    if (argc >=3D 3) {
        execvp(argv[3], &argv[3]);
        perror("Failed to execute command");
        exit(1);
    }

    return 0;
}

