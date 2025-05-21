Return-Path: <linux-fsdevel+bounces-49554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB49ABE8C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 02:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E008A20AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 00:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25EC3A1DB;
	Wed, 21 May 2025 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6iYY0S8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1362AD2D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747788938; cv=none; b=p3Zce93oX5QyPKSpdfrQt6mb3H1nmKgTOL5KMZz+UIqsRGJXq6gxAhkoIMH7Ihn7h8VhwgEx4ilzHRSQPsgCdvK8RB+pIZpHeob1y2K7JWeZHJU3W2Ze1zwAqHqm3ri8bUrWt7xIjiUXrd9qQWpwIgBNhlOcTI9LQevJmwvKd+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747788938; c=relaxed/simple;
	bh=3Y0eI2D8cnedVznYRle7TnjGhJ3X2g6z0d4K3WJthKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvxJRT0rFZOnfPuKgAGoeg7syJx/7KsMxZZrnFtxvn8VujPiDxcJjLPAK8LsHIKua2CWnmmDfjXl6XPZzHyK4mwBu4D3KJK+OHe7R7v4MxGQ1VM1fp50DEOedvQF3N3P7kmUrecDHmLAdhK+i+jXcedY6BQQt/l7BTo7o6RKKmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6iYY0S8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so26765a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747788935; x=1748393735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncdPurYh5hOloTnF5wYlf3UcK9wRpi+Q0GSN2FGpFac=;
        b=t6iYY0S8F9uuz9aTdTGzVi/0cVIoOe4P+CoySV6Esk6I3hSqPnSlxEmZhR2u8jyazn
         laZVf6RcIc8ELzwaMXmGfjzYQ8SAbIjv4IFXfTyBXM/E2W9nI/tqpf0c0HJx+zg9X3sz
         MrOKJYrk8wCe3/BhQA8zA8uJZgW8q7sbB3N8j9nihnoyI+ojilBL6Z254QfkP518+Apm
         RInyo800CxqXW7BcYy9iFqfufCYmQIQopHLq7I/jexZVzzUpOgT/QeaOq4HuXYfFUAj/
         onx4WCI5hOEMWO5M/hYPiQC7vlPQlLNsr6vNaGwalY60y67tv0cTfeeC46JBlAtkvmy/
         q+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747788935; x=1748393735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncdPurYh5hOloTnF5wYlf3UcK9wRpi+Q0GSN2FGpFac=;
        b=kChSKWnsJ/WYbEQlzXvNGgOj98dnwMHqAHQpHUo7N/0FOKwN+UCPct/XzWSxtttD/x
         DlvHcJAO3dJHaX1w0agK5mBgLKRxPXu8IbZMhEFJSAx7Qp+baN0iK4bzWvKsO+YgT9Hc
         zKowdu64SsfhNdLGkxlPhjE+6ILymK2H+UErq4mrv1SPInL8+24a0xP76KnsBxLYJAVK
         K4gQXpvuS6XZa+KtGyDZwd7dUhtjuk1faFr7f7vNoWq+eIgWEbRzQ2AYebwKxxrf4mnE
         NVzu3BNxkqFJ6pkU14ACd90Iy/PQyZHasVOtxf4k0bYlesIV9bJ0dGzIhTQdWbMC25AQ
         zHYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFgmbGUuRfnHVvWp78kBrc38iM+k36xeEYK4oA4Rtl4Lkx2JTiykft3H7ROwRl7BwZseZ0XNrVKjgRLdjH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+JIhjyPTW/y/S4zrKHCTe9vuc43xWz6ugGvkcbNqH1yHa1b/S
	/CS/T8Pm/uHQ+yYgyDA35YG6eHbVjMBz12paGYwndUnKNGBpOoS+AxokwRr99u+jx/lKhFBrj03
	ZEAY926jK5ODr2+7lSxz3FMQh0xnti/zdwBdz77Wj
X-Gm-Gg: ASbGncvEf97DPFL6M+lCG1UqaPwER3JQbFLg5zmzR1QKjGTBu9l610L2tKYQdM16ngP
	tpIH9uK1mvn2DQCdyQu6++3kdE6huj+vBUbG7l1CqQCY0RzPacsSld4vP7ytbfm6jXpB3T2E80I
	2rzVLyK+Is1+STJp+LTpeSOaAE14arDRjxO7HEPrOzOrugsZOeIKhOJvhbI5qUzG9RBuVDbgfA
X-Google-Smtp-Source: AGHT+IG1IjnHi54Q+N8idfo93JIC1frTSBUwH3gzuDMjjhBz9G/MzDcANwRogNTzPUUfNYSoKlZHrVja9CDjA4RXL78=
X-Received: by 2002:a05:6402:14d5:b0:601:233a:4f4d with SMTP id
 4fb4d7f45d1cf-6019bf2f776mr370366a12.2.1747788934322; Tue, 20 May 2025
 17:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520122838.29131f04@hermes.local> <20250521004207.10514-1-kuniyu@amazon.com>
In-Reply-To: <20250521004207.10514-1-kuniyu@amazon.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 May 2025 02:54:58 +0200
X-Gm-Features: AX0GCFtQXlIu9odOXoeE-q7wbNaaPaAzIzGo4QIICbt2W9dOwceP8yBMza1qmTI
Message-ID: <CAG48ez0r4A7iMXzBBdPiHWycYSAGSm7VFWULCqKQPXoBKFWpEw@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] coredump: add coredump socket
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: stephen@networkplumber.org, alexander@mihalicyn.com, brauner@kernel.org, 
	daan.j.demeyer@gmail.com, daniel@iogearbox.net, davem@davemloft.net, 
	david@readahead.eu, edumazet@google.com, horms@kernel.org, jack@suse.cz, 
	kuba@kernel.org, lennart@poettering.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	luca.boccassi@gmail.com, me@yhndnzj.com, netdev@vger.kernel.org, 
	oleg@redhat.com, pabeni@redhat.com, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 2:42=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> Date: Tue, 20 May 2025 12:28:38 -0700
> > On Fri, 16 May 2025 13:25:27 +0200
> > Christian Brauner <brauner@kernel.org> wrote:
> >
> > > Coredumping currently supports two modes:
> > >
> > > (1) Dumping directly into a file somewhere on the filesystem.
> > > (2) Dumping into a pipe connected to a usermode helper process
> > >     spawned as a child of the system_unbound_wq or kthreadd.
> > >
> > > For simplicity I'm mostly ignoring (1). There's probably still some
> > > users of (1) out there but processing coredumps in this way can be
> > > considered adventurous especially in the face of set*id binaries.
> > >
> > > The most common option should be (2) by now. It works by allowing
> > > userspace to put a string into /proc/sys/kernel/core_pattern like:
> > >
> > >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h
> > >
> > > The "|" at the beginning indicates to the kernel that a pipe must be
> > > used. The path following the pipe indicator is a path to a binary tha=
t
> > > will be spawned as a usermode helper process. Any additional paramete=
rs
> > > pass information about the task that is generating the coredump to th=
e
> > > binary that processes the coredump.
> > >
> > > In the example core_pattern shown above systemd-coredump is spawned a=
s a
> > > usermode helper. There's various conceptual consequences of this
> > > (non-exhaustive list):
> > >
> > > - systemd-coredump is spawned with file descriptor number 0 (stdin)
> > >   connected to the read-end of the pipe. All other file descriptors a=
re
> > >   closed. That specifically includes 1 (stdout) and 2 (stderr). This =
has
> > >   already caused bugs because userspace assumed that this cannot happ=
en
> > >   (Whether or not this is a sane assumption is irrelevant.).
> > >
> > > - systemd-coredump will be spawned as a child of system_unbound_wq. S=
o
> > >   it is not a child of any userspace process and specifically not a
> > >   child of PID 1. It cannot be waited upon and is in a weird hybrid
> > >   upcall which are difficult for userspace to control correctly.
> > >
> > > - systemd-coredump is spawned with full kernel privileges. This
> > >   necessitates all kinds of weird privilege dropping excercises in
> > >   userspace to make this safe.
> > >
> > > - A new usermode helper has to be spawned for each crashing process.
> > >
> > > This series adds a new mode:
> > >
> > > (3) Dumping into an AF_UNIX socket.
> > >
> > > Userspace can set /proc/sys/kernel/core_pattern to:
> > >
> > >         @/path/to/coredump.socket
> > >
> > > The "@" at the beginning indicates to the kernel that an AF_UNIX
> > > coredump socket will be used to process coredumps.
> > >
> > > The coredump socket must be located in the initial mount namespace.
> > > When a task coredumps it opens a client socket in the initial network
> > > namespace and connects to the coredump socket.
> >
> >
> > There is a problem with using @ as naming convention.
> > The starting character of @ is already used to indicate abstract
> > unix domain sockets in some programs like ss.
> > And will the new coredump socekt allow use of abstrace unix
> > domain sockets?
>
> The coredump only works with the pathname socket, so ideally
> the prefix should be '/', but it's same with the direct-file
> coredump.  We can distinguish the socket by S_ISSOCK() though.

The path lookups work very differently between COREDUMP_SOCK and
COREDUMP_FILE - they are interpreted relative to different namespaces,
and they run with different privileges, and they do different format
string interpretation. I think trying to determine dynamically whether
the path refers to a socket or to a nonexistent location at which we
should create a file (or a preexisting file we should clobber) would
not be practical, partly for these reasons.

Also, fundamentally, if we have the choice between letting userspace
be explicit about what it wants, or trying to guess userspace's intent
from the kernel, I think we should always go for being explicit.

So I guess it could be reasonable to bikeshed the prefix letter and
turn '@' into some other character that is not overloaded with another
meaning in this context, like '>'; but I don't think we should be
changing the overall approach because of this.

