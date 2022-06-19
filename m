Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D584550BE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiFSPlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSPlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:41:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D8646B
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655653264; x=1687189264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3GlXH9S57pJp/FopHhsW1mIroyEXCZdMt+bxMrlaxrU=;
  b=i3DLdBamwsBtEAupkEJv5/b49ywjbu94Erj+8JpSrIL01jBIWO3q2zU8
   v+6Cnt3avfsgCh5EmYr+TtGo7+qqmmW/Uaja12y4Vue9cUc8sctUIK5vd
   v5czA2U67gtTl/mxl9XHSW/aIupN3LTwRi0NFZ+1lvXdVPggr0ayCr5hM
   6lITDfwgNDD6W98Y3pfVk5+BqUff1VfeRbE3B+06QmUgdy8h+YCtsVA/Z
   o0Nic92BSlcsPUTo4vDzuh3A8tcgCWR31OUoRXff8nHaKq8Hwo8YZpfww
   vLKlIiuCtSVgM1jqbzLJFZcSkH5q3DDUAkeTMH5drec7ErjkJvB14Z4SA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305174310"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305174310"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 08:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832762665"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Jun 2022 08:41:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2x2r-000RKR-Rm;
        Sun, 19 Jun 2022 15:41:01 +0000
Date:   Sun, 19 Jun 2022 23:40:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.iov_iter_get_pages 24/33] lib/iov_iter.c:1295
 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.
Message-ID: <202206192306.POJg04ej-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter_get_pages
head:   fe8e2809c7db0ec65403b31b50906f3f481a9b10
commit: e64d637d648390e4ac0643747ae174c3be15f243 [24/33] iov_iter: saner helper for page array allocation
config: mips-randconfig-m031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206192306.POJg04ej-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
lib/iov_iter.c:1295 iter_xarray_get_pages() warn: unsigned 'count' is never less than zero.

vim +/count +1295 lib/iov_iter.c

  1280	
  1281	static ssize_t iter_xarray_get_pages(struct iov_iter *i,
  1282					     struct page ***pages, size_t maxsize,
  1283					     unsigned maxpages, size_t *_start_offset)
  1284	{
  1285		unsigned nr, offset;
  1286		pgoff_t index, count;
  1287		loff_t pos;
  1288	
  1289		pos = i->xarray_start + i->iov_offset;
  1290		index = pos >> PAGE_SHIFT;
  1291		offset = pos & ~PAGE_MASK;
  1292		*_start_offset = offset;
  1293	
  1294		count = want_pages_array(pages, maxsize, offset, maxpages);
> 1295		if (count < 0)
  1296			return count;
  1297		nr = iter_xarray_populate_pages(*pages, i->xarray, index, count);
  1298		if (nr == 0)
  1299			return 0;
  1300	
  1301		return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
  1302	}
  1303	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
