Return-Path: <linux-fsdevel+bounces-11958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B89E859870
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 19:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC961C20DDC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 18:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2616F06C;
	Sun, 18 Feb 2024 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FyrkcvXF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6831E86E
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708279749; cv=none; b=jNX5RqVa5qu/y6SR2CANPqduSrrpXdXMrnsCw8QgIA6IgtfQY185SkN2p6C6Hj7C4WN7hkxXdD6XNei8+d65O0I2LbzxYWHvWyjXvEB3Sy5PoxS93NCRMhbJ5823FceyKzsyClLf3A/SApDK3opeJCWGcCOUW2LMnnKhO8YXun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708279749; c=relaxed/simple;
	bh=kbPWAQ81yFOpzBMcfNwlWRtNQ3ofesQV74Xe8M4ir+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYNjI2CTW/f5YItt89GqBn8aapbWTQPmI6tAuiYTkwDIAjuXy146YK1dIt1FjTiNnfjfLaQJm4mb99WBddTicek4dLKK8FC3lyd9uG7RK1rWt4DCUCyTtx5Idp8qpk8/TlcHUKQ4gBlSo7Y46uuzdubmw3f7Z36ZxtmtdxpcHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FyrkcvXF; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so26891331fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708279745; x=1708884545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0qfuARKCEioSs7NOfqEwHgFcGW2PXotvOgdDbAXJdk=;
        b=FyrkcvXFTuT7XEfJCEUXmM4ofN+HD7R9J4gJsCI+4xgGjeQyKaFe7ElqQMTaALA/0B
         AxPOmN4CiphXE+KNobXx+5oAedyPR01BYCZZ2768/YOlAfYoZEsIG+T0hglyoq2AhcCT
         PfzO+gwVIhlEoWek6WeYvn9/WsBh5XQGSN7Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708279745; x=1708884545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0qfuARKCEioSs7NOfqEwHgFcGW2PXotvOgdDbAXJdk=;
        b=Xy2D7M4/8TkLXQgEK8rh8/23W4hs/SZhIS0v/KwpYNaN9tY4xIdfoJUoUgyq8fqHPp
         bJ+WAVP9xIH0UEMf7K/wB2+nR6uU5Zt5XFH/3D1O/MKq7ibZLpHnbMVZMeVJo/HcShBZ
         dwcBJEbQXgKGbEg/PK7W9w3xL0vag6LCua82WiwSrdIMwYGQ1U+MW0vVfqyJmJaeqBPb
         8KeOsbrufzULWxMS1WPPlCAPCJN7fEYiTPADLkBB8+5F5QxTUVAAMZ8cL6rpfZlE/nAj
         IisoK6mg2jHllPPrsqo01Fulx4Cz1oMemwqgs6sp3ledEe4H4wWmR84Xo3U4FKjUCluy
         E2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsVkW8dCTwN+33GARegyuc/BUiqkuChb/W0hIXv7+68i+HnMteuDwL0WFNBoLztjHBhoVki+rrCferzxGXMuob0g5RsqYZBAE0mptawQ==
X-Gm-Message-State: AOJu0YxKwe+1T8edO4KSSU9qI0AI/EiXRoBHvg8p9f9Y926IwpRW9K+r
	BfF5sq451IGPaIsi3zNJ84MEYgaw8fYbovPMCjL5AhkXrTV2lzaJ9dFdx2Q5ceGRMwqEVBFj7fp
	D8/M=
X-Google-Smtp-Source: AGHT+IEN3NORDEq2MaPj71LELlKtFyfYbOHic53UrdVsJpXeQEvVjTPrnMbYnRJ9in06hwzxL4O5mA==
X-Received: by 2002:a05:6512:1024:b0:511:87b7:6d88 with SMTP id r4-20020a056512102400b0051187b76d88mr6844266lfr.32.1708279745253;
        Sun, 18 Feb 2024 10:09:05 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id i7-20020a0565123e0700b00512aadef912sm372058lfv.27.2024.02.18.10.09.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 10:09:04 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso28858731fa.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 10:09:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULuW+XHMwNDemhlrfYFydU2DQGDEs5jhYNKF6IB14uwacSRTQWu6sIP+h/T/zUI8oZmcaDwY9mGsS4t3jlbvrHF61puY83uYhotcF3Sw==
X-Received: by 2002:a19:8c48:0:b0:512:b415:5a6d with SMTP id
 i8-20020a198c48000000b00512b4155a6dmr174757lfj.11.1708279744122; Sun, 18 Feb
 2024 10:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner> <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner> <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com> <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner> <20240218-anomalie-hissen-295c5228d16b@brauner>
 <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner>
In-Reply-To: <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Feb 2024 10:08:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
Message-ID: <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Feb 2024 at 09:54, Christian Brauner <brauner@kernel.org> wrote:
>
> So, I'm running out of time today so I'm appending the draft I jotted
> down now (untested).

This looks quite nice to me. Written like that with those well-named
helpers it is much more readable than the old nsfs code, honestly.

The only ugliness I see is the one that comes from the original code -
I'm not thrilled about the "return -EAGAIN" part, and I think that if
we found a previously stashed entry after all, we should loop.

But I think that whole horror comes from a fear of an endless loop
when the dentry is marked dead, and another CPU still sees the old
value (so you can't re-use it, and yet it's not NULL).

Which probably never happens, but I didn't think about it too much.

Anyway, that issue is pre-existing code, and your patch looks like an
improvement regardless, so that is *not* in any way a NAK, it's just
me musing on the code.

Al's email address has been bouncing for me for the last week or so,
so presumably he is not getting this and commenting on it. Oh well.

Anyway, ACK from me on this approach (assuming it passes your testing
when you get back, of course).

              Linus

