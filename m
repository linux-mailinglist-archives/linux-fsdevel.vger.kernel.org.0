Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D55573F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 09:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiFWH3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiFWH3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:29:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD84B4664C;
        Thu, 23 Jun 2022 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655969364; x=1687505364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r6+u7rtwUPyah+DHyy+CWmgovPjWOMdGY0liClTcjRE=;
  b=R8c/fZd2Y2II5WUomFqWuhZIqW0fvamoY3i4NFZzFeN9Iha51Fs3OLdF
   qkFDO/Hey8TxCvp6DJDWGs7x9I4pYkjjXRjvmDxxM5muynNjEUF5xziji
   FIXb/o1qq6TQ60d0QjYArU8zPpo480S0FCz3I/PRhBugSLDh8W9tj1hk4
   kSD5MwJQRbt668mKaRLs29+94gQspn4irteuBN63yBK24zEyaFUHDAfz+
   FnZYpzwDYoT/dXIrmctzQIy3ZUCiTnbMAnQuaXWRgk0CtdSPcQqfZuepz
   YNUfm6hFRX5Dzb3+P7hmybRyW/kdpGKAf/HkytJTf2jxtpPqmCCizqF15
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="306109834"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="306109834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 00:29:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="621218836"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Jun 2022 00:29:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4HHF-0000r3-2k;
        Thu, 23 Jun 2022 07:29:21 +0000
Date:   Thu, 23 Jun 2022 15:29:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org
Cc:     kbuild-all@lists.01.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: Re: [PATCH 6/7] ext4: Enable negative dentries on case-insensitive
 lookup
Message-ID: <202206231550.0JrilBjp-lkp@intel.com>
References: <20220622194603.102655-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-7-krisman@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

I love your patch! Yet something to improve:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on jaegeuk-f2fs/dev-test linus/master v5.19-rc3 next-20220622]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/Support-negative-dentries-on-case-insensitive-directories/20220623-034942
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: x86_64-randconfig-a006 (https://download.01.org/0day-ci/archive/20220623/202206231550.0JrilBjp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/69488ccc517a48af2f1cec0efb84651397edf6f6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/Support-negative-dentries-on-case-insensitive-directories/20220623-034942
        git checkout 69488ccc517a48af2f1cec0efb84651397edf6f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "d_set_casefold_lookup" [fs/ext4/ext4.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
