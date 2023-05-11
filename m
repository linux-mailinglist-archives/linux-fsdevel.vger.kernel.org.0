Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0272F6FE9B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 04:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjEKCI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 22:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKCIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 22:08:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C2EDE;
        Wed, 10 May 2023 19:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683770933; x=1715306933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RapQlMH/dlsFJalvQXdyhW1B6c6n6VpKA6SrVWpGKTM=;
  b=URBGvV0heAGc3fZ4H40C7d0IohL5PAKMr8xyLMcs08wwtv9/XJSiF5ZG
   BxQBHDZEtnN8sz8CW1HiQib17VzHZ5ReLq/DLZn/WO2AocPJS8kgClsdB
   ey+UmLr6IxGQ+WPuazreC0AvLTkKzWdf2NTxULx3WpBEP4vFTC9g+6dZM
   fDEl3DIqL11ikN6DWhRHXLCCnosPnGNGvuHibEKg/3Tx9PGW07yXZfjxP
   CEEvJSF1FKqK6eNhzOY4KrM+a+kcynokwIfRmajsTVg0UmCY11cn1j2FK
   TeiefojXsPRA6qqjwBxkhnXwpH7cpQhNbruKgexcLFU48hH/R/50FItjE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="413691008"
X-IronPort-AV: E=Sophos;i="5.99,265,1677571200"; 
   d="scan'208";a="413691008"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 19:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="789180107"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="789180107"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 May 2023 19:08:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwvje-0003hq-1J;
        Thu, 11 May 2023 02:08:50 +0000
Date:   Thu, 11 May 2023 10:08:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Kent Overstreet <kmo@daterainc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 23/32] iov_iter: copy_folio_from_iter_atomic()
Message-ID: <202305110949.RCcHYzkJ-lkp@intel.com>
References: <20230509165657.1735798-24-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-24-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[cannot apply to axboe-block/for-next akpm-mm/mm-everything kdave/for-next linus/master v6.4-rc1 next-20230510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/Compiler-Attributes-add-__flatten/20230510-010302
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230509165657.1735798-24-kent.overstreet%40linux.dev
patch subject: [PATCH 23/32] iov_iter: copy_folio_from_iter_atomic()
config: powerpc-randconfig-s042-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110949.RCcHYzkJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/0e5d4229f5e7671dabba56ea36583b1ca20a9a18
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kent-Overstreet/Compiler-Attributes-add-__flatten/20230510-010302
        git checkout 0e5d4229f5e7671dabba56ea36583b1ca20a9a18
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305110949.RCcHYzkJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/iov_iter.c:839:30: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> lib/iov_iter.c:839:30: sparse:    unsigned int *
>> lib/iov_iter.c:839:30: sparse:    unsigned long *

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
