Return-Path: <linux-fsdevel+bounces-27893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD1964B90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A211F21BA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E161B6540;
	Thu, 29 Aug 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CoARXOaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DAF1B5325;
	Thu, 29 Aug 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948495; cv=none; b=BLye7u37lMJ1Fhs5Zjg6/lnotqpXJm2PX2E/KdNYW2+SP+lhKEN+fIa6Lz1yrhKUdW7sjp4zXSu2xqgRgcraXYVWQ6H9n601UMQSE6M6nPfN3kd6TaN3nG0pMkMW0u0lF80LrdJo9RR/ypGHpCVb87PAn27d/617bi2e5014Ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948495; c=relaxed/simple;
	bh=QSD0KfHL5nBVjCs5CyKPuF0Hu/LItF1ebis/Y0+ARtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HREtMqugwx1znK7376Rs0BY5cDsNHw3BXgKCGUxExXPdc75QnU0MvL9coYezjgOr7aaYVwLdR6PXZX+jDWiYoatO69JF2MsNt70OmFM5hEkezSvFtGL/WzQXEYYzFzeLscSCM6sbHREqlWBuFq+UB4M5YY+nxS9laqP+P/F9fbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CoARXOaD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724948493; x=1756484493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSD0KfHL5nBVjCs5CyKPuF0Hu/LItF1ebis/Y0+ARtE=;
  b=CoARXOaDXvSxzo5PFlyYg6jyW5xR47lo+6Da/LT7bPo8kyF+dc1vAnHR
   m8RauvLq0C0Owqo210V3hw948HykysylRgRdUc8/8fPxoCn3pcmlGkuKF
   NU+wDpJxynLnEFzjhpzQhACjdKdiKWiit80loWmE010eXip9DM8jw8Mbj
   35W1W2g7TVj7btBBWowhYakfLwkE7lMYibkgAgEuLFk82lD4AfgjGB66S
   rcoGE49Z92WBBw4aCcuofvp1XHo/BwM9jRL3e2G4Vj5cngxyWebv7Q/ZG
   E2kDzUtmvmMOqHSpOwQZujzILKSNwfjPnqunQSxXw2Fh/wqN4bDyX+Mim
   g==;
X-CSE-ConnectionGUID: KeyKL/QhQbaVHwapqPTZ+A==
X-CSE-MsgGUID: a5J9g5BGTgOJguCRlRoaIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23725567"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23725567"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 09:21:32 -0700
X-CSE-ConnectionGUID: baVme5SvQhCgxvjuylVrYg==
X-CSE-MsgGUID: SRL9VVpyRRKKuQttzYY6tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="94368725"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Aug 2024 09:21:30 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjhtm-0000So-29;
	Thu, 29 Aug 2024 16:21:26 +0000
Date: Fri, 30 Aug 2024 00:20:59 +0800
From: kernel test robot <lkp@intel.com>
To: Haifeng Xu <haifeng.xu@shopee.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, tytso@mit.edu, yi.zhang@huaweicloud.com,
	yukuai1@huaweicloud.com, tj@kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
Message-ID: <202408300007.m9sHEOXo-lkp@intel.com>
References: <20240828033224.146584-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828033224.146584-1-haifeng.xu@shopee.com>

Hi Haifeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.11-rc5 next-20240829]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haifeng-Xu/buffer-Associate-the-meta-bio-with-blkg-from-buffer-page/20240828-113409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240828033224.146584-1-haifeng.xu%40shopee.com
patch subject: [PATCH] buffer: Associate the meta bio with blkg from buffer page
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20240830/202408300007.m9sHEOXo-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300007.m9sHEOXo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300007.m9sHEOXo-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/buffer.c: In function 'submit_bh_wbc':
   fs/buffer.c:2826:29: error: implicit declaration of function 'mem_cgroup_css_from_folio'; did you mean 'mem_cgroup_from_obj'? [-Werror=implicit-function-declaration]
    2826 |                 memcg_css = mem_cgroup_css_from_folio(folio);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                             mem_cgroup_from_obj
   fs/buffer.c:2826:27: warning: assignment to 'struct cgroup_subsys_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2826 |                 memcg_css = mem_cgroup_css_from_folio(folio);
         |                           ^
>> fs/buffer.c:2827:21: error: implicit declaration of function 'cgroup_subsys_on_dfl' [-Werror=implicit-function-declaration]
    2827 |                 if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
         |                     ^~~~~~~~~~~~~~~~~~~~
>> fs/buffer.c:2827:42: error: 'memory_cgrp_subsys' undeclared (first use in this function)
    2827 |                 if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
         |                                          ^~~~~~~~~~~~~~~~~~
   fs/buffer.c:2827:42: note: each undeclared identifier is reported only once for each function it appears in
   fs/buffer.c:2828:42: error: 'io_cgrp_subsys' undeclared (first use in this function)
    2828 |                     cgroup_subsys_on_dfl(io_cgrp_subsys)) {
         |                                          ^~~~~~~~~~~~~~
>> fs/buffer.c:2829:37: error: implicit declaration of function 'cgroup_e_css'; did you mean 'cgroup_exit'? [-Werror=implicit-function-declaration]
    2829 |                         blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
         |                                     ^~~~~~~~~~~~
         |                                     cgroup_exit
>> fs/buffer.c:2829:59: error: invalid use of undefined type 'struct cgroup_subsys_state'
    2829 |                         blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
         |                                                           ^~
   cc1: some warnings being treated as errors


vim +/cgroup_subsys_on_dfl +2827 fs/buffer.c

  2778	
  2779	static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
  2780				  enum rw_hint write_hint,
  2781				  struct writeback_control *wbc)
  2782	{
  2783		const enum req_op op = opf & REQ_OP_MASK;
  2784		struct bio *bio;
  2785	
  2786		BUG_ON(!buffer_locked(bh));
  2787		BUG_ON(!buffer_mapped(bh));
  2788		BUG_ON(!bh->b_end_io);
  2789		BUG_ON(buffer_delay(bh));
  2790		BUG_ON(buffer_unwritten(bh));
  2791	
  2792		/*
  2793		 * Only clear out a write error when rewriting
  2794		 */
  2795		if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
  2796			clear_buffer_write_io_error(bh);
  2797	
  2798		if (buffer_meta(bh))
  2799			opf |= REQ_META;
  2800		if (buffer_prio(bh))
  2801			opf |= REQ_PRIO;
  2802	
  2803		bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
  2804	
  2805		fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
  2806	
  2807		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
  2808		bio->bi_write_hint = write_hint;
  2809	
  2810		__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
  2811	
  2812		bio->bi_end_io = end_bio_bh_io_sync;
  2813		bio->bi_private = bh;
  2814	
  2815		/* Take care of bh's that straddle the end of the device */
  2816		guard_bio_eod(bio);
  2817	
  2818		if (wbc) {
  2819			wbc_init_bio(wbc, bio);
  2820			wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
  2821		} else if (buffer_meta(bh)) {
  2822			struct folio *folio;
  2823			struct cgroup_subsys_state *memcg_css, *blkcg_css;
  2824	
  2825			folio = page_folio(bh->b_page);
  2826			memcg_css = mem_cgroup_css_from_folio(folio);
> 2827			if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
  2828			    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> 2829				blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
  2830				bio_associate_blkg_from_css(bio, blkcg_css);
  2831			}
  2832		}
  2833	
  2834		submit_bio(bio);
  2835	}
  2836	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

