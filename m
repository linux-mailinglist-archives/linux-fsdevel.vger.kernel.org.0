Return-Path: <linux-fsdevel+bounces-8795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F71883B127
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE32283AC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920212AAFC;
	Wed, 24 Jan 2024 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K4mXIT0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1AC12A174
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120998; cv=none; b=VbqoqqGFnXL2PAb5uDvurRCiGYxtNPunAl2XVQwoH8KhoE49bG+GgbGUPuXrl1MlNCXgbqccSgMar4JM42XEb5yMNkFoI620CP6fQKDRgs6Xgn4T8XhUk3KyLbDSszRsJSyZ9QK1SyDLU2NNYXgdQofAoAbPM/HPMRnakKcz7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120998; c=relaxed/simple;
	bh=SW6iKvLIfjtPb7161k0Be90L2EGbRQCt76qGG32t4Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCGxmcg8cm3LIcIFYGZPWoPGOTi7AJdVwR5vT9fylLUpdod7hUcDL/kWHwtNKaMGKV5LlAdozL6Tp/herDYtj6C+3B2XO+80ETiWwQLk9DdxCVXBinhaWzGGR9OkWPgCXrwOg5SYVFJPhRwhcoY6/nuBi6CXWqZ5QOiJv+/WDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=K4mXIT0y; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so62723851fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706120994; x=1706725794; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0V0EohxWvuuUENl0m42DMDVa8sdRi34P5EyN97xnskE=;
        b=K4mXIT0yfeheSgC2LsLz2nHgNl6thRtk8zzRl3uwJozdi/FHPEAnDmrgy5q5NqAaMd
         mMED7fGAoTUmUbxgRZstGmrd8nk0duTbUE/qDyZK9uVGZHeCiiNr9t35GunDEfpIvrG3
         D1pJqA0VSY/ee7n5PDo+So61y+Hb7M05u/syo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120994; x=1706725794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0V0EohxWvuuUENl0m42DMDVa8sdRi34P5EyN97xnskE=;
        b=I1Qs9j+WJZesawJ6fNkKaDKnCDhlXDEVh8AsUbTmGyq0nRpC5AmgcqyPTZkkZ77FZR
         Pc/RgyTzkyMwqGhd836uGkYWtSgsAPpToiv1T+i0sssZZNuyPfav9iFdlcNuiOeKkMGm
         4JPwOFkMYOgoX2jTxUtLvmzdyeyNO2KbHkT6ccQQxUA0ra7FovZcD9SvmXcufcdJJZuz
         4G0gSewqhknlo7FN7PREwtD3mXZoY8smQ/+WzY0PBvCAOzSRhTrl8+gAOBThz0pAogoS
         oxt+VbKP4Eg+yaXJhI93CH4cuziuNrGtAc9wW5G9cjEwEKAdd1oqaanbJQRXtGe7m+eK
         cFsQ==
X-Gm-Message-State: AOJu0Yzrk0ujcPoppIl8XvevkCGhA6grUr/J8EEseHDFXaPvXGv1QMYx
	/PMvwvgLH9I16s2Nm/F917Mql9rZBcgC+lqzSg7FCz32FEvCA6lLiiCo90+4eUOkrOHAM+cHTaW
	1gYxZhg==
X-Google-Smtp-Source: AGHT+IFnwusR2Gk0lvEFap6CekNw+dytCrx8h3Amj6mjrecBWF9Qj30uwbp+gyNRYMCgW00c6NtvmQ==
X-Received: by 2002:a05:651c:81d:b0:2cc:7df7:3649 with SMTP id r29-20020a05651c081d00b002cc7df73649mr769583ljb.46.1706120994209;
        Wed, 24 Jan 2024 10:29:54 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f7-20020a2e3807000000b002cd97c7a029sm42279lja.16.2024.01.24.10.29.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:29:53 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf1c487235so16318761fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 10:29:53 -0800 (PST)
X-Received: by 2002:a2e:be05:0:b0:2cf:784:d3c4 with SMTP id
 z5-20020a2ebe05000000b002cf0784d3c4mr1264354ljq.35.1706120992964; Wed, 24 Jan
 2024 10:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
In-Reply-To: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 10:29:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgx71FcBsPF_sWoGAHyL6ohG8NRtCdPEqOt1jtSpiJN5A@mail.gmail.com>
Message-ID: <CAHk-=wgx71FcBsPF_sWoGAHyL6ohG8NRtCdPEqOt1jtSpiJN5A@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 10:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> UNTESTED

.. and just to check who is awake, I used 'file->f_flags &
__FMODE_EXEC' in tomoyo when 'file' doesn't exist as a variable.

It should be 'f->f_flags & __FMODE_EXEC'.

That way it at least compiles.

              Linus

