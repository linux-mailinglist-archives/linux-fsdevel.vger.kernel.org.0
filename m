Return-Path: <linux-fsdevel+bounces-31090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC066991B44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6060A1F2227A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA24165F16;
	Sat,  5 Oct 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HKK4UtLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C513635B
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728168217; cv=none; b=mkGCGp0DUsO/ClSLTjB/54mrT3/CMBJ4eI3FFvLjexA0fNW4lxYnnWNkqXRMyGERoll1KNXIQ2V4nUr7maQJ++hc90yqEo+ES6M2WdAWVGwZUKxCOub1bM6ykU/y1qbY9sLL5dAFfFAVLbZ3bBz4y5+GJOzA//j/8QfuPDTkjIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728168217; c=relaxed/simple;
	bh=IMXbS/Iznlt0s2iAL/vsKC+WWKEPO+xqsSSoemO5WrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8Vyd3mIzQJTEt2fYw761uUfzYyJrBZsM9zNhJI992GHN4XOEfACmRc1GOJSnPnGx73Ti3d7UG/A+xDiuTucHOEhcvQMCUlqnvgKZ2YHkPATX+5uir6I2LKARUwiMayEtGEiih2hkzZ5P/9aQv2MMDxLzpKKewLS5nqgCf4Edc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HKK4UtLv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso582172266b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728168214; x=1728773014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiYLoB/cwzi5uqdg+oyqdFtOxGnmUgu9t7fd8FV5+Cw=;
        b=HKK4UtLvI4k4kEr5A1jEs3hUjRDhWTnLrjzLn4YwH/vOM7hhTNLoqRmaM9yznltP9f
         kf2lWVfUA+vXgBxG8AlWQ+DJhXNiTKMt7lWFbsx5s4uX9+XTneDkVVrM20rd0a97t6MN
         FHJgZxXHyJjirjw7E1s5BtC1+cOMRV5s5aCbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728168214; x=1728773014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiYLoB/cwzi5uqdg+oyqdFtOxGnmUgu9t7fd8FV5+Cw=;
        b=Wr5VWq7uqMbXlOgFZd+Lhc7K+3GDf5ZeY5OZY53X/cGJM6NlcuVAgiWjs3S/sC46xz
         8oFufIdFORaAYBrxHr525Eyop72Lz2CwBVt3YmnJFvfWajf/ruycJDJ3WouA6aAmTmVv
         hLOKCHxwcHiqmAsacHw0ACwVAvH2VQeHCdISKqY+BgM8cHsb4HNLYTWMqtuIKK5Eh2T0
         ioGAXVlrVALUQIa6jkL5uUjvW2NBOlZMT1TSrTtaUiCJMqcgixemxZGFAMOF4RYIYUvl
         Ra8K2qxen949XAqSwuVqW4bqbMLTNPKfK3nd7CuQPjMrzWL7AvI/TJFeQZC3uUDbciYM
         wWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxs9Xmej4ba3YVgdR8EJH+BL2ZMQIOrWr1aEk0ZPuB3hLbQKR8/MEE0afj61vCZX5xPd+zgoW0Aw47XCAv@vger.kernel.org
X-Gm-Message-State: AOJu0YyUD/EJ/69B1T2d92gYqjGnkV39aNhIS2d7q3AOPYy4AC+fAnyC
	HIRivbba8jyulAF0W/DMA5mwkwLOf4nRzN/mlLwAjkFDu59UsUFeA+ZSMmUV7pyJvpuBS76OP88
	aJq2i5g==
X-Google-Smtp-Source: AGHT+IEwGELdKvrrS3iCZ7b8Pme7PQhqj0DXsRc+9iOIvnnnoV1a16gl1OizhvaUosa1bvkON9vW3g==
X-Received: by 2002:a17:907:6093:b0:a99:4136:5b07 with SMTP id a640c23a62f3a-a9941365b86mr272448466b.60.1728168213817;
        Sat, 05 Oct 2024 15:43:33 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e783d86sm181373066b.136.2024.10.05.15.43.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 15:43:33 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9939f20ca0so129797066b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWQlFOndCEpLpuP7VeHTdY+Zw00yiZcONXd1RfoIkfYr8OCWw4kVaDrGPT/6BTtXrVd/m8BK7us2lk1ROh@vger.kernel.org
X-Received: by 2002:a17:907:e688:b0:a86:7514:e649 with SMTP id
 a640c23a62f3a-a991bdbe0c2mr692436166b.52.1728168212320; Sat, 05 Oct 2024
 15:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com>
 <20241005220100.GA4017910@ZenIV> <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
 <20241005222836.GB4017910@ZenIV>
In-Reply-To: <20241005222836.GB4017910@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 15:43:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKmjuc8T_9mc7hWpBp1m_E+wkri-jFAD67AqkHZQjWPQ@mail.gmail.com>
Message-ID: <CAHk-=wgKmjuc8T_9mc7hWpBp1m_E+wkri-jFAD67AqkHZQjWPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 15:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> You can keep sending SCM_RIGHTS packets filled with references
> to the same file, for example...

Yeah, it's always SCM_RIGHTS or splice() that ends up having those
issues.  But it's a really easy place to go "Oh, no, you can't do
that".

> Anyway, which error would you return?  EBADF?

I really don't think it matters.

Come on - the only possible reason for two billion files is a bad
user. Do we care what error return an attacker gets? No. We're not
talking about breaking existing programs.

So EBADF sounds fine to me particularly from fget() and friends, since
they have that whole case of "no such file" anyway.

For try_get_page(), we also still have the WARN_ON_ONCE() if it ever
triggers. I don't recall having ever heard a report of it actually
triggering, but I do think we would do the same thing for the file ref
counting.

Anyway, maybe making f_count a 32-bit thing isn't worth it, simply
because 'struct file' is so much bigger (and less critical) than
'struct page' is anyway.

So I don't think that's actually the important thing here. If we keep
it a 'long', I won't lose any sleep over it.

But using the rcuref code doesn't work (regardless of whether 32-bit
or 'long' ref), because of the memory ordering issues.

             Linus

