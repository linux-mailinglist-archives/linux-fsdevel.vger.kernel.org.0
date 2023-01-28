Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E5C67FA56
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 20:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjA1TIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 14:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1TIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 14:08:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084882310A;
        Sat, 28 Jan 2023 11:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674932931; x=1706468931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CFk2RwypKPF19OyjjF+RmpNKHF1fwEMpHxULIXClvqA=;
  b=naFQNtmkoEIw6IpwsGIxmn6ciXoH9lq7vIlcVXaQnzI0805gRuXEZRL7
   lskEEgfPSWsgdFpGgyknKuI4ap1lwbDfmwvcFQHAzd6G8nDO7FMa8C/Pm
   V8gYmukn7itsozI1V1IRwEQaGI2rNx89ZPKRxn57VaVnHul3Yygt3JXF9
   SjDjR+yETVyQVI1DYb9SBbe26R+CYgw+crwmo/DbfEtaH0ceqtTdR3XND
   fLIHPLaT6wp1OvDVELgIer9s9ZYFp4T4WDOVJ+sXwTflp390KXS17sA6j
   tBupdF0EftxKm6YFQ1Ow+a01M4WiIsAcI8R+I3gL4qq4ExYYYlJHiO4UD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="391879872"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="391879872"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 11:08:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="656977886"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="656977886"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2023 11:08:48 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLqZD-00010i-1H;
        Sat, 28 Jan 2023 19:08:47 +0000
Date:   Sun, 29 Jan 2023 03:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
Message-ID: <202301290216.BcfP0oGK-lkp@intel.com>
References: <20230126202415.1682629-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-4-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20230127]
[cannot apply to tytso-ext4/dev xfs-linux/for-next linus/master v6.2-rc5 v6.2-rc4 v6.2-rc3 v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Add-FGP_WRITEBEGIN/20230128-150212
patch link:    https://lore.kernel.org/r/20230126202415.1682629-4-willy%40infradead.org
patch subject: [PATCH 03/31] ext4: Convert ext4_bio_write_page() to use a folio
config: x86_64-randconfig-a013-20230123 (https://download.01.org/0day-ci/archive/20230129/202301290216.BcfP0oGK-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f6e4c5cfaf2ef7b8ee6c5354bbbd5f1ee758746f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/fs-Add-FGP_WRITEBEGIN/20230128-150212
        git checkout f6e4c5cfaf2ef7b8ee6c5354bbbd5f1ee758746f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "bio_add_folio" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
