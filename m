Return-Path: <linux-fsdevel+bounces-30316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C8989671
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 19:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE7A1F2271A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Sep 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182917E006;
	Sun, 29 Sep 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XMwHn1yJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A717D346
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629673; cv=none; b=KaYpTSlzANkyGorvBKxCYeCiV6UNztmwVL+GuaQzZbzubLU+ff+yUXiSyEdNKLQWJdlVfq6ShwXliYDKuugwOdJOmttCTybWYGuQx3iMe0yiWEXOL6W9TM/N++z5oz8wU8xDsCHNeb2gp9iitBrH7vtRb0jYsNrD3KJocd3gg0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629673; c=relaxed/simple;
	bh=zdQYds0Tr0LdpW+LpaG7tiCiVFzDs3F/aeP0OfreZ8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoeUBG3FFDhTz5fb1HdsuRUNtmTlHytRn6YFmqchFM8hgsGpZmBFVvrgi0D99a32t/2XRr6RvgpiSXqFX/G49fXfXiFl83olAFWR8mZlPNZOkzIIFqtLbdhIqkOtxNn+kQBAdL/vRB+fSnEJE3Xh5JGHRCAp+ofC8yXPQ0uTN5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XMwHn1yJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a910860e4dcso631009566b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727629669; x=1728234469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M52U77mSwWLSAVE80WRwbIbF7nwQGMEyIqyXqj0p+m4=;
        b=XMwHn1yJuhQoPf4EXoY90XMZTnPm9Wz1+XKB6F7A0hHmkhLttvc0N8CWNATAaCLecT
         hWGwJ7HDFQC3ZCesW4w2bdvKh9aTZY7dMTBliecyxUuxXBRbfH11iSz+xGDf8meDosyX
         K0N1+OpPIGLZfuIWeTU7/WIM8sy4o4d0cgjU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727629669; x=1728234469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M52U77mSwWLSAVE80WRwbIbF7nwQGMEyIqyXqj0p+m4=;
        b=Pm+WhU4Z+mgWzoZO3NU+mTMJYCUKlMO8YTAp8+HcQbh+f60VTKLJOARd7c3znDn5kR
         VE6N6IBVkjJ6NLsw3czCHJ6TLIRCBA/Uy4EysZ6DRgYtLuBxraiCYnL7OH044J9ufMx4
         kdR1auoRVAYzj4saSofOh+C1Pmb7TaDya0f2FTGWn9iuLB3EE3n2dpQP4wXHxQuDmTxn
         ZJH3KiYzL/+E/YzB52LXCWaceisbK9AQJOSP657ilGitA46KTR+m36lqKIE9AdTwaHFA
         yIPU3TZ1YARZqtx6QqB3wcYR/SZoprk6HQREcLokBAxKaTdoCRiQzTCBSTYEPnPz72C1
         mz0w==
X-Forwarded-Encrypted: i=1; AJvYcCVcLkVQefN0UM059GiYal/JZcPP+1tTBHmqNUoxrMB4k6Wkj9Fsbfo1iVGh4pVt7GlC0yVgohzEr5gCnsVs@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqYjqRlZe+rWpklYNmm3tOWsn7dHhi+yYqN5pkBzDyyr7qhG2
	uqR2n6Ki9rNLo58WigAvlWBp4a/FL+OBZTgE+gE2jAtXpS96f+pr2eor7w7lH71/kTSN2vjnuJg
	4v0c=
X-Google-Smtp-Source: AGHT+IHnzMzVppYRk2uGlG4h1k7AZZiUG3gD6AkryuCCJ0ocbZwqvyzOL/+uIzEHtwZZSkWooxntkw==
X-Received: by 2002:a17:907:6d14:b0:a8d:592d:f5c with SMTP id a640c23a62f3a-a93c4a67782mr1264861666b.43.1727629669098;
        Sun, 29 Sep 2024 10:07:49 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c7130sm397123666b.67.2024.09.29.10.07.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 10:07:48 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so386104a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Sep 2024 10:07:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDFvXembaX6kVPDoB3gylliFpuqML0o4H5RsBWvwY+RqER+gJq7wlkU8a5k+penBARQY+aTZhMnHTFC8bI@vger.kernel.org
X-Received: by 2002:a17:907:7f26:b0:a8a:7501:de39 with SMTP id
 a640c23a62f3a-a93c48e8df9mr1133342066b.9.1727629667829; Sun, 29 Sep 2024
 10:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929122831.92515-1-laoar.shao@gmail.com>
In-Reply-To: <20240929122831.92515-1-laoar.shao@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Sep 2024 10:07:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_2Y3=CjaZpi9mH3wq_E96EaJ133jRRg_vaR0Oi94R2Q@mail.gmail.com>
Message-ID: <CAHk-=wi_2Y3=CjaZpi9mH3wq_E96EaJ133jRRg_vaR0Oi94R2Q@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: Add a sysctl for automated deletion of dentry
To: Yafang Shao <laoar.shao@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk, 
	linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 05:29, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> This patch seeks to reintroduce the concept conditionally, where the
> associated dentry is deleted only when the user explicitly opts for it
> during file removal. A new sysctl fs.automated_deletion_of_dentry is
> added for this purpose. Its default value is set to 0.

I look at this patch, and part of me goes "I think we should make it a
mount option", but at the same time I'm not sure it's worth the extra
complexity, since this is such a special case.

So Ack. While I'm not convinced a sysctl is the way to go, I also
don't think it's worth bikeshedding any further, at least until we
have other cases that care.

Christian, I assume this will come through you? Or should I just pick
it up directly?

                 Linus

