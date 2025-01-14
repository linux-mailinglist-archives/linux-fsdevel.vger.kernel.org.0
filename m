Return-Path: <linux-fsdevel+bounces-39204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A6A1158F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D4A166941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E47222594;
	Tue, 14 Jan 2025 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QOBBC+DB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194B20AF6D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898075; cv=none; b=oP72n/DBt6227pcJYXXR45TdpcdLbeU1O/T4XxCPhyAUKQBwj1GbDNQmeT78uFk3QoNSkRAwZoqTVqhtALiHiD6BaomSUXpcNx4PSg95Rbao1sJo9n+al0ZDqaNL8vWyvp3wP/JK/3tG5VMUIdtCSM0d+QZ4rVKU/2AgKRAo+pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898075; c=relaxed/simple;
	bh=3B8j00eSEg37fEaAXzPpRwW6KIITIMSCXjNxb2TcjAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjXfyJoDlvzpiFzxUcRgFIf0W/Trsy3qgtbX1+i7JRLl77xDrN2I9r2fjH9eRlPlicYA9k61ZWwiBZU9cD25TWT1rvekZNRu9USKbH56yFXfFeUUANiTxrERIw2YY5xTkY984ZHUVRkX7H4nLrv79InOPzcbqvx6+hoKjPCAb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QOBBC+DB; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71e252c3c19so397911a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736898073; x=1737502873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B8j00eSEg37fEaAXzPpRwW6KIITIMSCXjNxb2TcjAI=;
        b=QOBBC+DBA29fTWFyIhnZFo+Ip3UCMMqIapcpSpqFHU67n4sRKUmz3DpaikSA0tDsY+
         VT5nX+cZwobagxk0iPYSFE0dU3/VeJFn7Au1j1QQ1RkG9lpAIuJ4XOTJ3wGrmeAL8iR0
         OXpwhQi9EcwEAQqQz9U77vmZeFwekFxfm+6cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736898073; x=1737502873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B8j00eSEg37fEaAXzPpRwW6KIITIMSCXjNxb2TcjAI=;
        b=c4vNMWxagoo7ZDonZtZ2gwTf5Hr+f2wGr+bLaftWH4xntOvjmgWluY5fbQwI6Xajw6
         8NO2mYs65SsgHdctlE8308527t5TKGz1Zdl+Exty6n8YSjur4ZX0hhRBE2ljzLmwXAO3
         jgNZIXPWpkQf7LneSJe4VhcIH7kPPGh7ROs9lt1E6PtHNAKEMOQvXBV4Nt1K+ut/VztS
         iHfcCDPIYFKmrEzct3BjnvZ4j7toVSLfnjcfEci5YQ/8sCcbbCmspsHTL8OKaukPHoUq
         eTFip171g04XSANbcWZLPO4MhUIXCSgJF/llV1svFy1hzGAcP6YOZgSsTmWEz/pfKrC0
         BgjA==
X-Forwarded-Encrypted: i=1; AJvYcCUv1MotwC6JcU2ZIxuroydOOeZZ4x3kX5UtuPahpaWoyzRXbUts2YQWjgnweUV3ryykcpv6hi9ly0B9bSLO@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqsfc0dadWSm3UpqMKpVVi5d08xQL8iTNyftsW4PghJqcDvxMS
	YssIBp2HPurwlk4rkZOtoRGxtCCFVhjdI/KJdB4U7/xM7scCCuo1UKtkLhrXB0Ac2FEDI6pVAMS
	y0oW99sPYqlaclcxJgp3aHxdIF3ZTLcEJJHrP
X-Gm-Gg: ASbGncuKFInv9E7WgHqD3Sjwpcwr41STWa1nVcGmVwD3qeD2rBFpAo1q2Dm6fYDT/ej
	6gEjYtDjfxox1OEzpX3Ilrcxlbhl9tPKmOufM0/nptnM1ekOQbiZ2c3/nK2HAtq45esk=
X-Google-Smtp-Source: AGHT+IFsxdxAj5uDDfRMODfRkctmdNwKPiaPnxX0N+8IXey09stJ81ZQL9rOFw9h/m9QU/FLiQYhIIqpyweJHxf243E=
X-Received: by 2002:a05:6870:2a43:b0:296:8deb:d14c with SMTP id
 586e51a60fabf-2aa068070f2mr5322435fac.8.1736898072710; Tue, 14 Jan 2025
 15:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook> <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
 <CABi2SkV72c+28S3ThwQo+qbK8UXuhfVK4K=Ztv7+FhzeYyF-CA@mail.gmail.com>
 <Z4bC1I1GTlXiJhvS@google.com> <202501141326.E81023D@keescook> <Z4boRqW9Gv57GDzu@google.com>
In-Reply-To: <Z4boRqW9Gv57GDzu@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 14 Jan 2025 15:41:00 -0800
X-Gm-Features: AbW1kvaFU3ktWHZsWot8W04v-eF2GY_9VBvBnGe5wzGI_v6Sbb1GKmM0Ti_6fT0
Message-ID: <CABi2SkVqa7o7E82m7c8KTsHO4MjwCsdtp21UO+wb_A=r-+aqmw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Isaac Manjarres <isaacmanjarres@google.com>
Cc: Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:42=E2=80=AFPM Isaac Manjarres
<isaacmanjarres@google.com> wrote:
>
> On Tue, Jan 14, 2025 at 01:29:44PM -0800, Kees Cook wrote:
> > On Tue, Jan 14, 2025 at 12:02:28PM -0800, Isaac Manjarres wrote:

> Alternatively, MFD_NOEXEC_SEAL could be extended
> to prevent executable mappings, and MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> could be enabled, but that type of system would prevent memfd buffers
> from being used for execution for legitimate usecases (e.g. JIT), which
> may not be desirable.
>
The JIT case doesn't use execve(memfd), right ?



> --Isaac

