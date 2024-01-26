Return-Path: <linux-fsdevel+bounces-9114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A44683E440
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2771F22F7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797A24B59;
	Fri, 26 Jan 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ITiiXhmu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2CB33CF6
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706305774; cv=none; b=Nngrp5zIWX995sdEmatBALo28KVlrmqJRS+9tZk1iUGrh+/7V9Rv4ilQMxABgwTcU6Hr8ecT+dl9SfNdNpCz+RT59YPvyh2ZRqTUHYs/k5NzfDp2SXvvK0zkZJxgGICqTevUFKmrDJ5PUd0LnwRsqyuWG/V/In5scEejOv3XehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706305774; c=relaxed/simple;
	bh=1feBzgxjUm84iiTUiKu7X66LEHmz3gCWzAl4aZvt1MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwVcgJ8Olc05qNr9Tng+jtGZYLcCzA041hfgw3iC0pY3Rs/M2iBNKeQ93a/W9EvXFC5PcymWdfIquj+NHyLR5gMIIF5/iH6ZTKew40f4VKnb8IQoz95RxwTL4q+Hqth1SH9YrjngLe8JaFl+UbCoPB5lEernR4o7qMlheNFpvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ITiiXhmu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ad3ee50e4so1292709f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706305770; x=1706910570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wu3+xA7CIMWU4XKJQMmnJ1lLlzU5w120Zsjy2ckeYo=;
        b=ITiiXhmudKL1MPHqHwYC1207HInRj/txaj8MxdEN5yhIElN4HKnN3uJ0qy+v0o2vDC
         MbPRgPt5thoZu9pOGm4LdmSMR1mLCpMIlx1d3OhBpd+RWpv5kyBNJYSLaQqeeszBT5OH
         YxD60z5BY0bNA/cPPaOgmdXyhThUliqyMkhm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706305770; x=1706910570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wu3+xA7CIMWU4XKJQMmnJ1lLlzU5w120Zsjy2ckeYo=;
        b=bJS7etxM3d8iVg5V/TZwDdiE9aQgmDb11kLoKYZWRdfJ1WbQgGnaepfz90eI+gocmM
         xePEXH6vBJGWSiF5Cv6aemP6uS532WbCkGMT6j/s0Ls6UbNFUeGkM6kFJNatjZSct+8q
         x6NVPyOYSIuBNaPWy4j0ZaZpYL4D0qs4uxXIomCTOieo+Ka9XGOkLyUo7dbaZO2TsT29
         TJ4z0mwctIspeZg1coUqN6m2p/pBlNIO4Pkjh9u4aNVw0QSBT+8kWiXB+lt9k9IYMCLY
         6Pgl9jGkK8kj8kkjqYiwKlZHlAeyQqFS1dto/mN8JtIxNCfqTL/ASoxk3IOPIx0fXhcS
         0V+g==
X-Gm-Message-State: AOJu0Yy4Zs0P+aItHgcyzfHCGp2NaG/sAkANgRbovotkeYDF9Slh6Tbb
	ITZCAVJ6oQjNYcr0+3Zfkdth19MR5eERIdeu2PAXQEqnvYukpEff+US5HhMhAPYKf6yp/Kzuf85
	VYpfGoA==
X-Google-Smtp-Source: AGHT+IFu1nKZMMweeMwkCaZpxNoUafxDyNIBOyVvWvW5pTvPCMiznYbCPauwTW0PdUXkgvH9bx8f+w==
X-Received: by 2002:a5d:46d1:0:b0:337:aacb:3934 with SMTP id g17-20020a5d46d1000000b00337aacb3934mr149769wrs.19.1706305770558;
        Fri, 26 Jan 2024 13:49:30 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00a2b1a20e662sm1045886ejc.34.2024.01.26.13.49.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:49:30 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso22451885e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:49:29 -0800 (PST)
X-Received: by 2002:a05:600c:4a21:b0:40e:9706:9a38 with SMTP id
 c33-20020a05600c4a2100b0040e97069a38mr197355wmp.214.1706305769566; Fri, 26
 Jan 2024 13:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:49:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
Message-ID: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you have more than 4 billion inodes, something is really really wrong.

Btw, once again, the vfs layer function you took this from *does* have
some reason to worry. Somebody might be doing 'pipe()' in a loop.

Also, if your worry is "what if somebody mounts that thing a million
times", the solution to *that* would have been to make it a per-sb
counter, which I think would be cleaner anyway.

But my real issue is that I think you would be *much* better off just
deleting code, instead of adding new code.

For example, what purpose does 'e->dentry' and 'ei->d_childen[]' have?
Isn't that entirely a left-over from the bad old days?

So please try to look at things to *fix* and simplify, not at things
to mess around with and make more complicated.

              Linus

