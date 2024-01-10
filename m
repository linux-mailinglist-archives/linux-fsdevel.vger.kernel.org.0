Return-Path: <linux-fsdevel+bounces-7756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586B82A511
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 00:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F021C22F83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48984F8B1;
	Wed, 10 Jan 2024 23:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e520My48"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C44F8A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4414ec9c7so24075365ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704930524; x=1705535324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SwuTP7EzLEPd51rCmWc5l3FryuUpUIDaJ3oLG7EKxvs=;
        b=e520My48wrc6W1VBmjEKzXuD1l4aGEQr9pEN9UAoEUhQd/QUYuqS44jBW1Zw8B7Vwn
         rrGjOu7rPy2Wuan6f9O5ksZVKuA6URdB0/bxh/IavXl5ikWeLH0TmAyCUV9KNYOG23Tm
         fqS/uKRfi0lqWFMNaWxyrTbKEOGG3RQ9v03gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704930524; x=1705535324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwuTP7EzLEPd51rCmWc5l3FryuUpUIDaJ3oLG7EKxvs=;
        b=aRH8KCuzZ33ngBzcgnj98aZOq/JV/Zj0jkwlNlKugMzX5bpRyFcbu8+A1lqD9xAxFF
         0RQk0s5DTwHQFpX+uQw7xHXMe5pQmqAG8QetLB/cHFqfsiojanvQjxNRBxxSGUNLCQUS
         yCjHmHlEb8eJRhxr5OkzYDji47hsC2K1AO3/lAKJ9YT+TEIwowY/NKh7bTYftpnqVZnA
         kT6vt6/UOFPSJN/lizT1ihJ6emvt1mxL7AT3O+B4eQ3aDlqvCtewHVRW94Tobky4QX9c
         vQu46AoawgTqXaJ6X28hpcaixjCdxbg/t1DF32yRG6UlsCi7ixG8uSmPq3NmLm4NZvIF
         FqBQ==
X-Gm-Message-State: AOJu0Ywbrr3DpxEOdjcEz7isfK+HFgzz4JbQjAJMAZuwe9ZKiXnOqDeW
	0omhI2vIsWfrHBftN8yozVG4AZix87KgDFo57Z1fDpoaP1g3
X-Google-Smtp-Source: AGHT+IF8fgccVOtXqOEaJFh9qZqdhLe5dF5tch6GtJyBls2H2Ztl8x5oLrB9yayQo3OC6NpC/wcPaA==
X-Received: by 2002:a17:902:e80d:b0:1d4:f114:62c4 with SMTP id u13-20020a170902e80d00b001d4f11462c4mr399322plg.86.1704930524297;
        Wed, 10 Jan 2024 15:48:44 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902ab8c00b001d3bf27000csm4210321plr.293.2024.01.10.15.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 15:48:43 -0800 (PST)
Date: Wed, 10 Jan 2024 15:48:43 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <202401101525.112E8234@keescook>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>

On Wed, Jan 10, 2024 at 02:36:30PM -0500, Kent Overstreet wrote:
> [...]
>       bcachefs: %pg is banished

Hi!

Not a PR blocker, but this patch re-introduces users of strlcpy() which
has been otherwise removed this cycle. I'll send a patch to replace
these new uses, but process-wise, I'd like check on how bcachefs patches
are reviewed.

Normally I'd go find the original email that posted the patch and reply
there, but I couldn't find a development list where this patch was
posted. Where is this happening? (Being posted somewhere is supposed
to be a prerequisite for living in -next. E.g. quoting from the -next
inclusion boiler-plate: "* posted to the relevant mailing list,") It
looks like it was authored 5 days ago, which is cutting it awfully close
to the merge window opening:

	AuthorDate: Fri Jan 5 11:58:50 2024 -0500

Actually, it looks like you rebased onto v6.7-rc7? This is normally
strongly discouraged. The common merge base is -rc2.

It also seems it didn't get a run through scripts/checkpatch.pl, which
shows 4 warnings, 2 or which point out the strlcpy deprecation:

WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
#123: FILE: fs/bcachefs/super.c:1389:
+               strlcpy(c->name, name.buf, sizeof(c->name));

WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
#124: FILE: fs/bcachefs/super.c:1390:
+       strlcpy(ca->name, name.buf, sizeof(ca->name));

Please make sure you're running checkpatch.pl -- it'll make integration,
technical debt reduction, and coding style adjustments much easier. :)

Thanks!

-Kees

-- 
Kees Cook

