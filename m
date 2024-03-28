Return-Path: <linux-fsdevel+bounces-15529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 647CD890176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A7C295B3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 14:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948785649;
	Thu, 28 Mar 2024 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTqhU7ta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1E823CB
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635421; cv=none; b=SUziblwGYcFljF1myc9bm0Fj3dv5N/HjFE20L+n20nc8kZPFeEWCgZWZXSxJUuk0UuFACrvLVfuCPA4Wdy6GJmoWf7jS3oby3C3vcrDwP/YuEYJHXU6HYkxHYwhO8wc7uj8b7hYuhDDuLtMx6vW9YmF5LhS+hEPgro3NHOGKnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635421; c=relaxed/simple;
	bh=h4pyAfpzD/813Nb4OhgzyPI/dG83mPiaUM72PzINltY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VinM+X6Hz81QPvgVibpbjJgouvZ7wwFGdA4DC7MmMFOq2sZcYFR67nA0e50qrWYMfKS1zivHIp2fokDwo71tNG08lz1g85rZfpckDGtnOT+gtAPBu8jejL9yx7820rMMmcmo9kSy5+NPi17qF4RJdDYTHE/ND4xdId4gVfbWM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZTqhU7ta; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-430b6ff2a20so5224121cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711635416; x=1712240216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZkkr+8BMbOQbcHkSO5h3H5iApjHoCs8BFl7+oRwVKE=;
        b=ZTqhU7taE9TJG0V1OqqYvhR0V36qUmxz2tcp3njs4maoFv6WQir3mUaAoDRk+7HsUZ
         BWzGGy8yeeri4CBh8NaJBh5chrVNJ6qHdktBX+k4IqNuViALGIIdw2qJM17ggCHEZUfl
         IMgfQgtskAKt3tCUKJGWNnomlty4HzoSJ1FSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635416; x=1712240216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZkkr+8BMbOQbcHkSO5h3H5iApjHoCs8BFl7+oRwVKE=;
        b=nCuLBGLQhkj/eSWtfkZYbKCaLyYZHpj61NW0WYmEJ4O6jD1A2eedpEilsMMftpiPqG
         geky6q2Y0/q2GdjqZSv4ICsAwE9VMUUgYhpeANpsnkOpRF+f5pOeG3Fe7d00rETeprCB
         90qb//xg1jPms574PFMYEOWwgL9AX7frPe7udWmm4omVv3ZL6xrZf860z6YosKorb9UM
         Lo/rTK3Gw86bKyXB29bsCeELrOTt7j+iiOMptqin0stBFlcbNvOgO6sFhhn2O6LKkfGe
         0VfuXznQA373SMb3m8pZA7mUQeqp1dqKe9K8d0nx9D6/fDegKgjGmx7SDcujMfijSpsK
         AmSA==
X-Forwarded-Encrypted: i=1; AJvYcCWfpER0PQ5oax/faBHiLUhBDXbU+ZnY4CrP4BgCORMLHcvhOzHpm6FHQskYM3XJ79Hl1GW4feM+oDGPfgSIwXtXbu5CAcEnOVkt54mPYQ==
X-Gm-Message-State: AOJu0YyQwXIxhmlZ9TVqbHg9NHBA9GLCISp/vvOZvPDggJgE36Z1hERU
	p3ysgUEO0s5y4XyfOUHAUIzF4WKFsoCa2lin2L6feRzKLyF+1kDUef5gDCutviHUE5C+3HG+WgU
	=
X-Google-Smtp-Source: AGHT+IHvIvpQH023DQlJNhERG0KS+WSMRPF7Dx/Jtt0sJUyJ26DwFl6lmAuqxE5Inkyy3uORNL/eaA==
X-Received: by 2002:ad4:4f2c:0:b0:696:ae24:f132 with SMTP id fc12-20020ad44f2c000000b00696ae24f132mr2645968qvb.1.1711635415662;
        Thu, 28 Mar 2024 07:16:55 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b006906adc8aa2sm668758qvb.102.2024.03.28.07.16.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:16:54 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42ee0c326e8so220951cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 07:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX20yyBwu/7EtgOAPuYbcQp6JS9o5nQW5DEg4apvHyZRqGlgFTFMB48aXdFJ98MMMP3ytzriKijRVaDNNArjlZhxu1THILxQsWD1GiMFQ==
X-Received: by 2002:a05:622a:608d:b0:431:6352:80fb with SMTP id
 hf13-20020a05622a608d00b00431635280fbmr244987qtb.16.1711635413584; Thu, 28
 Mar 2024 07:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 28 Mar 2024 07:16:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com>
Message-ID: <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com>
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 3:55=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Feb 5, 2024 at 9:27=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> >
> > While browsing through ChromeOS crash reports, I found one with an
> > allocation failure that looked like this:
> >
> >   chrome: page allocation failure: order:7,
> >           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> >           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
> >   CPU: 7 PID: 3295 Comm: chrome Not tainted
> >           5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
> >   Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
> >   Call trace:
> >   ...
> >   warn_alloc+0x104/0x174
> >   __alloc_pages+0x5f0/0x6e4
> >   kmalloc_order+0x44/0x98
> >   kmalloc_order_trace+0x34/0x124
> >   __kmalloc+0x228/0x36c
> >   __regset_get+0x68/0xcc
> >   regset_get_alloc+0x1c/0x28
> >   elf_core_dump+0x3d8/0xd8c
> >   do_coredump+0xeb8/0x1378
> >   get_signal+0x14c/0x804
> >   ...
> >
> > An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
> > a surprise that this allocation failed on a system that's been running
> > for a while.
> >
> > More digging showed that it was fairly easy to see the order 7
> > allocation by just sending a SIGQUIT to chrome (or other processes) to
> > generate a core dump. The actual amount being allocated was 279,584
> > bytes and it was for "core_note_type" NT_ARM_SVE.
> >
> > There was quite a bit of discussion [1] on the mailing lists in
> > response to my v1 patch attempting to switch to vmalloc. The overall
> > conclusion was that we could likely reduce the 279,584 byte allocation
> > by quite a bit and Mark Brown has sent a patch to that effect [2].
> > However even with the 279,584 byte allocation gone there are still
> > 65,552 byte allocations. These are just barely more than the 65,536
> > bytes and thus would require an order 5 allocation.
> >
> > An order 5 allocation is still something to avoid unless necessary and
> > nothing needs the memory here to be contiguous. Change the allocation
> > to kvzalloc() which should still be efficient for small allocations
> > but doesn't force the memory subsystem to work hard (and maybe fail)
> > at getting a large contiguous chunk.
> >
> > [1] https://lore.kernel.org/r/20240201171159.1.Id9ad163b60d21c9e56c2d68=
6b0cc9083a8ba7924@changeid
> > [2] https://lore.kernel.org/r/20240203-arm64-sve-ptrace-regset-size-v1-=
1-2c3ba1386b9e@kernel.org
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Use kvzalloc() instead of vmalloc().
> > - Update description based on v1 discussion.
> >
> >  fs/binfmt_elf.c | 2 +-
> >  kernel/regset.c | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Just wanted to check in to see if there's anything else that I need to
> do here. Mark's patch to avoid the order 7 allocations [1] has landed,
> but we still want this kvzalloc() because the order 5 allocations
> can't really be avoided. I'm happy to sit tight for longer but just
> wanted to make sure it was clear that we still want my patch _in
> addition_ to Mark's patch and to see if there was anything else you
> needed me to do.
>
> Thanks!
>
> [1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-=
c7600ca74b9b@kernel.org

I'm not trying to be a pest here, so if this is on someone's todo list
and they'll get to it eventually then feel free to tell me to go away
and I'll snooze this for another few months. I just want to make sure
it's not forgotten.

I've been assuming that someone like Al Viro or Christian Brauner
would land this patch eventually and I know Al responded rather
quickly to my v1 [2]. I think all of Al's issues were resolved by Mark
Brown's patch [1] (which has landed in the arm64 tree) and my updating
of the patch description in v2. I see that Al and Christian are
flagged as maintainers of "fs/binfmt_elf.c" which is one of the two
files I'm touching, so that's mostly why I was assuming they would
land it.

...but I realize that perhaps my assumptions are wrong and this needs
to go through a different maintainer. In this case (if I'm reading it
correctly) Al and Christian are listed because the file is under "fs"
even though this isn't _really_ much of a filesystem-related patch.
Perhaps this needs to go through something like Andrew Morton's tree
since he often picks up patches that have nowhere else to land? If
someone else has suggestions, I'm all ears. I'm also happy to repost
this patch in case it helps with a maintainer applying it.

Thanks!

-Doug

[1] https://lore.kernel.org/r/20240213-arm64-sve-ptrace-regset-size-v2-1-c7=
600ca74b9b@kernel.org
[2] https://lore.kernel.org/r/20240202012249.GU2087318@ZenIV/

