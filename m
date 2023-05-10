Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AE16FD3CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 May 2023 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEJCVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 22:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEJCVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 22:21:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85C213C;
        Tue,  9 May 2023 19:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683685269; x=1715221269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f1qxuEs9rOJZLXdhY8DESS0tHY5WoChvDBSB1yM2b64=;
  b=f4QDqgxotd8XYvqeVmvUfu3hefLpF3KivdtWuecn21+aNkEWbz6r1IvW
   NVVrnsMuoIdN0N6o1C47iyB2IKKx+DiBINg77R5KD5HztWhEi5cgtrZOy
   TVZ3h6EW6ssRfP20CGTmauVRC8yZjvxGsYQ/zcrvJt2eHGKw/bbopA26J
   P7PhKSpxIgMr0Vg+ctI/SFNlLmZRxxuqCY8WkocNPKaF0cYtTNH57PmD3
   JMJNw9SVJ8Ky10cvVKVx4hsfPH+y4aQk8l1FiSXoXC5kX0daYzdgv5Dzk
   lrfcZHE+gE8lJKL5188G0SB8djMZHOlEoxTQ8fcscxnstrB6HY1gZGQ3d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="350142898"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="350142898"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 19:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="764120841"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="764120841"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 May 2023 19:21:07 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwZRy-0002n6-0l;
        Wed, 10 May 2023 02:21:06 +0000
Date:   Wed, 10 May 2023 10:20:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kent Overstreet <kmo@daterainc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 23/32] iov_iter: copy_folio_from_iter_atomic()
Message-ID: <202305101003.uncpRKqA-lkp@intel.com>
References: <20230509165657.1735798-24-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-24-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[cannot apply to axboe-block/for-next akpm-mm/mm-everything kdave/for-next linus/master v6.4-rc1 next-20230509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/Compiler-Attributes-add-__flatten/20230510-010302
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230509165657.1735798-24-kent.overstreet%40linux.dev
patch subject: [PATCH 23/32] iov_iter: copy_folio_from_iter_atomic()
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20230510/202305101003.uncpRKqA-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0e5d4229f5e7671dabba56ea36583b1ca20a9a18
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kent-Overstreet/Compiler-Attributes-add-__flatten/20230510-010302
        git checkout 0e5d4229f5e7671dabba56ea36583b1ca20a9a18
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305101003.uncpRKqA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/iov_iter.c:839:16: warning: comparison of distinct pointer types ('typeof (bytes) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12) - (offset & (~(((1UL) << 12) - 1)))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   unsigned b = min(bytes, PAGE_SIZE - (offset & PAGE_MASK));
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   1 warning generated.


vim +839 lib/iov_iter.c

   825	
   826	size_t copy_folio_from_iter_atomic(struct folio *folio, size_t offset,
   827					   size_t bytes, struct iov_iter *i)
   828	{
   829		size_t ret = 0;
   830	
   831		if (WARN_ON(offset + bytes > folio_size(folio)))
   832			return 0;
   833		if (WARN_ON_ONCE(!i->data_source))
   834			return 0;
   835	
   836	#ifdef CONFIG_HIGHMEM
   837		while (bytes) {
   838			struct page *page = folio_page(folio, offset >> PAGE_SHIFT);
 > 839			unsigned b = min(bytes, PAGE_SIZE - (offset & PAGE_MASK));
   840			unsigned r = __copy_page_from_iter_atomic(page, offset, b, i);
   841	
   842			offset	+= r;
   843			bytes	-= r;
   844			ret	+= r;
   845	
   846			if (r != b)
   847				break;
   848		}
   849	#else
   850		ret = __copy_page_from_iter_atomic(&folio->page, offset, bytes, i);
   851	#endif
   852	
   853		return ret;
   854	}
   855	EXPORT_SYMBOL(copy_folio_from_iter_atomic);
   856	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
