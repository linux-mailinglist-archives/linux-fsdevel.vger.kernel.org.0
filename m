Return-Path: <linux-fsdevel+bounces-19385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597DE8C4537
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70051F21BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889FB18C22;
	Mon, 13 May 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PoLQTO86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB117BD3
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618718; cv=none; b=blyoTiy+rebjfNM0dchbnPeE5MTvg4AM1GzBwYKpgs/xyk0EzKmBkX58xxRRzYoSb056cdWRljoNWIgj+Odw7XEb/HHyPzPD4Pavgx1z5LRmtDCHES8iFw+kyli2xG9hD3Miyf/Z6d9k5nLyKwADZ0um1mIbNfTF7TCXN8IXJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618718; c=relaxed/simple;
	bh=lkETshtZg2UeX9V8PR3M4XcdZMEm0CBA4IB+LwamxvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIy5Hoqtc/PXcMxOuk8mz9fcNrtaqXnO8wJyk1YRPD1XbDFw2Dg3OlbNviURnc9FGkLqfGMf4XUCZSjtC70URl6JNZBipouwxlFnsmNulBr9GGsejwqoqxpYv7+0GoWIexhV0CVNlkqnhtxyuuZnpt3pSHlYKcDPhrJd44pOqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PoLQTO86; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f45104ef0so4878872e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715618715; x=1716223515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Al7B0qVSYrIkeWgwQMeNcVrBCGs6mim3bHFYCnmLyvY=;
        b=PoLQTO86IuR8nuDI/osaM29NGKaEgCvDqCo93oR4x+jO3u1uC1kWjqslCy8QxUDIR4
         cdM6pzecWdFu8GIkTMxGnTIY79STh04aRSCE2MXrzcOxFpNayxQAjTS1CPFcWP4yLEM5
         yr1Z+WJdkwg1rYJ2YDr+eo4S1j6pupHv1Ygg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618715; x=1716223515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Al7B0qVSYrIkeWgwQMeNcVrBCGs6mim3bHFYCnmLyvY=;
        b=pssN6+5rvDe8uWiojTk9hYNbmU+ZtvFBbag9ghm6by8aaBv5eMqpM3qRJWm6hkKAj5
         BgTMjf8mfThOlWCdpydocco6xXigGFydeWvgnp/FT5pc6/evVVfGMUeN+5yDjn07lvOJ
         HdasNK7rewoqS1RGqF98GQ5qRzmTDXc+bWnJhSyvaDJv0UsTzybjaGFhCRkvU0/ZL4f9
         1yvGj0tHf6hsGynMcZf5TX8UmolvFtDXbnZucGqdX5kYaqSx0zIVCwNuLKimaEbHm7kg
         65esA6bB5rlXglzp5HEJZJ0cg/Qm8QtTSJ0wPeWY/J9Mb4mtalcY/2UaGKlCx6qAONfB
         KSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdVTNBIUYStyL80eq4SszijkkxArs59BLZzpESAOAAuDg6vd9M9fuuQioA8vZshlj2Ngiu/42WL4G5NuZVh+5dMTda2r8W7LX2Bv4wWA==
X-Gm-Message-State: AOJu0Yzvb+BbzYqJJOZqPQV2FlHRgqRmx6xuXrVh7eOrMe7ATYqvEOZi
	LhGkpKU9xU9YgrG3eZKWYv3eT705VtDkNwn6Wku7+k+b8fJ60x4+r0sTQkdDr+g1830Qcznh2sI
	Ig802mw==
X-Google-Smtp-Source: AGHT+IFbSXeKvAI++oXUEh2f9Oap1pl0tXcoKvAVo3NoEcP0Lro4FZK/5AcJL+GlgWrw70hi5YUMlw==
X-Received: by 2002:ac2:5931:0:b0:51c:1fb4:2329 with SMTP id 2adb3069b0e04-5220ff74c2fmr6179822e87.65.1715618715165;
        Mon, 13 May 2024 09:45:15 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52232d0f61esm1133944e87.268.2024.05.13.09.45.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 09:45:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51f45104ef0so4878832e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 09:45:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9aN7fJl3Fahf9OoMODV78ML/eVg+KLlR/xpSWr3vXi2YGky1eslUVp4sMB9X5YrnCl1Nwwo4cyVGnO833oCGKmT6EY54RErYsY0grYg==
X-Received: by 2002:a19:5206:0:b0:51b:6296:8d1a with SMTP id
 2adb3069b0e04-5220fb773e4mr5841370e87.29.1715618713639; Mon, 13 May 2024
 09:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org> <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV> <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV> <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
 <20240513053140.GJ2118490@ZenIV> <CAHk-=wgZU=TFEeiLoBjki1DJZEBWUb00oqJdddTCJxsMZrJUfQ@mail.gmail.com>
 <20240513163332.GK2118490@ZenIV>
In-Reply-To: <20240513163332.GK2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 09:44:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEMf8Du4UFzxuToGDnF3yLaMcrYeyNAaH1NJWa6fwcNQ@mail.gmail.com>
Message-ID: <CAHk-=wjEMf8Du4UFzxuToGDnF3yLaMcrYeyNAaH1NJWa6fwcNQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in 'rmdir()'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, brauner@kernel.org, jack@suse.cz, 
	laoar.shao@gmail.com, linux-fsdevel@vger.kernel.org, longman@redhat.com, 
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 09:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> try_to_shrink_children()?  Doable, and not even that hard to do, but
> as for shrinking async...  We can easily move it out of inode_lock
> on parent, but doing that really async would either need to be
> tied into e.g. remount r/o logics or we'd get userland regressions.

Let's aim to just get it out from under the inode lock first, and then
look at anything more exciting later, perhaps?

                   Linus

