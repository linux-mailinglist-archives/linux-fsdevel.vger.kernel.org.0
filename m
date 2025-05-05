Return-Path: <linux-fsdevel+bounces-48106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA661AA96C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADDF3A59DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149625DAE0;
	Mon,  5 May 2025 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gn07Fz2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2A202F9A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457221; cv=none; b=a2OsWy383dysNgPykrbHZ5hGPj6asFJC8wzWPBaCRSdOxjiFCH7skTzDtpljBb/o3zjS8Q7odDEalsxLQTQD16f470PsiGRiKTWpE8/bC4R5HJucuxYLD9UCZvLX8vr2jd4G5s8XVGXRx/gnL0mh7XbocA2JTir5uG8vqcfEs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457221; c=relaxed/simple;
	bh=dBUWsePdK+43bgJYz1/M5xbcGgbXAn2tygzYhdejMy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4u/7RxAGhxWFKlS780jQ44K8uAQIQU7MR0LNdT6XOwfkSRlVYIabthWy98xHL/GXGuSGKD7/pT0Jn1ahg6ssRXqf9X7zNfHDo/5iUxVxYr++fGMesSOdwJ71STtfejMwlhC0A2BxpxyIOH3nSVueG0UmuAEY+QY2uDN29VcYkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gn07Fz2j; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso13860a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 May 2025 08:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746457218; x=1747062018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgpaiR/N3ioL5/g7+EhtTfAMyKaTCNjdwR/daQulLIQ=;
        b=Gn07Fz2jjfazVk65MmWu+w5DqmkOODuyVLsw73yFcLLbeiAKG8r5ChTXtLHsliRFFt
         LgsM8yqx5rgRfY36evT06vDfzMO0Nu5uZs4avDUgsFAUt8LVUlHNy0KsNHg//uaaiCS1
         V4H4FAmNcrRkanYFTfQki7SfuV4S/IMuSoZz1AIMhr2mPpqrKWgbCIvnb1PlSZ0bDMc9
         feI8WYEUXf+4QYFqc/loRG4EDKhBvlsPHCFDfXiDrqNveljuxIQfBX8TX7rOkYnrW5TU
         lg2L0zFW2wK/ZQ6NOVPOWnlpMekRDCueS85fb7SrUXa+XdSUSxc9Q/laIJJziaTJoEkr
         fKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457218; x=1747062018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgpaiR/N3ioL5/g7+EhtTfAMyKaTCNjdwR/daQulLIQ=;
        b=hLUs5FJ8ix9ecwsjB1UcJLwD3F8NVjcZNVZd7xMj396FwMQc6JU9XvIolJGf11cIw1
         zG0KawlWaOpU6S7cqDhOQNgEv68ZG30ULfBTCDlOqS33C4tiyv815o7q3eDWgF3p1FFH
         dscvzfGWU6CmHxTpZ7cfGRDIffEXQc1TFGANxfm992yWfasemCFuBRhvW0mtDQOClMeG
         Sp/stssNhpwXx29fNpFLX9QRn4gjZP7Pg7h+HP41IscAKZwqhOjYC8GQbJkcIDCNDLzS
         Ub+OGIrBjiA+YzFp5vkLy5fYoWfjAv7NiSZ3MrfFEs3H27dbqRlIW4GsgKFnns4SeNLR
         xXzA==
X-Forwarded-Encrypted: i=1; AJvYcCU8nQup7oRlVhm8aAMzyDzeuAV3FzSVSsm6iLjr9CDhxHxG5dTMQxbqbs+5S+ZHMgNuKyyEsaL8/7WlGEfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxKAv6pKYzT0IiMGhF3BFqoy8KkzhTlMN2nqq3PeZipYHHCHLIQ
	4Vo4j8NZw0R40ImCMgdsweOaCOOdkQ4TvEFN8viRlX+eo+DemnI88o2kJbgGCfTiLyK2/J7fPJZ
	KUpufC3ZNPi4KMvADQEpWWQfwHNA+KEHTZ/qt
X-Gm-Gg: ASbGncvqQzAR2TQ8+Op+XG6bp/7WvNDQ1nuwah31X++mGCozYP9cxRJe5gIN1H+rUFK
	b2jxYv1ELgcub5T2WkyWc5EJ8Bp1lkWZKmhmygnKAusTFoxHQ5xEIIofLXhVtTdZ7EYsU8J1kgO
	JxdfQ33W7ZjcR4F82ZZgLXDNv9kdw32W6HuhLHlDsqYaeBQPE/ZQ==
X-Google-Smtp-Source: AGHT+IGBV00De7Bvs81up3DiMq5uNMuS1+NaIIw75xqG2AMJ/upMjP5p6RxIZZ1P7Y/Z/+u89lr0EL9heQCbZx6cvAY=
X-Received: by 2002:a05:6402:1507:b0:5f8:7b57:e5c2 with SMTP id
 4fb4d7f45d1cf-5fb566852d6mr2204a12.4.1746457217325; Mon, 05 May 2025 08:00:17
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org> <20250505.aFia3choo1aw@digikod.net>
In-Reply-To: <20250505.aFia3choo1aw@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 May 2025 16:59:41 +0200
X-Gm-Features: ATxdqUEpQd4Wf6EVwtubs_kdKekg1DlIT59sXj-KbDJqdbZPlnBKsnyyATHMsFk
Message-ID: <CAG48ez0Ti8y5GzZFhdf5cmZWH1XMmz0Q_3y8RCn6ca8UL-jrcA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 00/10] coredump: add coredump socket
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:41=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Mon, May 05, 2025 at 01:13:38PM +0200, Christian Brauner wrote:
> > Coredumping currently supports two modes:
> >
> > (1) Dumping directly into a file somewhere on the filesystem.
> > (2) Dumping into a pipe connected to a usermode helper process
> >     spawned as a child of the system_unbound_wq or kthreadd.
> >
> > For simplicity I'm mostly ignoring (1). There's probably still some
> > users of (1) out there but processing coredumps in this way can be
> > considered adventurous especially in the face of set*id binaries.
> >
> > The most common option should be (2) by now. It works by allowing
> > userspace to put a string into /proc/sys/kernel/core_pattern like:
> >
> >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> >
> > The "|" at the beginning indicates to the kernel that a pipe must be
> > used. The path following the pipe indicator is a path to a binary that
> > will be spawned as a usermode helper process. Any additional parameters
> > pass information about the task that is generating the coredump to the
> > binary that processes the coredump.
> >
> > In the example core_pattern shown above systemd-coredump is spawned as =
a
> > usermode helper. There's various conceptual consequences of this
> > (non-exhaustive list):
> >
> > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> >   connected to the read-end of the pipe. All other file descriptors are
> >   closed. That specifically includes 1 (stdout) and 2 (stderr). This ha=
s
> >   already caused bugs because userspace assumed that this cannot happen
> >   (Whether or not this is a sane assumption is irrelevant.).
> >
> > - systemd-coredump will be spawned as a child of system_unbound_wq. So
> >   it is not a child of any userspace process and specifically not a
> >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> >   upcall which are difficult for userspace to control correctly.
> >
> > - systemd-coredump is spawned with full kernel privileges. This
> >   necessitates all kinds of weird privilege dropping excercises in
> >   userspace to make this safe.
> >
> > - A new usermode helper has to be spawned for each crashing process.
> >
> > This series adds a new mode:
> >
> > (3) Dumping into an abstract AF_UNIX socket.
> >
> > Userspace can set /proc/sys/kernel/core_pattern to:
> >
> >         @linuxafsk/coredump_socket
> >
> > The "@" at the beginning indicates to the kernel that the abstract
> > AF_UNIX coredump socket will be used to process coredumps.
> >
> > The coredump socket uses the fixed address "linuxafsk/coredump.socket"
> > for now.
> >
> > The coredump socket is located in the initial network namespace. To bin=
d
> > the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
> > user namespace. Listening and reading can happen from whatever
> > unprivileged context is necessary to safely process coredumps.
> >
> > When a task coredumps it opens a client socket in the initial network
> > namespace and connects to the coredump socket. For now only tasks that
> > are acctually coredumping are allowed to connect to the initial coredum=
p
> > socket.
>
> I think we should avoid using abstract UNIX sockets, especially for new
> interfaces, because it is hard to properly control such access.  Can we
> create new dedicated AF_UNIX protocols instead?  One could be used by a
> privileged process in the initial namespace to create a socket to
> collect coredumps, and the other could be dedicatde to coredumped
> proccesses.  Such (coredump collector) file descriptor or new (proxy)
> socketpair ones could be passed to containers.

I would agree with you if we were talking about designing a pure
userspace thing; but I think the limits that Christian added on bind()
and connect() to these special abstract names in this series
effectively make it behave as if they were dedicated AF_UNIX
protocols, and prevent things like random unprivileged userspace
processes bind()ing to them.

