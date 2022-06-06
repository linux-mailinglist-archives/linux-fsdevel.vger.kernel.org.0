Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2298E53E052
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 06:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiFFEGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 00:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFFEGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:06:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617199D4F3;
        Sun,  5 Jun 2022 21:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654488368; x=1686024368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lOr5DTInx1SKE8hedXL5A+Zrl7PvzCn8r4DR/u3xt9s=;
  b=gXcXl1pGlUNRqJvtgQSJWe5Y4ctJjSWWD4qIk6aujX6Dh5rgcA+ZUDfi
   pB8q4Allf8y30bNLFx5JDZC5N5M1R8tAtLR86ceESCB0Gam0UCv8uqQpk
   1gKiG3zZzaVgHUql6yODmV6CkoTu0r2Bkj2HT5cUonEvDGTGMxkedQb20
   Sk7vX9xwM+dfZg1246ZnlOetYhOtmFxyGD1XhuNTsbc5uP3vZTlVbpsc0
   XV7Q4BF3SKBIttSgDR35UPszLNjoJNWnQcPtUEAO993JOPWYAhcYTCRvA
   i0egvR2OOLtl2et0VUuvZ33ffZ6+rNcswsNviJHLN/1zTeVxZFDggYLGF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362964010"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362964010"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 21:06:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="669287158"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2022 21:06:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny40D-000CSv-0i;
        Mon, 06 Jun 2022 04:06:05 +0000
Date:   Mon, 6 Jun 2022 12:05:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] quota: Support using the page cache for quota files
Message-ID: <202206061112.keHlFIBA-lkp@intel.com>
References: <20220605143815.2330891-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605143815.2330891-3-willy@infradead.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Matthew,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on jack-fs/for_next linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/Cache-quota-files-in-the-page-cache/20220606-021629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: riscv-randconfig-c006-20220605 (https://download.01.org/0day-ci/archive/20220606/202206061112.keHlFIBA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a7ff347e002ef476c8c116f30858f83529638a9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Cache-quota-files-in-the-page-cache/20220606-021629
        git checkout a7ff347e002ef476c8c116f30858f83529638a9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/quota/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/quota/dquot.c:2184:19: warning: comparison of distinct pointer types ('typeof (toread) *' (aka 'unsigned int *') and 'typeof (((1UL) << (12)) - ((unsigned long)(pos) & ~(~(((1UL) << (12)) - 1)))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size_t tocopy = min(toread, PAGE_SIZE - offset_in_page(pos));
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
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
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   1 warning and 20 errors generated.


vim +2184 fs/quota/dquot.c

  2165	
  2166	ssize_t generic_quota_read(struct super_block *sb, int type, char *data,
  2167				      size_t len, loff_t pos)
  2168	{
  2169		struct inode *inode = sb_dqopt(sb)->files[type];
  2170		struct address_space *mapping = inode->i_mapping;
  2171		size_t toread;
  2172		pgoff_t index;
  2173		loff_t i_size = i_size_read(inode);
  2174	
  2175		if (pos > i_size)
  2176			return 0;
  2177		if (pos + len > i_size)
  2178			len = i_size - pos;
  2179		toread = len;
  2180		index = pos / PAGE_SIZE;
  2181	
  2182		while (toread > 0) {
  2183			struct folio *folio = read_mapping_folio(mapping, index, NULL);
> 2184			size_t tocopy = min(toread, PAGE_SIZE - offset_in_page(pos));
  2185			void *src;
  2186	
  2187			if (folio == ERR_PTR(-ENOMEM)) {
  2188				memalloc_retry_wait(GFP_NOFS);
  2189				continue;
  2190			} else if (IS_ERR(folio))
  2191				return PTR_ERR(folio);
  2192	
  2193			src = kmap_local_folio(folio, offset_in_folio(folio, pos));
  2194			memcpy(data, src, tocopy);
  2195			kunmap_local(src);
  2196			folio_put(folio);
  2197	
  2198			toread -= tocopy;
  2199			data += tocopy;
  2200			pos += tocopy;
  2201			index++;
  2202		}
  2203		return len;
  2204	}
  2205	EXPORT_SYMBOL(generic_quota_read);
  2206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
