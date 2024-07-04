Return-Path: <linux-fsdevel+bounces-23093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9F926F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 08:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A621C22045
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 06:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0831A0732;
	Thu,  4 Jul 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k91nOGj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581A1A0722;
	Thu,  4 Jul 2024 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720072802; cv=none; b=VBAUL7TzvEUjkCQ7PBXLz2PxaHHB8V8bLpCxsVJc4XdrMmpVj4PnupVXBEhQK1L/wQuym2rF/xlz5cVyPaeQfBkDKUIjg5TYPCKAntxrlmEXS7e4xmt8/bGu1DKtuH1AiF0NqKmSAdIHW7GsbVtP+phKBM7aYyp9R/XljDuxCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720072802; c=relaxed/simple;
	bh=oQSiJGRIO7Sd0RoH9/CsPjkAYqaU9QVnsK6YnUewdEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gae5TEj2HqQzpzXV8uu5OpkHacppW4aYJXNq+yMW3cz8O4qjdKrxYcSnXnaVGGnqREkOxDYBYoXlggCtAts8Fs5jXIFO8GuKxfMKB1W6wy5uknf7ARmvSIWIXnACijl17E43S+gPlahIkJsXqjQ0RByT80kxJQ3TlpIKQvU/eHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k91nOGj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2E7C3277B;
	Thu,  4 Jul 2024 06:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720072802;
	bh=oQSiJGRIO7Sd0RoH9/CsPjkAYqaU9QVnsK6YnUewdEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k91nOGj+rRcjBGH6I6BHiU8BxFCKulKwwzCIr6QbFKGkIFGcyndmlgZftMjQYBoDa
	 H4AvlaLqrmzkVBdYlgRYCpAGUARBHKO1fG07QYqo5871dUGYFzzxJpt2vJWQNd8jfy
	 o1W83B6IxPZQtMJpcoL0zpDARzP2sYjxf6z0/BxhZeH+x/NRoz75jqGRShHBcHn0oX
	 Zh+EsxMTNy6Wqk3HZT+wRfa3vpJ4B9iLjnumD2OEoW5F+Qrl2CFKjLU+rm4Ul1eJBw
	 pgs9b1oiRwwa1LGQjxKi5hluDge7Sz7L1OVSBI9JTwp/9fddlPfKWVYP0vd8HTpQ+r
	 xF5X35sVvM2ug==
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
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 7/7] tools: add skeleton code for userland testing of VMA logic
Date: Wed,  3 Jul 2024 22:59:56 -0700
Message-Id: <20240704055956.96925-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <3303ff9b038710401f079f6eb3ee910876657082.1720006125.git.lorenzo.stoakes@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

On Wed,  3 Jul 2024 12:57:38 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Establish a new userland VMA unit testing implementation under
> tools/testing which utilises existing logic providing maple tree support in
> userland utilising the now-shared code previously exclusive to radix tree
> testing.
> 
> This provides fundamental VMA operations whose API is defined in mm/vma.h,
> while stubbing out superfluous functionality.
> 
> This exists as a proof-of-concept, with the test implementation functional
> and sufficient to allow userland compilation of vma.c, but containing only
> cursory tests to demonstrate basic functionality.

Overall, looks good to me.  Appreciate this work.  Nonetheless, I have some
trivial questions and comments below.

> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS                            |   1 +
>  include/linux/atomic.h                 |   2 +-
>  include/linux/mmzone.h                 |   3 +-

I doubt if changes to above two files are intentional.  Please read below
comments.

>  tools/testing/vma/.gitignore           |   6 +
>  tools/testing/vma/Makefile             |  16 +
>  tools/testing/vma/errors.txt           |   0
>  tools/testing/vma/generated/autoconf.h |   2 +

I'm also unsure if above two files are intentionally added.  Please read below
comments.

>  tools/testing/vma/linux/atomic.h       |  12 +
>  tools/testing/vma/linux/mmzone.h       |  38 ++
>  tools/testing/vma/vma.c                | 207 ++++++
>  tools/testing/vma/vma_internal.h       | 882 +++++++++++++++++++++++++
>  11 files changed, 1167 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/vma/.gitignore
>  create mode 100644 tools/testing/vma/Makefile
>  create mode 100644 tools/testing/vma/errors.txt
>  create mode 100644 tools/testing/vma/generated/autoconf.h
>  create mode 100644 tools/testing/vma/linux/atomic.h
>  create mode 100644 tools/testing/vma/linux/mmzone.h
>  create mode 100644 tools/testing/vma/vma.c
>  create mode 100644 tools/testing/vma/vma_internal.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff3e113ed081..c21099d0a123 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>  F:	mm/vma.c
>  F:	mm/vma.h
>  F:	mm/vma_internal.h
> +F:	tools/testing/vma/

Thank you for addressing my comment on the previous version :)

Btw, what do you think about moving the previous MAINTAINERS touching patch to
the end of this patch series and making this change together at once?

> 
>  VMALLOC
>  M:	Andrew Morton <akpm@linux-foundation.org>
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 8dd57c3a99e9..badfba2fd10f 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -81,4 +81,4 @@
>  #include <linux/atomic/atomic-long.h>
>  #include <linux/atomic/atomic-instrumented.h>
> 
> -#endif /* _LINUX_ATOMIC_H */
> +#endif	/* _LINUX_ATOMIC_H */

Maybe unintended change?

> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 41458892bc8a..30a22e57fa50 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1,4 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
>  #ifndef _LINUX_MMZONE_H
>  #define _LINUX_MMZONE_H
> 

To my understanding, the test adds tools/testing/vma/linux/mmzone.h and uses it
instead of this file.  If I'm not missing something here, above license change
may not really needed?

> diff --git a/tools/testing/vma/.gitignore b/tools/testing/vma/.gitignore
> new file mode 100644
> index 000000000000..d915f7d7fb1a
> --- /dev/null
> +++ b/tools/testing/vma/.gitignore
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +generated/bit-length.h
> +generated/map-shift.h

I guess we should also have 'generated/autoconf.h' here?  Please read below
comment for the file, too.

> +idr.c
> +radix-tree.c
> +vma
> diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
> new file mode 100644
> index 000000000000..70e728f2eee3
> --- /dev/null
> +++ b/tools/testing/vma/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +.PHONY: default
> +
> +default: vma
> +
> +include ../shared/shared.mk
> +
> +OFILES = $(SHARED_OFILES) vma.o maple-shim.o
> +TARGETS = vma
> +
> +vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
> +	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
> +
> +clean:
> +	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h

If my assumption about generated/autoconf.h file is not wrong, I think we
should also remove the file here, too.  'git' wouldn't care, but I think
removing generated/ directory with files under it would be clearer for
working space management.

> diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
> new file mode 100644
> index 000000000000..e69de29bb2d1

I'm not seeing who is really using this empty file.  Is this file intentionally
added?

> diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
> new file mode 100644
> index 000000000000..92dc474c349b
> --- /dev/null
> +++ b/tools/testing/vma/generated/autoconf.h
> @@ -0,0 +1,2 @@
> +#include "bit-length.h"
> +#define CONFIG_XARRAY_MULTI 1

Seems this file is automatically generated by ../shared/shared.mk.  If I'm not
wrong, I think removing this and adding changes I suggested to .gitignore and
Makefile would be needed?

Since share.mk just copies the file while setting -I flag so that
tools/testing/vma/vma.c can include files from share/ directory, maybe another
option is simply including the file from the share/ directory without copying
it here.

Also, the previous patch (tools: separate out shared radix-tree components)
that adds this file at tools/testing/shared/ would need to add SPDX License
identifier?

> diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
> new file mode 100644
> index 000000000000..e01f66f98982
> --- /dev/null
> +++ b/tools/testing/vma/linux/atomic.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _LINUX_ATOMIC_H
> +#define _LINUX_ATOMIC_H
> +
> +#define atomic_t int32_t
> +#define atomic_inc(x) uatomic_inc(x)
> +#define atomic_read(x) uatomic_read(x)
> +#define atomic_set(x, y) do {} while (0)
> +#define U8_MAX UCHAR_MAX
> +
> +#endif	/* _LINUX_ATOMIC_H */
> diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
> new file mode 100644
> index 000000000000..e6a96c686610
> --- /dev/null
> +++ b/tools/testing/vma/linux/mmzone.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

I'm not very familiar with the license stuffs, but based on the changes to
other files including that to include/linux/mmazone.h above, I was thinking
this file would also need to update the license to GP-2.0-or-later.  Should
this be updated so?

[...]
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> new file mode 100644
> index 000000000000..1f32bc4d60c2
> --- /dev/null
> +++ b/tools/testing/vma/vma.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#include "maple-shared.h"
> +#include "vma_internal.h"
> +
> +/*
> + * Directly import the VMA implementation here. Our vma_internal.h wrapper
> + * provides userland-equivalent functionality for everything vma.c uses.
> + */
> +#include "../../../mm/vma.c"
> +
> +const struct vm_operations_struct vma_dummy_vm_ops;
> +
> +#define ASSERT_TRUE(_expr)						\
> +	do {								\
> +		if (!(_expr)) {						\
> +			fprintf(stderr,					\
> +				"Assert FAILED at %s:%d:%s(): %s is FALSE.\n", \
> +				__FILE__, __LINE__, __FUNCTION__, #_expr); \
> +			return false;					\
> +		}							\
> +	} while (0)
> +#define ASSERT_FALSE(_expr) ASSERT_TRUE(!(_expr))
> +#define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
> +#define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
> +
> +static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
> +					unsigned long start,
> +					unsigned long end,
> +					pgoff_t pgoff,
> +					vm_flags_t flags)
> +{
> +	struct vm_area_struct *ret = vm_area_alloc(mm);
> +
> +	if (ret == NULL)
> +		return NULL;
> +
> +	ret->vm_start = start;
> +	ret->vm_end = end;
> +	ret->vm_pgoff = pgoff;
> +	ret->__vm_flags = flags;
> +
> +	return ret;
> +}
> +
> +static bool test_simple_merge(void)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
> +	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
> +	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
> +	VMA_ITERATOR(vmi, &mm, 0x1000);
> +
> +	ASSERT_FALSE(vma_link(&mm, vma_left));
> +	ASSERT_FALSE(vma_link(&mm, vma_middle));
> +	ASSERT_FALSE(vma_link(&mm, vma_right));

So, vma_link() returns the error if failed, or zero, and therefore above
assertions check if the function calls success as expected?  It maybe too
straighforward to people who familiar with the code, but I think adding some
comment explaining the intent of the test would be nice for new comers.

IMHO, 'ASSERT_EQ(vma_link(...), 0)' may be easier to read.

Also, in case of assertion failures, the assertion prints the error and return
false, to indicate the failure of the test, right?  Then, would the memory
allocated before, e.g., that for vma_{left,middle,right} above be leaked?  I
know this is just a test program in the user-space, but...  If this is
intentional, I think clarifying it somewhere would be nice.

> +
> +	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
> +				0x2000, 1);
> +	ASSERT_NE(vma, NULL);
> +
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x3000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +	ASSERT_EQ(vma->vm_flags, flags);
> +
> +	vm_area_free(vma);
> +	mtree_destroy(&mm.mm_mt);
> +
> +	return true;
> +}
> +
> +static bool test_simple_modify(void)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
> +	VMA_ITERATOR(vmi, &mm, 0x1000);
> +
> +	ASSERT_FALSE(vma_link(&mm, init_vma));
> +
> +	/*
> +	 * The flags will not be changed, the vma_modify_flags() function
> +	 * performs the merge/split only.
> +	 */
> +	vma = vma_modify_flags(&vmi, init_vma, init_vma,
> +			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
> +	ASSERT_NE(vma, NULL);
> +	/* We modify the provided VMA, and on split allocate new VMAs. */
> +	ASSERT_EQ(vma, init_vma);
> +
> +	ASSERT_EQ(vma->vm_start, 0x1000);
> +	ASSERT_EQ(vma->vm_end, 0x2000);
> +	ASSERT_EQ(vma->vm_pgoff, 1);
> +
> +	/*
> +	 * Now walk through the three split VMAs and make sure they are as
> +	 * expected.
> +	 */

I like these kind comments :)

> +
> +	vma_iter_set(&vmi, 0);
> +	vma = vma_iter_load(&vmi);
> +
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x1000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +
> +	vm_area_free(vma);
> +	vma_iter_clear(&vmi);
> +
> +	vma = vma_next(&vmi);
> +
> +	ASSERT_EQ(vma->vm_start, 0x1000);
> +	ASSERT_EQ(vma->vm_end, 0x2000);
> +	ASSERT_EQ(vma->vm_pgoff, 1);
> +
> +	vm_area_free(vma);
> +	vma_iter_clear(&vmi);
> +
> +	vma = vma_next(&vmi);
> +
> +	ASSERT_EQ(vma->vm_start, 0x2000);
> +	ASSERT_EQ(vma->vm_end, 0x3000);
> +	ASSERT_EQ(vma->vm_pgoff, 2);
> +
> +	vm_area_free(vma);
> +	mtree_destroy(&mm.mm_mt);
> +
> +	return true;
> +}
> +
> +static bool test_simple_expand(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
> +	VMA_ITERATOR(vmi, &mm, 0);
> +
> +	ASSERT_FALSE(vma_link(&mm, vma));
> +
> +	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
> +
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x3000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +
> +	vm_area_free(vma);
> +	mtree_destroy(&mm.mm_mt);
> +
> +	return true;
> +}
> +
> +static bool test_simple_shrink(void)
> +{
> +	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
> +	struct mm_struct mm = {};
> +	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
> +	VMA_ITERATOR(vmi, &mm, 0);
> +
> +	ASSERT_FALSE(vma_link(&mm, vma));
> +
> +	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
> +
> +	ASSERT_EQ(vma->vm_start, 0);
> +	ASSERT_EQ(vma->vm_end, 0x1000);
> +	ASSERT_EQ(vma->vm_pgoff, 0);
> +
> +	vm_area_free(vma);
> +	mtree_destroy(&mm.mm_mt);
> +
> +	return true;
> +}
> +
> +int main(void)
> +{
> +	int num_tests = 0, num_fail = 0;
> +
> +	maple_tree_init();
> +
> +#define TEST(name)							\
> +	do {								\
> +		num_tests++;						\
> +		if (!test_##name()) {					\
> +			num_fail++;					\
> +			fprintf(stderr, "Test " #name " FAILED\n");	\
> +		}							\
> +	} while (0)
> +
> +	TEST(simple_merge);
> +	TEST(simple_modify);
> +	TEST(simple_expand);
> +	TEST(simple_shrink);
> +
> +#undef TEST
> +
> +	printf("%d tests run, %d passed, %d failed.\n",
> +	       num_tests, num_tests - num_fail, num_fail);
> +
> +	return EXIT_SUCCESS;

What do you think about making the return value indicates if the overall test
has pass or failed, for easy integration with other test frameworks or scripts
in future?

[...]

I didn't read all of this patch series in detail yet (I'm not sure if I'll have
time to do that, so please don't wait for me), but looks nice work overall to
me.  Thank you for your efforts on this.


Thanks,
SJ

