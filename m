Return-Path: <linux-fsdevel+bounces-3861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23957F9466
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 18:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52948281089
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 17:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775ADDD8;
	Sun, 26 Nov 2023 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H0FgvpA9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B99FB
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:06:23 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548d60a4d60so4601243a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701018382; x=1701623182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnRXw7N9JGpw9rc7uqJHAThmRceM+sopTJkurxC/YfM=;
        b=H0FgvpA92+9RutJaHA7FeTVUL72fL5T0ruETGesPwKSuIJ7lGG/Q5rsxG8EYeBt55B
         a4LJFf3j03iyLT6DjzWjRAzOG5l9sH5yqugIC5/dnzAcyaHYelTHGsO5/xJJgOwd0in/
         RmzRILipfp/ruiGIuNt50OSP0xSW2syME+C2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701018382; x=1701623182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnRXw7N9JGpw9rc7uqJHAThmRceM+sopTJkurxC/YfM=;
        b=tuFph2uhBLfiRF/TD1wrEi/S8ZNDeztTHj73quHNfzxJ4gxfUkJVpp4gjbrhyUyHiE
         /H1PUK2/5vwXC1WiQ9MjLAlNj3G2k/L/BSgWyHiyf2CKFtshDOVVorR3R+XlBeHHKf9L
         6RuBXTh6hqc4U0acDy9ko79M5PI6yVJPrqe+3rnEAS2ZtOemfPMuYTg2mfN6a5uMMI4T
         gDv3i5F9jEmYlrdP82/RIcAgqnqZ5BSVx/5jsgi+eynSi3amikVwvXMEyegWZR99VIQK
         6z/cFOSSZQJS8RbDsJ3hyEKg2XTdGP+vs88SLTje6efEFpkYHMQInOA5GOW9+GMfkzEt
         gBlA==
X-Gm-Message-State: AOJu0YwLFzy+jDovBUxLWg1QDjdFyNiHSAng43wHLl5Wa+BmEd9SK39R
	YaT60kGN8Tmyqj8MhvHvhkD20C16eXZSkopxH/l9F8wD
X-Google-Smtp-Source: AGHT+IFmdS0zHFfYQoT1dFjav4HglyV96fQmT1ggLi+M+DwBY1BNENoELzMcVYItmyCWC9xnaW1YuQ==
X-Received: by 2002:aa7:cb56:0:b0:54b:1361:701 with SMTP id w22-20020aa7cb56000000b0054b13610701mr5324580edt.10.1701018382053;
        Sun, 26 Nov 2023 09:06:22 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id cm26-20020a0564020c9a00b0054ae75dcd6bsm3531901edb.95.2023.11.26.09.06.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 09:06:21 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a00cbb83c82so494379566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:06:21 -0800 (PST)
X-Received: by 2002:a17:906:eb17:b0:a03:6fd8:f14b with SMTP id
 mb23-20020a170906eb1700b00a036fd8f14bmr6682602ejb.28.1701018380691; Sun, 26
 Nov 2023 09:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031061226.GC1957730@ZenIV> <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk> <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
 <20231101181910.GH1957730@ZenIV> <20231110042041.GL1957730@ZenIV>
 <CAHk-=wgaLBRwPE0_VfxOrCzFsHgV-pR35=7V3K=EHOJV36vaPQ@mail.gmail.com>
 <ZV2rdE1XQWwJ7s75@gmail.com> <CAHk-=wj5pRLTd8i-2W2xyUi4HDDcRuKfqZDs=Fem9n5BLw4bsw@mail.gmail.com>
 <ZWN0ycxvzNzVXyNQ@gmail.com>
In-Reply-To: <ZWN0ycxvzNzVXyNQ@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Nov 2023 09:06:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjErxMmQaPqS8tVr=4ZqYcvs5Xw3yyBdAG1oO6KcwV0Vg@mail.gmail.com>
Message-ID: <CAHk-=wjErxMmQaPqS8tVr=4ZqYcvs5Xw3yyBdAG1oO6KcwV0Vg@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Nov 2023 at 08:39, Guo Ren <guoren@kernel.org> wrote:
>
> Here, what I want to improve is to prevent stack frame setup in the fast
> path, and that's the most benefit my patch could give out.

Side note: what patch do you have that avoids the stack frame setup?
Because I still saw the stack frame even with the
arch_spin_value_unlocked() fix and the improved code generation. The
compiler still does

        addi    sp,sp,-32
        sd      s0,16(sp)
        sd      s1,8(sp)
        sd      ra,24(sp)
        addi    s0,sp,32

at the top of the function for me - not because of the (now fixed)
lock value spilling, but just because it wants to save registers.

The reason seems to be that gcc isn't smart enough to delay the frame
setup to the slow path where it then has to do the actual spinlock, so
it has to generate a stack frame just for the return address and then
it does the whole frame setup thing.

I was using just the risc-v defconfig (with the cmpxchg lockrefs
enabled, and spinlock debugging disabled so that lockrefs actually do
something), so there might be some other config thing like "force
frame pointers" that then causes problems.

But while the current tree avoids the silly lock value spill and
reload, and my patch improved the integer instruction selection, I
really couldn't get rid of the stack frame entirely. The x86 code also
ends up looking quite nice, although part of that is that the
qspinlock test is a simple compare against zero:

  lockref_get:
        pushq   %rbx
        movq    %rdi, %rbx
        movq    (%rdi), %rax
        movl    $-100, %ecx
        movabsq $4294967296, %rdx
  .LBB0_1:
        testl   %eax, %eax
        jne     .LBB0_4
        leaq    (%rax,%rdx), %rsi
        lock
        cmpxchgq        %rsi, (%rbx)
        je      .LBB0_5
        incl    %ecx
        jne     .LBB0_1
  .LBB0_4:
        movq    %rbx, %rdi
        callq   _raw_spin_lock
        incl    4(%rbx)
        movb    $0, (%rbx)
  .LBB0_5:
        popq    %rbx
        retq

(That 'movabsq' thing is what generates the big constant that adds '1'
in the upper word - that add is then done as a 'leaq').

In this case, the 'retry' count is actually a noticeable part of the
code generation, and is probably also why it has to save/restore
'%rbx'. Oh well. We limited the cmpxchg loop because of horrible
issues with starvation on bad arm64 cores.  It turns out that SMP
cacheline bouncing is hard, and if you haven't been doing it for a
couple of decades, you'll do it wrong.

You'll find out the hard way that the same is probably true on any
early RISC-V SMP setups. You wanting to use prefetchw is a pretty
clear indication of the same kind of thing.

             Linus

