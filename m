Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF8A4BD597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 06:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbiBUF1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 00:27:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344522AbiBUF1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 00:27:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D56557;
        Sun, 20 Feb 2022 21:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645421231; x=1676957231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dHGj8oHhf1bY1cn6txGNu5geRsuh5pSV2cXKp7lEBiQ=;
  b=Tqa1sipcYcp5fC1mOcEYYejzZx/zVNhoUmNvUYxSesVknEs021OASzE8
   TwGdc6dga+goy7T1Opm6H7hQ9v7yhyR4c5BWbSOMCqW1sA+qgcT3AgVsw
   HFityz3XMJbJ5JHiXLoo0PYTbTRwm/fmESahbp5Eq7oQUkqDxSo6d/vAx
   wUl7lx00ZpM2n3Us62UejZm4yztHqcIREkv1uBhhEyNmVqPks0KyIvLjz
   XWeiKhtUPFPSRgq5l3fzMoAkIpw2tAZsXjeswsPhCNk7qEIpjsI5E7vUo
   cbxIdNM79TmAuzC0KFUV7nAXRD31B2I9KQX2fqcgTOeLFW3NKCX6KNwIU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="238851663"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="238851663"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 21:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="572985990"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Feb 2022 21:27:07 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nM1E2-0001La-LE; Mon, 21 Feb 2022 05:27:06 +0000
Date:   Mon, 21 Feb 2022 13:26:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     tangmeng <tangmeng@uniontech.com>,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     kbuild-all@lists.01.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nizhen@uniontech.com, zhanglianjie@uniontech.com,
        nixiaoming@huawei.com, tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH 01/11] kernel/parisc: move soft-power sysctl to its own
 file
Message-ID: <202202211342.EcgL15uq-lkp@intel.com>
References: <20220220060000.13079-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220220060000.13079-1-tangmeng@uniontech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi tangmeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on deller-parisc/for-next rostedt-trace/for-next linus/master v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/tangmeng/kernel-parisc-move-soft-power-sysctl-to-its-own-file/20220220-174553
base:   https://github.com/hnaz/linux-mm master
config: parisc-randconfig-s031-20220220 (https://download.01.org/0day-ci/archive/20220221/202202211342.EcgL15uq-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/fc2d0c0a37a34fd9c89e5519f2aea93de690c2ce
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tangmeng/kernel-parisc-move-soft-power-sysctl-to-its-own-file/20220220-174553
        git checkout fc2d0c0a37a34fd9c89e5519f2aea93de690c2ce
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash drivers/parisc/ mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/parisc/power.c:196:12: error: static declaration of 'pwrsw_enabled' follows non-static declaration
     196 | static int pwrsw_enabled;
         |            ^~~~~~~~~~~~~
   drivers/parisc/power.c:112:5: note: previous definition of 'pwrsw_enabled' with type 'int'
     112 | int pwrsw_enabled __read_mostly = 1;
         |     ^~~~~~~~~~~~~


vim +/pwrsw_enabled +196 drivers/parisc/power.c

   195	
 > 196	static int pwrsw_enabled;
   197	#ifdef CONFIG_SYSCTL
   198	static struct ctl_table kern_parisc_power_table[] = {
   199		{
   200			.procname       = "soft-power",
   201			.data           = &pwrsw_enabled,
   202			.maxlen         = sizeof(int),
   203			.mode           = 0644,
   204			.proc_handler   = proc_dointvec,
   205		},
   206		{ }
   207	};
   208	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
