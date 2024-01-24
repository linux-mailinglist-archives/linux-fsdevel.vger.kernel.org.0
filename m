Return-Path: <linux-fsdevel+bounces-8785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29983AFB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D4D1C26FE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742282D8B;
	Wed, 24 Jan 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KloGb6hc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D047F7DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116877; cv=none; b=bWyUJV4/leEfACoFRSNWxNpGPRPY0T892KnKSwxWLdz7nmnr3RnlJba+/dKFpVScZONkLgVcymgaDqDfgSC82oD/EprqjDyMmHri8/RxrUK9gdsy48+W/B7ZSqwrhgBxMrHpfmo2D+fMkvDZC8AajgqC6iTwUSQCXhRN6apwcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116877; c=relaxed/simple;
	bh=i0fh2fvqUB6h0Bq9w6eV538kz5PYIbRga3q0Tr+/O4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpboCd/l7NaY9QcVzUPaqDBO2tTUXFmGAkFYlxpODgt1+r9PiDBZcqUkYeRLCxsRf4yQWHiQkp0LzCwMOQuNCcJS7e9ylTvXtI9YkKQF50F3Ym2fX+NmgR22XWLlVYTHV6WeRl3dYubiWWyxvP9ODflU5/McIFRsPwwOrt/GU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KloGb6hc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-290ec261a61so630714a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 09:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706116875; x=1706721675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3H+ezh5j15p10TUIQ78gJT0AbI3MbNz0EQ5MG5g6Js=;
        b=KloGb6hcbTufAwdkYqlBSsWZOgn0F6LTXmIJSgH9nORprcQx8B2lRFJwhTiC2pO2+4
         fLHqqbiXPDUjPxlVt+kyLdHcTMULTYXLTqLdPOT55mTc8/XIaUU9S4krI65CVfTFFBuL
         WzleLev4QZD/VY7xznAXEGiD/XokWkniDoLr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116875; x=1706721675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3H+ezh5j15p10TUIQ78gJT0AbI3MbNz0EQ5MG5g6Js=;
        b=OgLsdPYWW9v4lMZUqzWYeUywUYqZfIv962qHQcSra54HLKTMyogWmzfF1s9WG22dW0
         b9521xIDQsgdb9VlYKRI9TnuUpbaMOLHKr2meYwf3Md0CtxfzE63xem9c8CjoVPJlH2m
         NGmgGtJg9je4qOCszF7ocoB0QxH4t3O4V7j+qy3VU2KmzOsCV3z+BUf0wqGMRAjkUBfs
         e93hJJHd4Du1Ss/3yAe+eVuXHQYchRX4XWQ9WxWLOfy9Oy6+5pv51MNCuVdVA4ZzuTul
         3aaXAK6qrKOd8e1172noNcqaSEVblAjTkM8UtcI7fJdqKmnNBDkXbTOH+JMacIXWrJcL
         FCtg==
X-Gm-Message-State: AOJu0YzPGnLd7Kgdnk6sW0V/3XL3kKcBzwZ6ndaaefMzlnjGnOojviNt
	Tjee+d10Whgt9XsykT2FN6ia5GorCkWSZ3TlJbZTC9hmi3C5svENzTcgXb/jog==
X-Google-Smtp-Source: AGHT+IF8mYZHsXtIZHYmarYRM5N7qbVfGOw6LSL+xSG6379FubnYGny6wPevlrY8z5lhGqrKJ4N0fA==
X-Received: by 2002:a17:90a:cf87:b0:28d:c7bf:3a12 with SMTP id i7-20020a17090acf8700b0028dc7bf3a12mr4364083pju.8.1706116875365;
        Wed, 24 Jan 2024 09:21:15 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id st13-20020a17090b1fcd00b0028cf59fea33sm13880703pjb.42.2024.01.24.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:21:14 -0800 (PST)
Date: Wed, 24 Jan 2024 09:21:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240916.044E6A6A7A@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
 <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>

On Wed, Jan 24, 2024 at 09:10:58AM -0800, Linus Torvalds wrote:
> On Wed, 24 Jan 2024 at 08:54, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. That whole thing is disgusting. I think it should have checked
> > FMODE_EXEC, and I have no idea why it doesn't.
> 
> Maybe because FMODE_EXEC gets set for uselib() calls too? I dunno. I
> think it would be even better if we had the 'intent' flags from
> 'struct open_flags' available, but they aren't there in the
> file_open() security chain.

I think there were other problems that I might have already fixed when I
reorganized things in commit 0fd338b2d2cd ("exec: move path_noexec() check
earlier") to more correctly map to LSM checks.

> Anyway, moving current->in_execve earlier looks fairly trivial, but I
> worry about the randomness. I'd be *so*( much happier if this crazy
> flag went away, and it got changed to look at the open intent instead.
> 
> Attached patch is ENTIRELY UNTESTED. And disgusting.

I opted to tie "current->in_execve" lifetime to bprm lifetime just to
have a clean boundary (i.e. strictly in alloc/free_bprm()).

-Kees

-- 
Kees Cook

