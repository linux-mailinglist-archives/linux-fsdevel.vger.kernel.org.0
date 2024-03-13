Return-Path: <linux-fsdevel+bounces-14355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0487B263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D752B23ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC0C4776A;
	Wed, 13 Mar 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="akogPoff"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD733CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358856; cv=none; b=P9SD5hNbQiVZutmotzv57Z0Sb/DglAYDK65ti8Wl6bLKepmz257nHAIqOICz4s+cmtBo6EXCLSaM3aA7aBydv0XPTLGQUAYSbP5QRoddJ9mXIJ5f6LZ+LNZ7899kuuju4aBoNDI3jujwR0uWMALMpsMYVYzTsvsazvzo6pBozQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358856; c=relaxed/simple;
	bh=SyWLx/CLZ2dnkUztoF3Wet7Am+S0TMDdR5smm1pPw18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1N419ndy+1AGSW8hN3xsqEjRiVWsFvY3OXXFhXkEnVZFjA4nTq8AE1hsjGINE/kg1LoTkl6I5gV92xfyFrMueZ5OiTzfO+FtngvSpQcFNIi7Z1ANiVp0BYE1ZwSbHDuyrEnAVPWYeAsKepgde8a9kxA92px3IrIIY8mqewqGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=akogPoff; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d24a727f78so2307391fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 12:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710358853; x=1710963653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1Z+s/JMA2O1SWekv2eraMQ5ST+sYQkftPbTsPkksvk=;
        b=akogPoffVqL+sikb5uUE4RQYyrPymud1Rwc7XP2ZT6lWAMagSNtGMo6iSycJwovjPT
         IlzLUmIKSLyoHquno/LxnGHTFsoN85e/ySDwOYFMR3ZUSaE0dXnFcEEnqbGshDZJmcc+
         ZkvR5pRxjmGrazYsXsmdVvHwkF25Fd0dttSjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710358853; x=1710963653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1Z+s/JMA2O1SWekv2eraMQ5ST+sYQkftPbTsPkksvk=;
        b=gau0UfB9AHWLBd3lLIzyBQu1deSip0Pd8IgU9Q4zYCKopM8FpjyERMKfne2PsOxcEN
         J4jpOF6X35TWCmJ+ojeiZDut+WfU3NMtBvG0ccXMQhI6vr0oP4IIQYTpo1nbHA75tvVg
         MrYQ9VCkQNAAwPbz3qrzZtPFlE37pXRes4ZNiPQpyMe+cnhQ91ki5FCPajtK/q9j+K8z
         cuOuKJABGyGRoe3K/s90ODXzFkSvQExUaZvL8Bc0/QlpxEJjBwxj1e7ZK454S3PoCWZA
         mP7kQDjXck7A1ehOLCsSRkXmEUotYHfODbi8CzM36jOYeaVNIMPV8Duz5ksjYakYpDay
         Hpxw==
X-Gm-Message-State: AOJu0YywbTF3+BBgUbq5GwYkRCf43mNanfq56iBrqyljm3prjF2LEiEV
	kEVGLk73Y9Qy3vmbSks37+Kvnyk3YWQk1uOlG4WjtBafgEFhLT0//zOdOQN042jFqsQXQA6/+zR
	X230ATw==
X-Google-Smtp-Source: AGHT+IHMvZtXhwxJ+wxv2aeKogZRJqs79vVA3M7nOwBhE55XW3nCp93N1zmXLzIYnPYSue12t2Cq3A==
X-Received: by 2002:a2e:9e10:0:b0:2d2:f5fa:f37e with SMTP id e16-20020a2e9e10000000b002d2f5faf37emr5053549ljk.51.1710358852822;
        Wed, 13 Mar 2024 12:40:52 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id t33-20020a056402242100b00567c34d8a82sm5226896eda.85.2024.03.13.12.40.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 12:40:52 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso221886a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 12:40:52 -0700 (PDT)
X-Received: by 2002:a17:907:160c:b0:a46:4548:aba6 with SMTP id
 cw12-20020a170907160c00b00a464548aba6mr5254063ejd.56.1710358851872; Wed, 13
 Mar 2024 12:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner> <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner> <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
 <20240312-pflug-sandalen-0675311c1ec5@brauner> <CAHk-=wjLkkGS=50D6hjCdGJjkTbNj73++CrRXDrw=o_on4RPAg@mail.gmail.com>
 <20240313-matschen-mutieren-283c6e07694b@brauner>
In-Reply-To: <20240313-matschen-mutieren-283c6e07694b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 12:40:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpQicLYSZwUw8gp8iW+QZQM8i4UJa1=O4Ww_D0aVBQtw@mail.gmail.com>
Message-ID: <CAHk-=whpQicLYSZwUw8gp8iW+QZQM8i4UJa1=O4Ww_D0aVBQtw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 10:10, Christian Brauner <brauner@kernel.org> wrote:
>
> If you're fine with it I would ask you to please just apply it [..]

I'll take it directly, no problem.

Thanks,
             Linus

