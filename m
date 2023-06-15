Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4239732248
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 00:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjFOWA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFOWA4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 18:00:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906522943;
        Thu, 15 Jun 2023 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686866454; x=1718402454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JN/6v0RRe0LtIZ2wBFgUzMVCscs41NCa1blW5xLxo3g=;
  b=F/ENdiuYXABmQCVTvCmSbarOpYFCCtsEYxECfBDDI6dnUUnN/ndd8NHt
   J4mUz8D3oTmfW6Dwr+TiNIIKRdqChHbQyfmtsNv9R0npvLbhXysbyUBIa
   5MMjHvaO1lM0kEhaWDIKYSmHlEX/A8OimeUa4+jJrX/+EHzSXzOLHUhry
   4Z3YfP56VYQgIPpAV+6Uj2RRF7MVUW9kivrpSb86T4lHt+KEEKMCLwHJ7
   /C7EzJZwBhBobD40vWi7wOjgKiV1Xs0s2vSAZofPFKxQtxlJsOX9kMpP+
   lXH2b1EdyBkXjSZdPSI8cTg1neMx6fnQaRnbY3bsPDN4KMt7yybzpD7rs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338669731"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="338669731"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 15:00:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825471879"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825471879"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 15:00:52 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9v1P-0000Qt-1c;
        Thu, 15 Jun 2023 22:00:51 +0000
Date:   Fri, 16 Jun 2023 05:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/11] md-bitmap: refactor md_bitmap_init_from_disk
Message-ID: <202306160552.smw0qbmb-lkp@intel.com>
References: <20230615064840.629492-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615064840.629492-7-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on song-md/md-next]
[also build test WARNING on device-mapper-dm/for-next linus/master v6.4-rc6 next-20230615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/md-bitmap-initialize-variables-at-declaration-time-in-md_bitmap_file_unmap/20230615-154928
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20230615064840.629492-7-hch%40lst.de
patch subject: [PATCH 06/11] md-bitmap: refactor md_bitmap_init_from_disk
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20230616/202306160552.smw0qbmb-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add song-md git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git
        git fetch song-md md-next
        git checkout song-md/md-next
        b4 shazam https://lore.kernel.org/r/20230615064840.629492-7-hch@lst.de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/md/

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306160552.smw0qbmb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/md/md-bitmap.c:1107:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (file && i_size_read(file->f_mapping->host) < store->bytes) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/md/md-bitmap.c:1198:9: note: uninitialized use occurs here
           return ret;
                  ^~~
   drivers/md/md-bitmap.c:1107:2: note: remove the 'if' if its condition is always false
           if (file && i_size_read(file->f_mapping->host) < store->bytes) {
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/md/md-bitmap.c:1090:9: note: initialize the variable 'ret' to silence this warning
           int ret;
                  ^
                   = 0
   1 warning generated.


vim +1107 drivers/md/md-bitmap.c

5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1068  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1069  /*
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1070   * Initialize the in-memory bitmap from the on-disk bitmap and set up the memory
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1071   * mapping of the bitmap file.
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1072   *
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1073   * Special case: If there's no bitmap file, or if the bitmap file had been
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1074   * previously kicked from the array, we mark all the bits as 1's in order to
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1075   * cause a full resync.
6a07997fc34ac1 drivers/md/bitmap.c    NeilBrown         2005-09-09  1076   *
6a07997fc34ac1 drivers/md/bitmap.c    NeilBrown         2005-09-09  1077   * We ignore all bits for sectors that end earlier than 'start'.
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1078   * This is used when reading an out-of-date bitmap.
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1079   */
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  1080  static int md_bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1081  {
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1082  	bool outofdate = test_bit(BITMAP_STALE, &bitmap->flags);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1083  	struct mddev *mddev = bitmap->mddev;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1084  	unsigned long chunks = bitmap->counts.chunks;
1ec885cdd01a9a drivers/md/bitmap.c    NeilBrown         2012-05-22  1085  	struct bitmap_storage *store = &bitmap->storage;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1086  	struct file *file = store->file;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1087  	unsigned long node_offset = 0;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1088  	unsigned long bit_cnt = 0;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1089  	unsigned long i;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1090  	int ret;
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1091  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1092  	if (!file && !mddev->bitmap_info.offset) {
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1093  		/* No permanent bitmap - fill with '1s'. */
1ec885cdd01a9a drivers/md/bitmap.c    NeilBrown         2012-05-22  1094  		store->filemap = NULL;
1ec885cdd01a9a drivers/md/bitmap.c    NeilBrown         2012-05-22  1095  		store->file_pages = 0;
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1096  		for (i = 0; i < chunks ; i++) {
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1097  			/* if the disk bit is set, set the memory bit */
40cffcc0e8f9f6 drivers/md/bitmap.c    NeilBrown         2012-05-22  1098  			int needed = ((sector_t)(i+1) << (bitmap->counts.chunkshift)
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1099  				      >= start);
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  1100  			md_bitmap_set_memory_bits(bitmap,
40cffcc0e8f9f6 drivers/md/bitmap.c    NeilBrown         2012-05-22  1101  						  (sector_t)i << bitmap->counts.chunkshift,
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1102  						  needed);
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1103  		}
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1104  		return 0;
ef99bf480de9bd drivers/md/bitmap.c    NeilBrown         2012-05-22  1105  	}
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1106  
d1244cb062750b drivers/md/bitmap.c    NeilBrown         2012-05-22 @1107  	if (file && i_size_read(file->f_mapping->host) < store->bytes) {
ec0cc226854a79 drivers/md/bitmap.c    NeilBrown         2016-11-02  1108  		pr_warn("%s: bitmap file too short %lu < %lu\n",
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1109  			bmname(bitmap),
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1110  			(unsigned long) i_size_read(file->f_mapping->host),
d1244cb062750b drivers/md/bitmap.c    NeilBrown         2012-05-22  1111  			store->bytes);
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1112  		goto err;
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1113  	}
bc7f77de2cd817 drivers/md/bitmap.c    NeilBrown         2005-06-21  1114  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1115  	if (mddev_is_clustered(mddev))
b97e92574c0bf3 drivers/md/bitmap.c    Goldwyn Rodrigues 2014-06-06  1116  		node_offset = bitmap->cluster_slot * (DIV_ROUND_UP(store->bytes, PAGE_SIZE));
b97e92574c0bf3 drivers/md/bitmap.c    Goldwyn Rodrigues 2014-06-06  1117  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1118  	for (i = 0; i < store->file_pages; i++) {
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1119  		struct page *page = store->filemap[i];
d785a06a0b9d0c drivers/md/bitmap.c    NeilBrown         2006-06-26  1120  		int count;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1121  
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1122  		/* unmap the old page, we're done with it */
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1123  		if (i == store->file_pages - 1)
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1124  			count = store->bytes - i * PAGE_SIZE;
d785a06a0b9d0c drivers/md/bitmap.c    NeilBrown         2006-06-26  1125  		else
d785a06a0b9d0c drivers/md/bitmap.c    NeilBrown         2006-06-26  1126  			count = PAGE_SIZE;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1127  
27581e5ae01f77 drivers/md/bitmap.c    NeilBrown         2012-05-22  1128  		if (file)
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1129  			ret = read_file_page(file, i, bitmap, count, page);
27581e5ae01f77 drivers/md/bitmap.c    NeilBrown         2012-05-22  1130  		else
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1131  			ret = read_sb_page(mddev, mddev->bitmap_info.offset,
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1132  					   page, i + node_offset, count);
27581e5ae01f77 drivers/md/bitmap.c    NeilBrown         2012-05-22  1133  		if (ret)
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1134  			goto err;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1135  	}
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1136  
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1137  	if (outofdate) {
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1138  		pr_warn("%s: bitmap file is out of date, doing full recovery\n",
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1139  			bmname(bitmap));
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1140  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1141  		for (i = 0; i < store->file_pages; i++) {
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1142  			struct page *page = store->filemap[i];
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1143  			unsigned long offset = 0;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1144  			void *paddr;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1145  	
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1146  			if (i == 0 && !mddev->bitmap_info.external)
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1147  				offset = sizeof(bitmap_super_t);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1148  
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1149  			/*
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1150  			 * If the bitmap is out of date, dirty the whole page
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1151  			 * and write it out
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1152  			 */
b2f46e68825648 drivers/md/bitmap.c    Cong Wang         2011-11-28  1153  			paddr = kmap_atomic(page);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1154  			memset(paddr + offset, 0xff, PAGE_SIZE - offset);
b2f46e68825648 drivers/md/bitmap.c    Cong Wang         2011-11-28  1155  			kunmap_atomic(paddr);
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1156  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1157  			write_page(bitmap, page, 1);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1158  			if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags)) {
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1159  				ret = -EIO;
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1160  				goto err;
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1161  			}
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1162  		}
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1163  	}
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1164  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1165  	for (i = 0; i < chunks; i++) {
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1166  		struct page *page = filemap_get_page(&bitmap->storage, i);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1167  		unsigned long bit = file_page_offset(&bitmap->storage, i);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1168  		void *paddr;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1169  		bool was_set;
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1170  
b2f46e68825648 drivers/md/bitmap.c    Cong Wang         2011-11-28  1171  		paddr = kmap_atomic(page);
b405fe91e50c60 drivers/md/bitmap.c    NeilBrown         2012-05-22  1172  		if (test_bit(BITMAP_HOSTENDIAN, &bitmap->flags))
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1173  			was_set = test_bit(bit, paddr);
bd926c63b7a684 drivers/md/bitmap.c    NeilBrown         2005-11-08  1174  		else
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1175  			was_set = test_bit_le(bit, paddr);
b2f46e68825648 drivers/md/bitmap.c    Cong Wang         2011-11-28  1176  		kunmap_atomic(paddr);
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1177  
5479b6ae3886b9 drivers/md/md-bitmap.c Christoph Hellwig 2023-06-15  1178  		if (was_set) {
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1179  			/* if the disk bit is set, set the memory bit */
40cffcc0e8f9f6 drivers/md/bitmap.c    NeilBrown         2012-05-22  1180  			int needed = ((sector_t)(i+1) << bitmap->counts.chunkshift
db305e507d5544 drivers/md/bitmap.c    NeilBrown         2009-05-07  1181  				      >= start);
e64e4018d57271 drivers/md/md-bitmap.c Andy Shevchenko   2018-08-01  1182  			md_bitmap_set_memory_bits(bitmap,
40cffcc0e8f9f6 drivers/md/bitmap.c    NeilBrown         2012-05-22  1183  						  (sector_t)i << bitmap->counts.chunkshift,
db305e507d5544 drivers/md/bitmap.c    NeilBrown         2009-05-07  1184  						  needed);
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1185  			bit_cnt++;
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1186  		}
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1187  	}
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1188  
ec0cc226854a79 drivers/md/bitmap.c    NeilBrown         2016-11-02  1189  	pr_debug("%s: bitmap initialized from disk: read %lu pages, set %lu of %lu bits\n",
1ec885cdd01a9a drivers/md/bitmap.c    NeilBrown         2012-05-22  1190  		 bmname(bitmap), store->file_pages,
d1244cb062750b drivers/md/bitmap.c    NeilBrown         2012-05-22  1191  		 bit_cnt, chunks);
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1192  
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1193  	return 0;
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1194  
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1195   err:
ec0cc226854a79 drivers/md/bitmap.c    NeilBrown         2016-11-02  1196  	pr_warn("%s: bitmap initialisation failed: %d\n",
4ad1366376bfef drivers/md/bitmap.c    NeilBrown         2007-07-17  1197  		bmname(bitmap), ret);
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1198  	return ret;
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1199  }
32a7627cf3a353 drivers/md/bitmap.c    NeilBrown         2005-06-21  1200  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
