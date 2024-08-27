Return-Path: <linux-fsdevel+bounces-27469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE538961A27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 00:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388D285198
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6B1D416C;
	Tue, 27 Aug 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt81/wgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359984D34;
	Tue, 27 Aug 2024 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799342; cv=none; b=dF15vha6q+Nie8OQ6hwVOXMQu28teAL7WCPIOzg4Q55HDHMk1ZJUDdGZdDdKs9q6YfDGH0QBktrQamxM8JMVA6cMMzWEV3xMm2e3tf4nJV0NDMX8EwD1yBPH4u3qMQ0nnLgRFcUsfoTWIfal6kPXTLRtIEHKw3xPZwJv0peKUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799342; c=relaxed/simple;
	bh=ptaK3/0U1Jk7BWxeibzeeYBhWoS6mOGUpCQa77r6vN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTSFoHrwDl800JVWUDSqYpQfOJiSkmwYN4XDqUaMDJ5rMpp4PG5x4EGL2LDEsmbebs1PRH9B0BJbc4zv89xa1gBZU3FcsZL7n+R4LDkAGVPdNSJWeoR6WMpZjCrda9ztJQacV+EVnC+Zg9CQ/Us8w2r/UnUtQCkgY9CLuxmBLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dt81/wgN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7bcf8077742so4228999a12.0;
        Tue, 27 Aug 2024 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724799340; x=1725404140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsar/HY/igeb/N5PuHSa3F5h30LOxiVIggShUntngqQ=;
        b=dt81/wgNoy7YANdV3IVwfD7mrD6UAphmOvYUcku/NI0wYypbJJdsZ+iYOUwzo6k/29
         WMwK32knhosRMpvdxuuIF3XtocNTgzS8/vQswpUoUct9ziArIZiCj6snbVCAuJFiRM9Q
         VREnh0BP6i37AHS4GSBaL4io3abvpS9NXPm8eNk/rDa3IUXvwrqclI01Y+f50qMmvp9p
         AdugjQDOO4kcUW5lAt0VYPopIVx9EI3Zfjd+ISOU/pjDWrnOStmF4G23KzOpK7oi18za
         D4reAI9ApSTBljH4/N+0m8tYrVvPXNSHEtUXfvXlfRlTcXY6CPwfyZDAlFHQjbaUh+fN
         QhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799340; x=1725404140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsar/HY/igeb/N5PuHSa3F5h30LOxiVIggShUntngqQ=;
        b=Gw+4XElG7IMdUxNQGo/+QLD3PQ/C4Wkz75A7nnhPvbRuXfgUIzbbesq6BZCGEGfbGj
         s0GiR+zqiUvmo3/mpB6GWfPeCaPH1MDEjiSrhDeYV50R6qwQU61IwBK0zZS+qbtaPIC1
         acEE9ioxi1rsr3oucepPPKFHptK6+WpYL/DbvwAeqW6KQtgKfckftySchdTyj8JWzcUU
         oVbvVV+Mb6mmxgvgX+TXUaVji7kuPV+U3qVl/G9p6TfU4aAlJ5JFI+NuNnyBXZvXuGuO
         a0huawgqbAvwaqRHT1xEbJBPWypYZeqG+ItcvXN4jK6bV0fs+qGWH/R7ufTuRVV8Guoh
         +7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVDxSMWA4X+LG4vKnGvZVSR4iJF/s4Se05LJf9DRFzuAG+FONOHzyLfET9MpNkdmO5A9wGOcd96TDRSkvHS@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSgTiFB8s2Psj7wtN+i/30pUhyjs8rooS6r158JqLwePvTdWn
	/U+X78K034Q5LZaVtpBdF9atpGDOLqbpipt0+sxsqLI1uPjP9WDy7EvEZTG/WI+AZsk6fclhc+d
	asXg7Yu3nGh1uPcFzuPYe7DRtf2IQ13Xg
X-Google-Smtp-Source: AGHT+IEwZt/y/Izw+LkAhH0vb5FK6Tqi8+RkxcIA31fyuJCPe6KaDFJJQoLNTS13v7fc+ZxHjgXzpe2+0WzO3L5ese0=
X-Received: by 2002:a17:90a:8d0f:b0:2d3:bc5e:8452 with SMTP id
 98e67ed59e1d1-2d646d30403mr15932467a91.32.1724799340358; Tue, 27 Aug 2024
 15:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org>
In-Reply-To: <20240813230300.915127-1-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 15:55:28 -0700
Message-ID: <CAEf4BzY4v6D9gusa+fkY1qg4m-yT8VVFg2Y-++BdrheQMp+j6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/8] BPF follow ups to struct fd refactorings
To: viro@kernel.org, brauner@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> This patch set extracts all the BPF-related changes done in [0] into
> a separate series based on top of stable-struct_fd branch ([1]) merged in=
to
> bpf-next tree. There are also a few changes, additions, and adjustments:
>
>   - patch subjects adjusted to use "bpf: " prefix consistently;
>   - patch #2 is extracting bpf-related changes from original patch #19
>     ("fdget_raw() users: switch to CLASS(fd_raw, ...)") and is ordered a =
bit
>     earlier in this patch set;
>   - patch #3 is reimplemented and replaces original patch #17
>     ("bpf: resolve_pseudo_ldimm64(): take handling of a single ldimm64 in=
sn into helper")
>     completely;
>   - in patch #4 ("bpf: switch maps to CLASS(fd, ...)"), which was origina=
lly
>     patch #18 ("bpf maps: switch to CLASS(fd, ...)"), I've combined
>     __bpf_get_map() and bpf_file_to_map() into __bpf_get_map(), as the la=
tter
>     is only used from it and makes no sense to keep separate;
>   - as part of rebasing patch #4, I adjusted newly added in patch #3
>     add_used_map_from_fd() function to use CLASS(fd, ...), as now
>     __bpf_get_map() doesn't do its own fdput() anymore. This made unneces=
sary
>     any further bpf_map_inc() changes, because we still rely on struct fd=
 to
>     keep map's file reference alive;
>   - patches #5 and #6 are BPF-specific bits extracted from original patch=
 #23
>     ("fdget(), trivial conversions") and #24 ("fdget(), more trivial conv=
ersions");
>   - patch #7 constifies security_bpf_token_create() LSM hook;
>   - patch #8 is original patch #35 ("convert bpf_token_create()"), with
>     path_get()+path_put() removed now that LSM hook above was adjusted.
>
> All these patches were pushed into a separate bpf-next/struct_fd branch (=
[2]).
> They were also merged into bpf-next/for-next so they can get early testin=
g in
> linux-next.
>
>   [0] https://lore.kernel.org/bpf/20240730050927.GC5334@ZenIV/
>   [1] https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=
=3Dstable-struct_fd
>   [2] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/lo=
g/?h=3Dstruct_fd
>
> Al Viro (6):
>   bpf: convert __bpf_prog_get() to CLASS(fd, ...)
>   bpf: switch fdget_raw() uses to CLASS(fd_raw, ...)
>   bpf: switch maps to CLASS(fd, ...)
>   bpf: trivial conversions for fdget()
>   bpf: more trivial fdget() conversions
>   bpf: convert bpf_token_create() to CLASS(fd, ...)
>
> Andrii Nakryiko (2):
>   bpf: factor out fetching bpf_map from FD and adding it to used_maps
>     list
>   security,bpf: constify struct path in bpf_token_create() LSM hook
>

Al, Christian,

Can you guys please take a look and let us know if this looks sane and
fine to you? I kept Al's patches mostly intact (see my notes in the
cover letter above), and patch #3 does the refactoring I proposed
earlier, keeping explicit fdput() temporarily, until Al's
__bpf_map_get() refactoring which allows and nice and simple CLASS(fd)
conversion.

I think we end up at exactly what the end goal of the original series
is: using CLASS(fd, ...) throughout with all the benefits.

>  include/linux/bpf.h            |  11 +-
>  include/linux/lsm_hook_defs.h  |   2 +-
>  include/linux/security.h       |   4 +-
>  kernel/bpf/bpf_inode_storage.c |  24 ++---
>  kernel/bpf/btf.c               |  11 +-
>  kernel/bpf/map_in_map.c        |  38 ++-----
>  kernel/bpf/syscall.c           | 181 +++++++++------------------------
>  kernel/bpf/token.c             |  74 +++++---------
>  kernel/bpf/verifier.c          | 110 +++++++++++---------
>  net/core/sock_map.c            |  23 ++---
>  security/security.c            |   2 +-
>  security/selinux/hooks.c       |   2 +-
>  12 files changed, 179 insertions(+), 303 deletions(-)
>
> --
> 2.43.5
>

