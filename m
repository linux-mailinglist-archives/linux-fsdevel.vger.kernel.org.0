Return-Path: <linux-fsdevel+bounces-4532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF874800197
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 03:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE551C20B99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960C5380
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Gt8BCfjI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A4110D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 17:09:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a19067009d2so143331966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 17:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701392960; x=1701997760; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5lPIMPDp5ubpzZk1F6EzorrZLu4dln7zbimT4TRmdw=;
        b=Gt8BCfjIbPTg7tgv7veIVDLptEpBdl8jjnPBhR4tzQKrSW3djnmCMMlxmNQYoacIMO
         wwq448TG8wSUYPlUQrJpW3HVri5hCPfU6w5HYKTTzd+Co0PlEMz7GX90oGp7z8a6lzI9
         8DlgUkp0Lyp4KJTX87LcHdz/v/sfHO6pArgOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701392960; x=1701997760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5lPIMPDp5ubpzZk1F6EzorrZLu4dln7zbimT4TRmdw=;
        b=AlZE5s2SRYmuOHtOfU/P1rT67OOVnaN34Woo8E+Lf+K+UmPj8VI+OjJ+aOXRsD8Zii
         7ADuK8WBO6/CnYj+Xo5r8SGK5JrAy+Q5U+h/uz68eyZ6aYn4H/cy8qbhtJ9rkIP75wiE
         P54+hKKpfbY1D93Wtf93vzQuHOVrZaCykvH/FXqalqF/GW8XTpYOVabMJZ2VIbUWmzoa
         0iKG6hfVfGR7iliEAGU8Re1Lq/i8BQKGLdt6q9wxPvlnu1gXldYJxOaxxKzFurAnWDJS
         +PmsV/iFML/N+Gd3JWD0DSY/zdjyfNxbFAKbbwdu38FBxrKFEvW4CVkc9RL+ikiRsyL2
         c62w==
X-Gm-Message-State: AOJu0YzYA+WFQgQGwVfrhjRYBwQX8q0H1j9co3mq/XT5pdPDmsBh+53r
	QX36gwFg6MgtaBW1q1FUaIygoPqdHfKEzFeiPhfmNxwT
X-Google-Smtp-Source: AGHT+IFUT9WNNI+v6lNZLeC8H2Z3eqcxbdXBNpVqpMOwnjIvgRmaN66NwekOjPsn+2nAdLycW1DjwA==
X-Received: by 2002:a17:907:971d:b0:a19:85ae:e0c3 with SMTP id jg29-20020a170907971d00b00a1985aee0c3mr296010ejc.35.1701392959924;
        Thu, 30 Nov 2023 17:09:19 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id q20-20020a170906145400b009fc927023bcsm1288311ejc.34.2023.11.30.17.09.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 17:09:19 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so1791763a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 17:09:18 -0800 (PST)
X-Received: by 2002:a50:d60e:0:b0:54c:4837:759d with SMTP id
 x14-20020a50d60e000000b0054c4837759dmr314091edi.73.1701392958589; Thu, 30 Nov
 2023 17:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV> <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com> <CAHk-=wiehwt_aYcmAyZXyM7LWbXsne6+JWqLkMtnv=4CJT1gwQ@mail.gmail.com>
 <ZWhdVpij9iCeMnog@gmail.com>
In-Reply-To: <ZWhdVpij9iCeMnog@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Dec 2023 10:09:01 +0900
X-Gmail-Original-Message-ID: <CAHk-=wgSsUKn0piCv_=7XZh6L07BNQHLH3CX1YUQ0G=MEpRSJA@mail.gmail.com>
Message-ID: <CAHk-=wgSsUKn0piCv_=7XZh6L07BNQHLH3CX1YUQ0G=MEpRSJA@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Nov 2023 at 19:01, Guo Ren <guoren@kernel.org> wrote:
>
> That needs the expensive mechanism DynAMO [1], but some power-efficient
> core lacks the capability. Yes, powerful OoO hardware could virtually
> satisfy you by a minimum number of retries, but why couldn't we
> explicitly tell hardware for "prefetchw"?

Because every single time we've had a prefetch in the kernel, it has
caused problems. A bit like cpu_relax() - these things get added for
random hardware where it helps, and then a few years later it turns
out that it hurts almost everywhere else.

We've had particular problems with 'prefetch' because it turns out
that (a) nobody sane uses them so (b) hardware is often buggy. And
here "buggy" may be just performance (ie "prefetch actually stalls on
TLB lookup" etc broken behavior that means that prefetch is not even
remotely like a no-op that just hints to the cache subsystem), but
sometimes even in actual semantics (ie "prefetch causes spurious
faulting behavior")

> Advanced hardware would treat cmpxchg as interconnect transactions when
> cache miss(far atomic), which means L3 cache wouldn't return a unique
> cacheline even when cmpxchg fails. The cmpxchg loop would continue to
> read data bypassing the L1/L2 cache, which means every failure cmpxchg
> is a cache-miss read.

Honestly, I wouldn't call that "advanced hardware". I would call that
ridiculous.

If the cmpxchg isn't guaranteed to make progress, then the cmpxchg is
broken. It's really that simple.

It does sound like on your hardware, maybe you just want to make the
RISC-V cmpxchg function always do a "prefetchw" if the 'sc.d' fails,
something like

                        "0:     lr.w %0, %2\n"                          \
                        "       bne  %0, %z3, 1f\n"                     \
                        "       sc.w %1, %z4, %2\n"                     \
-                       "       bnez %1, 0b\n"                          \
+                       "       beqz %1, 1f\n"                          \
+                       "       prefetchw %2\n"                         \
+                       "       j 0b\n"                                 \
                        "1:\n"                                          \

(quick entirely untested hack, you get the idea). A better
implementation might use "asm goto" and expose the different error
cases to the compiler so that it can move things around, but I'm not
convinced it's worth the effort.

But no, we're *not* adding a prefetchw to generic code just because
apparently some RISC-V code is doing bad things. You need to keep
workarounds for RISC-V behavior to RISC-V.

And yes, the current "retry count" in our lockref implementation comes
from another "some hardware does bad things for cmpxchg". But that
workaround at most causes a few extra (regular) ALU instructions, and
while not optimal, it's at least not going to cause any bigger
problems.

           Linus

