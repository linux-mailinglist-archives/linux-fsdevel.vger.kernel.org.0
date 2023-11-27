Return-Path: <linux-fsdevel+bounces-3963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD127FA7BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7381C20DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720A1374CD;
	Mon, 27 Nov 2023 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BfI81Rvz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F01BC9
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 09:11:15 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00f67f120aso613032966b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701105074; x=1701709874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8veV/N8u0KLOX8kp8+RpeOybN7ghMV50gJ3VwXOlp8=;
        b=BfI81Rvznm8Do/hJUIsxE+q6jEWIYdaL6U+k+y2wB1CBwU2rUBCnXPtT/blCaomi9A
         ZSxChLlpPEniPQ+l4y8dO8gHr314XZjuD2AT3aARPp31B25Z6j1EIQXkH10c1Dc2mzuK
         ftAkaCMtGEpsPU0gxKUFqwf10ASgs+PkPqoK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105074; x=1701709874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8veV/N8u0KLOX8kp8+RpeOybN7ghMV50gJ3VwXOlp8=;
        b=Lx4W1nhsQloOhXhwtmlvl+1q2+kkgZHeuLjTWcR2NfvRWfsf4K/4OLw5GKtszVjVvI
         RB8vDj2rOAWPyfj4sZoXSGQlevp5ycZK8QOZrtfPap0K39+BCAcUpPZtKH9ZbdD7+EX2
         QSWhtWSHCFrFB0/ncyr1pkMajGg0JwZgH+j9Koeq9TktLkgeVsv8h1EVCVNjYuVhIVY7
         xtWGKwctL7cfahlMwrAK8cTOgTsmFi3ysTQJ+blPvAMnERhq4NpEh3LcbHpRzpc9+vVr
         KEOE9GjyIK0z19g2nqzoEkWV/woKFaFD6yYqNre39VBJAdkp2jvqt+ARRIOPDtgidvXw
         +EGQ==
X-Gm-Message-State: AOJu0Yzoalpto8/iNc/32pHrCpAFD/E4vL/51rMeqmcKhxS1ad4dtfQl
	jUvaKWPpqnlcp3ZEjWnPYjrwX3orE9BSUgLwlz9dXg==
X-Google-Smtp-Source: AGHT+IHh0PZqO4hg/kttAEqOTHFQ0mR+yinVd6uH82goFLhg9WR+xIP0JdNGGOvPIJVKBr5BvwSg4w==
X-Received: by 2002:a17:906:d3:b0:9c4:54c6:8030 with SMTP id 19-20020a17090600d300b009c454c68030mr9380870eji.6.1701105073849;
        Mon, 27 Nov 2023 09:11:13 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id rv24-20020a17090710d800b00a0958af2387sm4510633ejb.201.2023.11.27.09.11.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:11:12 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54a95657df3so6364454a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Nov 2023 09:11:11 -0800 (PST)
X-Received: by 2002:a50:d4c5:0:b0:53e:1b:15f5 with SMTP id e5-20020a50d4c5000000b0053e001b15f5mr7964361edj.39.1701105070828;
 Mon, 27 Nov 2023 09:11:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202311201406.2022ca3f-oliver.sang@intel.com> <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com> <20231127-kirschen-dissens-b511900fa85a@brauner>
In-Reply-To: <20231127-kirschen-dissens-b511900fa85a@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Nov 2023 09:10:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
Message-ID: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
To: Christian Brauner <brauner@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, bpf@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Nov 2023 at 02:27, Christian Brauner <brauner@kernel.org> wrote:
>
> So I've picked up your patch (vfs.misc). It's clever alright so thanks
> for the comments in there otherwise I would've stared at this for far
> too long.

Note that I should probably have commented on one other thing: that
whole "just load from fd[0] is always safe, because the fd[] array
always exists".

IOW, that whole "load and mask" thing only works when you know the
array exists at all.

Doing that "just mask the index" wouldn't be valid if "size = 0" is an
option and might mean that we don't have an array at all (ie if "->fd"
itself could be NULL.

But we never have a completely empty file descriptor array, and
fdp->fd is never NULL.  At a minimum 'max_fds' is NR_OPEN_DEFAULT.

(The whole 'tsk->files' could be NULL, but only for kernel threads or
when exiting, so fget_task() will check for *that*, but it's a
separate thing)

So that's why it's safe to *entirely* remove the whole

                if (unlikely(fd >= fdt->max_fds))

test, and do it *all* with just "mask the index, and mask the resulting load".

Because we can *always* do that load at "fdt->fd[0]", and we want to
check the result for NULL anyway, so the "mask at the end and check
for NULL" is both natural and generates very good code.

Anyway, not a big deal, bit it might be worth noting before somebody
tries the same trick on some other array that *could* be zero-sized
and with a NULL base pointer, and where that 'array[0]' access isn't
necessarily guaranteed to be ok.

> It's a little unpleasant because of the cast-orama going on before we
> check the file pointer but I don't see that it's in any way wrong.

In my cleanup phase - which was a bit messy - I did wonder if I should
have some helper for it, since it shows up in both __fget_files_rcu()
and in files_lookup_fd_raw().

So I *could* have tried to add something like a
"masked_rcu_dereference()" that took the base pointer, the index, and
the mask, and did that whole dance.

Or I could have had just a "mask_pointer()" function, which we do
occasionally do in other places too (ie we hide data in low bits, and
then we mask them away when the pointer is used as a pointer).

But with only two users, it seemed to add more conceptual complexity
than it's worth, and I was not convinced that we'd want to expose that
pattern and have others use it.

So having a helper might clarify things, but it might also encourage
wrong users. I dunno.

I suspect the only real use for this ends up being this very special
"access the fdt->fd[] array using a file descriptor".

Anyway, that's why I largely just did it with comments, and commented
both places - and just kept the cast there in the open.

             Linus

