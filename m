Return-Path: <linux-fsdevel+bounces-52631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FD9AE4AC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 18:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C551736DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D699C2D3225;
	Mon, 23 Jun 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QQfP3AHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B102D3238
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695535; cv=none; b=m45Ubkbv2nPECWfoj4kAHrRrJnysOO3hRjpclp+k+ApmxgQ0dtFFzr1eNF0+oeb6Q/gyiJ7ZR4CTXkvLwEjAYM2kke0xW5HFY3f+11yn6WPwwNS2nqX/VtTGGOV4u6+yEz9M2CvnWDsC1dKs0Huun0Hwpq8rYUAyERfXDC3wdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695535; c=relaxed/simple;
	bh=8qVhVW02q6xjCUIZexC+t5fzjmktvAMnIV3Pi6u8Obs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gr5KUHONFPyrT2mPqrq5OlvgbnF1wZ+foZP4rn32fmQ4NNfUTCAKlpTbH29rjdsfsY4IDETIvCFseK7iSE6+A0lfFSm/1aG0dTfw6SHOtpy+vkDo8+QUZYxFCkE9ccBo35cKV3GpjcZbgsZpV13ftUfxrNyFg8q/UF8CuVeB6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QQfP3AHg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60794c43101so6615931a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750695531; x=1751300331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bEW6WItAX8yA2H9c4X3JZapWbED9sWBwlA+0qK3Qu8k=;
        b=QQfP3AHg3ddINfmOeeBBCcaoy6liUpd4XJBdzHPRyfyH1wVM5qrpa1245Dt/35lOcz
         32aWUNEm5q6xj13hl4mJgcoZshXkdAKkhPwOujNIiyPYrE2K+mrfrFNdx+j5CZ8qARvS
         zzMsXtic1GEewd+UgyuIDorOBvMtN3qfumgo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695531; x=1751300331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEW6WItAX8yA2H9c4X3JZapWbED9sWBwlA+0qK3Qu8k=;
        b=r5gaInzfxe2d0W8qTlgJX09oYPVdh6+5/vykiRLMDwJouz6cWGATe8gpp+6BpcmHXW
         E4+bFr9v1++3LPzha4diD/crio6qHon2J0Ijg108EaaCfu8qmquLQC9ZiS4DnHaxz4w8
         qdQ5UUoJK9e+Vjd5EhhdeRSAGt97METi/lhSUt5/MmLYi7uA7X2ns7pxxfhXkCM7VaqY
         Mr+vddHMscOMraFtA+ERb/bsBHleYzVjqUfz/gYeldShcKFutm1YMDD2DHOy8ZXJgHWZ
         4sWldHaSSXRnezJvgWS7j2lQheQ2Ek+3YsR8LtCZhmnogylbta50UlBKiKs2Od3jfagz
         SR2A==
X-Gm-Message-State: AOJu0Yz/8QP2ZyN1wPQoJJ/M7XNmgWFfkqO5fq49xykjIi8kPjothCpz
	w6dql9JmxsIKJyBGDRCkx2oCz5KVcms90xWnDWZUvLxvOCZroXyfWl7PNCMF1WUt7jRH9vSmxut
	qYXnkABs=
X-Gm-Gg: ASbGncvtPlZJjzpWSWjP/DZyaExRul+4SvM6CToT44upNcYKIjro4Kf8OOHPZ7xRP4e
	Ke3afMzjBXpJlft4GDnDjcJPTIykhIWsnZfhUwdOulIy3wA6W0nN4LSn+yGBe6Q0x4/IbuPo/Dd
	fQ+4XJzuwqdGuarDwixCquMigDMK7+4rilo3R/owhZDvWtErv2CIsB7UYy85SBsNtgLuRY3EGBW
	AtRy3l9JfgobtC0+82LdR4QCSaSZtn4ylPwHnGi1shniFYg2Ye2d+hS8uEbKKJ+1MM2s1xY85hV
	vKykW96z4G9OjPmrflURjE/jm/IADu0HrrHaJCCHzw19+FiYCubDqsFJIYvb2jdajAhfPwWt9+V
	v17mw4ISfQiYumdyr7ysWyyJ2YLtD2KbfyWzeWf+Dp4AnIcU=
X-Google-Smtp-Source: AGHT+IG+zyu6rHfJ8vfPYHf0EeHftmqX/MCLTVrkdEC18EMaXcIblJ5aU7dUD3JA9B6NnrBq6690Sw==
X-Received: by 2002:a05:6402:51c9:b0:60b:f7c1:654e with SMTP id 4fb4d7f45d1cf-60bf7c1680bmr1108055a12.25.1750695530945;
        Mon, 23 Jun 2025 09:18:50 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1854634csm6227805a12.29.2025.06.23.09.18.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 09:18:50 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6097de2852aso5671800a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 09:18:50 -0700 (PDT)
X-Received: by 2002:a05:6402:5112:b0:608:2e97:4399 with SMTP id
 4fb4d7f45d1cf-60a1cd1a8bbmr11118221a12.4.1750695529845; Mon, 23 Jun 2025
 09:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623044912.GA1248894@ZenIV> <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
In-Reply-To: <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Jun 2025 09:18:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
X-Gm-Features: Ac12FXyE46RrL0c8d27-yIrvlrSZ3_nn1zXf8bvq9mA1IPaO7X42OiFfnTmuxMw
Message-ID: <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
Subject: Re: [PATCH v2 17/35] sanitize handling of long-term internal mounts
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

So from a quick scan through the patches, they all looked really nice
(but note the "quick scan" - I didn't apply this, much less test
anything).

I did react to this one, though - not very complicated, but this patch
struck me as kind of ugly compared to most of the others.

On Sun, 22 Jun 2025 at 21:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> -       gemfs = vfs_kern_mount(type, SB_KERNMOUNT, type->name, huge_opt);
> -       if (IS_ERR(gemfs))
> +       fc = fs_context_for_mount(type, SB_KERNMOUNT);
> +       if (IS_ERR(fc))
> +               goto err;
> +       ret = add_param(fc, "source", "tmpfs");
> +       if (!ret)
> +               ret = add_param(fc, "huge", "within_size");
> +       if (!ret)
> +               gemfs = fc_mount_longterm(fc);
> +       put_fs_context(fc);
> +       if (ret)
>                 goto err;

So this "fs_context_for_mount() + N * add_param()" pattern ends up
showing up twice, with that 'add_param()' helper done twice too.

And that's ignoring the _existing_ users of "fs_context_for_mount() +
N * vfs_parse_fs_string()", which are really the same except they
don't wrap it with that 'add_param()' helper.

I'm not objecting to the patch, and I don't really even have a
solution: many of the existing cases actually do need the more
complicated vfs_parse_fs_string() interface because they don't want
that simple 'strlen()' for size.

I just feel that at a minimum you shouldn't implement add_param()
twice, because some other users *would* want to do that.

So I wish you had made that a real helper - which would obviously then
also force a naming change ("fs_context_add_param()".

Or maybe even go further and some helper to doi that
"fs_context_for_mount()" _with_ a list of param's to be added?

I do think that could be done later (separately), but wanted to just
mention this because I reacted to this patch.

              Linus

