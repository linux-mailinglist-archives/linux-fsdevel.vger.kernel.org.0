Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6554A834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348863AbiFNEgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237415AbiFNEgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:36:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0322A2E9E4;
        Mon, 13 Jun 2022 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655181377; x=1686717377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w3AuYhdMjXjPxjl++z71XmS+MtkRJl7PxlCwQyEHuZw=;
  b=Vpeg6euaE2ByM/f1TYXPxjYSttj8LP4ByVWyKFXx4GLNcrmiqD/tD8Kf
   Lw3P0ofzXXm78OA9Wqr6Tk7OMobMBlvsVWVzfM1mQUNecIMPrRGY5iFqg
   UDzvvIEJBfloX1Av2tvc1yiwaTAEYq8iCnv2XRGy05f/36In/kd9n1f5v
   QjJjWKnyshl3nPyZ5ZOf52Jwki9LGB9njaUyKGHQaqeec2V8AhmPu/0Cp
   GSy/711yvaOt4ognesG1mJR30QcYqLjQp4J9o5RZy2fPkn2rOX0RZrUZI
   CcVG6pDRjZ6Z2ldZa7/oWEL4W85JXhpK3ly7CTgfvrBlwWooR4AobJMpN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261535560"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261535560"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="612065590"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2022 21:36:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0yHl-000LTn-Cn;
        Tue, 14 Jun 2022 04:36:13 +0000
Date:   Tue, 14 Jun 2022 12:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] VFS: support concurrent renames.
Message-ID: <202206141215.dWJM11Ut-lkp@intel.com>
References: <165516230199.21248.18142980966152036732.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165516230199.21248.18142980966152036732.stgit@noble.brown>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc2 next-20220610]
[cannot apply to trondmy-nfs/linux-next viro-vfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/Allow-concurrent-directory-updates/20220614-072355
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220614/202206141215.dWJM11Ut-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/46a2afd9f68f24a42f38f3a8afebafe7e494e9d8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review NeilBrown/Allow-concurrent-directory-updates/20220614-072355
        git checkout 46a2afd9f68f24a42f38f3a8afebafe7e494e9d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/namei.c:3175:16: warning: no previous prototype for 'lock_rename_lookup_excl' [-Wmissing-prototypes]
    3175 | struct dentry *lock_rename_lookup_excl(struct dentry *p1, struct dentry *p2,
         |                ^~~~~~~~~~~~~~~~~~~~~~~


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
