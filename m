Return-Path: <linux-fsdevel+bounces-66498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C18C3C213B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D201A27659
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546433678C1;
	Thu, 30 Oct 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEf1E4LS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FA2E6CA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842119; cv=none; b=ACUgSkpYlh11taogPLL8i2kikduMl/D0o++P77QjWUTjSSg83myR6eQWGePhgHc6izgbuVkfy+ScwF+BzhklM2pgvnISwHxrmVOYhRpAU80Mz+6Sc/fhFA39yEoZqpEET7jaP+4kiyQfeGAq33aCrXryJoqEn9OvxRpq0hli1e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842119; c=relaxed/simple;
	bh=MGkUVlTZmVz9Vm+z7GQHP9RZBRcM8P4VQelHahlN594=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXJ/h+FAOXOUB6uGzr3oxIUMBWYBPn05y4/sBZEFWSUifvxm5JJlq1NK8eyFvLFAPeGcR1Q0XyYLFbCSYkFys3c9W2ln+7qhwMWYFdQcyV5nUQYltGHxI7Fr7nHjS9SAfqUHdF/usDLUFBXK5d8DlzVD/E3I+ryPi0un2CgPSgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEf1E4LS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c09ff13aeso2278830a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842116; x=1762446916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGkUVlTZmVz9Vm+z7GQHP9RZBRcM8P4VQelHahlN594=;
        b=VEf1E4LSJ9oGqAy3EJmY0G8HUp012WYASEDov4A4/doZ7r/p2K4ddRQhchhKkTz5/D
         NbfWWPIHMDy7K/WuJh1OfsZHwP81gVeaa+n1abUfAaUf6rb/6oee59TihQVpaWikoyxr
         SMozDkY1SD2iKvinRxV2MYBgrphQruMjWsKfYb/7K0cH5qWDBDFpbLeF/Lv6VINSWO36
         0ul4oZbS9gN70U0fnVX/jxcE39sSje+0I1sxsRPGoJ8S1pfmTZUgeS/5Z6hv7v6nMhNP
         n7t5/452WPgR2tRuzw3RhMKZiTQeyz+qqBNWtDlPYEHhIOFvVSg/vnzl5buN3r4Rj4d1
         NVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842116; x=1762446916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGkUVlTZmVz9Vm+z7GQHP9RZBRcM8P4VQelHahlN594=;
        b=IJSfGHeUrIj3/PWJ3j4gTOol8YcXaW1NsL0N3JNMQIjn9VKP9QwyITzD+ara1Uf3vK
         6qIhfQgQg496KV43BCskZDZRCKuOU8R4YmPFoLpJajJETSCP2Kgy5G2w+7fTxmbAJxFm
         Gu0HYuveP+q500Uh4fJD3WQwgIYP4knulH7sViSHhBNqzLnj5Q81kGOwpN5Lv7u0YxcZ
         ShAFVqV+SQl+kqfNKCsNGLlDSliRREB4O7GEY9GmSFZUy1t/Ne4MEpDlfNSKhWiBU24g
         tCPqMh1XwaLvJrDU7HmTblSd7sJIGAIvoHx4T0mF5yHqspmHl154J66tZzF0FGBaOaHy
         YJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0cK9LsI2GFZthEjf9YlGpA2U4CVMOOyrFfsFkGvlB3On+m3qNaXOK3LJDc/NOJJJRIDlutM/QlryMEZdW@vger.kernel.org
X-Gm-Message-State: AOJu0YzanutVKhVbtQ60+9Fhqy8bfjG5raoOetrn0xv9Gevtom4/HEJS
	SezBLPH+PPi15Etll6gcupBZLLn9asNX7HQdzNprBiZHVx8/Xl4jDynNJ5chOX3hKGyDX8JjgUG
	aEZXnYTUnYHGyT8x+YoVOR6UvNwiVB/4=
X-Gm-Gg: ASbGnctfglvDGv1bXdvHIk2tptJQGK7GKVObbYnw6xc59hkhRgKjMV+bv8CaM57ZHOT
	bvaIuWMhz6FC1eTyiaItQlNxKSk9fCQO0mM24DyTV1mhZV04zxdBWgcJvIrSB87WMW6SwelS33p
	U7HTYBZxdghWgF5hA/rT416BLgTbtxdCUBzNvd5nbBInIdZeGd5rhP7jWzlWTKylVwDIBkoZyTF
	oFNnyceU77xrtwxOhBqyqj9o/e6rxeWMXkeLf523JtNaY/QebcfyFtnaDQlFgGINqVmAga6GvR0
	XhKBCzIaiu15QbIgYcVRTNDLtg==
X-Google-Smtp-Source: AGHT+IEI9jyntojwf1mHen/eVV6CP66LheXmeZtEuf9j/UlMHcx3y2EdePYB/I7EdEcMIu8jXCq3/T2L3K3kk2RO9go=
X-Received: by 2002:a05:6402:3047:10b0:63c:8123:9d46 with SMTP id
 4fb4d7f45d1cf-64076f78ca0mr68713a12.11.1761842115516; Thu, 30 Oct 2025
 09:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Oct 2025 17:35:02 +0100
X-Gm-Features: AWmQ_bk0H66A4MjIr_4COm2P4YXtDHgN1JUPcsRB5KkYw_gDWY9N3WPt2xsKrLg
Message-ID: <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 5:16=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 30 Oct 2025 at 03:52, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > Should someone(tm) make this work for modules I'm not going to protest.
>
> Btw, that's a good point. When I did this all originally, I explicitly
> did *not* want to make it work for modules, but I do note that it can
> be used for modules very easily by mistake.
>
> > Vast majority of actual usage is coming from core kernel, which *is*
> > getting the new treatment and I don't think the ifdef is particularly
> > nasty.
>
> I suspect we should make that #ifdef be an integral part of the
> runtime const headers. Because right now it's really much too easy to
> get it wrong, and I wonder if we already do.
>

I don't know if you are suggesting to make the entire thing fail to
compile if included for a module, or to transparently convert
runtime-optimized access into plain access.

I presume the former.

Even then, there is the cosmetic issue of deciding whether to ifdef
within headers or create include/linux/runtime-constants.h which pulls
in the per-arch stuff and ifdef in there.

Personally I'm leaning towards just forcing compilation failure and
duplicating the code to do it within per-arch headers, for example:
diff --git a/arch/x86/include/asm/runtime-const.h
b/arch/x86/include/asm/runtime-const.h
index 8d983cfd06ea..42e6303b52f7 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,10 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H

+#ifdef MODULE
+#error "this functionality is not available for modules"
+#endif
+
 #ifdef __ASSEMBLY__

 .macro RUNTIME_CONST_PTR sym reg

Just tell me which way you want this sorted out and if it is less than
few minutes of screwing around I'll take care of it.

