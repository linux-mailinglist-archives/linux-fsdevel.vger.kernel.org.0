Return-Path: <linux-fsdevel+bounces-55606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89B0B0C702
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BA41C2025F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152D2D9793;
	Mon, 21 Jul 2025 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="PQ9+huo7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3164292B3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109685; cv=none; b=Xm8XL0GCFDQ1oeuBTUjTp2IgTeb/pn3HmBBvVRDO9fgKdZzevlVt9QTy/kc/VMimxwF/+VXTHssrooOor4jPmHcMWqgY3UrvlrbZVITEfIYd7qSrpC/P1tqNC4ixkaVnT5DamPzxYYb0O4XH+8O6hAVmO8krYzWojmP5ykN9TMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109685; c=relaxed/simple;
	bh=518kXeLj6kbtVwBxVqSfjB6e5f4U9FEy5Advv0uhCPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGSEIOvaFy9IFxpY+YURUsMfkXUy+Zm+CQGIMnMTb5QTtUio0bYn9fGg+bSg0g0sAEls7llMAHPd5OSjlP0hb1IEUJ/V8wAhc+04pQ4ops3IgqCC3lIqPJRPtDLzm2oiSpXpeY8zD5Oth2R/uCnszMC/cvvbT+Dt97a+Vt02yV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=PQ9+huo7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55516abe02cso4533418e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1753109682; x=1753714482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XmXS/nI5r2hga5CDWMuJ3Ma6+XCmtN/p6vOD3DC5Wg=;
        b=PQ9+huo7rjPRLmGo5wtJUxoy1RX+5TfKwF34BATWdlr76c5mq+EdH5vaVYCK109NNi
         6lc87WH8bUd6dFbTtm5LMMBUzMrbhzHaKD9eKUQDUKqbVgjyP8BhxIBErJ1Eqt2vUcEE
         zMh9WG4tiXuY4FKs30BAvYO/4cV00shkTrkphOypcI7E4kRcJyERb/oKSxofKA/3W+Wj
         Ot5EJSdrO8UBQkL4SQoY1m6Q9pFPUFsnq5qJAqphc7LYqzQeWNtR1pkhWuZoKln58U8+
         ZIzXVlJtofk4hd7s31vKRrOHzkF+iUTUiSx7XecAFsi9NNP1ou/K0+2olp1Ik6K4IcIa
         ixog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753109682; x=1753714482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XmXS/nI5r2hga5CDWMuJ3Ma6+XCmtN/p6vOD3DC5Wg=;
        b=k7sYRwwbmoXrzKF4wa9oxTHU/b+4GtMGr7aMx1WvIeBUe7xtMwOvDxh40KvzeeDvpS
         t1A7LG1uoKlzUiIRO+pLuPN3ZYj0JdDXjnmmX++1f0LvulM5OgcJCvNC7Mi4rFU/wzHM
         m7nqQgB4WQKMqnORxLaBfz6mmezVGKBzHU0Xu7pAIeRUwmt8gF+XlUOz7kzv7atrKrxK
         8u1IYudacEfloWjcBZe8AIw4/neSDydF/b1DBZ1ZTbHBHkCI6kOwj3P/nsC0EoRcgIHx
         mQHuhzCAgtjWBrEsTZE9GBgc5gVxwtoiT9/vCX0c03/lQriYezEA/gbCDtYbhUPaUxcR
         4RtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPTKAdOHXCX2jPeZMfjTYYjR0Pli5oz4tf2SKJB9usaqTxDLJlyEqv20SQMTT8n/A3VDhaUfrZEf+4XTY@vger.kernel.org
X-Gm-Message-State: AOJu0YylpFPMz1N9mtBOuEpkTZ39dlDCtC5wr9V/+0q4rqwou80QoR/4
	I7abFnvjbCWbCg29dTq3RGzfbwC4Ddo7aOmlrqwi+P8VH4HH9Bb+TkkuNdDrjwpyGMJQNN33u2r
	i/CAFSbOhphxlei9AEmtThrAWcvlILth2Li8U+xyC
X-Gm-Gg: ASbGncuUoUS6iLQrf49HXr6TZB90YRYLjU+Q6eaok1Ajr/dQECmOU4d2BTklnfkerH7
	4+8leAJEBRV3CedfffRj0x6/wm9uLCFHdqyi2TgRLMnfvHBbXqj+Tb5VYCjeFL58dRDRt9h50bp
	GFjWmkiKG3R+rxqN7EBVBiLfmdzPM1x+5NlbmOiR/EOCfgqPo8/Ne2Pq+LM0+TOptvWVKy/aV43
	tQ62g==
X-Google-Smtp-Source: AGHT+IEtAqgZcpU79/xXRzqVJ4e2WhSjNHLjvVNLiF1Rk9rzxfztT5QgvrGsTSD/4JlI4WCGerKhBMKc7bH8+8ZLaBE=
X-Received: by 2002:ac2:4e0c:0:b0:55a:32ef:6bc2 with SMTP id
 2adb3069b0e04-55a32ef6f42mr3865325e87.25.1753109681521; Mon, 21 Jul 2025
 07:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
In-Reply-To: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 21 Jul 2025 07:54:25 -0700
X-Gm-Features: Ac12FXzKaqLBu09o8y3jyqrwQXTdN07vZbAIAukCaEYRRYZu2yxBvBVI4Rm-DbU
Message-ID: <CALCETrVo+Mdj7as2R0R+FqTBbjqwTkXu5Zkj=dg8EVM9xRhBPw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] procfs: make reference pidns more user-visible
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:44=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> Ever since the introduction of pid namespaces, procfs has had very
> implicit behaviour surrounding them (the pidns used by a procfs mount is
> auto-selected based on the mounting process's active pidns, and the
> pidns itself is basically hidden once the mount has been constructed).
> This has historically meant that userspace was required to do some
> special dances in order to configure the pidns of a procfs mount as
> desired. Examples include:
>
>  * In order to bypass the mnt_too_revealing() check, Kubernetes creates
>    a procfs mount from an empty pidns so that user namespaced containers
>    can be nested (without this, the nested containers would fail to
>    mount procfs). But this requires forking off a helper process because
>    you cannot just one-shot this using mount(2).
>
>  * Container runtimes in general need to fork into a container before
>    configuring its mounts, which can lead to security issues in the case
>    of shared-pidns containers (a privileged process in the pidns can
>    interact with your container runtime process). While
>    SUID_DUMP_DISABLE and user namespaces make this less of an issue, the
>    strict need for this due to a minor uAPI wart is kind of unfortunate.
>
> Things would be much easier if there was a way for userspace to just
> specify the pidns they want. Patch 1 implements a new "pidns" argument
> which can be set using fsconfig(2):
>
>     fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>     fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0=
);
>
> or classic mount(2) / mount(8):
>
>     // mount -t proc -o pidns=3D/proc/self/ns/pid proc /tmp/proc
>     mount("proc", "/tmp/proc", "proc", MS_..., "pidns=3D/proc/self/ns/pid=
");
>
> The initial security model I have in this RFC is to be as conservative
> as possible and just mirror the security model for setns(2) -- which
> means that you can only set pidns=3D... to pid namespaces that your
> current pid namespace is a direct ancestor of. This fulfils the
> requirements of container runtimes, but I suspect that this may be too
> strict for some usecases.
>
> The pidns argument is not displayed in mountinfo -- it's not clear to me
> what value it would make sense to show (maybe we could just use ns_dname
> to provide an identifier for the namespace, but this number would be
> fairly useless to userspace). I'm open to suggestions.
>
> In addition, being able to figure out what pid namespace is being used
> by a procfs mount is quite useful when you have an administrative
> process (such as a container runtime) which wants to figure out the
> correct way of mapping PIDs between its own namespace and the namespace
> for procfs (using NS_GET_{PID,TGID}_{IN,FROM}_PIDNS). There are
> alternative ways to do this, but they all rely on ancillary information
> that third-party libraries and tools do not necessarily have access to.
>
> To make this easier, add a new ioctl (PROCFS_GET_PID_NAMESPACE) which
> can be used to get a reference to the pidns that a procfs is using.
>
> It's not quite clear what is the correct security model for this API,
> but the current approach I've taken is to:
>
>  * Make the ioctl only valid on the root (meaning that a process without
>    access to the procfs root -- such as only having an fd to a procfs
>    file or some open_tree(2)-like subset -- cannot use this API).
>
>  * Require that the process requesting either has access to
>    /proc/1/ns/pid anyway (i.e. has ptrace-read access to the pidns
>    pid1), has CAP_SYS_ADMIN access to the pidns (i.e. has administrative
>    access to it and can join it if they had a handle), or is in a pidns
>    that is a direct ancestor of the target pidns (i.e. all of the pids
>    are already visible in the procfs for the current process's pidns).

What's the motivation for the ptrace-read option?  While I don't see
an attack off the top of my head, it seems like creating a procfs
mount may give write-ish access to things in the pidns (because the
creator is likely to have CAP_DAC_OVERRIDE, etc) and possibly even
access to namespace-wide things that aren't inherently visible to
PID1.

Even the ancestor check seems dicey.  Imagine that uid 1000 makes an
unprivileged container complete with a userns.  Then uid 1001 (outside
the container) makes its own userns and mountns but stays in the init
pidns and then mounts (and owns, with all filesystem-related
capabilities) that mount.  Is this really safe?

CAP_SYS_ADMIN seems about right.

--Andy

