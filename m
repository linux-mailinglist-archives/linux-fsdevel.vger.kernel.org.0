Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82425292B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 23:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349201AbiEPVNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 17:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiEPVM4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 17:12:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796838B3;
        Mon, 16 May 2022 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652735160; x=1684271160;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZYt40Q+PfFSSqQhOuPpZ/jVUPjaP/eVg7/MgNninAro=;
  b=IeyTe/ArzNPfXAP2ZFH8Cbk5fHR0ZOkI7sfLSfQLKTEUTaqYDAZC1Ji3
   /w2ZlNBLitq8UpaKLn8N0cd7hGaMOloePNd8kQpnlU0MItyPUCVrHJcl9
   YAIEISBmStg3jg6uZNtWP8aNuGiNMNkOZDn2GcIxTJJYbHgbeQjWimo9h
   7UcnU91GRLGf7yRHivdDEYtCBlJyMANIFS+PUJ+u0luNj+yWIcCDxvVcv
   6Fwr8MImad0qfkbvSjraWk14VYVy1PFu5o1AiZDnmFKxkbGYiEXuQ9UUj
   BOUrsiBk+eWwLay9YWqAIP4Keln4+iC/8Mzz1MRrGL/mOIswQlOOJdEsP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258524322"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="258524322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 14:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="544548627"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2022 14:05:51 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqhuY-0000LC-JA;
        Mon, 16 May 2022 21:05:50 +0000
Date:   Tue, 17 May 2022 05:05:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiubo Li <xiubli@redhat.com>, jlayton@kernel.org,
        viro@zeniv.linux.org.uk
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, idryomov@gmail.com,
        vshankar@redhat.com, ceph-devel@vger.kernel.org, mcgrof@kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH 2/2] ceph: wait the first reply of inflight unlink/rmdir
Message-ID: <202205170402.ez4Z5njh-lkp@intel.com>
References: <20220516122046.40655-3-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516122046.40655-3-xiubli@redhat.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: i386-randconfig-a001-20220516 (https://download.01.org/0day-ci/archive/20220517/202205170402.ez4Z5njh-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 853fa8ee225edf2d0de94b0dcbd31bea916e825e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/85d578952d01b70d71fccd86ccb0fdd1dbd0df8b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiubo-Li/ceph-wait-async-unlink-to-finish/20220516-202249
        git checkout 85d578952d01b70d71fccd86ccb0fdd1dbd0df8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ceph_wait_on_conflict_unlink
   >>> referenced by dir.c
   >>>               ceph/dir.o:(ceph_link) in archive fs/built-in.a
   >>> referenced by dir.c
   >>>               ceph/dir.o:(ceph_symlink) in archive fs/built-in.a
   >>> referenced by dir.c
   >>>               ceph/dir.o:(ceph_mkdir) in archive fs/built-in.a
   >>> referenced 3 more times

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
