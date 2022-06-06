Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28A653E0F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 08:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiFFF1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 01:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiFFF1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:27:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB212B027;
        Sun,  5 Jun 2022 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654491995; x=1686027995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cxIZCHsRfBQh7J3e/3zeQZMrbh7+Lv72KC1u0AMk09o=;
  b=UR/dhrTj8Q6Js9nFUdd636u69WhBQ8dSeoTq06VQvUSQIcza5c6NFiMK
   bf+tQybmWOU+JH/hIkwMNJWaidUHqvUJ9EJVtERlEfo73ihISEFRTy5/n
   htUDgUJxi/aB9uK9Kn8OsoJQBoOXEMs1eV0ShLiseTN2k8fUxbeUFU0uL
   /RAaq6m1R3JJv6hu0OLFGF/IHsAs4kRBetHNPHJOtd624dfkYG3mm+J+l
   epnivYIzjgXZjXK5oLEy7vbQOUEC1KfbbYHfVvKHotCL+R0MJdyhllxbA
   wfNuwHsdysM5k5somGKeVgsisGClIF0GqvEbbORZNae/Gflj50qBeDkHH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276478356"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276478356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 21:37:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="708919848"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Jun 2022 21:37:06 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ny4UE-000CUD-0I;
        Mon, 06 Jun 2022 04:37:06 +0000
Date:   Mon, 6 Jun 2022 12:36:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.com>
Cc:     kbuild-all@lists.01.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, tytso@mit.edu,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] quota: Support using the page cache for quota files
Message-ID: <202206061211.HKxbKbgS-lkp@intel.com>
References: <20220605143815.2330891-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605143815.2330891-3-willy@infradead.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Matthew,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on jack-fs/for_next linus/master v5.19-rc1 next-20220603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/Cache-quota-files-in-the-page-cache/20220606-021629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220606/202206061211.HKxbKbgS-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a7ff347e002ef476c8c116f30858f83529638a9b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/Cache-quota-files-in-the-page-cache/20220606-021629
        git checkout a7ff347e002ef476c8c116f30858f83529638a9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/quota/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/quota/dquot.c:2184:33: sparse: sparse: incompatible types in comparison expression (different type sizes):
>> fs/quota/dquot.c:2184:33: sparse:    unsigned int *
>> fs/quota/dquot.c:2184:33: sparse:    unsigned long *

vim +2184 fs/quota/dquot.c

  2165	
  2166	ssize_t generic_quota_read(struct super_block *sb, int type, char *data,
  2167				      size_t len, loff_t pos)
  2168	{
  2169		struct inode *inode = sb_dqopt(sb)->files[type];
  2170		struct address_space *mapping = inode->i_mapping;
  2171		size_t toread;
  2172		pgoff_t index;
  2173		loff_t i_size = i_size_read(inode);
  2174	
  2175		if (pos > i_size)
  2176			return 0;
  2177		if (pos + len > i_size)
  2178			len = i_size - pos;
  2179		toread = len;
  2180		index = pos / PAGE_SIZE;
  2181	
  2182		while (toread > 0) {
  2183			struct folio *folio = read_mapping_folio(mapping, index, NULL);
> 2184			size_t tocopy = min(toread, PAGE_SIZE - offset_in_page(pos));
  2185			void *src;
  2186	
  2187			if (folio == ERR_PTR(-ENOMEM)) {
  2188				memalloc_retry_wait(GFP_NOFS);
  2189				continue;
  2190			} else if (IS_ERR(folio))
  2191				return PTR_ERR(folio);
  2192	
  2193			src = kmap_local_folio(folio, offset_in_folio(folio, pos));
  2194			memcpy(data, src, tocopy);
  2195			kunmap_local(src);
  2196			folio_put(folio);
  2197	
  2198			toread -= tocopy;
  2199			data += tocopy;
  2200			pos += tocopy;
  2201			index++;
  2202		}
  2203		return len;
  2204	}
  2205	EXPORT_SYMBOL(generic_quota_read);
  2206	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
