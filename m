Return-Path: <linux-fsdevel+bounces-8811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6F83B2A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A621C22D73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9F13342F;
	Wed, 24 Jan 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkjH7Wly"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A913340A
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126375; cv=none; b=Q2LPOVDaLrgAGDOkIcPOMHSAZ8rflMoZyKljpKOX6M3kOsAgJysvZo5hOqiXRW6Wwvz7DgUz7WOsfLV+HwcLpAvSjKZ6xKbq7A48szbmZr/ulVA8OfS6t4d7Nivs7xYN2CIi0HHb/azl4gvdG/XJd59cDraKBuLyvtHkkSkoEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126375; c=relaxed/simple;
	bh=IbNRc2tTI3uRJ4hOoUG/LLCmL8sxwzKLKOM6UpHlIBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OW5mdQ5KNESjaJtQX2gNw5iQ3v+hNizSq89wToS8F5Al9yom5bhvEHQ1rJqOR+r2CWxbQKOL6H0JVRovLyQW6+pcUnhdJtrSIiR9BMLTNwcg/s+6zRPzOmmhZZl21SWwjlAQfDtjTQ3hCnfnVrk2hiFg4MaAcYsx4KQFSMn88lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkjH7Wly; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso3531a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706126372; x=1706731172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbNRc2tTI3uRJ4hOoUG/LLCmL8sxwzKLKOM6UpHlIBE=;
        b=KkjH7Wly2be5bPpQh5/K+TpoIusUptoVc5hnVxbHKO89GQfrfwb+3t7RFDGtuAWXIj
         BYAH7Obe4FPxuW4m4u1eIvAJSCROmAD0CF3zIwjKHWKHQ0UE+y6qCi4n9Z1PqQlrYMyv
         vcKrU2tryisDF6PetjKM3JZVOSq7G39AHeA/B9F3BiHg5gMLB/nX0BiaP90ivp3l08XZ
         Ky642hhJpdnbm6jDuePdMl8nuUaSYx840Q/TbTjDcChYoW1L7YKE+RVeCL+qPfvEq4KT
         7366EW/bODPQiBOWVdlz3TtM9Ag29CU69UWePfmI6pXlgWG2g8LyeD9p+YgG4UEcnw22
         rxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126372; x=1706731172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbNRc2tTI3uRJ4hOoUG/LLCmL8sxwzKLKOM6UpHlIBE=;
        b=qSH7VF71ODLROXNWo56reOrXNWba+6VeA1FldcyzniDBRwNztaARYJ+UQGXU7zhlw7
         e9E3jrrvg2P73D5whLOVKx5C19xr05H950OGR1mzFKMbkKzTfUrsueZKXLJzEMCgUV8o
         /glVIp2pWjHjT3T+BjUVEguWGI2Wgxe7o2ds2+Z+nFYw9HQosJS+kzb7WqfNZaUVyo98
         qUYkbSKrZ6UfQQQZkgJIwGm57XO8lTIA4EPiFoZ7HNWuA8DYg/7pBqKNmFS0IaxAFoud
         XtNDnVS1pIU4AeKQNyDFoA+wcy201m95DVKijmjIrddeu3N+AJqImL1y5/dJprQRMZ5J
         HTlA==
X-Gm-Message-State: AOJu0Yy9qo/ltxSebLI+uMibd27nmPbXpLT6XQuLC3vhZpC7cEoL8aZI
	4z/9PA4C+E9/bSRe5pmfcDZbxPxI9rs3bC9j9MNkMkkxTWqZa3irBJ+jv+PvifB9AJF3AsODxnN
	MD/AnYUhjCXqwZ2ox1YwDLsEJTwvGIkkEDm0n
X-Google-Smtp-Source: AGHT+IHnF4f0O7cgArzhqXohHk8DKWdbCZVXNqyko/Yg6gnRAIJ7ffyT6vZhUBC9TtgW0kqc22Osp9E7+o4qEnIEp44=
X-Received: by 2002:a05:6402:1bc9:b0:55c:8eda:6e19 with SMTP id
 ch9-20020a0564021bc900b0055c8eda6e19mr34873edb.2.1706126371819; Wed, 24 Jan
 2024 11:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org>
In-Reply-To: <20240124192228.work.788-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 24 Jan 2024 20:58:55 +0100
Message-ID: <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Kees Cook <keescook@chromium.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Kevin Locke <kevin@kevinlocke.name>, 
	Linus Torvalds <torvalds@linux-foundation.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 8:22=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> After commit 978ffcbf00d8 ("execve: open the executable file before
> doing anything else"), current->in_execve was no longer in sync with the
> open(). This broke AppArmor and TOMOYO which depend on this flag to
> distinguish "open" operations from being "exec" operations.
>
> Instead of moving around in_execve, switch to using __FMODE_EXEC, which
> is where the "is this an exec?" intent is stored. Note that TOMOYO still
> uses in_execve around cred handling.

I think this is wrong. When CONFIG_USELIB is enabled, the uselib()
syscall will open a file with __FMODE_EXEC but without going through
execve(). From what I can tell, there are no bprm hooks on this path.

I don't know if it _matters_ much, given that it'll only let you
read/execute stuff from files with valid ELF headers, but still.

