Return-Path: <linux-fsdevel+bounces-35630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8109D67C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 07:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4496AB21FAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5B16DC12;
	Sat, 23 Nov 2024 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IsMpb+GE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05882485
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732342166; cv=none; b=ca+2kKfoFlWJF4BF+PEexcfznIUnVMPWitsHrSCUGVI1ub6pNgkZtFFpc2gpSYUk6lC8s8uCro+MW6HAFxbomP/aSOCHWHr3MS45+wvxkEvNjUPLRiMWMeVKYXi0wHyQ110ET8pXURraDb5qXLD/Mn/ywOpGlAQReAgIFRBTs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732342166; c=relaxed/simple;
	bh=MGyPtryu9vwlqXgH+YK8PKy2Yv9hW/j3LeOUBVe2VI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5RjDWAMd0HiAZaHHjE06apKAteV7gmGwgweJpasDnR9q/I9UMw2likNIJxhV3BAYXmYFi39rB0YOIA+iNmn+/JfyzEHjaku23lmb93eBd0wbAxu9sJSsAP+z8fDi1uP7QCRbV91CfPaJ3wKWWz0i+cd5jFROMHV2xoIbua9xoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IsMpb+GE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9e44654ae3so383175566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 22:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732342163; x=1732946963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IbrjbqNKCRo+IWqsypSqGBrpKrn9jqq/jrjfhjQ4XdM=;
        b=IsMpb+GE9S3EQuX4OjSBqeBU90BXVpMVwWDTZl0XII9fZCcpOcf/YZFXXE/8/8YUNQ
         xjpdzoY4ZV1Z+xrY20Pptm5nahgfk675MeVLddykasp9S+5P9PjyBXa5ATgQ3rcaTSlc
         NSYtPj8i1cxyBwPD8p+5HSpy2iA2q8lhofdOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732342163; x=1732946963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbrjbqNKCRo+IWqsypSqGBrpKrn9jqq/jrjfhjQ4XdM=;
        b=a67P9W6ugpN4cUVykd3YiRTrYEQQOkqrADCQwRJGeuhLUqmAGu0UbsfnwBvZxA6g9N
         0Jei34yJIzwHNFA0h6TiVz2UHqQGxo7f7crRPBz0wJNl2/X9/KS8p9Yc8ScN4Uk70Fy8
         UNTUiiaiVUM7azU3s/9rmkRK1C7mIqlb0iexQWRvTDRZyCxEMb+eJiTFadcQPpaiUHLp
         IjBfFNwC1q5pUPy2vyHp6OJmkDpTQ0orjtAJgTdRaYx1/bl6de0Mzwu13dRXZAOBJY6P
         RpXvHsvrDWcHr+SilbeTllHx+XL1lQnStoxwxY63Lb96VBG6HM3Vp4hvKws3X1ThZjKU
         waew==
X-Forwarded-Encrypted: i=1; AJvYcCXjoJ6Ex2dHrFiYqLRtBxI9RdaIM5iMutr8ombPvSjsXMCU+lABa0iM7VlEyzVQwmeCL88aHzEcoyAbDydX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8X8i5UYiK7TGyLspuSzSvFISM7Vvy+RO8TfUIhwpwYEF55CY7
	uzOdlGVu1OBiMCvDpu8dZEVVuld0GspqRMXcTINDUj5/8q9kg2tPvbwSzye4PIpMdUvJshpPMDe
	34WXc/w==
X-Gm-Gg: ASbGncspBq5QME0MnSVQ4yD/WuqfAhSrOByBvks4YdvJ58PNUYql/jqbItwvLJjx/Ri
	vlvcZ0+bJIMi7AKjrcbzDy1QAUS8IY/6dipnKSRiyXM/iBL45eoIIBaNJ1Hvkl9/2yPzboDAGB4
	WaIpgy/0JpllupQxd4CLdsQE8UC608LO/UPJw90s/5OA0CL7Bba08JezhWxMBRbxDCli2Cj/INR
	ah1CxEcJd78EKDKvwvVSSuJ2BYUAq/rnPQ1Ek4JBHx167F4r0BvQgYSp7WkGK/MoKYNLuG6tTJc
	Uch2yb1g0pzj0E9BaMxtYNz7
X-Google-Smtp-Source: AGHT+IHA0pyEE70BIyGBKG0mEXGqGj+3AyvuhCETUlqZ3+gxBTMC2Uv5u9w+lbCDG69ThWzghbFxCw==
X-Received: by 2002:a17:906:31da:b0:aa5:30c0:384b with SMTP id a640c23a62f3a-aa530c03aecmr117076566b.24.1732342163182;
        Fri, 22 Nov 2024 22:09:23 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57b7bcsm182335666b.133.2024.11.22.22.09.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 22:09:22 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5366d3b47so19180966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 22:09:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU9VOLaYAPrZKMfDHGNw3CG34cdSo+/mhBHSjlJwKddKzTO7jya72mXeBn8wlosz/0Vdlyg7+EAUYiEfZE@vger.kernel.org
X-Received: by 2002:a17:906:32d1:b0:a99:cedd:4612 with SMTP id
 a640c23a62f3a-aa50997e1fdmr440623366b.22.1732342160869; Fri, 22 Nov 2024
 22:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122095746.198762-1-amir73il@gmail.com> <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
In-Reply-To: <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 22:09:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com>
Message-ID: <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs updates for 6.13
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Nov 2024 at 21:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So may I ask that you look at perhaps just converting the (not very
> many) users of the non-light cred override to the "light" version?

I think you could do a completely automated conversion:

 (a) add a new "dup_cred()" helper

    /* Get the cred without clearing the 'non_rcu' flag */
    const struct cred *dup_cred(const struct cred *cred)
    { get_new_cred((struct cred *)cred); return cred; }

 (b) mindlessly convert:

    override_creds(cred) -> override_creds_light(dup_cred(cred))

    revert_creds(cred) -> put_cred(revert_creds_light(old));

 (c) rename away the "_light" again:

    override_creds_light -> override_creds
    revert_creds_light -> revert_creds

and then finally the only non-automated part would be

 (d) simplify any obvious and trivial dup_cred -> put_cred chains.

which might take some effort, but there should be at least a couple of
really obvious cases of "that's not necessary".

Because honestly, I think I'd rather see a few cases of

        old_creds = override_creds(dup_cred(cred));
        ...
        put_cred(revert_creds(old));

that look a bit more complicated, and couldn't be trivially simplified away.

That seems better than the current case of having two very different
forms of override_creds() / put_cred() where people have to know
deeply when to use one or the other.

No?

                Linus

