Return-Path: <linux-fsdevel+bounces-40152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E8A1DC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 20:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2F33A378D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8705192B96;
	Mon, 27 Jan 2025 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NhSmhV0M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237415FD13
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005154; cv=none; b=OcY8lX7DsGLyQa7CXsuNEwBpDd99AWlzp9VhXrCtxS0s+6LuequPbdpQvWaEVg1D96tVkzf188SfeKva0eVmP51bqw02qilsuuhEhvThk1bzK6TZOrJhJ1+rPgsglMQBWiNe3VIOAkXPrXvgLkE4fv0pu4OROoqbij7nbNw+7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005154; c=relaxed/simple;
	bh=UcNITMy5DVWrZbbR/azPBFt9W9DY/yhAk/aJXSOMVAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhAylRlNesxU6xbCX+9QQ7fBXDNxGqCAt1k4a9993pp9iAbUOE24O1q4TqkN8lqg9zQQ9dB7LLLKMY6Zh2vXRRGlqdMRtKCnxtQ5FQAuert8lsjNs9h4oYsVwP7VnPlIhD2tMiAzWlqEf7m1CB1sXfrQxjMGf100wCojUI437qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NhSmhV0M; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaeec07b705so941381466b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 11:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738005150; x=1738609950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oRWc0yc4UzREqFCikMBtMstVl9pz1QdSpT6OJeveUwc=;
        b=NhSmhV0M+3zZKsTQ2vXgXgI6lcLjZKrAEyZGSLKBXkL07rM272+kGV2dvbEFN/n1JP
         YNxw/7LY1vWDYhAXoy7bRwd+uZQyZA6/iW7tkZKd22Br4ws7RPeD0xoeL+rIj9H7WNPo
         IFob4C6uGJZaooIdodOkDAgAeDHUt0Dkwx8KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738005150; x=1738609950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRWc0yc4UzREqFCikMBtMstVl9pz1QdSpT6OJeveUwc=;
        b=fbL32nm50nAz0gVclVQvVEv1gnB74+aPamK+fM9gR9YuVYxSmz3ZveE49IR3I28exC
         QztbOySLHAarYrcpd7X9eZhPqO1ThN2Pq1eUcwK9A5xdFg6aqRjMnhJEO549eH+JbrQp
         45AdVTfM4haV0whNdV1RkBnbAPHHnAFXNxd5oSrcZtwLKChiTIpRPyvgbJYBWWDtVCv1
         8O9D8TYDRNNJ1Qg1qyTJ3Vx/LATQ2JRL9fSbXU2PrR89dGt5us0vtJEC9hmUpkfC5VRt
         Ih1gi4S2jQWRNQY15PsEcil9/3w1nwOn0nm296zDN6OCcFeby3V/OtfMxLWuhzNru8cf
         ZaZA==
X-Forwarded-Encrypted: i=1; AJvYcCX67fe6aULrtpPOyTJllSAPijkRpGlK4Pu4VPeqSmWmz3yZSBkUAKSZL2JqjCE97LA4EdPNM1KqjJ7LvaXk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQahk1guyhsYwgVyeJ1duOG56enn/64BrkaIZbycHCgAayNXQS
	ZaUiy36blY3p4aPVD+IUl8TJ/1FOCwc6PatDDy+Pq4XUDx9rdLxtRXpZS5Tcb9h4R7f8WYu88ux
	Nae0=
X-Gm-Gg: ASbGncukyJ6NtD+++6j7i3lOtmpj2JSeEe65/fP/F+6qHj7wU+/WvmvlgKpJmWPrpFE
	N4DrLzmbUSATTY+gMntWCAkgWfAd1ttubRvUXGBGq3UUQhFbh5ZCp35raAIyl/M7NWTSJdtSFyH
	KW4hE+6N1/tWIrady/wr9bm/GoVOO5BibSj/yS6dzx+mJ1CKLFM6k7Qtn4vcbRt2x2VE5svrnZy
	skjYp9+5vmlWR4KYPOHG2RmeyXW5EDjFHE3XRAKUcja86QyMaFoMMyxqqJRye5dzZSMcB+08Gy1
	jGFNRn32CDtC8jVNGncIsPqRN5mTzUkE55gE36XGxkcYt9x5lshft8Y=
X-Google-Smtp-Source: AGHT+IH6o6bo3Oq62Jyh7agUpgIV4NUc8p+D+Tyllbl2t3Po5uqiLvNloPGS/lbTjwo0ksgwjj4qgA==
X-Received: by 2002:a17:907:1c11:b0:ab3:7720:d87c with SMTP id a640c23a62f3a-ab38b384218mr4236688766b.35.1738005150172;
        Mon, 27 Jan 2025 11:12:30 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18628919sm5888469a12.25.2025.01.27.11.12.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 11:12:29 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so941374466b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 11:12:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAsBlArasR81UgpO45lBI3Q59nOpZ6O7ioMRCLrKN+SR4sLADEZvcs7TeFC8CNRXNWRTOuGyMI5ji1L8Z7@vger.kernel.org
X-Received: by 2002:a17:907:783:b0:ab3:64dd:bc89 with SMTP id
 a640c23a62f3a-ab38b1100d9mr3171825266b.20.1738005147960; Mon, 27 Jan 2025
 11:12:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127044721.GD1977892@ZenIV> <Z5fAOpnFoXMgpCWb@lappy>
In-Reply-To: <Z5fAOpnFoXMgpCWb@lappy>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Jan 2025 11:12:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
X-Gm-Features: AWEUYZnfYCSPESiHiidOrlrhf_2gR4sjvZbtI4_GCzVar-LNOMBy-6juZGoYcwQ
Message-ID: <CAHk-=wh=PVSpnca89fb+G6ZDBefbzbwFs+CG23+WGFpMyOHkiw@mail.gmail.com>
Subject: Re: [git pull] d_revalidate pile
To: Sasha Levin <sashal@kernel.org>, kernelci@lists.linux.dev
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 09:19, Sasha Levin <sashal@kernel.org> wrote:
>
> With this pulled on top of Linus's tree, LKFT is managing to trigger
> kfence warnings:
>
> <3>[   62.180289] BUG: KFENCE: out-of-bounds read in d_same_name+0x4c/0xd0
> <3>[   62.180289]
> <3>[   62.182647] Out-of-bounds read at 0x00000000eedd4b55 (64B right of kfence-#174):
> <4>[   62.184178]  d_same_name+0x4c/0xd0

Bah. I've said this before, but I really wish LKFT would use debug
builds and run the warnings through scripts/decode_stacktrace.sh.

Getting filenames and line numbers (and inlining information!) for
stack traces can be really really useful.

I think you are using KernelCI builds (at least that was the case last
time), and apparently they are non-debug builds. And that's possibly
due to just resource issues (the debug info does take a lot more disk
space and makes link times much longer too). So it might not be easily
fixable.

But let's see if it might be an option to get this capability. So I'm
adding the kernelci list to see if somebody goes "Oh, that was just an
oversight" and might easily be made to happen. Fingers crossed.

              Linus

