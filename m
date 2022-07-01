Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF28B5638A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiGARiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGARiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:38:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C535377D4;
        Fri,  1 Jul 2022 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656697085; x=1688233085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2x1fmGCp5mV5jHwkeCy/MtDdRc5LTMqXTURYhBc4fSg=;
  b=BI3k8yRHMhebJB8eqcjT3Ck/2b61ougLUMLMo26n8lc/hz/xg9Y31zvP
   uOKNBHWw4G1OxHrjKMom5JQG2OHP7kXH49aBx363q3iKeBzzwng6qKPtK
   7v12V33tH0imuNA/wTFYGHyU9dsuSii/klBi6mf589/DRnlGl2l1bmmfe
   ZiZikKaXTZNLuQXjzP/2BMpEh49XH4pFx9YCiInvMyX175NYOs7gkW1kM
   F0sAd+6eRpWzTquqMIBOK2fV58oQU/nXENISxe/PJ+kgpjDmOdiPIFeh8
   WAFMFVyvZmQOSple2Unv9xz02vd6KSQxBSyA5mrTJ7MpoTdcAWclr3nBw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="262502912"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="262502912"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 10:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="681475180"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Jul 2022 10:37:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7Kaa-000ECk-Vv;
        Fri, 01 Jul 2022 17:37:56 +0000
Date:   Sat, 2 Jul 2022 01:37:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <greg@kroah.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftest: Taint kernel when test module loaded
Message-ID: <202207020132.SKDpQP9D-lkp@intel.com>
References: <20220701084744.3002019-4-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701084744.3002019-4-davidgow@google.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on shuah-kselftest/next linus/master v5.19-rc4 next-20220701]
[cannot apply to mcgrof/modules-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Gow/panic-Taint-kernel-if-tests-are-run/20220701-164843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
config: alpha-randconfig-r006-20220629 (https://download.01.org/0day-ci/archive/20220702/202207020132.SKDpQP9D-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/42b6461d6cca4baeeeed474b1400e203057c2b9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/panic-Taint-kernel-if-tests-are-run/20220701-164843
        git checkout 42b6461d6cca4baeeeed474b1400e203057c2b9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from lib/test_printf.c:27:
   lib/test_printf.c: In function 'test_printf_init':
>> lib/../tools/testing/selftests/kselftest_module.h:45:19: error: 'TAINT_KUNIT' undeclared (first use in this function)
      45 |         add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);       \
         |                   ^~~~~~~~~~~
   lib/test_printf.c:801:1: note: in expansion of macro 'KSTM_MODULE_LOADERS'
     801 | KSTM_MODULE_LOADERS(test_printf);
         | ^~~~~~~~~~~~~~~~~~~
   lib/../tools/testing/selftests/kselftest_module.h:45:19: note: each undeclared identifier is reported only once for each function it appears in
      45 |         add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);       \
         |                   ^~~~~~~~~~~
   lib/test_printf.c:801:1: note: in expansion of macro 'KSTM_MODULE_LOADERS'
     801 | KSTM_MODULE_LOADERS(test_printf);
         | ^~~~~~~~~~~~~~~~~~~


vim +/TAINT_KUNIT +45 lib/../tools/testing/selftests/kselftest_module.h

    40	
    41	#define KSTM_MODULE_LOADERS(__module)			\
    42	static int __init __module##_init(void)			\
    43	{							\
    44		pr_info("loaded.\n");				\
  > 45		add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);	\
    46		selftest();					\
    47		return kstm_report(total_tests, failed_tests, skipped_tests);	\
    48	}							\
    49	static void __exit __module##_exit(void)		\
    50	{							\
    51		pr_info("unloaded.\n");				\
    52	}							\
    53	module_init(__module##_init);				\
    54	module_exit(__module##_exit)
    55	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
