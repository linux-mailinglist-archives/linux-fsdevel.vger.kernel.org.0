Return-Path: <linux-fsdevel+bounces-67995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FCAC4FC24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 21:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B06FD4F09D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 20:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991393A8D72;
	Tue, 11 Nov 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dukZk/14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFD53546E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894700; cv=none; b=N7CvZTDm2tFkIN5in9FWK/xEP2dRhd/0FWqMFnQjgFkv7gNQmcrr4SZF/ilPPTM8na+uY4bFT+6Oz8xh9B3PqEvkjLGdF7Kac82wlgTaI7Y8YH6MPBErR5YEIpxIzgDuCCnAxhDUQ7Rt5Dk9WNLYllTjVhG5BX3Ami+9eSYyQ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894700; c=relaxed/simple;
	bh=5IPiXaFkwwZtaZuDIqZvEEkFtfPxtooPB1hfynQopyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u65mf6bVVxsNGA7ud3ZF+7QDaQX97t75o2pWQ+PaFbs2yyTm1KdUyxOk4JnGVvDUB1dpcLrIoKGQ04NFFkxuwEqSm+WqWQ8/T7oRHqH2dAIpYuQOzhsxSmlXkbr1Fw7zqn3tFd1lAiLjchqL1LadbMTL9Ut+JCpkBqF4aNvZS6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dukZk/14; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso151671a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762894697; x=1763499497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5IPiXaFkwwZtaZuDIqZvEEkFtfPxtooPB1hfynQopyI=;
        b=dukZk/14N6P3AY3E//uOob/83ZX56Gg3zcmtlFUOVT0+RBuc3oVCii9zMzDt0mS7Y7
         pVxePc4+xS3rsb78/9whAgzRXbpZ9dSenr/uKwitxoKL6a39CklQbTWQ84DfE2/2sDpj
         5QrK0yluU7KAdt4/YJyY7bqqDFuGoapuWkAZ/HeBtbDOA+cZvre8wbqZwmo3DpJqRjA0
         AX7ORJWzHwifdvbBKOHF2epxKMLN6oG013yAfpraAz+Z4jBYjZ1Rwwj04Ke5bFL85FyZ
         Hh10I029esix4doxY7fQeqwVT0nERTFDdl81yfWXS23v8Rn7emvqPTcO43gGhwJP6rNh
         ln8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894697; x=1763499497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IPiXaFkwwZtaZuDIqZvEEkFtfPxtooPB1hfynQopyI=;
        b=nOtbza45b89QbJbMHpn7n4L8IJ1pXNh+t0UiQ+C568bnX7aPktH+3vsm7MIbBRdFrb
         s40I00Z7AHrS6hEVe/NvobvMFT3JYXmVNB+vrkxV+9FjHwU4Xsl7XeIfEMfMRZxHZKtN
         SjEM1AWcWEzfxIN6osFxm1DaONDsmqqSd6ksWI8Q3TTXmNM6i1uRA5CtNKitBQ4rCQTX
         KUDQTv2tGNRi7m9Kjw8/Yiw/nIgKjfePT8dhUDI6PT3tW1QSPGbb5DTsqtgY3l7RdZ8O
         cDYyDiWWrckPE5KT0Z1u2R1G04TrXHaCxH8J3pFdoflSmtuokfPtylpBJ+C3kRqigngc
         Fa0A==
X-Forwarded-Encrypted: i=1; AJvYcCWg/DdSRj36OejdgKUTMU79whRtRMDHARxQjdtA0hko3xqikxo9UGv3Y4gD/5gGkP9TTADtlKloK737+Trg@vger.kernel.org
X-Gm-Message-State: AOJu0YyfmlSLiaN4+7sgHUG9DnofE25eFprrPkLWYIGh87+8qcKcu1s/
	lnR7MpMef0C6QAWfhJIS/p9SPRb/SdKyETO4Deu7W5Gr2/Ct+/RocKVx2uGfISCTxzh4bcKIr1d
	hINFSdUzhKhh3vOKgjoRTfXBb/+ELP28Vj2phXboKrg==
X-Gm-Gg: ASbGncvtF8IQOQufg4v80sXU2LcHNEfMlMiXzRNx4ONpnTvuh8wN2w/vgFI7rN/+f8W
	bwFMoQhpqhl+Ip4FIuvcM3caEoz44NeSju13pgQk9K2gYnmFqefbEKFIeXRlyaNp9KQnRM6KDin
	cICvZt/AMybOu8TxyjEeGp6oklnhLD6D6r+Pniss5K7Ck1vlQI4x6aoR5LZQGTw3W0XiC6ljTBt
	msewEQxTRWi3YXe/ozgXKA0oAPhTGWfnGjGQ72y4XtW71zAC8MM2uGwkA==
X-Google-Smtp-Source: AGHT+IHuAFVKekWd1XIceTepFQM+2KcFkyr0+Jt/14Gjj3YjuSVXCqO15zGETNvx22Zso3bXtPLN06bMXeUC9RPF4AI=
X-Received: by 2002:a05:6402:1450:b0:640:ee09:bfc1 with SMTP id
 4fb4d7f45d1cf-6431a57e0ecmr566813a12.37.1762894696728; Tue, 11 Nov 2025
 12:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRHiCxoJnEGmj17q@kernel.org>
 <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com> <aROZi043lxtegqWE@kernel.org>
In-Reply-To: <aROZi043lxtegqWE@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 11 Nov 2025 15:57:39 -0500
X-Gm-Features: AWmQ_bkvWgSaihTKA4ZFuehWCb49R8fZ8C14CFTHsoW2qubcK_JcQqaA8FvRRnI
Message-ID: <CA+CK2bAsrEqpt9d3s0KXpjcO9WPTJjymdwtiiyWVS6uq5KKNgA@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] liveupdate: luo_core: integrate with KHO
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
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

Thank you for review, my comments below:

> > This is why this call is placed first in reboot(), before any
> > irreversible reboot notifiers or shutdown callbacks are performed. If
> > an allocation problem occurs in KHO, the error is simply reported back
> > to userspace, and the live update update is safely aborted.
>
> This is fine. But what I don't like is that we can't use kho without
> liveupdate. We are making debugfs optional, we have a way to call

Yes you can: you can disable liveupdate (i.e. not supply liveupdate=1
via kernel parameter) and use KHO the old way: drive it from the
userspace. However, if liveupdate is enabled, liveupdate becomes the
driver of KHO as unfortunately KHO has these weird states at the
moment.

> kho_finalize() on the reboot path and it does not seem an issue to do it
> even without liveupdate. But then we force kho_finalize() into
> liveupdate_reboot() allowing weird configurations where kho is there but
> it's unusable.

What do you mean KHO is there but unusable, we should not have such a state...

> What I'd like to see is that we can finalize KHO on kexec reboot path even
> when liveupdate is not compiled and until then the patch that makes KHO
> debugfs optional should not go further IMO.
>
> Another thing I didn't check in this series yet is how finalization driven
> from debugfs interacts with liveupdate internal handling?

I think what we can do is the following:
- Remove "Kconfig: make debugfs optional" from this series, and
instead make that change as part of stateless KHO work.
- This will ensure that when liveupdate=0 always KHO finalize is fully
support the old way.
- When liveupdate=1 always disable KHO debugfs "finalize" API, and
allow liveupdate to drive it automatically. It would add another
liveupdate_enable() check to KHO, and is going to be removed as part
of stateless KHO work.

Pasha

