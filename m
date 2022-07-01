Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097B8563877
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Jul 2022 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiGARRG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Jul 2022 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGARRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:17:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FBD167C9;
        Fri,  1 Jul 2022 10:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656695824; x=1688231824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=78PtGUkKSp36JzVKi0xJJNA9YET195hTgBzl+p/xvmM=;
  b=A2gnsFjE3ZPeTI+x9CA1JXAN5UA24mJHbH+t855fd3gSTISb6545KugD
   Z+rXdRSJvCy7vgb039XagZXlAclk4980/8UzYJoPdsvgzX566F6wrHjm3
   rEqZWJIhCHoKhJtcW6odgZfsQ6Df+i0YZtx1lzkFSVtbAzfNthcb42jcd
   zgs0biuXedqEEzXboMsdxEflq2dFnRaY4oWUL5eUjAI9IQQPz1UDbvtIB
   umnA/JImmuJvpE6q8yrUN3ux3zBPn1QdVe9xHRK4DHnw9eDbLqr2FDl+1
   tDrx0yN+rtGXsPUOqfMr1bIygby2G/12G+3V21XBsSsXCZsKke5HUKxZ2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281464206"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="281464206"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 10:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="566417554"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jul 2022 10:16:56 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7KGG-000EBO-5W;
        Fri, 01 Jul 2022 17:16:56 +0000
Date:   Sat, 2 Jul 2022 01:16:31 +0800
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
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
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
Message-ID: <202207020131.L5kV3eDf-lkp@intel.com>
References: <20220701084744.3002019-4-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701084744.3002019-4-davidgow@google.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: arm-randconfig-r024-20220629 (https://download.01.org/0day-ci/archive/20220702/202207020131.L5kV3eDf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a9119143a2d1f4d0d0bc1fe0d819e5351b4e0deb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/42b6461d6cca4baeeeed474b1400e203057c2b9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review David-Gow/panic-Taint-kernel-if-tests-are-run/20220701-164843
        git checkout 42b6461d6cca4baeeeed474b1400e203057c2b9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/test_printf.c:157:52: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                  ~~~~                       ^
                                  %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:55: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                       ~~~~                     ^
                                       %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:58: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                            ~~~~                   ^~~
                                            %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:63: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                                 ~~~~                   ^~~
                                                 %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:157:68: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
           test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
                                                      ~~~~                   ^~
                                                      %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:52: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                  ~~~~                       ^
                                  %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:55: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                       ~~~~                     ^
                                       %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:58: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                            ~~~~                   ^~~
                                            %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:63: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                                 ~~~~                   ^~~
                                                 %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:158:68: warning: format specifies type 'char' but the argument has type 'int' [-Wformat]
           test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
                                                      ~~~~                   ^~
                                                      %d
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:159:41: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
           test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
                                     ~~~          ^~~~
                                     %o
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:159:47: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
           test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
                                        ~~~             ^~~~
                                        %o
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
   lib/test_printf.c:159:53: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]
           test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
                                           ~~~~               ^~~~~~
                                           %#o
   lib/test_printf.c:137:40: note: expanded from macro 'test'
           __test(expect, strlen(expect), fmt, ##__VA_ARGS__)
                                          ~~~    ^~~~~~~~~~~
>> lib/test_printf.c:801:1: error: use of undeclared identifier 'TAINT_KUNIT'
   KSTM_MODULE_LOADERS(test_printf);
   ^
   lib/../tools/testing/selftests/kselftest_module.h:45:12: note: expanded from macro 'KSTM_MODULE_LOADERS'
           add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);       \
                     ^
   13 warnings and 1 error generated.
--
>> lib/test_scanf.c:811:1: error: use of undeclared identifier 'TAINT_KUNIT'
   KSTM_MODULE_LOADERS(test_scanf);
   ^
   lib/../tools/testing/selftests/kselftest_module.h:45:12: note: expanded from macro 'KSTM_MODULE_LOADERS'
           add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);       \
                     ^
   1 error generated.
--
>> lib/test_bitmap.c:889:1: error: use of undeclared identifier 'TAINT_KUNIT'
   KSTM_MODULE_LOADERS(test_bitmap);
   ^
   lib/../tools/testing/selftests/kselftest_module.h:45:12: note: expanded from macro 'KSTM_MODULE_LOADERS'
           add_taint(TAINT_KUNIT, LOCKDEP_STILL_OK);       \
                     ^
   1 error generated.


vim +/TAINT_KUNIT +801 lib/test_printf.c

707cc7280f452a1 Rasmus Villemoes 2015-11-06  800  
6b1a4d5b1a26ae8 Tobin C. Harding 2019-04-05 @801  KSTM_MODULE_LOADERS(test_printf);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
