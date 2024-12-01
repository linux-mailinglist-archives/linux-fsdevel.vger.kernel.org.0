Return-Path: <linux-fsdevel+bounces-36213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F334D9DF713
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F645B215BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABE41D90CD;
	Sun,  1 Dec 2024 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SwJotehU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED341D86C3
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Dec 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733084630; cv=none; b=oG1+R9NlSZEoOx38LQygk65RLWWDeJQHqjqxeJ088cIuNiZXsrGWdz2tilXfrPzfaAyc9rBUtR7zuZS2ZCa4OuMZddYaDhMFsthTo41Qg2LD0Q1PBzmYUe7zUqvL0w3jgm9yRfnmru+wD2gm9K/XxP7rEZ2ZzjJRqW5xcfTErv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733084630; c=relaxed/simple;
	bh=4xGNzN9Wp70Q9GgcCs1b92wuOYHLnPfSc5E75h7FS04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBA0z7J7gfCN4Lyec67mS+Fo79k4Qu+t8Yhr9+KIanuBiyqLU4To8z8R36l8pCf3AO0UYJUq6sqdpvf5YwQ5WEgaDXiPGjWjNSmaEnkz+yEiC2ZKBxcPspL9x1HZkos/GuZQL30uL5heuC+4nFyI9v+cNM2ukXbWW92jGFB9DSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SwJotehU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0c8ba475bso2044157a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733084627; x=1733689427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0PBRuUNrVMG3jWkuVgZ+alnShpvbiX+xpV3R8jGwMw=;
        b=SwJotehUo7tgTiDD3jJ6uEyXPyF0+fo2O0fv5nx0TvQp3LH4IOXDHDdxlDrlTsSq3M
         FZocGm3vD5cXk9uu3iMTpOl3w+Q/QDnOr2VSaHX2qJW/6+7FHGOr03YKQ6Jq/xQ96cHM
         lvb68nEI0gIH/pfPJ5zJcBxrfli/AJLjb/RSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733084627; x=1733689427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0PBRuUNrVMG3jWkuVgZ+alnShpvbiX+xpV3R8jGwMw=;
        b=vapnyAf/xiKgwXiVkKmBYqAhE3TO7sW+pEF7SUUYvkBk01IwGuSZoLV/aI8ZKmhiZX
         OLYkWgoF4ROK5f8TRhM3K8gwpIGz/bNlLr8PqrklIPj+8kCK6yhJp3vsr0ovtZPpM1N0
         Y/AGpvcMgjq10Bnv5bRWbF0X1F4vNUT0vIQYUWNJf1rfFq3w9HA6KCDy+iqK+hmdc0h8
         i9CTwEWhU7I1W/j0IILolC3d0ccRXJGhg8EP/T84ZkpDyDEffOC3JDe84V+w7euqMDmQ
         HWY6lQFeVCZQolgAxleGo//c+fKsBhah1EcI2TYk153+9j/0pVeweDxrrSPVV9XJjXeV
         VodA==
X-Forwarded-Encrypted: i=1; AJvYcCXK2gr5EXJdh5NV83VZF3EbeF0mWaYcTPI6GUU2b++Q6oye2Z0GbICX9REl7O9juvxtqp/H1UZWKy3r+gs4@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYNsCbaDJFW6UK/oTKS5hXgOUj70YUibiRirHbwXHwFMNFgaF
	t/0MpYuqlNELa0kjQMK9Ro9GtQmZ2MOrJypTerGd+NSJcgRG6U06zH2ePsorg65GjGvkppC1RrS
	FVUAImA==
X-Gm-Gg: ASbGncvdOFNIbVAR1859iR80PQ1/z3KoHdPPMtL69xc+txM+PY6WGuHCyS2R4DGfp68
	LFvxSKR84bNLsW1Wmxi7wnyPRyDUBWl+4Yu0o+MX8l2mC1qtaTWGvxmYX+i2IEnzPAhivku2Uff
	06qmDApmEnxENa+I7CQwCWMorjXygE1vKAwZyxsjASOCZLLK6HsHSojTAvdeD6NJy4G/djQlvx/
	xi4SVFLHdHb3bQpyVqOmOXWfMCoMRZZDkP1eBc9AE5RVU68scjLayLVISLKc6zKNrrIKOx4BdRD
	x2leYOFCb02n6hqSAAvwh/6N
X-Google-Smtp-Source: AGHT+IHH9yhWXbIkZl78DfAcUOwt4jHgPKsdQj4YTarf3XmJISs7AIerPC/P0xxy0cDh6SdCiOdZ+g==
X-Received: by 2002:a05:6402:3219:b0:5d0:b74f:6422 with SMTP id 4fb4d7f45d1cf-5d0b74f66b8mr13166672a12.32.1733084626934;
        Sun, 01 Dec 2024 12:23:46 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097db0bbesm4169894a12.29.2024.12.01.12.23.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 12:23:44 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso599061866b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Dec 2024 12:23:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXF9XSscz4R09q8h+p7Q9ITe1VQvHhdM091Q7XYsYq+Y1wG9vrmg63IPDYH/Mrb7IDUe1JhYcNh26t0WZvB@vger.kernel.org
X-Received: by 2002:a17:906:3090:b0:aa5:1585:ef33 with SMTP id
 a640c23a62f3a-aa580f1ae0emr1684398666b.23.1733084623092; Sun, 01 Dec 2024
 12:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130044909.work.541-kees@kernel.org> <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
In-Reply-To: <CAHk-=wjAmu9OBS--RwB+HQn4nhUku=7ECOnSRP8JG0oRU97-kA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Dec 2024 12:23:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGWbU-MpmrXnHdqey5kDkyXnPxQ-ZsGVGBkZQ5d5g0mw@mail.gmail.com>
Message-ID: <CAHk-=wiGWbU-MpmrXnHdqey5kDkyXnPxQ-ZsGVGBkZQ5d5g0mw@mail.gmail.com>
Subject: Re: [PATCH] exec: Make sure task->comm is always NUL-terminated
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Yu <yu.c.chen@intel.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 23:15, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yes, we could make the word-at-a-time case also know about masking
> the last word, but it's kind of annoying and depends on byte ordering.

Actually, it turned out to be really trivial to do. It does depend on
byte order, but not in a very complex way.

Also, doing the memory accesses with READ_ONCE() might be good for
clarity, but it makes gcc have conniptions and makes the code
generation noticeably worse.

I'm not sure why, but gcc stops doing address generation in the memory
instruction for volatile accesses. I've seen that before, but
completely forgot about how odd the code generation becomes.

This actually generates quite good code - apart from the later
'memset()' by strscpy_pad().  Kind of sad, since the word-at-a-time
code by 'strscpy()' actually handles comm[] really well (the buffer is
a nice multiple of the word length), and extending it to padding would
be trivial.

The whole sized_strscpy_pad() macro is in fact all kinds of stupid. It does

        __wrote = sized_strscpy(__dst, __src, __count);
        if (__wrote >= 0 && __wrote < __count)

and that '__wrote' name is actively misleading, and the "__wrote <
__count" test is pointless.

The underlying sized_strscpy() function doesn't return how many
characters it wrote, it returns the length of the resulting string (or
error if it truncated it), so the return value is *always* smaller
than __count.

That's the whole point of the function, after all.

Oh well. I'll just commit my strscpy() improvement as a fix.

And I'll think about how to do the "pad" version better too. Just because.

                Linus

