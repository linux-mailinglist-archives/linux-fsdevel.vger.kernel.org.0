Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1731954B24A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbiFNN3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiFNN3h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:29:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D092AE39;
        Tue, 14 Jun 2022 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655213376; x=1686749376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N09Lo78A/vN3Z9Ilmb4LDXjX/Vl0OGOLeOGeV0vZZ5Y=;
  b=QX6I1bMlQatqcdfRT6CaDpkwrh+MN5dQKb44Yr58zv/mZATp9aCS9+52
   EixQEHtD1aEm8MWRc02+QZegstzA9qOTa8ktDXgvrcBGDQFzeV7rZd/Qy
   6XYBShYpvy8p2fbtxnzlYMHKD8kA9lWb1thofkxlB7OsZUnioiwCqKM+C
   7G5lBUCD/gJcERrTAvsjjhZ9tKo5O6yKZF5NC3aJb1pfOvDhRRjzTypxh
   2masPah03TtMYl3f62RXM9Hgp9jGr/Fldm+O42Omo+gbLDVfXZvEf1slX
   fG7KpEWTCxUewl2Iva1VLhdFM6mT329gFVWUsQwXkjnEHZ4HenQcd+/gR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267301739"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="267301739"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="726820139"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2022 06:29:32 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o16br-000Lvx-PJ;
        Tue, 14 Jun 2022 13:29:31 +0000
Date:   Tue, 14 Jun 2022 21:28:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] VFS: support concurrent renames.
Message-ID: <202206142141.w8ni6M0m-lkp@intel.com>
References: <165516230199.21248.18142980966152036732.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165516230199.21248.18142980966152036732.stgit@noble.brown>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: i386-buildonly-randconfig-r005-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142141.w8ni6M0m-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c97436f8b6e2718286e8496faf53a2c800e281cf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46a2afd9f68f24a42f38f3a8afebafe7e494e9d8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review NeilBrown/Allow-concurrent-directory-updates/20220614-072355
        git checkout 46a2afd9f68f24a42f38f3a8afebafe7e494e9d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/namei.c:3175:16: warning: no previous prototype for function 'lock_rename_lookup_excl' [-Wmissing-prototypes]
   struct dentry *lock_rename_lookup_excl(struct dentry *p1, struct dentry *p2,
                  ^
   fs/namei.c:3175:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   struct dentry *lock_rename_lookup_excl(struct dentry *p1, struct dentry *p2,
   ^
   static 
   1 warning generated.


vim +/lock_rename_lookup_excl +3175 fs/namei.c

  3174	
> 3175	struct dentry *lock_rename_lookup_excl(struct dentry *p1, struct dentry *p2,
  3176					       struct dentry **d1p, struct dentry **d2p,
  3177					       struct qstr *last1, struct qstr *last2,
  3178					       unsigned int flags1, unsigned int flags2)
  3179	{
  3180		struct dentry *p;
  3181		struct dentry *d1, *d2;
  3182	
  3183		if (p1 == p2) {
  3184			inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
  3185			d1 = __lookup_hash(last1, p1, flags1, NULL);
  3186			if (IS_ERR(d1))
  3187				goto out_unlock_1;
  3188			d2 = __lookup_hash(last2, p2, flags2, NULL);
  3189			if (IS_ERR(d2))
  3190				goto out_unlock_2;
  3191			*d1p = d1; *d2p = d2;
  3192			return NULL;
  3193		out_unlock_2:
  3194			dput(d1);
  3195			d1 = d2;
  3196		out_unlock_1:
  3197			inode_unlock(p1->d_inode);
  3198			return d1;
  3199		}
  3200	
  3201		mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
  3202	
  3203		if ((p = d_ancestor(p2, p1)) != NULL) {
  3204			inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
  3205			inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
  3206		} else if ((p = d_ancestor(p1, p2)) != NULL) {
  3207			inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
  3208			inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
  3209		} else {
  3210			inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
  3211			inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
  3212		}
  3213		d1 = __lookup_hash(last1, p1, flags1, NULL);
  3214		if (IS_ERR(d1))
  3215			goto unlock_out_3;
  3216		d2 = __lookup_hash(last2, p2, flags2, NULL);
  3217		if (IS_ERR(d2))
  3218			goto unlock_out_4;
  3219	
  3220		*d1p = d1;
  3221		*d2p = d2;
  3222		return p;
  3223	unlock_out_4:
  3224		dput(d1);
  3225		d1 = d2;
  3226	unlock_out_3:
  3227		inode_unlock(p1->d_inode);
  3228		inode_unlock(p2->d_inode);
  3229		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
  3230		return d1;
  3231	}
  3232	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
