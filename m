Return-Path: <linux-fsdevel+bounces-8815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC583B351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 21:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FD128236D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B391350F7;
	Wed, 24 Jan 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQSaSBKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F851292FB
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129514; cv=none; b=Rn1rDsulDELmXRZsgIarl/ZTApoI97SA9gt/bZzMRwg8pBhJhiMSgOlbpvZodSxxAGfrmdFFdEjmhCFP8q0rYiJleEPY2J0RK2pmmkLd5txe9tE1TI2Bzypatt/8/6UIibcXIaK/FwpNCbHmrKnaZeUwLZ0pHfr+ADiUFCUHaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129514; c=relaxed/simple;
	bh=8AHF91uvt8/XRr8nVpdx7OTkc9kUJK+Zdwkb7E1C+tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9IpMe3s2kl0uj09gl+MWxBzO1uD6/XCs+HQYbjSFvYTZu4Q8qwQJBX5BdP55tSi+VhuBf9VrDvjvcexGujqB2+KLtaBFaUEGFuUGou8hyyxR+9u8YjSJwJNeGaXxnvrnWDyDfjRB5FHFVC5NtaSx3LXvYV1mZqcfN3sr8H74Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQSaSBKc; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso4395a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 12:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706129511; x=1706734311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AHF91uvt8/XRr8nVpdx7OTkc9kUJK+Zdwkb7E1C+tM=;
        b=QQSaSBKc5YXRrwseT28VLCXtVbUV7E9Jtd5kb0ypblZapUB9tDqWdtW/mMUMI/O2Ti
         KfZs9FX4LFcnev1OX1te+yEtwvtIZttYte6zHJGP2FXcLJLiEyNiqY825ehFNXC/k+EC
         /hackWXgSmqIVPqjIMqXfvuZ8n4R6zJDGptfgjjnCj0qUgEpETladENJuZqUMhLQsIMK
         NMHCKThaIMl5Cm7T3cwHqPfUL7LjR2Wnhe9jEiZ5qDX9Q5jB6YksnZAkwzAFcjcz6YeK
         XFNvQrPkMckc5mxcR57G7tAcrdehDi+1YysgeQ4jlw7tl9pegfzFgy8/g64iSMF40EN7
         Utrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129511; x=1706734311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AHF91uvt8/XRr8nVpdx7OTkc9kUJK+Zdwkb7E1C+tM=;
        b=J1ti0JKfpC9AA/w9pRpM6OQWQYCMYOYmWD4reXOdN652lLjLhrRh5ScVn3MMrhzdOu
         zphxN/Qj52XbOtVZawgd4zjU6EqLCMe+GOyCInn2lvNykWQQLZdXUGlEH3QB4z/VEPJR
         P3t6AVzDdalj6F9R7UkzJGijAUBcBWN8iDqB7ZfNa+Fojk25au4KOFyEC9Vks+Ck3aOt
         jTe4Tuaq8Zon88cwEN0b4IWg4vrmKUkRrmijmh/tHQ/jOgkT0U+IPxTND2UhCvf0IRjW
         Cvi95JArWqSjBrNYx81OB7AF7zMdfxzAWQiN7rmRs2t4Br4HpUWE3XCoKLUuCpBkSvlw
         oZng==
X-Gm-Message-State: AOJu0Yz9KNOaKs6pqBK5ZxsWpQWRhWPcS3+m7thPMcQBdjGCD/F7XIm9
	6OzSqWFgQ5XMALjTfOyCpoq4reYrEB0mUnfPL21Dla05y1Wfn9M3JDcjqytma0Ca5BhuhAjT3CJ
	rCEotVsWEp+mQJvuWL8OSW5xjWrjYgkgcmxcG
X-Google-Smtp-Source: AGHT+IFSJu3YtHxJ1C9xsiD6VboT0OpL149sYEOn3JiasNKwbqmVCWDsj+0AThh+onMYWiLSwFji1svlzJHw50Lzx7w=
X-Received: by 2002:a05:6402:b77:b0:55a:7f4e:1d62 with SMTP id
 cb23-20020a0564020b7700b0055a7f4e1d62mr47583edb.4.1706129510820; Wed, 24 Jan
 2024 12:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook> <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
In-Reply-To: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 24 Jan 2024 21:51:13 +0100
Message-ID: <CAG48ez3v=dWVNaLwQi_f0j5X2+g5e9ubuaZoEkivsCTVK5u24Q@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Josh Triplett <josh@joshtriplett.org>, 
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

On Wed, Jan 24, 2024 at 9:47=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
> >
> > Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> > CONFIG_USELIB, even though it was reported[2] to them almost 4 years ag=
o.
>
> Well, we could just remove the __FMODE_EXEC from uselib.
>
> It's kind of wrong anyway.
>
> Unlike a real execve(), where the target executable actually takes
> control and you can't actually control it (except with ptrace, of
> course), 'uselib()' really is just a wrapper around a special mmap.
>
> And you can see it in the "acc_mode" flags: uselib already requires
> MAY_READ for that reason. So you cannot uselib() a non-readable file,
> unlike execve().
>
> So I think just removing __FMODE_EXEC would just do the
> RightThing(tm), and changes nothing for any sane situation.

Sounds like a good idea. That makes this codepath behave more as if
userspace had done the same steps manually...

