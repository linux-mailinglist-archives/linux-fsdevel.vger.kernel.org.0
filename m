Return-Path: <linux-fsdevel+bounces-10650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476E84D0FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C72844BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFB385654;
	Wed,  7 Feb 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SWReDU48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0029823DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329551; cv=none; b=XKanC0w1dVRa1SBTDwLs3PIdwHS7qW5zXBUu2p0b2nvZNcsWNme+kPcSA2iK/hP6aYIyHavk2BXC+Ac2CdJwR9QG1D7f2kYKac2BfDIu0MhJZNg7iz4x8wF00yOh2KxNBOUNdFnBnW37fRCwpcf+SJ6iKLngKYkIa8uRjbrP1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329551; c=relaxed/simple;
	bh=HemVGK6zZne3B0GajBNYqVima/P4OLJW7RPvot4BnIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFdO7cAre8B/1n+hnPnJkTN44BHStejIyScC9lPUv6YQnJxc0W13LbOo7EsWKE0oBhAFhyBFImBCFDZm6ARnSx2mHf+bCCi7fSyt5Z1tLoMWAbgD0ZwWdqlfdn9dGF06Jpfv2e29Ty8wJQmeEyRHYW6UvXArPwne3fBLxhhN4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SWReDU48; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so974690276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707329545; x=1707934345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hHXbmrv3ps1sMVSmLFG15zm3/Plob5tS/368EqKz5w=;
        b=SWReDU48FE7BclzS2BxrGrfX+g+CGjiVq0wUg09cuz9SyES6ugYQ7Lm6UvTijviwcO
         tSkY9hIEDdWyIdw0VWpCZLPduw5Uxtrn6aLpU2VScppiocx0+zKxTVby62emzn8JcOth
         yFRa0KaCzlOjDXa8L7VecFSlHMKb4eG/N/zaZJyQxcpoVAN3wH+Rf0pDiWsfTTLVdW6D
         6js/jtMKe06gp35Nziyib/+X8yA7wazlz0VXWZddYfeQPgiYvx9ziTvG47XTWvvI5nby
         L8t+zNZ/XYGWX1B7kG7BWW9yE5D03ZoJIw2BoavzC5rh1s5UORbC+XfkdQ7jchiRNCZn
         L/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329545; x=1707934345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hHXbmrv3ps1sMVSmLFG15zm3/Plob5tS/368EqKz5w=;
        b=Lwlh1hJM3z/UdnQib1KX+baXreLT68Sg/K6hJ27qK4RwC30spzUHAzttXYs3nuvwir
         1Tv6zxMOHjUTEuhYGETY864Qyk/FnezYYQhdKntrUl7LS4gRJbg/27AsqZKcs6PwrrY5
         cr0jtkN5obtJmONTNPhUINnXVg/0JDiFbMmI4l4h5sA4nvdDe//tr2HI4ip53+Waf/fm
         dJ1Z9q2Tncxl9+dkg+19cg0blE5sfZG9GNj4q3yM6fnL7/l88CgDi6HYsbW6ZNYzOmyR
         Zn+zaN3MHkE9DZqCu27AQGBRODM8Apsq7c0XbOghcK0uzBJVWZCE2+81UrA4ja0/nmvg
         sUKw==
X-Gm-Message-State: AOJu0Yw0laB+B+4CAOBLx7QEB5sLziqlJqNDm3xwF5ADoi8ZXqTDElUO
	uNRmjF1hZB4KrF2yOlr8DPbV9GeJBikDcKlH5W/K+zlclgPlRdWa6xRfvUXSuQS5NQzqNuuOXTq
	bfNpIpRQhLc8yQy155EE/e1pnQ+r3xTkxdS8x
X-Google-Smtp-Source: AGHT+IHxnQ5vAEAJSNuMes3+eXgpNC1vkbsCULnqxfu1b77zpdub65nMVS21AFiTfVqgPjNJ25GA/1LSAKxOdxXqZY4=
X-Received: by 2002:a25:ec0e:0:b0:dc7:1d:5db4 with SMTP id j14-20020a25ec0e000000b00dc7001d5db4mr5835418ybh.34.1707329544772;
 Wed, 07 Feb 2024 10:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
 <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
In-Reply-To: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 13:12:13 -0500
Message-ID: <CAHC9VhQ4UZGOJg=DCEokKEP7e5S62pSax+XOgiBB-qQ=WGCbOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Okay, let's get confirmation from Tetsuo on the current state of
> > TOMOYO in Linus' tree.  If it is currently broken [..]
>
> As far as I understand, the current state is working, just the horrid
> random flag.
>
> So I think the series is a cleanup and worth doing, but also not
> hugely urgent. But it would probably be good to just get this whole
> thing over and done with, rather than leave it lingering for another
> release for no reason.

I've always operated under a policy of "just fixes" during the -rcX
period of development, but you're the boss.  Once we get something
suitable for merging I'll send it up to you after it has soaked in
linux-next for a bit.

--=20
paul-moore.com

