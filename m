Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1E577F0D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 09:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348351AbjHQHBU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 03:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348397AbjHQHBP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:01:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BA2712;
        Thu, 17 Aug 2023 00:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692255674; x=1723791674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJecru2MS+4Qam6WJWWn6XOWJpvEESf1Ln+mn83CJjU=;
  b=CUSB527pQWHa2tTvu+0F1xMV7nbWrvxBkLeNLcv7RafVq1zkIjIXEThN
   n2doZFtLkZjg+lt7JjX5SAp+jX5aGSq4YRa/xMXjqM60rH0Maykv6bvcz
   +nVclDh8F3/TRbizGCbxAzZNdbUPyo5cd8LtUFwte73fgwOpa5G7oDJ/L
   hGpd42xHGFcTTg3c37Jrmt+CjqXCcis+y768IySjtwLIFA/Gf3Z7L9VGN
   vnB/5NuZr05N0Srzcgl7no+Z8GESW1+mBzYIC6MSSQHeof4YcgQgW859G
   XaahcHdo40G23UGuom4aZ5pbDqOw+w2jRHXgbXOlQ7yTfKRflWogJkTRn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403711262"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="403711262"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:01:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711421261"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="711421261"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Aug 2023 00:01:10 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWX0H-0000sI-28;
        Thu, 17 Aug 2023 07:01:09 +0000
Date:   Thu, 17 Aug 2023 15:00:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gabriel Krisman Bertazi <krisman@suse.de>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, tytso@mit.edu, ebiggers@kernel.org,
        jaegeuk@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@suse.de>
Subject: Re: [PATCH v5 04/10] fs: Expose name under lookup to d_revalidate
 hooks
Message-ID: <202308171453.3HpCqtib-lkp@intel.com>
References: <20230812004146.30980-5-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812004146.30980-5-krisman@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gabriel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on linus/master]
[cannot apply to tyhicks-ecryptfs/next ericvh-v9fs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Krisman-Bertazi/fs-Expose-helper-to-check-if-a-directory-needs-casefolding/20230812-084506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230812004146.30980-5-krisman%40suse.de
patch subject: [PATCH v5 04/10] fs: Expose name under lookup to d_revalidate hooks
config: mips-randconfig-r002-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171453.3HpCqtib-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171453.3HpCqtib-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171453.3HpCqtib-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ecryptfs/dentry.c:33: warning: Function parameter or member 'name' not described in 'ecryptfs_d_revalidate'


vim +33 fs/ecryptfs/dentry.c

237fead619984c Michael Halcrow         2006-10-04  17  
237fead619984c Michael Halcrow         2006-10-04  18  /**
237fead619984c Michael Halcrow         2006-10-04  19   * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
237fead619984c Michael Halcrow         2006-10-04  20   * @dentry: The ecryptfs dentry
0b728e1911cbe6 Al Viro                 2012-06-10  21   * @flags: lookup flags
237fead619984c Michael Halcrow         2006-10-04  22   *
237fead619984c Michael Halcrow         2006-10-04  23   * Called when the VFS needs to revalidate a dentry. This
237fead619984c Michael Halcrow         2006-10-04  24   * is called whenever a name lookup finds a dentry in the
237fead619984c Michael Halcrow         2006-10-04  25   * dcache. Most filesystems leave this as NULL, because all their
237fead619984c Michael Halcrow         2006-10-04  26   * dentries in the dcache are valid.
237fead619984c Michael Halcrow         2006-10-04  27   *
237fead619984c Michael Halcrow         2006-10-04  28   * Returns 1 if valid, 0 otherwise.
237fead619984c Michael Halcrow         2006-10-04  29   *
237fead619984c Michael Halcrow         2006-10-04  30   */
0838ae103beaf6 Gabriel Krisman Bertazi 2023-08-11  31  static int ecryptfs_d_revalidate(struct dentry *dentry,
0838ae103beaf6 Gabriel Krisman Bertazi 2023-08-11  32  				 const struct qstr *name, unsigned int flags)
237fead619984c Michael Halcrow         2006-10-04 @33  {
2edbfbf1c1ab0a Al Viro                 2013-09-15  34  	struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
5556e7e6d30e8e Tyler Hicks             2015-08-05  35  	int rc = 1;
237fead619984c Michael Halcrow         2006-10-04  36  
0b728e1911cbe6 Al Viro                 2012-06-10  37  	if (flags & LOOKUP_RCU)
34286d6662308d Nicholas Piggin         2011-01-07  38  		return -ECHILD;
34286d6662308d Nicholas Piggin         2011-01-07  39  
5556e7e6d30e8e Tyler Hicks             2015-08-05  40  	if (lower_dentry->d_flags & DCACHE_OP_REVALIDATE)
0838ae103beaf6 Gabriel Krisman Bertazi 2023-08-11  41  		rc = lower_dentry->d_op->d_revalidate(lower_dentry, name, flags);
5556e7e6d30e8e Tyler Hicks             2015-08-05  42  
2b0143b5c986be David Howells           2015-03-17  43  	if (d_really_is_positive(dentry)) {
5556e7e6d30e8e Tyler Hicks             2015-08-05  44  		struct inode *inode = d_inode(dentry);
ae56fb16337c88 Michael Halcrow         2006-11-16  45  
5556e7e6d30e8e Tyler Hicks             2015-08-05  46  		fsstack_copy_attr_all(inode, ecryptfs_inode_to_lower(inode));
5556e7e6d30e8e Tyler Hicks             2015-08-05  47  		if (!inode->i_nlink)
5556e7e6d30e8e Tyler Hicks             2015-08-05  48  			return 0;
ae56fb16337c88 Michael Halcrow         2006-11-16  49  	}
237fead619984c Michael Halcrow         2006-10-04  50  	return rc;
237fead619984c Michael Halcrow         2006-10-04  51  }
237fead619984c Michael Halcrow         2006-10-04  52  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
