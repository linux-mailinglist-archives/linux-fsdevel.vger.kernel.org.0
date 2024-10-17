Return-Path: <linux-fsdevel+bounces-32189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05E9A21B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB581C23771
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB01DD0DB;
	Thu, 17 Oct 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lI5Oh6J6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7A1DA0E3;
	Thu, 17 Oct 2024 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166429; cv=none; b=hLmlVWKVtk4gq3hmDpJG1co9wF/GTWEzjyztPrh4uGrLx4bX+S3Y5Zs2jg3BOSh9eW1SzKFQ/yZV7wumCguLOH3dj1dzhdA+wO0rAtK4gvuV0RYr4tCF0VlKZdbwl+m6ijrnq3g8hbYVNIu1HUQdEMtvhdGE7O3HXMoZM/3BVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166429; c=relaxed/simple;
	bh=Byl5BuzrsLEDMbFApadNHqtbjze3qn3c4G+v9EMZddk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms1HiGYarqmXMHgcUzP03388dbSwVKXxcU8zxXfZjGK3dxag5hPCJK6xjMoLhYrvdZPhWRcHnH+lbkPWh0eQSRs+O2Gvol3rf7NVpI+/hsXiTBgYZ6NV6e87UX6YUkAf/ooDGCXSCPonSXpbIgrBjAsm7zQ/hpO3TVsCrLwny34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lI5Oh6J6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729166425; x=1760702425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Byl5BuzrsLEDMbFApadNHqtbjze3qn3c4G+v9EMZddk=;
  b=lI5Oh6J6fsbwQmNS9Hj6FnAlBzg3I2VRQq0xT7piqrY1E3HP/pfmJ3SQ
   EbFKOmEVuL/w0Cjo0BvIIY3kCp/JJmQHOPlCNh421TeIxPOZ8u6FFzZcj
   5R4t7EkC2Qq56ge2MIEiIjH6D1cjosEG+JCjCm+i6r4Olmi/rlzfSENh6
   cRvlGWGsDV369vHFAD/QHEFcPcR7yWBEeyg62SU9qI4ElBQ7qTAxnSfVt
   L03RjIvtmzxn+HzeU+hF+s9h6cCAjPZ0TAbSmW+QJqGDN+PPaFtO/gz67
   mI74o/8/jcK5s77NLvlx/fhKxqJP7zjxKV1N7JpSh6pDR0lVIY7EjLI8Z
   g==;
X-CSE-ConnectionGUID: bl8ClyXTSx+o0a67AJSOBw==
X-CSE-MsgGUID: 0JmAJAomSYS6FtmhijuNOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="28853871"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="28853871"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:00:24 -0700
X-CSE-ConnectionGUID: OV+igYayRjasrtRoX/cySQ==
X-CSE-MsgGUID: +qOg4easS32xwZ0iwjns4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="79354503"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Oct 2024 05:00:21 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1PAw-000MH1-1R;
	Thu, 17 Oct 2024 12:00:18 +0000
Date: Thu, 17 Oct 2024 19:59:31 +0800
From: kernel test robot <lkp@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	rppt@kernel.org, david@redhat.com, yosryahmed@google.com,
	shakeel.butt@linux.dev, Andrii Nakryiko <andrii@kernel.org>,
	Yi Lai <yi1.lai@intel.com>
Subject: Re: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in
 build_id_parse()
Message-ID: <202410171938.aMzLRpxM-lkp@intel.com>
References: <20241016221629.1043883-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016221629.1043883-1-andrii@kernel.org>

Hi Andrii,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/lib-buildid-handle-memfd_secret-files-in-build_id_parse/20241017-061747
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
patch link:    https://lore.kernel.org/r/20241016221629.1043883-1-andrii%40kernel.org
patch subject: [PATCH v2 bpf] lib/buildid: handle memfd_secret() files in build_id_parse()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241017/202410171938.aMzLRpxM-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171938.aMzLRpxM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171938.aMzLRpxM-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/buildid.c: In function 'freader_get_folio':
>> lib/buildid.c:79:14: error: implicit declaration of function 'kernel_page_present' [-Wimplicit-function-declaration]
      79 |             !kernel_page_present(&r->folio->page) ||
         |              ^~~~~~~~~~~~~~~~~~~


vim +/kernel_page_present +79 lib/buildid.c

    58	
    59	static int freader_get_folio(struct freader *r, loff_t file_off)
    60	{
    61		/* check if we can just reuse current folio */
    62		if (r->folio && file_off >= r->folio_off &&
    63		    file_off < r->folio_off + folio_size(r->folio))
    64			return 0;
    65	
    66		freader_put_folio(r);
    67	
    68		r->folio = filemap_get_folio(r->file->f_mapping, file_off >> PAGE_SHIFT);
    69	
    70		/* if sleeping is allowed, wait for the page, if necessary */
    71		if (r->may_fault && (IS_ERR(r->folio) || !folio_test_uptodate(r->folio))) {
    72			filemap_invalidate_lock_shared(r->file->f_mapping);
    73			r->folio = read_cache_folio(r->file->f_mapping, file_off >> PAGE_SHIFT,
    74						    NULL, r->file);
    75			filemap_invalidate_unlock_shared(r->file->f_mapping);
    76		}
    77	
    78		if (IS_ERR(r->folio) ||
  > 79		    !kernel_page_present(&r->folio->page) ||
    80		    !folio_test_uptodate(r->folio)) {
    81			if (!IS_ERR(r->folio))
    82				folio_put(r->folio);
    83			r->folio = NULL;
    84			return -EFAULT;
    85		}
    86	
    87		r->folio_off = folio_pos(r->folio);
    88		r->addr = kmap_local_folio(r->folio, 0);
    89	
    90		return 0;
    91	}
    92	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

