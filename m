Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3048E4D162D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiCHLYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiCHLYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:24:33 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771AD2E6A3;
        Tue,  8 Mar 2022 03:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646738617; x=1678274617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OTDKdBP6ceow3LhtfZ7Bn1leLycFOUIHkQ8k/QtllPU=;
  b=GefeUd+iiCuvQUoDpAq+/CxkV51W34LKtbQ3TVPcI5daz0kMCdgbJ0V3
   vAeLrzqy5GJXFMI2Bc6txJmP9MGpo/QqOYap/0/kwT7LRkXTMMv5njiNB
   LOxomzzD0F3mNpEcHKdqb1j6anEACchqreU7hRn/H74AxM/sVL2/jVY9t
   Qll4CxpaY3T97J+g1xOrpCkTulyuNEmTaSSWYBxD1HEiPJjHcGBfz5scl
   DcKLW2LWVk5UeedckZrGpE0iVZcWBnZSL/RqCmY+XnC+lFGl+KcPDZGOz
   XcHhpSfB9az/nsJk8rAGdaqOkEHObbgirVeW37KTqAv7/gusSDzygvvU1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="315375857"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="315375857"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="632203033"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Mar 2022 03:23:20 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRXvz-0001KN-PN; Tue, 08 Mar 2022 11:23:19 +0000
Date:   Tue, 8 Mar 2022 19:22:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Tang <tangmeng@uniontech.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org
Cc:     kbuild-all@lists.01.org, nixiaoming@huawei.com,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        sujiaxun@uniontech.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
Message-ID: <202203081905.IbWENTfU-lkp@intel.com>
References: <20220304112341.19528-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304112341.19528-1-tangmeng@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Meng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mcgrof/sysctl-next]
[also build test WARNING on jack-fs/fsnotify rostedt-trace/for-next kees/for-next/pstore linus/master v5.17-rc7 next-20220308]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Meng-Tang/fs-proc-optimize-register-ctl_tables/20220307-150704
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220308/202203081905.IbWENTfU-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/1c32e4182bcc38ac7cf4385267fa8b4ca2d7d97a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Meng-Tang/fs-proc-optimize-register-ctl_tables/20220307-150704
        git checkout 1c32e4182bcc38ac7cf4385267fa8b4ca2d7d97a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash fs/proc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/proc/proc_sysctl.c:1442: warning: expecting prototype for register_sysctl(). Prototype was for register_sysctl_with_num() instead


vim +1442 fs/proc/proc_sysctl.c

1f87f0b52b1d65 Eric W. Biederman 2012-01-06  1428  
fea478d4101a42 Eric W. Biederman 2012-01-20  1429  /**
fea478d4101a42 Eric W. Biederman 2012-01-20  1430   * register_sysctl - register a sysctl table
fea478d4101a42 Eric W. Biederman 2012-01-20  1431   * @path: The path to the directory the sysctl table is in.
fea478d4101a42 Eric W. Biederman 2012-01-20  1432   * @table: the table structure
1c32e4182bcc38 Meng Tang         2022-03-04  1433   * @register_by_num: register single one and table must be without child
fea478d4101a42 Eric W. Biederman 2012-01-20  1434   *
fea478d4101a42 Eric W. Biederman 2012-01-20  1435   * Register a sysctl table. @table should be a filled in ctl_table
fea478d4101a42 Eric W. Biederman 2012-01-20  1436   * array. A completely 0 filled entry terminates the table.
fea478d4101a42 Eric W. Biederman 2012-01-20  1437   *
fea478d4101a42 Eric W. Biederman 2012-01-20  1438   * See __register_sysctl_table for more details.
fea478d4101a42 Eric W. Biederman 2012-01-20  1439   */
1c32e4182bcc38 Meng Tang         2022-03-04  1440  struct ctl_table_header *register_sysctl_with_num(const char *path,
1c32e4182bcc38 Meng Tang         2022-03-04  1441  		struct ctl_table *table, int register_by_num)
fea478d4101a42 Eric W. Biederman 2012-01-20 @1442  {
1c32e4182bcc38 Meng Tang         2022-03-04  1443  	return __register_sysctl_table_with_num(&sysctl_table_root.default_set,
1c32e4182bcc38 Meng Tang         2022-03-04  1444  					path, table, register_by_num);
fea478d4101a42 Eric W. Biederman 2012-01-20  1445  }
1c32e4182bcc38 Meng Tang         2022-03-04  1446  EXPORT_SYMBOL(register_sysctl_with_num);
fea478d4101a42 Eric W. Biederman 2012-01-20  1447  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
