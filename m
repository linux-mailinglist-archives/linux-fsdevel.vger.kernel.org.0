Return-Path: <linux-fsdevel+bounces-854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A27D167B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 21:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9576A28265A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83D222332;
	Fri, 20 Oct 2023 19:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="alPPSER8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3E1802E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 19:44:18 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC896D52
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 12:44:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507be298d2aso1719368e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 12:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697831055; x=1698435855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NnnjNkqgXxS0pckrv1oPel8s8uR9/bn0uOyrsj0uCGA=;
        b=alPPSER8Jb2LCXXrEsza92LYG7E6LRL6g930ClGmnEP8DJqoLHc68UjXV0cJPK5UFZ
         krj8zljdzac/fY0EJNhVlNfTuOU0CQigJYvVdMSNgv+Xra9YVDD6ruWPiAyBXIvp0L3Z
         ol2srF1cYOmr/Hbc4TX0kkK55HxsHvfeR8L9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697831055; x=1698435855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnnjNkqgXxS0pckrv1oPel8s8uR9/bn0uOyrsj0uCGA=;
        b=QsNrGPdJ3DbfRhUbDG5d33BPmZMKNZ7wKSib3PXYIj25gQkumFQO+2/+pc7Nl5XxcS
         PGf/8g+d6GKZQGGvB8nG4NNnhYiD+05PYcETh62FbasdqAmTuBGEygkcQfHdu1q5PkNO
         +MZ9aNgaB0Y6mtZ0t8aeTdK9Xuo9+dKZ1N0Kdnfr59BheTv5wfJctQpRuxAhpT1qtHoe
         QLMazOalbkU03av6BHSvFYxVGZy2tKZyOlPtu/cuAaxVNOCmDekdTv4lR2EG7QG/+UlJ
         EivCtqdpyI2BQhUUz+6ig3AY3HNFtXl3N/kIjpb8xHUR5W5kqekYfi3TEDUutYU4ayqK
         Gf4A==
X-Gm-Message-State: AOJu0YzvP0VKwfhfau85kcMCUl6KaBHvCmp2XRYbdADNRNVxnh7hv+1a
	n58SXYCvQ9qTJT6hO9gUlB/OjyCLuL64AZ4kckMMLbft
X-Google-Smtp-Source: AGHT+IFsVkPx54kjzaC5huR1IT85OmQm8Y6Mqi2YXBg/6qdwS5eNLMJgxufUzjOcn9IsAQ15A0W8qQ==
X-Received: by 2002:ac2:52a2:0:b0:503:1c07:f7f9 with SMTP id r2-20020ac252a2000000b005031c07f7f9mr2060810lfm.29.1697831054691;
        Fri, 20 Oct 2023 12:44:14 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id l22-20020a50d6d6000000b005309eb7544fsm2053358edj.45.2023.10.20.12.44.14
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 12:44:14 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so1839613a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 12:44:14 -0700 (PDT)
X-Received: by 2002:a17:907:2d08:b0:9bf:d65d:dc0f with SMTP id
 gs8-20020a1709072d0800b009bfd65ddc0fmr1770580ejc.4.1697831053735; Fri, 20 Oct
 2023 12:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
 <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
In-Reply-To: <ZTLHBYv6wSUVD/DW@smile.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 12:43:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
Message-ID: <CAHk-=wgHFSTuANT3jXsw1EtzdHQe-XQtWQACzeFxn2BEBzX-gA@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Baokun Li <libaokun1@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 11:29, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> I'll reply to this with the attached object file, I assume it won't go to the
> mailing list, but should be available in your mailbox.

Honestly, both cases (that function gets inlined twice) look
*identical* from a quick look, apart from obviously the extra call to
__quota_error().

I might be missing something, but this most definitely is not a "gcc
ends up creating very different code when it doesn't need to
synchronize around the call" thing.

So a compiler issue looks very unlikely. No absolute guarantees - I
didn't do *that* kind of walk-through instruction by instruction - but
the results actually seem to line up perfectly.

Even register allocation didn't change, making the compare between #if
0 and without rather easy.

There's one extra spill/reload due to the call in the "non-#if0" case,
and that actually made me look twice (because it spilled %eax, and
then reloaded it as %rcx), but it turns that %eax/%ecx had the same
value at the time of the spill, so even that was not a "real"
difference.

So I will claim that no, it's not the compiler. It's some unrelated
subtle timing, or possibly just a random code layout issue (because
the code addresses do obviously change).

                    Linus

