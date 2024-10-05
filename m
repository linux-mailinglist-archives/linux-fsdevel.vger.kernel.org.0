Return-Path: <linux-fsdevel+bounces-31086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3E991B2C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D361C216E9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10995168483;
	Sat,  5 Oct 2024 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WBRDLzG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE0165EEF
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728166480; cv=none; b=IT0ILBC9Xi6lt8KzbIebx/aDQVNTuXoDtBigvOs1ntUJgFkwt5EiwevmPuoi7YjllUccvh/0BgqMh92e7VYCFRpFd0s3IiMMXu/yNfRZypIXgs5GPbGMPrIbshmZ1FdzjOb0aAOh0Li16WQX+/2S09YuZ57xaLXhUlEKKzQlBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728166480; c=relaxed/simple;
	bh=WM8mIcL0c9Fv8EDIss1EQIdZcQnRrIkeWzVovcVrWpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tePZZ2uPXMbigA+tj8tV97hc8nGrJMstlYr/ZK4r4agxVQM+DS0Nw4ONRLM6RjdfuAnBZ1dkXpTfCpSFS/y8noIykKsYPEworQlbdZor/G+qZOtPuFN/TriQKA17zoNXU5XJsF1tmP+qLyobPhM2rB4PvxgdOChX7HAOzifZpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WBRDLzG6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c89bdb9019so3877516a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728166472; x=1728771272; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxeoRrrkTFuyi8nqR4W5wTlrVGUjVb+4B20LZCJGEb8=;
        b=WBRDLzG65TgmqQVEWpyXYji1TpanYfpG4CR8Nxuw+TykYRgRvqjlY5aI8WyLGUttCx
         PtvkEyDPj0vY1rj961svwrIFh4MnLs26dg3syjvLQazRWn5zYWWr00UxgzYpIiH3zznV
         VfPfU4erYcK/Hfh0dZbYHGVkVkIpWVzdfhy/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728166472; x=1728771272;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxeoRrrkTFuyi8nqR4W5wTlrVGUjVb+4B20LZCJGEb8=;
        b=U6m1A3fD9k3nmILZZ8KZC+mbvdcZmqPP4vN6Dqi4mOIQ1RIOAekecFXwdLUj09gSx5
         bSbYFiCZg++h6Sa35RhM0mhiO+BKEixrxiM709T4EelylFCsUC7Lqo009HCWR7y6/e53
         vH8UUAEp/s+V0MZ/+aPmfJuwnOQjZHNtKobNOTXPQjfkzXfYoQpRYPu4JOQ1B7O/Gx/z
         D/stbiQ4BA0OonZakTEGBdHdhGL8eQHXURbmFvVMuZICntBAXHsAIWQWN53nk5N+DTiI
         pCjqm8TVhCc4O/sZ/C2SkKGxVx0s8qm1ziC2nLGN3dcZOs71XAaKe+xW70dv1TlXH1pm
         ereQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSQn7qFDy93oam57EktnmRgm4FrKbZ8KgKtFui76QgT6i/p8staYCQHcfd1UxBgHN/gPF1ExMlInr09eo0@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgUMZ0dNyc7hg6D/1ypdoxz/6fE8eyaJJ/RL89UIoBOBJTP3a
	ymRtmnafizbE9oQvWK1rWrrDqgZqirmBgMpmdo2A/uw//5/GHfKXIcl7E5YYA/W4LlQ6Wke7whz
	5sp5WPg==
X-Google-Smtp-Source: AGHT+IHkbSQo1UKS8Bu08oLxQRmjQqDloGbtFPHPVOzB/yDdTKecFeDHtYcl1vK0hc/RAPSd9Z5wuQ==
X-Received: by 2002:a05:6402:5cb:b0:5c8:a01c:e511 with SMTP id 4fb4d7f45d1cf-5c8d2e151e0mr6082376a12.10.1728166472105;
        Sat, 05 Oct 2024 15:14:32 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb7f0sm1412552a12.72.2024.10.05.15.14.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 15:14:31 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a90188ae58eso421294466b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Oct 2024 15:14:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU93FNBOLMiBe8Hj4Mc2jNKXLCTeZhNlJ1oqYrcOnBqWLwJYxVi5AeeRAFA01Rc+NvHTu70jyh76J5/F2ta@vger.kernel.org
X-Received: by 2002:a17:906:fe4d:b0:a90:1300:e613 with SMTP id
 a640c23a62f3a-a991c077ddbmr729450166b.55.1728166470688; Sat, 05 Oct 2024
 15:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-brauner-file-rcuref-v1-0-725d5e713c86@kernel.org>
 <CAHk-=wj7=Ynmk9+Fm860NqHu5q119AiN4YNXNJPt=6Q=Y=w3HA@mail.gmail.com> <20241005220100.GA4017910@ZenIV>
In-Reply-To: <20241005220100.GA4017910@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 15:14:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
Message-ID: <CAHk-=whAwEqFKXjvYpnsq42JbE1GFoDR5LnmjjK_cOF4+nAhtg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] fs: port files to rcuref_long_t
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 15:01, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I wouldn't bet on that.  You *can* get over 2G references on 64bit box
> with arseloads of memory, and we have no way to make fget() et.al.
> fail when refcount gets that high - no valid error to return and
> a serious DoS potential if we start doing that.

Why do you think we can't make fget() fail?

That's what we did for the page count, and it worked just fine. Two
billion file references is not a valid thing - it's an attack.

We don't have to fix every file ref increment - the same way we didn't
fix all the get_page() cases. We only need to fix the ones that are
directly triggerable from user accesses (ie temporary kernel refs are
fine).

And the main case that is user-accessible is exactly the fget()
variatiosn that result in get_file_rcu(). It's perfectly fine to say
"nope, I'm not getting you this file, you're clearly a bad person".

There are probably other cases that just do "get_file()" on an
existing 'struct file *" directly, but it's usually fairly hard to get
users to refer to file pointers without giving an actual file
descriptor number. But things like "split a vma" will do it (on the
file that is mapped), and probably a few other cases, but I bet it
really is just a few cases.

That said, the simple "atomic_inc_return()" suggestion of mine was
broken for other reasons anyway.

So I do think it needs some of the rcuref code complexity with the
rcuref_put_slowpath() turning the last ref into RCUREF_DEAD).

                 Linus

