Return-Path: <linux-fsdevel+bounces-59498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1045B3A159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F43A0817D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BFA311948;
	Thu, 28 Aug 2025 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KS6Hnug+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81031F37D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756390115; cv=none; b=dtEwlvM64GtYu/KYFLixWjMO47GuoJkOyPQSAluZUjm4TZT1yp16aS86Xq11bUlG6RFPu2AXQibDUzhLZfM86RW/YjutK7d72e32UeRpfnT5Z6hpLaxBOGMLNv9NL+AxkC1DKoYQS7dtfUzLNj/gwfk1IoapHUYYxIE7fAUTFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756390115; c=relaxed/simple;
	bh=8lxPMqWWCWP3DHxdxDQJ9DqCqUQdf3kaMEmAXDwTcVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjhGaIR01Im4GG0+NCisU9HMyZqCwu55MMjZf9yzNB2rO/XP7UlilJ+LoRKC6KBhVF2zZpCwtZ1BoPb+v5NFmw3tLlSmqMK9q2Vi0fCtSmjJAs/Cr6RDoQmML+iJtXOY2zSP8dmIzb3lpqvuzJU7W3IYFCHo7Cl1pOG0Z0HAJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KS6Hnug+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109914034so12021121cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756390111; x=1756994911; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yqx7p8UnrTmi/mPLjfIoXsH/wHTOszMfO6rtmNm9KWU=;
        b=KS6Hnug+XJb+c71Yz7CMcSX1dIiS7oejLXqNNfgcjFFsp09JbDb8I8v3B4mFybyWLV
         Y00OCecsW+/zeC0puiFfXWC1jRfODecPcqwfbQj4YPTIcMGwkV4+MO32AnpCSNIZZsKJ
         dVMetkuHjD/ocFMV0zwM5U4dwRawIdYU0vy7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756390111; x=1756994911;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yqx7p8UnrTmi/mPLjfIoXsH/wHTOszMfO6rtmNm9KWU=;
        b=cNj2zUocp3D8mJThtUCmiSphvwVjTnHaf9iFeSi6Su68vN2lF+cvOmLTrruBYpHW9u
         AKrjEVRqpPcfqlVjWMWP7iLRftwxBY3uuPtfmarXnvV6QVxatNVHseDd8cuypOtj1OKp
         hHK9rUGt4000dkSepqdBDXqGYglf0WpEPkQxbKZSx2b10uWGtstDepqN5jpjoWZNav7K
         cmjDuqIOlf9niXSjkx0gi4RG1mD6Zeqrw9fGuutZwUB0hCBA1CxUDrHhzZA5Hk1OL2X3
         43HkNolxF3NuCkWST9IrKRjgX+jqccN/iyAC8+N3lotZA030qdzKfHszfxZoruzHL7bc
         wDmg==
X-Forwarded-Encrypted: i=1; AJvYcCUQgCdK9pGGxt8f6UFO/D8Y5qJ2Cn/rgQer/4Y7V0bKqVEFs/n+UkdCWdWlmGQ0BjE1kNGakedDAlQ7Pxyo@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBbD8JSDnKirm4Jl7qOfS/OlYFHW+BpkWhxzw/KcLReCHafFN
	rL+xNsX6Nd+bz9KAv/Pvk32UwPoAy9WWgjLbV9y1pzC73AJnEHndk4ZmDskDPYMVxXGZwNTxSiE
	Kd91iFQg6kZ0ZLjvvRKJMO9OFlki6TclHXZhbz1Y51w==
X-Gm-Gg: ASbGnctBqShpUyN9FIIx3xRM/NC0sQsYvT7gLQcmyylrCeL98XzU07l5BY+k4ASxl3a
	br7QKdeJaYmRzWDRi7kt5qW8BiYPhNTcctFgPKoY1tk1m/hmRMqJHuk028Rm7X6aE3FE3vEaB/m
	wtlK760qsGhKQ5sKcXniwZzDMsi3aBsM1Jz7fW9bzQyfGRyionY3OqPviroUuwR75EwJaCGvCq3
	16sMh9sGA==
X-Google-Smtp-Source: AGHT+IHqtsklig/8cbvgInoLtmyO/Yuu/ACZzn+3KSu1XQSf3kJWUgrbIjBOezjb3MhpqTrCdeNMaiECvVjHw8gaIFM=
X-Received: by 2002:a05:622a:2512:b0:4b2:8ac5:259a with SMTP id
 d75a77b69052e-4b2c79ce4f4mr222506021cf.67.1756390110940; Thu, 28 Aug 2025
 07:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs> <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
 <20250826193154.GE19809@frogsfrogsfrogs> <CAJnrk1YMLTPYFzTkc_w-5wkc-BXUrFezXcU-jM0mHg1LeJrZeA@mail.gmail.com>
 <CAJfpegsRw3kSbJU7-OS7XS3xPTRvgAi+J_twMUFQQA661bM9zA@mail.gmail.com> <20250827191238.GC8117@frogsfrogsfrogs>
In-Reply-To: <20250827191238.GC8117@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Aug 2025 16:08:19 +0200
X-Gm-Features: Ac12FXzFqrCCVA3nB0_wYWUg6fyZJdoOf9xwvmiDyagl9szTS3f9ixVC2NCyrzg
Message-ID: <CAJfpegu5n=Y58TXCWDG3gw87BnjOmHzSHs3PSLisA8VqV+Y-Fw@mail.gmail.com>
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, synarete@gmail.com, 
	Bernd Schubert <bernd@bsbernd.com>, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 21:12, Darrick J. Wong <djwong@kernel.org> wrote:

> Well sync() will poke all the fuse filesystems, right?

Only those with writeback_cache enabled.  But yeah, apparently this
was overlooked when dealing with "don't allow DoS-ing sync(2)".

Can't see a good way out of this.

Thanks,
Miklos

