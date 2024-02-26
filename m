Return-Path: <linux-fsdevel+bounces-12843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FD8867E1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 18:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B996AB2CFF5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2D130E39;
	Mon, 26 Feb 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cRZGNXUg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C90130E2D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967476; cv=none; b=GtxDYWAoXMb6kp3xw0iSP6mZo3RRLlOqraOjVf7uU3KsmzWK+15CFt3P1LAQbOGiD2h7ZQelU6pEThhGyLOLVQpjOKDryvIZUBJePqC0M5qxbrp4Ms5k4tFq00XRIhxVYM7xwTJNWA6FJ3qc9EwP4VNtSmJxdLvsWTftJXBwWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967476; c=relaxed/simple;
	bh=Yt1iK6ApoRRAwYIAF8J0XZzIcb/oxLGRDCMiADPPzcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX7x70ISr7l+BBkzco9ldN7GVIy2CoMMwTY7lBPUZC5QC/ITZE5FBqCN4jaTGvldIKv0PiCz6897SYa3Rsw8hsrOZBDRzlGz6YYIcFACr1WU4wih6Mt6TmtX4sqmUXbGwSFSIOwUaFW0W4PwiSo1WfciOSjiwR411PovP0HhG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cRZGNXUg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564647bcdbfso3334275a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 09:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708967472; x=1709572272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOKxowLRXopwaSUBXoFBP7qAPcPHaHQRznoK8vOmNBg=;
        b=cRZGNXUg7tMrDIy/Trs+pcRxxdWR4fXE549Zjdszpu1xsb1bXRsUCtbM5E7WiJL85k
         rTgwTYNeAh5fTsFM4HUvr+t45+SJUdgFfsY05PVp07ATrKKPrXCgI+2gTpuM8cszSbXv
         akWHvy7Dtc7dWU4yLBmPGT49QxCTIe9258MiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708967472; x=1709572272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOKxowLRXopwaSUBXoFBP7qAPcPHaHQRznoK8vOmNBg=;
        b=pxG2R+3lPI3XX5XUhNNsrfgJ9NVbfRi/HMNg/I2phfKJqy2djtTy3ZFykFz2ZlFkBI
         NsO+CBq0LlcUpQrwwYaAXo9kci7YTt4R3+dyGhzb59B3mSKYG+0nN36rjIv6MSBR3IYd
         cAe0zU91AbDGH+x8i+Tlc8uS7GohCdOrM1J5uJmZ9NtsWlvjQDb6yT3UngqNH6w1KRl3
         sQFn9Xzi5S2ouuZQFDNolyKBVRKCCivVJD1s5Lh/hrx29y02gVGjpklP5cv2o+l4dfSJ
         kXEBdhCGJbN7j1H2H2cMK4M7xAFPh2WZUUn5XhzKNl4VmYOISl1M2BcXI7d8+f7Ecery
         PGnw==
X-Forwarded-Encrypted: i=1; AJvYcCWlYatK3e1EV+7/jVwTmWBMOzsKMXoOU3T2caHvvmxlRHmv2cVwlRuaIe+tPwYe1/vGLEN+Fd5P27V8QgujIK4UgL63pAc7dmFdtj9Qcw==
X-Gm-Message-State: AOJu0YxTKws+aFYl2nUExZ1jnI++jscbVCGw/W6j0YQsySi19nXxQKfL
	xKj8pqM0XzGsaRMf8MVSjzFDL7C5THyYiDw2hZqjJH73sYVlKroQ53vFSJFx8Lij15GekjBPfGm
	41BFK
X-Google-Smtp-Source: AGHT+IFYD/JksHBPuxsi0b3xVe/QXBdfRGVkU0C+rbip1PZJJWLXv5vGNd7ToWmN8ugNt7KWns3bqw==
X-Received: by 2002:a05:6402:5201:b0:565:a5f5:84d0 with SMTP id s1-20020a056402520100b00565a5f584d0mr4989959edd.22.1708967472292;
        Mon, 26 Feb 2024 09:11:12 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b005649df0654asm2494908edw.21.2024.02.26.09.11.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 09:11:11 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412a9f272f4so11275e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 09:11:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvESU7VCTE9a/SOmGxbbyrnTd4SPhCxK7YlsY7EmytI8mBz449bYi/eFmPj1HokElWwU9xAAAa/sqxE7FoqRWSNQoFMWYTYh5Vij4phg==
X-Received: by 2002:a05:600c:5007:b0:412:a9ce:5f68 with SMTP id
 n7-20020a05600c500700b00412a9ce5f68mr40767wmr.2.1708967471006; Mon, 26 Feb
 2024 09:11:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
In-Reply-To: <20240221210626.155534-1-adrian.ratiu@collabora.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 09:10:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
Message-ID: <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>, Kees Cook <keescook@chromium.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> Prior to v2.6.39 write access to /proc/<pid>/mem was restricted,
> after which it got allowed in commit 198214a7ee50 ("proc: enable
> writing to /proc/pid/mem"). Famous last words from that patch:
> "no longer a security hazard". :)
>
> Afterwards exploits appeared started causing drama like [1]. The
> /proc/*/mem exploits can be rather sophisticated like [2] which
> installed an arbitrary payload from noexec storage into a running
> process then exec'd it, which itself could include an ELF loader
> to run arbitrary code off noexec storage.
>
> As part of hardening against these types of attacks, distrbutions
> can restrict /proc/*/mem to only allow writes when they makes sense,
> like in case of debuggers which have ptrace permissions, as they
> are able to access memory anyway via PTRACE_POKEDATA and friends.
>
> Dropping the mode bits disables write access for non-root users.
> Trying to `chmod` the paths back fails as the kernel rejects it.
>
> For users with CAP_DAC_OVERRIDE (usually just root) we have to
> disable the mem_write callback to avoid bypassing the mode bits.
>
> Writes can be used to bypass permissions on memory maps, even if a
> memory region is mapped r-x (as is a program's executable pages),
> the process can open its own /proc/self/mem file and write to the
> pages directly.
>
> Even if seccomp filters block mmap/mprotect calls with W|X perms,
> they often cannot block open calls as daemons want to read/write
> their own runtime state and seccomp filters cannot check file paths.
> Write calls also can't be blocked in general via seccomp.
>
> Since the mem file is part of the dynamic /proc/<pid>/ space, we
> can't run chmod once at boot to restrict it (and trying to react
> to every process and run chmod doesn't scale, and the kernel no
> longer allows chmod on any of these paths).
>
> SELinux could be used with a rule to cover all /proc/*/mem files,
> but even then having multiple ways to deny an attack is useful in
> case on layer fails.
>
> [1] https://lwn.net/Articles/476947/
> [2] https://issues.chromium.org/issues/40089045
>
> Based on an initial patch by Mike Frysinger <vapier@chromium.org>.
>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mike Frysinger <vapier@chromium.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Tested on next-20240220.
>
> I would really like to avoid depending on CONFIG_MEMCG which is
> required for the struct mm_stryct "owner" pointer.
>
> Any suggestions how check the ptrace owner without MEMCG?
> ---
>  fs/proc/base.c   | 26 ++++++++++++++++++++++++--
>  security/Kconfig | 13 +++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)

Thanks for posting this! This looks reasonable to me, but I'm nowhere
near an expert on this so I won't add a Reviewed-by tag.

This feels like the kind of thing that Kees might be interested in
reviewing, so adding him to the "To" list.

