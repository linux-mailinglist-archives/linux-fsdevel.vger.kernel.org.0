Return-Path: <linux-fsdevel+bounces-29879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E208C97EF44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 18:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34309B214F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8E19F120;
	Mon, 23 Sep 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+702F4G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB1E14A8B;
	Mon, 23 Sep 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108979; cv=none; b=eL/wubt5ZkwB6EM7vb88+Aa7RSjY/avJ6JR74Q5vtV/ga2A7B0iyJdNg4H/fjvViCbQfGq5P5sRUowedcNQmWEL1gf6da79kElUaOaKsxJI8K0wQgTex2Oz9RfZzexFvXYFFrfgUeUtzly1BzCNsBf98s2STjFT/+cxFsFaJ008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108979; c=relaxed/simple;
	bh=lvl/tpp3D2iigerhPqJlAeR64cN3GRVe7gUUIkF0zyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgNXfdNIwc7s+YkH7mr2Yp6ss8+T7vzMQQe+Bcc55q48XRnJo1yK8Z1Ra7kVRhEdqqZMLquk9/bjHsOeFvuRVGuzRTfPYURlmQFDDSbBr55+tmukH0GUA/14NV8sp/ounC6hsnZ899HVcrwb7VcSca2tGn4IQ6tmJdjB4gEs/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+702F4G; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727108978; x=1758644978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvl/tpp3D2iigerhPqJlAeR64cN3GRVe7gUUIkF0zyQ=;
  b=U+702F4GwtZoEwes7p9m605q6fbG5cK6IntV+L2z0qmN20C3c7vV1ZJD
   BdKUif26jAFayddMjhw+WoF07ks64qkz8/UL+TQsUb/PXB71ssGSn47Ws
   J5ezz0xHaQK/Jzl+r91y+AbK1YI5ClWh3e+ZPUkUkl6bfaFvq8xBRci+2
   a24/q7WMQ5hrfWNE2j07Y5q07aCroigXefQwmZVy0PJY0U+XcPH6UXAtO
   l1hcqMPIpAsvoEGNTx5RHPIyoxDGGzHGhwa/YhIrkWqBzJaAcDkZGfQ4s
   Q7X0TBeaX3RdVmBxBfYNhuXqURKRHntzqlQg+JOntXXnlUFo2wsgF6Vx2
   A==;
X-CSE-ConnectionGUID: tgAbKqw5RG+bybNoV41Q1Q==
X-CSE-MsgGUID: NIN7HEWxRMaPDEVQJQUnKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26222978"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26222978"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 09:29:37 -0700
X-CSE-ConnectionGUID: /JOl0swhT9GGULE0YxRVpw==
X-CSE-MsgGUID: GD5dfzzrQGSjs2Y1gpF1kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="76047545"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 23 Sep 2024 09:29:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sslwK-000HP2-0C;
	Mon, 23 Sep 2024 16:29:32 +0000
Date: Tue, 24 Sep 2024 00:28:56 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>, Matthew Wilcox <willy@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH] xarray: rename xa_lock/xa_unlock to xa_enter/xa_leave
Message-ID: <202409240026.7kkshSxM-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240924/202409240026.7kkshSxM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240026.7kkshSxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240026.7kkshSxM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/list_lru.h:14,
                    from include/linux/fs.h:13,
                    from mm/page-writeback.c:19:
   mm/page-writeback.c: In function '__folio_mark_dirty':
>> include/linux/xarray.h:567:41: error: implicit declaration of function 'xa_leave_irqsave'; did you mean 'xa_lock_irqsave'? [-Werror=implicit-function-declaration]
     567 | #define xa_unlock_irqrestore(xa, flags) xa_leave_irqsave(xa, flags)
         |                                         ^~~~~~~~~~~~~~~~
   mm/page-writeback.c:2801:9: note: in expansion of macro 'xa_unlock_irqrestore'
    2801 |         xa_unlock_irqrestore(&mapping->i_pages, flags);
         |         ^~~~~~~~~~~~~~~~~~~~
   mm/page-writeback.c: In function '__folio_start_writeback':
>> include/linux/xarray.h:1453:49: error: implicit declaration of function 'xas_leave_irqsave'; did you mean 'xas_lock_irqsave'? [-Werror=implicit-function-declaration]
    1453 | #define xas_unlock_irqrestore(xas, flags)       xas_leave_irqsave(xas, flags)
         |                                                 ^~~~~~~~~~~~~~~~~
   mm/page-writeback.c:3155:17: note: in expansion of macro 'xas_unlock_irqrestore'
    3155 |                 xas_unlock_irqrestore(&xas, flags);
         |                 ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +567 include/linux/xarray.h

   426	
   427	/**
   428	 * xa_for_each_range() - Iterate over a portion of an XArray.
   429	 * @xa: XArray.
   430	 * @index: Index of @entry.
   431	 * @entry: Entry retrieved from array.
   432	 * @start: First index to retrieve from array.
   433	 * @last: Last index to retrieve from array.
   434	 *
   435	 * During the iteration, @entry will have the value of the entry stored
   436	 * in @xa at @index.  You may modify @index during the iteration if you
   437	 * want to skip or reprocess indices.  It is safe to modify the array
   438	 * during the iteration.  At the end of the iteration, @entry will be set
   439	 * to NULL and @index will have a value less than or equal to max.
   440	 *
   441	 * xa_for_each_range() is O(n.log(n)) while xas_for_each() is O(n).  You have
   442	 * to handle your own locking with xas_for_each(), and if you have to unlock
   443	 * after each iteration, it will also end up being O(n.log(n)).
   444	 * xa_for_each_range() will spin if it hits a retry entry; if you intend to
   445	 * see retry entries, you should use the xas_for_each() iterator instead.
   446	 * The xas_for_each() iterator will expand into more inline code than
   447	 * xa_for_each_range().
   448	 *
   449	 * Context: Any context.  Takes and releases the RCU lock.
   450	 */
   451	#define xa_for_each_range(xa, index, entry, start, last)		\
   452		for (index = start,						\
   453		     entry = xa_find(xa, &index, last, XA_PRESENT);		\
   454		     entry;							\
   455		     entry = xa_find_after(xa, &index, last, XA_PRESENT))
   456	
   457	/**
   458	 * xa_for_each_start() - Iterate over a portion of an XArray.
   459	 * @xa: XArray.
   460	 * @index: Index of @entry.
   461	 * @entry: Entry retrieved from array.
   462	 * @start: First index to retrieve from array.
   463	 *
   464	 * During the iteration, @entry will have the value of the entry stored
   465	 * in @xa at @index.  You may modify @index during the iteration if you
   466	 * want to skip or reprocess indices.  It is safe to modify the array
   467	 * during the iteration.  At the end of the iteration, @entry will be set
   468	 * to NULL and @index will have a value less than or equal to max.
   469	 *
   470	 * xa_for_each_start() is O(n.log(n)) while xas_for_each() is O(n).  You have
   471	 * to handle your own locking with xas_for_each(), and if you have to unlock
   472	 * after each iteration, it will also end up being O(n.log(n)).
   473	 * xa_for_each_start() will spin if it hits a retry entry; if you intend to
   474	 * see retry entries, you should use the xas_for_each() iterator instead.
   475	 * The xas_for_each() iterator will expand into more inline code than
   476	 * xa_for_each_start().
   477	 *
   478	 * Context: Any context.  Takes and releases the RCU lock.
   479	 */
   480	#define xa_for_each_start(xa, index, entry, start) \
   481		xa_for_each_range(xa, index, entry, start, ULONG_MAX)
   482	
   483	/**
   484	 * xa_for_each() - Iterate over present entries in an XArray.
   485	 * @xa: XArray.
   486	 * @index: Index of @entry.
   487	 * @entry: Entry retrieved from array.
   488	 *
   489	 * During the iteration, @entry will have the value of the entry stored
   490	 * in @xa at @index.  You may modify @index during the iteration if you want
   491	 * to skip or reprocess indices.  It is safe to modify the array during the
   492	 * iteration.  At the end of the iteration, @entry will be set to NULL and
   493	 * @index will have a value less than or equal to max.
   494	 *
   495	 * xa_for_each() is O(n.log(n)) while xas_for_each() is O(n).  You have
   496	 * to handle your own locking with xas_for_each(), and if you have to unlock
   497	 * after each iteration, it will also end up being O(n.log(n)).  xa_for_each()
   498	 * will spin if it hits a retry entry; if you intend to see retry entries,
   499	 * you should use the xas_for_each() iterator instead.  The xas_for_each()
   500	 * iterator will expand into more inline code than xa_for_each().
   501	 *
   502	 * Context: Any context.  Takes and releases the RCU lock.
   503	 */
   504	#define xa_for_each(xa, index, entry) \
   505		xa_for_each_start(xa, index, entry, 0)
   506	
   507	/**
   508	 * xa_for_each_marked() - Iterate over marked entries in an XArray.
   509	 * @xa: XArray.
   510	 * @index: Index of @entry.
   511	 * @entry: Entry retrieved from array.
   512	 * @filter: Selection criterion.
   513	 *
   514	 * During the iteration, @entry will have the value of the entry stored
   515	 * in @xa at @index.  The iteration will skip all entries in the array
   516	 * which do not match @filter.  You may modify @index during the iteration
   517	 * if you want to skip or reprocess indices.  It is safe to modify the array
   518	 * during the iteration.  At the end of the iteration, @entry will be set to
   519	 * NULL and @index will have a value less than or equal to max.
   520	 *
   521	 * xa_for_each_marked() is O(n.log(n)) while xas_for_each_marked() is O(n).
   522	 * You have to handle your own locking with xas_for_each(), and if you have
   523	 * to unlock after each iteration, it will also end up being O(n.log(n)).
   524	 * xa_for_each_marked() will spin if it hits a retry entry; if you intend to
   525	 * see retry entries, you should use the xas_for_each_marked() iterator
   526	 * instead.  The xas_for_each_marked() iterator will expand into more inline
   527	 * code than xa_for_each_marked().
   528	 *
   529	 * Context: Any context.  Takes and releases the RCU lock.
   530	 */
   531	#define xa_for_each_marked(xa, index, entry, filter) \
   532		for (index = 0, entry = xa_find(xa, &index, ULONG_MAX, filter); \
   533		     entry; entry = xa_find_after(xa, &index, ULONG_MAX, filter))
   534	
   535	#define xa_tryenter(xa)		spin_trylock(&(xa)->xa_lock)
   536	#define xa_enter(xa)		spin_lock(&(xa)->xa_lock)
   537	#define xa_leave(xa)		spin_unlock(&(xa)->xa_lock)
   538	#define xa_enter_bh(xa)		spin_lock_bh(&(xa)->xa_lock)
   539	#define xa_leave_bh(xa)		spin_unlock_bh(&(xa)->xa_lock)
   540	#define xa_enter_irq(xa)	spin_lock_irq(&(xa)->xa_lock)
   541	#define xa_leave_irq(xa)	spin_unlock_irq(&(xa)->xa_lock)
   542	#define xa_enter_irqsave(xa, flags) \
   543					spin_lock_irqsave(&(xa)->xa_lock, flags)
   544	#define xa_leave_irqrestore(xa, flags) \
   545					spin_unlock_irqrestore(&(xa)->xa_lock, flags)
   546	#define xa_enter_nested(xa, subclass) \
   547					spin_lock_nested(&(xa)->xa_lock, subclass)
   548	#define xa_enter_bh_nested(xa, subclass) \
   549					spin_lock_bh_nested(&(xa)->xa_lock, subclass)
   550	#define xa_enter_irq_nested(xa, subclass) \
   551					spin_lock_irq_nested(&(xa)->xa_lock, subclass)
   552	#define xa_enter_irqsave_nested(xa, flags, subclass) \
   553			spin_lock_irqsave_nested(&(xa)->xa_lock, flags, subclass)
   554	
   555	/*
   556	 * These names are deprecated. Please use xa_enter instead of xa_lock, and
   557	 * xa_leave instead of xa_unlock.
   558	 */
   559	#define xa_trylock(xa)			xa_tryenter(xa)
   560	#define xa_lock(xa)			xa_enter(xa)
   561	#define xa_unlock(xa)			xa_leave(xa)
   562	#define xa_lock_bh(xa)			xa_enter_bh(xa)
   563	#define xa_unlock_bh(xa)		xa_leave_bh(xa)
   564	#define xa_lock_irq(xa)			xa_enter_irq(xa)
   565	#define xa_unlock_irq(xa)		xa_leave_irq(xa)
   566	#define xa_lock_irqsave(xa, flags)	xa_enter_irqsave(xa, flags)
 > 567	#define xa_unlock_irqrestore(xa, flags) xa_leave_irqsave(xa, flags)
   568	#define xa_lock_nested(xa, subclass)	xa_enter_nested(xa, subclass)
   569	#define xa_lock_bh_nested(xa, subclass) xa_enter_bh_nested(xa, subclass)
   570	#define xa_lock_irq_nested(xa, subclass) xa_enter_irq_nested(xa, subclass)
   571	#define xa_lock_irqsave_nested(xa, flags, subclass) \
   572			xa_enter_irqsave_nested(xa, flags, subclass)
   573	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

