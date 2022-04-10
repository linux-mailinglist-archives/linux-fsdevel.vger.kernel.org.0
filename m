Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63F34FB0E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 01:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiDJX5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 19:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiDJX5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:57:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BA7CFF;
        Sun, 10 Apr 2022 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649634903; x=1681170903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Mx4eKFVr0fQGB09ANO23LBc1IXsd9gKMI9x9LYS73M=;
  b=BxV6btQUOBbM6+jLVCIFGcR1aIE/uvcGJmEzhnojQn/o/B3/FwH/LmW2
   2oSmYH+SOSK5JVwmWUZUr+hcpWtOLhZvzy5aSx5Ob/4eQaCs7F/yCtn7q
   5hOHos/Qr1kNuW8SwE5NEdT1o23hlrCI0LqonzoZnFMFl+FSXPPEDtYqk
   0sUv0RDpER6p3WDqyKqQ9MaJ6Wi6ed5tYAwEpLW5hovMK69rk3qiYXWJd
   BneLQaxD7YrvWukWLh6pPiHUdnIkpj3FrJwa/bKHBjdNLueOj3CgxLCD9
   RIotBweEg6Qswxm/Jkm1Vy1RzxdIzF3t4drcqacW+BLNg/C8xXKNnbrQG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="243888300"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="243888300"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 16:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="853691241"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2022 16:54:58 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndhOU-0001CJ-3b;
        Sun, 10 Apr 2022 23:54:58 +0000
Date:   Mon, 11 Apr 2022 07:54:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, djwong@kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com, hch@infradead.org,
        jane.chu@oracle.com
Subject: Re: [PATCH v12 6/7] xfs: Implement ->notify_failure() for XFS
Message-ID: <202204110700.66Eh1XZg-lkp@intel.com>
References: <20220410160904.3758789-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410160904.3758789-7-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Shiyang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on next-20220408]
[cannot apply to xfs-linux/for-next linus/master linux/master v5.18-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220411-001048
base:   https://github.com/hnaz/linux-mm master
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220411/202204110700.66Eh1XZg-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bf68be0c39b8ecc4223b948a9ee126af167d74f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Shiyang-Ruan/fsdax-introduce-fs-query-to-support-reflink/20220411-001048
        git checkout bf68be0c39b8ecc4223b948a9ee126af167d74f0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: fs/xfs/xfs_buf.o: in function `xfs_alloc_buftarg':
>> xfs_buf.c:(.text+0x9920): undefined reference to `xfs_dax_holder_operations'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
