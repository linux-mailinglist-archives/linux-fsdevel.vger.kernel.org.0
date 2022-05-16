Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B46529510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiEPXS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 19:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiEPXS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 19:18:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C033A27;
        Mon, 16 May 2022 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652743136; x=1684279136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i7wsPh2fobRlYAsrYMy+rFuqEKWx5TVdq2AvC5j5cTM=;
  b=cKfVcab3x8TlxZMvvXgy1t6xPlZ+QB4xUaOzgfYQDAJdPwo/fFHkUtRK
   LdbpUysTlea/lPTAvifA1yQk3BXFFyufA/4V42+pMwqK5zR/Vo0YuhkFW
   XVKBEYApt9TPT/cFlAmvadYpDURXLQx1r93ZuDvzBj9XJRFoSyRrNpPM8
   mxBEJ6Yqth0Ytoj0R4TOA3dR5MBS9P7FlzAkyFEn00HCPTzwmx0yA+VS2
   flIkOISPO1rpSyZMgqOqfhSRGBvNpPG1sISdBqQEPnB84NZNaw8zWZpAR
   AeFbeFAU2ER7Ornrxv8wygG7m2IbInjA1OvDTwRP2LVS6zpi76pkLj4Rn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="334034458"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="334034458"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 16:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="555493661"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 May 2022 16:18:53 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqjzI-0000PN-Ql;
        Mon, 16 May 2022 23:18:52 +0000
Date:   Tue, 17 May 2022 07:18:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiubo Li <xiubli@redhat.com>, jlayton@kernel.org,
        viro@zeniv.linux.org.uk
Cc:     kbuild-all@lists.01.org, idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, mcgrof@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 2/2] ceph: wait the first reply of inflight unlink/rmdir
Message-ID: <202205170751.AZfL9JiX-lkp@intel.com>
References: <20220516122046.40655-3-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516122046.40655-3-xiubli@redhat.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Xiubo,

I love your patch! Yet something to improve:

[auto build test ERROR on ceph-client/for-linus]
[also build test ERROR on linus/master v5.18-rc7 next-20220516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiubo-Li/ceph-wait-async-unlink-to-finish/20220516-202249
base:   https://github.com/ceph/ceph-client.git for-linus
config: i386-debian-10.3-kselftests (https://download.01.org/0day-ci/archive/20220517/202205170751.AZfL9JiX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/85d578952d01b70d71fccd86ccb0fdd1dbd0df8b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiubo-Li/ceph-wait-async-unlink-to-finish/20220516-202249
        git checkout 85d578952d01b70d71fccd86ccb0fdd1dbd0df8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ceph_wait_on_conflict_unlink" [fs/ceph/ceph.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
