Return-Path: <linux-fsdevel+bounces-36214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51419DF73A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 22:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A969EB2132B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CB1D9329;
	Sun,  1 Dec 2024 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="L39OeohB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FD1D7E21
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Dec 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733089792; cv=none; b=DprvBEZyrpTB1RyA26l0MlIGk5ix8RMPKQgfAQAlwYFOIIT6LuE/E70CwKtC0Yl0iPuLtF2m2Kw8t+32XBkRt85fS/6PEY2wHkhC+SGwC9Pp1VouXW759yNoR4L4l54kD/w4s1yrCkEmndozZ+SsioqQ3McIVXPalReCcZcjr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733089792; c=relaxed/simple;
	bh=xXJPQ6YbYgc+LsntidKKs/X461vEK6auxVARRMkPIzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSSObRdxILo2vBwMnL1UmPfxXsJtqspS823k8WhuIYNPaOEiTVA/I7sxL+zdxwopluxwr+9G/NeKYiu5Ydpeen60mXDkcpX5BtnPGhWKyeylwsCW9hmgETSoGL/h3ZLBEnGxrzLY3rVUOAwS8Eg0fDTbQF8HfVvsFy3tcWci8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=L39OeohB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7256dc42176so398826b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733089790; x=1733694590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckF5QGnSsa0BB01QMlPw18K2Y6z5eE1xBtBTmSkmOrU=;
        b=L39OeohBrATyQzBYGf4B7mSuB61Oo0AczOununI4eMr8/Gj9jeHZBzWs1oNGBjKx+D
         ua80OZzaYqPz6BU8mNGMuySjhC4CSBohfAdtGmF8UWCn6Fx5dcvmc+bBCT70E+WGLCiH
         s3YOJs2DPvrTgCpbJwonNarS8FcZs+FUgL8/7/tGI6PcdGBz2n8N91qpcJvT8Ef6dyKb
         X3Eb0AOls8Ht5mMSgJxNqf0s0sEmO/WqMknhI866IgFD9pXnVemKaTsqqQ+a2MBUAKcF
         wl6fiGw5DQJ95TvmeZFRRqjoNEncPdB4E3ODCFY8dDbwn0ueD0nmc0QhKOhkUJ5pN4LT
         z7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733089790; x=1733694590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckF5QGnSsa0BB01QMlPw18K2Y6z5eE1xBtBTmSkmOrU=;
        b=KdAKn5eKNIZgv9DBaLakFKT3YL4w27xKwoUo7bVGDDChKPIoTRdOIHo4TwPHOoR0qo
         NC2793KtiWWRmVcSDQ5Lutarm7MSKlf113oQ9NlYlmKCSrQHCmcVCH7zJjV+6w5Qw0Zl
         mg0a2WbVUKnaGC9G6z13QEmJHJs6pBByyZpKDZlT7F7L1HtKBkHB7Ce+3sKSDWRAsCw2
         mZQM5OtiIrkpmlSFpNuhdCG3c+9DG8ddBNfCyH4xjqxt9hgFZv2C4WBb+0aedUF8dcAX
         WIYJ3INGVHHj5y0ECsCLFNTKk14QKiq5gl0itwOtRojyEgZiR1gUFaUgLebzU8WQTomx
         1UWw==
X-Forwarded-Encrypted: i=1; AJvYcCW3pSa2GHK/GjRivUjCCqSPuGtfdC4B3Ggq8dPkOLE91fmBzl4Q93UHnQsrx9c7A0CcosktZCaoCUx0UGfW@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQ1qtiDsKTbN5dQv+43k58dhj25ASDaXlJ/pIeKkDlw0Umils
	yXA/X2QT2TSF8xLoVOdtCYJdVBu8Hz3zp8KPjzeNSDJ3s0Q2drV0zzNaneJlOAKs5E2w/l4FAfY
	Y
X-Gm-Gg: ASbGncu04VtysfLVA00Z+s73+lGbQ7TvvdSx+yTciGTXWWMU4mGp6vC5flmENYIlqfK
	Bnm5uudeHMF9tMZ3ylRqgH6YNfW1KvDP1LCu0bT2Wfco48p8YLjiClF/SpaFhBhFao8r2ZBJMp8
	Fmf2GJK/np2Th92n09w8+KcmqegQSXEltEIrdFwW5IIGjBuEyaQkjfimz3hvZhP2jdw5PUoEkJ1
	Yn4utgsJgF2OnXX12Rt2evdkcZsZYtdQnXsgCEfZjdtSqU=
X-Google-Smtp-Source: AGHT+IEJ8i/d4RS5aNUgb0ZzcIBRhjMpR8RaWqdw3iTHbi813IFT7He4V5pwrlQ+TjGvCu78jA5zjQ==
X-Received: by 2002:a05:6a00:2381:b0:71e:5d1d:1aa2 with SMTP id d2e1a72fcca58-7253000347emr24970119b3a.7.1733089790310;
        Sun, 01 Dec 2024 13:49:50 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417725e9sm7069306b3a.80.2024.12.01.13.49.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 13:49:49 -0800 (PST)
Message-ID: <be3a3bd5-0991-480e-8190-010faa5b4727@kernel.dk>
Date: Sun, 1 Dec 2024 14:49:47 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chen Yu <yu.c.chen@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241130044909.work.541-kees@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241130044909.work.541-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:49 PM, Kees Cook wrote:
> Using strscpy() meant that the final character in task->comm may be
> non-NUL for a moment before the "string too long" truncation happens.
> 
> Instead of adding a new use of the ambiguous strncpy(), we'd want to
> use memtostr_pad() which enforces being able to check at compile time
> that sizes are sensible, but this requires being able to see string
> buffer lengths. Instead of trying to inline __set_task_comm() (which
> needs to call trace and perf functions), just open-code it. But to
> make sure we're always safe, add compile-time checking like we already
> do for get_task_comm().

In terms of the io_uring changes, both of those looks fine to me. Feel
free to bundle it with something else. If you're still changing things,
then I do prefer = { }; rather than no space...

-- 
Jens Axboe

