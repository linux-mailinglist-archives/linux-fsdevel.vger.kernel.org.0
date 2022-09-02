Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F0C5ABA50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiIBVki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiIBVkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:40:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D04D251;
        Fri,  2 Sep 2022 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662154830; x=1693690830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HksWenRhyuRs7h/PR6mpnNs+GL/O4/v36GNHyfdYvWA=;
  b=StX3EJ+XPsGgWj3yMm7TgouTBuiP4XerK8I3J8LGEebS0h6csfo/BZY5
   5KBhyREVh745qzYXVPAl59DlyIUU6LoB+DSjFClPqR45fQakHy9XK6qdA
   uhvFzv5kA0L9CiRRKvpaU0lofIZoAIDFGbI58VUrTXwHZB1c4Ozp5DR8P
   9rgWhxNS+EhqW9OaoDoqamuKxBJuSdvFXyJ5I4jlXFNl2UTVsgHsEJCxw
   gEH1Rqci11wHPFJmBW+tpqHqkoSxn6nIOXXPzyESHSspxa+4fXNYW+u8Z
   PnhK2W9bUY8QhjPCgj/XPNTCZlomqoqc9AHztFBYXZHwFwNvwKDR3Wv9w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="296876916"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="296876916"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 14:40:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="564106825"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Sep 2022 14:40:25 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUEOm-0000dc-2p;
        Fri, 02 Sep 2022 21:40:24 +0000
Date:   Sat, 3 Sep 2022 05:39:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [PATCH 14/23] f2fs: Convert f2fs_write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <202209030512.9yAy8edt-lkp@intel.com>
References: <20220901220138.182896-15-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901220138.182896-15-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Vishal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on kdave/for-next linus/master v6.0-rc3]
[cannot apply to ceph-client/for-linus next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20220902-060430
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
config: arc-randconfig-r043-20220901 (https://download.01.org/0day-ci/archive/20220903/202209030512.9yAy8edt-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c74320953cd3749db95f9f09c1fc7d044933635
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vishal-Moola-Oracle/Convert-to-filemap_get_folios_tag/20220902-060430
        git checkout 6c74320953cd3749db95f9f09c1fc7d044933635
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/f2fs/data.c: In function 'f2fs_write_cache_pages':
>> fs/f2fs/data.c:3016:53: error: 'nr_pages' undeclared (first use in this function); did you mean 'dir_pages'?
    3016 |                                         &fbatch, i, nr_pages, true))
         |                                                     ^~~~~~~~
         |                                                     dir_pages
   fs/f2fs/data.c:3016:53: note: each undeclared identifier is reported only once for each function it appears in
>> fs/f2fs/data.c:3017:41: error: label 'lock_page' used but not defined
    3017 |                                         goto lock_page;
         |                                         ^~~~


vim +3016 fs/f2fs/data.c

  2908	
  2909	/*
  2910	 * This function was copied from write_cche_pages from mm/page-writeback.c.
  2911	 * The major change is making write step of cold data page separately from
  2912	 * warm/hot data page.
  2913	 */
  2914	static int f2fs_write_cache_pages(struct address_space *mapping,
  2915						struct writeback_control *wbc,
  2916						enum iostat_type io_type)
  2917	{
  2918		int ret = 0;
  2919		int done = 0, retry = 0;
  2920		struct folio_batch fbatch;
  2921		struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
  2922		struct bio *bio = NULL;
  2923		sector_t last_block;
  2924	#ifdef CONFIG_F2FS_FS_COMPRESSION
  2925		struct inode *inode = mapping->host;
  2926		struct compress_ctx cc = {
  2927			.inode = inode,
  2928			.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
  2929			.cluster_size = F2FS_I(inode)->i_cluster_size,
  2930			.cluster_idx = NULL_CLUSTER,
  2931			.rpages = NULL,
  2932			.nr_rpages = 0,
  2933			.cpages = NULL,
  2934			.valid_nr_cpages = 0,
  2935			.rbuf = NULL,
  2936			.cbuf = NULL,
  2937			.rlen = PAGE_SIZE * F2FS_I(inode)->i_cluster_size,
  2938			.private = NULL,
  2939		};
  2940	#endif
  2941		int nr_folios;
  2942		pgoff_t index;
  2943		pgoff_t end;		/* Inclusive */
  2944		pgoff_t done_index;
  2945		int range_whole = 0;
  2946		xa_mark_t tag;
  2947		int nwritten = 0;
  2948		int submitted = 0;
  2949		int i;
  2950	
  2951		folio_batch_init(&fbatch);
  2952	
  2953		if (get_dirty_pages(mapping->host) <=
  2954					SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
  2955			set_inode_flag(mapping->host, FI_HOT_DATA);
  2956		else
  2957			clear_inode_flag(mapping->host, FI_HOT_DATA);
  2958	
  2959		if (wbc->range_cyclic) {
  2960			index = mapping->writeback_index; /* prev offset */
  2961			end = -1;
  2962		} else {
  2963			index = wbc->range_start >> PAGE_SHIFT;
  2964			end = wbc->range_end >> PAGE_SHIFT;
  2965			if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
  2966				range_whole = 1;
  2967		}
  2968		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
  2969			tag = PAGECACHE_TAG_TOWRITE;
  2970		else
  2971			tag = PAGECACHE_TAG_DIRTY;
  2972	retry:
  2973		retry = 0;
  2974		if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
  2975			tag_pages_for_writeback(mapping, index, end);
  2976		done_index = index;
  2977		while (!done && !retry && (index <= end)) {
  2978			nr_folios = filemap_get_folios_tag(mapping, &index, end,
  2979					tag, &fbatch);
  2980			if (nr_folios == 0)
  2981				break;
  2982	
  2983			for (i = 0; i < nr_folios; i++) {
  2984				struct folio *folio = fbatch.folios[i];
  2985				bool need_readd;
  2986	readd:
  2987				need_readd = false;
  2988	#ifdef CONFIG_F2FS_FS_COMPRESSION
  2989				if (f2fs_compressed_file(inode)) {
  2990					void *fsdata = NULL;
  2991					struct page *pagep;
  2992					int ret2;
  2993	
  2994					ret = f2fs_init_compress_ctx(&cc);
  2995					if (ret) {
  2996						done = 1;
  2997						break;
  2998					}
  2999	
  3000					if (!f2fs_cluster_can_merge_page(&cc,
  3001									folio->index)) {
  3002						ret = f2fs_write_multi_pages(&cc,
  3003							&submitted, wbc, io_type);
  3004						if (!ret)
  3005							need_readd = true;
  3006						goto result;
  3007					}
  3008	
  3009					if (unlikely(f2fs_cp_error(sbi)))
  3010						goto lock_folio;
  3011	
  3012					if (!f2fs_cluster_is_empty(&cc))
  3013						goto lock_folio;
  3014	
  3015					if (f2fs_all_cluster_page_ready(&cc,
> 3016						&fbatch, i, nr_pages, true))
> 3017						goto lock_page;
  3018	
  3019					ret2 = f2fs_prepare_compress_overwrite(
  3020								inode, &pagep,
  3021								folio->index, &fsdata);
  3022					if (ret2 < 0) {
  3023						ret = ret2;
  3024						done = 1;
  3025						break;
  3026					} else if (ret2 &&
  3027						(!f2fs_compress_write_end(inode,
  3028							fsdata, folio->index, 1) ||
  3029						 !f2fs_all_cluster_page_ready(&cc,
  3030							&fbatch, i, nr_folios,
  3031							false))) {
  3032						retry = 1;
  3033						break;
  3034					}
  3035				}
  3036	#endif
  3037				/* give a priority to WB_SYNC threads */
  3038				if (atomic_read(&sbi->wb_sync_req[DATA]) &&
  3039						wbc->sync_mode == WB_SYNC_NONE) {
  3040					done = 1;
  3041					break;
  3042				}
  3043	#ifdef CONFIG_F2FS_FS_COMPRESSION
  3044	lock_folio:
  3045	#endif
  3046				done_index = folio->index;
  3047	retry_write:
  3048				folio_lock(folio);
  3049	
  3050				if (unlikely(folio->mapping != mapping)) {
  3051	continue_unlock:
  3052					folio_unlock(folio);
  3053					continue;
  3054				}
  3055	
  3056				if (!folio_test_dirty(folio)) {
  3057					/* someone wrote it for us */
  3058					goto continue_unlock;
  3059				}
  3060	
  3061				if (folio_test_writeback(folio)) {
  3062					if (wbc->sync_mode != WB_SYNC_NONE)
  3063						f2fs_wait_on_page_writeback(
  3064								&folio->page,
  3065								DATA, true, true);
  3066					else
  3067						goto continue_unlock;
  3068				}
  3069	
  3070				if (!folio_clear_dirty_for_io(folio))
  3071					goto continue_unlock;
  3072	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
