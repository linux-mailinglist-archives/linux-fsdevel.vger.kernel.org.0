Return-Path: <linux-fsdevel+bounces-11781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAA8571D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C07EB248DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 23:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A7145B26;
	Thu, 15 Feb 2024 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aYui0xY1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A79138489
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040876; cv=none; b=WRGTp/JZmt7EMNYZrQLJVhUKsneJPh7paOLlhGyhtZ2vYxJkous6Azf+SYj+c8+e7k5iRN5bSjSHlw4/XzI/M2wyEe6rf066Gw4hugJ9Ti8yNBRhKUK8IsmpgoFpPPr/BdPvT/In/H3gmy69K4VBMXpAXzGFmzwYB/V9M/QizQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040876; c=relaxed/simple;
	bh=i0JkEoazbe7olxPfKu+G8Uy4A1Di4zZuZedbjzHoSNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ficS7vcgSvHxWhWafw7ZGpDW4Yh4hDcOPmVAiRocfo//piTQEkYtalaBmQy/u/gJGmXRER0Mjh6ERRbxziN2W0jgxUvwTFe1js2qfeJOs3EjrussXcdviL84XH1ydmf8KVseBviCPdaMKb7wQepzE7U5V7WCMsyOKS8pBFeZ6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aYui0xY1; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc73148611so1628456276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 15:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708040873; x=1708645673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNqNjWyj5Im8N6xWYYajO215Bvq50L/4j9hhElLNjXY=;
        b=aYui0xY188H+UoJn+hSOIc4QjrEciHSFIhXKUFqjYi0ete6C2JbxdY6QFA6cM/v5a4
         gMxYJhHM08soJ6YqWCgI9z7aUsQ6A2jhx50dNzjEOFi0ztlp6thiEHMAE7ShGokQe8O3
         EjiapTGcLiGf0BquSSdEsphdKiOesT7UmLOw+1qUmyi0qUJaIyEIkDTJzZP9+i+F44U4
         lQV0UsHBoUb8xZNBMzVWmWJXxfnHoLhYCqdT1afaiS8aZND8ToH8KIuEyh/AgmfvMwqL
         mq2ZCJehDA7PItvedNp1h/vmnu+lnhkO6ae/YqNuofk4RUA7ElpwAT7RBXYgLNmeG+M5
         atag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708040873; x=1708645673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNqNjWyj5Im8N6xWYYajO215Bvq50L/4j9hhElLNjXY=;
        b=cRU39HVU2RC7aGXw3JIpI/0Q7imOk9I5B3cr7UYyUbh/RGvM6T7yO1f9JM88L8Gi22
         Vusjw6gZf3QUUuP0MWQUomrDTpu2+xBB2RmtFbBsTWQ1slQtBdKI2+7pT4xxLTsmcoFT
         KA/k1AwZdt0bTS5/Hrnyuf9UR0WpslWIcOWtsOs0vjuMDVBTh4aJuQiqhq2P6rcm4PcB
         SD0jkyNfOe4wqBJ9xpyWqVgX0zTh/RdqYIOAhXDQjnnRKQJcsiqBIBa/28QaMIqHPT5Y
         NDaWAaL7s6BwXsdZp+pIxYbAWehSMNYyVAdN4825AO69mGHDIuhd9y0YEX19mz2TRyBZ
         jj0A==
X-Forwarded-Encrypted: i=1; AJvYcCVeILOPlKdtwj90eNiV7IfNWAlSVqEE7H73Zre26a3xmkMygTiJunK8Wrba39s8NPVgcqzheXqMNoTJnG/Y3FbHCZKyrzVfUlzurYHKWg==
X-Gm-Message-State: AOJu0YwUD1oum/YP7nvn6MOKoUWCQnlFxzqNN6lHho6L9JEo/G/leizs
	vfeFSOLSK5AiQoH8fAPOcnnq37yMwBVRrWcklup8VTQu9Rtq3ikZ8ODgwCaWpLEErdJ0Y7pUBrX
	pKvvU19HB6hAFZQBYWGm4xNSbj2M2vJyYSoA7
X-Google-Smtp-Source: AGHT+IGj4sYe0xwnV8Z27fpJ5XIo46jQrmblbhi+Z75L6k1QenA7Kck+4HBXyW1C8ZgM8RHcSbfHoYCrtsSiiXbyGWQ=
X-Received: by 2002:a25:69c6:0:b0:dcc:99b6:830b with SMTP id
 e189-20020a2569c6000000b00dcc99b6830bmr2991821ybc.19.1708040873125; Thu, 15
 Feb 2024 15:47:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook> <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
 <CAHC9VhTTj9U-wLLqrHN5xHp8UbYyWfu6nTXuyk8EVcYR7GB6=Q@mail.gmail.com> <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>
In-Reply-To: <76bcd199-6c14-484f-8d4d-5a9c4a07ff7b@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Feb 2024 18:47:42 -0500
Message-ID: <CAHC9VhTac1ZuAzD5w=NtSYryu8vYxHnCx0NsMP-C4nmqiffA-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Eric Biederman <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, 
	Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:33=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/02/15 6:46, Paul Moore wrote:
> >> To quickly summarize, there are two paths forward that I believe are
> >> acceptable from a LSM perspective, pick either one and send me an
> >> updated patchset.
> >>
> >> 1. Rename the hook to security_bprm_free() and update the LSM hook
> >> description as I mentioned earlier in this thread.
> >>
> >> 2. Rename the hook to security_execve_revert(), move it into the
> >> execve related functions, and update the LSM hook description to
> >> reflect that this hook is for reverting execve related changes to the
> >> current task's internal LSM state beyond what is possible via the
> >> credential hooks.
> >
> > Hi Tetsuo, I just wanted to check on this and see if you've been able
> > to make any progress?
> >
>
> I'm fine with either approach. Just worrying that someone doesn't like
> overhead of unconditionally calling security_bprm_free() hook.
> If everyone is fine with below one, I'll post v4 patchset.

My guess is that based on the previous comments people are going to
prefer option #2 above, but we'll see what everyone says.  I did have
one comment, below ...

>  fs/exec.c                     |    1 +
>  include/linux/lsm_hook_defs.h |    1 +
>  include/linux/security.h      |    5 +++++
>  security/security.c           |   12 ++++++++++++
>  4 files changed, 19 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index 3aaad75c9ce8..ba2f480b2bdb 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1223,6 +1223,18 @@ void security_bprm_committed_creds(const struct li=
nux_binprm *bprm)
>         call_void_hook(bprm_committed_creds, bprm);
>  }
>
> +/**
> + * security_bprm_free() - Notify of completion of an exec()

The short summary above doesn't match the summary below.  If we stick
with the security_bprm_free() approach please change "Notify of
completion of an exec()" to "Notify LSMs of a bprm free event" or
similar.

> + * This hook is called when a linux_bprm instance is being destroyed, af=
ter
> + * the bprm creds have been released, and is intended to cleanup any int=
ernal
> + * LSM state associated with the linux_bprm instance.
> + */
> +void security_bprm_free(void)
> +{
> +       call_void_hook(bprm_free);
> +}
> +
>  /**
>   * security_fs_context_submount() - Initialise fc->security
>   * @fc: new filesystem context
>

--=20
paul-moore.com

