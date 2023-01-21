Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBE67661B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 12:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjAULxY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 06:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAULxX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:53:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184842BEC3;
        Sat, 21 Jan 2023 03:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674302002; x=1705838002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YAXz73bfRzC4TRnCjnoOuIBuHFdhFbzfUfvKWYHlwQM=;
  b=jz7ixWo7douEGUfTWgQPm4ABzJYu7JsqXiXK9DRzpPJ8spFQVrk/K2um
   4HxFSOSOWhMlGzWuUMgbwqRyAtxZ28Lx8viUsZISv4SbKdjDF2MXe4423
   4XqWHod1NZQjWA+szShmtRstY0SYoWeqbjN01qRczpd2O2iT8jXLStdKA
   Imac2OUf9+u+uOLJQ/9LJZTSwosVUMI8uAqBKB0y5G/UIGcKAEW06Kdfs
   ZJPm9EBVDxdWJDl8vwNVfK4axY+h+rpAXzaeZofNDsiJX9R8Gi4N82a4J
   6DGLR7HN5Djsf7WEc5yhJHC4B2DKI+OKwMPCK5oDKzWnn6vYeTGD/VlAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="309353720"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="309353720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2023 03:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="610768753"
X-IronPort-AV: E=Sophos;i="5.97,235,1669104000"; 
   d="scan'208";a="610768753"
Received: from lkp-server01.sh.intel.com (HELO 5646d64e7320) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Jan 2023 03:53:17 -0800
Received: from kbuild by 5646d64e7320 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pJCQv-00041S-0Y;
        Sat, 21 Jan 2023 11:53:17 +0000
Date:   Sat, 21 Jan 2023 19:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: [PATCH 7/7] mm: return an ERR_PTR from __filemap_get_folio
Message-ID: <202301211944.5T9l1RgA-lkp@intel.com>
References: <20230121065755.1140136-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121065755.1140136-8-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

I love your patch! Perhaps something to improve:

[auto build test WARNING on next-20230120]
[cannot apply to akpm-mm/mm-everything tytso-ext4/dev kdave/for-next xfs-linux/for-next konis-nilfs2/upstream linus/master v6.2-rc4 v6.2-rc3 v6.2-rc2 v6.2-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/mm-make-mapping_get_entry-available-outside-of-filemap-c/20230121-155847
patch link:    https://lore.kernel.org/r/20230121065755.1140136-8-hch%40lst.de
patch subject: [PATCH 7/7] mm: return an ERR_PTR from __filemap_get_folio
config: riscv-randconfig-r013-20230119 (https://download.01.org/0day-ci/archive/20230121/202301211944.5T9l1RgA-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 4196ca3278f78c6e19246e54ab0ecb364e37d66a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3c8a98fd03b82ace84668b3f8bb48d48e9f34af2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christoph-Hellwig/mm-make-mapping_get_entry-available-outside-of-filemap-c/20230121-155847
        git checkout 3c8a98fd03b82ace84668b3f8bb48d48e9f34af2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/iomap/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/iomap/buffered-io.c:669:28: warning: variable 'folio' is uninitialized when used here [-Wuninitialized]
           if (pos + len > folio_pos(folio) + folio_size(folio))
                                     ^~~~~
   fs/iomap/buffered-io.c:636:21: note: initialize the variable 'folio' to silence this warning
           struct folio *folio;
                              ^
                               = NULL
   fs/iomap/buffered-io.c:598:22: warning: unused function '__iomap_get_folio' [-Wunused-function]
   static struct folio *__iomap_get_folio(struct iomap_iter *iter, loff_t pos,
                        ^
   2 warnings generated.


vim +/folio +669 fs/iomap/buffered-io.c

69f4a26c1e0c7c Gao Xiang               2021-08-03  630  
d7b64041164ca1 Dave Chinner            2022-11-29  631  static int iomap_write_begin(struct iomap_iter *iter, loff_t pos,
bc6123a84a71b5 Matthew Wilcox (Oracle  2021-05-02  632) 		size_t len, struct folio **foliop)
afc51aaa22f26c Darrick J. Wong         2019-07-15  633  {
471859f57d4253 Andreas Gruenbacher     2023-01-15  634  	const struct iomap_folio_ops *folio_ops = iter->iomap.folio_ops;
fad0a1ab34f777 Christoph Hellwig       2021-08-10  635  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
d1bd0b4ebfe052 Matthew Wilcox (Oracle  2021-11-03  636) 	struct folio *folio;
afc51aaa22f26c Darrick J. Wong         2019-07-15  637  	int status = 0;
afc51aaa22f26c Darrick J. Wong         2019-07-15  638  
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  639  	BUG_ON(pos + len > iter->iomap.offset + iter->iomap.length);
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  640  	if (srcmap != &iter->iomap)
c039b997927263 Goldwyn Rodrigues       2019-10-18  641  		BUG_ON(pos + len > srcmap->offset + srcmap->length);
afc51aaa22f26c Darrick J. Wong         2019-07-15  642  
afc51aaa22f26c Darrick J. Wong         2019-07-15  643  	if (fatal_signal_pending(current))
afc51aaa22f26c Darrick J. Wong         2019-07-15  644  		return -EINTR;
afc51aaa22f26c Darrick J. Wong         2019-07-15  645  
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  646) 	if (!mapping_large_folio_support(iter->inode->i_mapping))
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  647) 		len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  648) 
d7b64041164ca1 Dave Chinner            2022-11-29  649  	/*
d7b64041164ca1 Dave Chinner            2022-11-29  650  	 * Now we have a locked folio, before we do anything with it we need to
d7b64041164ca1 Dave Chinner            2022-11-29  651  	 * check that the iomap we have cached is not stale. The inode extent
d7b64041164ca1 Dave Chinner            2022-11-29  652  	 * mapping can change due to concurrent IO in flight (e.g.
d7b64041164ca1 Dave Chinner            2022-11-29  653  	 * IOMAP_UNWRITTEN state can change and memory reclaim could have
d7b64041164ca1 Dave Chinner            2022-11-29  654  	 * reclaimed a previously partially written page at this index after IO
d7b64041164ca1 Dave Chinner            2022-11-29  655  	 * completion before this write reaches this file offset) and hence we
d7b64041164ca1 Dave Chinner            2022-11-29  656  	 * could do the wrong thing here (zero a page range incorrectly or fail
d7b64041164ca1 Dave Chinner            2022-11-29  657  	 * to zero) and corrupt data.
d7b64041164ca1 Dave Chinner            2022-11-29  658  	 */
471859f57d4253 Andreas Gruenbacher     2023-01-15  659  	if (folio_ops && folio_ops->iomap_valid) {
471859f57d4253 Andreas Gruenbacher     2023-01-15  660  		bool iomap_valid = folio_ops->iomap_valid(iter->inode,
d7b64041164ca1 Dave Chinner            2022-11-29  661  							 &iter->iomap);
d7b64041164ca1 Dave Chinner            2022-11-29  662  		if (!iomap_valid) {
d7b64041164ca1 Dave Chinner            2022-11-29  663  			iter->iomap.flags |= IOMAP_F_STALE;
d7b64041164ca1 Dave Chinner            2022-11-29  664  			status = 0;
d7b64041164ca1 Dave Chinner            2022-11-29  665  			goto out_unlock;
d7b64041164ca1 Dave Chinner            2022-11-29  666  		}
d7b64041164ca1 Dave Chinner            2022-11-29  667  	}
d7b64041164ca1 Dave Chinner            2022-11-29  668  
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09 @669) 	if (pos + len > folio_pos(folio) + folio_size(folio))
d454ab82bc7f4a Matthew Wilcox (Oracle  2021-12-09  670) 		len = folio_pos(folio) + folio_size(folio) - pos;
afc51aaa22f26c Darrick J. Wong         2019-07-15  671  
c039b997927263 Goldwyn Rodrigues       2019-10-18  672  	if (srcmap->type == IOMAP_INLINE)
bc6123a84a71b5 Matthew Wilcox (Oracle  2021-05-02  673) 		status = iomap_write_begin_inline(iter, folio);
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  674  	else if (srcmap->flags & IOMAP_F_BUFFER_HEAD)
d1bd0b4ebfe052 Matthew Wilcox (Oracle  2021-11-03  675) 		status = __block_write_begin_int(folio, pos, len, NULL, srcmap);
afc51aaa22f26c Darrick J. Wong         2019-07-15  676  	else
bc6123a84a71b5 Matthew Wilcox (Oracle  2021-05-02  677) 		status = __iomap_write_begin(iter, pos, len, folio);
afc51aaa22f26c Darrick J. Wong         2019-07-15  678  
afc51aaa22f26c Darrick J. Wong         2019-07-15  679  	if (unlikely(status))
afc51aaa22f26c Darrick J. Wong         2019-07-15  680  		goto out_unlock;
afc51aaa22f26c Darrick J. Wong         2019-07-15  681  
bc6123a84a71b5 Matthew Wilcox (Oracle  2021-05-02  682) 	*foliop = folio;
afc51aaa22f26c Darrick J. Wong         2019-07-15  683  	return 0;
afc51aaa22f26c Darrick J. Wong         2019-07-15  684  
afc51aaa22f26c Darrick J. Wong         2019-07-15  685  out_unlock:
7a70a5085ed028 Andreas Gruenbacher     2023-01-15  686  	__iomap_put_folio(iter, pos, 0, folio);
1b5c1e36dc0e0f Christoph Hellwig       2021-08-10  687  	iomap_write_failed(iter->inode, pos, len);
afc51aaa22f26c Darrick J. Wong         2019-07-15  688  
afc51aaa22f26c Darrick J. Wong         2019-07-15  689  	return status;
afc51aaa22f26c Darrick J. Wong         2019-07-15  690  }
afc51aaa22f26c Darrick J. Wong         2019-07-15  691  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
