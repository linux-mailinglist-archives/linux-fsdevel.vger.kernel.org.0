Return-Path: <linux-fsdevel+bounces-47925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E5BAA7470
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 16:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DEB1C01F67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943B32561D8;
	Fri,  2 May 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K40oS+KD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968023C4EB
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194708; cv=none; b=OoBza0ehsd8vEwMnJYGjqq4tNcPqmBoUIJ0vrGGpZZ46EVno2+oCY69A/xo05GSAJJMftjYEXP+hOCOjmJFpFms7GuKs0sf//DURNXvHUdB8jZYeQrR5ms4uC9JrGbEVTQlGJs3Jo5LHQT+N6kzcN6ZKyWoKbqn6g3wvq9fo1Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194708; c=relaxed/simple;
	bh=D9FrQH4n+PdihizMnAjXGJ0f+TPN3pD0AbB60hJwMCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrfvV+U7uQesDXtTmTKvlsht4QRrD/AmXGYKNnWDszPKJXCTm6swKq67zF+EOiafYdlNzUI8mlgdtxzhosLId/L9ouxuRbOd+YTNsA8Bt+rVxl9IykwaMWmWPSmk30y6uVCjonVdZ0ZSCD32HD/qlypQWhw/u10WH693/+K2460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K40oS+KD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so10913a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 May 2025 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746194704; x=1746799504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDe9RtA7TLLrd+vDa4DrWUwMAtXgbf0yt5j9UCuWdJ4=;
        b=K40oS+KDoYyve/QhEdChMv2ixxs+PRSsEVpBWtf5lquTpS+iffSsqIo1ZE3+8dW4WC
         i+9lOwDOj1LMex/qm07kMWuNW+MUrU1/x9Xu+6rH7rziI2zGKXKyToTTwRBpAY8jUZhR
         E4I7duhtszys1nK3zmDJV+W1zCZ/ae7dBGkmN6WZlG4HHqggAfY55nOAWN/+CVyVGkpO
         zCT38ugw6i2s9+xz913lPsGXi5fj10KLd+ncHDWOY++98okpxlAlHXY6w/kOVvCJy9Fn
         GItNs7Fjd0ztVHPc2S0+ikwjlGf9t8zxsft6IPhXgnvZ68bCoSQ65C6ApoWpz9yAqlIG
         ID5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746194704; x=1746799504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDe9RtA7TLLrd+vDa4DrWUwMAtXgbf0yt5j9UCuWdJ4=;
        b=Pj3LXlhnv7S3/grKpIpjhM26Mfnr8sJwP+1NSMOBOD/Lrb4Nl7zdlhLFe3+KD1VFlc
         udrF2kCkfPBnzZckHd2Uc3+mDxVpxAyAgbVYP8rYbT0BMUa+LYRI+akG3fY3Pu13buI+
         9YU9tkDro75UEmmAR0NT19fKep99KS6liSwLw0imkDiCpIuLJsXbC8XNdfCPGxFDfenZ
         EdnNpzoV6Ta1QO2jDIUV9bLYewEzwZjS1Kkh+5hTASEkefpurA4N1oPaPPTcaMf+BDry
         BzywflcZ5O1PiGfJ7xai8yiCxvMrdfL211T6wxwk5pPWguLO8HHEf1jS70tKD0rhnRJY
         egAA==
X-Forwarded-Encrypted: i=1; AJvYcCUr+6QxR5P4XJlsCtpmY2yWS+M+LakeeX3dRrALrZ1GtdeSKMlT+MheoQtIZCLu3lsXomT0jsUZgm4HG4PF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/drlla0DT/7qz4yPZDeaib268ZJSliYxcyJqpgA9ZMHgtVX2
	SbIcUPfEQi0LYDbodgB6C5sEcl+rox/2Nqr4Bv3njZ/Yz8/0zzwjH7KZUV5hdEFdq4Vw4Thjz5+
	41hD3ZvEjHmoxy4PNrEZqWu3cPG23FyItjTUMM4yQZJwnoB21xj6O
X-Gm-Gg: ASbGncvMlxbsugw/DjvDwxW5upp1mAW7l5bLHSiLHE/dUSF83hxqsjcpcjDQqjjMhXk
	capWmYh4MK3du25t+4yXzeYMGhERP2kxyqBgmdDbTNl25HjQAJt6HJoJuHQoKlT+44DgjmEQIQ0
	ij/ma4reoELdIzS7fryCtJJyOlgPDVXGRVEapCVphgFYoMWBV14g==
X-Google-Smtp-Source: AGHT+IGQyG7jBeuHSLNmsAImzv0cQUgCHSzQUeks+9StY/yQAdwPY81V2I46PF4Wav7Pheny/ljSV/t3KJ1MePw5oro=
X-Received: by 2002:a05:6402:1d38:b0:5e4:afad:9a83 with SMTP id
 4fb4d7f45d1cf-5f9130fae93mr209007a12.2.1746194704052; Fri, 02 May 2025
 07:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 May 2025 16:04:28 +0200
X-Gm-Features: ATxdqUEap07yOkwLkXFTwqsri6Zk9OGzrg6-_-HwiNt-HyE-SosQ2SulcKFl1qc
Message-ID: <CAG48ez3oefetsGTOxLf50d+PGcthj3oJCiMbxtNvkDkRZ-jwEg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] coredump: support AF_UNIX sockets
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 2:42=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> I need some help with the following questions:
>
> (i) The core_pipe_limit setting is of vital importance to userspace
>     because it allows it to a) limit the number of concurrent coredumps
>     and b) causes the kernel to wait until userspace closes the pipe and
>     thus prevents the process from being reaped, allowing userspace to
>     parse information out of /proc/<pid>/.
>
>     Pipes already support this. I need to know from the networking
>     people (or Oleg :)) how to wait for the userspace side to shutdown
>     the socket/terminate the connection.
>
>     I don't want to just read() because then userspace can send us
>     SCM_RIGHTS messages and it's really ugly anyway.
>
> (ii) The dumpability setting is of importance for userspace in order to
>      know how a given binary is dumped: as regular user or as root user.
>      This helps guard against exploits abusing set*id binaries. The
>      setting needs to be the same as used at the time of the coredump.
>
>      I'm exposing this as part of PIDFD_GET_INFO. I would like some
>      input whether it's fine to simply expose the dumpability this way.
>      I'm pretty sure it is. But it'd be good to have @Jann give his
>      thoughts here.

My only concern here is that if we expect the userspace daemon to look
at the dumpability field and treat nondumpable tasks as "this may
contain secret data and resources owned by various UIDs mixed
together, only root should see the dump", we should have at least very
clear documentation around this.

[...]
> Userspace can get a stable handle on the task generating the coredump by
> using the SO_PEERPIDFD socket option. SO_PEERPIDFD uses the thread-group
> leader pid stashed during connect(). Even if the task generating the

Unrelated to this series: Huh, I think I haven't seen SO_PEERPIDFD
before. I guess one interesting consequence of that feature is that if
you get a unix domain socket whose peer is in another PID namespace,
you can call pidfd_getfd() on that peer, which wouldn't normally be
possible? Though of course it'll still be subject to the normal ptrace
checks.

