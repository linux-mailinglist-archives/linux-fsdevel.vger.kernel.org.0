Return-Path: <linux-fsdevel+bounces-41325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AFDA2DFF0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 19:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31D31629D7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6D91E0B77;
	Sun,  9 Feb 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwEeGy5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91DCA6F;
	Sun,  9 Feb 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739126084; cv=none; b=E96lGdyOcF7q6Ksp4MMjB43q9Df40ScJSrnrD6sNCDUyCYlgzLuypVDz2rrMP1zN8Rvay6lb83JkRTDjh+SoU0uKbJ6HNLPHI/QZkenEOR1HsEunJxxP8ymQd42wvkOqt8TDxzY6o7668LGkUqpTS1vZ5c0Z612e25+ais6onrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739126084; c=relaxed/simple;
	bh=s3OY3AULI5X+NvDz32HCd+UGdaVozUJwD7rEPO82W24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUBIOuCtEOqpebs8vl5QXv0MBykXyBuJnyFm7eXkarhkD+dMGtLxFLdWwHZSU/kXEDU00On41jz05HHP8pcm5FRdL07NhBep0KeHw7pfnDvj+t4g6jyxzUivOd310bOUwmduny5gr57HZCPXM3xr9Zf2KkTkpoogYNz80drMz5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwEeGy5J; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43934d6b155so5633595e9.1;
        Sun, 09 Feb 2025 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739126081; x=1739730881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNdiOPJboUi/+NBqeTXjI26HZzzFYamUZn+GmXOgenc=;
        b=jwEeGy5JbmW7Zxi6d79VxCLodOwOq8xbSqjXD8/8UGV8M/LqYG6j9H/oDlIUKcdNYs
         XjNmC59qMm7nnwFsVARUQQpznrOtZQKTCKLWzhZmXp2hK6/a1hKHJoQP+lGVH3HSoozM
         UVIPBrY4X+00ig1PyHlf/7xBCFBOQT7wS5pN5FI4AY++QQ3jKcVs9EGCpNd4k7bYS5RJ
         t6YdDpVtFLKvNZIDxq/ssOFuT0VeTl/4l6Sw7R15nQT7oDgjyxgjB3Qa5O3LrJn19T78
         DETQh13sCXXbPoFInCa455wUwmpNEWSdA2HvMczZbL1wmfDn6/RrU5nxc7ubE2vodur8
         24tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739126081; x=1739730881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNdiOPJboUi/+NBqeTXjI26HZzzFYamUZn+GmXOgenc=;
        b=oq71m/bKSKKB+wSCqjIRJ7XswBsCSrszgFL+NB2JdieJmxq/1JJnTiE90pY8Uv80uQ
         lDp3zHV4kE+7hHr0pkoWHnVNWw+dEYo8AlQmWDErB598PrGc+2+S7G/0mGT9fkGMy5bN
         /s0nwSTSzLQ6TNpm/PtFpAdrhXdYDASMGcoDjIBV3T75FGkPEJqPjxnRAtPFc/cLXLQ6
         pEkAQ/IyqGOQC5wVHPIrUCf7221eODqLT2ouvzmeBd0yfvItxkONbnEa3KWfbv2uhHF1
         IqNRPgwQQ69NW7BGqAON3Kw8zS3Hv86XXEvXXbM8D9KjymG9VWOYefx396C4DRk+wwSy
         C+3w==
X-Forwarded-Encrypted: i=1; AJvYcCWuPS4KdVOrlN5ZO5l57ZEmNO/0/eOaPAYHjRuwcM3citB/wkuidU1dMO+aKpqnEVwrXUqEf9BO2cs7EMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJWD+sfHzACk97HHBQb5N/7gcB4Rf30m2lnf5ooSsrTjtzJNVK
	JFsUpHfpRxhyXlLrK9zd24T9BI7eV+vCVCiUxpWhHaXS1Mc8suUs
X-Gm-Gg: ASbGncuIbSQrewcmAKNqBIjYMsEXvEeXkPgyJvgVOhuamm2+jV7BNM98yhUGNGNqxi0
	W+G8e/Ivs7FWI1rnapLnjT1EP40K030bOMRKbTz5dMTm8sOBQnMn6zRPh64XITN+0hDSBobMXuT
	SYugznF5GsmkfChrqEOgj41FMxf6jOJ4HzZ6N5ZEGfBD52nFooomwRamE8Dj7QJjz+AqjbhHrQG
	2sosDXiqkQd7wnQyV22kotTDhmVwWJbBqXfK/MFP+nHKB4K0FamvN3lhuiv5IUoWWXj8jr3SZwS
	VG1cZZ7wvDVM0I7KygZy1DVlm3w+DheKeZkjhTudV9weO81n3gl2uw==
X-Google-Smtp-Source: AGHT+IEzO0mC4OnT6RgW9PntmKKqSb17cY3i1o7rN5bpzi9gNoqcJYkhdowUZ3e7t8TGDEFO1GnSrQ==
X-Received: by 2002:a05:600c:1d8b:b0:439:3e90:c54b with SMTP id 5b1f17b1804b1-4393e90c744mr20049795e9.0.1739126080389;
        Sun, 09 Feb 2025 10:34:40 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94d7d4sm159407755e9.10.2025.02.09.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 10:34:39 -0800 (PST)
Date: Sun, 9 Feb 2025 18:34:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <kees@kernel.org>
Subject: Re: [PATCH 1/2] uaccess: Simplify code pattern for masked user
 copies
Message-ID: <20250209183437.340dcee6@pumpkin>
In-Reply-To: <CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
References: <20250209105600.3388-1-david.laight.linux@gmail.com>
	<20250209105600.3388-2-david.laight.linux@gmail.com>
	<CAHk-=wgu0B+9ZSmXaL6EyYQyDsWRGZv48jRGKJMphpO4bNiu_A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 09:40:05 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 9 Feb 2025 at 02:56, David Laight <david.laight.linux@gmail.com> wrote:
> >
> > Code can then be changed:
> > -               if (!user_read_access_begin(from, sizeof(*from)))
> > +               if (!masked_user_read_access_begin(&from, sizeof(*from)))
> >                         return -EFAULT;  
> 
> I really dislike the use of "pass pointer to simple variable you are
> going to change" interfaces which is why I didn't do it this way.

For real functions they do generate horrid code.
But since this is a define the *&from is optimised away.
Definitely better than just passing 'from' and having it unexpectedly
changed (why did C++ allow that one?).

> It's actually one of my least favorite parts of C - and one of the
> things that Rust got right - because the whole "error separate from
> return value" is such an important thing for graceful error handling.

Especially since the ABI almost always let a register pair be returned.
Shame it can't be used for anything other than double-length integers.

> And it's also why we use error pointers in the kernel: because I
> really *hated* all the cases where people were returning separate
> errors and results. The kernel error pointer thing may seem obvious
> and natural to people now, but it was a fairly big change at the time.

I've a lurking plan to change getsockopt() to return error/length and
move all the user copies into the syscall wrapper.
Made more complicated by code that wants to return an error and a length.
(They'll probably need packing into a single value that is negative - so
that the decode is in the slow path.)

> I'd actually much prefer the "goto efault" model that
> "unsafe_get/put_user()" uses than passing in the other return value
> with a pointer.
> 
> I wish we had a good error handling model.
> 
> Not the async crap that is exceptions with try/catch (or
> setjmp/longjmp - the horror). Just nice synchronous error handling
> that doesn't require the whole "hide return value as a in-out
> argument".
> 
> I know people think 'goto' and labels are bad. But I seriously think
> they are better and more legible constructs than the 'return value in
> arguments'.

I've had to fix some 'day-job' code which had repeated 'if (!error)'
clauses to avoid early return (never mind goto).
Typically at least one path got the error handling wrong.
At least explicit 'return error' or 'goto return_error' are easy
to validate.

> 
> Yes, you can make spaghetti code with goto and labels. But 'return
> value in arguments' is worse, because it makes the *data flow* harder
> to see.

Hidden returns are a real nightmare - you can't even guess whether any
locking (etc) is done.
At least hidden goto are visible.

Let me see if I can to a 'hidden goto' version.

	David

> 
>           Linus


