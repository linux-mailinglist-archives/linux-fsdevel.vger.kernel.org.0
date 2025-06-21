Return-Path: <linux-fsdevel+bounces-52384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EDDAE2CDE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 00:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32155189345E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8B12749FF;
	Sat, 21 Jun 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5FMOh+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990F1BC9E2;
	Sat, 21 Jun 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750546234; cv=none; b=q8terepF6qIchpiFiSNe//PRUC5mlDn956BTgGxtdTv43QjwO5mHoJALd49hMmeAQQlFNUQ6cY3YPaZy8Wm98GVzg2GKLN4NRvTHATd2FusN3l0526CUisvUM3j0IGZKAcyzuCHJpLQIM0bOxSQ7wOJSigPcc2BHkWdRFjPSN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750546234; c=relaxed/simple;
	bh=rEzJIzRTm/YUdx6Llmb/okZM3u3fuKWkj6qzoThEJ1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL6mwb0eIwJIa4JfqDZwy7yfKDtUv1/0nPn91q2n48h+DpFbgO/jAWqMpFXYrTcs/Qa3tJvmp7yOXEqTFmmT2PY1icDPrcpztGSdMscXyCiJDn4ZaiYQ57T3Z7sFB6ofi+b20dW6/JYdpi3+gdHvBveXtaqeN/PY+lJrBAoeAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5FMOh+f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-441ab63a415so31215015e9.3;
        Sat, 21 Jun 2025 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750546231; x=1751151031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEzJIzRTm/YUdx6Llmb/okZM3u3fuKWkj6qzoThEJ1I=;
        b=e5FMOh+fF0/67utNC34kueuhQtgj1j8CwnZXNaMDyAvEEOedkuAi+50n8HxbQPMc/S
         lOdEklSTPYcktB5LpU/snYmUBR8XD0nagMd5UfXYpDX7HB4os//MIi6mNbW7FugDpEBM
         VkngpEr76vBNMGMnCfWTKaMH4GFYgSS+ouBMe59XsVgDsOU+X6WTz11wulD//uRv0eyt
         oxdJO7gzTh3RYVmclUTTte1xU8jMH84cy7PMtYZv+0D5SJsLCwB76bJiqqRwqrxUuD+x
         6EqDFLG8lkKHACjXZfyFeRtVVH2/nVpv47aWVxMQLPrLyxrz1ZcAvetOHzQMxJtMdCrE
         +SjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750546231; x=1751151031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEzJIzRTm/YUdx6Llmb/okZM3u3fuKWkj6qzoThEJ1I=;
        b=pl/M/BP54+rInOMSP5V6rklbD1aYh4dzFoIudeC1ao4ybtdofDD/I5Y6nb4tbNIK8s
         Bwq2ipC6AXIxxLNj1zfjsBsiQ1e1lt6Qyqv9obaW2URViQ3wfepbrUb5UMnI2up3Pk8q
         l0BGy116naohzKT5+DuzqcNvtZT0FNUFwQ20tTre0yfsFhvPiH1prIFxY/9QxsoPWroY
         pY1/zSvmUPCT+VmuPOIBxyRe+Zn0HwAEP6MGh4v+1v++o3L3+GPE5CnsmwPqGIXQw7Os
         iUAZnLGowvIMBk9kCBPqWgeV0CxM1RXCutyCaLXajOXVAZHnB6GVvIas/dwiTz7ywFeH
         IVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAUaPPc3PsGvykfqum/0p6R1VWheeBLIOXzyletgVs21SdFfMwsXoQZ8F3wnyeeSqZ1xetEz7I36kRE/kM@vger.kernel.org, AJvYcCXw9m2DtAbUFsAHHYl6qNpQzbRpAqJOGA/RhJMJRSW+yc+A5sgnkxRpBwbqfgxkicTHAVSPnoxw+zrW7Un6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywix+EnMdoVTm7jdXL034IuCE75nu6KSLcgAT1BLt1wVUCtjuM7
	k3aarM/syQXjdQRzzotXLRetmOHyurudJooKdQ5Myl3Usw9laW7UCcht4ITJ04AhlwyzUg4mtgb
	eugVC9H4Pj70apVmmQNwAMYnUz/SYnrKAPRQE
X-Gm-Gg: ASbGnct9fE4dkFK26FQDE2WAgtuKePTfjTOKCWFp77Hd2dIxRnuCqQt2WRYf8JrsghA
	Xk4uZiK6Ni6Hkq8uO88Ucra//VWm7A7mCmYYlPygBW76vH4dT3Y3ufG5GHyGn4DhF2jLWFsOfdG
	ALz+7TfkmSIiD31KxjtzI6vr44VbAncBysEtSwtTUPbBYNWwruaESdVtJn
X-Google-Smtp-Source: AGHT+IEzYCn8AOW+cg5eQcUVcnpI83Pm0gkl+jOW1oyfFpHezBtxDezT/LR6Ic9+jpSub9FPkoHpVADInpiiawSU/Kg=
X-Received: by 2002:a05:600c:1da0:b0:451:833f:483c with SMTP id
 5b1f17b1804b1-453653d4544mr67884085e9.7.1750546230969; Sat, 21 Jun 2025
 15:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4xkggoquxqprvphz2hwnir7nnuygeybf2xzpr5a4qtj4cko6fk@dlrov4usdlzm>
 <06f75836-8276-428e-b128-8adffd0664ee@sotapeli.fi> <ep4g2kphzkxp3gtx6rz5ncbbnmxzkp6jsg6mvfarr5unp5f47h@dmo32t3edh2c>
 <3366564.44csPzL39Z@lichtvoll.de> <hewwxyayvr33fcu5nzq4c2zqbyhcvg5ryev42cayh2gukvdiqj@vi36wbwxzhtr>
 <20250620124346.GB3571269@mit.edu> <bwhemajjrh7hao5nzs5t2jwcgit6bwyw42ycjbdi5nobjgyj7n@4nscl4fp6cjo>
 <ztqfbkxiuuvsp7r66kqxlnedca3h5ckm5wscopzo2e4z33rrjg@lyundluol5qq> <CALJXSJrWjsAgN8HDUAhr5WYB97_YS57PuAhwpRctpNFU6=4AKQ@mail.gmail.com>
In-Reply-To: <CALJXSJrWjsAgN8HDUAhr5WYB97_YS57PuAhwpRctpNFU6=4AKQ@mail.gmail.com>
From: =?UTF-8?B?SsOpcsO0bWUgUG91bGlu?= <jeromepoulin@gmail.com>
Date: Sat, 21 Jun 2025 18:50:19 -0400
X-Gm-Features: AX0GCFvokSGuLxOCoAtQRhQm9JH8wBQM8VPoUnFJ5HJjfKAiIMn95QNj4-lQrrM
Message-ID: <CALJXSJqAuFqGN8jtddeZp5rEuwWbgZubbV+RY=br0tm_xD0Vew@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc3
To: linux-bcachefs@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "Theodore Ts'o" <tytso@mit.edu>, 
	Martin Steigerwald <martin@lichtvoll.de>, Jani Partanen <jiipee@sotapeli.fi>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for bottom quoting, Gmail issues, just clarifying this was
meant to be a standalone message,

On Sat, Jun 21, 2025 at 5:07=E2=80=AFPM J=C3=A9r=C3=B4me Poulin <jeromepoul=
in@gmail.com> wrote:
>
> As a bcachefs user who has been following this discussion, I'd like to
> share my perspective on the current state of the filesystem and the
> path forward.

