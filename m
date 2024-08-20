Return-Path: <linux-fsdevel+bounces-26407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F702959012
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 23:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B61F247E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C461C68AA;
	Tue, 20 Aug 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1JCi1B/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C5189BB6
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191108; cv=none; b=LKQnrqgcQ+Jzpe6FubTGx0JaJoue0O5nXWe19TFk4TjbAyDCmpfa68aZK/cDWDrqjyc7/9LPMM4I3kn5k9QsFbBWNC+glQH6l0MhAm/X9G2ZUHWYJkceELqHlpb193tmEQF2QkJB8EHdMTwjuIkJleselvdW3LW+lKjvKMwuy2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191108; c=relaxed/simple;
	bh=6aJg8eWkIu6E+nuBgwiwCdUGFgcdw16iAxyUgSWdpYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTVtbV3r/8ysWpGN/hlaJRkRsy/sYWqilP56NthYTPgXrZWDvW0VOURY37h9BDMQQ8w8Xtyg8pdjIK6JH5iMCZmctnSinzGGPKbUqFabIDTYcQmvzSMOm4fwNnKcPx3OpovXPcIEpjqo/qyTKvwO6DZOS/pe+JyVVgSaKyt9Brc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1JCi1B/; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f15790b472so72449651fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724191104; x=1724795904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U+YfgjBbjapgsBjbRcnfMrP6oWrjX+7ArLGJFDDZNek=;
        b=N1JCi1B/YP+rI+s5jiGOJbi3HEYN+wu/u+D1rRH3BNoSCkXxyyco0XF6AoRGgYsmhM
         LbvwAbP2s2d1QxobPXuVvdk+b/sKz0Ax7CHJk6duxKWNpoV04/ulCEoRpSKUKpf+17fd
         /HBemzi1+xGdU5DfDtuVg0T8r0k2jQ6IQBDsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724191104; x=1724795904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+YfgjBbjapgsBjbRcnfMrP6oWrjX+7ArLGJFDDZNek=;
        b=SQcBBvFSvCZRHNZTBlgisYFp5FhRd1T9xuL2+AfWADhCvFm7fcMykrc9AstaRJ+dhq
         eenZ8+jBxEywxaqA2XUstxb5Wg2i3+mBR5SjdpYATOxbqzl9lg3vxEarAgVkdG7zT/ES
         kkzEHR97xqg9asrk/56IXEWRv/uufCUQIWIIKaI9ckakcNtlN0N+vNeWiDwU2YfK4jIk
         uM7xwP4952ViP/2TQzNY3YuK4GuVgoyDg2AZM5i8pxdblVF8jQZCrp44Hh6RBXxWyEXP
         AimkqMExh40G3c2gQT3vM0XAik+FTKJCWMbv/L31lZhREQqrPdjsMSZ9yl6jcyQOVkAb
         Npug==
X-Forwarded-Encrypted: i=1; AJvYcCUc93w86BniF9vtbDilxttUF6BA37BIVAbOZ9IzFPb4sILOImF5FMzflEwsTTwlQxLD2m4Ckh1b5JTielid@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgL7TnKEfG6cV5PIJ/UVlAV16tcGSO954jO5g5oZuVX3jEEb9
	2OYEfB7R2zoAD6QLi9ouNm6kt2rtg6NRbEnRmHO6YAOPT1cRZmIN7ZEBEM4Y9Sp6DHEZN2VGcyS
	TZRb3ZQ==
X-Google-Smtp-Source: AGHT+IFji8FE34wpYPD81TyjQd8rnVQVRSkuOnJEBPJ+jILm8bWb1KerLnHLmQLHf5QuKq1e1Ub9Dg==
X-Received: by 2002:a2e:741:0:b0:2f3:f193:d2d0 with SMTP id 38308e7fff4ca-2f3f893f3afmr1787481fa.33.1724191103153;
        Tue, 20 Aug 2024 14:58:23 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b746cd5csm18109811fa.28.2024.08.20.14.58.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:58:22 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-530e22878cfso6168355e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 14:58:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCf7a2vm2QGV2oH77BIB5YxcAotf/SH47+iIEtLsp0BWP4yvLT7BltNoOQhop3UZ+Sj1u3vHRlxzm2xzaf@vger.kernel.org
X-Received: by 2002:a05:6512:114d:b0:52c:818c:13b8 with SMTP id
 2adb3069b0e04-5334857f579mr82520e87.4.1724191101986; Tue, 20 Aug 2024
 14:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819053605.11706-1-neilb@suse.de> <CAHk-=widip3Dj5UWs8MVGgxt=DJjMy1OEzZq9U8TMJAT3y48Uw@mail.gmail.com>
 <172419045605.6062.3170152948140066950@noble.neil.brown.name>
In-Reply-To: <172419045605.6062.3170152948140066950@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:58:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
Message-ID: <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 14:47, NeilBrown <neilb@suse.de> wrote:
>
> I can definitely get behind the idea has having a few more helpers and
> using them more widely.  But unless we get rid of wake_up_bit(), people
> will still use and some will use it wrongly.

I do not believe this is a valid argument.

"We have interfaces that somebody can use wrongly" is a fact of life,
not an argument.

The whole "wake_up_bit()" is a very special thing, and dammit, if
people don't know the rules, then they shouldn't be using it.

Anybody using that interface *ALREADY* has to have some model of
atomicity for the actual bit they are changing. And yes, they can get
that wrong too.

The only way to actually make it a simple interface is to do the bit
operation and the wakeup together. Which is why I think that
interfaces like clear_bit_and_wake() or set_bit_and_wake() are fine,
because at that point you actually have a valid rule for the whole
operation.

But wake_up_bit() on its own ALREADY depends on the user doing the
right thing for the bit itself. Putting a memory barrier in it will
only *HIDE* incompetence, it won't be fixing it.

So no. Don't add interfaces that hide the problem.

                  Linus

