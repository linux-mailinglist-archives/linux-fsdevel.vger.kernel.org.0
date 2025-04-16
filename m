Return-Path: <linux-fsdevel+bounces-46601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1277A90EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A601903BE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188123ED63;
	Wed, 16 Apr 2025 22:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="atVMYsgB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7523A98C
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843197; cv=none; b=Wf3AICfp1YD4d9z1scGtGcTDSi3suNcHX8djY+IBvp/BswE7wR8q8VxW3C68do+G26RZK3lUDtkRg90IP0SS5BfTlVWSDJ4z+B/nc+pJtR2zxBAfx+VsAn+ax07v6Jvu5fA1GSI1kPepeZDqDhwLUJqOrLs0e1OXrN+uNrakLnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843197; c=relaxed/simple;
	bh=kd8CIoyZU9z+s6yhVJAsL20bAYQiydUjPDvjdWdTYQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRhcyc3y8cI2q8F4DWgru+dK9+01HtgDxy9J2SRvZVSH1eMklP2nMFc0sCK7ejA6dD4yEar0NyaVx09b8k4Fotn+k8kqj2eU06Q5kGybgPpbkeO8LWdStPWlVkJPrfXDlYgg/YkqAfhJa8mPKD7bsSHUkKdsvK/x+2VrfP3ifIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=atVMYsgB; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso274954a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 15:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744843193; x=1745447993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jm44dwmZcQ04sKyHxrckFG06FkU/O4r8HH0/pnpLZx0=;
        b=atVMYsgBJedqVBa3muizlrVb1k5F4IJGcIdbNH70eOi9Vzfeo0V4xWsPv3QRAMyOmQ
         +F/zCInH10/kPMtE4onWNa2TmUCqFuZ6Hl+SplUS1R7yo4xqNQkXXouf0U7LQ7cAvTdi
         iZmzM85Oi4eZdMAsVZJ+mZermcM579t4Vrc2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843193; x=1745447993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jm44dwmZcQ04sKyHxrckFG06FkU/O4r8HH0/pnpLZx0=;
        b=UiFgrt+7W4UCpjaU7UuWrWxx5uVs+jjXIyb3XlLe1hZOTB+nTBAUhBGPrygYBhdmLd
         D77g6qTZNx3supPv27GF+LAxQwtiPa2ekqOt1D5+rI5L1jDPeJgYIq0HKVcbloXJCipF
         Xd3IudZrUrI41BI1ZLjLA4ShsNmGRWbv0DeBMR1MB2/Olf4ZrEPk1+FQcsUo2qaZYzHc
         JLTrHwqyWXwIWBWX/RYDwkaFEEgsSe1IONVDHIRwfMl1qwPa3macPUkpjzaqJY1C8DBa
         lL4oPFCkTn6BykEJ50YnNTJVxiGC//wJEeZD+9QK6IYTxapTX1sEgf1rck7MtUxz26f7
         V3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXy4gILd9MefsKfYS5ePI02eMu53dQiQYivfSGjNY83rTR3Z0SCW5ghcwL19jwkB4gPj0xJ0wwQIVYym0+n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiy6fiS8YC49LEQ8SBDABEUeDgxU6md7dgMrqtqPmgrTkTMxt0
	FKUmKPrlWzNTUMfBe/a5slkCOYAJohngXQxXb6cqWElGgIIUdWS/t5eo7ItAfLDWSZvmAJs634Q
	1y0LMjg==
X-Gm-Gg: ASbGncv4SEuC+mPMHkHcTGHWFtzSMMndrdPMqyAPIGgnBQVJIw9booZWIsMxW6//wHq
	xVg/8Fp1IAAxV1y+ptcbTilzBcH3FK+9HD73s/sl/AxAQZvgQEAJC74MVms292nsGa+8XG0Nicw
	0wEy6WjBDdKKxrmwXg5N5pqFWsinmW+MArzp60OgTG/XcSiFQ73rZ0v/p4dZHZTxri8xLdo1ONk
	Y+th8O01RnpbM5jQ+J5foC+frE78TVF73/1IrayCQcGoscutZjXwApt5dSubjLr3Hf6R9xM63px
	j7cXDvWYEfmHJp0rmPs4Rp7XUtwGtbJ8xxbb75TvveLA+knfeRNg4KSz5AF4J+OZ/62PF2D6Ek3
	xWaZrkrwhxSLMD4fhC/rRVO1XKw==
X-Google-Smtp-Source: AGHT+IHtjp5s+ZIA0bb8H3sgddKczUY1LGr8B2LEo+h9bFa1e2eT268QXcV1knZ0f5w54t29vpQkgg==
X-Received: by 2002:a05:6402:520d:b0:5f4:35c4:a935 with SMTP id 4fb4d7f45d1cf-5f4b75deb6amr2892213a12.21.1744843193695;
        Wed, 16 Apr 2025 15:39:53 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54d8fsm9206021a12.12.2025.04.16.15.39.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:39:52 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5f3f04b5dbcso261282a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 15:39:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxuMWNUsgs08qUKm1/lmC3YXu/hmkA3G4eQynxnBjuRLKkvlaKIl6jwbedly3A4E6py/4OE0p+VxJFygKI@vger.kernel.org
X-Received: by 2002:a17:907:7f0d:b0:aca:d52d:b59b with SMTP id
 a640c23a62f3a-acb42af00f9mr291976266b.47.1744843192133; Wed, 16 Apr 2025
 15:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416221626.2710239-1-mjguzik@gmail.com>
In-Reply-To: <20250416221626.2710239-1-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Apr 2025 15:39:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUYJ1XbnMnKzv1coxX=WhH1g-ufMGxz7anf-Tw6M3+Bw@mail.gmail.com>
X-Gm-Features: ATxdqUFLEOCfS07bzwWoyJm7dcPWUV3_QMm7wan5599m25oiRJfIRXjqUJ1YLl0
Message-ID: <CAHk-=wgUYJ1XbnMnKzv1coxX=WhH1g-ufMGxz7anf-Tw6M3+Bw@mail.gmail.com>
Subject: Re: [PATCH 0/2] two nits for path lookup
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 15:16, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> since path looku is being looked at, two extra nits from me:

Ack, both look sane to me.

             Linus

