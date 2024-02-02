Return-Path: <linux-fsdevel+bounces-9965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4E84694D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 08:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DED71C24B57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9BF17BB7;
	Fri,  2 Feb 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoRZpllh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8035717998;
	Fri,  2 Feb 2024 07:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859035; cv=none; b=j2EOVJ1Tb/veyYU9wt3C6NWtfZ5+hjdN7Fc2LmgtVFITsbsX8pq97bjHU4hBpE3y61x0UxP+AWiLpvLzPdWQLMaudYiPyZC3o76S0DblBTNNKunW1b6U5gCM1R1ZVXMbzFsZQW2FZR5RHce5IHYQ3aap6HQpfSBN1deaXHzwEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859035; c=relaxed/simple;
	bh=ctJynnj1nxK56C5o2I4DSfBBAA8i9yhTI3eCstGnKp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THMIJQmnp7EjbAEPCCbkqh82+OEb1EleCpmQp8heHI3m+q6NMezYTzl5Kx3GyNl7q3ia8CA7iO71RpqsYpC68bgFoYQKy4l8cjq53dgTo5U4uYZFF33jcO0yelfY34Vth1qnzF63dQeWPdbyy0tCrhZxtqsyGfcSF3nV3reQ0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoRZpllh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1901C433F1;
	Fri,  2 Feb 2024 07:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706859035;
	bh=ctJynnj1nxK56C5o2I4DSfBBAA8i9yhTI3eCstGnKp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QoRZpllhRn7N5QLMovtRrjgmqps6sBMynuyfZPcTZ0E0iDQ4l4Tm5ckFgAkBHgjnx
	 1rr9NA6DmxSVcItyE7pIKcT7fhaSYbHXwVy5NOhnPI6GqC7l277T0/S+BQJKRMb1gj
	 YqHB1F36pkUSJpyU8iHeyUV9ey5ckrm8A0vOY0ymcMvBLtPLUbPx+KbxpIdGh0dDKf
	 sghzhZnRNY0zQqE9VsLYp3tEkypW8nAywJqKgNpIEYvvZn9/51EJvbuQNL/6Dec7K5
	 OGT/UvfoJhejZ3RBtgOfdV8/Hd6JudlP/Cd4RvKSAtydNbu6D5zO+KpBYcPhOgfZIq
	 8huAL27c63fcA==
Date: Thu, 1 Feb 2024 23:30:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-bcache@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	Daniel Hill <daniel@gluo.nz>
Subject: Re: [PATCH 1/5] mean and variance: Promote to lib/math
Message-ID: <20240202073034.GG6184@frogsfrogsfrogs>
References: <20240126220655.395093-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126220655.395093-1-kent.overstreet@linux.dev>

On Fri, Jan 26, 2024 at 05:06:51PM -0500, Kent Overstreet wrote:
> Small statistics library, for taking in a series of value and computing
> mean, weighted mean, standard deviation and weighted deviation.
> 
> The main use case is for statistics on latency measurements.

Oh, heh, I didn't realize this was a patch and not a cover letter.

A few things I noticed while adding timestats to xfs -- pahole says this
about the weighted mean and variance object:

struct mean_and_variance_weighted {
        /* typedef bool */ _Bool                      init;                              /*     0     1 */
        /* typedef u8 -> __u8 */ unsigned char              weight;                      /*     1     1 */

        /* XXX 6 bytes hole, try to pack */

        /* typedef s64 -> __s64 */ long long int              mean;                      /*     8     8 */
        /* typedef u64 -> __u64 */ long long unsigned int     variance;                  /*    16     8 */

        /* size: 24, cachelines: 1, members: 4 */
        /* sum members: 18, holes: 1, sum holes: 6 */
        /* last cacheline: 24 bytes */
};

AFAICT the init flag isn't used, and the u8 wastes 6 bytes of space.
Two of these get plugged into struct time_stats, which means we waste 12
bytes of space on a ~464 byte structure.  Removing quantiles support
from that shrinks the struct down to 208 bytes.

Any chance we could pass in the weights as a function parameter so that
we could shrink this to 16 bytes?  If we do that and rearrange
time_stats, the whole thing goes down to 192 bytes, which means I can
spray in twice as many timestats.

I also noticed that struct time_stat_buffer is:

struct time_stat_buffer {
        unsigned int               nr;                                                   /*     0     4 */

        /* XXX 4 bytes hole, try to pack */

        struct time_stat_buffer_entry {
                /* typedef u64 -> __u64 */ long long unsigned int start;                 /*     8     8 */
                /* typedef u64 -> __u64 */ long long unsigned int end;                   /*    16     8 */
        } entries[32]; /*     8   512 */

        /* size: 520, cachelines: 9, members: 2 */
        /* sum members: 516, holes: 1, sum holes: 4 */
        /* last cacheline: 8 bytes */
};

I wonder, if entries[] shrank to 31 entries, this would align to 512b;
would that make for more efficient allocations?  I tried to follow
alloc_percpu_gfp and got caught in a twisty mess of macros.

--D

FWIW the full time_stats struct ended up like this after I turned off
quantiles and did all the lazy rearranging I could do without removing
init or weight:

struct time_stats {
        /* typedef spinlock_t */ struct spinlock {
                union {
                        struct raw_spinlock {
                                /* typedef arch_spinlock_t */ struct qspinlock {
                                        union {
                                                /* typedef atomic_t */ struct {
                                                        int                    counter;  /*     0     4 */
                                                } val; /*     0     4 */
                                                struct {
                                                        /* typedef u8 -> __u8 */ unsigned char          locked; /*     0     1 */
                                                        /* typedef u8 -> __u8 */ unsigned char          pending; /*     1     1 */
                                                };                                       /*     0     2 */
                                                struct {
                                                        /* typedef u16 -> __u16 */ short unsigned int     locked_pending; /*     0     2 */
                                                        /* typedef u16 -> __u16 */ short unsigned int     tail; /*     2     2 */
                                                };                                       /*     0     4 */
                                        };                                               /*     0     4 */
                                } raw_lock; /*     0     4 */
                                unsigned int magic;                                      /*     4     4 */
                                unsigned int owner_cpu;                                  /*     8     4 */

                                /* XXX 4 bytes hole, try to pack */

                                void * owner;                                            /*    16     8 */
                        }rlock; /*     0    24 */
                };                                                                       /*     0    24 */
        } lock; /*     0    24 */
        /* typedef u64 -> __u64 */ long long unsigned int     min_duration;              /*    24     8 */
        /* typedef u64 -> __u64 */ long long unsigned int     max_duration;              /*    32     8 */
        /* typedef u64 -> __u64 */ long long unsigned int     total_duration;            /*    40     8 */
        /* typedef u64 -> __u64 */ long long unsigned int     max_freq;                  /*    48     8 */
        /* typedef u64 -> __u64 */ long long unsigned int     min_freq;                  /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        /* typedef u64 -> __u64 */ long long unsigned int     last_event;                /*    64     8 */
        /* typedef u64 -> __u64 */ long long unsigned int     last_event_start;          /*    72     8 */
        struct mean_and_variance {
                /* typedef s64 -> __s64 */ long long int      n;                         /*    80     8 */
                /* typedef s64 -> __s64 */ long long int      sum;                       /*    88     8 */
                /* typedef u128_u */ struct {
                        __int128 unsigned v;                                             /*    96    16 */
                } sum_squares __attribute__((__aligned__(16))) __attribute__((__aligned__(16))); /*    96    16 */
        } __attribute__((__aligned__(16)))duration_stats __attribute__((__aligned__(16))); /*    80    32 */
        struct mean_and_variance {
                /* typedef s64 -> __s64 */ long long int      n;                         /*   112     8 */
                /* typedef s64 -> __s64 */ long long int      sum;                       /*   120     8 */
                /* --- cacheline 2 boundary (128 bytes) --- */
                /* typedef u128_u */ struct {
                        __int128 unsigned v;                                             /*   128    16 */
                } sum_squares __attribute__((__aligned__(16))) __attribute__((__aligned__(16))); /*   128    16 */
        } __attribute__((__aligned__(16)))freq_stats __attribute__((__aligned__(16))); /*   112    32 */
        struct mean_and_variance_weighted {
                /* typedef bool */ _Bool              init;                              /*   144     1 */
                /* typedef u8 -> __u8 */ unsigned char      weight;                      /*   145     1 */

                /* XXX 6 bytes hole, try to pack */

                /* typedef s64 -> __s64 */ long long int      mean;                      /*   152     8 */
                /* typedef u64 -> __u64 */ long long unsigned int variance;              /*   160     8 */
        }duration_stats_weighted; /*   144    24 */
        struct mean_and_variance_weighted {
                /* typedef bool */ _Bool              init;                              /*   168     1 */
                /* typedef u8 -> __u8 */ unsigned char      weight;                      /*   169     1 */

                /* XXX 6 bytes hole, try to pack */

                /* typedef s64 -> __s64 */ long long int      mean;                      /*   176     8 */
                /* typedef u64 -> __u64 */ long long unsigned int variance;              /*   184     8 */
        }freq_stats_weighted; /*   168    24 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        struct time_stat_buffer *  buffer;                                               /*   192     8 */

        /* size: 208, cachelines: 4, members: 13 */
        /* padding: 8 */
        /* forced alignments: 2 */
        /* last cacheline: 16 bytes */
} __attribute__((__aligned__(16)));


> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Daniel Hill <daniel@gluo.nz>
> Cc: Darrick J. Wong <djwong@kernel.org>
> ---
>  MAINTAINERS                                        |  9 +++++++++
>  fs/bcachefs/Kconfig                                | 10 +---------
>  fs/bcachefs/Makefile                               |  3 ---
>  fs/bcachefs/util.c                                 |  2 +-
>  fs/bcachefs/util.h                                 |  3 +--
>  {fs/bcachefs => include/linux}/mean_and_variance.h |  0
>  lib/Kconfig.debug                                  |  9 +++++++++
>  lib/math/Kconfig                                   |  3 +++
>  lib/math/Makefile                                  |  2 ++
>  {fs/bcachefs => lib/math}/mean_and_variance.c      |  3 +--
>  {fs/bcachefs => lib/math}/mean_and_variance_test.c |  3 +--
>  11 files changed, 28 insertions(+), 19 deletions(-)
>  rename {fs/bcachefs => include/linux}/mean_and_variance.h (100%)
>  rename {fs/bcachefs => lib/math}/mean_and_variance.c (99%)
>  rename {fs/bcachefs => lib/math}/mean_and_variance_test.c (99%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..de635cfd354d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13379,6 +13379,15 @@ S:	Maintained
>  F:	drivers/net/mdio/mdio-regmap.c
>  F:	include/linux/mdio/mdio-regmap.h
>  
> +MEAN AND VARIANCE LIBRARY
> +M:	Daniel B. Hill <daniel@gluo.nz>
> +M:	Kent Overstreet <kent.overstreet@linux.dev>
> +S:	Maintained
> +T:	git https://github.com/YellowOnion/linux/
> +F:	include/linux/mean_and_variance.h
> +F:	lib/math/mean_and_variance.c
> +F:	lib/math/mean_and_variance_test.c
> +
>  MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
>  M:	William Breathitt Gray <william.gray@linaro.org>
>  L:	linux-iio@vger.kernel.org
> diff --git a/fs/bcachefs/Kconfig b/fs/bcachefs/Kconfig
> index 5cdfef3b551a..72d1179262b3 100644
> --- a/fs/bcachefs/Kconfig
> +++ b/fs/bcachefs/Kconfig
> @@ -24,6 +24,7 @@ config BCACHEFS_FS
>  	select XXHASH
>  	select SRCU
>  	select SYMBOLIC_ERRNAME
> +	select MEAN_AND_VARIANCE
>  	help
>  	The bcachefs filesystem - a modern, copy on write filesystem, with
>  	support for multiple devices, compression, checksumming, etc.
> @@ -86,12 +87,3 @@ config BCACHEFS_SIX_OPTIMISTIC_SPIN
>  	Instead of immediately sleeping when attempting to take a six lock that
>  	is held by another thread, spin for a short while, as long as the
>  	thread owning the lock is running.
> -
> -config MEAN_AND_VARIANCE_UNIT_TEST
> -	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
> -	depends on KUNIT
> -	depends on BCACHEFS_FS
> -	default KUNIT_ALL_TESTS
> -	help
> -	  This option enables the kunit tests for mean_and_variance module.
> -	  If unsure, say N.
> diff --git a/fs/bcachefs/Makefile b/fs/bcachefs/Makefile
> index 1a05cecda7cc..b11ba74b8ad4 100644
> --- a/fs/bcachefs/Makefile
> +++ b/fs/bcachefs/Makefile
> @@ -57,7 +57,6 @@ bcachefs-y		:=	\
>  	keylist.o		\
>  	logged_ops.o		\
>  	lru.o			\
> -	mean_and_variance.o	\
>  	migrate.o		\
>  	move.o			\
>  	movinggc.o		\
> @@ -88,5 +87,3 @@ bcachefs-y		:=	\
>  	util.o			\
>  	varint.o		\
>  	xattr.o
> -
> -obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
> diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
> index 56b815fd9fc6..d7ea95abb9df 100644
> --- a/fs/bcachefs/util.c
> +++ b/fs/bcachefs/util.c
> @@ -22,9 +22,9 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/sched/clock.h>
> +#include <linux/mean_and_variance.h>
>  
>  #include "eytzinger.h"
> -#include "mean_and_variance.h"
>  #include "util.h"
>  
>  static const char si_units[] = "?kMGTPEZY";
> diff --git a/fs/bcachefs/util.h b/fs/bcachefs/util.h
> index b414736d59a5..0059481995ef 100644
> --- a/fs/bcachefs/util.h
> +++ b/fs/bcachefs/util.h
> @@ -17,8 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/workqueue.h>
> -
> -#include "mean_and_variance.h"
> +#include <linux/mean_and_variance.h>
>  
>  #include "darray.h"
>  
> diff --git a/fs/bcachefs/mean_and_variance.h b/include/linux/mean_and_variance.h
> similarity index 100%
> rename from fs/bcachefs/mean_and_variance.h
> rename to include/linux/mean_and_variance.h
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 975a07f9f1cc..817ddfe132cd 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2191,6 +2191,15 @@ config CPUMASK_KUNIT_TEST
>  
>  	  If unsure, say N.
>  
> +config MEAN_AND_VARIANCE_UNIT_TEST
> +	tristate "mean_and_variance unit tests" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	select MEAN_AND_VARIANCE
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option enables the kunit tests for mean_and_variance module.
> +	  If unsure, say N.
> +
>  config TEST_LIST_SORT
>  	tristate "Linked list sorting test" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/lib/math/Kconfig b/lib/math/Kconfig
> index 0634b428d0cb..7530ae9a3584 100644
> --- a/lib/math/Kconfig
> +++ b/lib/math/Kconfig
> @@ -15,3 +15,6 @@ config PRIME_NUMBERS
>  
>  config RATIONAL
>  	tristate
> +
> +config MEAN_AND_VARIANCE
> +	tristate
> diff --git a/lib/math/Makefile b/lib/math/Makefile
> index 91fcdb0c9efe..8cdfa13a67ce 100644
> --- a/lib/math/Makefile
> +++ b/lib/math/Makefile
> @@ -4,6 +4,8 @@ obj-y += div64.o gcd.o lcm.o int_log.o int_pow.o int_sqrt.o reciprocal_div.o
>  obj-$(CONFIG_CORDIC)		+= cordic.o
>  obj-$(CONFIG_PRIME_NUMBERS)	+= prime_numbers.o
>  obj-$(CONFIG_RATIONAL)		+= rational.o
> +obj-$(CONFIG_MEAN_AND_VARIANCE) += mean_and_variance.o
>  
>  obj-$(CONFIG_TEST_DIV64)	+= test_div64.o
>  obj-$(CONFIG_RATIONAL_KUNIT_TEST) += rational-test.o
> +obj-$(CONFIG_MEAN_AND_VARIANCE_UNIT_TEST)   += mean_and_variance_test.o
> diff --git a/fs/bcachefs/mean_and_variance.c b/lib/math/mean_and_variance.c
> similarity index 99%
> rename from fs/bcachefs/mean_and_variance.c
> rename to lib/math/mean_and_variance.c
> index bf0ef668fd38..ba90293204ba 100644
> --- a/fs/bcachefs/mean_and_variance.c
> +++ b/lib/math/mean_and_variance.c
> @@ -40,10 +40,9 @@
>  #include <linux/limits.h>
>  #include <linux/math.h>
>  #include <linux/math64.h>
> +#include <linux/mean_and_variance.h>
>  #include <linux/module.h>
>  
> -#include "mean_and_variance.h"
> -
>  u128_u u128_div(u128_u n, u64 d)
>  {
>  	u128_u r;
> diff --git a/fs/bcachefs/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
> similarity index 99%
> rename from fs/bcachefs/mean_and_variance_test.c
> rename to lib/math/mean_and_variance_test.c
> index 019583c3ca0e..f45591a169d8 100644
> --- a/fs/bcachefs/mean_and_variance_test.c
> +++ b/lib/math/mean_and_variance_test.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <kunit/test.h>
> -
> -#include "mean_and_variance.h"
> +#include <linux/mean_and_variance.h>
>  
>  #define MAX_SQR (SQRT_U64_MAX*SQRT_U64_MAX)
>  
> -- 
> 2.43.0
> 
> 

