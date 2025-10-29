Return-Path: <linux-fsdevel+bounces-66372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570DC1D546
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 21:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93A694E31E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 20:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8525DB12;
	Wed, 29 Oct 2025 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HfBfEVYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4718312836
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771561; cv=none; b=SNaA+NRNud7bMMmO6Dp4gKaHXE6P/xJoKxYH1FuyrqmFmgORswHizVv54O/C/ORV4Txp19Z81C9uIrXoFlm1EdN7vwBZ/Xa/eIiMCA8ZhspIWXczI6ikAo57yzoxqJUDVeXC2N0mOXiQRtxCw8pMMz042qslfdWRO7dThikyr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771561; c=relaxed/simple;
	bh=LbCzKk2cGvRRVZVsuoizSMZfwxwz1pQ654zQNk3mgK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uasJk6j6+bliZdVJtupqx1k3b0oG6kdFUJiRZU6K387IWlc9WG33AfxwfmiO41e8cNtyYCyEdtj0fgRHViA5jUJtIb9KT5QgG8ab6JWEH3Slpg3m2VSvHccymhKVIpitV7dvAicb4dNawoBqiR+E43B0BGDswU1CPKm8KZiil1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HfBfEVYA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so61807766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761771558; x=1762376358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfAN57AJ3VlZrtEXkpg0YM0RNnc6zjLGC6mTJFKCfBA=;
        b=HfBfEVYAm6pKrOzMQIBf8PkgeaLjDBNONliYapp6CWViux2Dk2stZc23yzp+kCiYd6
         eIwPDPx1uHrwbJcnVmI5Pg+8rvb6ndWVMCyoJyvMIZGPC/0eKiQWG+d0VjtgxYlk9evl
         hU8m51IiiPJYZ1y21+dEwj738WlG4fz9y2Phyr9hvRMQ5bkdqPlqOJbERD339Gs9wo64
         GjKXrWjxKA4CDHQkRnR5IY2K/kBV2sW5LUnwQtBQ8cH9Au313zSu3BknGP1fZZD4yZpu
         kt/e7xhhQ2osoba0CbBjrGGZ+/nxysfO43ysnewmOuBtYtgevpout5pD/vq/pm226wsZ
         Gp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771558; x=1762376358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfAN57AJ3VlZrtEXkpg0YM0RNnc6zjLGC6mTJFKCfBA=;
        b=e8pEeAtNs3epjjMvHOiXu6ga0AtNS6KKNYNcgbzjnTR2tIIWmVzLOhThN8mu+8K1w2
         3167pQEObalG01NLCYCBt4wCbP/sNP3YHiFK5RMhCYv/VftO7/PQlu7YSxc/L2KO+ssg
         sx5pQc3/P+/t1bXGkNboO0i//5LdNNy+jQxduOxScyPm1UFt5CvfRh1x4h/G7EIWh0WX
         5vSwt9cREcbfsDqQlfLNiRNGZ32vR4cqAoJhe4kWNYAFPgmHs98G+YWrufAnzO4f9Qd8
         lgfeW0Au+oeUORGcHddM+rC/WV5kjgF+coD6UtBp/nDkMt4m5rDjqITTx2dYQZ6LaAeG
         GQIg==
X-Forwarded-Encrypted: i=1; AJvYcCXtbqO40g73vi1S/DMJMSFzKeweg3NQ9NoRZKVGPBSYW6J7aK3qDDXTGxAwigQpdiE8MVuVymf/G9F0bOgi@vger.kernel.org
X-Gm-Message-State: AOJu0YwMB6/NrqeRMR1X0tgI6j8BW7UzweomrfDstl2t8Es+mWrR8N+T
	OC+vYfrx1WcUmbTmpAvSdejMMX5cq6Jd1Nc98BpT2jNH+3pmsK4Fa/+y6Yjqd2Bh2zO+wsFV6Wv
	kpx0kkyrES1zxCiFSAyKcNKM8zGW4ZIiKY8s7eI/xaw==
X-Gm-Gg: ASbGncuWel0k47+KxKOwDMaoiVRynfF+cX9piMdyFxrxiryl3joUxqcFpwz8f3pAlDH
	8NGoh4C0747ZnRM+wFoo9cZVHaO8NnMBdVvRAQXdjeXu0+wZoJZX+cpFfN5zHw6xJjFZIzaYRrK
	369YpbOp83rcwlEiJWXWm9DSrr/E/XiMqxqnb7VL7EvDx+I6kbw2VD6AxNOE3xcrcOFbUddVoeW
	SYSyuDlJf0hCY4qBDXrATkGPOUB30RS29TJmAwLh9XepLUolmuQMX/JWA==
X-Google-Smtp-Source: AGHT+IE/RXMv8hoooZh1E58NXDF0M8rMKt7Jq2/dOGekqdl2XNp/FrTs01ETHE1dw8Wf9fSE9rBqLnrH1cmST40VDnY=
X-Received: by 2002:a17:906:6a10:b0:b5c:753a:a4d8 with SMTP id
 a640c23a62f3a-b703d601679mr444730266b.62.1761771557853; Wed, 29 Oct 2025
 13:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0pla5cuml.fsf@kernel.org>
In-Reply-To: <mafs0pla5cuml.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 16:58:40 -0400
X-Gm-Features: AWmQ_bl42EDPtm_TaUQbgHgrX7gDrKin3DS3aEDrxO6qieGZ-fwZboHP8lat9pQ
Message-ID: <CA+CK2bB6e_=yQ9tQgvh7tJ3q34vCo9v4KpYG8DRF5pRa+YuUrQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:37=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
> > Introducing the userspace interface and internal logic required to
> > manage the lifecycle of file descriptors within a session. Previously, =
a
> > session was merely a container; this change makes it a functional
> > management unit.
> >
> > The following capabilities are added:
> >
> > A new set of ioctl commands are added, which operate on the file
> > descriptor returned by CREATE_SESSION. This allows userspace to:
> > - LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
> >   to be preserved across the live update.
> > - LIVEUPDATE_SESSION_UNPRESERVE_FD: Remove a previously added file
> >   descriptor from the session.
> > - LIVEUPDATE_SESSION_RESTORE_FD: Retrieve a preserved file in the
> >   new kernel using its unique token.
> >
> > A state machine for each individual session, distinct from the global
> > LUO state. This enables more granular control, allowing userspace to
> > prepare or freeze specific sessions independently. This is managed via:
> > - LIVEUPDATE_SESSION_SET_EVENT: An ioctl to send PREPARE, FREEZE,
> >   CANCEL, or FINISH events to a single session.
> > - LIVEUPDATE_SESSION_GET_STATE: An ioctl to query the current state
> >   of a single session.
> >
> > The global subsystem callbacks (luo_session_prepare, luo_session_freeze=
)
> > are updated to iterate through all existing sessions. They now trigger
> > the appropriate per-session state transitions for any sessions that
> > haven't already been transitioned individually by userspace.
> >
> > The session's .release handler is enhanced to be state-aware. When a
> > session's file descriptor is closed, it now correctly cancels or
> > finishes the session based on its current state before freeing all
> > associated file resources, preventing resource leaks.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> [...]
> > +static int luo_session_restore_fd(struct luo_session *session,
> > +                               struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_session_restore_fd *argp =3D ucmd->cmd;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     guard(rwsem_read)(&luo_state_rwsem);
> > +     if (!liveupdate_state_updated())
> > +             return -EBUSY;
> > +
> > +     argp->fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (argp->fd < 0)
> > +             return argp->fd;
> > +
> > +     guard(mutex)(&session->mutex);
> > +
> > +     /* Session might have already finished independatly from global s=
tate */
> > +     if (session->state !=3D LIVEUPDATE_STATE_UPDATED)
> > +             return -EBUSY;
> > +
> > +     ret =3D luo_retrieve_file(session, argp->token, &file);
>
> The retrieve behaviour here causes some nastiness.
>
> When the session is deserialized by luo_session_deserialize(), all the
> files get added to the session's files_list. Now when a process
> retrieves the session after kexec and restores a file, the file
> handler's retrieve callback is invoked, deserializing and restoring the
> file. Once deserialization is done, the callback usually frees up the
> metadata. All this is fine.
>
> The problem is that the file stays on on the files_list. When the
> process closes the session FD, the unpreserve callback is invoked for
> all files.


> The unpreserve callback should undo what preserve did. That is, free up

Right, we discussed that continous preservation is not going to be
possible. So, this bug is not going to be present in the next version.

