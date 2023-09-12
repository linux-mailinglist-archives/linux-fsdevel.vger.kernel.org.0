Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361E79C163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjILA6W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 20:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjILA6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 20:58:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E1144EB4;
        Mon, 11 Sep 2023 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694479762; x=1726015762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oLzf0xFFu11Gps4vsJbzS9rWCswHgzXvG1WtldyxkjU=;
  b=P6TvxlYMLGuF9M7f123yoNr6B3yQstBodA/ica6TRNKo7TlErUbntqUc
   kJWNG3FchCYwcqjBLCkEnz7Dbta51IuKRwgIWrxUaxavrekftER3X6cZ9
   eslFJh52M8f2Sh0ZyG5VszY7y7uzrBOcY/j5E+SoBnRMhMRlmRdBWjmo8
   JyA44iXezZWFHA+N3eGGIdmw1f9WcTc4p7/l9qjcSY6folRZysCN0aofF
   OylTnVYBdEFpyph1DxoGXf2xFbtotlyzK8roEhYZ0mxb+Xp4Tp2HzV2gP
   fJKtQNbn4kr9/Sqkp9XZbW4ECe1G3Y6Rj32URIpLnC0XSPPLhvGEhGVEo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="380945743"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="380945743"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 17:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867153834"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="867153834"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 Sep 2023 17:47:01 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfrYR-0006zu-1p;
        Tue, 12 Sep 2023 00:46:59 +0000
Date:   Tue, 12 Sep 2023 08:46:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 1/2] fuse: revalidate: move lookup into a separate
 function
Message-ID: <202309120853.QbAMM1to-lkp@intel.com>
References: <9a2b0c5b625cd88c561289bf7d4d7dfe305c10ed.1693440240.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a2b0c5b625cd88c561289bf7d4d7dfe305c10ed.1693440240.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Krister,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc1 next-20230911]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krister-Johansen/fuse-revalidate-move-lookup-into-a-separate-function/20230912-051352
base:   linus/master
patch link:    https://lore.kernel.org/r/9a2b0c5b625cd88c561289bf7d4d7dfe305c10ed.1693440240.git.kjlx%40templeofstupid.com
patch subject: [PATCH 1/2] fuse: revalidate: move lookup into a separate function
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230912/202309120853.QbAMM1to-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230912/202309120853.QbAMM1to-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309120853.QbAMM1to-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/dir.c: In function 'fuse_dentry_revalidate_lookup':
>> fs/fuse/dir.c:194:28: warning: variable 'fi' set but not used [-Wunused-but-set-variable]
     194 |         struct fuse_inode *fi;
         |                            ^~


vim +/fi +194 fs/fuse/dir.c

   185	
   186	static int fuse_dentry_revalidate_lookup(struct fuse_mount *fm,
   187						 struct dentry *entry,
   188						 struct inode *inode,
   189						 struct fuse_entry_out *outarg,
   190						 bool *lookedup)
   191	{
   192		struct dentry *parent;
   193		struct fuse_forget_link *forget;
 > 194		struct fuse_inode *fi;
   195		FUSE_ARGS(args);
   196		int ret;
   197	
   198		forget = fuse_alloc_forget();
   199		ret = -ENOMEM;
   200		if (!forget)
   201			goto out;
   202	
   203		parent = dget_parent(entry);
   204		fuse_lookup_init(fm->fc, &args, get_node_id(d_inode(parent)),
   205				 &entry->d_name, outarg);
   206		ret = fuse_simple_request(fm, &args);
   207		dput(parent);
   208	
   209		/* Zero nodeid is same as -ENOENT */
   210		if (!ret && !outarg->nodeid)
   211			ret = -ENOENT;
   212		if (!ret) {
   213			fi = get_fuse_inode(inode);
   214			if (outarg->nodeid != get_node_id(inode) ||
   215			    (bool) IS_AUTOMOUNT(inode) != (bool) (outarg->attr.flags & FUSE_ATTR_SUBMOUNT)) {
   216				fuse_queue_forget(fm->fc, forget,
   217						  outarg->nodeid, 1);
   218				goto invalid;
   219			}
   220			*lookedup = true;
   221		}
   222		kfree(forget);
   223		if (ret == -ENOMEM || ret == -EINTR)
   224			goto out;
   225		if (ret || fuse_invalid_attr(&outarg->attr) ||
   226		    fuse_stale_inode(inode, outarg->generation, &outarg->attr)) {
   227			goto invalid;
   228		}
   229	
   230		ret = 1;
   231	out:
   232		return ret;
   233	
   234	invalid:
   235		ret = 0;
   236		goto out;
   237	}
   238	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
