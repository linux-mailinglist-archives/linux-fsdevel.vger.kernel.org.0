Return-Path: <linux-fsdevel+bounces-24380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D065593E911
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 21:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE071C20F7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72C7174F;
	Sun, 28 Jul 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJo6Nonk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03695B669
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722195282; cv=none; b=i72tBh4gP4mF28ZK4d9ojYyyl41pUAsPfqfVVhDKIZUNwXFWzoRvhm3K0dg+HFfkLV4sjECqrI7Q2RKY7882WSjTwT2B0TXQJzuDbDk/1xPPjKl9AgtPd+Oq7iwY+jdT6ZFw3fsB9ktHz0/VdpELZJbCk8KdFWZ4rwCljQFpGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722195282; c=relaxed/simple;
	bh=eiHpgoCCNDzt2LGNdDK/WPcBrAcooSXWBqevTAnxG5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBxhGBbYU7t2yOHzQiPSRse5nD/5Yl9Jrccv88PY07M8GbQIK6xaK+MlktckjqmKsu6UIkkjrvJoPZCS+sIUSW8rWIEcPd1L4NJsilzaXw6T5VyHJzns9C016h8DaY0TOtTs0VpnBknGz/k/aSGReILooCxc+4b0mj7+eD3Ur2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJo6Nonk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34431so2441403a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 12:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722195279; x=1722800079; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DOUs3iJY9lkTpGKZDHpIuHKAspZrlDKN5UkaPQTsESI=;
        b=qJo6NonktvMaPE3nPbL6hicbjdAZ9lOReuoLHiAfWwQcpIqOYy5RgQJQdhdsSvUMUz
         dh+JOh9Nj45K/rrNmv5xC90MAGEv5oryAX4PuI7xLvGfqu+RQKDsZmbL97fjlCm6xy9h
         YT7lypxto7jITd6aTgZBoNA72jG/2in7MoL1QAFfv2YwGhWpLF9UX2f5Htsfc4AG+e0N
         8hsAHkzz904p2LsB0UyxmcZ2CdFpeypnqZGfSG/vYFe9eEjBlqJBcyNB+8zizpvUbn4J
         qEdTjsE23azpzoc49RoI9N8CNBk2tBIRjjGzNBcbXuwbNzIr07gnifZ9sY31LGCMSn8y
         /+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722195279; x=1722800079;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOUs3iJY9lkTpGKZDHpIuHKAspZrlDKN5UkaPQTsESI=;
        b=NBoWVUDdxtfjw7Fy7vzoDJIT1ke7RFn0KjoF3TcVOO/i1jAncpsEeOeSsXsjgfQRoF
         LkCOoqOhD4epoWXq9yQx1tvz2F0GoTvJFGAem5q68ziVNGD8/xRme7fnnZ2TXxNtMA1+
         29/ATsgbvHTfxn3aUQz1iV1cOnxJErJxVIiHThXJeltly/mZOeKTXe2cew+UrKFPa7Zl
         3A3VbZceNaiYFwRyTWwlxazGhS0l8FxK/MDAJsQXwikRZFfEZnwdEvokRbt6MLgUoRsr
         ax0BsbEcFNUy3ej3oKCZAlao1ErUEHN6JJYyr6W6csJOUOh59LL6yPh0x2Ohm7z09N6e
         hbfg==
X-Forwarded-Encrypted: i=1; AJvYcCVe6tgSkKtPMEwVa+hLME5mP19AxeSr9pT/Z3MR7pi3vB5JPLGIEwhqrygXJ+zDN43GqJVk2gNuwRHTuxtnwLcztWF/9bWqVvQsnvcv3g==
X-Gm-Message-State: AOJu0YxheJi6fq9huoCFZWghZo/0CxGEIN4RmVMD642rfPpiPfTZim1Z
	mnY2b7qmGJTtgmTTSuzYjGq9aEOcNfj468Pk/CP2YmdyzJs9GgKg5bqYfxdSrg==
X-Google-Smtp-Source: AGHT+IGNb4QowyQtSDJw+LbQH3Bw7Bi2zqSssbTuKI9nnKYqCoTtYLvrZMvaMsDZ4hdXcOpAngv5Lg==
X-Received: by 2002:a50:8d57:0:b0:5a1:71b2:e9bd with SMTP id 4fb4d7f45d1cf-5b02375ed86mr4448002a12.34.1722195278771;
        Sun, 28 Jul 2024 12:34:38 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b017787967sm2628656a12.9.2024.07.28.12.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 12:34:38 -0700 (PDT)
Date: Sun, 28 Jul 2024 19:34:34 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 2/3] selftests/bpf: add negative tests for
 new VFS based BPF kfuncs
Message-ID: <ZqadSvz0X_Tj3yFM@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-3-mattbobrowski@google.com>
 <CAPhsuW4Ty7rkjdwCPBWDfkhWY2+5uofnjm5yM=EypTKVSzyePw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4Ty7rkjdwCPBWDfkhWY2+5uofnjm5yM=EypTKVSzyePw@mail.gmail.com>

On Fri, Jul 26, 2024 at 04:38:32PM -0700, Song Liu wrote:
> On Fri, Jul 26, 2024 at 1:56 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > Add a bunch of negative selftests responsible for asserting that the
> > BPF verifier successfully rejects a BPF program load when the
> > underlying BPF program misuses one of the newly introduced VFS based
> > BPF kfuncs.
> 
> Negative tests are great. Thanks for adding them.
> 
> A few nitpicks below.

Thanks for the review!

> > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> > index 828556cdc2f0..8a1ed62b4ed1 100644
> > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > @@ -195,6 +195,32 @@ extern void bpf_iter_task_vma_destroy(struct bpf_iter_task_vma *it) __ksym;
> >   */
> >  extern void bpf_throw(u64 cookie) __ksym;
> >
> > +/* Description
> > + *     Acquire a reference on the exe_file member field belonging to the
> > + *     mm_struct that is nested within the supplied task_struct. The supplied
> > + *     task_struct must be trusted/referenced.
> > + * Returns
> > + *     A referenced file pointer pointing to the exe_file member field of the
> > + *     mm_struct nested in the supplied task_struct, or NULL.
> > + */
> > +extern struct file *bpf_get_task_exe_file(struct task_struct *task) __ksym;
> > +
> > +/* Description
> > + *     Release a reference on the supplied file. The supplied file must be
> > + *     trusted/referenced.
> 
> Probably replace "trusted/referenced" with "acquired".

Done.

> > + */
> > +extern void bpf_put_file(struct file *file) __ksym;
> > +
> > +/* Description
> > + *     Resolve a pathname for the supplied path and store it in the supplied
> > + *     buffer. The supplied path must be trusted/referenced.
> > + * Returns
> > + *     A positive integer corresponding to the length of the resolved pathname,
> > + *     including the NULL termination character, stored in the supplied
> > + *     buffer. On error, a negative integer is returned.
> > + */
> > +extern int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz) __ksym;
> > +
> 
> In my environment, we already have these declarations in vmlinux.h.
> So maybe we don't need to add them manually?

Right, but that's probably when building vmlinux.h using the latest
pahole I imagine? Those not using the latest pahole will probably
won't already see these BPF kfuncs within the generated vmlinux.h.

> >  /* This macro must be used to mark the exception callback corresponding to the
> >   * main program. For example:
> >   *
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > index 67a49d12472c..14d74ba2188e 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -85,6 +85,7 @@
> >  #include "verifier_value_or_null.skel.h"
> >  #include "verifier_value_ptr_arith.skel.h"
> >  #include "verifier_var_off.skel.h"
> > +#include "verifier_vfs_reject.skel.h"
> >  #include "verifier_xadd.skel.h"
> >  #include "verifier_xdp.skel.h"
> >  #include "verifier_xdp_direct_packet_access.skel.h"
> > @@ -205,6 +206,7 @@ void test_verifier_value(void)                { RUN(verifier_value); }
> >  void test_verifier_value_illegal_alu(void)    { RUN(verifier_value_illegal_alu); }
> >  void test_verifier_value_or_null(void)        { RUN(verifier_value_or_null); }
> >  void test_verifier_var_off(void)              { RUN(verifier_var_off); }
> > +void test_verifier_vfs_reject(void)          { RUN(verifier_vfs_reject); }
> >  void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
> >  void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
> >  void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> > new file mode 100644
> > index 000000000000..27666a8ef78a
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2024 Google LLC. */
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <linux/limits.h>
> > +
> > +#include "bpf_misc.h"
> > +#include "bpf_experimental.h"
> > +
> > +static char buf[PATH_MAX];
> > +
> > +SEC("lsm.s/file_open")
> > +__failure __msg("Possibly NULL pointer passed to trusted arg0")
> > +int BPF_PROG(get_task_exe_file_kfunc_null)
> > +{
> > +       struct file *acquired;
> > +
> > +       /* Can't pass a NULL pointer to bpf_get_task_exe_file(). */
> > +       acquired = bpf_get_task_exe_file(NULL);
> > +       if (!acquired)
> > +               return 0;
> > +
> > +       bpf_put_file(acquired);
> > +       return 0;
> > +}
> > +
> > +SEC("lsm.s/inode_getxattr")
> > +__failure __msg("arg#0 pointer type STRUCT task_struct must point to scalar, or struct with scalar")
> > +int BPF_PROG(get_task_exe_file_kfunc_fp)
> > +{
> > +       u64 x;
> > +       struct file *acquired;
> > +       struct task_struct *fp;
> 
> "fp" is a weird name for a task_struct pointer.

OK, just want to make it clear that it was a pointer to something that
exists on the current stack frame. Happy to change the name to task or
something. Done.

> Other than these:
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> > +
> > +       fp = (struct task_struct *)&x;
> > +       /* Can't pass random frame pointer to bpf_get_task_exe_file(). */
> > +       acquired = bpf_get_task_exe_file(fp);
> > +       if (!acquired)
> > +               return 0;
> > +
> > +       bpf_put_file(acquired);
> > +       return 0;
> > +}
> > +
> [...]
/M

