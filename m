Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF034594EE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 05:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiHPDB6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiHPDAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:00:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790E2DD5ED;
        Mon, 15 Aug 2022 16:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660606485; x=1692142485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EU3WVIPEiTVCLq3r1ATnkbH8mOj++2Yt6SGbSryJ5r0=;
  b=MdhohSoUqeuVP1wJ3W+x3DA0fk22RTfQ/qOlaj/cd/d724w8nmAhteeA
   lrVwtVkytJOyPqGYMipBWefLIt/aGEPOSzcf+7C2Ad5XCyvN6UbipU39j
   wFd6Dey8rB1F0pRilan1H3HyeX6wLsAMWLV6tsJusgOhkkfuA73kaa96h
   7WcANTc0ClGwB7iU/xK9FPeLDXtzgEo7NOurOOwZOalTTSXaKMx69b3z5
   v2FWgbps1ClXKxeRvIAWMtt3PdMUPz1cuYu8/aScTb868xa+EYZkWoVs4
   B7ycmxJGf1alvk1RTp8rPiO2y94dt04a9a/aVLGmEGKwBhn8QBiA8C35c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="289650012"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="289650012"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 16:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="583073534"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 16:34:41 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNjbU-0001Gv-1b;
        Mon, 15 Aug 2022 23:34:40 +0000
Date:   Tue, 16 Aug 2022 07:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-btrfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to
 use filemap_get_folios_contig()
Message-ID: <202208160738.yErltyXd-lkp@intel.com>
References: <20220815185452.37447-6-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815185452.37447-6-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Vishal,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc1 next-20220815]
[cannot apply to kdave/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_contig/20220816-025830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220816/202208160738.yErltyXd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/ce1966344933bbe10010035cd25f23ec7dd76914
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/Convert-to-filemap_get_folios_contig/20220816-025830
        git checkout ce1966344933bbe10010035cd25f23ec7dd76914
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nilfs2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nilfs2/page.c: In function 'nilfs_find_uncommitted_extent':
>> fs/nilfs2/page.c:542:1: warning: label 'out' defined but not used [-Wunused-label]
     542 | out:
         | ^~~


vim +/out +542 fs/nilfs2/page.c

622daaff0a8975 Ryusuke Konishi       2010-12-26  466  
622daaff0a8975 Ryusuke Konishi       2010-12-26  467  /**
622daaff0a8975 Ryusuke Konishi       2010-12-26  468   * nilfs_find_uncommitted_extent - find extent of uncommitted data
622daaff0a8975 Ryusuke Konishi       2010-12-26  469   * @inode: inode
622daaff0a8975 Ryusuke Konishi       2010-12-26  470   * @start_blk: start block offset (in)
622daaff0a8975 Ryusuke Konishi       2010-12-26  471   * @blkoff: start offset of the found extent (out)
622daaff0a8975 Ryusuke Konishi       2010-12-26  472   *
622daaff0a8975 Ryusuke Konishi       2010-12-26  473   * This function searches an extent of buffers marked "delayed" which
622daaff0a8975 Ryusuke Konishi       2010-12-26  474   * starts from a block offset equal to or larger than @start_blk.  If
622daaff0a8975 Ryusuke Konishi       2010-12-26  475   * such an extent was found, this will store the start offset in
622daaff0a8975 Ryusuke Konishi       2010-12-26  476   * @blkoff and return its length in blocks.  Otherwise, zero is
622daaff0a8975 Ryusuke Konishi       2010-12-26  477   * returned.
622daaff0a8975 Ryusuke Konishi       2010-12-26  478   */
622daaff0a8975 Ryusuke Konishi       2010-12-26  479  unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
622daaff0a8975 Ryusuke Konishi       2010-12-26  480  					    sector_t start_blk,
622daaff0a8975 Ryusuke Konishi       2010-12-26  481  					    sector_t *blkoff)
622daaff0a8975 Ryusuke Konishi       2010-12-26  482  {
ce1966344933bb Vishal Moola (Oracle  2022-08-15  483) 	unsigned int i, nr;
622daaff0a8975 Ryusuke Konishi       2010-12-26  484  	pgoff_t index;
622daaff0a8975 Ryusuke Konishi       2010-12-26  485  	unsigned int nblocks_in_page;
622daaff0a8975 Ryusuke Konishi       2010-12-26  486  	unsigned long length = 0;
622daaff0a8975 Ryusuke Konishi       2010-12-26  487  	sector_t b;
ce1966344933bb Vishal Moola (Oracle  2022-08-15  488) 	struct folio_batch fbatch;
ce1966344933bb Vishal Moola (Oracle  2022-08-15  489) 	struct folio *folio;
622daaff0a8975 Ryusuke Konishi       2010-12-26  490  
622daaff0a8975 Ryusuke Konishi       2010-12-26  491  	if (inode->i_mapping->nrpages == 0)
622daaff0a8975 Ryusuke Konishi       2010-12-26  492  		return 0;
622daaff0a8975 Ryusuke Konishi       2010-12-26  493  
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  494  	index = start_blk >> (PAGE_SHIFT - inode->i_blkbits);
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  495  	nblocks_in_page = 1U << (PAGE_SHIFT - inode->i_blkbits);
622daaff0a8975 Ryusuke Konishi       2010-12-26  496  
ce1966344933bb Vishal Moola (Oracle  2022-08-15  497) 	folio_batch_init(&fbatch);
622daaff0a8975 Ryusuke Konishi       2010-12-26  498  
622daaff0a8975 Ryusuke Konishi       2010-12-26  499  repeat:
ce1966344933bb Vishal Moola (Oracle  2022-08-15  500) 	nr = filemap_get_folios_contig(inode->i_mapping, &index, ULONG_MAX,
ce1966344933bb Vishal Moola (Oracle  2022-08-15  501) 			&fbatch);
ce1966344933bb Vishal Moola (Oracle  2022-08-15  502) 	if (nr == 0)
622daaff0a8975 Ryusuke Konishi       2010-12-26  503  		return length;
622daaff0a8975 Ryusuke Konishi       2010-12-26  504  
ce1966344933bb Vishal Moola (Oracle  2022-08-15  505) 	b = fbatch.folios[0]->index << (PAGE_SHIFT - inode->i_blkbits);
622daaff0a8975 Ryusuke Konishi       2010-12-26  506  	i = 0;
622daaff0a8975 Ryusuke Konishi       2010-12-26  507  	do {
ce1966344933bb Vishal Moola (Oracle  2022-08-15  508) 		folio = fbatch.folios[i];
622daaff0a8975 Ryusuke Konishi       2010-12-26  509  
ce1966344933bb Vishal Moola (Oracle  2022-08-15  510) 		folio_lock(folio);
ce1966344933bb Vishal Moola (Oracle  2022-08-15  511) 		if (folio_buffers(folio)) {
622daaff0a8975 Ryusuke Konishi       2010-12-26  512  			struct buffer_head *bh, *head;
622daaff0a8975 Ryusuke Konishi       2010-12-26  513  
ce1966344933bb Vishal Moola (Oracle  2022-08-15  514) 			bh = head = folio_buffers(folio);
622daaff0a8975 Ryusuke Konishi       2010-12-26  515  			do {
622daaff0a8975 Ryusuke Konishi       2010-12-26  516  				if (b < start_blk)
622daaff0a8975 Ryusuke Konishi       2010-12-26  517  					continue;
622daaff0a8975 Ryusuke Konishi       2010-12-26  518  				if (buffer_delay(bh)) {
622daaff0a8975 Ryusuke Konishi       2010-12-26  519  					if (length == 0)
622daaff0a8975 Ryusuke Konishi       2010-12-26  520  						*blkoff = b;
622daaff0a8975 Ryusuke Konishi       2010-12-26  521  					length++;
622daaff0a8975 Ryusuke Konishi       2010-12-26  522  				} else if (length > 0) {
622daaff0a8975 Ryusuke Konishi       2010-12-26  523  					goto out_locked;
622daaff0a8975 Ryusuke Konishi       2010-12-26  524  				}
622daaff0a8975 Ryusuke Konishi       2010-12-26  525  			} while (++b, bh = bh->b_this_page, bh != head);
622daaff0a8975 Ryusuke Konishi       2010-12-26  526  		} else {
622daaff0a8975 Ryusuke Konishi       2010-12-26  527  			if (length > 0)
622daaff0a8975 Ryusuke Konishi       2010-12-26  528  				goto out_locked;
622daaff0a8975 Ryusuke Konishi       2010-12-26  529  
622daaff0a8975 Ryusuke Konishi       2010-12-26  530  			b += nblocks_in_page;
622daaff0a8975 Ryusuke Konishi       2010-12-26  531  		}
ce1966344933bb Vishal Moola (Oracle  2022-08-15  532) 		folio_unlock(folio);
622daaff0a8975 Ryusuke Konishi       2010-12-26  533  
ce1966344933bb Vishal Moola (Oracle  2022-08-15  534) 	} while (++i < nr);
622daaff0a8975 Ryusuke Konishi       2010-12-26  535  
ce1966344933bb Vishal Moola (Oracle  2022-08-15  536) 	folio_batch_release(&fbatch);
622daaff0a8975 Ryusuke Konishi       2010-12-26  537  	cond_resched();
622daaff0a8975 Ryusuke Konishi       2010-12-26  538  	goto repeat;
622daaff0a8975 Ryusuke Konishi       2010-12-26  539  
622daaff0a8975 Ryusuke Konishi       2010-12-26  540  out_locked:
ce1966344933bb Vishal Moola (Oracle  2022-08-15  541) 	folio_unlock(folio);
622daaff0a8975 Ryusuke Konishi       2010-12-26 @542  out:

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
