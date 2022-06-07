Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDF153F4A2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 05:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiFGDjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 23:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiFGDit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:38:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B88387BA;
        Mon,  6 Jun 2022 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654573128; x=1686109128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w4xeyqU+kOhDYzyqy82v69OYCHkAH6xk8Nd95qrz48A=;
  b=cI2CtkAJJHCwTU24iLHMl95jI+TLyqQ/r3CzxiuMBsum3Zv2lOijhywx
   7DQxnW0svepR7cp/Rauiczc3JEk/wEP7uw+iZJv1Ee5IL74PR6EiMkyxq
   D7kbQjvry7tdZe4f42EZ/drgMjgpCADrgfxO3h3i3qQ1FeSLQWIkDJQYB
   kieFIk5f/kvR16vOGkqCCcMAg/9btpMI1Y088XhRrhM/chcTLjbk9KAPd
   Ho5/plGjKvI5ADJA8DLH/y62CuUwY1ISoqsWmZM36GUBflL+xLtTSWE3x
   /dgtopIsWdfkoEzeAqYkJ9xLs+k8sMlFV0uH6o0ehNoz6lj9zRqRFrxQB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275480643"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="275480643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 20:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="579430786"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Jun 2022 20:38:40 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyQ3D-000DJf-KE;
        Tue, 07 Jun 2022 03:38:39 +0000
Date:   Tue, 7 Jun 2022 11:37:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 04/20] mm/migrate: Convert buffer_migrate_page() to
 buffer_migrate_folio()
Message-ID: <202206071139.aWSx4GHH-lkp@intel.com>
References: <20220606204050.2625949-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-5-willy@infradead.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc1 next-20220606]
[cannot apply to jaegeuk-f2fs/dev-test trondmy-nfs/linux-next kdave/for-next xfs-linux/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f2906aa863381afb0015a9eb7fefad885d4e5a56
config: i386-defconfig (https://download.01.org/0day-ci/archive/20220607/202206071139.aWSx4GHH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/96e64ba8b1be545885d89f44b1d8b968b22bdb4d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Convert-aops-migratepage-to-aops-migrate_folio/20220607-044509
        git checkout 96e64ba8b1be545885d89f44b1d8b968b22bdb4d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/migrate.c:775: warning: expecting prototype for buffer_migrate_folio_noref(). Prototype was for buffer_migrate_folio_norefs() instead


vim +775 mm/migrate.c

89cb0888ca1483a Jan Kara                2018-12-28  758  
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  759) /**
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  760)  * buffer_migrate_folio_noref() - Migration function for folios with buffers.
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  761)  * @mapping: The address space containing @src.
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  762)  * @dst: The folio to migrate to.
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  763)  * @src: The folio to migrate from.
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  764)  * @mode: How to migrate the folio.
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  765)  *
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  766)  * Like buffer_migrate_folio() except that this variant is more careful
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  767)  * and checks that there are also no buffer head references. This function
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  768)  * is the right one for mappings where buffer heads are directly looked
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  769)  * up and referenced (such as block device mappings).
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  770)  *
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  771)  * Return: 0 on success or a negative errno on failure.
89cb0888ca1483a Jan Kara                2018-12-28  772   */
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  773) int buffer_migrate_folio_norefs(struct address_space *mapping,
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  774) 		struct folio *dst, struct folio *src, enum migrate_mode mode)
89cb0888ca1483a Jan Kara                2018-12-28 @775  {
96e64ba8b1be545 Matthew Wilcox (Oracle  2022-06-06  776) 	return __buffer_migrate_folio(mapping, dst, src, mode, true);
89cb0888ca1483a Jan Kara                2018-12-28  777  }
9361401eb7619c0 David Howells           2006-09-30  778  #endif
1d8b85ccf1ed53a Christoph Lameter       2006-06-23  779  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
