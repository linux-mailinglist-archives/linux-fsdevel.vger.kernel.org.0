Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BA3369AE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhDWT30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 15:29:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:8187 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhDWT30 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:29:26 -0400
IronPort-SDR: ft7vLmunPBqfeslfR6PmPXBjrwZlgP31J6aOxy0Lb7mSMh9yaEd1SpreXQPjUt7lAoM1flU6PH
 CwHf+eVIG3Qw==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="196233068"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="gz'50?scan'50,208,50";a="196233068"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 12:28:49 -0700
IronPort-SDR: Vi80RRDmHGXlFgHMPYHNO3cnYhpQava7ykT/tNjJlTw1CuKE0+CUY3tSUlZ7jqE5zeF13wFqPR
 2EifzS9Wb66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="gz'50?scan'50,208,50";a="453663803"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Apr 2021 12:28:44 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1la1Tn-0004oI-6f; Fri, 23 Apr 2021 19:28:43 +0000
Date:   Sat, 24 Apr 2021 03:27:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Ted Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH 10/12] shmem: Use invalidate_lock to protect fallocate
Message-ID: <202104240337.blcLX2eE-lkp@intel.com>
References: <20210423173018.23133-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20210423173018.23133-10-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on fuse/for-next linus/master v5.12-rc8]
[cannot apply to hnaz-linux-mm/master next-20210423]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jan-Kara/fs-Hole-punch-vs-page-cache-filling-races/20210424-013114
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: s390-randconfig-s031-20210424 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/800cf89f11d437415eead2da969c3b07908fd406
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jan-Kara/fs-Hole-punch-vs-page-cache-filling-races/20210424-013114
        git checkout 800cf89f11d437415eead2da969c3b07908fd406
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/shmem.c: In function 'shmem_writepage':
>> mm/shmem.c:1326:10: warning: variable 'index' set but not used [-Wunused-but-set-variable]
    1326 |  pgoff_t index;
         |          ^~~~~


vim +/index +1326 mm/shmem.c

^1da177e4c3f41 Linus Torvalds         2005-04-16  1316  
^1da177e4c3f41 Linus Torvalds         2005-04-16  1317  /*
^1da177e4c3f41 Linus Torvalds         2005-04-16  1318   * Move the page from the page cache to the swap cache.
^1da177e4c3f41 Linus Torvalds         2005-04-16  1319   */
^1da177e4c3f41 Linus Torvalds         2005-04-16  1320  static int shmem_writepage(struct page *page, struct writeback_control *wbc)
^1da177e4c3f41 Linus Torvalds         2005-04-16  1321  {
^1da177e4c3f41 Linus Torvalds         2005-04-16  1322  	struct shmem_inode_info *info;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1323  	struct address_space *mapping;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1324  	struct inode *inode;
6922c0c7abd387 Hugh Dickins           2011-08-03  1325  	swp_entry_t swap;
6922c0c7abd387 Hugh Dickins           2011-08-03 @1326  	pgoff_t index;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1327  
800d8c63b2e989 Kirill A. Shutemov     2016-07-26  1328  	VM_BUG_ON_PAGE(PageCompound(page), page);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1329  	BUG_ON(!PageLocked(page));
^1da177e4c3f41 Linus Torvalds         2005-04-16  1330  	mapping = page->mapping;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1331  	index = page->index;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1332  	inode = mapping->host;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1333  	info = SHMEM_I(inode);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1334  	if (info->flags & VM_LOCKED)
^1da177e4c3f41 Linus Torvalds         2005-04-16  1335  		goto redirty;
d9fe526a83b84e Hugh Dickins           2008-02-04  1336  	if (!total_swap_pages)
^1da177e4c3f41 Linus Torvalds         2005-04-16  1337  		goto redirty;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1338  
d9fe526a83b84e Hugh Dickins           2008-02-04  1339  	/*
97b713ba3ebaa6 Christoph Hellwig      2015-01-14  1340  	 * Our capabilities prevent regular writeback or sync from ever calling
97b713ba3ebaa6 Christoph Hellwig      2015-01-14  1341  	 * shmem_writepage; but a stacking filesystem might use ->writepage of
97b713ba3ebaa6 Christoph Hellwig      2015-01-14  1342  	 * its underlying filesystem, in which case tmpfs should write out to
97b713ba3ebaa6 Christoph Hellwig      2015-01-14  1343  	 * swap only in response to memory pressure, and not for the writeback
97b713ba3ebaa6 Christoph Hellwig      2015-01-14  1344  	 * threads or sync.
d9fe526a83b84e Hugh Dickins           2008-02-04  1345  	 */
48f170fb7d7db8 Hugh Dickins           2011-07-25  1346  	if (!wbc->for_reclaim) {
48f170fb7d7db8 Hugh Dickins           2011-07-25  1347  		WARN_ON_ONCE(1);	/* Still happens? Tell us about it! */
48f170fb7d7db8 Hugh Dickins           2011-07-25  1348  		goto redirty;
48f170fb7d7db8 Hugh Dickins           2011-07-25  1349  	}
1635f6a74152f1 Hugh Dickins           2012-05-29  1350  
1635f6a74152f1 Hugh Dickins           2012-05-29  1351  	/*
1635f6a74152f1 Hugh Dickins           2012-05-29  1352  	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
1635f6a74152f1 Hugh Dickins           2012-05-29  1353  	 * value into swapfile.c, the only way we can correctly account for a
1635f6a74152f1 Hugh Dickins           2012-05-29  1354  	 * fallocated page arriving here is now to initialize it and write it.
800cf89f11d437 Jan Kara               2021-04-23  1355  	 * Since a page added by currently running fallocate call cannot be
800cf89f11d437 Jan Kara               2021-04-23  1356  	 * dirtied and thus arrive here we know the fallocate has already
800cf89f11d437 Jan Kara               2021-04-23  1357  	 * completed and we are fine writing it out.
1635f6a74152f1 Hugh Dickins           2012-05-29  1358  	 */
1635f6a74152f1 Hugh Dickins           2012-05-29  1359  	if (!PageUptodate(page)) {
1635f6a74152f1 Hugh Dickins           2012-05-29  1360  		clear_highpage(page);
1635f6a74152f1 Hugh Dickins           2012-05-29  1361  		flush_dcache_page(page);
1635f6a74152f1 Hugh Dickins           2012-05-29  1362  		SetPageUptodate(page);
1635f6a74152f1 Hugh Dickins           2012-05-29  1363  	}
1635f6a74152f1 Hugh Dickins           2012-05-29  1364  
38d8b4e6bdc872 Huang Ying             2017-07-06  1365  	swap = get_swap_page(page);
48f170fb7d7db8 Hugh Dickins           2011-07-25  1366  	if (!swap.val)
48f170fb7d7db8 Hugh Dickins           2011-07-25  1367  		goto redirty;
d9fe526a83b84e Hugh Dickins           2008-02-04  1368  
b1dea800ac3959 Hugh Dickins           2011-05-11  1369  	/*
b1dea800ac3959 Hugh Dickins           2011-05-11  1370  	 * Add inode to shmem_unuse()'s list of swapped-out inodes,
6922c0c7abd387 Hugh Dickins           2011-08-03  1371  	 * if it's not already there.  Do it now before the page is
6922c0c7abd387 Hugh Dickins           2011-08-03  1372  	 * moved to swap cache, when its pagelock no longer protects
b1dea800ac3959 Hugh Dickins           2011-05-11  1373  	 * the inode from eviction.  But don't unlock the mutex until
6922c0c7abd387 Hugh Dickins           2011-08-03  1374  	 * we've incremented swapped, because shmem_unuse_inode() will
6922c0c7abd387 Hugh Dickins           2011-08-03  1375  	 * prune a !swapped inode from the swaplist under this mutex.
b1dea800ac3959 Hugh Dickins           2011-05-11  1376  	 */
b1dea800ac3959 Hugh Dickins           2011-05-11  1377  	mutex_lock(&shmem_swaplist_mutex);
05bf86b4ccfd0f Hugh Dickins           2011-05-14  1378  	if (list_empty(&info->swaplist))
b56a2d8af9147a Vineeth Remanan Pillai 2019-03-05  1379  		list_add(&info->swaplist, &shmem_swaplist);
b1dea800ac3959 Hugh Dickins           2011-05-11  1380  
4afab1cd256e42 Yang Shi               2019-11-30  1381  	if (add_to_swap_cache(page, swap,
3852f6768ede54 Joonsoo Kim            2020-08-11  1382  			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
3852f6768ede54 Joonsoo Kim            2020-08-11  1383  			NULL) == 0) {
4595ef88d13613 Kirill A. Shutemov     2016-07-26  1384  		spin_lock_irq(&info->lock);
6922c0c7abd387 Hugh Dickins           2011-08-03  1385  		shmem_recalc_inode(inode);
267a4c76bbdb95 Hugh Dickins           2015-12-11  1386  		info->swapped++;
4595ef88d13613 Kirill A. Shutemov     2016-07-26  1387  		spin_unlock_irq(&info->lock);
6922c0c7abd387 Hugh Dickins           2011-08-03  1388  
267a4c76bbdb95 Hugh Dickins           2015-12-11  1389  		swap_shmem_alloc(swap);
267a4c76bbdb95 Hugh Dickins           2015-12-11  1390  		shmem_delete_from_page_cache(page, swp_to_radix_entry(swap));
267a4c76bbdb95 Hugh Dickins           2015-12-11  1391  
6922c0c7abd387 Hugh Dickins           2011-08-03  1392  		mutex_unlock(&shmem_swaplist_mutex);
d9fe526a83b84e Hugh Dickins           2008-02-04  1393  		BUG_ON(page_mapped(page));
9fab5619bdd7f8 Hugh Dickins           2009-03-31  1394  		swap_writepage(page, wbc);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1395  		return 0;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1396  	}
^1da177e4c3f41 Linus Torvalds         2005-04-16  1397  
6922c0c7abd387 Hugh Dickins           2011-08-03  1398  	mutex_unlock(&shmem_swaplist_mutex);
75f6d6d29a40b5 Minchan Kim            2017-07-06  1399  	put_swap_page(page, swap);
^1da177e4c3f41 Linus Torvalds         2005-04-16  1400  redirty:
^1da177e4c3f41 Linus Torvalds         2005-04-16  1401  	set_page_dirty(page);
d9fe526a83b84e Hugh Dickins           2008-02-04  1402  	if (wbc->for_reclaim)
d9fe526a83b84e Hugh Dickins           2008-02-04  1403  		return AOP_WRITEPAGE_ACTIVATE;	/* Return with page locked */
d9fe526a83b84e Hugh Dickins           2008-02-04  1404  	unlock_page(page);
d9fe526a83b84e Hugh Dickins           2008-02-04  1405  	return 0;
^1da177e4c3f41 Linus Torvalds         2005-04-16  1406  }
^1da177e4c3f41 Linus Torvalds         2005-04-16  1407  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mYCpIKhGyMATD0i+
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--mYCpIKhGyMATD0i+--
