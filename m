Return-Path: <linux-fsdevel+bounces-3862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2D7F94BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 18:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5521C20A8B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8861F9FD;
	Sun, 26 Nov 2023 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KSV3jOMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF6E6
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:59:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00a9d677fcso474891566b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701021571; x=1701626371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z2xP6y3s8sp1Ao1DyaX4PWlEZHiD1CxosZUk39uIt0=;
        b=KSV3jOMkmntzTzuwQYVTJIkQ1qqBG2M+4K17Qe0i9dW3QiK9wPJrk42nLMDyvU91Ws
         ZwKYaV1YGo9+mHIcpnWFl1wJfSZsfmkVs15Sd5tszq5P1joRwIHiyr02mvE+yXMFaSMj
         Uav59fU8PxzgNLC+iIy17d5RGqCOY6VmlydmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701021571; x=1701626371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z2xP6y3s8sp1Ao1DyaX4PWlEZHiD1CxosZUk39uIt0=;
        b=GQztwKTTGcrki22BeiZEuyVvDSlRHI20vJOqlaaY9Q8mir6UVJxsxb7jT91BA8/UI4
         gBTN2ZP4BM++WuEGhq8oab5EqOY5ISpLh7G6rbh2YLn+/YqjbF75gboTIUP0Fs9ctWcD
         ch2xAIPwjuXFp/93nEDeUoLpOlx0LZ05szbERmEQWdlLtWl98GYheNWv2GfpSb2ZwMJe
         Xtow1vf3uiThIKHDcwPXrJINgPSyVspdGXoz6nubX/cLMLRrg3hRFn6Ocj7jXbgLywae
         MvTs7KuKzZmqrOnYJcA6ddEyqSinkc63ekOSnvxMLvXd9WJj4KCsatopGCZufJw6txd6
         o7nA==
X-Gm-Message-State: AOJu0Yy4wDoXz3BlHDEDV2uM3IHZDs323cwMzPmVc3ObIRRtS1L6DSGm
	0qkQ1U7Vm8wC0h0Y8Xgq8S0XGlECNqpz9zotMpTVDcHD
X-Google-Smtp-Source: AGHT+IHsCO+d/98ghSZLGNkjKnWWtSPMIhYI6t/FT2EJjg/9lE8+F1vZ7j7cd+EH/dR6Y3ucemlZbw==
X-Received: by 2002:a17:906:6ad9:b0:9e6:4923:680a with SMTP id q25-20020a1709066ad900b009e64923680amr5960499ejs.3.1701021571260;
        Sun, 26 Nov 2023 09:59:31 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id n20-20020a170906089400b009e5e1710ae7sm4783203eje.191.2023.11.26.09.59.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 09:59:30 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a013d22effcso472435666b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Nov 2023 09:59:30 -0800 (PST)
X-Received: by 2002:a17:907:a0d6:b0:9fe:324b:f70a with SMTP id
 hw22-20020a170907a0d600b009fe324bf70amr7773178ejc.63.1701021569975; Sun, 26
 Nov 2023 09:59:29 -0800 (PST)
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
 <ZWN0ycxvzNzVXyNQ@gmail.com> <CAHk-=wjErxMmQaPqS8tVr=4ZqYcvs5Xw3yyBdAG1oO6KcwV0Vg@mail.gmail.com>
In-Reply-To: <CAHk-=wjErxMmQaPqS8tVr=4ZqYcvs5Xw3yyBdAG1oO6KcwV0Vg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 26 Nov 2023 09:59:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfmohtYBGBsGrUn_NcPXkcPrn2==zA=civ40Q=y0+n7g@mail.gmail.com>
Message-ID: <CAHk-=whfmohtYBGBsGrUn_NcPXkcPrn2==zA=civ40Q=y0+n7g@mail.gmail.com>
Subject: Re: lockless case of retain_dentry() (was Re: [PATCH 09/15] fold the
 call of retain_dentry() into fast_dput())
To: Guo Ren <guoren@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 Nov 2023 at 09:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In this case, the 'retry' count is actually a noticeable part of the
> code generation, and is probably also why it has to save/restore
> '%rbx'.

Nope. The reason for having to save/restore a register is the

        spin_lock(&lockref->lock);
        lockref->count++;

sequence: since spin_lock() is a function call, it will clobber all
the registers that a function can clobber, and the callee has to keep
the 'lockref' argument somewhere. So it needs a callee-saved register,
which it then itself needs to save.

Inlining the spinlock sequence entirely would fix it, but is the wrong
thing to do for the slow case.

Marking the spinlock functions with

  __attribute__((no_caller_saved_registers))

might actually be a reasonable option. It makes the spinlock itself
more expensive (since now it saves/restores all the registers it
uses), but in this case that's the right thing to do.

Of course, in this case, lockref has already done the optimistic
"check the lock" version, so our spinlock code that does that

        LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);

which first tries to do the trylock, is all kinds of wrong.

In a perfect world, the lockref code actually wants only the
slow-path, since it has already done the fast-path case. And it would
have that "slow path saves all registers" thing. That might be a good
idea for spinlocks in general, who knows..

Oh well. Probably not worth worrying about. In my profiles, lockref
looks pretty good even under heavy dentry load. Even if it's not
perfect.

                 Linus

