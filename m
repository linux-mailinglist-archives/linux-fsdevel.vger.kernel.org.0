Return-Path: <linux-fsdevel+bounces-48735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4760AB357D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 13:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FFF863BC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF626267B8E;
	Mon, 12 May 2025 10:59:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00125CC41;
	Mon, 12 May 2025 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047549; cv=none; b=e0fbj1arqmA7ZlyXZRav3y1MrmR2mHlQuhTRDtN8gUDbnZopHCT8C20q8CxRLPLzT18exQSWOa9bjSeq7/nCt0qv7Kvmb9kXvZO0z8klnISyvpr3vcaC8ST8jc3kkTNMNXzm6g1+9JtuP5tO4jr2dY+qfTOUINF6ZGZSqu9q+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047549; c=relaxed/simple;
	bh=rVZyzZYw1PMWsSuDhX8DQZ9HYMGVkH1KluRzeJ95Qtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLQmDRBNL4j8r35yU46J18dSxEVVrjPEhHwWcaHZxqJsPRe4s+pMppVnH629uszLBBIXn5JbkYd5AFm9EyIAJ1YJNbR2yfG70FdfNECmrfv8azfDpkOBDH/qPvTCX70QluKXS6+U+G+4gAPxnhPiKo7OPk504xq2UJE6sFSrcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7082e46880eso37848167b3.1;
        Mon, 12 May 2025 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747047546; x=1747652346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8PsN0J2Swl6o1xGZOYbU/MU+6PxWnwPSf4GCl8IgvA=;
        b=N9BMSmly7Ehc6+/DgA7CVepjEmqtWgCPuTRut3Qz6VM9ZsWfavNRoX8lg5dvgOl0mj
         t8ko9s1w6GRTvlK66i/llsOmBSm/Cs+DKnOQv/aIMyFWT3M4YFwFiTgY2PYAUUpkbKL7
         RIYBB1i0e2vMs+KhPEZM9eS/HznONFzglqQVnlcCRYBWrovJ2qvOxqbTMBIdkh+m35N1
         rn304aq94VQBteW5JDKft0PV+Lk6oHijrG9Vqnq6zL4Hi1u9SHKPrEbjFxKdork0E6bc
         Z2PWhW3acrW6rPmbrae+h4P+BIwp8Phf1SknGIpRWR0kQTQb415AFR+ztCRowXOMIUGj
         x8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVUT2Q1ntj4b+U9Ictc1mNxp7jFmu6aTaiG4iQ1SAcRG2h4020HwynCtDFk/94z61GdNBYjmWlX+c9cG4Q=@vger.kernel.org, AJvYcCX9a/INZT+Sd1euqlxI2oXlJkomXORCiBEL0UEzuRlSXMjsWJXZR1G5sgpc4lCiN8az3D8bzqoq@vger.kernel.org, AJvYcCXKlPEt89M2KhRczZXMP19/7YFQCAWXlA1TT2+70GogHcoAd0uTNhQrmmhEOII+FzhrGuJyBi+icj1k4iiobghFwXQEC9UX@vger.kernel.org
X-Gm-Message-State: AOJu0YyEi9dQxPp8UmchZYGi9BYzqniYnXfI4cx5tiH5uSSWeXPlmpmx
	eZuNY/cuV+ngi6v+2X+6GnfsricFKHgbCKxsfM7klkWlyqtIRVzu4nFQbQ0Q
X-Gm-Gg: ASbGnctQH5RmDRuqAYMg4/wa3ofvg98NT3I6id0c4E3CCc4ub/LCWMFGVSKfPRlHL+D
	Al5OgANdtBfFju3fzw+vm2ENoLP4phT6oIdF1iQuFIxNgEDcKvTG706etWXKDNcTD3k2tGIHOBO
	Ef7VQGuepXMurkb9h4oHnjaAeei3EQzgv2LzKU4IdKLqY3s06EHwdLUOULelrzdPIGBIJit8lz/
	tqqeGqx5MV3pni7cDhr2x98U2TJrk5AfbeCRivBIWCyCKrSBMNnzUp+55VcOjaj4bJKZqHJ25k6
	SZTFbETEG9wi0RUDEl9ZvaviDxI9zgR4UOQCFkSbUKnBiS99I813aPmgBopVZlk4TfVBMZmlkXI
	p/AV6oyPB13RL
X-Google-Smtp-Source: AGHT+IGYMOzzu0K4b1tOxbGH+rxEEFyw5EdK6Vahw1hnd+bsxODQ3YXkq/Jz1OYmNcUCMtGhcVKksg==
X-Received: by 2002:a05:690c:6307:b0:708:c2dd:c39f with SMTP id 00721157ae682-70a3fa35805mr161860947b3.17.1747047546342;
        Mon, 12 May 2025 03:59:06 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70a3d9ebdcfsm18860277b3.102.2025.05.12.03.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 03:59:05 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-708d90aa8f9so39265887b3.3;
        Mon, 12 May 2025 03:59:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMkrOG3ozJGqow2VQxJvyDJqO24lCeIhj2bQG3VC995ggk3rP2sogBo8WG8TZraWTRRTypNR/rSOEdBfI=@vger.kernel.org, AJvYcCW9jy/yIQbxfgsSoPPT8XFU/BwlOrW74TOLeoR91JbwB08oDSC8uJZ5EHEDCV32ykRoEupidwws8bkiH1BaJpKH/70linzN@vger.kernel.org, AJvYcCX0QmtjIXuaTutZni8N3B2tOW4m1ys/HXtdVmrvFc6a+ztxexSZnHfXi6FLBN5Kkm5gHsFAQua/@vger.kernel.org
X-Received: by 2002:a05:690c:6c05:b0:708:139e:4e03 with SMTP id
 00721157ae682-70a3fa181a3mr172595757b3.16.1747047545394; Mon, 12 May 2025
 03:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org> <20250512-work-coredump-socket-v6-4-c51bc3450727@kernel.org>
In-Reply-To: <20250512-work-coredump-socket-v6-4-c51bc3450727@kernel.org>
From: Luca Boccassi <bluca@debian.org>
Date: Mon, 12 May 2025 11:58:54 +0100
X-Gmail-Original-Message-ID: <CAMw=ZnTF9EVV+E+bXTz1je3VT+OwDPAzbbFy7G02zBjeCpqxFA@mail.gmail.com>
X-Gm-Features: AX0GCFsyH_TmjjPguQGV1t1Tf5zy3LvYUYu79bJiOgfvSrNURzcSRCb3aNHlYeI
Message-ID: <CAMw=ZnTF9EVV+E+bXTz1je3VT+OwDPAzbbFy7G02zBjeCpqxFA@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] coredump: add coredump socket
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 09:56, Christian Brauner <brauner@kernel.org> wrote:
>
> Coredumping currently supports two modes:
>
> (1) Dumping directly into a file somewhere on the filesystem.
> (2) Dumping into a pipe connected to a usermode helper process
>     spawned as a child of the system_unbound_wq or kthreadd.
>
> For simplicity I'm mostly ignoring (1). There's probably still some
> users of (1) out there but processing coredumps in this way can be
> considered adventurous especially in the face of set*id binaries.
>
> The most common option should be (2) by now. It works by allowing
> userspace to put a string into /proc/sys/kernel/core_pattern like:
>
>         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
>
> The "|" at the beginning indicates to the kernel that a pipe must be
> used. The path following the pipe indicator is a path to a binary that
> will be spawned as a usermode helper process. Any additional parameters
> pass information about the task that is generating the coredump to the
> binary that processes the coredump.
>
> In the example core_pattern shown above systemd-coredump is spawned as a
> usermode helper. There's various conceptual consequences of this
> (non-exhaustive list):
>
> - systemd-coredump is spawned with file descriptor number 0 (stdin)
>   connected to the read-end of the pipe. All other file descriptors are
>   closed. That specifically includes 1 (stdout) and 2 (stderr). This has
>   already caused bugs because userspace assumed that this cannot happen
>   (Whether or not this is a sane assumption is irrelevant.).
>
> - systemd-coredump will be spawned as a child of system_unbound_wq. So
>   it is not a child of any userspace process and specifically not a
>   child of PID 1. It cannot be waited upon and is in a weird hybrid
>   upcall which are difficult for userspace to control correctly.
>
> - systemd-coredump is spawned with full kernel privileges. This
>   necessitates all kinds of weird privilege dropping excercises in
>   userspace to make this safe.
>
> - A new usermode helper has to be spawned for each crashing process.
>
> This series adds a new mode:
>
> (3) Dumping into an abstract AF_UNIX socket.
>
> Userspace can set /proc/sys/kernel/core_pattern to:
>
>         @address SO_COOKIE
>
> The "@" at the beginning indicates to the kernel that the abstract
> AF_UNIX coredump socket will be used to process coredumps. The address
> is given by @address and must be followed by the socket cookie of the
> coredump listening socket.
>
> The socket cookie is used to verify the socket connection. If the
> coredump server restarts or crashes and someone recycles the socket
> address the kernel will detect that the address has been recycled as the
> socket cookie will have necessarily changed and refuse to connect.

This dynamic/cookie prefix makes it impossible to use this with socket
activation units. The way systemd-coredump works is that every
instance is an independent templated unit, spawned when there's a
connection to the private socket. If the path was fixed, we could just
reuse the same mechanism, it would fit very nicely with minimal
changes.

But because you need a "server" to be permanently running, this means
socket-based activation can no longer work, and systemd-coredump must
switch to a persistently-running mode. This is a severe degradation of
functionality, will continuously waste CPU/memory resources for no
good reasons, and makes the whole thing more fragile and complex, as
if there are any issues with this server, you start losing core files.
And honestly I don't really see the point? Setting the pattern is a
privileged operation anyway. systemd manages the socket with a socket
unit and again that's privileged already.

Could we drop this cookie prefix and go back to the previous version
(v5), please? Or if there is some specific non-systemd use case in
mind that I am not aware of, have both options, so that we can use the
simpler and more straightforward one with systemd-coredump.
Thanks!

