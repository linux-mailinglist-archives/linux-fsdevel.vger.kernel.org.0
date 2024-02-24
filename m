Return-Path: <linux-fsdevel+bounces-12680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18018626FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A64A1F2163E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A25495E5;
	Sat, 24 Feb 2024 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bB8/krgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008C481B7
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708802482; cv=none; b=q1c28jUyoPPnO5F+i5+Vr7NupTQhgTDwCl1KP1WpJKLxOk6C77mob0D/1YEJ+ZWaWqX/fuVp/jC4ryqumL5brlEt8UOE9zfVo/Jo+zO+Eq3+mGVLqRD1kzNmqmQimoy/X0nAZBI0Uh4Qq/GFnSwFGMOO9dLnn7sOre7X6BcNxsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708802482; c=relaxed/simple;
	bh=LEDmZd3bdmCF5vJJpxZw5RCr63r0XiJ1pORcy5l8t0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeD7SAYynK6DRaOxFmEIwU8wJlkFpv0Iy4XYIH5g4BDapc65sk3ZWhfOZtrvsPjilLrNrV5JvQg/Va3f2DPSR7P+EC2FDjfZrkLW+fIX3qoqstkC+iX7RU6AFSj9oxK0r/0l4jYvuQKjz3/XefpfAlfQQ80XTyWgHuUvLDLK+ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bB8/krgF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56533e30887so1825343a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708802478; x=1709407278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55PO3O8joddm3VZ6ZyAuyMt3UGM56JF8jPl6jl4C96A=;
        b=bB8/krgFCa/ij2vrMBpfdWLc5KxGN4jwJzQ4UWbJp5rS6M4n2+D70/7dyH+3kiyd1d
         x+wE/ieJ62jUy8Oldu0ZDnZ8AwxE8LV6AnzO6zZtoz+iUZDKFhZ3hY8H2D867Uh34icq
         cW3+KDmR0tJgWvp33s1cO6j1mpwfdNmwKrADE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708802478; x=1709407278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55PO3O8joddm3VZ6ZyAuyMt3UGM56JF8jPl6jl4C96A=;
        b=W0+Yv+IEmryxC6opzn59POZ4DoL4MrJFimy0fZLQIrwfX9eCeWK60TdDPEuqyrqBlW
         M1dCfOBazP1Cy8BIYGgCxgnQBogfSdOCYVyWGFTma5kdTnnvngRZIeQ0mqGhX01/e76Y
         Wgz+PJzA9ltv/1vrc8JUnEOzP98/GUsC/+j204lL2ZmKDX/7NHv8JxLILn3kt7DVO49V
         uiY1zRNXiBMJ1sXo2A2eltGLmGEmhRaV9WSRRLuM2+s0BlGRscdlxBri6r+qG6i/P/KU
         L3Y+cYbeqprYFw3xPaGKtNiH5fJXxVv6YRludLP2D4Zm9ZHTrae/WA3B8wCGmyXGlAjx
         n+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWRBqdcGaevY/ObSTwbCtZzUiasqvpCRWR21cI8IrkwR2Ese5/uq++ACy8XlSbeydhvpYD9NEqWP1plJmvwYPwJwsLJ2t3FrVmwRQMxSg==
X-Gm-Message-State: AOJu0YxGk0QZ9EiH7/OdIENecw2ytm3+hxpI5to7+V3lj8LxmDDlRmz0
	9M0jdxOs4+yxP6aUzEWRCsavnsSJiomw7DBKIfSMh3dsOTtiCPlksmFdZ821fPAbe44J8tgqO6y
	5/lo=
X-Google-Smtp-Source: AGHT+IE2dBsjavQYYc6C2VC0VVVgj4Z+Yia8k5NqhxjXFglj5VynfwNvrDXYtVwPu60+Hbb4Bm1NZw==
X-Received: by 2002:a17:906:11d6:b0:a42:eaeb:2932 with SMTP id o22-20020a17090611d600b00a42eaeb2932mr1120438eja.62.1708802478677;
        Sat, 24 Feb 2024 11:21:18 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id n25-20020a1709062bd900b00a3f63b267b0sm823625ejg.101.2024.02.24.11.21.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 11:21:17 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a36126ee41eso194353966b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 11:21:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7nGwNPIQAeznme3vxaNZ4KOnZmp6wtHH7SK+N29LbgL2nr8l2Ll/iM/FAc49BlSs4HFIAyzUw3P2cXSkgISC973EN1j0dRO6GycGy3A==
X-Received: by 2002:a17:906:1949:b0:a43:3b2:bcf8 with SMTP id
 b9-20020a170906194900b00a4303b2bcf8mr615523eje.10.1708802477257; Sat, 24 Feb
 2024 11:21:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org> <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner> <20240223-schusselig-windschatten-a108c9034c5b@brauner>
 <CAHk-=wg0D8g_97_pakX-tC2DnANE-=6ZNY5bz=-hP+uHYyh4=g@mail.gmail.com>
 <20240224-westseite-haftzeit-721640a8700b@brauner> <CAHk-=wguw2UsVREQ8uR7gA1KF4satf2d+J9S1J6jJFngxM30rw@mail.gmail.com>
 <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>
In-Reply-To: <20240224-altgedienten-meerwasser-1fb9de8f4050@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Feb 2024 11:21:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvWr5j6DZqepuNx1-ChgNxM++h1OfOPfKaJrC-TeSaDg@mail.gmail.com>
Message-ID: <CAHk-=whvWr5j6DZqepuNx1-ChgNxM++h1OfOPfKaJrC-TeSaDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>, 
	Heiko Carstens <hca@linux.ibm.com>, Al Viro <viro@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 24 Feb 2024 at 11:16, Christian Brauner <brauner@kernel.org> wrote:
>
> > Would selinux be happy if the inode allocation just used the
> > anon_inode superblock instead of pidfdfs_sb?
>
> No, unfortunately not. The core issue is that anon_inode_getfile() isn't
> subject to any LSM hooks which is what pidfds used. But dentry_open() is
> via security_file_open().

Ahh.

> But here's a straightforward fix appended. We let pidfs.c use that fix
> as and then we introduce a new LSM hook for pidfds that allows mediation
> of pidfds and selinux can implement it when they're ready. This is
> regression free and future proof. I actually tested this already today.
>
> How does that sounds?

Ack. Perfect. This is how new features go in: they act like the old
ones, but have expanded capabilities that you can expose for people
who want to use them.

The fact that this all apparently happened in nsfs too is a bit sad. I
hadn't even been aware of it.

I absolutely *hate* how some kernel people will just say "the fix is
to upgrade your user space".

Oh well, water under the bridge. But let's do it right for pidfs, and
your fix looks good to me.

Thanks,

            Linus

