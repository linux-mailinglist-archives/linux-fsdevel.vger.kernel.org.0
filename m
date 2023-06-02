Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6332371F819
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 03:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjFBBi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 21:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjFBBiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:38:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AD6E6F;
        Thu,  1 Jun 2023 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685669913; x=1717205913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=01GCcuu0HghGwWeCZNHmm9Tq8ORhR7z4ILt07iIC0l8=;
  b=BC/plNyzbbVKycKY7bnJX70W/j4iJ4Rnya6ncF8PBVYBV5KuWgFDfVF2
   fZlALNJ6VVKJnUUzVy8KPY5E4z0Lfajmjm5J0BZovc25OhBk860nTpz7C
   wnyTgIEthCQh0zxDk8GwXjMXCApxfXuaLTnf9DYaqGZM/g8RjYqz2D4jb
   D2RFd0tBJ7WIfHHcBUx4cMKaM2OLWpMTvq2wQktBHkZSCHa0kmf76d1gL
   uw+qcH/ejplQ06WCeXX4fu3NYxX9bj3Brz7M3xF2JXYrEonn6o/0ig6CM
   he+P9nfi81awxLp/EEfrVuIfO3il+6mHjrGl9Ut8P02SEjnKYAd3SaGT1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="336103236"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="336103236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 18:36:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="772677288"
X-IronPort-AV: E=Sophos;i="6.00,211,1681196400"; 
   d="scan'208";a="772677288"
Received: from lkp-server01.sh.intel.com (HELO fb1ced2c09fb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2023 18:36:54 -0700
Received: from kbuild by fb1ced2c09fb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4tin-0002t2-1u;
        Fri, 02 Jun 2023 01:36:53 +0000
Date:   Fri, 2 Jun 2023 09:36:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/6] fs: Establish locking order for unrelated
 directories
Message-ID: <202306020948.TBmCxtVw-lkp@intel.com>
References: <20230601105830.13168-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601105830.13168-4-jack@suse.cz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.4-rc4 next-20230601]
[cannot apply to vfs-idmapping/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jan-Kara/ext4-Remove-ext4-locking-of-moved-directory/20230601-225100
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230601105830.13168-4-jack%40suse.cz
patch subject: [PATCH v2 4/6] fs: Establish locking order for unrelated directories
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20230602/202306020948.TBmCxtVw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/234d970a1de0d79e372cc04d6a8112d2aec56c44
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jan-Kara/ext4-Remove-ext4-locking-of-moved-directory/20230601-225100
        git checkout 234d970a1de0d79e372cc04d6a8112d2aec56c44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306020948.TBmCxtVw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/inode.c: In function 'lock_two_inodes':
>> fs/inode.c:1121:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
    1121 |         if (!inode1 || !inode2)
         |         ^~
   fs/inode.c:1129:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    1129 |                 goto lock;
         |                 ^~~~
>> fs/inode.c:1129:17: error: label 'lock' used but not defined
   fs/inode.c: At top level:
>> fs/inode.c:1136:9: error: expected identifier or '(' before 'if'
    1136 |         if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
         |         ^~
>> fs/inode.c:1139:11: error: expected identifier or '(' before 'else'
    1139 |         } else if (!S_ISDIR(inode1->i_mode))
         |           ^~~~
   In file included from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/inode.c:7:
>> include/linux/minmax.h:167:63: error: expected identifier or '(' before 'while'
     167 |         do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
         |                                                               ^~~~~
   fs/inode.c:1140:17: note: in expansion of macro 'swap'
    1140 |                 swap(inode1, inode2);
         |                 ^~~~
>> fs/inode.c:1141:5: error: expected '=', ',', ';', 'asm' or '__attribute__' before ':' token
    1141 | lock:
         |     ^
   fs/inode.c:1144:9: error: expected identifier or '(' before 'if'
    1144 |         if (inode2 && inode2 != inode1)
         |         ^~
>> fs/inode.c:1146:1: error: expected identifier or '(' before '}' token
    1146 | }
         | ^


vim +/lock +1129 fs/inode.c

  1105	
  1106	/**
  1107	 * lock_two_inodes - lock two inodes (may be regular files but also dirs)
  1108	 *
  1109	 * Lock any non-NULL argument. The caller must make sure that if he is passing
  1110	 * in two directories, one is not ancestor of the other.  Zero, one or two
  1111	 * objects may be locked by this function.
  1112	 *
  1113	 * @inode1: first inode to lock
  1114	 * @inode2: second inode to lock
  1115	 * @subclass1: inode lock subclass for the first lock obtained
  1116	 * @subclass2: inode lock subclass for the second lock obtained
  1117	 */
  1118	void lock_two_inodes(struct inode *inode1, struct inode *inode2,
  1119			     unsigned subclass1, unsigned subclass2)
  1120	{
> 1121		if (!inode1 || !inode2)
  1122			/*
  1123			 * Make sure @subclass1 will be used for the acquired lock.
  1124			 * This is not strictly necessary (no current caller cares) but
  1125			 * let's keep things consistent.
  1126			 */
  1127			if (!inode1)
  1128				swap(inode1, inode2);
> 1129			goto lock;
  1130		}
  1131	
  1132		/*
  1133		 * If one object is directory and the other is not, we must make sure
  1134		 * to lock directory first as the other object may be its child.
  1135		 */
> 1136		if (S_ISDIR(inode2->i_mode) == S_ISDIR(inode1->i_mode)) {
  1137			if (inode1 > inode2)
  1138				swap(inode1, inode2);
> 1139		} else if (!S_ISDIR(inode1->i_mode))
  1140			swap(inode1, inode2);
> 1141	lock:
  1142		if (inode1)
  1143			inode_lock_nested(inode1, subclass1);
  1144		if (inode2 && inode2 != inode1)
  1145			inode_lock_nested(inode2, subclass2);
> 1146	}
  1147	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
