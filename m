Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17F6BFF0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 03:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCSCSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 22:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCSCSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:18:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78331DBB7;
        Sat, 18 Mar 2023 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679192284; x=1710728284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uKIhVwGRC0KWA+MElVhfLP51Oupf+Vdkru1GB11TeFM=;
  b=XXaWNCG0zblx+jraNGHFcQJ/3DcDN+bYQBN4FxowCHoEJp/8Ngn1pABu
   kdk5MUbzbvxFZ/VZVi4vbAVKxii4TRLHlya1WbOKzjtlyiwJliPx8Y3un
   HvhlLGJ5ucYEoDDGZo2xglquuSeM5xH9Vo5ZPzkpNhoKB32ZA7FPZkFGT
   L0DkWiJyUwdiluNp0ULkS2ude34IVPosQXvKbQQQ5q5qIcSNHf+DSF2Dq
   cknZENMTKYz6gD+gypiB7BI6rdu6IRNhDixj9JGJcqriXzpXZJtHe9d5G
   ygpTo5rVjPhM2TI9g+m0k9jzp7ow/P/bQRNS+wzIxrVNDByIycLEdIyaq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="318874994"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="318874994"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 19:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="854880049"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="854880049"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2023 19:17:59 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdicQ-000ALK-0q;
        Sun, 19 Mar 2023 02:17:58 +0000
Date:   Sun, 19 Mar 2023 10:16:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <202303191017.vsaaDpyw-lkp@intel.com>
References: <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lorenzo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.3-rc2 next-20230317]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/fs-proc-kcore-Avoid-bounce-buffer-for-ktext-data/20230319-082147
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes%40gmail.com
patch subject: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
config: sh-randconfig-r013-20230319 (https://download.01.org/0day-ci/archive/20230319/202303191017.vsaaDpyw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a28f374d35bd294a529fcba0b69c8b0e2b66fa6c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lorenzo-Stoakes/fs-proc-kcore-Avoid-bounce-buffer-for-ktext-data/20230319-082147
        git checkout a28f374d35bd294a529fcba0b69c8b0e2b66fa6c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303191017.vsaaDpyw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/nommu.c:201:6: warning: no previous prototype for 'vread' [-Wmissing-prototypes]
     201 | long vread(char *buf, char *addr, unsigned long count)
         |      ^~~~~


vim +/vread +201 mm/nommu.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  200  
^1da177e4c3f41 Linus Torvalds 2005-04-16 @201  long vread(char *buf, char *addr, unsigned long count)
^1da177e4c3f41 Linus Torvalds 2005-04-16  202  {
9bde916bc73255 Chen Gang      2013-07-03  203  	/* Don't allow overflow */
9bde916bc73255 Chen Gang      2013-07-03  204  	if ((unsigned long) buf + count < count)
9bde916bc73255 Chen Gang      2013-07-03  205  		count = -(unsigned long) buf;
9bde916bc73255 Chen Gang      2013-07-03  206  
^1da177e4c3f41 Linus Torvalds 2005-04-16  207  	memcpy(buf, addr, count);
^1da177e4c3f41 Linus Torvalds 2005-04-16  208  	return count;
^1da177e4c3f41 Linus Torvalds 2005-04-16  209  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  210  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
