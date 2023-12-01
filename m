Return-Path: <linux-fsdevel+bounces-4541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF58003F7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 07:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59279B20EA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 06:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA216E575
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OwCL54H8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC5D40
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 21:15:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bc7706520so2438064e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 21:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701407734; x=1702012534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5dinIoxlujtALpDGgIpx/RvOFCz/Yn1MlWegXqKVFc8=;
        b=OwCL54H8IQjDDxlcrwD6PaGHrxYa0TAv4ewp+FMv5oZuPvQW7yvamSqrJf7h8UaxUr
         jBAUhKVDP//ezYQDFoeV6JnXrz9BKQxAf642m7lZyuaazibV1rVVuZgD4Ye3rzu0dro5
         u0tGPEySkGlA+MZ2Vvdi9FO1mo3KL/VB+msBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701407734; x=1702012534;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dinIoxlujtALpDGgIpx/RvOFCz/Yn1MlWegXqKVFc8=;
        b=iwikxmFAs/1t+kxtBpPOEN2b+/9lP5ONGZU9BXZtRyHezkvThbSJpfr77Fzqj6gdZ0
         KOettOYd+shuhAXx6jMzO82uQqlE3IDI423PGW+ChhDEADd4U+4ommurtdqqxn3i4fQC
         vqoqPBRGep+AU5AJ04RMZB7WWtZ18wrxLa1rx0TWUswKuZrNPOucenlQqUVZJAWEgH+s
         VjJxDqILvkOJcGHYl/93fzFTr97GoyXr0ga7DRh7jsEEbOCfr7DjTFSWFfskuX+xGa2R
         zEWZ0JalPSNWdY4amNWm5mF24w+cn+9UQ+kUL+W3yu4QZxtAmoh+5fGbtioLwXXITubV
         aN9A==
X-Gm-Message-State: AOJu0YzfK4H0wysbosFZYNxMEsD/Y4faRg4lqmpR9YvBNBcLvSVRT7hk
	q96WwsWXK5YS0p5ledIfLcv6CkFJrVzgAeZSoCnWF4qT
X-Google-Smtp-Source: AGHT+IHYdA7Ro2NMgLtl2yJOYLFR3dZ4GW5cQPYBKgMhhrx58M6jcCVAWFnf+lKRRZ0ApLZJbVldGQ==
X-Received: by 2002:ac2:410d:0:b0:50b:c722:cff6 with SMTP id b13-20020ac2410d000000b0050bc722cff6mr349583lfi.19.1701407734116;
        Thu, 30 Nov 2023 21:15:34 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id g18-20020ac24d92000000b0050aaa64cd0dsm327696lfe.13.2023.11.30.21.15.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 21:15:33 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50bd8efb765so477292e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 21:15:33 -0800 (PST)
X-Received: by 2002:a05:6512:3b2:b0:50b:c88d:e861 with SMTP id
 v18-20020a05651203b200b0050bc88de861mr299687lfp.54.1701407733004; Thu, 30 Nov
 2023 21:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com> <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
 <ZWhdVpij9iCeMnog@gmail.com> <CAHk-=wgSsUKn0piCv_=7XZh6L07BNQHLH3CX1YUQ0G=MEpRSJA@mail.gmail.com>
 <ZWlUy1wElujRfDLA@gmail.com>
In-Reply-To: <ZWlUy1wElujRfDLA@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Dec 2023 14:15:15 +0900
X-Gmail-Original-Message-ID: <CAHk-=wgfcR+XQXhivpgFCzkOEvcgnMKOrOAeqGGD7hfksmM3ow@mail.gmail.com>
Message-ID: <CAHk-=wgfcR+XQXhivpgFCzkOEvcgnMKOrOAeqGGD7hfksmM3ow@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Dec 2023 at 12:36, Guo Ren <guoren@kernel.org> wrote:
>
> I modify your code to guarantee the progress of the comparison failure
> situation:

Are you sure you want to prefetch when the value doesn't even match
the existing value? Aren't you better off just looping doing just
reads until you at least have a valid value to exchange?

Otherwise you might easily find that your cmpxchg loops cause
horrendous cacheline ping-pong patterns.

Of course, if your hardware is bad at releasing the written state,
that may actually be what you want, to see changes in a timely manner.

At least some of our cmpxchg uses are the "try_cmpxchg()" pattern,
which wouldn't even loop - and won't write at all - on a value
mismatch.

And some of those try_cmpxchg cases are a lot more important than the
lockref code. Things like spin_trylock() etc. Of course, for best
results you might want to have an actual architecture-specific helper
for the try_cmpxchg case, and use the compiler for "outputs in
condition codes" (but then you need to have fallback cases for older
compilers that don't support it).

See the code code for example of the kinds of nasty support code you need with

  /*
   * Macros to generate condition code outputs from inline assembly,
   * The output operand must be type "bool".
   */
  #ifdef __GCC_ASM_FLAG_OUTPUTS__
  # define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
  # define CC_OUT(c) "=@cc" #c
  #else
  # define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
  # define CC_OUT(c) [_cc_ ## c] "=qm"
  #endif

and then a lot of "CC_SET()/CC_OUT()" use in the inline asms in
<asm/cmpxchg.h>...

IOW, you really should time this and then add the timing information
to whatever commit message.

             Linus

