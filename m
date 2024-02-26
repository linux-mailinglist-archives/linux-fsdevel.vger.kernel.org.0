Return-Path: <linux-fsdevel+bounces-12890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F38683D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 23:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4AC2B23772
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771A1350F5;
	Mon, 26 Feb 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="URxK7Ovq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7121350E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 22:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987072; cv=none; b=ACqlGTi0XAZ0BiThYb8qBtUdZr10CZ6Hm2tulK1bYVcg0rTGe5UdpIQXjqMpZSzFjsxQduCv85peAk1/x6bvAB3KYpmeE2Mnw0V2hj+dgTTRxyQXeFjU6Fiv8VWMVpvJ/Ugnh8a94j/oeXWysLqsK3YAh3hcR2irnruMfUcI8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987072; c=relaxed/simple;
	bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtAfH9DLZqSFC5l7rj7JvCuMyC+IF1qglKjA1mrIHMY1pkZ01YSMZ73HcOEHSb4ZruWiK2KBAw+eNLRsR24jtkzHWBerAyb/zih89b6YD8fqixFAtQub3jYX90cfaM7GqpoF6WAfTQ4BLpDd7DOjPwMhgU7ptw6r1iUIgwmsTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=URxK7Ovq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d26227d508so40734431fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708987066; x=1709591866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=URxK7Ovq6mgCNT0pAEqBb/3M/wjnmM/LSxXpmCakoJ1ePWBWfexAdkcuSxDKu8qmrw
         wnZfWZ5v8j38ev4wD9Zz2QxRZsrZveUstPE5T2J+pr21rnoxIcx01LeSJWlF8Wyq8amw
         5pNEpFVJPmJG9/uQTS6blToY7w/7Uk2TQ949U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987066; x=1709591866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=Ap5OB8GdZ1zC6/GT837a5MMZuW0JdW3BBcT151NgbT2HY5c16SxIF2W1XiOj3qjhQW
         DKyWkQdaip3kY0FRUuyUm0COq7MBp8uuYEBpbBiOsC9M5jo/IZ9dC6dhFFxaULrJsqL7
         qb9Xpq3OoWvW3jLVvc2JqStmPShAwdDXH/iGzQzxvvbV9d8Dd+gM35iBWg39Hj13A0ic
         kt2MqwqyV/Ls+if5sONOjnyicPxG+O1HSiqZmhPB5qqM1GuloAquci2UmpOUqzkVVIBu
         kqQ9LWF9LPTz8Sqh6kEeTBoE/+PBPtw6yAUd445hTLF8XKQaU0s3j7Xdom6F5oUDJDCM
         A1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVHMcOzSH2ScN2byIVTT0p2z3fZWna3iB/zCYWo57CGiUSuHL0IuQsq8XCDnkLzW4syEUgPa4gaHzMi0hp/DVdT0cDkC+sFnT0qEW+5Qw==
X-Gm-Message-State: AOJu0YyA/LkAAKcAxkpj70Hi662KYgbpo8W1cz10szA6HWCp/pd6A2Tx
	PXl4rb7IuAdk6jrAqyd5obZzel/gokJWowQQ4DQihv3CYyBzcaNXm9Y1GdelV478wl/gFRRSSyM
	JyDbB
X-Google-Smtp-Source: AGHT+IF6MSLn0ujiizP/4jvt3hcXlElW8mNQmJZsCVSIc9a6RFE6JLAJeDg9B26cBHf4WWtvCTFJUA==
X-Received: by 2002:a2e:9dd2:0:b0:2d2:3ec0:29d9 with SMTP id x18-20020a2e9dd2000000b002d23ec029d9mr4650087ljj.38.1708987066572;
        Mon, 26 Feb 2024 14:37:46 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id j8-20020aa7c408000000b0056200715130sm170095edq.54.2024.02.26.14.37.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:37:46 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so5265e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 14:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW65Fc1lVspUCbB0H1GuZx91siC2TaHxXMKMeippKXbXItsaSkcnujSiauUdrYek05RagupgT26SfzZVkwZajiAByVoxZpyPYkpMnJgvw==
X-Received: by 2002:a05:600c:1d8b:b0:412:a80e:a5cc with SMTP id
 p11-20020a05600c1d8b00b00412a80ea5ccmr30242wms.1.1708987065108; Mon, 26 Feb
 2024 14:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook> <1405e4-65dd1180-3-7a785380@32026879>
In-Reply-To: <1405e4-65dd1180-3-7a785380@32026879>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 14:37:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Kees Cook <keescook@chromium.org>, jannh@google.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 2:33=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> > > [...]
> > > +config SECURITY_PROC_MEM_RESTRICT_WRITES
> >
> > Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> > sysctl, but that's be harder given the perms). That this is selectable
> > by distro users, etc, and they don't need to rebuild their kernel to
> > benefit from it.
>
> Ack, I'll implement a cmdline arg in v2.

Any objections to doing both? Have a CONFIG option for a default and a
cmdline to override it? This way if a distro wants to restrict writes
by default then don't need to jam more stuff into the kernel command
line.

-Doug

