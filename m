Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373A54C5CB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 16:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiB0P63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiB0P62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:58:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AA38DB5;
        Sun, 27 Feb 2022 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645977471; x=1677513471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZVNRO0qfhvL5YBVwTKw1rTCJwkow3/0UaHUBIhgeNU=;
  b=RLkh4lUTttFqBspJoam49cARbfcxk2khSK2UFGmDwZ1ttesuzr285yiX
   bppTpRxvD9iSl/JWYWtRYaFfe+GADrMlwO8I89uBwF4P4XCcy1U+T4qZg
   hYn5BlGCReb3+A99HovoL6XzUM8HdBI61RNdi70bhetCJid25mcxcpYp4
   b8Wz1vd1Pejo/kzcf3um+3nIJw0g/4J/MaeANnvo4qDE59ARuHzbjF0Ax
   fXx1STyN3xRGVwjOk68/FuYqP96D3LQttaUQetDqbE2s3DOQlTI4kh6sy
   f7ne+fwNThCRqcPLMzQ3Pie50T07OGN21raGXaoNZ/nWxRJP+DghASMY9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="240153060"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="240153060"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 07:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="777852020"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 27 Feb 2022 07:57:36 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOLvT-0006bd-Qq; Sun, 27 Feb 2022 15:57:35 +0000
Date:   Sun, 27 Feb 2022 23:57:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v11 8/8] fsdax: set a CoW flag when associate reflink
 mappings
Message-ID: <202202272359.2aizNPgB-lkp@intel.com>
References: <20220227120747.711169-9-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227120747.711169-9-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on linux/master]
[cannot apply to hnaz-mm/master linus/master v5.17-rc5 next-20220225]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220227-200849
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220227/202202272359.2aizNPgB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a0ac78065bbb4fbb3e5477c32686eca3b9f0e1ef
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220227-200849
        git checkout a0ac78065bbb4fbb3e5477c32686eca3b9f0e1ef
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/dax.c:337:67: warning: parameter 'mapping' set but not used [-Wunused-but-set-parameter]
   static inline void dax_mapping_set_cow_flag(struct address_space *mapping)
                                                                     ^
   1 warning generated.


vim +/mapping +337 fs/dax.c

   328	
   329	/*
   330	 * Iterate through all mapped pfns represented by an entry, i.e. skip
   331	 * 'empty' and 'zero' entries.
   332	 */
   333	#define for_each_mapped_pfn(entry, pfn) \
   334		for (pfn = dax_to_pfn(entry); \
   335				pfn < dax_end_pfn(entry); pfn++)
   336	
 > 337	static inline void dax_mapping_set_cow_flag(struct address_space *mapping)
   338	{
   339		mapping = (struct address_space *)PAGE_MAPPING_DAX_COW;
   340	}
   341	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
