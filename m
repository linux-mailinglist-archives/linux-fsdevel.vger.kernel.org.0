Return-Path: <linux-fsdevel+bounces-10115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF18847E48
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 02:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623CF287C21
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C846FAE;
	Sat,  3 Feb 2024 01:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvOBBtv7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F56127
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Feb 2024 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706925317; cv=none; b=X1sRjlZzLW2N2KeWdoPyyUXL06l22/1YV6IWyWvmwS0yZfri/P/U+tHl9MmHenIjDpGjmQpur69YI3a+fTUzKWwB6U8GTp1i3vdMXTtjzDBqIpUeLdL7+WUdgxZLvznUqxSoImRGYI5fPBsO9Zi31fqykM0eIO3nj3JxweFdQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706925317; c=relaxed/simple;
	bh=zj5W0jgMX2iMP6/D1Yn+1ZlFej6I3CPhYxpVBoixFgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL7WsBBbGaes+VUar8BB2lAtdDTlJPnZ4pDPP28MmvmOlxYj3ic2eRfT0IOJ971vuJ9ebV604uDmlpepY9LRJD4OD5lbqNVrrbqf0rbqsiDWKNNva0a0HSRDASYCsn748+BQJ5fGvNZA4B3YSglrMTGX5AnEWqm5iWQkpwcfkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvOBBtv7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706925316; x=1738461316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zj5W0jgMX2iMP6/D1Yn+1ZlFej6I3CPhYxpVBoixFgQ=;
  b=IvOBBtv7xf3UTN9yR/g15EUd47Jv3vaYoZ4DTeqsHJutEPB1hHSuS7f5
   cvqDt1ABRPVHLvg+Jd26RAg0TF6xpsexRE+tsl2ZJjn3B75oGVX7hkl+X
   DTnq4tRSl9svyzVS6D2KBdZJP3jx5T9O1JLt8O3V3AutcNha7bTyg8kAe
   rWffdAKHCJZ8WkI8mKhcm+zObW0eppi9rxKc75/QnxDbCAuLSISqdCpNB
   O5B8l7NoS4K+mxe5i87TmRMVdwNoTYYtMh0NPLraLwmmdXo841cx27wcP
   sdji3ox5HWQqXkZNAgvNy+I7EPi1Z+ansKpC8/TLwVWwG4XMHSUR0OMlO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17803208"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17803208"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 17:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="433862"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Feb 2024 17:55:14 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rW5Ey-0004Wc-1m;
	Sat, 03 Feb 2024 01:55:11 +0000
Date: Sat, 3 Feb 2024 09:53:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/13] jfs: Convert inc_io and mp_anchor to take a folio
Message-ID: <202402030956.qthlo2BE-lkp@intel.com>
References: <20240201224605.4055895-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201224605.4055895-11-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on kleikamp-shaggy/jfs-next]
[also build test ERROR on linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/jfs-Convert-metapage_read_folio-to-use-folio-APIs/20240202-064805
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20240201224605.4055895-11-willy%40infradead.org
patch subject: [PATCH 10/13] jfs: Convert inc_io and mp_anchor to take a folio
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240203/202402030956.qthlo2BE-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402030956.qthlo2BE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402030956.qthlo2BE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/jfs/jfs_metapage.c: In function 'remove_metapage':
   fs/jfs/jfs_metapage.c:130:38: error: passing argument 1 of 'folio_detach_private' from incompatible pointer type [-Werror=incompatible-pointer-types]
     130 |                 folio_detach_private(&folio->page);
         |                                      ^~~~~~~~~~~~
         |                                      |
         |                                      struct page *
   In file included from include/linux/buffer_head.h:15,
                    from fs/jfs/jfs_metapage.c:14:
   include/linux/pagemap.h:508:56: note: expected 'struct folio *' but argument is of type 'struct page *'
     508 | static inline void *folio_detach_private(struct folio *folio)
         |                                          ~~~~~~~~~~~~~~^~~~~
   fs/jfs/jfs_metapage.c: In function 'inc_io':
>> fs/jfs/jfs_metapage.c:137:37: warning: dereferencing 'void *' pointer
     137 |         atomic_inc(&mp_anchor(folio)->io_count);
         |                                     ^~
>> fs/jfs/jfs_metapage.c:137:37: error: request for member 'io_count' in something not a structure or union
   cc1: some warnings being treated as errors


vim +/io_count +137 fs/jfs/jfs_metapage.c

  > 14	#include <linux/buffer_head.h>
    15	#include <linux/mempool.h>
    16	#include <linux/seq_file.h>
    17	#include <linux/writeback.h>
    18	#include "jfs_incore.h"
    19	#include "jfs_superblock.h"
    20	#include "jfs_filsys.h"
    21	#include "jfs_metapage.h"
    22	#include "jfs_txnmgr.h"
    23	#include "jfs_debug.h"
    24	
    25	#ifdef CONFIG_JFS_STATISTICS
    26	static struct {
    27		uint	pagealloc;	/* # of page allocations */
    28		uint	pagefree;	/* # of page frees */
    29		uint	lockwait;	/* # of sleeping lock_metapage() calls */
    30	} mpStat;
    31	#endif
    32	
    33	#define metapage_locked(mp) test_bit(META_locked, &(mp)->flag)
    34	#define trylock_metapage(mp) test_and_set_bit_lock(META_locked, &(mp)->flag)
    35	
    36	static inline void unlock_metapage(struct metapage *mp)
    37	{
    38		clear_bit_unlock(META_locked, &mp->flag);
    39		wake_up(&mp->wait);
    40	}
    41	
    42	static inline void __lock_metapage(struct metapage *mp)
    43	{
    44		DECLARE_WAITQUEUE(wait, current);
    45		INCREMENT(mpStat.lockwait);
    46		add_wait_queue_exclusive(&mp->wait, &wait);
    47		do {
    48			set_current_state(TASK_UNINTERRUPTIBLE);
    49			if (metapage_locked(mp)) {
    50				unlock_page(mp->page);
    51				io_schedule();
    52				lock_page(mp->page);
    53			}
    54		} while (trylock_metapage(mp));
    55		__set_current_state(TASK_RUNNING);
    56		remove_wait_queue(&mp->wait, &wait);
    57	}
    58	
    59	/*
    60	 * Must have mp->page locked
    61	 */
    62	static inline void lock_metapage(struct metapage *mp)
    63	{
    64		if (trylock_metapage(mp))
    65			__lock_metapage(mp);
    66	}
    67	
    68	#define METAPOOL_MIN_PAGES 32
    69	static struct kmem_cache *metapage_cache;
    70	static mempool_t *metapage_mempool;
    71	
    72	#define MPS_PER_PAGE (PAGE_SIZE >> L2PSIZE)
    73	
    74	#if MPS_PER_PAGE > 1
    75	
    76	struct meta_anchor {
    77		int mp_count;
    78		atomic_t io_count;
    79		struct metapage *mp[MPS_PER_PAGE];
    80	};
    81	#define mp_anchor(folio) (folio->private)
    82	
    83	static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
    84	{
    85		struct meta_anchor *anchor = folio->private;
    86	
    87		if (!anchor)
    88			return NULL;
    89		return anchor->mp[offset >> L2PSIZE];
    90	}
    91	
    92	static inline int insert_metapage(struct folio *folio, struct metapage *mp)
    93	{
    94		struct meta_anchor *a;
    95		int index;
    96		int l2mp_blocks;	/* log2 blocks per metapage */
    97	
    98		a = folio->private;
    99		if (!a) {
   100			a = kzalloc(sizeof(struct meta_anchor), GFP_NOFS);
   101			if (!a)
   102				return -ENOMEM;
   103			folio_attach_private(folio, a);
   104			kmap(&folio->page);
   105		}
   106	
   107		if (mp) {
   108			l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
   109			index = (mp->index >> l2mp_blocks) & (MPS_PER_PAGE - 1);
   110			a->mp_count++;
   111			a->mp[index] = mp;
   112		}
   113	
   114		return 0;
   115	}
   116	
   117	static inline void remove_metapage(struct folio *folio, struct metapage *mp)
   118	{
   119		struct meta_anchor *a = mp_anchor(folio);
   120		int l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
   121		int index;
   122	
   123		index = (mp->index >> l2mp_blocks) & (MPS_PER_PAGE - 1);
   124	
   125		BUG_ON(a->mp[index] != mp);
   126	
   127		a->mp[index] = NULL;
   128		if (--a->mp_count == 0) {
   129			kfree(a);
   130			folio_detach_private(&folio->page);
   131			kunmap(&folio->page);
   132		}
   133	}
   134	
   135	static inline void inc_io(struct folio *folio)
   136	{
 > 137		atomic_inc(&mp_anchor(folio)->io_count);
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

