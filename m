Return-Path: <linux-fsdevel+bounces-10629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C36E84CF35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF921B21959
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B781AD8;
	Wed,  7 Feb 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6PXEEPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE581207
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324316; cv=none; b=a61piDUfWTO9F6vF7HHb71bHm36UP7RKd7p+v2vE5/4MRsgLNbdxOa6SDw4RdWUdA3FREL2tBuQnzk9i/OOeIZ2IA5V75vyfDbkqEAN0+6REBfviW1c5u6/bjXN3SWyWEuB2oDI2ZHMkGIXv+6mYSWFC5Gl6/m/A2jmwVm+WAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324316; c=relaxed/simple;
	bh=jX1o2DqvrsVX0Ygwc04l+jqit2/Rd//ugPrvxIoI0Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1VGjVcY6zufHMJGxqcZSIeS3NCXM8wCGCBV6/luZ4bmm0OyThG3uiBJvYxTGInpP00rLkVqKgdNOL94F4h/IAAjZlwj1AxU7Ck9wzabWILpBg9g5Mwl+MF7J3e4DZViU5056aNrcvfHLsVAaiziZqEiIVOPF58N5R4HP19yZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6PXEEPK; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-604966eaf6eso6441687b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707324313; x=1707929113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+RVmbChygOBAmJgHT868vpaz7uzT1TsygZuYJ78CkQ=;
        b=Q6PXEEPKhVwQ0kPkyUuCmFZmJvRBtJDjCwG92W00qtmlbKFfQnCxuiLerP3Eht2KzT
         tMh962ihgzeOX704jHS7OdJSNAN7MobRFV67cUF2Ni+rxAG+ZCer0YIgPs2sHsYi/pkq
         q9DAqtlbesMRkBAxR2REnehYh+mc+dNa11SKxdVlzBjTwRoOOD9jmsnBRCoC3Ta43mKB
         HmLP1hNmtYhBhzN3fMYLi9OAht/3DWzoKqyH9+PcO2TU5hvcVBTcY3ICsNgU51cvGjDZ
         IhAvsczAwFIkSzvxh1iET00m3Cda+utAsMpWG6yU8H/sof51MAtjq/uRoidY/Cn/3BnL
         w5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324313; x=1707929113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+RVmbChygOBAmJgHT868vpaz7uzT1TsygZuYJ78CkQ=;
        b=otaRnxFAvkn9xAi0jR6I6JPSAFM6OiHBTiDNhuVPbxoanvGmzlIAdAFpiJ/KD7KOyF
         4s+P6LIqWafgM7YeqRFa2OwBqjkcdaZPZoOkjKngzPNbmZIbaVE7LwPvitk41QYrR6Pt
         TszuHQjdZY1u96WYpsVo+a8WHB/KlTfstM5Zs+Uv+cdtnw8qE7j1xQAcH+mjqlgmGnKn
         NbXZPaPsnDmflnD6VRNMSL3SAmYc5sF67bEszLz27JJA0djqB7mUaVeMyJoJnr/igxRE
         WGerMUG+mQ5poBy/GtQODd+JS+ssBIG23vnu3aMtxE7uNc9R0FgJoP/62P93lDd3qare
         zy2w==
X-Gm-Message-State: AOJu0YxPSRbyqYEGIeJ+e8FkP9ES4QomEQRIiOESIjT37YLBwvXqdGDZ
	SYitQ6yptgkMsVG31hzXTR5hMGkpI68AxytBSGwpTaN6Ra+O7GYKX4+Z2Hjuzk6N1dgboILwyU2
	oLSii+ldbzTwZCoGSa2IfIMSHemzZyUlSVYuK
X-Google-Smtp-Source: AGHT+IHRgcgMxbkrsPyJQIEFMLZQE+5SzwFbUZBRUzL4DU8q0Ya24A0FTp6644UsHQnVPJ1XIg6pqBWs0HQgn0Qzw7s=
X-Received: by 2002:a05:6902:1b05:b0:dc6:898:150d with SMTP id
 eh5-20020a0569021b0500b00dc60898150dmr6082425ybb.25.1707324313368; Wed, 07
 Feb 2024 08:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook>
In-Reply-To: <202402070740.CFE981A4@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 11:45:02 -0500
Message-ID: <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:43=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
> On Wed, Feb 07, 2024 at 10:21:07AM -0500, Paul Moore wrote:

...

> > Please hold off on this Kees (see my email from yesterday), I'd prefer
> > to take this via the LSM tree and with the immediate regression
> > resolved I'd prefer this go in during the upcoming merge window and
> > not during the -rcX cycle.  Or am I misunderstanding things about the
> > state of Linus' tree currently?
>
> My understanding was that TOMOYO is currently broken in Linus's tree. If
> that's true, I'd like to make sure it gets fixed before v6.8 is
> released.
>
> If it's working okay, then sure, that's fine to wait. :)

Okay, let's get confirmation from Tetsuo on the current state of
TOMOYO in Linus' tree.  If it is currently broken, I'll merge the next
updated patchset from Tetsuo into the lsm/stable-6.8 branch and send
it up to Linus during v6.8-rcX after some soaking in linux-next.  If
it's working, we'll wait :)

--=20
paul-moore.com

