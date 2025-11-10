Return-Path: <linux-fsdevel+bounces-67719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47176C47A8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20411887C71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518631326F;
	Mon, 10 Nov 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dzvOjL21"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12D26F443
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789464; cv=none; b=Cqy1CsS56qe7fOBHaL2A0y9W6EYW/pYUMkgFgsnD3/1S1TzJsrIPrZjIL4556jgxKWyp4TyciauoT7YZCv4RZPeyCn5VAih74BJMolz/0EIjP3PxCCgOZ+3+dmfwGhL/aahrE4/AhyTwBDklcUdWNY6tcLbPNtvZS7ifBIewmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789464; c=relaxed/simple;
	bh=0/OiCETMmzcumsvoWoUgjV7cQZEVGoR3fXx3J8u0qVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2wrm1jyLq1hRsdrR2SBBGhQyUsQqqiy4rvTTPyA4C+I0Dw35SpqGAPKmip3olIPEMhOvJ2ZumKf1NBVeNJpjFzgBRVnbhstPaPYAd/jsMTfUVy2qEBt/ghyv+BmdvWA+HHxp2g5ry2KGiS7DUQgWDYU0GViMO7T8j8N+g+UzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dzvOjL21; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so1470702a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 07:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762789461; x=1763394261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KQAadWs2BEV1pVXExDFNf/QXLwU7Gs3Db0cLPnWAqzw=;
        b=dzvOjL21KjvkYZZzR6Ed+fpTiS0NvhBWEAiCCEQBV19oX3UrQouoka3tyVBpTo2UWs
         j4PVvJ2pL4ZrTlNNHUDdVANtzS7C0YiDtCMYtFnYw/pyxn35SX9EwsR3r5NFtC1pqczs
         PfomZmit+5jlMicEO2krFsQEgEsMZznnqrt7AdW062KR3Wf/NJR/LoXOHLXXcJofeQ8w
         P/mI86v2d6dSxyNcHa7tmNUU9ErJLfuhu6SpeaUNPhOq1V1iuMB9XnDS0OlHfX5ljxM5
         w50mfpkDbsD/GI0E+6Q1b7bB14spFnuBLpTe0ZV8evQnSc8hpXd9fph6sJ0No4vC/Pti
         NLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762789461; x=1763394261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQAadWs2BEV1pVXExDFNf/QXLwU7Gs3Db0cLPnWAqzw=;
        b=J4qsOFphyCFxGAKTWtR6hFFyu9evEzdHcYps6sfxPrWPtWCmN2m8UAVckKUsAaMPlq
         jMp0wYPMUFN7JSk+Jy1985ZH3GTxU7eKu1c3x/su5KI8AdCMYAVhiKsjj8RemSnHGyB9
         9HHMkxVMYBXH+ZdQfcxt1O/Kv6ihJNdDYgUgaqcxaT8kdm4KBTFp6CfLwNfd+sGRlOxe
         wXLA+xxQqAigs0hqtQKyHVP8K7FyJSKF1y9nNYO1xY0FQDji4a/h6cRjAoSPIeoZ2+XP
         YZw/4DA3+nUL+d22Jm4ZOmOzul4ukOVs2Tm4rxM7aFhRm/CQR8jAG1NvqJ94XN/O7d0T
         yeeg==
X-Forwarded-Encrypted: i=1; AJvYcCUsgpbZFKePzTqxUTmosobfR6xeG+MHpNX5hFvKDnjTcZhXTgigHWSlgqjAcBU7iMPooUOkPPj7qhnyTBAk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ezuHrazKV+NxEXRAn2YlyJS/t87kTjJLSn9f7DeCtj7OpjNE
	Ppdwc8eD1AE8kUUl5k8JfOYpxtP0Vr22cgMO0/HBpPbuPjIiZvulYvU2LRkhE7VcR2Uu89sSirx
	7OJH7XBJgIn5iXQnvnvllzrPgfUOoEseVkTvqStz+MQ==
X-Gm-Gg: ASbGncspOOo6Ar+/U/KQ+Cj0KH1sG/FrtYKV6lrDV4lWeD65QWEhJd7IB8UeuaTw/x2
	AdgauZ5fYV0Ly4l/WmLcAUCJyKf0y1eAJtu4Ho3iynDZ+RsN3uQ+5MBAM8tjJSjBPhwEetV1V2o
	2uPho88OeHIWEmQ1CDtR/IHc1LDpnEMo6m+RbJ/Nrudbnwpf6q3Ll6Ljdtc6FpvN0CsiwCkLgQQ
	Yyi4FuwMUzI41o1ehwhB0q3Fa7Fx5uTWtYLXofDYaXJQt34t+PewvnXBg==
X-Google-Smtp-Source: AGHT+IHgzYBqOch+pmqIr6aFKeN8KU2lBlaA5VrUfecgkUX1bwRao0L5zlIWi8QFdGiWaxEVfTfghHwHllS6y/yRZSI=
X-Received: by 2002:a05:6402:5245:b0:641:270:2c5b with SMTP id
 4fb4d7f45d1cf-6415dc082f2mr6735966a12.4.1762789460667; Mon, 10 Nov 2025
 07:44:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
 <20251107210526.257742-3-pasha.tatashin@soleen.com> <aRHiCxoJnEGmj17q@kernel.org>
In-Reply-To: <aRHiCxoJnEGmj17q@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 10 Nov 2025 10:43:43 -0500
X-Gm-Features: AWmQ_bn3hTY0dfz8jKC-NQyPogDeCUM0IUVj5R8f5Xi9W9zl_j-5I3l31CcFnck
Message-ID: <CA+CK2bCHhbBtSJCx38gxjfR6DM1PjcfsOTD-Pqzqyez1_hXJ7Q@mail.gmail.com>
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

>
> kho_finalize() should be really called from kernel_kexec().
>
> We avoided it because of the concern that memory allocations that late in
> reboot could be an issue. But I looked at hibernate() and it does
> allocations on reboot->hibernate path, so adding kho_finalize() as the
> first step of kernel_kexec() seems fine.

This isn't a regular reboot; it's a live update. The
liveupdate_reboot() is designed to be reversible and allows us to
return an error, undoing the freeze() operations via unfreeze() in
case of failure.

This is why this call is placed first in reboot(), before any
irreversible reboot notifiers or shutdown callbacks are performed. If
an allocation problem occurs in KHO, the error is simply reported back
to userspace, and the live update update is safely aborted.

> And if we prioritize stateless memory tracking in KHO, it won't be a
> concern at all.

We are prioritizing stateless KHO work ;-) +Jason Miu
Once KHO is stateless, the kho_finalize() is going to be removed.

>
> > +     if (err) {
> > +             pr_err("kho_finalize failed %d\n", err);
> > +             /*
> > +              * kho_finalize() may return libfdt errors, to aboid passing to
> > +              * userspace unknown errors, change this to EAGAIN.
> > +              */
> > +             err = -EAGAIN;
> > +     }
> > +
> > +     return err;
> >  }
> >
> >  /**
>
> --
> Sincerely yours,
> Mike.

