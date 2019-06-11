Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCE3C8E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 12:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405446AbfFKK0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 06:26:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405432AbfFKK0H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:26:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CF457ADDD;
        Tue, 11 Jun 2019 10:26:04 +0000 (UTC)
Subject: Re: [PATCH 10/12] bcache: move closures to lib/
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <20190610191420.27007-11-kent.overstreet@gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <3642ab83-d59f-4572-4cd6-3db946c8319f@suse.de>
Date:   Tue, 11 Jun 2019 18:25:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610191420.27007-11-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/6/11 3:14 上午, Kent Overstreet wrote:
> Prep work for bcachefs - being a fork of bcache it also uses closures
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Acked-by: Coly Li <colyli@suse.de>

Thanks.

Coly Li


> ---
>  drivers/md/bcache/Kconfig                     | 10 +------
>  drivers/md/bcache/Makefile                    |  6 ++--
>  drivers/md/bcache/bcache.h                    |  2 +-
>  drivers/md/bcache/super.c                     |  1 -
>  drivers/md/bcache/util.h                      |  3 +-
>  .../md/bcache => include/linux}/closure.h     | 17 ++++++-----
>  lib/Kconfig                                   |  3 ++
>  lib/Kconfig.debug                             |  9 ++++++
>  lib/Makefile                                  |  2 ++
>  {drivers/md/bcache => lib}/closure.c          | 28 ++++++-------------
>  10 files changed, 37 insertions(+), 44 deletions(-)
>  rename {drivers/md/bcache => include/linux}/closure.h (97%)
>  rename {drivers/md/bcache => lib}/closure.c (89%)
> 
> diff --git a/drivers/md/bcache/Kconfig b/drivers/md/bcache/Kconfig
> index f6e0a8b3a6..3dd1d48987 100644
> --- a/drivers/md/bcache/Kconfig
> +++ b/drivers/md/bcache/Kconfig
> @@ -2,6 +2,7 @@
>  config BCACHE
>  	tristate "Block device as cache"
>  	select CRC64
> +	select CLOSURES
>  	help
>  	Allows a block device to be used as cache for other devices; uses
>  	a btree for indexing and the layout is optimized for SSDs.
> @@ -16,12 +17,3 @@ config BCACHE_DEBUG
>  
>  	Enables extra debugging tools, allows expensive runtime checks to be
>  	turned on.
> -
> -config BCACHE_CLOSURES_DEBUG
> -	bool "Debug closures"
> -	depends on BCACHE
> -	select DEBUG_FS
> -	help
> -	Keeps all active closures in a linked list and provides a debugfs
> -	interface to list them, which makes it possible to see asynchronous
> -	operations that get stuck.
> diff --git a/drivers/md/bcache/Makefile b/drivers/md/bcache/Makefile
> index d26b351958..2b790fb813 100644
> --- a/drivers/md/bcache/Makefile
> +++ b/drivers/md/bcache/Makefile
> @@ -2,8 +2,8 @@
>  
>  obj-$(CONFIG_BCACHE)	+= bcache.o
>  
> -bcache-y		:= alloc.o bset.o btree.o closure.o debug.o extents.o\
> -	io.o journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o\
> -	util.o writeback.o
> +bcache-y		:= alloc.o bset.o btree.o debug.o extents.o io.o\
> +	journal.o movinggc.o request.o stats.o super.o sysfs.o trace.o util.o\
> +	writeback.o
>  
>  CFLAGS_request.o	+= -Iblock
> diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
> index fdf75352e1..ced9f1526c 100644
> --- a/drivers/md/bcache/bcache.h
> +++ b/drivers/md/bcache/bcache.h
> @@ -180,6 +180,7 @@
>  
>  #include <linux/bcache.h>
>  #include <linux/bio.h>
> +#include <linux/closure.h>
>  #include <linux/kobject.h>
>  #include <linux/list.h>
>  #include <linux/mutex.h>
> @@ -192,7 +193,6 @@
>  
>  #include "bset.h"
>  #include "util.h"
> -#include "closure.h"
>  
>  struct bucket {
>  	atomic_t	pin;
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index a697a3a923..da6803f280 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2487,7 +2487,6 @@ static int __init bcache_init(void)
>  		goto err;
>  
>  	bch_debug_init();
> -	closure_debug_init();
>  
>  	return 0;
>  err:
> diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
> index 00aab6abcf..8a75100c0b 100644
> --- a/drivers/md/bcache/util.h
> +++ b/drivers/md/bcache/util.h
> @@ -4,6 +4,7 @@
>  #define _BCACHE_UTIL_H
>  
>  #include <linux/blkdev.h>
> +#include <linux/closure.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/clock.h>
> @@ -13,8 +14,6 @@
>  #include <linux/workqueue.h>
>  #include <linux/crc64.h>
>  
> -#include "closure.h"
> -
>  #define PAGE_SECTORS		(PAGE_SIZE / 512)
>  
>  struct closure;
> diff --git a/drivers/md/bcache/closure.h b/include/linux/closure.h
> similarity index 97%
> rename from drivers/md/bcache/closure.h
> rename to include/linux/closure.h
> index 376c5e659c..308e38028c 100644
> --- a/drivers/md/bcache/closure.h
> +++ b/include/linux/closure.h
> @@ -155,7 +155,7 @@ struct closure {
>  
>  	atomic_t		remaining;
>  
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  #define CLOSURE_MAGIC_DEAD	0xc054dead
>  #define CLOSURE_MAGIC_ALIVE	0xc054a11e
>  
> @@ -184,15 +184,13 @@ static inline void closure_sync(struct closure *cl)
>  		__closure_sync(cl);
>  }
>  
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  
> -void closure_debug_init(void);
>  void closure_debug_create(struct closure *cl);
>  void closure_debug_destroy(struct closure *cl);
>  
>  #else
>  
> -static inline void closure_debug_init(void) {}
>  static inline void closure_debug_create(struct closure *cl) {}
>  static inline void closure_debug_destroy(struct closure *cl) {}
>  
> @@ -200,21 +198,21 @@ static inline void closure_debug_destroy(struct closure *cl) {}
>  
>  static inline void closure_set_ip(struct closure *cl)
>  {
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  	cl->ip = _THIS_IP_;
>  #endif
>  }
>  
>  static inline void closure_set_ret_ip(struct closure *cl)
>  {
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  	cl->ip = _RET_IP_;
>  #endif
>  }
>  
>  static inline void closure_set_waiting(struct closure *cl, unsigned long f)
>  {
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  	cl->waiting_on = f;
>  #endif
>  }
> @@ -243,6 +241,7 @@ static inline void closure_queue(struct closure *cl)
>  	 */
>  	BUILD_BUG_ON(offsetof(struct closure, fn)
>  		     != offsetof(struct work_struct, func));
> +
>  	if (wq) {
>  		INIT_WORK(&cl->work, cl->work.func);
>  		queue_work(wq, &cl->work);
> @@ -255,7 +254,7 @@ static inline void closure_queue(struct closure *cl)
>   */
>  static inline void closure_get(struct closure *cl)
>  {
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  	BUG_ON((atomic_inc_return(&cl->remaining) &
>  		CLOSURE_REMAINING_MASK) <= 1);
>  #else
> @@ -271,7 +270,7 @@ static inline void closure_get(struct closure *cl)
>   */
>  static inline void closure_init(struct closure *cl, struct closure *parent)
>  {
> -	memset(cl, 0, sizeof(struct closure));
> +	cl->fn = NULL;
>  	cl->parent = parent;
>  	if (parent)
>  		closure_get(parent);
> diff --git a/lib/Kconfig b/lib/Kconfig
> index a9e56539bd..09a25af0d0 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -427,6 +427,9 @@ config ASSOCIATIVE_ARRAY
>  
>  	  for more information.
>  
> +config CLOSURES
> +	bool
> +
>  config HAS_IOMEM
>  	bool
>  	depends on !NO_IOMEM
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d5a4a4036d..6d97985e7e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1397,6 +1397,15 @@ config DEBUG_CREDENTIALS
>  
>  source "kernel/rcu/Kconfig.debug"
>  
> +config DEBUG_CLOSURES
> +	bool "Debug closures (bcache async widgits)"
> +	depends on CLOSURES
> +	select DEBUG_FS
> +	help
> +	Keeps all active closures in a linked list and provides a debugfs
> +	interface to list them, which makes it possible to see asynchronous
> +	operations that get stuck.
> +
>  config DEBUG_WQ_FORCE_RR_CPU
>  	bool "Force round-robin CPU selection for unbound work items"
>  	depends on DEBUG_KERNEL
> diff --git a/lib/Makefile b/lib/Makefile
> index 18c2be516a..2003eda127 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -193,6 +193,8 @@ obj-$(CONFIG_ATOMIC64_SELFTEST) += atomic64_test.o
>  
>  obj-$(CONFIG_CPU_RMAP) += cpu_rmap.o
>  
> +obj-$(CONFIG_CLOSURES) += closure.o
> +
>  obj-$(CONFIG_CORDIC) += cordic.o
>  
>  obj-$(CONFIG_DQL) += dynamic_queue_limits.o
> diff --git a/drivers/md/bcache/closure.c b/lib/closure.c
> similarity index 89%
> rename from drivers/md/bcache/closure.c
> rename to lib/closure.c
> index 73f5319295..46cfe4c382 100644
> --- a/drivers/md/bcache/closure.c
> +++ b/lib/closure.c
> @@ -6,13 +6,12 @@
>   * Copyright 2012 Google, Inc.
>   */
>  
> +#include <linux/closure.h>
>  #include <linux/debugfs.h>
> -#include <linux/module.h>
> +#include <linux/export.h>
>  #include <linux/seq_file.h>
>  #include <linux/sched/debug.h>
>  
> -#include "closure.h"
> -
>  static inline void closure_put_after_sub(struct closure *cl, int flags)
>  {
>  	int r = flags & CLOSURE_REMAINING_MASK;
> @@ -127,7 +126,7 @@ void __sched __closure_sync(struct closure *cl)
>  }
>  EXPORT_SYMBOL(__closure_sync);
>  
> -#ifdef CONFIG_BCACHE_CLOSURES_DEBUG
> +#ifdef CONFIG_DEBUG_CLOSURES
>  
>  static LIST_HEAD(closure_list);
>  static DEFINE_SPINLOCK(closure_list_lock);
> @@ -158,8 +157,6 @@ void closure_debug_destroy(struct closure *cl)
>  }
>  EXPORT_SYMBOL(closure_debug_destroy);
>  
> -static struct dentry *closure_debug;
> -
>  static int debug_seq_show(struct seq_file *f, void *data)
>  {
>  	struct closure *cl;
> @@ -182,7 +179,7 @@ static int debug_seq_show(struct seq_file *f, void *data)
>  			seq_printf(f, " W %pS\n",
>  				   (void *) cl->waiting_on);
>  
> -		seq_printf(f, "\n");
> +		seq_puts(f, "\n");
>  	}
>  
>  	spin_unlock_irq(&closure_list_lock);
> @@ -201,18 +198,11 @@ static const struct file_operations debug_ops = {
>  	.release	= single_release
>  };
>  
> -void  __init closure_debug_init(void)
> +static int __init closure_debug_init(void)
>  {
> -	if (!IS_ERR_OR_NULL(bcache_debug))
> -		/*
> -		 * it is unnecessary to check return value of
> -		 * debugfs_create_file(), we should not care
> -		 * about this.
> -		 */
> -		closure_debug = debugfs_create_file(
> -			"closures", 0400, bcache_debug, NULL, &debug_ops);
> +	debugfs_create_file("closures", 0400, NULL, NULL, &debug_ops);
> +	return 0;
>  }
> -#endif
> +late_initcall(closure_debug_init)
>  
> -MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
> -MODULE_LICENSE("GPL");
> +#endif
> 


-- 

Coly Li
