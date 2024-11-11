Return-Path: <linux-fsdevel+bounces-34334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBEE9C4889
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCC91F25497
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAF21BC9E2;
	Mon, 11 Nov 2024 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YFd6xClp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AC1AC89A
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361928; cv=none; b=SheM2IO6NJR75N4gjtjZoVmdTVu6Hn4PXRwKychViW3pCtGE6do+zhCJiVFa2zDhIpyZve+fScPD07GWdIsEah2LrhMzuc1HIJL8ZuseLT+q8RePIgNKm5wbdWSnvsoAaHBf0rymAI3IBIWSXqJbWcd6oMkbpWSa2jQZgGaV6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361928; c=relaxed/simple;
	bh=q/zqChwYsrx4Zy33qGdG8SBhmqndzWb5CoC2UrWb3jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apx3Me+Unf4O6WPETu+by0E9DKtzifJEAGIf7iUpkUC99fHzYlpaJvXu7agtGR676+eLfNntIkde72gZGwnbx0B1p0huknUhtSqU3XEoY41+w1vbp5OV/DBerHhxEDwV/6tAVmgn9G4m6vYbOuIEWR1rmVAOXTcdN9Rg1jfJPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YFd6xClp; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e3f35268so5477529e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731361923; x=1731966723; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L24fLxFCjFl/hQH9TQaBFKqNsNfJNVwL6H3wGfP4DSE=;
        b=YFd6xClpm5Z/rzg6DadchCVqpv8DOwXHjqj7Ko3l56u5zz1yKHyyRc++0S8eIDO4YE
         PrJNVpOWHb9kX2FZ1dN3np/6q828VkOeD8J08UZorF8kSUuiqZs0hPz5hgC93h5Z4Foz
         tq762Jj4K6vCkVxZIif89KrBNQm8lDNWnrgNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731361923; x=1731966723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L24fLxFCjFl/hQH9TQaBFKqNsNfJNVwL6H3wGfP4DSE=;
        b=wOHsBRfD2uMpaM6qZw5a+761gIRlsdVsrsKA+7MJ4ZRtVqQC6H4gCj/nWF2nag6wP0
         ZRCEWUAIOv+01E7KTGzhyvnTMir/2Fs25VCuUbV1s+da6cdJX2+yuu78hkYzO8Ds6Oco
         kj8OWjaYnkDHqRIAACDkxHudHmBXxcirQ7rHx38PbrKc0ePoo5nc10wwJOt9KRod60TN
         gsIwYilZOrhPGzQj+ay4zkWTgBSLakMaDJV9d1MjPlWd917xACSZaEsB2lT2yF+ukZyF
         OIlu8ysmMte0+m5aTkDlFY47xF1HlDonrXq4UeMIah0k/EaBjJ12Hewpj8Jh7S0iEjVI
         72qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX725SFKEy6ytKQFjaJPly/NKxicyy40jvYsbJeBp37hu7tZ0cckbKd/BJFAZvYW3HzDRL9tx318/5jyloO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bBbVbY+yo+m46NlFvdEWO6Lbij53Ew8gP1tJBaPN0iMICbv3
	tHhlUhc52wQztyDqU4oLHDl8m+hyMn8IZrtdOvNc+RE2xRHcONqmdFCyW2mL6RW5GEkAhHybHhf
	izwQ=
X-Google-Smtp-Source: AGHT+IEMLlCwT/R1MSDzLkuO32/oJfB4/uBL0r8/MMwXEf44s1aBHIKMUiL3fIgJoIcTXKTi0W5Hpw==
X-Received: by 2002:a05:6512:3c8d:b0:52c:e3bd:c70b with SMTP id 2adb3069b0e04-53d862b32afmr6671877e87.1.1731361923186;
        Mon, 11 Nov 2024 13:52:03 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4b90esm646557166b.65.2024.11.11.13.52.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:52:01 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a0c7abaa6so650860066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:52:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1YvFJd98YWr7keOjvhU4F3WWWSE6KCY2y5XD7gPpDtdf3DgJzPgBJ8PQux9472J8Sb07YPGnqmFfiOBju@vger.kernel.org
X-Received: by 2002:a17:906:730d:b0:a89:f5f6:395 with SMTP id
 a640c23a62f3a-a9eefeade4cmr1373427066b.1.1731361921497; Mon, 11 Nov 2024
 13:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 13:51:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
Message-ID: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
>
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() hook.
> +        * This is a pre-content hook that is called without sb_writers held
> +        * and after the file was truncated.
> +        */
> +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
>  }

Stop adding sh*t like this to the VFS layer.

Seriously. I spend time and effort looking at profiles, and then
people who do *not* seem to spend the time and effort just willy nilly
add fsnotify and security events and show down basic paths.

I'm going to NAK any new fsnotify and permission hooks unless people
show that they don't add any overhead.

Because I'm really really tired of having to wade through various
permission hooks in the profiles that I can not fix or optimize,
because those hoosk have no sane defined semantics, just "let user
space know".

Yes, right now it's mostly just the security layer. But this really
looks to me like now fsnotify will be the same kind of pain.

And that location is STUPID. Dammit, it is even *documented* to be
stupid. It's a "pre-content" hook that happens after the contents have
already been truncated. WTF? That's no "pre".

I tried to follow the deep chain of inlines to see what actually ends
up happening, and it looks like if the *whole* filesystem has no
notify events at all, the fsnotify_sb_has_watchers() check will make
this mostly go away, except for all the D$ accesses needed just to
check for it.

But even *one* entirely unrelated event will now force every single
open to typically call __fsnotify_parent() (or possibly "just"
fsnotify), because there's no sane "nobody cares about this dentry"
kind of thing.

So effectively this is a new hook that gets called on every single
open call that nobody else cares about than you, and that people have
lived without for three decades.

Stop it, or at least add the code to not do this all completely pointlessly.

Because otherwise I will not take this kind of stuff any more. I just
spent time trying to figure out how to avoid the pointless cache
misses we did for every path component traversal.

So I *really* don't want to see another pointless stupid fsnotify hook
in my profiles.

                Linus

