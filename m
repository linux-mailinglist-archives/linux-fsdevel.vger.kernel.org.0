Return-Path: <linux-fsdevel+bounces-8926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF783C5FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CCD1C2526D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FBC6EB76;
	Thu, 25 Jan 2024 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ywe7DKeV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B76EB56
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194798; cv=none; b=kbwySw6J2vwdJSRaYoKc3VEIopDK7mOi6yDVaPNqpPyFRfF0M9FwyHhRPn6bRoo3IV3wJtoA5IQXUHY9ZE8AH8ivJerlkFOHFHROYI2q1L2MqjZ/W18td5mavt3VCbTkldaBpwzZF7imEmWmMgE6I21jzkYv9UucjQmCwioJdf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194798; c=relaxed/simple;
	bh=NVvEtQm6kIc5iJVLjWQ7WGuCykEqscCeR/8JE5EYsvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTRNOnpHABuNvmp7WBCoqYnrtTtP5LXrNgQuTawRNMksCTx2MVzA9kYSqB+TkACdKrqAb9p+3xD1Q/dWl5NJNLOkZwHSdBhYfo2yZxJFWErw7K6+Vx0qFrJKt5peauz5oAP6RT0AzyqzQtJewuffaHK03LnyGHJ6ra9xVTUbaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ywe7DKeV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55d1d32d781so472a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706194795; x=1706799595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVvEtQm6kIc5iJVLjWQ7WGuCykEqscCeR/8JE5EYsvU=;
        b=ywe7DKeVLgmbEvuvIhAhxDlugmvDF0137qywdlLrLQAVIsCRrVwDfMXqQXzEq36zjN
         duhRuPbxnbbVBkSA6B34HESH1+ZU+cq+/bn3WVjJLv1QCeqU3mLoHKvlcQ1wk3g5Nkb7
         fJ5nv4lzoysO7zQrUYZ1zwOgr9d94il9rv2tVJNh15J3p1NGivQZ8FE03orEoGVUp8eT
         1ZFkjzC8V+ijBNBGX/b6Jj3hWCSYoA5hxYJmPMib8ghWY3Hx4v2hphFR9R1Gav146njq
         5m6TnU35zJc5pSUcnhIbdGXptRXalwJkv3HxfSGhnq12zuUcmpdv6jzVJBuWhNx2yIid
         +npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194795; x=1706799595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVvEtQm6kIc5iJVLjWQ7WGuCykEqscCeR/8JE5EYsvU=;
        b=jWXV8dLynJA9tVpmpHaqS7K2E88tr2Ydl7pViZesizGerXWsfB4jWmaV5ghn/6BGXZ
         +VtQtcC580DuQlUAFuGnA97q5qUIjtoCOl3h/rpTE3wR2QUVocYCDqG8dGc8w+MJ/fyz
         WI+pCfRsPaUb8RKCVE8LsKKrny/rq4ZrkQz7Mk81MnyCUx8x4q9r6tnUJE9TfJpNspBz
         IF5aBkdH1XmKG/5+HUf42E6l3CWHabNiI/s/7ejH4Yr/rIi5dVS1irDKp7KkzknuKZIg
         SE3MMCcmaT95cdVvGZbwGEhTXipY6dFa0g/U2b/XAOyx1WfQgFnbnPHqr63wzT4yrdgF
         lSbg==
X-Gm-Message-State: AOJu0YyqTeXz9neNmwizR95yqYLZ3KsHi8LgTKuj0dDU6WyrXcrxgjdO
	JTuDxaAoUZIduyFIrF843Tw997zvc9XxdimwayHS9PGuUHK4oZGxkDj3Gjsacm5kyJhqTZBq7oT
	b1+YnBf0nwMQ7DE9Yv5xlKYGQ6lNtkrNhKhq5
X-Google-Smtp-Source: AGHT+IGIh91e+GUrEWI2VlgkJRJgEwPq3pQit/1u6pod8dk+ZSjuV2o1xzEEvMsVGi6ZGj+bb5Hul2/ERa0C1CI5xvw=
X-Received: by 2002:a05:6402:c08:b0:55c:e50c:c66 with SMTP id
 co8-20020a0564020c0800b0055ce50c0c66mr233529edb.0.1706194795113; Thu, 25 Jan
 2024 06:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook> <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook> <CAG48ez1tcxtEwWgxSUqLDcYbrkY=UM3hz22A0BTvTYq4BGpM8A@mail.gmail.com>
 <202401241348.1A2860EB58@keescook> <62d1c43c-18e5-4ddf-ad85-c47e5c58d79a@I-love.SAKURA.ne.jp>
In-Reply-To: <62d1c43c-18e5-4ddf-ad85-c47e5c58d79a@I-love.SAKURA.ne.jp>
From: Jann Horn <jannh@google.com>
Date: Thu, 25 Jan 2024 15:59:18 +0100
Message-ID: <CAG48ez1BwRBy67=c7bgsNCoGHaw82tyU0O_QJjbFvQYVd9Aukg@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Josh Triplett <josh@joshtriplett.org>, Kevin Locke <kevin@kevinlocke.name>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:35=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/01/25 6:50, Kees Cook wrote:
> > Yeah, I was just noticing this. I was over thinking. :) It does look
> > like all that is needed is to remove __FMODE_EXEC.
>
> I worry that some out-of-tree kernel code continues using __FMODE_EXEC fo=
r
> opening for non-execve() purpose. If that happened, TOMOYO will be fooled=
...

I just scrolled through the Github code search results for the query
"__FMODE_EXEC -path:fs/exec.c -path:fs/fcntl.c -path:fs/nfs/
-path:security/tomoyo/ -path:security/apparmor/
-path:include/linux/fsnotify.h -path:nfs/dir.c
-path:include/linux/fs.h -path:security/landlock/", and the only place
I saw in there that sets __FMODE_EXEC, other than copies of core
kernel code in weirdly named files, was this one hit in a patch for
the 2.6.39 kernel to add plan9 syscalls:

https://github.com/longlene/clx/blob/fdf996e0c2a7835d61ee827a82146723de76a3=
64/sys-kernel/glendix-sources/files/glendix_2.6.39.patch#L2833

Debian codesearch also doesn't show anything relevant.

So I don't think we have to be particularly worried about that.

