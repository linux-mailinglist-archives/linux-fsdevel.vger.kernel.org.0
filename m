Return-Path: <linux-fsdevel+bounces-12868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CBA8681EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 21:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C635B22FC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9927E130AC8;
	Mon, 26 Feb 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXUH4LYt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5891012FF69
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708979370; cv=none; b=i1TGiGmHsWegTuOQuwqb6WEnMgHSLOuvEnhp9trEmw6DAI1fnOBFeNh7/04Rtz97PapYqx0ciinkTMy5rHopxVNRHbp3CwbxarL8iaRJfJTdav7E+j+Ku9g2f2kToGBDYXZDJc9WmolsKuu5lS0sRfEC5F5JFJ77fY6t45DlFrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708979370; c=relaxed/simple;
	bh=QxHMa8tXHRVUnwvw9mD2wDd93p39Q3LXyym88+LBQsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjRcoJsuser3Fw9vKaLzdBW8BJg8D3dJw04tE8CVtsaaumsDkIZ8XIMA8yJCzahvt3WTBvyTcS0Hnr6gpryP3JeL3oxeQXU1VY10BbLhBNXoyKzyS9uvrXGbi0BQwvy0Y5CBQiqIf0PEyCha7wsg3+SCR/LGmYirF1x+L/Vn3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXUH4LYt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512f54c81d2so2048498e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 12:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708979366; x=1709584166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=kXUH4LYt0O+PcJSbQibj7bUR7GS3p3pHNY+97jePEAWM6mstU1LXPsKaj0lU/+8N7C
         a666jEF++XwzafrndzIg3MCT+lqXplSbXR9Q5dOEtP2fyWl/TmEoEor3dDLM9Xb9UiFG
         a1kxSmGodbTYdmNgGzzjy8k4nVrkFm7FRnGew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708979366; x=1709584166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNlbAlWQ1iLJPy/RP5LQxjXWzGeumRLZ8mhf6SEDR2k=;
        b=tRIE8oFMe702GJaA2hGYDUPywZYCXnlFLMqpPfX1WY8rib1NTVnMnbogjKDajZCDR0
         dlzzi5orJkOXQtcRQXQN1QmxUdWK16jzF+A3U+F0KIadxOHxFeVqtk9oshftLbR1/HV3
         yeSXq+2P7QTFyM2rXS7tr0qR3n6xf5UhcbeGVKTDXWmWa08cqleFogcgRyUXbDiVeYFh
         iVXeV/ghCYEsdUPcwV7mz33XwKrb++JnEnpOGBBOBYR1TLDDPrO/6oUiSnbLr1lTDgSU
         hty+nx8UqL+RqA8YPsRirvLuYLctCmQyfhuVMZM08K4JzeJ5ThxFdVVDyUIoejXzFvFj
         VJWg==
X-Forwarded-Encrypted: i=1; AJvYcCX/upRS2RDZhyY7++pE9m4/wVd8DSJu/QcqKev3PaNM3PPATHsc4+hleMaCaXf9oj/NmgHEzBXCe7w1frINUSmQqulSDn/yKiT2npCq9g==
X-Gm-Message-State: AOJu0Yzh7LawNJRH6fn4H3cl4UvJ55hckwOustyINXQQ0Q3jhd/mMLp/
	+iKSGj2AdufRoumk8CHd3lETb8jcpZRwwYvmcvW0Ws1c2n3bwCx9X7/NzxdMj/gwnFf2eZBtSGX
	lfcZCgKFw3WWGaBhX/5TZ8mo6uVaPHSK4X4vX
X-Google-Smtp-Source: AGHT+IE4y/QI5ASnYlnv6FmbjUzGGENEjUwIiTvu+iC22zSP9/uqeaEIobfef09+sc2WB6Z9VlPhm8xH62y6EUnNoXI=
X-Received: by 2002:ac2:5d4f:0:b0:512:a4ce:abaa with SMTP id
 w15-20020ac25d4f000000b00512a4ceabaamr4861210lfd.48.1708979366487; Mon, 26
 Feb 2024 12:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook>
In-Reply-To: <202402261123.B2A1D0DE@keescook>
From: Mike Frysinger <vapier@chromium.org>
Date: Mon, 26 Feb 2024 15:28:49 -0500
Message-ID: <CAAbOSckyxGka1vWTpuYwA8eH=17sJbGMUOuCwHs2gE_FPnXG3A@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Kees Cook <keescook@chromium.org>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, jannh@google.com, 
	Doug Anderson <dianders@chromium.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, Guenter Roeck <groeck@chromium.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(lemme try this again as plain text)

On Mon, Feb 26, 2024 at 2:24=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Mon, Feb 26, 2024 at 09:10:54AM -0800, Doug Anderson wrote:
> > On Wed, Feb 21, 2024 at 1:06=E2=80=AFPM Adrian Ratiu <adrian.ratiu@coll=
abora.com> wrote:
> > +     if (ptracer_capable(current, mm->user_ns) &&
>
> It really looks like you're trying to do a form of ptrace_may_access(),
> but _without_ the introspection exception?

to be clear, we want the check to be "ptracer is attached, and the
process attempting the write is the ptracer", not "does the writer
pass ptrace access checks".  the latter opens up more angles,
including shellcode self-modification, that we don't want.  the only
use case we have for writable mem files is for debuggers, and those
should already be attached.
-mike

