Return-Path: <linux-fsdevel+bounces-39209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A4A115B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAC2160649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A2E21E0A6;
	Tue, 14 Jan 2025 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9kedv+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D214921420F
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899016; cv=none; b=u61oGhFg4TWDHKIrrvDZV6LA8RHPuJFz41f4Pj0JA2otyknMu3v/8dM3BV9t05GpoRnNG78sX8zU1GjJnIgNzDsSGGpB9HtTKn5Z5lwjJAy9ziTOQdD38DmQl6vU0HSLEjIBLBcSVJ+h/zkjLrqq8a0wImi4yZa4G5njJEygbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899016; c=relaxed/simple;
	bh=hsDXwmzK+MEbUTf1nmH+fU3nSl1k+Il7rWMBGEuCIjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ClBiGuS1zibJxuGFBZf8XXcfXQpy0mKzLTnDOV5LWO0yzG2+LzCy05GPxfSt3tpooAvE1oHRmyLl0LKDGpSESfs50G5npXRi8w1ggpCfKLezmqOTJ8tqZ0HYTfY30RaJA/FeoiT8DD8wNn1sT7Qu0i7jX3DwCyzGf67Ezcwqazw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9kedv+E; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e29a0dfd6so415238a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 15:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736899014; x=1737503814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsDXwmzK+MEbUTf1nmH+fU3nSl1k+Il7rWMBGEuCIjY=;
        b=M9kedv+EmytPQRJS5vDO2QW54eG8n18qMKR5X577V5SdNMdY3AmkHkp6/xynmK68rD
         stT+dWvypE+JJzRT/9t3pQ2wrGZPJ9xVzawrqEEWazhuz2HAEs3ukKb81m44kVNku0z9
         dvQfqhHGMMfAgCdbyVu8wUtfn5dt8xutg4TME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736899014; x=1737503814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsDXwmzK+MEbUTf1nmH+fU3nSl1k+Il7rWMBGEuCIjY=;
        b=Zfng72gi7XTpJtJfZ3UQol9+dxDruYLwGyc68G4z2Ce8UHd3cuqD+IOmOWHbri4IYC
         vCse7gUD51IIczUGS5shQ1p8ikJux4kPecTxIsVj5NaNYZxTweA2duUZwNPr2OfUe8UI
         50bt8mb5Yc5g/AD7fb7nGhw2A3puRvf2/F2WJw+XeBKlrMCYx542SlSQvwXjA4sd+7i/
         tUCBoSdWqbJ/uQafpmmYP/lazE48yco8mztCpBKiPqYQohT1PR1ERndBG/2lsYkc8kGt
         o7Ebw/C27ICuWHwgbulVIr5JB8MsUOVfG11xIlLDfWjrOMSJnj7kOhwaNyn3x/I4XlcN
         zbPA==
X-Forwarded-Encrypted: i=1; AJvYcCVs5rd/b4oU59w8U2Ht+FTs0Sg6ClZ7R3CiIMEND44V3rJz58bf/bANQqEGWSb23eg5+l9ymqxF383qEfJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YywLMgvbYu82izIzl6TJOnXPo3kpJurXECodyWT0w55/4AjIfzK
	Jk65kyO8J6FHYJX7DuW7zKCV+B3mr7oenRVZYr77ZolOy7OlcXaxQQV+AE5HxsOMnYswl8ELLnu
	2/Jc2S/FJyuFXW1MKGJR4jki+kWj+YyD0eoQP
X-Gm-Gg: ASbGncv8ffViK0x40o55SEVo008i2BN6+ivN4sr0aPgBe3YR4CtmG1Y71xs1XDu/O9A
	H5JBgTeP9jx9pbuNr7j9vaJG65c3szrr0UlWaZkdmgZ9bKvg5fdcVsPffhsvpzWXAeH4=
X-Google-Smtp-Source: AGHT+IEAw2B5tCNJDwUL7Y6+KMPrK0hY5kh46XqIOUz3BH2q9OUUWw7ikrIg6V0VzXoo+NOVvkfJ1O15Pgg2qtc+B/I=
X-Received: by 2002:a05:6870:718d:b0:29e:57b1:b20c with SMTP id
 586e51a60fabf-2aa069758f3mr6115602fac.10.1736899014008; Tue, 14 Jan 2025
 15:56:54 -0800 (PST)
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
 <Z4bC1I1GTlXiJhvS@google.com> <202501141326.E81023D@keescook>
 <Z4boRqW9Gv57GDzu@google.com> <CABi2SkVqa7o7E82m7c8KTsHO4MjwCsdtp21UO+wb_A=r-+aqmw@mail.gmail.com>
In-Reply-To: <CABi2SkVqa7o7E82m7c8KTsHO4MjwCsdtp21UO+wb_A=r-+aqmw@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 14 Jan 2025 15:56:42 -0800
X-Gm-Features: AbW1kvYVUAP5xVIsnmRsQIsr2TbfB3Xp5ZrZuZOEIpJoQq_ZV6Ao_Nj-QrGDqBs
Message-ID: <CABi2SkWE6dguS24oSoycB1z0dCNS1iqW=ftv56Vpm4EtaMTX9A@mail.gmail.com>
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

On Tue, Jan 14, 2025 at 3:41=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> wrote=
:
>
> On Tue, Jan 14, 2025 at 2:42=E2=80=AFPM Isaac Manjarres
> <isaacmanjarres@google.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 01:29:44PM -0800, Kees Cook wrote:
> > > On Tue, Jan 14, 2025 at 12:02:28PM -0800, Isaac Manjarres wrote:
>
> > Alternatively, MFD_NOEXEC_SEAL could be extended
> > to prevent executable mappings, and MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
> > could be enabled, but that type of system would prevent memfd buffers
> > from being used for execution for legitimate usecases (e.g. JIT), which
> > may not be desirable.
> >
> The JIT case doesn't use execve(memfd), right ?
>
That might not be important.

I also think selinux policy will be a better option for this, There is
a pending work item to restrict/enforce MFD_NOEXEC_SEAL on
memfd_create().


>
>
> > --Isaac

