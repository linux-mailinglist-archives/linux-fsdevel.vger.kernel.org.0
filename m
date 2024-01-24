Return-Path: <linux-fsdevel+bounces-8822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F9283B42D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 22:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05A61F242EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E06135A40;
	Wed, 24 Jan 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzlf/m6t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B41135400
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132490; cv=none; b=K3D5Y2PBzJNLbJxH7Jkul2IurCWQtxJZ4UpADY9U1Re6/r6WbaxDvsqPuspeBSVlBu+HfFg7oXPqKDRRBPRN6+UTh20iKpAhuDi5xc18ySKWIk4NW/p42SAwRAX5lGJ7Us26iwyiGpZMrKyfQQOvyEkB2oRLjhr5plDmCva7Uto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132490; c=relaxed/simple;
	bh=qfJAC4HXvVMWIYaEASPBnMaLjXS1T8A8l0vIjG+Z74U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBjgskV+G7Is6Jy10NqwTjv8CSdyb9Vv9N7K8YyO62CxtnrivWTmHbvXww9ZXcfooaq0w51KYDoRzhA8d/NCFRJkOu2uVsq2sUndO+7UTMh01hJdjbBqcecB/i0enVOHEzAWXpYql0krFeMjjGqTNPY3pTMUlOZ5PHL4TjUYN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzlf/m6t; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so654a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 13:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706132486; x=1706737286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NToZqtE5w7bxKN+3pRr0bsg8tIkz9lpNWRvoqa9C32U=;
        b=jzlf/m6tFfcKIWBxQ44N60HF/GbGGhvCmrah/cagGrVrfThExacQOUHuAMvJQ+57t5
         +FTOk5nK4+2WVT8MV4FJh5PgPXt4jJyEKCP5EWfqnqtVyBLrvriqASsEGe4sWzZkIgdP
         fKkgi21+XGaHfHKICLoxda0VEwxKCKkYxrbwsFabJM6n4dpUlv8i+bWJ8WIqcYfsM/Cb
         4yQFmOSt7zFyWnVT8j1leWfjzXi3cdnm72fbR7saOr/G01pYrYYXzOltjNG+d6N2VKI2
         D6cQDbt2W8WKBXPFymf6aEwfK64nWdSkQX2HdNMtI96NV7bfYquFRkiJY8BBzQFtSuBH
         KSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706132486; x=1706737286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NToZqtE5w7bxKN+3pRr0bsg8tIkz9lpNWRvoqa9C32U=;
        b=He2mLsHJGKJfZRbqliOkolVhGQ3j0hsWna8jaAFZCT0hXZBnhyqHkXBVc5BSQCL04s
         EaywsY5PK0ykST1rUjugwdeHz77DhR60LNFqscxxq9cfmZgSVO30oi2eflW6XaIhTqXX
         QE5TQLi6qSTXVXaf22B9GjCA8N53OAgD+Dz7OZkLWcTSZmlcMODiIpDY2Y9tcr2WyvLb
         SpN8TfSyU+CKj8ZHuD2B16M6E1NoSxTh5mWP2cxed8SO+8jDW9Q6NoP/6915jAPK1vfH
         RJh8FESPOTxTqomPwOWS+W+Nd6HI2Ch8qKBXFQ4R8phnIPwIsLFbBhPVTM7XxyMpQXc5
         5VMg==
X-Gm-Message-State: AOJu0YxK6l8mUAV/tG1oN7PPTVk7i6PVSrii82yaP0BtWo0F7fuds7aJ
	ZstTH1ya7i12GFX0jVIrSmAO1BLaepT3Ib2ktuKlhiCKNfOp80FhEqw+n1kUFs1Y0ifieg6Fqsm
	uAytZ7AU1Ej2PyqUBhYn2bEZ+IjTOXh+itXSF
X-Google-Smtp-Source: AGHT+IHauIX2Vpg/PHzzW0JTV4fDFuqXAIYuBOadb1Lhdqvm+7hcjrHyfDr8nUiI/Qt4r1fFyqSNf90c4QBY22tL2Fo=
X-Received: by 2002:a05:6402:290b:b0:55c:2493:2b31 with SMTP id
 ee11-20020a056402290b00b0055c24932b31mr11642edb.3.1706132486242; Wed, 24 Jan
 2024 13:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook> <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook>
In-Reply-To: <202401241310.0A158998@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 24 Jan 2024 22:40:49 +0100
Message-ID: <CAG48ez1tcxtEwWgxSUqLDcYbrkY=UM3hz22A0BTvTYq4BGpM8A@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, 
	Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
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

On Wed, Jan 24, 2024 at 10:32=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Wed, Jan 24, 2024 at 12:47:34PM -0800, Linus Torvalds wrote:
> > On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > > CONFIG_USELIB, even though it was reported[2] to them almost 4 years =
ago.
>
> For completeness, Fedora hasn't had CONFIG_USELIB for a while now.
>
> > Well, we could just remove the __FMODE_EXEC from uselib.
> >
> > It's kind of wrong anyway.
>
> Yeah.
>
> > So I think just removing __FMODE_EXEC would just do the
> > RightThing(tm), and changes nothing for any sane situation.
>
> Agreed about these:
>
> - fs/fcntl.c is just doing a bitfield sanity check.
>
> - nfs_open_permission_mask(), as you say, is only checking for
>   unreadable case.
>
> - fsnotify would also see uselib() as a read, but afaict,
>   that's what it would see for an mmap(), so this should
>   be functionally safe.
>
> This one, though, I need some more time to examine:
>
> - AppArmor, TOMOYO, and LandLock will see uselib() as an
>   open-for-read, so that might still be a problem? As you
>   say, it's more of a mmap() call, but that would mean
>   adding something a call like security_mmap_file() into
>   uselib()...
>
> The issue isn't an insane "support uselib() under AppArmor" case, but
> rather "Can uselib() be used to bypass exec/mmap checks?"
>
> This totally untested patch might give appropriate coverage:
>
> diff --git a/fs/exec.c b/fs/exec.c
> index d179abb78a1c..0c9265312c8d 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -143,6 +143,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library=
)
>         if (IS_ERR(file))
>                 goto out;
>
> +       error =3D security_mmap_file(file, PROT_READ | PROT_EXEC, MAP_FIX=
ED | MAP_SHARED);
> +       if (error)
> +               goto exit;

Call path from here is:

sys_uselib -> load_elf_library -> elf_load -> elf_map -> vm_mmap ->
vm_mmap_pgoff

Call path for normal mmap is:

sys_mmap_pgoff -> ksys_mmap_pgoff -> vm_mmap_pgoff

So I think the call paths converge before any real security checks
happen, and the check you're suggesting should be superfluous. (There
is some weird audit call in ksys_mmap_pgoff() but that's just to
record the FD number, so I guess that doesn't matter.)

