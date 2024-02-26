Return-Path: <linux-fsdevel+bounces-12867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6202D86810E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9A8B233A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 19:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4C312FF61;
	Mon, 26 Feb 2024 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IDawg6Dh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46B12F361
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975477; cv=none; b=YuT6OEnw8cl8duNsgbwZMe8e2pbqPF7Z0tdP5ZuBuMv7N+yTrKgcUSOE4gTHmgJNpVmHUJ8O56Flhldys6RHgXRUYC0Ad7BK6wAOiU3HvfNsIExZxt6uKLOoJQwqC9440O9ikf322vWBnLD5XLfmey+1t8GO3FbDIzhc48U6zjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975477; c=relaxed/simple;
	bh=THgm6rGLpzdRlqCmuQGYCh3G2e2uZuhgn1thuX7TM28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdQ+FeFUZcdBEhJe3GMxtPhpg8+TzIEgr1QrHFzpwWhOJ4ZctqV4WB9AE7V72FE23vo8PdL5whvjjS6UdXNLNbLfXh0V5vAR5sG3OJogqxOzlhenooC5lB71xT4YLsE6zsPjrUaFtpIpUftXIuxBgf0zOSuC3jJPSvTiryP/IZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IDawg6Dh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc0e5b223eso28772695ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 11:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708975474; x=1709580274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=InMne0CIdEUH5H66AFxEIsfbiaQhDQQyahGGSNpAGCM=;
        b=IDawg6DhM0XUTrV9XNtDtxehkJZRJwGpvO5ptOOXE9onzexPKtwIc1EQvwTOiYXXIu
         S8+A3bnPp5HmicrtSCh+6mmZ7MeMB+WA/0WQvsTlVdIAruUkqYkfSTxVc4HJMrySEMFp
         dCIo/mHxl8iSUS620NEsHqSX9wr6vpT6/mQcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708975474; x=1709580274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=InMne0CIdEUH5H66AFxEIsfbiaQhDQQyahGGSNpAGCM=;
        b=gYGGLrE8gmWj1AHoUtb5u7V4EkhGjnQO968VMrgCcmV26Zjtrwzu5ejZYabrT271sF
         hC9+NJy2ScWL3tJEij7zgdTo0x4S0aUDGvIZA5sIEeWsix9fK1lixEri9hkYeo6FoQkp
         BJYSm0NEtkkKwuBwu/shGtvcxwOKjoxlbBUnZnCp10ESmOKsEatEDXpL2rVtK+mTL10S
         3z4MaEmuoKvOTpatfOClNzSzF2YKdFyVS7rCTfbLwnNlFwDQeinRt6bymoxltKN3LEBo
         IbZhBXft4XdioNJASVGEKnq7vwftHjipXe/3eEFNuYoV081PH619IQnyXI8+T/7jgBRE
         Jqzw==
X-Forwarded-Encrypted: i=1; AJvYcCXnpweRrIoGzEayzCTKDca9l7WKvmFxCHWdfA9wNKjKe4v05uSscHQsojCESlsMQEbF8+ZJphwo2YP/+25BaOCt2AOkN2+84Y8Dsejfhg==
X-Gm-Message-State: AOJu0Yy1X7u7X47a7ifJkhofCI/JxUTg6oKOE7KPtwsskE4xI0gQe3py
	4BF3ymdbRAvVIwxl5erkl0aPBGwVchKFdk3M7eqgbl1+Ot2aCsoYW5PTzvo1Zw==
X-Google-Smtp-Source: AGHT+IGuKJW5UHzRannH3J/uDHtHCTUjnDGiC7Kw9nAZoWU+O3ZdeIO5FhWpusWjRzPLtJW8pjElAA==
X-Received: by 2002:a17:902:e94c:b0:1dc:ada9:bceb with SMTP id b12-20020a170902e94c00b001dcada9bcebmr1895063pll.5.1708975473701;
        Mon, 26 Feb 2024 11:24:33 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903308d00b001dc2d1bd4d6sm51088plc.77.2024.02.26.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:24:33 -0800 (PST)
Date: Mon, 26 Feb 2024 11:24:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com
Cc: Doug Anderson <dianders@chromium.org>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
	Mike Frysinger <vapier@chromium.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
Message-ID: <202402261123.B2A1D0DE@keescook>
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202402261110.B8129C002@keescook>

[sorry for the duplicate, fixing Jann's email address]

On Mon, Feb 26, 2024 at 09:10:54AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 21, 2024 at 1:06 PM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> >
> > Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> > after which it got allowed in commit 198214a7ee50 ("proc: enable
> > writing to /proc/pid/mem"). Famous last words from that patch:
> > "no longer a security hazard". :)
> >
> > Afterwards exploits appeared started causing drama like [1]. The
> > /proc/*/mem exploits can be rather sophisticated like [2] which
> > installed an arbitrary payload from noexec storage into a running
> > process then exec'd it, which itself could include an ELF loader
> > to run arbitrary code off noexec storage.
> >
> > As part of hardening against these types of attacks, distrbutions
> > can restrict /proc/*/mem to only allow writes when they makes sense,
> > like in case of debuggers which have ptrace permissions, as they
> > are able to access memory anyway via PTRACE_POKEDATA and friends.
> >
> > Dropping the mode bits disables write access for non-root users.
> > Trying to `chmod` the paths back fails as the kernel rejects it.
> >
> > For users with CAP_DAC_OVERRIDE (usually just root) we have to
> > disable the mem_write callback to avoid bypassing the mode bits.
> >
> > Writes can be used to bypass permissions on memory maps, even if a
> > memory region is mapped r-x (as is a program's executable pages),
> > the process can open its own /proc/self/mem file and write to the
> > pages directly.
> >
> > Even if seccomp filters block mmap/mprotect calls with W|X perms,
> > they often cannot block open calls as daemons want to read/write
> > their own runtime state and seccomp filters cannot check file paths.
> > Write calls also can't be blocked in general via seccomp.
> >
> > Since the mem file is part of the dynamic /proc/<pid>/ space, we
> > can't run chmod once at boot to restrict it (and trying to react
> > to every process and run chmod doesn't scale, and the kernel no
> > longer allows chmod on any of these paths).
> >
> > SELinux could be used with a rule to cover all /proc/*/mem files,
> > but even then having multiple ways to deny an attack is useful in
> > case on layer fails.
> >
> > [1] https://lwn.net/Articles/476947/
> > [2] https://issues.chromium.org/issues/40089045
> >
> > Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
> >
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Signed-off-by: Mike Frysinger <vapier@chromium.org>

This should have a "Co-developed-by: Mike..." tag, since you're making
changes and not just passing it along directly.

> > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > ---
> > Tested on next-20240220.
> >
> > I would really like to avoid depending on CONFIG_MEMCG which is
> > required for the struct mm_stryct "owner" pointer.
> >
> > Any suggestions how check the ptrace owner without MEMCG?
> > ---
> >  fs/proc/base.c   | 26 ++++++++++++++++++++++++--
> >  security/Kconfig | 13 +++++++++++++
> >  2 files changed, 37 insertions(+), 2 deletions(-)
> 
> Thanks for posting this! This looks reasonable to me, but I'm nowhere
> near an expert on this so I won't add a Reviewed-by tag.
> 
> This feels like the kind of thing that Kees might be interested in
> reviewing, so adding him to the "To" list.

I'd love to make /proc/$pid/mem more strict. A few comments:

> [...]
> +	if (ptracer_capable(current, mm->user_ns) &&

It really looks like you're trying to do a form of ptrace_may_access(),
but _without_ the introspection exception?

Also, using "current" in the write path can lead to problems[1], so this
should somehow use file->f_cred, or limit write access during the open()
instead?

> [...]
> +config SECURITY_PROC_MEM_RESTRICT_WRITES

Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
sysctl, but that's be harder given the perms). That this is selectable
by distro users, etc, and they don't need to rebuild their kernel to
benefit from it.

Jann Horn has tried to restrict access to this file in the past as well,
so he may have some additional advice about it.

-Kees

[1] https://docs.kernel.org/security/credentials.html#open-file-credentials

-- 
Kees Cook

