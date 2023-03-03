Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA936A96F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 13:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjCCMGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 07:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCCMGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:06:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1AA1ACD1;
        Fri,  3 Mar 2023 04:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677845177; x=1709381177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ZhnkZvUx6/qDxwOmfHWY1TW6Ezr2JMQifRPtpqWpl8=;
  b=Pv9c1kKM3LFOwOG9CR3aJ1aGUqPbHCN/MXr6d4YG1e56DKOE9CSQaaL+
   louuYHBJ+IcRm6tv4Jsz8fnET/W3C6FmoCllNVP2pEn08kpyKTRdHYujt
   +TUug1K3IwzW3By+jmRlel1ai/W9k0uStlmpQxRZNsC8mWx/QNuc+x7vh
   S8cNuf1GLPtnSwwWseK2FCgxTB2fERL8RnvX+4M4UAq2/vM0xCVPUekU1
   xbRRfYP6sWzlOtakJZ+mG8qLV6V1EoiYyEo9rzaWmtLYJSW+SQxjNgBSl
   FZxvmuMQwVIMxGoIbj+RP/Jt15sPucyU2/Opjosr8j8/m1xTUOvW9XujV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="397618378"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="397618378"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 04:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="849438018"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="849438018"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2023 04:06:14 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pY4Av-0001Qe-0k;
        Fri, 03 Mar 2023 12:06:13 +0000
Date:   Fri, 3 Mar 2023 20:05:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 1/2] filemap: Add folio_copy_tail()
Message-ID: <202303031911.we6DjYXd-lkp@intel.com>
References: <20230303064315.701090-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303064315.701090-2-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master next-20230303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/filemap-Add-folio_copy_tail/20230303-144359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230303064315.701090-2-willy%40infradead.org
patch subject: [PATCH 1/2] filemap: Add folio_copy_tail()
config: arm-randconfig-r006-20230302 (https://download.01.org/0day-ci/archive/20230303/202303031911.we6DjYXd-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/a4ee841f30215e4f7c5dda2ab82007f590a6a62b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/filemap-Add-folio_copy_tail/20230303-144359
        git checkout a4ee841f30215e4f7c5dda2ab82007f590a6a62b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303031911.we6DjYXd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/filemap.c:4160:17: warning: comparison of distinct pointer types ('typeof (poff + len) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                   size_t plen = min(poff + len, PAGE_SIZE) - poff;
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
>> mm/filemap.c:4172:11: warning: comparison of distinct pointer types ('typeof (len) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                           plen = min(len, PAGE_SIZE);
                                  ^~~~~~~~~~~~~~~~~~~
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
   2 warnings generated.


vim +4160 mm/filemap.c

  4125	
  4126	/**
  4127	 * folio_copy_tail - Copy an in-memory file tail into a page cache folio.
  4128	 * @folio: The folio to copy into.
  4129	 * @pos: The file position of the first byte of data in the tail.
  4130	 * @src: The address of the tail data.
  4131	 * @max: The size of the buffer used for the tail data.
  4132	 *
  4133	 * Supports file tails starting at @pos that are a maximum of @max
  4134	 * bytes in size.  Zeroes the remainder of the folio.
  4135	 */
  4136	void folio_copy_tail(struct folio *folio, loff_t pos, void *src, size_t max)
  4137	{
  4138		loff_t isize = i_size_read(folio->mapping->host);
  4139		size_t offset, len = isize - pos;
  4140		char *dst;
  4141	
  4142		if (folio_pos(folio) > isize) {
  4143			len = 0;
  4144		} else if (folio_pos(folio) > pos) {
  4145			len -= folio_pos(folio) - pos;
  4146			src += folio_pos(folio) - pos;
  4147			max -= folio_pos(folio) - pos;
  4148			pos = folio_pos(folio);
  4149		}
  4150		/*
  4151		 * i_size is larger than the number of bytes stored in the tail?
  4152		 * Assume the remainder is zero-padded.
  4153		 */
  4154		if (WARN_ON_ONCE(len > max))
  4155			len = max;
  4156		offset = offset_in_folio(folio, pos);
  4157		dst = kmap_local_folio(folio, offset);
  4158		if (folio_test_highmem(folio) && folio_test_large(folio)) {
  4159			size_t poff = offset_in_page(offset);
> 4160			size_t plen = min(poff + len, PAGE_SIZE) - poff;
  4161	
  4162			for (;;) {
  4163				memcpy(dst, src, plen);
  4164				memset(dst + plen, 0, PAGE_SIZE - poff - plen);
  4165				offset += PAGE_SIZE - poff;
  4166				if (offset == folio_size(folio))
  4167					break;
  4168				kunmap_local(dst);
  4169				dst = kmap_local_folio(folio, offset);
  4170				len -= plen;
  4171				poff = 0;
> 4172				plen = min(len, PAGE_SIZE);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
