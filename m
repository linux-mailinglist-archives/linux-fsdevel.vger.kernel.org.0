Return-Path: <linux-fsdevel+bounces-10648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECCE84D041
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 18:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395861C25FFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D6823B9;
	Wed,  7 Feb 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bsW3vDVA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F5782C76
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328669; cv=none; b=EusNJ87muWuQqoVF8VXWoRtSVr2OUE70Nf1nwxUreT8zgGUeKmeBRfHBgY9FNTt7Z6XqgiiiBPmgGAc14pFtJ8k3+dzRujtgGuF0ePsxAV/uDTRMcKwok3YhYdiQsJbQAtSgIVprYa6maL/jOx6QyBvgqN2zmxtIkmH/uqrqwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328669; c=relaxed/simple;
	bh=cRRJoxkRzUXRvLL7R3KphPee6imOsA+kZBjZd4YXNoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQ8pugDr//nr2tJzXt2M08GIhMsasZVgPelIQtjwYz9mhRgAtQoY8EJCvKQBU7fFXrXozucc3bcJnyfNNl7cM24jc9ryh2cEkgHun0fv1NugoBWdjAvpF96DFnkYrKK+YKRzctcEQr6GMs4wUNECCIPApA7jbv6m4z+cr6p24XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bsW3vDVA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d073b54359so12487131fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707328665; x=1707933465; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+D67kFPKINWDXTANYzDAtf4PxKO+gh9QVFhv0sOkzl8=;
        b=bsW3vDVA41+y6vjUvfuSN1oXzGtIa+7uxeVN+1ysQNhGJaBcN+bWOG4ZOAtAKxOXHC
         iPnVpvNfhuSFPo2f2ZfROj9lIHxSKAhIFJu3p5T+/bet3SBOz9rRP+Eo2RvoKFTi0PQI
         uThxFuXwS1jvbTINCtrk48zhWlx8wTJCkrssU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328665; x=1707933465;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D67kFPKINWDXTANYzDAtf4PxKO+gh9QVFhv0sOkzl8=;
        b=SDPP5OFoEgXlkSmuFgNKPwXQGZrDHwWt17vhWyswcf7vTE70BeI6uDWZ01GPmle1lT
         fUGZdg3ZSic39eQV6FbbmRksgTCCAjm+0lA8evFrsZoB0wpI3OBC5vw2Xb2orOaPl534
         pE1rFkax9VOdGJTg7E+cLpcegtyVZSn9rs4ZyliLx1fdzGFtitNYnh2nQPUD+yut0g++
         gNJHQi3AsV42hr45hVbnS4XIhsYB6VJ6nNrwAl4eZcJZjIi/8rjtfswdqXmf938wMvT4
         IPMCXeD64gMOX7meYrqDHSjBGa/Q0fesmBwn4Zq1lTH1IJoOQRBXh+ju+F9Shw4N4qYT
         PpFQ==
X-Gm-Message-State: AOJu0YyOQ4JZJsJw5MYEF2aGh+3OjIl1sszURi/mXXezOBv8jdmskUBN
	6PmViRbmf4y5dwQYMAMTzsQw2POGktGHLKLaqKqcA7P9zX43q+StfQ9OLKhx5jKWkR2iq6D4rlh
	p
X-Google-Smtp-Source: AGHT+IE7QzqFRV0K83LBYwrOk3TftCSrY5aJITI3Si7U75vbqdS9PJEmeEGxGPm0lM2asWEDJJRwtw==
X-Received: by 2002:a2e:be0c:0:b0:2cd:eb9e:b372 with SMTP id z12-20020a2ebe0c000000b002cdeb9eb372mr5446629ljq.27.1707328664803;
        Wed, 07 Feb 2024 09:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtVYxmOoDDmubLAAckHYM1xt5tkoE5pH1BFvpEkAwqORJ8WxQpyJvaiku7sudcSPEyM7rmHgtp17FThmOezOBNQwP/novAZMzVlKxgkA==
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r21-20020a2e8e35000000b002d0c8960490sm255226ljk.41.2024.02.07.09.57.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 09:57:43 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-511490772f6so1071002e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Feb 2024 09:57:43 -0800 (PST)
X-Received: by 2002:a2e:a792:0:b0:2d0:be0f:96ff with SMTP id
 c18-20020a2ea792000000b002d0be0f96ffmr4990992ljf.17.1707328662807; Wed, 07
 Feb 2024 09:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2024 17:57:26 +0000
X-Gmail-Original-Message-ID: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Message-ID: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
>
> Okay, let's get confirmation from Tetsuo on the current state of
> TOMOYO in Linus' tree.  If it is currently broken [..]

As far as I understand, the current state is working, just the horrid
random flag.

So I think the series is a cleanup and worth doing, but also not
hugely urgent. But it would probably be good to just get this whole
thing over and done with, rather than leave it lingering for another
release for no reason.

                Linus

