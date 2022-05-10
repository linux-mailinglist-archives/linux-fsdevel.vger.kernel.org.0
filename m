Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9F520A46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 02:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiEJAjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 20:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiEJAjD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 20:39:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C932AEDB9;
        Mon,  9 May 2022 17:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652142907; x=1683678907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ws6RuJwZ5f3e7nMk3f5y6a+++iD9RCQTt1KaPqd40aE=;
  b=OGav8uwtxbtM5zMD2NzeTWIWHG5mm8YBgIZrI9IRU1V+IUOxXzl/zCRe
   o3KPzThgfMcIBSpRj5c2+jRoiMuuqc8sShaJDC4hEV1CvvQSGw/c0o6ig
   zah3IfL+BO9+RvXrVA/MSQHQjDStk7cFa+MqrD4NjDjs2wN7eyA/XHExR
   JpkiNEoaNDlnPK8FwzlNfQkXDOp5Hy1AMGUsxRdd+jCnYTrJOH+wfdBKF
   7y1ErIcsyiz4LfgHoBfFJOUUK1eC0ZczgwkmNVCZy196aUxW/ttTSuJaa
   bCPPb5qRgtpPKK9Fy1xP0owLlsUFZ6YfPTKwIPfoI+ysk11rkXUkzdnpa
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269144889"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="269144889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:35:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="552268142"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 17:35:04 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noDqB-000H3S-NV;
        Tue, 10 May 2022 00:35:03 +0000
Date:   Tue, 10 May 2022 08:34:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <202205100814.M4Aiy8hF-lkp@intel.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131726.59664-1-tcs.kernel@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Haimin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Haimin-Zhang/fs-pipe-Deinitialize-the-watch_queue-when-pipe-is-freed/20220509-212415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
config: s390-randconfig-r004-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100814.M4Aiy8hF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3abb68a626160e019c30a4860e569d7bc75e486a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/22e9d0a2c66d49444376e55348c8a6fa26e6d150
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Haimin-Zhang/fs-pipe-Deinitialize-the-watch_queue-when-pipe-is-freed/20220509-212415
        git checkout 22e9d0a2c66d49444376e55348c8a6fa26e6d150
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   <inline asm>:5:5: error: expected absolute expression
   .if 6651b-6641b > 254
       ^
   <inline asm>:6:2: error: cpu alternatives does not support instructions blocks > 254 bytes
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   <inline asm>:8:5: error: expected absolute expression
   .if (6651b-6641b) % 2
       ^
   <inline asm>:9:2: error: cpu alternatives instructions length is odd
           .error "cpu alternatives instructions length is odd"
           ^
   <inline asm>:15:5: error: expected absolute expression
   .if -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) > 6
       ^
>> <inline asm>:18:8: error: unexpected token in '.rept' directive
           .rept (-(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) - (6620b-662b)) / 2
                 ^
   <inline asm>:21:8: error: unexpected token in '.rept' directive
           .rept -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) / 6
                 ^
>> <inline asm>:22:2: error: unknown directive
           .brcl 0,0
           ^
>> <inline asm>:23:7: error: unmatched '.endr' directive
           .endr
                ^
   <inline asm>:24:8: error: unexpected token in '.rept' directive
           .rept -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) % 6 / 4
                 ^
   <inline asm>:26:7: error: unmatched '.endr' directive
           .endr
                ^
   <inline asm>:27:8: error: unexpected token in '.rept' directive
           .rept -(((6651b-6641b)-(662b-661b)) > 0) * ((6651b-6641b)-(662b-661b)) % 6 % 4 / 2
                 ^
   <inline asm>:29:6: error: unmatched '.endr' directive
   .endr
        ^
   <inline asm>:32:5: error: expected absolute expression
   .if 662b-661b > 254
       ^
   <inline asm>:33:2: error: cpu alternatives does not support instructions blocks > 254 bytes
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   <inline asm>:35:5: error: expected absolute expression
   .if (662b-661b) % 2
       ^
   <inline asm>:36:2: error: cpu alternatives instructions length is odd
           .error "cpu alternatives instructions length is odd"
           ^
   In file included from kernel/watch_queue.c:11:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: expected absolute expression
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:62:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           ".if " len " > 254\n"                                           \
            ^
   <inline asm>:5:5: note: instantiated into assembly here
   .if 6651b-6641b > 254
       ^
   In file included from kernel/watch_queue.c:11:
   In file included from include/linux/module.h:14:
   In file included from include/linux/buildid.h:5:
   In file included from include/linux/mm_types.h:8:
   In file included from include/linux/kref.h:16:
   In file included from include/linux/spinlock.h:93:
   arch/s390/include/asm/spinlock.h:81:3: error: cpu alternatives does not support instructions blocks > 254 bytes
                   ALTERNATIVE("", ".insn rre,0xb2fa0000,7,0", 49) /* NIAI 7 */
                   ^
   arch/s390/include/asm/alternative.h:118:2: note: expanded from macro 'ALTERNATIVE'
           ALTINSTR_REPLACEMENT(altinstr, 1)                               \
           ^
   arch/s390/include/asm/alternative.h:113:2: note: expanded from macro 'ALTINSTR_REPLACEMENT'
           INSTR_LEN_SANITY_CHECK(altinstr_len(num))
           ^
   arch/s390/include/asm/alternative.h:63:3: note: expanded from macro 'INSTR_LEN_SANITY_CHECK'
           "\t.error \"cpu alternatives does not support instructions "    \
            ^
   <inline asm>:6:2: note: instantiated into assembly here
           .error "cpu alternatives does not support instructions blocks > 254 bytes"
           ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
