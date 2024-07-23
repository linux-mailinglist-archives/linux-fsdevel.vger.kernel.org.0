Return-Path: <linux-fsdevel+bounces-24147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C847C93A49D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 18:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372E8B22E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF891581E9;
	Tue, 23 Jul 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PizVxo1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B5137748;
	Tue, 23 Jul 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721753909; cv=none; b=K73k6FCP2+F+NUysTJ3SCPtzdQMhlX1ahEuTy/2Nj0+GwFlfcQe4PWQ42/Vf3x8juOzVAe+38FHauv9ekZJ1159csPiPY0l0vH/a99WV/RTbUgLTLB/mDWjgMM28q1HcUo8xSLPUCgXIbqZBqoRBpFWcGqTDDwWOya44HdfzsHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721753909; c=relaxed/simple;
	bh=Sqs/0quIp3Pa11UvNTzT7w+Q8ZTby6g4NE3CHsEZAl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aSigzfgDlX5GsTviFbeu8yUqXTbQ6UfC8h2og7xrYZBjxsr90+8WqNLlPwlzYhu8BpGZE4z7ioD47fuYTvpi0Mmxwkow9Ri988CosOfET16JlVBSXFcOtCrrfw+WcNdZv+vAe+Lv4zmai1z8VgAoFYdZXGyXogsZBrWftNvufDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PizVxo1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B48C4AF09;
	Tue, 23 Jul 2024 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721753909;
	bh=Sqs/0quIp3Pa11UvNTzT7w+Q8ZTby6g4NE3CHsEZAl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PizVxo1oR2M8aKRGi2wOJgA4mAsf5CbqST3vugX2h0rqCuMeiaaCSx8xC1fpV9HEe
	 DGbtr2BY9p77OoiW+VImy8DX/QF2Hgru7aRZa5IhJG2OECUM7HdF+kYbRrGh2s6FZH
	 reEVHGWTRZLtmxEb1/amXltuFsKc8nIsXle1TwlNUx/jO6qgT7ahee2WTMX4x5idcz
	 ZBsh4mT54/hU0zLqr8y7IooaOv+cq1bWaw5tDLZJH8f2tXJFj8ni2GPxmDmiTWP4V2
	 N8XOoLmriui7NjecJDPiyWXWyz80XTtNpqKX2X3uiUtLqncMwex6dASfnZu/CpENta
	 5rJyhTfBf3doA==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v3 4/7] mm: move internal core VMA manipulation functions to own file
Date: Tue, 23 Jul 2024 09:58:25 -0700
Message-Id: <20240723165825.196416-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <36667fcc4fcf9e6341239a4eb0e15f6143cdc5c2.1721648367.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On Mon, 22 Jul 2024 12:50:22 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> This patch introduces vma.c and moves internal core VMA manipulation
> functions to this file from mmap.c.
> 
> This allows us to isolate VMA functionality in a single place such that we
> can create userspace testing code that invokes this functionality in an
> environment where we can implement simple unit tests of core functionality.
> 
> This patch ensures that core VMA functionality is explicitly marked as such
> by its presence in mm/vma.h.
> 
> It also places the header includes required by vma.c in vma_internal.h,
> which is simply imported by vma.c. This makes the VMA functionality
> testable, as userland testing code can simply stub out functionality
> as required.
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h |   35 -
>  mm/Makefile        |    2 +-
>  mm/internal.h      |  236 +-----
>  mm/mmap.c          | 1980 +++-----------------------------------------
>  mm/mmu_notifier.c  |    2 +
>  mm/vma.c           | 1766 +++++++++++++++++++++++++++++++++++++++
>  mm/vma.h           |  364 ++++++++
>  mm/vma_internal.h  |   52 ++
>  8 files changed, 2294 insertions(+), 2143 deletions(-)
>  create mode 100644 mm/vma.c
>  create mode 100644 mm/vma.h
>  create mode 100644 mm/vma_internal.h
> 
[...]
> diff --git a/mm/vma_internal.h b/mm/vma_internal.h
> new file mode 100644
> index 000000000000..e13e5950df78
> --- /dev/null
> +++ b/mm/vma_internal.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * vma_internal.h
> + *
> + * Headers required by vma.c, which can be substituted accordingly when testing
> + * VMA functionality.
> + */
> +
> +#ifndef __MM_VMA_INTERNAL_H
> +#define __MM_VMA_INTERNAL_H
> +
[...]
> +#include <asm/current.h>
> +#include <asm/page_types.h>
> +#include <asm/pgtable_types.h>

I found the latest mm-unstable fails build for arm64 and kunit (tenically
speaking, UM) with errors including below.  And 'git bisect' points this patch.

From arm64 build:
      CC      mm/vma.o
    In file included from /mm/vma.c:7:
    /mm/vma_internal.h:46:10: fatal error: asm/page_types.h: No such file or directory
       46 | #include <asm/page_types.h>
          |          ^~~~~~~~~~~~~~~~~~
    compilation terminated.

From kunit build:

    $ ./tools/testing/kunit/kunit.py build
    [...]
    $ make ARCH=um O=.kunit --jobs=36
    ERROR:root:../lib/iomap.c:156:5: warning: no previous prototype for ‘ioread64_lo_hi’ [-Wmissing-prototypes]
      156 | u64 ioread64_lo_hi(const void __iomem *addr)
          |     ^~~~~~~~~~~~~~
    ../lib/iomap.c:163:5: warning: no previous prototype for ‘ioread64_hi_lo’ [-Wmissing-prototypes]
      163 | u64 ioread64_hi_lo(const void __iomem *addr)
          |     ^~~~~~~~~~~~~~
    ../lib/iomap.c:170:5: warning: no previous prototype for ‘ioread64be_lo_hi’ [-Wmissing-prototypes]
      170 | u64 ioread64be_lo_hi(const void __iomem *addr)
          |     ^~~~~~~~~~~~~~~~
    ../lib/iomap.c:178:5: warning: no previous prototype for ‘ioread64be_hi_lo’ [-Wmissing-prototypes]
      178 | u64 ioread64be_hi_lo(const void __iomem *addr)
          |     ^~~~~~~~~~~~~~~~
    ../lib/iomap.c:264:6: warning: no previous prototype for ‘iowrite64_lo_hi’ [-Wmissing-prototypes]
      264 | void iowrite64_lo_hi(u64 val, void __iomem *addr)
          |      ^~~~~~~~~~~~~~~
    ../lib/iomap.c:272:6: warning: no previous prototype for ‘iowrite64_hi_lo’ [-Wmissing-prototypes]
      272 | void iowrite64_hi_lo(u64 val, void __iomem *addr)
          |      ^~~~~~~~~~~~~~~
    ../lib/iomap.c:280:6: warning: no previous prototype for ‘iowrite64be_lo_hi’ [-Wmissing-prototypes]
      280 | void iowrite64be_lo_hi(u64 val, void __iomem *addr)
          |      ^~~~~~~~~~~~~~~~~
    ../lib/iomap.c:288:6: warning: no previous prototype for ‘iowrite64be_hi_lo’ [-Wmissing-prototypes]
      288 | void iowrite64be_hi_lo(u64 val, void __iomem *addr)
          |      ^~~~~~~~~~~~~~~~~
    In file included from ../mm/vma_internal.h:46,
                     from ../mm/vma.c:7:

Maybe the above two #include need to be removed or protected for some configs?
I confirmed simply removing the two lines as below makes at least kunit, arm64,
and my x86_64 builds happy, but would like to hear your thoughts.

"""
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index e13e5950df78..14c24d5cb582 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -43,8 +43,6 @@
 #include <linux/userfaultfd_k.h>

 #include <asm/current.h>
-#include <asm/page_types.h>
-#include <asm/pgtable_types.h>
 #include <asm/tlb.h>

 #include "internal.h"
"""


Thanks,
SJ

[...]

