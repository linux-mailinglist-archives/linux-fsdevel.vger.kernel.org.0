Return-Path: <linux-fsdevel+bounces-41321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C0A2DF7E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D63A52F2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 17:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC491DFE06;
	Sun,  9 Feb 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JZ07SReS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CC1119A
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122827; cv=none; b=qlRAZXwGPitdMg3rUVYooNMhVfrZRVYE/FDdtG7A1AT6lwPzE7BhwALw+BqF0xm88AuWBZtgX0upX/iZFZionFhRVcWkGpyO7NXVqxQbY5wLROI0h91YnDm0Zq60kZXR8zcBynA1Xnd3y2lxTSVlVJIcpOmuCzH+yejSz/k6aMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122827; c=relaxed/simple;
	bh=awNkYa3Md5bUo8i8zsV7pVKF5MYaBSWMYBPHO3M15Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9lTNJfKY+ofEyjmsKIiRZdf1ZS4z1k2M3Mmd0SVDit3zDhjT5s/pg5vRkOR66jDFNjftgf0UfFuY8yLiunzdLxJhiD2ynmWLwDOT9+030TgtxEAu9mIHF9tCZEBjEUB9/32TaDSAkWOkfDHNQ+WpLC+HCFFZ/Kx633U7M+Qd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JZ07SReS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de56ff9851so3235073a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739122824; x=1739727624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8f+USY5i1jojbJGeDtJw0r2JSIdnbcI05exT8JPCLJM=;
        b=JZ07SReS03dRJ71pZDmP45P1HxaEqPNFVFfwjvGOcv2RO/VSscxjB5qRT1zLxJyHxC
         WW0WmIyxFuaWyTIarZf5zoGfMPC/al2s/WH5O0RbvJ8FZXUe/+h7xKhTo9L5HWyvfg0A
         U30EIrxQeoQjxAHhKAwoMzoLX+naC+gtUq9DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739122824; x=1739727624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f+USY5i1jojbJGeDtJw0r2JSIdnbcI05exT8JPCLJM=;
        b=jDSepmQCOy56cwSTjQ39d9PdIfCGb1HgxYTUdUOh4JhdWRAiBrJSIYeJ6+DjUd0v7W
         8bCQISsqoCot/KI9tt0CYwwuqxw2tCsxnQ7SPXS8B80cZBLPcdcDnJv+9eerEHaJg4iT
         Ri2MwSgHA+hjuNDmbgPAJaw8JcBc4OjSWzema9/C6pso58oX0Ob4yxJrt/NZ1EyULr0g
         DO6B0NpgaQVS+d4lhQqNUZHs7qdlILfA58DENamRIt6byAMl1zBLgosHr/yWxWrHglUJ
         AI4rw55Eq5amwtv5z3wnnXQsfVbjfgGRYN4iwDvr2GFDjET5FP8GV3+M4/jXhbPEibEs
         IaqA==
X-Gm-Message-State: AOJu0YwmwvhlX3E8ifB3hpBH29SIXXMrEzzRZad4RlkSDS5AJ7xJXYic
	MUbko+YuuVrKjxhgeHssx9yxy2yLBkL2xW7VlSXaZG5i5C491jRSj0cXEGjUgLjPnPoZPAfoPNL
	ImtA=
X-Gm-Gg: ASbGncvn07wLw6Rdk7xduzGy6jBJzaLquxZtPjNoxjJAS0s5xgn8epO+0Kaw4mEYQkK
	4ex4Qjh3LSsxG+cEmhUik68QcHVioxWnIlnqKgtLUuvOmR4nXjQ3TeYrFlX620g4/IBW5IruLVw
	tdYwX/1wgFSuS4+DpCzqFkaaCyD8maGPTXht2XC6gCwKn6mR/QzWCwSwzFAi3/5xoC+tZms0lHq
	IerRM9l9Tu0kn7OAvch7pJ+OQ9kqcyF434nqhoNiM1jSm06jnpjmIWoiowc/T5kQ6rxwi0ZYJHV
	k1BVwn8NMlAqx47hwAMX/bomG14c9oOaeO8CtBfPuSM6uW2Wc5EajyfZlD7m+O845w==
X-Google-Smtp-Source: AGHT+IEoBObsDr7WjDbLGAsxq94+cwpfYmZXzMfEB6HBIcmOSyzNAibrgsAmA7cf+GGaUxLdduI5sQ==
X-Received: by 2002:a05:6402:40c9:b0:5de:4acc:8a99 with SMTP id 4fb4d7f45d1cf-5de4acc8d50mr11333666a12.18.1739122823849;
        Sun, 09 Feb 2025 09:40:23 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de62512da4sm2749554a12.81.2025.02.09.09.40.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 09:40:22 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so1790947a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 09:40:21 -0800 (PST)
X-Received: by 2002:a05:6402:13c8:b0:5d0:ed71:3ce4 with SMTP id
 4fb4d7f45d1cf-5de44feaa0bmr13224043a12.6.1739122821546; Sun, 09 Feb 2025
 09:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209105600.3388-1-david.laight.linux@gmail.com> <20250209105600.3388-2-david.laight.linux@gmail.com>
In-Reply-To: <20250209105600.3388-2-david.laight.linux@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 09:40:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
X-Gm-Features: AWEUYZnVB4u0CE8_NqktnRI7jAQu96wYzkqcCCQdZkJ0CHx-FvrH7mTME3sNsc4
Message-ID: <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user copies
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 02:56, David Laight <david.laight.linux@gmail.com> wrote:
>
> Code can then be changed:
> -               if (!user_read_access_begin(from, sizeof(*from)))
> +               if (!masked_user_read_access_begin(&from, sizeof(*from)))
>                         return -EFAULT;

I really dislike the use of "pass pointer to simple variable you are
going to change" interfaces which is why I didn't do it this way.

It's actually one of my least favorite parts of C - and one of the
things that Rust got right - because the whole "error separate from
return value" is such an important thing for graceful error handling.

And it's also why we use error pointers in the kernel: because I
really *hated* all the cases where people were returning separate
errors and results. The kernel error pointer thing may seem obvious
and natural to people now, but it was a fairly big change at the time.

I'd actually much prefer the "goto efault" model that
"unsafe_get/put_user()" uses than passing in the other return value
with a pointer.

I wish we had a good error handling model.

Not the async crap that is exceptions with try/catch (or
setjmp/longjmp - the horror). Just nice synchronous error handling
that doesn't require the whole "hide return value as a in-out
argument".

I know people think 'goto' and labels are bad. But I seriously think
they are better and more legible constructs than the 'return value in
arguments'.

Yes, you can make spaghetti code with goto and labels. But 'return
value in arguments' is worse, because it makes the *data flow* harder
to see.

          Linus

