Return-Path: <linux-fsdevel+bounces-10628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A235184CE82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591D528907D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6893880057;
	Wed,  7 Feb 2024 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YeF10JYz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBC480048
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707321677; cv=none; b=a8WB19NwQ2k2g4fplTZbQ2gb29GACp9unZqVKox2aCkeiVALnTv9IABzJl8FMyYo3KXl4F9gJQ2JlfJKoKbnJrrSi+DlWrV0S4hO040ZHGzt+O1dETmkqUoQovV9+b7fFTcDORlXc6TfTwp7UamUOKkz+x5vTc0Gbt+M+EwVq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707321677; c=relaxed/simple;
	bh=tRFljhwMB4MgO3yaAsgqXOkez35UfRXvUgw0a7Rtm44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/BlPmVX/i3hXufQPHcQ96Sy0S6dM7WV4mMVDGN0oldq33w4M9P+KKbc0VFVoUlNsbHFe2UmojNLW0wZWH+/2bd3K+oilZEIy+PI6z/e3h0b1gtoUvs0Zj1uCM/t6ib6j3kx6DlmlJJrtRwvT/xp4CtNuyzE+U/9xl3EOLpA6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YeF10JYz; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6de8a699dso756794276.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707321675; x=1707926475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxtNW82JBl+/qv1Lfklex243MjNUyJXmyfgEwoYAhcA=;
        b=YeF10JYzzfnJq2ooJA/bx8bvFQbVVM4MFXMpTjUIhZxRdaDxN1XcfX3QXfc1turHFz
         4OAmaRelm0ulI65ayKuXfYa1vP/Y032a7DvaicaHjZumNNDzmqF5lFBSqhFpVOZKr7xz
         KspEwrTBJeiY370aIm2OLCdok74xosyrvDqkKE2dKmmy9/+VDT6XHpBAvDpJW3oOBJF9
         8c2k8Ba5IQZ2gbTmoeac76gFIKf5SNu1IQmDZycobLYzKSwrz9XdeS6T7c6Gq071qXtS
         A5KcQz4uuLx2f+m3k/PaGvIbijYgIneL0gYHxz87bNQYrJUIiR2bRZgn0zd/kLh+JpDO
         Pqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707321675; x=1707926475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxtNW82JBl+/qv1Lfklex243MjNUyJXmyfgEwoYAhcA=;
        b=iGV1fHMO5ZXZM7IMdVg6nNqAHktV1cqlD5JUw7ZUsJXE2+6QmNbmNOjRVVPeyC85W7
         rLhEYtMIGCVGncgY8b68g/UY5F7O1pnexzxE30NHBvweP0AzcY+0gEfCnigIjLmfGx3n
         dECcOvPdFkeMC5r8GsQXUdrXRd1JtnZkleBVBDip/K+RQvwh625WM58GXi5EOOBZ/ab/
         8a7tcwOaxa9a0UVuj5bIPHL8UxxTXA8jbdfT0e/vMkZTbmZqXVjixImwUjKHPV8xTwN6
         Fn+e+j0aDhm+CFfPOB4hFHlJ8A9EX+v6QwU8EwYDG4YUAiacH7njJIAE/yX1hPwWal1m
         9O+w==
X-Gm-Message-State: AOJu0YxkVjBrKIQqaPcB4iMIGTln/61v8jIDySmHdXyfSMAdet3i5t/S
	CCvRSsABby3efgRm3RLMzIdJAtrN+LzwQl6SZqkbLRR/8n+nXlyi+OTog3rNfq6Opv1WLBP+47y
	wlEIQfq6AK6yU0YfbHpnLJ9OQ5azY22zMvAYMxvl1Hc3Z/gxH+Q==
X-Google-Smtp-Source: AGHT+IGLRof03AeG7moUMh3bNmzc2buHmfvITsFlKH2vkSeVCiedBCdAJ9+91kZrNNYraEEDXJYoLrCGtWdtB8t3AEQ=
X-Received: by 2002:a25:ae93:0:b0:dc6:ff66:87a8 with SMTP id
 b19-20020a25ae93000000b00dc6ff6687a8mr5182541ybj.51.1707321674769; Wed, 07
 Feb 2024 08:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <894cc57c-d298-4b60-a67d-42c1a92d0b92@I-love.SAKURA.ne.jp>
 <ab82c3ffce9195b4ebc1a2de874fdfc1@paul-moore.com> <1138640a-162b-4ba0-ac40-69e039884034@I-love.SAKURA.ne.jp>
 <202402070631.7B39C4E8@keescook>
In-Reply-To: <202402070631.7B39C4E8@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 11:01:03 -0500
Message-ID: <CAHC9VhS1yHyzA-JuDLBQjyyZyh=sG3LxsQxB9T7janZH6sqwqw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] LSM: add security_execve_abort() hook
To: Kees Cook <keescook@chromium.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:34=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
> On Wed, Feb 07, 2024 at 08:10:55PM +0900, Tetsuo Handa wrote:
> > On 2024/02/07 9:00, Paul Moore wrote:
> > >> @@ -1223,6 +1223,17 @@ void security_bprm_committed_creds(const stru=
ct linux_binprm *bprm)
> > >>    call_void_hook(bprm_committed_creds, bprm);
> > >>  }
> > >>
> > >> +/**
> > >> + * security_execve_abort() - Notify that exec() has failed
> > >> + *
> > >> + * This hook is for undoing changes which cannot be discarded by
> > >> + * abort_creds().
> > >> + */
> > >> +void security_execve_abort(void)
> > >> +{
> > >> +  call_void_hook(execve_abort);
> > >> +}
> > >
> > > I don't have a problem with reinstating something like
> > > security_bprm_free(), but I don't like the name security_execve_abort=
(),
> > > especially given that it is being called from alloc_bprm() as well as
> > > all of the execve code.  At the risk of bikeshedding this, I'd be muc=
h
> > > happier if this hook were renamed to security_bprm_free() and the
> > > hook's description explained that this hook is called when a linux_bp=
rm
> > > instance is being destroyed, after the bprm creds have been released,
> > > and is intended to cleanup any internal LSM state associated with the
> > > linux_bprm instance.
> > >
> > > Are you okay with that?
> >
> > Hmm, that will bring us back to v1 of this series.
> >
> > v3 was based on Eric W. Biederman's suggestion
> >
> >   If you aren't going to change your design your new hook should be:
> >           security_execve_revert(current);
> >   Or maybe:
> >           security_execve_abort(current);
> >
> >   At least then it is based upon the reality that you plan to revert
> >   changes to current->security.  Saying anything about creds or bprm wh=
en
> >   you don't touch them, makes no sense at all.  Causing people to
> >   completely misunderstand what is going on, and making it more likely
> >   they will change the code in ways that will break TOMOYO.
> >
> > at https://lkml.kernel.org/r/8734ug9fbt.fsf@email.froward.int.ebiederm.=
org .
>
> Yeah, I'd agree with Eric on this: it's not about bprm freeing, it's
> catching the execve failure. I think the name is accurate -- it mirrors
> the abort_creds() call.

I'm sorry, but I would still much rather prefer security_bprm_free()
both to reflect the nature of the caller as well as to abstract away a
particular use case; this is also why I suggested a different hook
description for the function header block.

If you really want this to be focused on reverting the execvc changes
(I do agree with Eric about "revert" over "abort") then please move
this hook out of free_bprm() and into do_execveat_common() and
kernel_execve().

To quickly summarize, there are two paths forward that I believe are
acceptable from a LSM perspective, pick either one and send me an
updated patchset.

1. Rename the hook to security_bprm_free() and update the LSM hook
description as I mentioned earlier in this thread.

2. Rename the hook to security_execve_revert(), move it into the
execve related functions, and update the LSM hook description to
reflect that this hook is for reverting execve related changes to the
current task's internal LSM state beyond what is possible via the
credential hooks.

--=20
paul-moore.com

