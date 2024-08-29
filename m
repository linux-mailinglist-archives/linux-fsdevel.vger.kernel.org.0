Return-Path: <linux-fsdevel+bounces-27935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F333964D26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0362812CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A141B81AE;
	Thu, 29 Aug 2024 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIJKuEHl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BE1B5EA1;
	Thu, 29 Aug 2024 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953479; cv=none; b=RkHz/Flp2Czd/2oveq835W2xDM9JVusKouhJ3XB0+xjYSDE7S83obHR3mlozEWwVHaJTdQRcjuTzS769oiZM0iukW+qi7bgycQ7Mj835zKLcIVwJVLiXQIoLeVVfAFNt9qar9P3wYHTLF1jj3RJkeTeXHkOSiXubBTDCgWpfG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953479; c=relaxed/simple;
	bh=OeICkt69Q7l7jMzcCZkaAIW3lOqEG7Hp8jq5sAQ3Q0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCzoCQNLJyD7i4oX+Nb3XEm4/iaiW0hCmYjexJDlkaw5NP0t8cjQWzsFSPsRiomsmegc77MssTn287de9JXf8xKGhEyXIEW4AqrCVuVy1co9e20S0X8Y+dLvsO9fpHUtDK4ny6TgpvXVnhg72diFaD+WrHV3sAeVxm2n9//6iog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIJKuEHl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724953478; x=1756489478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OeICkt69Q7l7jMzcCZkaAIW3lOqEG7Hp8jq5sAQ3Q0g=;
  b=aIJKuEHlGePEh/WUPVpKR1z8IW+QdFC86WhgSinMfPC5BiFcVGrfWDgc
   1vAlR7RzFZnD75zz4SquKveED7XSC+9aRasJ/KgLPILZRoIMEpCaTcKVK
   0n9oEQOYXaKXaMFtqjzcxht4JeNfyBPEj85lhJSmOpauMWu/5Pd9KPeuZ
   /pqqVg/xmlGsUWOzNaw7PLmps0biV7PTLF/ceCA81URMEw9fWNz00hlF6
   qk6MtT9WpCplG+bZuO5cMjkFNzwblAkRP1YN93K4KUMsg7Co9dfAFQKI5
   EOtcQF+RVKX0BjVE8tZtwRgp8gGC2xE52v7HTc4Dxlzq3caUqdR0MadDO
   g==;
X-CSE-ConnectionGUID: 2WNe8LJJQRiDzTyQqAa9Ww==
X-CSE-MsgGUID: mwllGqfYQDy8bjB+Cp92Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34232538"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34232538"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 10:44:36 -0700
X-CSE-ConnectionGUID: FxpRN4OETXa62Xjcxo95RA==
X-CSE-MsgGUID: 1G6AMos7TaKBcxMKjbSvHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63844429"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Aug 2024 10:44:34 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjjCB-0000ZO-0k;
	Thu, 29 Aug 2024 17:44:31 +0000
Date: Fri, 30 Aug 2024 01:43:41 +0800
From: kernel test robot <lkp@intel.com>
To: Haifeng Xu <haifeng.xu@shopee.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Cc: oe-kbuild-all@lists.linux.dev, tytso@mit.edu, yi.zhang@huaweicloud.com,
	yukuai1@huaweicloud.com, tj@kernel.org, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
Message-ID: <202408300119.UQ0zNU1f-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-002-20240829 (https://download.01.org/0day-ci/archive/20240830/202408300119.UQ0zNU1f-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300119.UQ0zNU1f-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300119.UQ0zNU1f-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/buffer.c: In function 'submit_bh_wbc':
>> fs/buffer.c:2826:29: error: implicit declaration of function 'mem_cgroup_css_from_folio'; did you mean 'mem_cgroup_from_obj'? [-Werror=implicit-function-declaration]
    2826 |                 memcg_css = mem_cgroup_css_from_folio(folio);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                             mem_cgroup_from_obj
>> fs/buffer.c:2826:27: warning: assignment to 'struct cgroup_subsys_state *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2826 |                 memcg_css = mem_cgroup_css_from_folio(folio);
         |                           ^
   In file included from include/linux/array_size.h:5,
                    from include/linux/kernel.h:16,
                    from fs/buffer.c:22:
>> fs/buffer.c:2827:42: error: 'memory_cgrp_subsys_on_dfl_key' undeclared (first use in this function); did you mean 'misc_cgrp_subsys_on_dfl_key'?
    2827 |                 if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
         |                                          ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:19:53: note: in definition of macro 'likely_notrace'
      19 | #define likely_notrace(x)       __builtin_expect(!!(x), 1)
         |                                                     ^
   include/linux/jump_label.h:511:56: note: in expansion of macro 'static_key_enabled'
     511 | #define static_branch_likely(x)         likely_notrace(static_key_enabled(&(x)->key))
         |                                                        ^~~~~~~~~~~~~~~~~~
   include/linux/cgroup.h:95:9: note: in expansion of macro 'static_branch_likely'
      95 |         static_branch_likely(&ss ## _on_dfl_key)
         |         ^~~~~~~~~~~~~~~~~~~~
   fs/buffer.c:2827:21: note: in expansion of macro 'cgroup_subsys_on_dfl'
    2827 |                 if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
         |                     ^~~~~~~~~~~~~~~~~~~~
   fs/buffer.c:2827:42: note: each undeclared identifier is reported only once for each function it appears in
    2827 |                 if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
         |                                          ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:19:53: note: in definition of macro 'likely_notrace'
      19 | #define likely_notrace(x)       __builtin_expect(!!(x), 1)
         |                                                     ^
   include/linux/jump_label.h:511:56: note: in expansion of macro 'static_key_enabled'
     511 | #define static_branch_likely(x)         likely_notrace(static_key_enabled(&(x)->key))
         |                                                        ^~~~~~~~~~~~~~~~~~
   include/linux/cgroup.h:95:9: note: in expansion of macro 'static_branch_likely'
      95 |         static_branch_likely(&ss ## _on_dfl_key)
         |         ^~~~~~~~~~~~~~~~~~~~
   fs/buffer.c:2827:21: note: in expansion of macro 'cgroup_subsys_on_dfl'
    2827 |                 if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
         |                     ^~~~~~~~~~~~~~~~~~~~
>> fs/buffer.c:2828:42: error: 'io_cgrp_subsys_on_dfl_key' undeclared (first use in this function); did you mean 'misc_cgrp_subsys_on_dfl_key'?
    2828 |                     cgroup_subsys_on_dfl(io_cgrp_subsys)) {
         |                                          ^~~~~~~~~~~~~~
   include/linux/compiler.h:19:53: note: in definition of macro 'likely_notrace'
      19 | #define likely_notrace(x)       __builtin_expect(!!(x), 1)
         |                                                     ^
   include/linux/jump_label.h:511:56: note: in expansion of macro 'static_key_enabled'
     511 | #define static_branch_likely(x)         likely_notrace(static_key_enabled(&(x)->key))
         |                                                        ^~~~~~~~~~~~~~~~~~
   include/linux/cgroup.h:95:9: note: in expansion of macro 'static_branch_likely'
      95 |         static_branch_likely(&ss ## _on_dfl_key)
         |         ^~~~~~~~~~~~~~~~~~~~
   fs/buffer.c:2828:21: note: in expansion of macro 'cgroup_subsys_on_dfl'
    2828 |                     cgroup_subsys_on_dfl(io_cgrp_subsys)) {
         |                     ^~~~~~~~~~~~~~~~~~~~
>> fs/buffer.c:2829:70: error: 'io_cgrp_subsys' undeclared (first use in this function); did you mean 'misc_cgrp_subsys'?
    2829 |                         blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
         |                                                                      ^~~~~~~~~~~~~~
         |                                                                      misc_cgrp_subsys
   cc1: some warnings being treated as errors


vim +2826 fs/buffer.c

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
> 2826			memcg_css = mem_cgroup_css_from_folio(folio);
> 2827			if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> 2828			    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
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

