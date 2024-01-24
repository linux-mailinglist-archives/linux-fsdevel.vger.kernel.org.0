Return-Path: <linux-fsdevel+bounces-8782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A083AEC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AA2851F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287C7E58A;
	Wed, 24 Jan 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQGuxd9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7CE7C08C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115322; cv=none; b=DEjiZUBM5LZwZ9Lr/Sy1Sq+IuiTRiyV/INpTYSgsdecgoMPGdRE0XlVxFnuP9KHFTz4Q+bLwjdVzk+c8Ms65SsBFx5W29EWgLdiFBilLM9wIjOrFEBHquNFGdZOPJ2tz19G7h0glk0HvXLYRyJbOyS8cRTcYyoVvNV1zlyogUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115322; c=relaxed/simple;
	bh=YImQJ7siYYOCy8HRvG07XXg2YFYJXgcsNfV6voSQuBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL3Ia4RskgFZV/npCtVFwm/0/Myt7m160mykwwudZNPIKPvaibCUCUmFsoJ7z56uhSqKVwe4lr9OhhH1S/fDgMxUy8CiVGdCLqqfMxcVy8pYy7B9jEGaQfMHe+Z6TKaDsR9J2ZldkMLIhIQyYItkxGQocwhbvyEe58/fw3Nx6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQGuxd9P; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so2201868e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706115318; x=1706720118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPdCGKuEWKXJWP2sfaXpzZkS4P7GnOGZQJx21so96qE=;
        b=bQGuxd9Pd5Eu251gHRY/VYhrZRVfccrxjdaR9APocEm/kH+j2088ARnUJEed/jyFca
         JuLOBigSgn05DcSlLsGj+BS5/VWjKL6xsG+GBZz6PE56D15v9RPUYwz/6q7jRhUS+1Mo
         CzaoXyOR4ynFgPo1x/FbQkkXmywjuzh8hAYkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115318; x=1706720118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPdCGKuEWKXJWP2sfaXpzZkS4P7GnOGZQJx21so96qE=;
        b=S4dvhEH7xB2i2Pgidw5gDBqIn3la4qFP6MGfwdXzmlIlBx0Ldb7E8ZoQa1iS+j3vQP
         z+U4bsF7NMRbpwEGvmdc29KWl7QVc0FVPy4TPW8oh653E+sc1huF9AMklxkNivFZdx6+
         eWbKAS6nfyiotKJC+wVnzTreUpf1trB+zQ+ZVj7SieoQs577NOWTf+n+pQNHrmarhi26
         1tvurP87RI0pJoRxG9gZAwdIdSDe3VVhs5cKr0yf8+2oklf4R2UhAoncqzJBnYCtF+xt
         2ecRPgPPcWHa5tQaIMF5jcWLGeSogKnuZezSS5jUBSPXVhw82Ious+16zWDxEITWJSh8
         yAsA==
X-Gm-Message-State: AOJu0YwO8yqTCAnWJe+sIKhmQlwYYs6zoYeTzgsrVMBgN2pO/dVu2fMc
	D4ZCCuzL1a2L1jxTXHqWmk2MaxuS8RI4hZcUjldShicTAZZlhHu5UW32z9RM56qbBRZw/iL4oFj
	va//xJA==
X-Google-Smtp-Source: AGHT+IHb9JnGqz41hMLAudzmjgMumoJXVq5mF+D/X0XEm6+W9G7c0GzU5fhvyxvMECYX/e/T2Ro+DQ==
X-Received: by 2002:a05:6512:1317:b0:50e:a6f8:aacf with SMTP id x23-20020a056512131700b0050ea6f8aacfmr4636584lfu.14.1706115318373;
        Wed, 24 Jan 2024 08:55:18 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id w27-20020ac2443b000000b005100d4e7d02sm310676lfl.27.2024.01.24.08.55.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:55:17 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100c3f7df1so2201833e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 08:55:17 -0800 (PST)
X-Received: by 2002:a05:651c:1043:b0:2cf:155e:2567 with SMTP id
 x3-20020a05651c104300b002cf155e2567mr1158083ljm.95.1706115317480; Wed, 24 Jan
 2024 08:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
In-Reply-To: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 08:54:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
Message-ID: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If the code ends up deciding "is this an exec" based on some state
> flag that hasn't been set, that would explain it.
>
> Something like "current->in_execve", perhaps?

Yeah, that looks like exactly what some of the security layer is testing.

Hmm. That whole thing is disgusting. I think it should have checked
FMODE_EXEC, and I have no idea why it doesn't.

                 Linus

