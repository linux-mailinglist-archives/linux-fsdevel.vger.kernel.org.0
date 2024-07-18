Return-Path: <linux-fsdevel+bounces-23896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B939347CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 08:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718151C215FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276B5339D;
	Thu, 18 Jul 2024 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vg2BP8zB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AEA3C6A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282670; cv=none; b=e3A6j1KxUv4SvuKySP/IjPNIpMEXIkNvG2C8u8QmMaTOl0ipsbNKFe8OVHqHAjNHBldmHkVZF/DkCtNw8su4GSLNlj/1yfE/FnkL8XmAxQF1PvqzeycnZt2Ks9l+Ufg+dT569x29Qbv5zYF8i77IFCqkV9ApKQq/c1SqAFUkuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282670; c=relaxed/simple;
	bh=QfTgL/I/TgLu6XUSR3k5WsBkx8SZ5zYCe55lbljcCCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnedGX3+89WV/VgWzl7Yq+neJsL/AZX0iEJquMlZJbm/PzZu4kFSlJ0RTH9bWKf2KaCusRRSTJew704CjTitogT3EP6VQI8as+jaIf6sCjbBrlu91JQQ12V426LNrnEZuMdI/dwoQ96WD5Zqk0QXDqpEomKeheZqZmEBCAilQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vg2BP8zB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44a8b140a1bso201551cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721282668; x=1721887468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E8scQbL3ojunFA2vu6Mm/M82C9xFWuPlbVxUojeYRbc=;
        b=Vg2BP8zByNYsIcilvDNp3aJ4K2xIlWBe6F7zS+/iXd+NSylIaYHadt7LYTSUAKxPx8
         nvczGR4d5p4pH/9Ft4+gE4RLYugTr0WZkaYF1mgWnWUqt8pC9vQS0nEiWUbE2G3aztW0
         dTdwX4Eun8LU5hmrHNi8kv6YqGA+osM6oYayb8xasHpmKHjWo+C+0tq4uRhzB4jL6jMx
         wfkWbr2sUTM+Vb/7TJqtMARAo8EdXKynsoSxEQHwdGAuCdxkCauOL+mHNFTh7xKQNQu9
         Y+x2Erf3XG6Ft6zQQHdj2yAzeAPaIfiImJ4EZfFPSxLxpODSafsEVjoyH+KxzCJcMnvq
         t1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282668; x=1721887468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8scQbL3ojunFA2vu6Mm/M82C9xFWuPlbVxUojeYRbc=;
        b=nfkOgOX4qROt3thlqg5rz21hPslm45QbDGHgfL4xx2muP1qbWSeKnG/p37q+S+Qy77
         vuDtbwspVHQYGxlV/m/Wg18irhaFltWTThgeYWTV4rZoEaRYcr4YmpOqwOOsrT/4Jm55
         SvTzDI25zLR8G6mniBS4DFV55K/YHHnfQusRh6Uk9/FE+fufHarQFPTnKg7yGSBRg1/T
         okbtbliP0A1Xb/+VbJdMaYkHp1vqu0GrOKbQdz1FHjQT5r66iVlZa3CmTLQfo/w3SChW
         j0i3JbYglPuVkA5xffxwAB0sly1ldSDpq6atpuXBOGZiESg0TCsDQpG4dcg72xuQ/XNG
         wPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNkOKpaZqR7OxyQT05ApkTV9T1TyNeb8glWdGGYTBJo9Yx1tiuhhqMLXnhZwSz+hWIw1iEcTHkmAdI8E63jlLuTpCGfJ5ZVCceqs+RpQ==
X-Gm-Message-State: AOJu0Yy0BotC0rhj7V8eFXG7lP12pbI/gFGSlSBlpFw6dfdLtqL7IPP1
	NxWKw2MBWSLS1H/+WvnRPpQvEyu7vQlhZx/iOH9zO4iSbNS8BzxMMh0HSxdRNQm04VNZbyK50E5
	oYTxbdajt2rOVL26dzAEdVP7qyM+Coo4fO96w
X-Google-Smtp-Source: AGHT+IFWiSFqWtqZYfC0jy++zn1iek0Vig5wz8pSEdHMvDV8US/DapjvjgpSBDodO3pWivnkdS9LQpK1eVFmUnjjxIc=
X-Received: by 2002:a05:622a:4297:b0:447:d78d:773b with SMTP id
 d75a77b69052e-44f919d5b5emr1331311cf.6.1721282667643; Wed, 17 Jul 2024
 23:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717212230.work.346-kees@kernel.org>
In-Reply-To: <20240717212230.work.346-kees@kernel.org>
From: David Gow <davidgow@google.com>
Date: Thu, 18 Jul 2024 14:04:14 +0800
Message-ID: <CABVgOSmKwPq7JEpHfS6sbOwsR0B-DBDk_JP-ZD9s9ZizvpUjbQ@mail.gmail.com>
Subject: Re: [PATCH] execve: Move KUnit tests to tests/ subdirectory
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 05:22, Kees Cook <kees@kernel.org> wrote:
>
> Move the exec KUnit tests into a separate directory to avoid polluting
> the local directory namespace. Additionally update MAINTAINERS for the
> new files and mark myself as Maintainer.
>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> I'll toss this into -next and send it to Linus before -rc1 closes.
> ---

With s/_test/_kunit (once the docs changes are sorted), this looks good.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  MAINTAINERS                      | 5 +++--
>  fs/binfmt_elf.c                  | 2 +-
>  fs/exec.c                        | 2 +-
>  fs/{ => tests}/binfmt_elf_test.c | 0
>  fs/{ => tests}/exec_test.c       | 0
>  5 files changed, 5 insertions(+), 4 deletions(-)
>  rename fs/{ => tests}/binfmt_elf_test.c (100%)
>  rename fs/{ => tests}/exec_test.c (100%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8dfbe998f175..35474718c05b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8211,8 +8211,8 @@ S:        Maintained
>  F:     rust/kernel/net/phy.rs
>
>  EXEC & BINFMT API, ELF
> +M:     Kees Cook <keescook@chromium.org>
>  R:     Eric Biederman <ebiederm@xmission.com>
> -R:     Kees Cook <keescook@chromium.org>
>  L:     linux-mm@kvack.org
>  S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
> @@ -8220,7 +8220,8 @@ F:        Documentation/userspace-api/ELF.rst
>  F:     fs/*binfmt_*.c
>  F:     fs/Kconfig.binfmt
>  F:     fs/exec.c
> -F:     fs/exec_test.c
> +F:     fs/tests/binfmt_*_test.c
> +F:     fs/tests/exec_test.c
>  F:     include/linux/binfmts.h
>  F:     include/linux/elf.h
>  F:     include/uapi/linux/binfmts.h
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 40111451aa95..1a032811b304 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2152,5 +2152,5 @@ core_initcall(init_elf_binfmt);
>  module_exit(exit_elf_binfmt);
>
>  #ifdef CONFIG_BINFMT_ELF_KUNIT_TEST
> -#include "binfmt_elf_test.c"
> +#include "tests/binfmt_elf_test.c"
>  #endif
> diff --git a/fs/exec.c b/fs/exec.c
> index 5b580ff8d955..5a59063c50b1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -2244,5 +2244,5 @@ fs_initcall(init_fs_exec_sysctls);
>  #endif /* CONFIG_SYSCTL */
>
>  #ifdef CONFIG_EXEC_KUNIT_TEST
> -#include "exec_test.c"
> +#include "tests/exec_test.c"
>  #endif
> diff --git a/fs/binfmt_elf_test.c b/fs/tests/binfmt_elf_test.c
> similarity index 100%
> rename from fs/binfmt_elf_test.c
> rename to fs/tests/binfmt_elf_test.c
> diff --git a/fs/exec_test.c b/fs/tests/exec_test.c
> similarity index 100%
> rename from fs/exec_test.c
> rename to fs/tests/exec_test.c
> --
> 2.34.1
>

