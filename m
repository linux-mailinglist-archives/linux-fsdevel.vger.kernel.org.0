Return-Path: <linux-fsdevel+bounces-27013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E3195DAC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 04:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0DC9B2151F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 02:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B1282F7;
	Sat, 24 Aug 2024 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DPjXSp0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71DB18641
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724468297; cv=none; b=WrGf3n6zAUd++5Vqf0nagoNsutP8QjjqodJhVX0MGv5a2mDfWhO5AXZopNs3Mm2yDObksGF1GmFrkf/2IoFtbAYae4ytMrkC/AilCQl5k7DJIMjZltxFN1UWkW9m0l8Z0p4LRXLm6Rdka88ARJtgnCjEUZpuwkaL0khSauUvJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724468297; c=relaxed/simple;
	bh=Hezca5d/Hiw2dSGl+lfWfGmJ5GwuSrZGZxIfhqwIlv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/6iHmYeeRiXgrlvW0D73xcDDf5nlja6E2Kt6EuWl3o7p/xKTqbCpzcoT9IQ2uX3Xl7iqnmYoaf0NnaXReHJYOqH1zzE4ndxSxem0mW12/ENjeEaQNYyMpUPSIfMJJPX8/vUDA1pltaNcvSP4d6KnPpagjLxFmppfiugM/8c9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DPjXSp0w; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3b8eb3df5so26233791fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724468294; x=1725073094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zedOl8uvkVp44rXL8uYLdQqyjd2Jc+tYGlkUMKlkF8=;
        b=DPjXSp0wP4hFZM5I+hXlBZskEl2snEkfjvp6u20iKzAx8jAUIXV2eKOetgBKZ73dnA
         xVu12wVJTghsgSnP07YDqRVo8k8qOWBKmbgz6faxuE6pAEU2KZIprE89JmIlsemb+wBN
         0rk7BfxMDVFJCEWDf2xZyAA/l5vLuBm6kcmzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724468294; x=1725073094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zedOl8uvkVp44rXL8uYLdQqyjd2Jc+tYGlkUMKlkF8=;
        b=kqfiE5ecYHYRPO9wLfrIy9jreRvmtqibLwTAfE/XGEbAUrS0H1sVIdj/7N8vE3vL8K
         SxsIeSUqpy6W+3MhMCZvwdA2OPByy6zh+GtbAhq+raq/z4xFUwKRuwk6lCwAoAIDpWXk
         i4QfGJ2j1pVlxn632mbFPalo8OCY5G6U/ek6WmgfX+LLjzVFsxFPtFduJowzzMsaEHI1
         PtE4CIJPZDe6T8XHKBTqxnqNioXkLoHg6w8XAapa5S/urY2QqTWM4GURyS6J9t0MYkk2
         dUGSmrNz6HBShy0cLIdHS8SKvTiMVo8kuaYqgLXiG3YOwxcdJbWDF0zAtGihGdo3BFoz
         3ItA==
X-Forwarded-Encrypted: i=1; AJvYcCVK+7MfXbh+ecCQlTea0n0PTBiXV3TINt8MUTOBhvS12Uf4xk0jOJPKffcfLoiCna2XIGDxD7s9piG+Wqob@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0FpVnOqwccn0VtO03zks4B5mCVVzOEobizZd+xwo9E09KVP0
	16p1Hu/tjKcUFQI4cKzLrKBQM4T4sfllz4YmP+JG9kwDCclVwsDFyig7OLgGgzOp+wB694dsa9P
	s/arBSw==
X-Google-Smtp-Source: AGHT+IG5f3s3V3ls1TSVbX7NgBlwyfrYBb5uje/g7J6/+03XyGzp3hIvBW7rfXVklXv8DSaVEnFKlA==
X-Received: by 2002:a05:651c:b0b:b0:2f2:9f39:3e58 with SMTP id 38308e7fff4ca-2f502b9cd12mr4736401fa.48.1724468293205;
        Fri, 23 Aug 2024 19:58:13 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4e66sm6280921fa.3.2024.08.23.19.58.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 19:58:12 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f3f0a31ab2so29763341fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 19:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlVgvX8zMElKrG0MQqCbNSzZE1hwFYFiWeUPDldl3MVx4wlguVLZSs8LkqaiPxykXRuRXjRsBCWs7DVUTq@vger.kernel.org
X-Received: by 2002:a05:651c:b21:b0:2ef:2bb4:2ea1 with SMTP id
 38308e7fff4ca-2f4f5728ed4mr31688981fa.4.1724468292020; Fri, 23 Aug 2024
 19:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <sctzes5z3s2zoadzldrpw3yfycauc4kpcsbpidjkrew5hkz7yf@eejp6nunfpin>
 <CAHk-=wj1Oo9-g-yuwWuHQZU8v=VAsBceWCRLhWxy7_-QnSa1Ng@mail.gmail.com>
 <kj5vcqbx5ztolv5y3g4csc6te4qmi7y7kmqfora2sxbobnrbrm@rcuffqncku74>
 <CAHk-=wjuLtz5F12hgCb1Yp1OVr4Bbo481m-k3YhheHWJQLpA0g@mail.gmail.com>
 <nxyp62x2ruommzyebdwincu26kmi7opqq53hbdv53hgqa7zsvp@dcveluxhuxsd>
 <CAHk-=wgpb0UPYYSe6or8_NHKQD+VooTxpfgSpHwKydhm3GkS0A@mail.gmail.com> <wdxl2l4h2k3ady73fb4wiyzhmfoszeelmr2vs5h36xz3nl665s@n4qzgzsdekrg>
In-Reply-To: <wdxl2l4h2k3ady73fb4wiyzhmfoszeelmr2vs5h36xz3nl665s@n4qzgzsdekrg>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 10:57:55 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
Message-ID: <CAHk-=wjwn-YAJpSNo57+BB10fZjsG6OYuoL0XToaYwyz4fi1MA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.11-rc5
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Aug 2024 at 10:48, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Sure, which is why I'm not sending you anything here that isn't a fix
> for a real issue.

Kent, bugs happen.

The number of bugs that happen in "bug fixes" is in fact quite high.
You should see the stable tree discussions when people get heated
about the regressions introduced by fixes.

This is, for example, why stable has the rule of fixes being small
(which does get violated, but it is at least a goal: "It cannot be
bigger than 100 lines, with context"), because small fixes are easier
to think about and hopefully they have fewer problems of their own.

It's also why my "development happens before the merge window" rule exists.

If you have to do development to fix an old problem, it's for the next
merge window. Exactly because new bugs happen. We want _stability_.

The fixes after the merge window are supposed to be fixes for
regressions, not "oh, I noticed a long-standing problem, and now I'm
fixing that".

But obviously the same kind of logic as for stable trees apply: if
it's a small obvious fix that would be stable material *anyway*, then
there is no reason to wait for the next release and then just put it
in the stable pile.

So I do end up taking small fixes, because at that point it is indeed
a "it wouldn't help to wait" situation.

But your pull requests haven't been "small fixes". And I admit, I've
let it slide. You never saw the last pull request, when I sighed, did
a "git fetch", and went through every commit just to see. And then did
the pull for real.

This time I did the same. And came to the conclusion that no, this was
not a series of small fixes any more.

             Linus

