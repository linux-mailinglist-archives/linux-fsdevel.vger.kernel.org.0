Return-Path: <linux-fsdevel+bounces-69835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5E3C86B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 20:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B6724E3E07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311092528FD;
	Tue, 25 Nov 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gaz/sIUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6E2010EE
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764097312; cv=none; b=FVeSYMMBDdX4TzBLW8tLArCPfIeZzIQKn9EveF/AAnwNGD4GkvrnXH9JWLXTmJHZXfEYpXixWGWBkAQ3l+0riYo193JKKR5TqfjXm8HaM5SJRtWO91yJGCVnDhuim9+/lqdCipLr6+8ZsIycG6NSA0s3ZeqtOMBb5R7qEPExX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764097312; c=relaxed/simple;
	bh=MOyjrq9o6VhvNdGxsukEhpqXDWstKGHoaaJHOE/8nqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO2cAMA9c0E2Wm4YqXpTsxZfawT13+26ChBs0iwbPMrBisdYfrMKvlLA3+Dv4ansHbl/C8QE3xnFlIZ851TzS1E5eVjRFPluhjba087zJI22thZMO3X8veCt706NsN6r/EeWc4URNYujIjixpKDJQpvZ5VB3AYWguXZ0LA/SJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gaz/sIUP; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso10144944a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764097309; x=1764702109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+cab5OoFiSAnh0Rr1KkIMrwuY0x0IPZJPyGZAN91W0=;
        b=gaz/sIUPnVyEAbMa4nHlq67irq9G8tHlouy1AmrGF3ax4IsbJHIwRGSpkPO2NOm5xc
         PaIQ6tRg6jdyKqWAVpdIEIAJPw3+zg9UedPjStCHsaRdpCFtp0QWKacaMO0aP4kYu7/X
         tyJ8PwlLH6lGzh+gUVrLUF+PjvaN/dAbxyKS3LXsAlYU7m4VBzctEH5lSVzuLh5DVAIp
         TmTvfnSGC+pufTBskrZNocvBbRnKsOq5TC2eTr+gMCaRYPE++dR+G3n4Syt0bPQsUtqK
         Havf51x/0gdPFrOa+AqrmtuDnUdy7EhvCSd2CMX5ZAVIE37MIJVFMiCobFtlLSnUWg/v
         gOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764097309; x=1764702109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+cab5OoFiSAnh0Rr1KkIMrwuY0x0IPZJPyGZAN91W0=;
        b=XXxLZ229Sl6FeAuV4hAzHk0SkPkfX5qgq60ygqLaJR1kajkm85AosxqkJMZIaUaUeE
         su+S8CBRQL1c1zxmLelmhhbsAw5j74K2JuuBh2j317g766nO15IUgDWWOaFsLkulkApu
         NWqlRWcVwV5YYep+Y7r2Pm+MSffw8ztwb1zMDW0oeomtgiyaXa6K8jAgsbRJzqf9Tuet
         LMMoa7i+j7yOEb7nyr8zMQt6QHE/R/KYTsiX5xmsqqZDAQ51p1vEA0vSAKxTsbr1uqIE
         Z/uiVQtw4X51BajdExjqQiWM3OX6fUkXyqAKhLbzGEcW9v/W99kwnacNJLGAfkkgHbcW
         eXOg==
X-Forwarded-Encrypted: i=1; AJvYcCUW/Slt/uomGydZd+aJkiRTLITTf6B7jRcsmuHj4igkpfaMWDTeIMK9ueNDFEj2RX0TXGT3tPcxzR9RtGPX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60xIVrcZ+jrsb7LaDhOnWVhMD8g7Ex5i1eCq8vMqkkJCJpRy2
	AHyr4m4Qo1JF+mirOYgY7jwle6FjJk+pX2FjhrHk2Rrrz7BqBfET9Gn4qPkv6gtFi+yE7COLhg5
	hJSxhu0XR+LG/3oukoj1cG5kfaigaVyQB28FVmHQ3Hw==
X-Gm-Gg: ASbGncvbMaNPQwZs0jsbTSN1oYPvxVQ6xMMRBLxQHOqNT6/xjf7Zp8X/56176Jqjg+p
	NIGa8buoWz/OiSLg7yv2aKrBQ2xWvSmxupM2uNiJiAtxsY/q5zkwK6RjUJ/DEygn7TH0RGAIE6k
	TdndKFAUU0dv9YP8c/q1UptTz7JckYmfBvZl6QEJBxX+lnNfC/Lz4b4Yllxf9HjXEcFFdR0Y8bQ
	O//rmIR0dBYboj05cIF6j7OB+jLvWtmR7i9g13c5iA4q6Ws+1JTr3VBFxZAKtTHeKH/
X-Google-Smtp-Source: AGHT+IE7rh2493kGukystiIbPKWb0LUwVClME9rpzIqFBySy1Ee89iOW2xWboR8KNUdfVwKxse2RLFaevMjMIITj+Qo=
X-Received: by 2002:a05:6402:5252:b0:643:4e9c:d166 with SMTP id
 4fb4d7f45d1cf-6455443ed4cmr14156611a12.8.1764097309246; Tue, 25 Nov 2025
 11:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
 <20251125165850.3389713-3-pasha.tatashin@soleen.com> <aSX7Nm_yrXHeejQU@kernel.org>
In-Reply-To: <aSX7Nm_yrXHeejQU@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 25 Nov 2025 14:01:12 -0500
X-Gm-Features: AWmQ_bn2a3c7qeqfEVEla4N9ePeEsUIzOpDhVQeyvGV93y9dTtTiY8YHmxuVAOw
Message-ID: <CA+CK2bDJ0QwbVi07A2tAohceuOur8JNp2Dut3DEZ5z4EFwXz5g@mail.gmail.com>
Subject: Re: [PATCH v8 02/18] liveupdate: luo_core: integrate with KHO
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 1:54=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Nov 25, 2025 at 11:58:32AM -0500, Pasha Tatashin wrote:
> > Integrate the LUO with the KHO framework to enable passing LUO state
> > across a kexec reboot.
> >
> > This patch implements the lifecycle integration with KHO:
> >
> > 1. Incoming State: During early boot (`early_initcall`), LUO checks if
> >    KHO is active. If so, it retrieves the "LUO" subtree, verifies the
> >    "luo-v1" compatibility string, and reads the `liveupdate-number` to
> >    track the update count.
> >
> > 2. Outgoing State: During late initialization (`late_initcall`), LUO
> >    allocates a new FDT for the next kernel, populates it with the basic
> >    header (compatible string and incremented update number), and
> >    registers it with KHO (`kho_add_subtree`).
> >
> > 3. Finalization: The `liveupdate_reboot()` notifier is updated to invok=
e
> >    `kho_finalize()`. This ensures that all memory segments marked for
> >    preservation are properly serialized before the kexec jump.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you!

Pasha

