Return-Path: <linux-fsdevel+bounces-59600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99480B3AFAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 02:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14571889947
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 00:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0029414EC73;
	Fri, 29 Aug 2025 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dSNLEh4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029E017A2E0
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 00:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756427750; cv=none; b=Cd3XGK69TLOqv9t4QHhzjnHktjxxKIqwMjdjuoZuft5BtXIg0q7hDe7TYdTzVDEvGmFfSN3zGvKAZNcS0YJ41XEbxvPKFKnnsCYj2tTLEoyMELONxby96g43wp8KrWTJWGy6dAMADBnO4zKRkAJZ/mqVQEna9FMmKy25h+X4wF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756427750; c=relaxed/simple;
	bh=cpEdyNByG4NNcDMbJXEHsMz9OHatfhsyvN2dAyumaUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lO14ImidgdhnKUqMq4zGk5mmh3B1zfBiodOhdeqj+fbSW1KmuoXgi3+umU89MZ0gqgSQEGXvcm3n+liZiQ5/JKR6UA0xn8vhcLvGSWDHfcInwNZv1rS8X44FPTL+25ATSh45BhN3zDplPqkz2G5D7noFDtCbDeEvwrXwoNHUeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dSNLEh4f; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7322da8so275427866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756427746; x=1757032546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFVGVbqsaaGu5oAX8K+JOex7FFy1dbl6B4AS9P80myY=;
        b=dSNLEh4fSvxtXErbKqSwGdVrZpeiYX0Clh9Qr95itX43iwUpflBKr70FEZCJXPSm8c
         nFGqWeVCIM/pzzkTTeR1omZeDoQVFeg41A+bqsare2ftrkRPhFMs7E5qvsixWf4HP288
         Z/K+LGhkqPpcS7GM/keCwVx4FabuA93q1jQ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756427746; x=1757032546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFVGVbqsaaGu5oAX8K+JOex7FFy1dbl6B4AS9P80myY=;
        b=JhiO0GO6o+933Lf4yWERs2iQs9/CcdmNWrwPL0f6IxslP0bf5j11ejnp3yQJHujp0K
         8dPQI+/7h6jNhoky6xf09pH313s0Ux6kRpJ/jvEQmXpGWhQZVXlRfgoX6Gnfb6rbJPhl
         3K+oHo9kSRJc6leccqU4wO02uWAU4reM5CJkMHHjhuEXkELJGBKsMrAgA7+8CuUtDB5B
         Fy2eXkFzVBCdK+LoFkLAzQ2suXqnI3Q863l79Rigyy1n1Fg6IheuyvdTOjABpWlDnoFp
         wZroHSAsRroAGiPz0qTq+2HbazCE4nkTo8QTGcFtoyhqgL1oAmPf82lheYUPY4WH0jzt
         D+Vw==
X-Gm-Message-State: AOJu0Yys2tDc+4qWbrLj/GWQ3dcbmw6e7kbuVHY69RKl7iYC5e5iORy8
	lZyM3VzC2ACaiN86eAz5whywFQjEFuYo4TyI9JXmQ8FtVulOhDVomYylfXIV24uhAX39+bYPhd9
	GyRot2iJOMw==
X-Gm-Gg: ASbGncvYEeLvTVhy2aQqykiXnZjcrbbFavSN/2Mw6lNFiknwAVgLT7ZI7xb4XzzWFG3
	WCDxRjLbYBUDoV7AFcPPi1X6n6+frGl0tQxsApN40V6APjI+DOUOik0NzZ8b80Cb9FAN//kCWWD
	zNQ3/rRgMOlRYOVxIOr9I7ngNTq/ZcYlfyEeo7yan5xRoY8pLcDPyElzoe5iXYwY3m8fymICBKP
	FPID+Or5apUKjmUKJb99EZcWenonwl1NpLD1DY7pFYs3cTon0imGQ5rjaALtvgOSNcjnxFO+X3u
	X7ZftzWAZ6SckkBwmE+n9L7rZNEkpHT+2i4r7jErHRZmGH5vqDTfaviu6l4OBwu5DxEjp90tXDk
	JqY1EZVy6oc0sxzXiGdLfDBSKo2TZFk5ccKGaJEZDHlZFjlsBPvMkGfiF4M/UFDl+4V32TqDlEI
	tltVaDPhQ=
X-Google-Smtp-Source: AGHT+IFod4Z+/CWZOegjwdfRUg2RB/lX7+fU/WXUoHJU3MFTtPzaURiOPlxF2ZKOHOSl0nI53k1fAQ==
X-Received: by 2002:a17:906:f591:b0:af9:29c1:1103 with SMTP id a640c23a62f3a-afe296e5004mr2371544466b.55.1756427745970;
        Thu, 28 Aug 2025 17:35:45 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f0d44sm77701266b.11.2025.08.28.17.35.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 17:35:44 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afebb6d4093so248465166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 17:35:44 -0700 (PDT)
X-Received: by 2002:a17:906:fe05:b0:ad5:777d:83d8 with SMTP id
 a640c23a62f3a-afe29447253mr2139911666b.29.1756427744000; Thu, 28 Aug 2025
 17:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828230706.GA3340273@ZenIV> <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk> <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
In-Reply-To: <20250829001109.GB39973@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 17:35:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
X-Gm-Features: Ac12FXwAkm5BKcdwS6fdPuurL4WuUlRxNoV6iFS0vfHBYIv7Fm8aMcx4yb9HlRI
Message-ID: <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
Subject: Re: [PATCH v2 61/63] struct mount: relocate MNT_WRITE_HOLD bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 17:11, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What I want to avoid is compiler seeing something like
>         (unsigned long)READ_ONCE(m->mnt_pprev_for_sb) & 1
> and going "that thing is a pointer to struct mount *, either the address
> is even or it's an undefined behaviour and I can do whatever I want
> anyway; optimize it to 0".

Have you actually seen that? Because if some compiler does this, we
have tons of other places that will hit this, and we'll need to try to
figure out some generic solution, or - more likely - just disable said
compiler "optimization".

And if you really want to deal with this theoretical issue, please
just use a union for it, having both the proper pointer type and the
'unsigned long', and using the appropriate field instead of any type
casts.

                  Linus

