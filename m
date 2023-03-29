Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239B6CD71D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 11:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjC2J66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjC2J65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:58:57 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530AB19A;
        Wed, 29 Mar 2023 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680083936; x=1711619936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L329AyF3OgVN9WsY0kOL7oj+CaQXmNshjdDst3A4NC8=;
  b=LPiiCvEDsDa7Ajl75aAYPrUy51vTISx0HxCwD2fI3hY3eAVmlU4tlP1F
   IkGHrVUCzKmt1veMHLlgTc2U9Bqnn6FNAchYSNfsLBiXOrdgyQ1nvkcvT
   b54bOhHz0jJFvvEbB3plSI0BVW8kf4SaiUuMbpYdEYsPyNs/fOccTY8hh
   kYOLa/M+Sls/8CM79iDeVZwo1op2pbCOqJfGayCgmSX1MerbPCw8r4pM+
   gR0fweeZ08idY+anbGOXcGZWQloRjeBKWK2ez/JfqT64+Zx4BEMLN2Dl+
   mouxUJxRbqDSlbEDJ3T5boY2q6sbBR5rxXbR2qm7bhEsjTkevtEkfvsvF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="339557871"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="339557871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 02:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="634415819"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="634415819"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 02:58:51 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phSZp-000JQ8-0v;
        Wed, 29 Mar 2023 09:58:45 +0000
Date:   Wed, 29 Mar 2023 17:58:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Zi Yan <zi.yan@sent.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     oe-kbuild-all@lists.linux.dev, Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/7] mm: page_owner: add support for splitting to any
 order in split page_owner.
Message-ID: <202303291732.7OqWI96E-lkp@intel.com>
References: <20230329011712.3242298-5-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329011712.3242298-5-zi.yan@sent.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.3-rc4 next-20230329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-memcg-use-order-instead-of-nr-in-split_page_memcg/20230329-091809
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20230329011712.3242298-5-zi.yan%40sent.com
patch subject: [PATCH v2 4/7] mm: page_owner: add support for splitting to any order in split page_owner.
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20230329/202303291732.7OqWI96E-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6d1831c0e01a1a742e026454fe6e5643e08c5985
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Zi-Yan/mm-memcg-use-order-instead-of-nr-in-split_page_memcg/20230329-091809
        git checkout 6d1831c0e01a1a742e026454fe6e5643e08c5985
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303291732.7OqWI96E-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/page_owner.c: In function '__split_page_owner':
>> mm/page_owner.c:226:28: error: implicit declaration of function 'lookup_page_ext' [-Werror=implicit-function-declaration]
     226 |                 page_ext = lookup_page_ext(page + i);
         |                            ^~~~~~~~~~~~~~~
   mm/page_owner.c:226:26: warning: assignment to 'struct page_ext *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     226 |                 page_ext = lookup_page_ext(page + i);
         |                          ^
   cc1: some warnings being treated as errors


vim +/lookup_page_ext +226 mm/page_owner.c

   213	
   214	void __split_page_owner(struct page *page, int old_order, int new_order)
   215	{
   216		int i;
   217		struct page_ext *page_ext = page_ext_get(page);
   218		struct page_owner *page_owner;
   219		unsigned int old_nr = 1 << old_order;
   220		unsigned int new_nr = 1 << new_order;
   221	
   222		if (unlikely(!page_ext))
   223			return;
   224	
   225		for (i = 0; i < old_nr; i += new_nr) {
 > 226			page_ext = lookup_page_ext(page + i);
   227			page_owner = get_page_owner(page_ext);
   228			page_owner->order = new_order;
   229		}
   230		page_ext_put(page_ext);
   231	}
   232	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
