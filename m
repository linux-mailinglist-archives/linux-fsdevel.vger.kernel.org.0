Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80CE46BF60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbhLGPgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 10:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhLGPgF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:36:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAB1C061574;
        Tue,  7 Dec 2021 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BurdL9CoYhvyq3FVTEq/kmPu0MyElA+TlhLVyir3/R0=; b=j0UyoYlZuTg6aH2j9xf4JGORW1
        bdeqF6foQxA3ClXobjdChUFB2Xleavfo55fPkfJ9ttSFenrKUfCSy9UL/yIlGuTs+MNXBDk/lEddE
        xh1clHwdrjdHcM/w8u46Tb4JN0r3Q/rW5Hj+AuzpZjPmIIJW/rgq1NSAhnQ7I5w1kk2P0agL5xpr3
        sQEQZT0hwr/KaspIF6zNQz+7CPKkqKeKYFpceb+AZ/R0Z09gNxlkQ5Ed5wjyvnL/8OME0GA0gxYLb
        1NvuUj3FETVOyTgO8Wx8DK+8R1SWi7AGYL2N/I+uQWNtMkgi/BVsa9ry6XxPw35kiyhUTzShftWAt
        sLg0J9UQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mucSE-007UJj-8t; Tue, 07 Dec 2021 15:32:30 +0000
Date:   Tue, 7 Dec 2021 15:32:30 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, kernelci@groups.io,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC 2/3] headers: introduce linux/struct_types.h
Message-ID: <Ya9+jqIPJ8y0/Q4s@casper.infradead.org>
References: <20211207150927.3042197-1-arnd@kernel.org>
 <20211207150927.3042197-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207150927.3042197-3-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:09:26PM +0100, Arnd Bergmann wrote:
> Working towards a cleaner header structure, start by moving the most
> commonly embedded structures into a single header file that itself
> has only a minimum set of indirect includes. At this moment, this
> include structures for
> 
>  - locking
>  - timers
>  - work queues
>  - waitqueues
>  - rcu
>  - xarray
>  - kobject
>  - bio_vec

I generally support all of this.  I did look at adding struct xarray to
types.h when I first added it, but was stymied by the need to embed the
spinlock.  I looked at adding a linux/adt.h or a linux/struct.h but
it was just too much work.  So thank you for taking this on.

> diff --git a/include/linux/struct_types.h b/include/linux/struct_types.h
> new file mode 100644
> index 000000000000..5a06849fd347
> --- /dev/null
> +++ b/include/linux/struct_types.h
> @@ -0,0 +1,483 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_STRUCT_TYPES_H
> +#define __LINUX_STRUCT_TYPES_H
> +/*
> + * This header includes data structures that build on top of
> + * the plain types from linux/types.h and that are commonly
> + * embedded within other structures in the kernel.
> + *
> + * By keeping these in one place that has a minimum set of
> + * indirect includes, we can avoid deeply nested include
> + * hierarchies that slow down the build and cause frequent
> + * recompiles after header changes.
> + *
> + * Be careful about including further headers here.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/bits.h>
> +#include <linux/threads.h>
> +#include <linux/lockdep_types.h>
> +#include <linux/rbtree_types.h>
> +
> +#if defined(CONFIG_SMP)
> +# include <asm/spinlock_types.h>
> +#else
> +# include <linux/spinlock_types_up.h>
> +#endif
> +
> +/**
> + * typedef refcount_t - variant of atomic_t specialized for reference counts
> + * @refs: atomic_t counter field
> + *
> + * The counter saturates at REFCOUNT_SATURATED and will not move once
> + * there. This avoids wrapping the counter and causing 'spurious'
> + * use-after-free bugs.
> + */

There's no corresponding patch to Documentation, so this kernel-doc is
orphaned.

> diff --git a/include/linux/swait.h b/include/linux/swait.h
> index 6a8c22b8c2a5..d7798752922d 100644
> --- a/include/linux/swait.h
> +++ b/include/linux/swait.h
> @@ -38,18 +38,6 @@
>   * wait queues in most cases.
>   */
>  
> -struct task_struct;
> -
> -struct swait_queue_head {
> -	raw_spinlock_t		lock;
> -	struct list_head	task_list;
> -};
> -
> -struct swait_queue {
> -	struct task_struct	*task;
> -	struct list_head	task_list;
> -};
> -
>  #define __SWAITQUEUE_INITIALIZER(name) {				\
>  	.task		= current,					\
>  	.task_list	= LIST_HEAD_INIT((name).task_list),		\

swait.h doesn't need to include <linux/struct_types.h> ?

> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index a91e3d90df8a..4f1e55074ef0 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -275,29 +275,6 @@ enum xa_lock_type {
>  #define XA_FLAGS_ALLOC	(XA_FLAGS_TRACK_FREE | XA_FLAGS_MARK(XA_FREE_MARK))
>  #define XA_FLAGS_ALLOC1	(XA_FLAGS_TRACK_FREE | XA_FLAGS_ZERO_BUSY)
>  
> -/**
> - * struct xarray - The anchor of the XArray.
> - * @xa_lock: Lock that protects the contents of the XArray.
> - *
> - * To use the xarray, define it statically or embed it in your data structure.
> - * It is a very small data structure, so it does not usually make sense to
> - * allocate it separately and keep a pointer to it in your data structure.
> - *
> - * You may use the xa_lock to protect your own data structures as well.
> - */
> -/*
> - * If all of the entries in the array are NULL, @xa_head is a NULL pointer.
> - * If the only non-NULL entry in the array is at index 0, @xa_head is that
> - * entry.  If any other entry in the array is non-NULL, @xa_head points
> - * to an @xa_node.
> - */
> -struct xarray {
> -	spinlock_t	xa_lock;
> -/* private: The rest of the data structure is not to be used directly. */
> -	gfp_t		xa_flags;
> -	void __rcu *	xa_head;
> -};
> -
>  #define XARRAY_INIT(name, flags) {				\
>  	.xa_lock = __SPIN_LOCK_UNLOCKED(name.xa_lock),		\
>  	.xa_flags = flags,					\

I think this is going to break:

(cd tools/testing/radix-tree; make)
