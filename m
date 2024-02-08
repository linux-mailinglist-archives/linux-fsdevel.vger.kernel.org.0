Return-Path: <linux-fsdevel+bounces-10745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAAB84DC70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 10:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5EC282B46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 09:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7226BB3C;
	Thu,  8 Feb 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iG4dg/hp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4C692EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383393; cv=none; b=osWyt8ZDIN09vNFP4mCAv/OBMqbXQ3hCWo5aTLlNbTgDN5Y7IcFJ9YqoNnmYVIVGEFN8SIm7hyIFc5suzfrjd+OEB6h4XCYV1okDIxQrqJktlNZGKjHP0+xJOMXua9edTJuhEtuvrJY2pJr8R1M6MZlJ2tz1xzYNOadvHwRU8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383393; c=relaxed/simple;
	bh=zVsw84a2RwGpKBPrw4jYTiy1UtSi5N2mqNp6IaCH95c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KI4ivJ0l+Wt7J16xqCyTGmJIYSxknDIrW6qsCsKTOfWM88PyhcgSko+MdQ8Y2HGoWD/OLRA80Fp4SDJCxWE4BrcVERk7wAb8iwjvTyL0pcpcVbuQE5DoG32U5uHX3mqIX1GuJRcyEzzS7S59IcjP7V4878o1Ri9Lb06E9481YGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iG4dg/hp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so207499766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1707383389; x=1707988189; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=si3xHK+k194EZDIzaB37YbzCU6i2qGxC7c5NTYon5g0=;
        b=iG4dg/hpLk3XHnjgPaMC8kyY5DRCph0T+VFbA9jQspBajQO+8+Dc33xrLxNZIc/J9R
         WKBUeMinRGKzQXOWDpLMG/hRVSIUHxtSiruChJpNuMZR0jaPjB39BwAvKHB209Fk8AZC
         HRKp6o0KS7VhQDxMQWJTv7MONttyNOEfMI+k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383389; x=1707988189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si3xHK+k194EZDIzaB37YbzCU6i2qGxC7c5NTYon5g0=;
        b=YhOej23fQPG6i5K60UVK49bMUSQtJqsHgzW5KNUCSfYca/L/MjizpWvxBdvVPVNVAA
         /yEPWeaQdRhR7FffiRB6xG9QodPUncGHGWFFu15BxtqKHB39bUoCx/uQ9nap6kRdq9BV
         mqc6ZSzzgqJTpiXpi+V9QRz931i2F4FK50ps/Gs+p1F5uLVSMw72RGAW2ZBEt5SxMSzd
         gSAGuG8nOPtebm9m6hRvBYyL7r0a0Ie4iRuMWD+0EduBWYCMTBmJFOQmAA58blAsPmkM
         FHKR969Fc8SBU5wTxZcBXDTFARcXbatUaCJKfgNT05vEYVt28E4bQ7lCPJjKGYmG7fFD
         4yJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9h6IqSWl2hVvRb+XGU3kPTkS0RTKRw0QSRAXpfkRANcSS1i6/vxJ48XXz7+8bXgXItxIdDxFeL/4dcGgdp1EScqGGnKK7feoyDaegfA==
X-Gm-Message-State: AOJu0YzeKGBloD/LJ2WxTKWitDspBFWDFpK7iPjfbtAtslrkkLG3hO7+
	qN+ejpRWPqNrvdlf8KzwnsEonQdHifqiyU8pzo8OQZyBOb5TtXmyX56JdpQk1ujReMwDRJPsuzF
	taDVTzaH2pCnAPn5cKFNaHEF4EGIXX8yn3UP9pQ==
X-Google-Smtp-Source: AGHT+IEr5ybnrgs7QEr6RwDRUNtDFB2ss+L0SZXg8ulNl9BKfzLBHvkO0AwDNKY5TsqS9PoK/JntL0Xwn8kaVWep/Vg=
X-Received: by 2002:a17:907:762a:b0:a37:20d4:22be with SMTP id
 jy10-20020a170907762a00b00a3720d422bemr5690729ejc.49.1707383388930; Thu, 08
 Feb 2024 01:09:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <ZcP4GewZ9jPw5NbA@dread.disaster.area>
In-Reply-To: <ZcP4GewZ9jPw5NbA@dread.disaster.area>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 8 Feb 2024 10:09:36 +0100
Message-ID: <CAJfpeguTGdAuQ+5Ai0ZXL7p-UeCyk2spBDhm6bkdTC-0UAKenQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] tracing the source of errors
To: Dave Chinner <david@fromorbit.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 22:37, Dave Chinner <david@fromorbit.com> wrote:

> ftrace using the function_graph tracer will emit the return values
> of the functions if you use it with the 'funcgraph-retval' option.
>
> Seems like a solved problem?

Except

a) this seems exceedingly difficult to set up for non-developers,
which is often where this is needed.  Even strace is pretty verbose
and the generated output too big, let alone all function calls across
the whole system.

b) can only point to the function was generated.  But the same error
is often generated for several different reasons within the same
function and the return value doesn't help there.

I think a) is the critical one, and possibly the ftrace infrastructure
could be used for something more friendly that just pointed to the
function where the error was generated without having to go through
hoops.

Thanks,
Miklos

