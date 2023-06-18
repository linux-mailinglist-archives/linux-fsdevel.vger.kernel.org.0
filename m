Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF4734955
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 01:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFRXf5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 19:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRXf4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 19:35:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D783E44;
        Sun, 18 Jun 2023 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687131354; x=1718667354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VofrOuJxE/Vk0udrmnYtndlTeRd31idF1sSeKN8z/5Q=;
  b=L3YZXsuGL+tq7nA6pFCe6TBSoKpXEGfrNOa5dgR8HkNikUcNmMXiGHTj
   i7a1sa+GokRVzr0HnYtiS3OA/IclUnuO+9/+/JDFJHH5ehduduuygxeUu
   Y+bg1OxSDCBIVZHD76OMoMDmkUKXy67AT9OWfMEs6VbddQCTedd3sFI6I
   OPDIQHRKpKXEnSmVjFVZR6e8uEAtaMqsRJPlBQn+aNNOrgSPLzfec+tih
   r60cmOQJHNzGyaJjQhewKOXaKl7yczP3QRjqVBXg/pC4HJ2+GIzS+m8+8
   9WX7P7Euk0V8VJ7HkjphwsYMPDQVDiIpW3SJRBTX7SPC5Gngqu98W2S9y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="445896149"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="445896149"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 16:35:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="887734980"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="887734980"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2023 16:35:48 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qB1vw-00048M-0j;
        Sun, 18 Jun 2023 23:35:48 +0000
Date:   Mon, 19 Jun 2023 07:35:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bean Huo <beanhuo@iokpp.de>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, akpm@linux-foundation.org, jack@suse.cz,
        jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, beanhuo@micron.com
Subject: Re: [PATCH v1 2/5] fs/buffer.c: convert block_commit_write to return
 void
Message-ID: <202306190729.oETrBjGU-lkp@intel.com>
References: <20230618213250.694110-3-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618213250.694110-3-beanhuo@iokpp.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Bean,

kernel test robot noticed the following build errors:

[auto build test ERROR on tytso-ext4/dev]
[also build test ERROR on vfs-idmapping/for-next linus/master v6.4-rc6]
[cannot apply to akpm-mm/mm-everything next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bean-Huo/fs-buffer-clean-up-block_commit_write/20230619-053759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20230618213250.694110-3-beanhuo%40iokpp.de
patch subject: [PATCH v1 2/5] fs/buffer.c: convert block_commit_write to return void
config: i386-defconfig (https://download.01.org/0day-ci/archive/20230619/202306190729.oETrBjGU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306190729.oETrBjGU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306190729.oETrBjGU-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ext4/move_extent.c: In function 'move_extent_per_page':
>> fs/ext4/move_extent.c:399:22: error: void value not ignored as it ought to be
     399 |                 *err = block_commit_write(&folio[0]->page, from, from + replaced_size);
         |                      ^


vim +399 fs/ext4/move_extent.c

bb5574880574fe Dmitry Monakhov       2012-09-26  234  
748de6736c1e48 Akira Fujita          2009-06-17  235  /**
748de6736c1e48 Akira Fujita          2009-06-17  236   * move_extent_per_page - Move extent data per page
748de6736c1e48 Akira Fujita          2009-06-17  237   *
748de6736c1e48 Akira Fujita          2009-06-17  238   * @o_filp:			file structure of original file
748de6736c1e48 Akira Fujita          2009-06-17  239   * @donor_inode:		donor inode
748de6736c1e48 Akira Fujita          2009-06-17  240   * @orig_page_offset:		page index on original file
65dd8327eb055a Xiaoguang Wang        2014-10-11  241   * @donor_page_offset:		page index on donor file
748de6736c1e48 Akira Fujita          2009-06-17  242   * @data_offset_in_page:	block index where data swapping starts
748de6736c1e48 Akira Fujita          2009-06-17  243   * @block_len_in_page:		the number of blocks to be swapped
556615dcbf38b0 Lukas Czerner         2014-04-20  244   * @unwritten:			orig extent is unwritten or not
f868a48d06f888 Akira Fujita          2009-11-23  245   * @err:			pointer to save return value
748de6736c1e48 Akira Fujita          2009-06-17  246   *
748de6736c1e48 Akira Fujita          2009-06-17  247   * Save the data in original inode blocks and replace original inode extents
65dd8327eb055a Xiaoguang Wang        2014-10-11  248   * with donor inode extents by calling ext4_swap_extents().
f868a48d06f888 Akira Fujita          2009-11-23  249   * Finally, write out the saved data in new original inode blocks. Return
f868a48d06f888 Akira Fujita          2009-11-23  250   * replaced block count.
748de6736c1e48 Akira Fujita          2009-06-17  251   */
748de6736c1e48 Akira Fujita          2009-06-17  252  static int
44fc48f7048ab9 Akira Fujita          2009-09-05  253  move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  254  		     pgoff_t orig_page_offset, pgoff_t donor_page_offset,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  255  		     int data_offset_in_page,
556615dcbf38b0 Lukas Czerner         2014-04-20  256  		     int block_len_in_page, int unwritten, int *err)
748de6736c1e48 Akira Fujita          2009-06-17  257  {
496ad9aa8ef448 Al Viro               2013-01-23  258  	struct inode *orig_inode = file_inode(o_filp);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  259) 	struct folio *folio[2] = {NULL, NULL};
748de6736c1e48 Akira Fujita          2009-06-17  260  	handle_t *handle;
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  261  	ext4_lblk_t orig_blk_offset, donor_blk_offset;
748de6736c1e48 Akira Fujita          2009-06-17  262  	unsigned long blocksize = orig_inode->i_sb->s_blocksize;
f868a48d06f888 Akira Fujita          2009-11-23  263  	unsigned int tmp_data_size, data_size, replaced_size;
bcff24887d00bc Eryu Guan             2016-02-12  264  	int i, err2, jblocks, retries = 0;
f868a48d06f888 Akira Fujita          2009-11-23  265  	int replaced_count = 0;
bb5574880574fe Dmitry Monakhov       2012-09-26  266  	int from = data_offset_in_page << orig_inode->i_blkbits;
09cbfeaf1a5a67 Kirill A. Shutemov    2016-04-01  267  	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
88c6b61ff1cfb4 Dmitry Monakhov       2014-11-05  268  	struct super_block *sb = orig_inode->i_sb;
bcff24887d00bc Eryu Guan             2016-02-12  269  	struct buffer_head *bh = NULL;
748de6736c1e48 Akira Fujita          2009-06-17  270  
748de6736c1e48 Akira Fujita          2009-06-17  271  	/*
748de6736c1e48 Akira Fujita          2009-06-17  272  	 * It needs twice the amount of ordinary journal buffers because
748de6736c1e48 Akira Fujita          2009-06-17  273  	 * inode and donor_inode may change each different metadata blocks.
748de6736c1e48 Akira Fujita          2009-06-17  274  	 */
bb5574880574fe Dmitry Monakhov       2012-09-26  275  again:
bb5574880574fe Dmitry Monakhov       2012-09-26  276  	*err = 0;
748de6736c1e48 Akira Fujita          2009-06-17  277  	jblocks = ext4_writepage_trans_blocks(orig_inode) * 2;
9924a92a8c2175 Theodore Ts'o         2013-02-08  278  	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, jblocks);
748de6736c1e48 Akira Fujita          2009-06-17  279  	if (IS_ERR(handle)) {
f868a48d06f888 Akira Fujita          2009-11-23  280  		*err = PTR_ERR(handle);
f868a48d06f888 Akira Fujita          2009-11-23  281  		return 0;
748de6736c1e48 Akira Fujita          2009-06-17  282  	}
748de6736c1e48 Akira Fujita          2009-06-17  283  
748de6736c1e48 Akira Fujita          2009-06-17  284  	orig_blk_offset = orig_page_offset * blocks_per_page +
748de6736c1e48 Akira Fujita          2009-06-17  285  		data_offset_in_page;
748de6736c1e48 Akira Fujita          2009-06-17  286  
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  287  	donor_blk_offset = donor_page_offset * blocks_per_page +
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  288  		data_offset_in_page;
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  289  
f868a48d06f888 Akira Fujita          2009-11-23  290  	/* Calculate data_size */
748de6736c1e48 Akira Fujita          2009-06-17  291  	if ((orig_blk_offset + block_len_in_page - 1) ==
748de6736c1e48 Akira Fujita          2009-06-17  292  	    ((orig_inode->i_size - 1) >> orig_inode->i_blkbits)) {
748de6736c1e48 Akira Fujita          2009-06-17  293  		/* Replace the last block */
f868a48d06f888 Akira Fujita          2009-11-23  294  		tmp_data_size = orig_inode->i_size & (blocksize - 1);
748de6736c1e48 Akira Fujita          2009-06-17  295  		/*
f868a48d06f888 Akira Fujita          2009-11-23  296  		 * If data_size equal zero, it shows data_size is multiples of
748de6736c1e48 Akira Fujita          2009-06-17  297  		 * blocksize. So we set appropriate value.
748de6736c1e48 Akira Fujita          2009-06-17  298  		 */
f868a48d06f888 Akira Fujita          2009-11-23  299  		if (tmp_data_size == 0)
f868a48d06f888 Akira Fujita          2009-11-23  300  			tmp_data_size = blocksize;
748de6736c1e48 Akira Fujita          2009-06-17  301  
f868a48d06f888 Akira Fujita          2009-11-23  302  		data_size = tmp_data_size +
748de6736c1e48 Akira Fujita          2009-06-17  303  			((block_len_in_page - 1) << orig_inode->i_blkbits);
f868a48d06f888 Akira Fujita          2009-11-23  304  	} else
f868a48d06f888 Akira Fujita          2009-11-23  305  		data_size = block_len_in_page << orig_inode->i_blkbits;
f868a48d06f888 Akira Fujita          2009-11-23  306  
f868a48d06f888 Akira Fujita          2009-11-23  307  	replaced_size = data_size;
748de6736c1e48 Akira Fujita          2009-06-17  308  
e8dfc854eef20a Vishal Moola (Oracle  2022-12-07  309) 	*err = mext_folio_double_lock(orig_inode, donor_inode, orig_page_offset,
e8dfc854eef20a Vishal Moola (Oracle  2022-12-07  310) 				     donor_page_offset, folio);
f868a48d06f888 Akira Fujita          2009-11-23  311  	if (unlikely(*err < 0))
bb5574880574fe Dmitry Monakhov       2012-09-26  312  		goto stop_journal;
8c854473917354 Dmitry Monakhov       2012-09-26  313  	/*
556615dcbf38b0 Lukas Czerner         2014-04-20  314  	 * If orig extent was unwritten it can become initialized
8c854473917354 Dmitry Monakhov       2012-09-26  315  	 * at any time after i_data_sem was dropped, in order to
8c854473917354 Dmitry Monakhov       2012-09-26  316  	 * serialize with delalloc we have recheck extent while we
8c854473917354 Dmitry Monakhov       2012-09-26  317  	 * hold page's lock, if it is still the case data copy is not
8c854473917354 Dmitry Monakhov       2012-09-26  318  	 * necessary, just swap data blocks between orig and donor.
8c854473917354 Dmitry Monakhov       2012-09-26  319  	 */
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  320) 
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  321) 	VM_BUG_ON_FOLIO(folio_test_large(folio[0]), folio[0]);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  322) 	VM_BUG_ON_FOLIO(folio_test_large(folio[1]), folio[1]);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  323) 	VM_BUG_ON_FOLIO(folio_nr_pages(folio[0]) != folio_nr_pages(folio[1]), folio[1]);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  324) 
556615dcbf38b0 Lukas Czerner         2014-04-20  325  	if (unwritten) {
393d1d1d769338 Dr. Tilmann Bubeck    2013-04-08  326  		ext4_double_down_write_data_sem(orig_inode, donor_inode);
8c854473917354 Dmitry Monakhov       2012-09-26  327  		/* If any of extents in range became initialized we have to
8c854473917354 Dmitry Monakhov       2012-09-26  328  		 * fallback to data copying */
556615dcbf38b0 Lukas Czerner         2014-04-20  329  		unwritten = mext_check_coverage(orig_inode, orig_blk_offset,
8c854473917354 Dmitry Monakhov       2012-09-26  330  						block_len_in_page, 1, err);
8c854473917354 Dmitry Monakhov       2012-09-26  331  		if (*err)
8c854473917354 Dmitry Monakhov       2012-09-26  332  			goto drop_data_sem;
8c854473917354 Dmitry Monakhov       2012-09-26  333  
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  334  		unwritten &= mext_check_coverage(donor_inode, donor_blk_offset,
8c854473917354 Dmitry Monakhov       2012-09-26  335  						 block_len_in_page, 1, err);
8c854473917354 Dmitry Monakhov       2012-09-26  336  		if (*err)
8c854473917354 Dmitry Monakhov       2012-09-26  337  			goto drop_data_sem;
748de6736c1e48 Akira Fujita          2009-06-17  338  
556615dcbf38b0 Lukas Czerner         2014-04-20  339  		if (!unwritten) {
393d1d1d769338 Dr. Tilmann Bubeck    2013-04-08  340  			ext4_double_up_write_data_sem(orig_inode, donor_inode);
8c854473917354 Dmitry Monakhov       2012-09-26  341  			goto data_copy;
8c854473917354 Dmitry Monakhov       2012-09-26  342  		}
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  343) 		if ((folio_has_private(folio[0]) &&
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  344) 		     !filemap_release_folio(folio[0], 0)) ||
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  345) 		    (folio_has_private(folio[1]) &&
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  346) 		     !filemap_release_folio(folio[1], 0))) {
8c854473917354 Dmitry Monakhov       2012-09-26  347  			*err = -EBUSY;
8c854473917354 Dmitry Monakhov       2012-09-26  348  			goto drop_data_sem;
8c854473917354 Dmitry Monakhov       2012-09-26  349  		}
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  350  		replaced_count = ext4_swap_extents(handle, orig_inode,
8c854473917354 Dmitry Monakhov       2012-09-26  351  						   donor_inode, orig_blk_offset,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  352  						   donor_blk_offset,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  353  						   block_len_in_page, 1, err);
8c854473917354 Dmitry Monakhov       2012-09-26  354  	drop_data_sem:
393d1d1d769338 Dr. Tilmann Bubeck    2013-04-08  355  		ext4_double_up_write_data_sem(orig_inode, donor_inode);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  356) 		goto unlock_folios;
8c854473917354 Dmitry Monakhov       2012-09-26  357  	}
8c854473917354 Dmitry Monakhov       2012-09-26  358  data_copy:
3060b6ef05603c Matthew Wilcox        2023-03-24  359  	*err = mext_page_mkuptodate(folio[0], from, from + replaced_size);
bb5574880574fe Dmitry Monakhov       2012-09-26  360  	if (*err)
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  361) 		goto unlock_folios;
748de6736c1e48 Akira Fujita          2009-06-17  362  
bb5574880574fe Dmitry Monakhov       2012-09-26  363  	/* At this point all buffers in range are uptodate, old mapping layout
bb5574880574fe Dmitry Monakhov       2012-09-26  364  	 * is no longer required, try to drop it now. */
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  365) 	if ((folio_has_private(folio[0]) &&
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  366) 		!filemap_release_folio(folio[0], 0)) ||
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  367) 	    (folio_has_private(folio[1]) &&
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  368) 		!filemap_release_folio(folio[1], 0))) {
bb5574880574fe Dmitry Monakhov       2012-09-26  369  		*err = -EBUSY;
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  370) 		goto unlock_folios;
bb5574880574fe Dmitry Monakhov       2012-09-26  371  	}
6e2631463f3a2c Dmitry Monakhov       2014-07-27  372  	ext4_double_down_write_data_sem(orig_inode, donor_inode);
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  373  	replaced_count = ext4_swap_extents(handle, orig_inode, donor_inode,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  374  					       orig_blk_offset, donor_blk_offset,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  375  					   block_len_in_page, 1, err);
6e2631463f3a2c Dmitry Monakhov       2014-07-27  376  	ext4_double_up_write_data_sem(orig_inode, donor_inode);
bb5574880574fe Dmitry Monakhov       2012-09-26  377  	if (*err) {
f868a48d06f888 Akira Fujita          2009-11-23  378  		if (replaced_count) {
f868a48d06f888 Akira Fujita          2009-11-23  379  			block_len_in_page = replaced_count;
f868a48d06f888 Akira Fujita          2009-11-23  380  			replaced_size =
f868a48d06f888 Akira Fujita          2009-11-23  381  				block_len_in_page << orig_inode->i_blkbits;
ac48b0a1d06888 Akira Fujita          2009-11-24  382  		} else
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  383) 			goto unlock_folios;
748de6736c1e48 Akira Fujita          2009-06-17  384  	}
bb5574880574fe Dmitry Monakhov       2012-09-26  385  	/* Perform all necessary steps similar write_begin()/write_end()
bb5574880574fe Dmitry Monakhov       2012-09-26  386  	 * but keeping in mind that i_size will not change */
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  387) 	if (!folio_buffers(folio[0]))
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  388) 		create_empty_buffers(&folio[0]->page, 1 << orig_inode->i_blkbits, 0);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  389) 	bh = folio_buffers(folio[0]);
bcff24887d00bc Eryu Guan             2016-02-12  390  	for (i = 0; i < data_offset_in_page; i++)
bcff24887d00bc Eryu Guan             2016-02-12  391  		bh = bh->b_this_page;
bcff24887d00bc Eryu Guan             2016-02-12  392  	for (i = 0; i < block_len_in_page; i++) {
bcff24887d00bc Eryu Guan             2016-02-12  393  		*err = ext4_get_block(orig_inode, orig_blk_offset + i, bh, 0);
bcff24887d00bc Eryu Guan             2016-02-12  394  		if (*err < 0)
bcff24887d00bc Eryu Guan             2016-02-12  395  			break;
6ffe77bad545f4 Eryu Guan             2016-02-21  396  		bh = bh->b_this_page;
bcff24887d00bc Eryu Guan             2016-02-12  397  	}
bb5574880574fe Dmitry Monakhov       2012-09-26  398  	if (!*err)
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17 @399) 		*err = block_commit_write(&folio[0]->page, from, from + replaced_size);
748de6736c1e48 Akira Fujita          2009-06-17  400  
bb5574880574fe Dmitry Monakhov       2012-09-26  401  	if (unlikely(*err < 0))
bb5574880574fe Dmitry Monakhov       2012-09-26  402  		goto repair_branches;
bb5574880574fe Dmitry Monakhov       2012-09-26  403  
bb5574880574fe Dmitry Monakhov       2012-09-26  404  	/* Even in case of data=writeback it is reasonable to pin
bb5574880574fe Dmitry Monakhov       2012-09-26  405  	 * inode to transaction, to prevent unexpected data loss */
73131fbb003b36 Ross Zwisler          2019-06-20  406  	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
73131fbb003b36 Ross Zwisler          2019-06-20  407  			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
bb5574880574fe Dmitry Monakhov       2012-09-26  408  
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  409) unlock_folios:
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  410) 	folio_unlock(folio[0]);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  411) 	folio_put(folio[0]);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  412) 	folio_unlock(folio[1]);
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  413) 	folio_put(folio[1]);
bb5574880574fe Dmitry Monakhov       2012-09-26  414  stop_journal:
748de6736c1e48 Akira Fujita          2009-06-17  415  	ext4_journal_stop(handle);
88c6b61ff1cfb4 Dmitry Monakhov       2014-11-05  416  	if (*err == -ENOSPC &&
88c6b61ff1cfb4 Dmitry Monakhov       2014-11-05  417  	    ext4_should_retry_alloc(sb, &retries))
88c6b61ff1cfb4 Dmitry Monakhov       2014-11-05  418  		goto again;
bb5574880574fe Dmitry Monakhov       2012-09-26  419  	/* Buffer was busy because probably is pinned to journal transaction,
bb5574880574fe Dmitry Monakhov       2012-09-26  420  	 * force transaction commit may help to free it. */
88c6b61ff1cfb4 Dmitry Monakhov       2014-11-05  421  	if (*err == -EBUSY && retries++ < 4 && EXT4_SB(sb)->s_journal &&
88c6b61ff1cfb4 Dmitry Monakhov       2014-11-05  422  	    jbd2_journal_force_commit_nested(EXT4_SB(sb)->s_journal))
bb5574880574fe Dmitry Monakhov       2012-09-26  423  		goto again;
f868a48d06f888 Akira Fujita          2009-11-23  424  	return replaced_count;
bb5574880574fe Dmitry Monakhov       2012-09-26  425  
bb5574880574fe Dmitry Monakhov       2012-09-26  426  repair_branches:
bb5574880574fe Dmitry Monakhov       2012-09-26  427  	/*
bb5574880574fe Dmitry Monakhov       2012-09-26  428  	 * This should never ever happen!
bb5574880574fe Dmitry Monakhov       2012-09-26  429  	 * Extents are swapped already, but we are not able to copy data.
bb5574880574fe Dmitry Monakhov       2012-09-26  430  	 * Try to swap extents to it's original places
bb5574880574fe Dmitry Monakhov       2012-09-26  431  	 */
393d1d1d769338 Dr. Tilmann Bubeck    2013-04-08  432  	ext4_double_down_write_data_sem(orig_inode, donor_inode);
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  433  	replaced_count = ext4_swap_extents(handle, donor_inode, orig_inode,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  434  					       orig_blk_offset, donor_blk_offset,
fcf6b1b729bcd2 Dmitry Monakhov       2014-08-30  435  					   block_len_in_page, 0, &err2);
393d1d1d769338 Dr. Tilmann Bubeck    2013-04-08  436  	ext4_double_up_write_data_sem(orig_inode, donor_inode);
bb5574880574fe Dmitry Monakhov       2012-09-26  437  	if (replaced_count != block_len_in_page) {
54d3adbc29f0c7 Theodore Ts'o         2020-03-28  438  		ext4_error_inode_block(orig_inode, (sector_t)(orig_blk_offset),
54d3adbc29f0c7 Theodore Ts'o         2020-03-28  439  				       EIO, "Unable to copy data block,"
bb5574880574fe Dmitry Monakhov       2012-09-26  440  				       " data will be lost.");
bb5574880574fe Dmitry Monakhov       2012-09-26  441  		*err = -EIO;
bb5574880574fe Dmitry Monakhov       2012-09-26  442  	}
bb5574880574fe Dmitry Monakhov       2012-09-26  443  	replaced_count = 0;
6dd8fe86fa8472 Vishal Moola (Oracle  2022-11-17  444) 	goto unlock_folios;
748de6736c1e48 Akira Fujita          2009-06-17  445  }
748de6736c1e48 Akira Fujita          2009-06-17  446  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
