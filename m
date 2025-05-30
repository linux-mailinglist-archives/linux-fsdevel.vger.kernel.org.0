Return-Path: <linux-fsdevel+bounces-50229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0EEAC917E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1697B55B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615A232392;
	Fri, 30 May 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtQ3nWmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AE230D0D;
	Fri, 30 May 2025 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748615133; cv=none; b=GEjitBf7U7oHu3rdA0smDelHWwbvR4Bktt7nFyhPSKs5rej4ZZarZWwWp5nyvKDZjYN1wmrUiYOMMN9pvspRkdSNGoK/+7q/OdNf81HUng5KKOnsSOyUGZ68lQIwAp8yf+X40yV/uuEgAl2D1q747IS135Hk6cgYCo3piWTyC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748615133; c=relaxed/simple;
	bh=ebhvap3uGIXeOkgxbWkbzYk5e87c3HNY7AXyqp6Ao+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBs4ukqps4LNKt0rjxmZtdxpz6mQcFFBsq2rrPrZLqPk+iDj30VXvgxPwuHed3gVghMQhRjaiegmFmv0vtJVAuXrWPERqPYwrpcR6gRzWu56XEMN2GC06nUTz2jsUhFhWK/nGugiiSwMwmt5fdfnM2FVtfZq23EOWGvDHtjP/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtQ3nWmW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748615131; x=1780151131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ebhvap3uGIXeOkgxbWkbzYk5e87c3HNY7AXyqp6Ao+U=;
  b=LtQ3nWmWCSfkemP3ezydgtAzbfGH6wJjwZ4mYhWHfS2dCgMe6ZpTrM9l
   XhvazVLOKNRtpbsYlSNaQ97Z1nE49+yAOZtoBTq+iJrm596nhtCUWB6fI
   m0XYVorD44Iju6sIbyIvUnhPxen+9Ce3vYx8NGdJaHYHz9TJUfe3AaHVe
   JuCMQGenyFWss7zp6qOMM+zRDA4Q7t52xKWjm09LsaYGBAoAmVGKKtTmE
   mBy40PxwxFFRcqFHoPZ3x+Uz5Cnf/ZH4TZ1xcxKfoy0/y7Ga9mB1XctgI
   j+hQBg3RxM1VM5UMBq9P9rxNOG210ksdBi8FYQxxmObS18/877uF7BbFN
   A==;
X-CSE-ConnectionGUID: u9/T5//HTR2dB3e6hTjr2w==
X-CSE-MsgGUID: IqVYCbdESCu/97XP+/eF1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="61336573"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="61336573"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 07:25:30 -0700
X-CSE-ConnectionGUID: ZKP7FC/5Re2B7jgQnKVX5w==
X-CSE-MsgGUID: Etq2N76sQ3mlvbSQ+wT7jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143855846"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 May 2025 07:25:24 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uL0fh-000XhK-1e;
	Fri, 30 May 2025 14:25:21 +0000
Date: Fri, 30 May 2025 22:24:41 +0800
From: kernel test robot <lkp@intel.com>
To: wangtao <tao.wangtao@honor.com>, sumit.semwal@linaro.org,
	christian.koenig@amd.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	amir73il@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	jack@suse.cz, baolin.wang@linux.alibaba.com,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bintian.wang@honor.com, yipengxiang@honor.com, liulu.liu@honor.com,
	feng.han@honor.com, wangtao <tao.wangtao@honor.com>
Subject: Re: [PATCH v3 3/4] udmabuf: Implement udmabuf rw_file callback
Message-ID: <202505302235.mDzENMSm-lkp@intel.com>
References: <20250530103941.11092-4-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530103941.11092-4-tao.wangtao@honor.com>

Hi wangtao,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on next-20250530]
[cannot apply to linus/master v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/wangtao/fs-allow-cross-FS-copy_file_range-for-memory-backed-files/20250530-184146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250530103941.11092-4-tao.wangtao%40honor.com
patch subject: [PATCH v3 3/4] udmabuf: Implement udmabuf rw_file callback
config: sparc64-randconfig-002-20250530 (https://download.01.org/0day-ci/archive/20250530/202505302235.mDzENMSm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250530/202505302235.mDzENMSm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505302235.mDzENMSm-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/dma-buf/udmabuf.c: In function 'udmabuf_rw_file':
>> drivers/dma-buf/udmabuf.c:298:25: error: storage size of 'iter' isn't known
     298 |         struct iov_iter iter;
         |                         ^~~~
>> drivers/dma-buf/udmabuf.c:299:45: error: 'ITER_SOURCE' undeclared (first use in this function)
     299 |         unsigned int direction = is_write ? ITER_SOURCE : ITER_DEST;
         |                                             ^~~~~~~~~~~
   drivers/dma-buf/udmabuf.c:299:45: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/dma-buf/udmabuf.c:299:59: error: 'ITER_DEST' undeclared (first use in this function)
     299 |         unsigned int direction = is_write ? ITER_SOURCE : ITER_DEST;
         |                                                           ^~~~~~~~~
>> drivers/dma-buf/udmabuf.c:327:17: error: implicit declaration of function 'iov_iter_bvec'; did you mean 'bvec_iter_bvec'? [-Wimplicit-function-declaration]
     327 |                 iov_iter_bvec(&iter, direction, bvec, bv_idx, bv_total);
         |                 ^~~~~~~~~~~~~
         |                 bvec_iter_bvec
>> drivers/dma-buf/udmabuf.c:298:25: warning: unused variable 'iter' [-Wunused-variable]
     298 |         struct iov_iter iter;
         |                         ^~~~


vim +298 drivers/dma-buf/udmabuf.c

   286	
   287	static ssize_t udmabuf_rw_file(struct dma_buf *dmabuf, loff_t my_pos,
   288				struct file *other, loff_t pos,
   289				size_t count, bool is_write)
   290	{
   291		struct udmabuf *ubuf = dmabuf->priv;
   292		loff_t my_end = my_pos + count, bv_beg, bv_end = 0;
   293		pgoff_t pg_idx = my_pos / PAGE_SIZE;
   294		pgoff_t pg_end = DIV_ROUND_UP(my_end, PAGE_SIZE);
   295		size_t i, bv_off, bv_len, bv_num, bv_idx = 0, bv_total = 0;
   296		struct bio_vec *bvec;
   297		struct kiocb kiocb;
 > 298		struct iov_iter iter;
 > 299		unsigned int direction = is_write ? ITER_SOURCE : ITER_DEST;
   300		ssize_t ret = 0, rw_total = 0;
   301		struct folio *folio;
   302	
   303		bv_num = min_t(size_t, pg_end - pg_idx + 1, 1024);
   304		bvec = kvcalloc(bv_num, sizeof(*bvec), GFP_KERNEL);
   305		if (!bvec)
   306			return -ENOMEM;
   307	
   308		init_sync_kiocb(&kiocb, other);
   309		kiocb.ki_pos = pos;
   310	
   311		for (i = 0; i < ubuf->nr_pinned && my_pos < my_end; i++) {
   312			folio = ubuf->pinned_folios[i];
   313			bv_beg = bv_end;
   314			bv_end += folio_size(folio);
   315			if (bv_end <= my_pos)
   316				continue;
   317	
   318			bv_len = min(bv_end, my_end) - my_pos;
   319			bv_off = my_pos - bv_beg;
   320			my_pos += bv_len;
   321			bv_total += bv_len;
   322			bvec_set_page(&bvec[bv_idx], &folio->page, bv_len, bv_off);
   323			if (++bv_idx < bv_num && my_pos < my_end)
   324				continue;
   325	
   326			/* start R/W if bvec is full or count reaches zero. */
 > 327			iov_iter_bvec(&iter, direction, bvec, bv_idx, bv_total);
   328			if (is_write)
   329				ret = other->f_op->write_iter(&kiocb, &iter);
   330			else
   331				ret = other->f_op->read_iter(&kiocb, &iter);
   332			if (ret <= 0)
   333				break;
   334			rw_total += ret;
   335			if (ret < bv_total || fatal_signal_pending(current))
   336				break;
   337	
   338			bv_idx = bv_total = 0;
   339		}
   340		kvfree(bvec);
   341	
   342		return rw_total > 0 ? rw_total : ret;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

