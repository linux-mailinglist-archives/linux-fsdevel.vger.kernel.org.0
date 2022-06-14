Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E154B1A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356093AbiFNMmB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 08:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356244AbiFNMln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:41:43 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E33457B9;
        Tue, 14 Jun 2022 05:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655210312; x=1686746312;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JZpQvDvEIGZaQUq59bSiwPNjvfk7SP1Lb3vRsb+B8Io=;
  b=Lk/jEIiYK7feeM2vPVRCWln2ntqpFXNwxNbBG1rDLvduvnt5qrpZ73fi
   HGR/w2kr3RZPMY7Kefk5UL34VTO4qigHDtVoxPM9V0odiaNnopgy/FxvH
   8u9rRClS7ATnQjYnW1yU56CSO4M3qniSMRPWMgLyh3SkuZe3qiAWQzvNF
   Db6YvBuZiSGYWQz8JPiw0qX+EdfnOVUAjaEPJ20bbJlr39yFJDPFe+pXh
   bBzkSqkZuOdPgMUjziztRWxxmkJrhSSSpiwciWeKwqvlmULEbMOmbS1K4
   HkCB8AA4bXrIERLvyLiy3tx03VOJPo3ekL/UMc0AtvrPD4E1ojZIUxhru
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="304016026"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="304016026"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="617980489"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jun 2022 05:38:30 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o15oT-000LsV-D8;
        Tue, 14 Jun 2022 12:38:29 +0000
Date:   Tue, 14 Jun 2022 20:37:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] VFS: support concurrent renames.
Message-ID: <202206142059.8hhAq16w-lkp@intel.com>
References: <165516230199.21248.18142980966152036732.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165516230199.21248.18142980966152036732.stgit@noble.brown>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc2 next-20220614]
[cannot apply to trondmy-nfs/linux-next viro-vfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/Allow-concurrent-directory-updates/20220614-072355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
config: i386-randconfig-s001-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142059.8hhAq16w-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/46a2afd9f68f24a42f38f3a8afebafe7e494e9d8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review NeilBrown/Allow-concurrent-directory-updates/20220614-072355
        git checkout 46a2afd9f68f24a42f38f3a8afebafe7e494e9d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/namei.c:3175:15: sparse: sparse: symbol 'lock_rename_lookup_excl' was not declared. Should it be static?
   fs/namei.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'terminate_walk' - unexpected unlock
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'try_to_unlazy' - unexpected unlock
   include/linux/rcupdate.h:726:9: sparse: sparse: context imbalance in 'try_to_unlazy_next' - unexpected unlock
   fs/namei.c:2492:19: sparse: sparse: context imbalance in 'path_init' - different lock contexts for basic block

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
