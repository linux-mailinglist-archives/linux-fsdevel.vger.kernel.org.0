Return-Path: <linux-fsdevel+bounces-56095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C6B12D1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 01:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3671D17CFE7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB8A230981;
	Sat, 26 Jul 2025 23:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YCpSn1le"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397622AE75
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573076; cv=none; b=CPjBAJtYm0Nf8W2+DA9MnLOeXogj7ba2L6i/ho3b8XVREUQbzxlxxQ9Ojv1MSnqUE4mmf+SGcF9+wXUJVleDuCiPAdUuuEZJ88f2EUgTnmTvqS8lSMA8/lNGxvZrn30JB0/5+vImZEtBW8zdNNFxjxSCLW7tdeVaKHyqxaCuTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573076; c=relaxed/simple;
	bh=7B24QJDsbG9O9xyrIOj7H/k5Wjt7NkdzQ2ZYcADPiko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaiqDbsve2TKSTDmusG3dKPj4x3CBffEno6W1drWtNxzjItHIw/R7zPyd6VPgaIVFZ0g0yiwQ6FHLlQHVDUR6SWkmkLaaY3SOJdRIMgdsss3IIV60683TzgcF9Abp0BY+wj+RlbFPwbSTleUS9J5yAZ1KQKQIKSx4ch0lKA2nQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YCpSn1le; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so5444096a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753573072; x=1754177872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=YCpSn1leoz8iY+M1vcgUvBZAhIM5A+TzG88DyCPofvwrQz37gx7TF+UOReUjPlrwZ+
         8NxkmnOjg4W5+g3RrUorRFQ974SK4fOQTxGdOTlp4MYQREzeI0+g1hgn3+nsgWl2tA9e
         X328Xr7ZhwkqdGRCPzUT7efqp/1HlPTs0z540=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753573072; x=1754177872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=pEv6gANxcA6TxcahKnT0sx5GmQGQwNiYkvMylbuSPalcxoMI6SNuC0G9BDQD57TeUQ
         WI2KehZlOU0wryfwHgWJab6dOwu6CUcafuWk+kJ9wRR5sFGMIqvqGP2ElVSHLNFFqaOq
         ZIgpwVh5oX9x57FIVMIVTYpKTVS8hnNDUg+W/f5+2ajY73vPmVtbgOhaT+VWgS7uUnR1
         773pwPTHuQc/luGTxFrOzPnB3w8rC/TcyFfo3XxfGcd+dVf5p7d+FmEfgt1hULPWx5ZY
         8ckhwaOT7y+9f93K1WXZnoSyE+lM7+RMVcMiQzUr35Y/lA2z5sS53HxoClMKTe1nH4nw
         RcGw==
X-Forwarded-Encrypted: i=1; AJvYcCVPRITFnWTw+LyipNZafjMcMazV1VDBzfcbSUSStr1EiRCeW8hDYmAaBbhsJ3gUP058RoRYqfPhtROrkX/h@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyEFlylu2xJQPspHNT9Tl9k9SqVSigMABUA1c//CHQvTqhssZ
	tbmtd9BaSwXStV0R642rP/K0oEFef9UJTPW8/Hgjz6Utj78GPEHt3qStA5jEvIP+krS043Wp1H3
	DQahmdAo0IA==
X-Gm-Gg: ASbGncuX0FTEnpEaZkQxyM/QoZqrRDQiGeRW7KGr+bIfYzzmFJcJUe8uDDa6ptuYwE8
	lQfMtgpj5GbLDZictPpl/j+wUPd51Rwouj1RakX+WuI8dk1KJkVd8mVRv6xGO8lU3D4Kqswj5Jq
	CJcJrkR6IYo2vBC+d/qeUJubPIOrS2fFCUbtNDWjPAkWgM1+CzDC4g3GroCWLprFZMOyHWlMJGg
	IURLJcsebIcju8jEvUp2ly2yhv6kjLsfQrx/Od0lnyt5SQneknQHviOwac9m3LxXkNYeBqiWJ8h
	wBqnHbO6+vtQ/efAryzqdpCvpEE2oewTG2/glccSw7h36Ld1bt4kFubHGdG0e6LW9Nrb+NUAEfw
	ATVRGfR4kS4n+X+NMy+qxzujye53LaM36DVYVCXVvcnbKCA5/J59H9IItROAzvKfw0oJGNjTD
X-Google-Smtp-Source: AGHT+IFwQh/papfWMSbC5HCyPrMriJPuAj+9REEZpa++6AHBCr3TF89ceObu4R9AI3m3nzRhW0/SdQ==
X-Received: by 2002:a05:6402:278c:b0:615:25e7:9783 with SMTP id 4fb4d7f45d1cf-61525e799f3mr844654a12.12.1753573072023;
        Sat, 26 Jul 2025 16:37:52 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615308a945esm96658a12.38.2025.07.26.16.37.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so4988428a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPBP8iN8NSzQhBLUsFv4JlOW6Pkz7MKG9xgIz1CPbt6Qzq1zesfQdTAr/qYZlxymf5W7yY7CAKXeRLb+5k@vger.kernel.org
X-Received: by 2002:a05:6402:483:b0:611:f4b2:379c with SMTP id
 4fb4d7f45d1cf-614f1dced8amr5514831a12.20.1753573070075; Sat, 26 Jul 2025
 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook> <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
 <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
In-Reply-To: <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 16:37:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwLhT2VoOEv9kNeOdgouvN4zZ9YLvHzVMPIsLMuRmQFnkSkLFn13r5tjO0
Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 16:19, Kees Cook <kees@kernel.org> wrote:
>
> That works for me! I just get twitchy around seeing memcpy used for strings. :) if we're gonna NUL after the memcpy, just use strscpy_pad().

I do worry a tiny bit about performance.

Because 'memcpy+set last byte to NUL' really is just a couple of
instructions when we're talking small constant-sized arrays.

strscpy_pad() isn't horrible, but it's still at another level. And
most of the cost is that "return the length" which people often don't
care about.

Dang, I wish we had some compiler trick to say "if the value isn't
used, do X, if it _is_ used do Y".

It's such a trivial thing in the compiler itself, and the information
is there, but I don't think it is exposed in any useful way.

In fact, it *is* exposed in one way I can think of:

   __attribute__((__warn_unused_result__))

but not in a useful form for actually generating different code.

Some kind of "__builtin_if_used(x,y)" where it picks 'x' if the value
is used, and 'y' if it isn't would be lovely for this.

Then you could do things like

    #define my_helper(x) \
        __builtin_if_used( \
                full_semantics(x), \
                simpler_version(x))

when having a return value means extra work and most people don't care.

Maybe it exists in some form that I haven't thought of?

Any compiler people around?

                 Linus

