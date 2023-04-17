Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F16E4815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 14:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDQMoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 08:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjDQMou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:44:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8056E6;
        Mon, 17 Apr 2023 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681735489; x=1713271489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y/esuIhc93Jp7lxKz3B0zEndGBlU9SQYN2Zc+WRiBI4=;
  b=aC3W/gRrGmSM4EGAfg9/g+CnS21TGwon1u2GEwboDuwTsGz8hYGSI1Eq
   P0u0A0mF41stSrsq83TfsXlKiwF1mpVyx7RJRgfCFjVV21qeO4iRdaAKi
   0m8Q6LVsfMtHHDs27sDZlze5myeEYWqJrAfM6PF94ibZboZWIr95CMC2o
   Cp0H01xXhRnoIFixuDvX64nK2MJjafIAT9Q5OgxSAH2i/FAdDWAt0Nirs
   k8HCcIA4rpgvFIEMNdzy8SYnI1MHlObCArlFEr4VGGLWUfsdEMF/sHC1b
   MBkXbzelpps66rf3y5COkhCbttA9a4X8Zk8FSeMXPxb3Mc0TKvZCgVDaH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="346729368"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="346729368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 05:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="834407213"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="834407213"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2023 05:44:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poODs-000cMF-0V;
        Mon, 17 Apr 2023 12:44:44 +0000
Date:   Mon, 17 Apr 2023 20:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     wenyang.linux@foxmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Wen Yang <wenyang.linux@foxmail.com>,
        Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore
 eventfd to reduce cpu utilization
Message-ID: <202304172058.piI49JCE-lkp@intel.com>
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on vfs-idmapping/for-next]
[also build test WARNING on linus/master v6.3-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wenyang-linux-foxmail-com/eventfd-support-delayed-wakeup-for-non-semaphore-eventfd-to-reduce-cpu-utilization/20230416-193353
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git for-next
patch link:    https://lore.kernel.org/r/tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605%40qq.com
patch subject: [PATCH] eventfd: support delayed wakeup for non-semaphore eventfd to reduce cpu utilization
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/ea9214e265bae223a795f144d6ddcac65e8e2084
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review wenyang-linux-foxmail-com/eventfd-support-delayed-wakeup-for-non-semaphore-eventfd-to-reduce-cpu-utilization/20230416-193353
        git checkout ea9214e265bae223a795f144d6ddcac65e8e2084
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304172058.piI49JCE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/sysctl/fs.rst:74: WARNING: Title underline too short.

vim +74 Documentation/admin-guide/sysctl/fs.rst

    72	
    73	eventfd_wakeup_delay_msec
  > 74	------------------
    75	Frequent writing of an eventfd can also lead to frequent wakeup of the peer
    76	read process, resulting in significant cpu overhead.
    77	How ever for the NON SEMAPHORE eventfd, if it's counter has a nonzero value,
    78	then a read(2) returns 8 bytes containing that value, and the counter's value
    79	is reset to zero.
    80	So it coule be optimized as follows: N event_writes vs ONE event_read.
    81	By adding a configurable delay after eventfd_write, these unnecessary wakeup
    82	operations are avoided.
    83	The max value is 100 ms.
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
