Return-Path: <linux-fsdevel+bounces-29873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DBB97EEE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5C51C21690
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66FE19E97C;
	Mon, 23 Sep 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8iGYh8Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A21A46B5;
	Mon, 23 Sep 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107776; cv=none; b=uXzhnP/wnc1AfbuU9d84i9QXZwGEOmN04u/0URdBaCd9OQMSngXcunVfLTNbH7hL/OigSoNsWTZyz4KOLTNZs6wowhXhzxTDkEE6Xk0NF8j7ODp9Wq0eCl0Hxqix6qL4Gv22+X/+4bYNlmQa7VJICV79loqWMSHZ3Hj9bvYXyiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107776; c=relaxed/simple;
	bh=ZAbMmXXVjqho4T7NkogHC0zle0UoSxjUKL0z5Po77EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du9GiURiLTaRYFdrp2NCumFr8vXXlq4E2CL2lTsW8/kbSuTFfw0OHGyg42SE960z4tnX8nOGTBocTXaR6aGRBoWpz6txmmT8L3FTS0Rnq1pF4zfyZ8sVqxpI5b0REdZOeLXfASw6F5h3BnMe/HvnpcZCCPoR2OddmrPX6GjhVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8iGYh8Q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107774; x=1758643774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZAbMmXXVjqho4T7NkogHC0zle0UoSxjUKL0z5Po77EQ=;
  b=F8iGYh8QUWMBjHOjbv8EGyG59Ay14xcFHT1elxFTgmhd+tetQQo9+0BX
   /3waS2aHeB9zaydoq005iAg9vu9Bd3ZmmR2d41l/sKYqed5dkSOyiGevH
   oaqOwhtfIlycX9nxvJkiwIY1xHSoBGyV45vKZ+58LKeKpI+AeJNuR7lao
   eo9qhZK3q4CpPvv2MUYMOiU9eUXEIGXv4qXRCx/rRPva0xr/V7ZiOWtbJ
   NZoZunac0qyuG6oMhPR3dOAL40mmgtdDdZ78qrzsZxz5MvIEWsCAikzif
   mLJt1ReQoPVIcQINB44Ug9srlGaFmSjULlCYkWE7FcN8aY3BmRuHqWH9V
   g==;
X-CSE-ConnectionGUID: ir2fyLdpRweiMflu9jm0Og==
X-CSE-MsgGUID: mCGLO42SQWCnqPUdYmVcUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29850391"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="29850391"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 09:08:35 -0700
X-CSE-ConnectionGUID: wAymrxdYTHGgarhjT4nP/g==
X-CSE-MsgGUID: M4GS815lSyyKwWsJUUgd4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71438039"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Sep 2024 09:08:32 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sslbx-000HME-2E;
	Mon, 23 Sep 2024 16:08:29 +0000
Date: Tue, 24 Sep 2024 00:08:03 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] xarray: rename xa_lock/xa_unlock to xa_enter/xa_leave
Message-ID: <202409232343.7o1tQrIx-lkp@intel.com>
References: <20240923-xa_enter_leave-v1-1-6ff365e8520a@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923-xa_enter_leave-v1-1-6ff365e8520a@google.com>

Hi Alice,

kernel test robot noticed the following build errors:

[auto build test ERROR on 98f7e32f20d28ec452afb208f9cffc08448a2652]

url:    https://github.com/intel-lab-lkp/linux/commits/Alice-Ryhl/xarray-rename-xa_lock-xa_unlock-to-xa_enter-xa_leave/20240923-184045
base:   98f7e32f20d28ec452afb208f9cffc08448a2652
patch link:    https://lore.kernel.org/r/20240923-xa_enter_leave-v1-1-6ff365e8520a%40google.com
patch subject: [PATCH] xarray: rename xa_lock/xa_unlock to xa_enter/xa_leave
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240923/202409232343.7o1tQrIx-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409232343.7o1tQrIx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409232343.7o1tQrIx-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/idr.c:453:2: error: call to undeclared function 'xas_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     453 |         xas_unlock_irqrestore(&xas, flags);
         |         ^
   include/linux/xarray.h:1453:43: note: expanded from macro 'xas_unlock_irqrestore'
    1453 | #define xas_unlock_irqrestore(xas, flags)       xas_leave_irqsave(xas, flags)
         |                                                 ^
   lib/idr.c:521:2: error: call to undeclared function 'xas_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     521 |         xas_unlock_irqrestore(&xas, flags);
         |         ^
   include/linux/xarray.h:1453:43: note: expanded from macro 'xas_unlock_irqrestore'
    1453 | #define xas_unlock_irqrestore(xas, flags)       xas_leave_irqsave(xas, flags)
         |                                                 ^
   lib/idr.c:553:2: error: call to undeclared function 'xas_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     553 |         xas_unlock_irqrestore(&xas, flags);
         |         ^
   include/linux/xarray.h:1453:43: note: expanded from macro 'xas_unlock_irqrestore'
    1453 | #define xas_unlock_irqrestore(xas, flags)       xas_leave_irqsave(xas, flags)
         |                                                 ^
   3 errors generated.
--
>> lib/xarray.c:2256:2: error: call to undeclared function 'xas_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2256 |         xas_unlock_irqrestore(&xas, flags);
         |         ^
   include/linux/xarray.h:1453:43: note: expanded from macro 'xas_unlock_irqrestore'
    1453 | #define xas_unlock_irqrestore(xas, flags)       xas_leave_irqsave(xas, flags)
         |                                                 ^
   1 error generated.
--
>> mm/page-writeback.c:2801:2: error: call to undeclared function 'xa_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2801 |         xa_unlock_irqrestore(&mapping->i_pages, flags);
         |         ^
   include/linux/xarray.h:567:41: note: expanded from macro 'xa_unlock_irqrestore'
     567 | #define xa_unlock_irqrestore(xa, flags) xa_leave_irqsave(xa, flags)
         |                                         ^
   mm/page-writeback.c:3100:3: error: call to undeclared function 'xa_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3100 |                 xa_unlock_irqrestore(&mapping->i_pages, flags);
         |                 ^
   include/linux/xarray.h:567:41: note: expanded from macro 'xa_unlock_irqrestore'
     567 | #define xa_unlock_irqrestore(xa, flags) xa_leave_irqsave(xa, flags)
         |                                         ^
>> mm/page-writeback.c:3155:3: error: call to undeclared function 'xas_leave_irqsave'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    3155 |                 xas_unlock_irqrestore(&xas, flags);
         |                 ^
   include/linux/xarray.h:1453:43: note: expanded from macro 'xas_unlock_irqrestore'
    1453 | #define xas_unlock_irqrestore(xas, flags)       xas_leave_irqsave(xas, flags)
         |                                                 ^
   3 errors generated.


vim +/xas_leave_irqsave +453 lib/idr.c

5806f07cd2c329 Jeff Mahoney            2006-06-26  307  
56083ab17e0075 Randy Dunlap            2010-10-26  308  /**
56083ab17e0075 Randy Dunlap            2010-10-26  309   * DOC: IDA description
72dba584b695d8 Tejun Heo               2007-06-14  310   *
0a835c4f090af2 Matthew Wilcox          2016-12-20  311   * The IDA is an ID allocator which does not provide the ability to
0a835c4f090af2 Matthew Wilcox          2016-12-20  312   * associate an ID with a pointer.  As such, it only needs to store one
0a835c4f090af2 Matthew Wilcox          2016-12-20  313   * bit per ID, and so is more space efficient than an IDR.  To use an IDA,
0a835c4f090af2 Matthew Wilcox          2016-12-20  314   * define it using DEFINE_IDA() (or embed a &struct ida in a data structure,
0a835c4f090af2 Matthew Wilcox          2016-12-20  315   * then initialise it using ida_init()).  To allocate a new ID, call
5ade60dda43c89 Matthew Wilcox          2018-03-20  316   * ida_alloc(), ida_alloc_min(), ida_alloc_max() or ida_alloc_range().
5ade60dda43c89 Matthew Wilcox          2018-03-20  317   * To free an ID, call ida_free().
72dba584b695d8 Tejun Heo               2007-06-14  318   *
b03f8e43c92618 Matthew Wilcox          2018-06-18  319   * ida_destroy() can be used to dispose of an IDA without needing to
b03f8e43c92618 Matthew Wilcox          2018-06-18  320   * free the individual IDs in it.  You can use ida_is_empty() to find
b03f8e43c92618 Matthew Wilcox          2018-06-18  321   * out whether the IDA has any IDs currently allocated.
0a835c4f090af2 Matthew Wilcox          2016-12-20  322   *
f32f004cddf86d Matthew Wilcox          2018-07-04  323   * The IDA handles its own locking.  It is safe to call any of the IDA
f32f004cddf86d Matthew Wilcox          2018-07-04  324   * functions without synchronisation in your code.
f32f004cddf86d Matthew Wilcox          2018-07-04  325   *
0a835c4f090af2 Matthew Wilcox          2016-12-20  326   * IDs are currently limited to the range [0-INT_MAX].  If this is an awkward
0a835c4f090af2 Matthew Wilcox          2016-12-20  327   * limitation, it should be quite straightforward to raise the maximum.
72dba584b695d8 Tejun Heo               2007-06-14  328   */
72dba584b695d8 Tejun Heo               2007-06-14  329  
d37cacc5adace7 Matthew Wilcox          2016-12-17  330  /*
d37cacc5adace7 Matthew Wilcox          2016-12-17  331   * Developer's notes:
d37cacc5adace7 Matthew Wilcox          2016-12-17  332   *
f32f004cddf86d Matthew Wilcox          2018-07-04  333   * The IDA uses the functionality provided by the XArray to store bitmaps in
f32f004cddf86d Matthew Wilcox          2018-07-04  334   * each entry.  The XA_FREE_MARK is only cleared when all bits in the bitmap
f32f004cddf86d Matthew Wilcox          2018-07-04  335   * have been set.
d37cacc5adace7 Matthew Wilcox          2016-12-17  336   *
f32f004cddf86d Matthew Wilcox          2018-07-04  337   * I considered telling the XArray that each slot is an order-10 node
f32f004cddf86d Matthew Wilcox          2018-07-04  338   * and indexing by bit number, but the XArray can't allow a single multi-index
f32f004cddf86d Matthew Wilcox          2018-07-04  339   * entry in the head, which would significantly increase memory consumption
f32f004cddf86d Matthew Wilcox          2018-07-04  340   * for the IDA.  So instead we divide the index by the number of bits in the
f32f004cddf86d Matthew Wilcox          2018-07-04  341   * leaf bitmap before doing a radix tree lookup.
d37cacc5adace7 Matthew Wilcox          2016-12-17  342   *
d37cacc5adace7 Matthew Wilcox          2016-12-17  343   * As an optimisation, if there are only a few low bits set in any given
3159f943aafdba Matthew Wilcox          2017-11-03  344   * leaf, instead of allocating a 128-byte bitmap, we store the bits
f32f004cddf86d Matthew Wilcox          2018-07-04  345   * as a value entry.  Value entries never have the XA_FREE_MARK cleared
f32f004cddf86d Matthew Wilcox          2018-07-04  346   * because we can always convert them into a bitmap entry.
f32f004cddf86d Matthew Wilcox          2018-07-04  347   *
f32f004cddf86d Matthew Wilcox          2018-07-04  348   * It would be possible to optimise further; once we've run out of a
f32f004cddf86d Matthew Wilcox          2018-07-04  349   * single 128-byte bitmap, we currently switch to a 576-byte node, put
f32f004cddf86d Matthew Wilcox          2018-07-04  350   * the 128-byte bitmap in the first entry and then start allocating extra
f32f004cddf86d Matthew Wilcox          2018-07-04  351   * 128-byte entries.  We could instead use the 512 bytes of the node's
f32f004cddf86d Matthew Wilcox          2018-07-04  352   * data as a bitmap before moving to that scheme.  I do not believe this
f32f004cddf86d Matthew Wilcox          2018-07-04  353   * is a worthwhile optimisation; Rasmus Villemoes surveyed the current
f32f004cddf86d Matthew Wilcox          2018-07-04  354   * users of the IDA and almost none of them use more than 1024 entries.
f32f004cddf86d Matthew Wilcox          2018-07-04  355   * Those that do use more than the 8192 IDs that the 512 bytes would
f32f004cddf86d Matthew Wilcox          2018-07-04  356   * provide.
f32f004cddf86d Matthew Wilcox          2018-07-04  357   *
f32f004cddf86d Matthew Wilcox          2018-07-04  358   * The IDA always uses a lock to alloc/free.  If we add a 'test_bit'
d37cacc5adace7 Matthew Wilcox          2016-12-17  359   * equivalent, it will still need locking.  Going to RCU lookup would require
d37cacc5adace7 Matthew Wilcox          2016-12-17  360   * using RCU to free bitmaps, and that's not trivial without embedding an
d37cacc5adace7 Matthew Wilcox          2016-12-17  361   * RCU head in the bitmap, which adds a 2-pointer overhead to each 128-byte
d37cacc5adace7 Matthew Wilcox          2016-12-17  362   * bitmap, which is excessive.
d37cacc5adace7 Matthew Wilcox          2016-12-17  363   */
d37cacc5adace7 Matthew Wilcox          2016-12-17  364  
f32f004cddf86d Matthew Wilcox          2018-07-04  365  /**
f32f004cddf86d Matthew Wilcox          2018-07-04  366   * ida_alloc_range() - Allocate an unused ID.
f32f004cddf86d Matthew Wilcox          2018-07-04  367   * @ida: IDA handle.
f32f004cddf86d Matthew Wilcox          2018-07-04  368   * @min: Lowest ID to allocate.
f32f004cddf86d Matthew Wilcox          2018-07-04  369   * @max: Highest ID to allocate.
f32f004cddf86d Matthew Wilcox          2018-07-04  370   * @gfp: Memory allocation flags.
f32f004cddf86d Matthew Wilcox          2018-07-04  371   *
f32f004cddf86d Matthew Wilcox          2018-07-04  372   * Allocate an ID between @min and @max, inclusive.  The allocated ID will
f32f004cddf86d Matthew Wilcox          2018-07-04  373   * not exceed %INT_MAX, even if @max is larger.
f32f004cddf86d Matthew Wilcox          2018-07-04  374   *
3b6742618ed921 Stephen Boyd            2020-10-15  375   * Context: Any context. It is safe to call this function without
3b6742618ed921 Stephen Boyd            2020-10-15  376   * locking in your code.
f32f004cddf86d Matthew Wilcox          2018-07-04  377   * Return: The allocated ID, or %-ENOMEM if memory could not be allocated,
f32f004cddf86d Matthew Wilcox          2018-07-04  378   * or %-ENOSPC if there are no free IDs.
f32f004cddf86d Matthew Wilcox          2018-07-04  379   */
f32f004cddf86d Matthew Wilcox          2018-07-04  380  int ida_alloc_range(struct ida *ida, unsigned int min, unsigned int max,
f32f004cddf86d Matthew Wilcox          2018-07-04  381  			gfp_t gfp)
72dba584b695d8 Tejun Heo               2007-06-14  382  {
f32f004cddf86d Matthew Wilcox          2018-07-04  383  	XA_STATE(xas, &ida->xa, min / IDA_BITMAP_BITS);
f32f004cddf86d Matthew Wilcox          2018-07-04  384  	unsigned bit = min % IDA_BITMAP_BITS;
f32f004cddf86d Matthew Wilcox          2018-07-04  385  	unsigned long flags;
f32f004cddf86d Matthew Wilcox          2018-07-04  386  	struct ida_bitmap *bitmap, *alloc = NULL;
f32f004cddf86d Matthew Wilcox          2018-07-04  387  
f32f004cddf86d Matthew Wilcox          2018-07-04  388  	if ((int)min < 0)
f32f004cddf86d Matthew Wilcox          2018-07-04  389  		return -ENOSPC;
f32f004cddf86d Matthew Wilcox          2018-07-04  390  
f32f004cddf86d Matthew Wilcox          2018-07-04  391  	if ((int)max < 0)
f32f004cddf86d Matthew Wilcox          2018-07-04  392  		max = INT_MAX;
f32f004cddf86d Matthew Wilcox          2018-07-04  393  
f32f004cddf86d Matthew Wilcox          2018-07-04  394  retry:
f32f004cddf86d Matthew Wilcox          2018-07-04  395  	xas_lock_irqsave(&xas, flags);
f32f004cddf86d Matthew Wilcox          2018-07-04  396  next:
f32f004cddf86d Matthew Wilcox          2018-07-04  397  	bitmap = xas_find_marked(&xas, max / IDA_BITMAP_BITS, XA_FREE_MARK);
f32f004cddf86d Matthew Wilcox          2018-07-04  398  	if (xas.xa_index > min / IDA_BITMAP_BITS)
0a835c4f090af2 Matthew Wilcox          2016-12-20  399  		bit = 0;
f32f004cddf86d Matthew Wilcox          2018-07-04  400  	if (xas.xa_index * IDA_BITMAP_BITS + bit > max)
f32f004cddf86d Matthew Wilcox          2018-07-04  401  		goto nospc;
f32f004cddf86d Matthew Wilcox          2018-07-04  402  
3159f943aafdba Matthew Wilcox          2017-11-03  403  	if (xa_is_value(bitmap)) {
3159f943aafdba Matthew Wilcox          2017-11-03  404  		unsigned long tmp = xa_to_value(bitmap);
f32f004cddf86d Matthew Wilcox          2018-07-04  405  
f32f004cddf86d Matthew Wilcox          2018-07-04  406  		if (bit < BITS_PER_XA_VALUE) {
f32f004cddf86d Matthew Wilcox          2018-07-04  407  			bit = find_next_zero_bit(&tmp, BITS_PER_XA_VALUE, bit);
f32f004cddf86d Matthew Wilcox          2018-07-04  408  			if (xas.xa_index * IDA_BITMAP_BITS + bit > max)
f32f004cddf86d Matthew Wilcox          2018-07-04  409  				goto nospc;
f32f004cddf86d Matthew Wilcox          2018-07-04  410  			if (bit < BITS_PER_XA_VALUE) {
f32f004cddf86d Matthew Wilcox          2018-07-04  411  				tmp |= 1UL << bit;
f32f004cddf86d Matthew Wilcox          2018-07-04  412  				xas_store(&xas, xa_mk_value(tmp));
f32f004cddf86d Matthew Wilcox          2018-07-04  413  				goto out;
d37cacc5adace7 Matthew Wilcox          2016-12-17  414  			}
f32f004cddf86d Matthew Wilcox          2018-07-04  415  		}
f32f004cddf86d Matthew Wilcox          2018-07-04  416  		bitmap = alloc;
f32f004cddf86d Matthew Wilcox          2018-07-04  417  		if (!bitmap)
f32f004cddf86d Matthew Wilcox          2018-07-04  418  			bitmap = kzalloc(sizeof(*bitmap), GFP_NOWAIT);
d37cacc5adace7 Matthew Wilcox          2016-12-17  419  		if (!bitmap)
f32f004cddf86d Matthew Wilcox          2018-07-04  420  			goto alloc;
3159f943aafdba Matthew Wilcox          2017-11-03  421  		bitmap->bitmap[0] = tmp;
f32f004cddf86d Matthew Wilcox          2018-07-04  422  		xas_store(&xas, bitmap);
f32f004cddf86d Matthew Wilcox          2018-07-04  423  		if (xas_error(&xas)) {
f32f004cddf86d Matthew Wilcox          2018-07-04  424  			bitmap->bitmap[0] = 0;
f32f004cddf86d Matthew Wilcox          2018-07-04  425  			goto out;
f32f004cddf86d Matthew Wilcox          2018-07-04  426  		}
d37cacc5adace7 Matthew Wilcox          2016-12-17  427  	}
d37cacc5adace7 Matthew Wilcox          2016-12-17  428  
0a835c4f090af2 Matthew Wilcox          2016-12-20  429  	if (bitmap) {
f32f004cddf86d Matthew Wilcox          2018-07-04  430  		bit = find_next_zero_bit(bitmap->bitmap, IDA_BITMAP_BITS, bit);
f32f004cddf86d Matthew Wilcox          2018-07-04  431  		if (xas.xa_index * IDA_BITMAP_BITS + bit > max)
f32f004cddf86d Matthew Wilcox          2018-07-04  432  			goto nospc;
0a835c4f090af2 Matthew Wilcox          2016-12-20  433  		if (bit == IDA_BITMAP_BITS)
f32f004cddf86d Matthew Wilcox          2018-07-04  434  			goto next;
72dba584b695d8 Tejun Heo               2007-06-14  435  
0a835c4f090af2 Matthew Wilcox          2016-12-20  436  		__set_bit(bit, bitmap->bitmap);
0a835c4f090af2 Matthew Wilcox          2016-12-20  437  		if (bitmap_full(bitmap->bitmap, IDA_BITMAP_BITS))
f32f004cddf86d Matthew Wilcox          2018-07-04  438  			xas_clear_mark(&xas, XA_FREE_MARK);
0a835c4f090af2 Matthew Wilcox          2016-12-20  439  	} else {
3159f943aafdba Matthew Wilcox          2017-11-03  440  		if (bit < BITS_PER_XA_VALUE) {
3159f943aafdba Matthew Wilcox          2017-11-03  441  			bitmap = xa_mk_value(1UL << bit);
3159f943aafdba Matthew Wilcox          2017-11-03  442  		} else {
f32f004cddf86d Matthew Wilcox          2018-07-04  443  			bitmap = alloc;
72dba584b695d8 Tejun Heo               2007-06-14  444  			if (!bitmap)
f32f004cddf86d Matthew Wilcox          2018-07-04  445  				bitmap = kzalloc(sizeof(*bitmap), GFP_NOWAIT);
f32f004cddf86d Matthew Wilcox          2018-07-04  446  			if (!bitmap)
f32f004cddf86d Matthew Wilcox          2018-07-04  447  				goto alloc;
0a835c4f090af2 Matthew Wilcox          2016-12-20  448  			__set_bit(bit, bitmap->bitmap);
3159f943aafdba Matthew Wilcox          2017-11-03  449  		}
f32f004cddf86d Matthew Wilcox          2018-07-04  450  		xas_store(&xas, bitmap);
72dba584b695d8 Tejun Heo               2007-06-14  451  	}
f32f004cddf86d Matthew Wilcox          2018-07-04  452  out:
f32f004cddf86d Matthew Wilcox          2018-07-04 @453  	xas_unlock_irqrestore(&xas, flags);
f32f004cddf86d Matthew Wilcox          2018-07-04  454  	if (xas_nomem(&xas, gfp)) {
f32f004cddf86d Matthew Wilcox          2018-07-04  455  		xas.xa_index = min / IDA_BITMAP_BITS;
f32f004cddf86d Matthew Wilcox          2018-07-04  456  		bit = min % IDA_BITMAP_BITS;
f32f004cddf86d Matthew Wilcox          2018-07-04  457  		goto retry;
72dba584b695d8 Tejun Heo               2007-06-14  458  	}
f32f004cddf86d Matthew Wilcox          2018-07-04  459  	if (bitmap != alloc)
f32f004cddf86d Matthew Wilcox          2018-07-04  460  		kfree(alloc);
f32f004cddf86d Matthew Wilcox          2018-07-04  461  	if (xas_error(&xas))
f32f004cddf86d Matthew Wilcox          2018-07-04  462  		return xas_error(&xas);
f32f004cddf86d Matthew Wilcox          2018-07-04  463  	return xas.xa_index * IDA_BITMAP_BITS + bit;
f32f004cddf86d Matthew Wilcox          2018-07-04  464  alloc:
f32f004cddf86d Matthew Wilcox          2018-07-04  465  	xas_unlock_irqrestore(&xas, flags);
f32f004cddf86d Matthew Wilcox          2018-07-04  466  	alloc = kzalloc(sizeof(*bitmap), gfp);
f32f004cddf86d Matthew Wilcox          2018-07-04  467  	if (!alloc)
f32f004cddf86d Matthew Wilcox          2018-07-04  468  		return -ENOMEM;
f32f004cddf86d Matthew Wilcox          2018-07-04  469  	xas_set(&xas, min / IDA_BITMAP_BITS);
f32f004cddf86d Matthew Wilcox          2018-07-04  470  	bit = min % IDA_BITMAP_BITS;
f32f004cddf86d Matthew Wilcox          2018-07-04  471  	goto retry;
f32f004cddf86d Matthew Wilcox          2018-07-04  472  nospc:
f32f004cddf86d Matthew Wilcox          2018-07-04  473  	xas_unlock_irqrestore(&xas, flags);
a219b856a2b993 Matthew Wilcox (Oracle  2020-04-02  474) 	kfree(alloc);
f32f004cddf86d Matthew Wilcox          2018-07-04  475  	return -ENOSPC;
0a835c4f090af2 Matthew Wilcox          2016-12-20  476  }
f32f004cddf86d Matthew Wilcox          2018-07-04  477  EXPORT_SYMBOL(ida_alloc_range);
72dba584b695d8 Tejun Heo               2007-06-14  478  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

