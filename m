Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93365AB92C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 22:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIBUJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 16:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBUJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:09:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04CA32A8B;
        Fri,  2 Sep 2022 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662149388; x=1693685388;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dfYcUn+noeT5T7sIeUiJNjSqZU06JxPpPMa1yx2CwNs=;
  b=Xy8Y9qqZGC/baP+jeME/oFDbDgmHUmWi1ZUnQv47muSxlHpzswmPrO5R
   v5j48Zmjw7/Jd1bWtVpbAME/5PvYBVtiNaIXsHzg/iDRhMpZhufn2HjzK
   PA3wpiKlLjaB9By2ungKB4gUxq1UDkNtcMv33Tnhhxp2RUqi41Yu74EGQ
   BqczzdPFWPwOIR7fbsg2TkKUzJ4qznQqnaXyrkobiBfsa59De5gt7kkwp
   DU60wfV3+9osazpwG9ANUng4J3H/Vkr0T5rjLjH+h4m3IB8sWhH3a11PA
   E3fWASxJ2z88bYfkbCrSfyxGZFqHiDeKkTb670PzM6uRKLkc7/q7VJ0UD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382373013"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="382373013"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 12:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="609084187"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2022 12:36:18 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUCSf-0000WB-2p;
        Fri, 02 Sep 2022 19:36:17 +0000
Date:   Sat, 3 Sep 2022 03:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunhui Cui <cuiyunhui@bytedance.com>, corbet@lwn.net,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, david@redhat.com,
        mail@christoph.anton.mitterer.name, ccross@google.com,
        vincent.whitchurch@axis.com, paul.gortmaker@windriver.com,
        peterz@infradead.org, edumazet@google.com, joshdon@google.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] bpf: added the account of BPF running time
Message-ID: <202209030333.Goj9I0Pe-lkp@intel.com>
References: <20220902101217.1419-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902101217.1419-1-cuiyunhui@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Yunhui,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunhui-Cui/bpf-added-the-account-of-BPF-running-time/20220902-181437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220903/202209030333.Goj9I0Pe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/e31420772f2a63d6bc561211b8ef0331d41b2123
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yunhui-Cui/bpf-added-the-account-of-BPF-running-time/20220902-181437
        git checkout e31420772f2a63d6bc561211b8ef0331d41b2123
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /usr/bin/ld: warning: arch/x86/um/vdso/vdso.o: missing .note.GNU-stack section implies executable stack
   /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
   /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
   /usr/bin/ld: kernel/seccomp.o: in function `seccomp_run_filters':
   seccomp.c:(.text+0xaa7): undefined reference to `bpftime'
   /usr/bin/ld: fs/proc/stat.o: in function `show_stat':
   stat.c:(.text+0x124): undefined reference to `bpftime'
   /usr/bin/ld: stat.c:(.text+0x332): undefined reference to `bpftime'
   /usr/bin/ld: net/core/flow_dissector.o: in function `bpf_flow_dissect':
>> flow_dissector.c:(.text+0x9f5): undefined reference to `bpftime'
   /usr/bin/ld: net/core/dev.o: in function `bpf_prog_run_generic_xdp':
>> dev.c:(.text+0x8c43): undefined reference to `bpftime'
   /usr/bin/ld: net/core/ptp_classifier.o:ptp_classifier.c:(.text+0xf8): more undefined references to `bpftime' follow
   collect2: error: ld returned 1 exit status

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
