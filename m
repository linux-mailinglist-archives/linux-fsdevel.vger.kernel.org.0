Return-Path: <linux-fsdevel+bounces-67308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8F2C3B2FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2EA24EF740
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9531A7F0;
	Thu,  6 Nov 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXPWslVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFA632E722
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435162; cv=none; b=Y4+UK/bOohwII0+vQi9aVHlB8mPPTw5/6y2yGwhr1V3jd8muLyqE68DtKoKaQccpcFJlRS8bcam6Ss/lJmEJ1jTBSHqi0F3FwCOshK6276O3lpP0Gr1dqvM1TiQ6+OiYF91AZbeuwb2qZoTNSgkDELPBagHA6zjfyxrP4q//5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435162; c=relaxed/simple;
	bh=DeEJsga8X2O3ZMGaj85I+rgHyhM9Q10HpKR+YWn5rS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2pS03D5sIQrcRUgumJNAKFmjvtbBN2i24wKF8vTw8T4+OPBuCvAJ699kcwWzqwxkZn+dGtzFb5NAptwiIVjo+KlJ6WILi+nf2Jv6Zo7KEW9MooSpMc3d3Nmvgq0nJ3XL8LW1YQaahWdNZFl8++slaoOz2VnDYgziIVN8xNTRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXPWslVu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640f8a7aba2so1388967a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435159; x=1763039959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeEJsga8X2O3ZMGaj85I+rgHyhM9Q10HpKR+YWn5rS8=;
        b=mXPWslVuBQVVKJHqjsCQ90hn2UIUrTPyaL6lzw1gKGOqWAmH2gIiR3Y0kNYyy0hE3V
         ueHEoPjqeKiElyWfcGkhqWZLXhDi82p4WX48Zl6fK+3pmwnaYks3RTfiMtUwB9hwXwEd
         8O5jopzFO8RWZBwhUI/qlN372IwPFoujdgVFdqjAEXBZ+ZXMD2JySdbEUEL2ZTxO7x2p
         yTfhv0UW4oNKrQ/eeuw77xm8pPjLb5aWb6/c/tS8OHg0n15paU/+z0JTlSFzRDK1yE4d
         wJZJ5byPQJIVVreXQPBx5vOSaB/GEjfKJtgq7NbanZpn1rIHOn061OPJOZl7m2dBC22b
         bzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435159; x=1763039959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeEJsga8X2O3ZMGaj85I+rgHyhM9Q10HpKR+YWn5rS8=;
        b=SwrNKnlNiP9LzNMd+gIejdkQADHrhVnvvqtak/Z/qC/7Q7OG7yb2OmtkZFKICYdWbS
         /Po8sWOvIlt//k6VNy29HtIz7cnD8ikI+sGF2W9/NVFYpRL5CcqIqNS7dV8mMuxINWNz
         t+pqYk3MIilOqD+jk1R9auE4nP3WlGgL/JH2TuVxJJ3xHfRBVFVxXX7LYg0w7+TqbMU3
         wynBTOEzeEFQhAzE9phqAbsjJPYk8h7sFzYSY8ep7geLfItne2VTXO/dpt9rJpveLD1l
         o+dxxYeOvispFOXcaHb4yDDyo2pxDIf9b2frIKdys1R922/h3PCHx8gqx7fcagWZ6Dht
         1abw==
X-Forwarded-Encrypted: i=1; AJvYcCVObk3tw5twXiwKyhVy3m5uGeV/sb6/HoJLLSzxs4EGmZBTvmuAiRNkUaxbVXo9i/IE0zI9i8oNOIeki+31@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4R8O+3xoYIyj6waH/G3HITI5ospl6fbNBdBy5uO4KG1f+rbE
	jjAd6hcNEGBUKXRynmtNwipjK0trlZtYE4SM8QjCQcSeN06G6WX33ki/ZO3Ng5aDWet8v65UK9i
	MbeLC6hR3Cnvm0qw0mUW0FfThbvB94Qc=
X-Gm-Gg: ASbGncsEFKbjO1UOa6oFMvzSglEQxG2NGybm3NByFn8+I6ZbYdZjS7hNnKjlTT5+4EE
	Fbz/95PlqazlIqUA3v9HHspTya/bFzebjgBBXUPEY4dQTN2I4RFOhCRpkgyGY+LL/hAgSS+tO19
	FsEqmurbs2PxF4eV7+BYjs2Zf9Hms/kUkUG4au9mv90m27etkdOFdKeRCoXMDU6k130zZheJMHP
	pxofNznqhQFrcGqITyHpMpb+VHGtRPiPkkhMU057lJoKrfeZDlO74jm9EewSC2pTK2Bf1NFVyb7
	ZUcPp1VvL5889GMlljAHVfTShw==
X-Google-Smtp-Source: AGHT+IGxs+sian8Sm9s90Hy3ND6mTfZ+z8i6/WtEjUDe9ivLlS1ryoHlAEFf7rvbGl8JcDIgKKkxWD6QKWjAKZ8vedY=
X-Received: by 2002:a05:6402:1d50:b0:640:c807:6af8 with SMTP id
 4fb4d7f45d1cf-64105a582f8mr6791886a12.30.1762435158807; Thu, 06 Nov 2025
 05:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <20251104102544.GBaQnUqFF9nxxsGCP7@fat_crate.local> <20251104161359.GDaQomRwYqr0hbYitC@fat_crate.local>
 <CAGudoHGXeg+eBsJRwZwr6snSzOBkWM0G+tVb23zCAhhuWR5UXQ@mail.gmail.com>
 <20251106111429.GCaQyDFWjbN8PjqxUW@fat_crate.local> <CAGudoHGWL6gLjmo3m6uCt9ueHL9rGCdw_jz9FLvgu_3=3A-BrA@mail.gmail.com>
 <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
In-Reply-To: <20251106131030.GDaQyeRiAVoIh_23mg@fat_crate.local>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 6 Nov 2025 14:19:06 +0100
X-Gm-Features: AWmQ_bmyw0pNYHXADFAd6fmPUn7Fnskg_NMC8tjfXErLEc176QKVF8M0jsu-KY4
Message-ID: <CAGudoHG1P61Nd7gMriCSF=g=gHxESPBPNmhHjtOQvG8HhpW0rg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 2:10=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Thu, Nov 06, 2025 at 01:06:06PM +0100, Mateusz Guzik wrote:
> > I don't know what are you trying to say here.
> >
> > Are you protesting the notion that reducing cache footprint of the
> > memory allocator is a good idea, or perhaps are you claiming these
> > vars are too problematic to warrant the effort, or something else?
>
> I'm saying all work which does not change the code in a trivial way shoul=
d
> have numbers to back it up. As in: "this change X shows this perf improve=
ment
> Y with the benchmark Z."
>
> Because code uglification better have a fair justification.
>
> Not just random "oh yeah, it would be better to have this." If the change=
s are
> trivial, sure. But the runtime const thing was added for a very narrow ca=
se,
> AFAIR, and it wasn't supposed to have a widespread use. And it ain't that
> trivial, codewise.
>
> IOW, no non-trivial changes which become a burden to maintainers without
> a really good reason for them. This has been the guiding principle for
> non-trivial perf optimizations in Linux. AFAIR at least.
>
> But hey, what do I know...

Then, as I pointed out, you should be protesting the patching of
USER_PTR_MAX as it came with no benchmarks and also resulted in a
regression.

