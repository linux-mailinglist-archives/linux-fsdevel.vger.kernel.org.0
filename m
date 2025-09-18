Return-Path: <linux-fsdevel+bounces-62157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0842B8632B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 19:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B23ADAB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D631A54F;
	Thu, 18 Sep 2025 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K96h17TL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923F313268
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758216269; cv=none; b=c4k04pkq51aif1Ok9jtnW995lskltguR5O0JE5ah5Wk1PR10w58zAoN8NoF0a1D7WzHaihUkF9QpZQeDIaVYovZcpUTZVtjp6/97r79BriSY0IfhDEON5xrLLIgsWby9so572hcgDmcMDfrVaRQJmul/PWYBdEr8isOCyUxKMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758216269; c=relaxed/simple;
	bh=VPVaLq3mEhpTLnLGgFBqDthQx4v4zfVov8m51kTdsRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTKsAukjBh1/Zuun36VpaCoc3MHZ9X2mvtQnj3lMIzqywQz4H2FCoXMGTWNLZYaP3m3Jx9iZZU+3cqo2NnIgqROKR6JlsWpV3DPt5oA9Vcww0h3TsgP5lQJGiZpiuqtkXIP4LMMeJMrV3jvEOecI2lNDpqOF3A58syTG/JTHccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K96h17TL; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e8123c07d7so1035247f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 10:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758216266; x=1758821066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epDoJHvLYqW2JL6NNPKc53wLkRtM0zeExMM8c9t1quc=;
        b=K96h17TLtGLiQ+jtYwQXqYRBF+MV55l8OrAIg3e+N/O9IuSoCcFNL9x+q1kO8Kaowr
         ZBmL2CMFuZPoYSnhtRm5avT0VEDbHwbpWoNFAAT5cqK4v8lJTZ51fLPJWze4iE6PuNA0
         jEYnrT3lTr2TV4GQGFBZhVC4TpCXfXoVansGkOpFRBjGmjTHGBKT1G4m4rzpVC4KB/Ly
         0LNtxw1/Hna0dI6tJ9L/qmRdC8FHfG3IFZebW9EqkZdFd4FyRBfMwHG6i4Hjzr0y0eou
         S4CRlEg5/eJ2/QbbbrrE3lTnMZKfzcbMaa97fDgHPySkLl0rYeTeyngJPum9UUqEgeRS
         iq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758216266; x=1758821066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epDoJHvLYqW2JL6NNPKc53wLkRtM0zeExMM8c9t1quc=;
        b=kTFEFEs9fQHiJotSIL5aXd7BW2WJ134Pboz8dc+HWdN0UDRIdjxjf5JQCCPzhSPI+0
         Lw060Ec+R4VsREedDup+I12osIXlHl1+OxIRjsSF9DBi8m1Kn4VzZXC5Woxr0HDLrH7o
         iKI5bVJfDK6cs7pVPz9JxCt3E9HnEbo9PcvOWMOXa2hzcycfzB/Ols+SsfORO8zzaR0L
         MLMqGaQVFGrMHvv18iLbjVOg1BNcGZAicAP+at9s5rACQPmDGbKT0g039ksXF6M+cUIs
         FZE4Gncf1mrcIxLUteUY9Xt9wiY9CdpnpAweD1a4yRoSeH1K/P9zQW6eA8oyjGjxpdTB
         0EOA==
X-Forwarded-Encrypted: i=1; AJvYcCXwc08CFlWSRKz7u+I1ihVZxpGVV+DsZMyHC8syUOXVZEIQcpMSPA6P7tbTfpXflXSAp/14W0qjiZIZo7Ck@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vf5SrR9QIhlQ6pwWGg5BsDt+2IgX13OOBnkas7trwVLevQ1Z
	BDvmTa6l0KIH8F7RUCPDsRZs8SW4tfr+/xWi+XszG+rmdKpzlnhKrmIkLwcrfFG+F6wvUionP0i
	ITQe5zMAqBgREFjRVlskWx8ZpHBm2Ozj7bYcXmLBH
X-Gm-Gg: ASbGncvV09Z2m22DWzI2K9Y1KLpeJDbcsjye4aK3ZwqOn6h5Kb1j779u2eQShwxH020
	PniepmXzWyuE5Wse454SnYBXq4USllPz03DZM2YsvznT4H1i+2xxeUtykJl+yqVCu/Jzk+QzDEJ
	/IPTNrJbGHEd1LR7D6b/IXYQz6JrNSPqft0sMG1M6cYCXemM2oybILThm3XDZeGTLlnpZ1jimx5
	Z8HIBYx/Bngd85tdyDih6ApZpTlkTXihuKjHaVMt6RAxDsPYd1TR+NVF6r3L5mx
X-Google-Smtp-Source: AGHT+IFOw4CJFmAI9RamLzW4T7p5y68pw3l7sF7vN11tflJvFcK2DY7GQts5zPIH7DY4olKyRLU0HJAAK0jICO110J4=
X-Received: by 2002:a05:6000:2301:b0:3ec:db88:bf1 with SMTP id
 ffacd0b85a97d-3edd43c02fdmr3984418f8f.12.1758216266082; Thu, 18 Sep 2025
 10:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918144356.28585-1-manerakai@protonmail.com>
 <20250918144356.28585-3-manerakai@protonmail.com> <CAH5fLgiDJbtqYHJFmt-2HNpDVENAvm+Cu82pTuuhUvgScgM0iw@mail.gmail.com>
 <d90b10f1-2634-481a-beec-ce9f31aadb74@protonmail.com>
In-Reply-To: <d90b10f1-2634-481a-beec-ce9f31aadb74@protonmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Sep 2025 19:24:14 +0200
X-Gm-Features: AS18NWCJ-KA24BPiLVdZMm7KuWsn9wKB2ov2s7U4hMX9LGAaLcStRnnsDeNwjmk
Message-ID: <CAH5fLgiCzcTo3VF5Of=_bHO0H8+_uPKYwD_aG_Q-oJc3sf+bTA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: miscdevice: Implemented `read` and `write`
To: ManeraKai <manerakai@protonmail.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 7:22=E2=80=AFPM ManeraKai <manerakai@protonmail.com=
> wrote:
>
>  > We already merged read_iter / write_iter functions for miscdevice this
>  > cycle.
>
> I couldn't find it. Can you send me a link please?

https://lore.kernel.org/rust-for-linux/20250822-iov-iter-v5-0-6ce4819c2977@=
google.com/

