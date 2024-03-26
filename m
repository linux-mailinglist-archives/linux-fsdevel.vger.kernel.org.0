Return-Path: <linux-fsdevel+bounces-15365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8F88CC5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 19:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1082919D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 18:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F86213CA9F;
	Tue, 26 Mar 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RVSIHSq9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DB13C9DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479146; cv=none; b=IIJEE34Dl4d16V1JmQiAlpquEoBLSNIjYocdo2d8bmN7ikV5ZU6g7vIX8t9ujaCMdEdD0Xa8f8A6oY5PVwJGNHZpnwaO+0lzt0yOk5Jtf/KjaVX4DBo4qzAGo9+GF7yXSY7YNxOu+GibNEeUjlfHGy4xotNz9S38bUUJmZIXXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479146; c=relaxed/simple;
	bh=gVGL9JKWsT+/jWsd/FheyCcz8K4hp3FIwzMKWZrzr6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXSEew6MIEHRcBZ2QfAEOVe+4HbyLkjsUv0UC2tNh1HAWiQrl111Hi7DYJMAS4vVpSRbfno7wWaEZKl1tr1xla7nSCP9e0Q/Y7RF5KpJ+3XkCYfmbnV7hkpe7JIY6Z3c8b2IfK0I0XlLbwr9NxsrXkpelE9R6p9owuw2PVkysuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RVSIHSq9; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f1f97864so67346757b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 11:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711479144; x=1712083944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzSSnt/1tuqFAqk72WO9Yx92dcNUcT/slEGP7/aoLdQ=;
        b=RVSIHSq9ryDRSaY85pv34d9aEzHjPlrYPDOqiZqos5fty8gX8MCkRRjnrAMHYEnnXE
         TeuuP3w2YtuU2xAcA5rSHvxlqGLddlc6JTUfUMNA+znAY7/ubMX+4UFWwi7wjw7EZgSE
         OVhgyqr8Af9zEA1qXIpsyl9pWuNCDC3uHmIFsQuUDplbx5TZuI1unE+TBLbpuX0zZta5
         uuBh1w7sb4hSOqAiJ0XqdDm7tyNdjm0r2uaHITXv4HPI5rN4pUQ2doSLlbNZzQ2gvbE4
         pUtf2WLC9fBdahPF/fM8spyM8kERhNSUDjWdk/uv6ygVrL1NguS/vQRUKf9eRlK6Eol1
         07eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479144; x=1712083944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzSSnt/1tuqFAqk72WO9Yx92dcNUcT/slEGP7/aoLdQ=;
        b=wFZUup3EI72WHZWEjFSUSkcEFg8FwqAu/bRw4UWBFLWbhT6Rsa9LZWFGruRhO55oEq
         ZCgazsLR4lBzwuHcOBCIXYWJ32T5/bLJOkb0FxqsyCcbhDLsM2JnAzJ8LlgUYOkBcwef
         iLXsygui9jsPxdxaA+IM5jbGTfIMonb3oGaOLNmqRowvs6nWEbobYCv9jfDt06l5fODh
         IPzC2iUQQ3hVSFH3wUVorSt7tVj5eV8CaazxkXBlQrSn/WfFC7fjUV9KTOqsgnEWaEHs
         tmJK3YAu7ZXWvRsdEgjpR9DYI2PqGdVH5taATjVTFoVkzqXiDhk703klVwMQqcQxdwpU
         +EUw==
X-Forwarded-Encrypted: i=1; AJvYcCVf/8fYbWt49iL3t/r6PJIBCNTPv6NE+NKzCFPyyVGtWdE2XwMbx3p21ZROT7HogTHFrPlXEpqk4hwSxN3xgAse30k2LWSYrHkl8qSX9w==
X-Gm-Message-State: AOJu0YzlhCN7WEIE/3BeIL04mErY4ygdKoOSfDxoza1L0Dqssvjz3BLC
	5coZmRh9qTLgoTrgIFRhodIiMzc8zsbeLueR3Xd5ZgmXL0Vdgrx+gEiXQ5zIoJuJtee5fF9N4io
	t4Xnk/NoU79pWT9WDXJZYjaEf26PMsRuAATfP
X-Google-Smtp-Source: AGHT+IHqdyqNSAGGvJ3X0kEfA8lHzuIhyBNUZQgGjd2oGp2RW2WNuYuDp28MTzBqvtIcA8x9MrW/yUrTte2tCqt9XtY=
X-Received: by 2002:a81:49c1:0:b0:611:6be5:4fca with SMTP id
 w184-20020a8149c1000000b006116be54fcamr6905198ywa.6.1711479142547; Tue, 26
 Mar 2024 11:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com> <20240325134004.4074874-2-gnoack@google.com>
In-Reply-To: <20240325134004.4074874-2-gnoack@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Mar 2024 14:52:11 -0400
Message-ID: <CAHC9VhQJFWYeheR-EqqdfCq0YpvcQX5Scjfgcz1q+jrWg8YsdA@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] security: Introduce ENOFILEOPS return value for
 IOCTL hooks
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:40=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
>
> If security_file_ioctl or security_file_ioctl_compat return
> ENOFILEOPS, the IOCTL logic in fs/ioctl.c will permit the given IOCTL
> command, but only as long as the IOCTL command is implemented directly
> in fs/ioctl.c and does not use the f_ops->unhandled_ioctl or
> f_ops->compat_ioctl operations, which are defined by the given file.
>
> The possible return values for security_file_ioctl and
> security_file_ioctl_compat are now:
>
>  * 0 - to permit the IOCTL
>  * ENOFILEOPS - to permit the IOCTL, but forbid it if it needs to fall
>    back to the file implementation.
>  * any other error - to forbid the IOCTL and return that error

At this point I think this thread has resolved itself, but I wanted to
add a quick comment for those who may stumble across this in the
future ... I want to discourage magic return values in the LSM hooks
as much as possible; they have caused issues in the past and I suspect
they will continue to do so in the future (although now that we have
proper function header comments the risk may be slightly lower).  If
there is absolutely no way around it, then that's okay, but if
possible I would prefer we stick with the 0:allowed, !0:rejected model
for the LSM hook return values.

> This is an alternative to the previously discussed approaches [1] and [2]=
,
> and implements the proposal from [3].
>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20240309075320.160128-2-gnoack@google.com=
 [1]
> Link: https://lore.kernel.org/r/20240322151002.3653639-2-gnoack@google.co=
m/ [2]
> Link: https://lore.kernel.org/r/32b1164e-9d5f-40c0-9a4e-001b2c9b822f@app.=
fastmail.com/ [3]
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> ---
>  fs/ioctl.c               | 25 ++++++++++++++++++++-----
>  include/linux/security.h |  6 ++++++
>  security/security.c      | 10 ++++++++--
>  3 files changed, 34 insertions(+), 7 deletions(-)

--=20
paul-moore.com

