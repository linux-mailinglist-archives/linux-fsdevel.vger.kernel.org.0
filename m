Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6550567F9C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjA1RO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjA1ROz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:14:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F92D5599
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674926087; x=1706462087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6tTRMsYGt6H6KUiFaird/wqszdo9PWRL7bOVgLw4bH8=;
  b=LGEhpOqUdz/s/9EXFFmD/rau1lw5gE0YQTSCq3n7lPELlH4cLyCBPZsX
   Q0wAB5qBl/p2MGQ3WdRmx4a7aQILMalZIF6199JGlFvwgzkQZTQYJXrAP
   0ZULW9G2EGWODmuWtogQLjxo2+ZgY2PNVD+h+gTsc2QAMi56VVfPoiTSg
   4sTK2zLSlNWoIrpyrlZlzGS7to3siabLaQNHacmA2GbesU1bESWK4beAJ
   vn1z4v+VVbfE13WuIxuPVcxRxjk0JJ5oBIyyvhbPsXlfVclZXLxl1Iz1n
   BInk0uEjiQsZzZga6Xc7ngdaVB45NGkkLDX38YjYNQCTJ+oKeg6pUR+rU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="310932505"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="310932505"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 09:14:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="732208707"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="732208707"
Received: from lkp-server01.sh.intel.com (HELO ffa7f14d1d0f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jan 2023 09:14:44 -0800
Received: from kbuild by ffa7f14d1d0f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pLomp-0000wP-35;
        Sat, 28 Jan 2023 17:14:43 +0000
Date:   Sun, 29 Jan 2023 01:13:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: Convert writepage_t callback to pass a folio
Message-ID: <202301290130.frg9YGk5-lkp@intel.com>
References: <20230126201255.1681189-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126201255.1681189-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20230125]
[cannot apply to tytso-ext4/dev akpm-mm/mm-everything cifs/for-next mszeredi-fuse/for-next xfs-linux/for-next trondmy-nfs/linux-next hubcap/for-next linus/master v6.2-rc5 v6.2-rc4 v6.2-rc3 v6.2-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Convert-writepage_t-callback-to-pass-a-folio/20230128-112951
patch link:    https://lore.kernel.org/r/20230126201255.1681189-2-willy%40infradead.org
patch subject: [PATCH 1/2] fs: Convert writepage_t callback to pass a folio
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230129/202301290130.frg9YGk5-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/19e834de445f5d3a390fff94320e71e8077ce632
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/fs-Convert-writepage_t-callback-to-pass-a-folio/20230128-112951
        git checkout 19e834de445f5d3a390fff94320e71e8077ce632
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash fs/gfs2/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/gfs2/log.c: In function 'gfs2_ail1_start_one':
>> fs/gfs2/log.c:143:55: error: passing argument 3 of 'write_cache_pages' from incompatible pointer type [-Werror=incompatible-pointer-types]
     143 |                 ret = write_cache_pages(mapping, wbc, __gfs2_writepage, mapping);
         |                                                       ^~~~~~~~~~~~~~~~
         |                                                       |
         |                                                       int (*)(struct page *, struct writeback_control *, void *)
   In file included from fs/gfs2/log.c:20:
   include/linux/writeback.h:375:66: note: expected 'writepage_t' {aka 'int (*)(struct folio *, struct writeback_control *, void *)'} but argument is of type 'int (*)(struct page *, struct writeback_control *, void *)'
     375 |                       struct writeback_control *wbc, writepage_t writepage,
         |                                                      ~~~~~~~~~~~~^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/write_cache_pages +143 fs/gfs2/log.c

95ecbd0f162fc0 Andreas Gruenbacher     2023-01-19   91  
ddacfaf76dd620 Steven Whitehouse       2006-10-03   92  /**
c551f66c5dfefd Lee Jones               2021-03-30   93   * gfs2_ail1_start_one - Start I/O on a transaction
c551f66c5dfefd Lee Jones               2021-03-30   94   * @sdp: The superblock
4667a0ec328678 Steven Whitehouse       2011-04-18   95   * @wbc: The writeback control structure
c551f66c5dfefd Lee Jones               2021-03-30   96   * @tr: The transaction to start I/O on
c551f66c5dfefd Lee Jones               2021-03-30   97   * @plug: The block plug currently active
ddacfaf76dd620 Steven Whitehouse       2006-10-03   98   */
ddacfaf76dd620 Steven Whitehouse       2006-10-03   99  
4f1de018215fb5 Steven Whitehouse       2011-04-26  100  static int gfs2_ail1_start_one(struct gfs2_sbd *sdp,
4667a0ec328678 Steven Whitehouse       2011-04-18  101  			       struct writeback_control *wbc,
17d77684088510 Bob Peterson            2021-02-18  102  			       struct gfs2_trans *tr, struct blk_plug *plug)
d6a079e82efd5f Dave Chinner            2011-03-11  103  __releases(&sdp->sd_ail_lock)
d6a079e82efd5f Dave Chinner            2011-03-11  104  __acquires(&sdp->sd_ail_lock)
ddacfaf76dd620 Steven Whitehouse       2006-10-03  105  {
5ac048bb7ea6e8 Steven Whitehouse       2011-03-30  106  	struct gfs2_glock *gl = NULL;
4667a0ec328678 Steven Whitehouse       2011-04-18  107  	struct address_space *mapping;
ddacfaf76dd620 Steven Whitehouse       2006-10-03  108  	struct gfs2_bufdata *bd, *s;
ddacfaf76dd620 Steven Whitehouse       2006-10-03  109  	struct buffer_head *bh;
b1676cbb11153b Bob Peterson            2019-11-13  110  	int ret = 0;
ddacfaf76dd620 Steven Whitehouse       2006-10-03  111  
16ca9412d80181 Benjamin Marzinski      2013-04-05  112  	list_for_each_entry_safe_reverse(bd, s, &tr->tr_ail1_list, bd_ail_st_list) {
ddacfaf76dd620 Steven Whitehouse       2006-10-03  113  		bh = bd->bd_bh;
ddacfaf76dd620 Steven Whitehouse       2006-10-03  114  
16ca9412d80181 Benjamin Marzinski      2013-04-05  115  		gfs2_assert(sdp, bd->bd_tr == tr);
ddacfaf76dd620 Steven Whitehouse       2006-10-03  116  
ddacfaf76dd620 Steven Whitehouse       2006-10-03  117  		if (!buffer_busy(bh)) {
30fe70a85a909a Bob Peterson            2019-11-13  118  			if (buffer_uptodate(bh)) {
30fe70a85a909a Bob Peterson            2019-11-13  119  				list_move(&bd->bd_ail_st_list,
30fe70a85a909a Bob Peterson            2019-11-13  120  					  &tr->tr_ail2_list);
30fe70a85a909a Bob Peterson            2019-11-13  121  				continue;
30fe70a85a909a Bob Peterson            2019-11-13  122  			}
036330c914365f Bob Peterson            2019-04-10  123  			if (!cmpxchg(&sdp->sd_log_error, 0, -EIO)) {
ddacfaf76dd620 Steven Whitehouse       2006-10-03  124  				gfs2_io_error_bh(sdp, bh);
69511080bd6efd Bob Peterson            2019-02-12  125  				gfs2_withdraw_delayed(sdp);
9e1a9ecd13b9bb Andreas Gruenbacher     2018-06-07  126  			}
ddacfaf76dd620 Steven Whitehouse       2006-10-03  127  		}
ddacfaf76dd620 Steven Whitehouse       2006-10-03  128  
30fe70a85a909a Bob Peterson            2019-11-13  129  		if (gfs2_withdrawn(sdp)) {
30fe70a85a909a Bob Peterson            2019-11-13  130  			gfs2_remove_from_ail(bd);
30fe70a85a909a Bob Peterson            2019-11-13  131  			continue;
30fe70a85a909a Bob Peterson            2019-11-13  132  		}
ddacfaf76dd620 Steven Whitehouse       2006-10-03  133  		if (!buffer_dirty(bh))
ddacfaf76dd620 Steven Whitehouse       2006-10-03  134  			continue;
5ac048bb7ea6e8 Steven Whitehouse       2011-03-30  135  		if (gl == bd->bd_gl)
5ac048bb7ea6e8 Steven Whitehouse       2011-03-30  136  			continue;
5ac048bb7ea6e8 Steven Whitehouse       2011-03-30  137  		gl = bd->bd_gl;
16ca9412d80181 Benjamin Marzinski      2013-04-05  138  		list_move(&bd->bd_ail_st_list, &tr->tr_ail1_list);
11551cf15ecc17 Matthew Wilcox (Oracle  2022-12-15  139) 		mapping = bh->b_folio->mapping;
4f1de018215fb5 Steven Whitehouse       2011-04-26  140  		if (!mapping)
4f1de018215fb5 Steven Whitehouse       2011-04-26  141  			continue;
d6a079e82efd5f Dave Chinner            2011-03-11  142  		spin_unlock(&sdp->sd_ail_lock);
95ecbd0f162fc0 Andreas Gruenbacher     2023-01-19 @143  		ret = write_cache_pages(mapping, wbc, __gfs2_writepage, mapping);
17d77684088510 Bob Peterson            2021-02-18  144  		if (need_resched()) {
17d77684088510 Bob Peterson            2021-02-18  145  			blk_finish_plug(plug);
17d77684088510 Bob Peterson            2021-02-18  146  			cond_resched();
17d77684088510 Bob Peterson            2021-02-18  147  			blk_start_plug(plug);
17d77684088510 Bob Peterson            2021-02-18  148  		}
d6a079e82efd5f Dave Chinner            2011-03-11  149  		spin_lock(&sdp->sd_ail_lock);
4e79e3f08e576a Bob Peterson            2020-11-12  150  		if (ret == -ENODATA) /* if a jdata write into a new hole */
4e79e3f08e576a Bob Peterson            2020-11-12  151  			ret = 0; /* ignore it */
b1676cbb11153b Bob Peterson            2019-11-13  152  		if (ret || wbc->nr_to_write <= 0)
4667a0ec328678 Steven Whitehouse       2011-04-18  153  			break;
b1676cbb11153b Bob Peterson            2019-11-13  154  		return -EBUSY;
4667a0ec328678 Steven Whitehouse       2011-04-18  155  	}
4f1de018215fb5 Steven Whitehouse       2011-04-26  156  
b1676cbb11153b Bob Peterson            2019-11-13  157  	return ret;
4667a0ec328678 Steven Whitehouse       2011-04-18  158  }
ddacfaf76dd620 Steven Whitehouse       2006-10-03  159  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
