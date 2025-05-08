Return-Path: <linux-fsdevel+bounces-48440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB45AAF21C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 06:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8EB98260A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 04:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAFF20C001;
	Thu,  8 May 2025 04:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aybba2EK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D415A858;
	Thu,  8 May 2025 04:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746678647; cv=none; b=G63HwzjClq9o9qz0h/kqpkShtOX067VNakWZvaYgvViPXSH3UFqezjC1fSzCnch1NJfxwifLesO6DCfPwlWdI/ug5BKFuwwrcAkR91zYE+0CEAjOl2GLmY5GP3xzdnkvXysdT3Hg86UCVL7lBYdbjKNZr7STW4aeQQlJOs17lxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746678647; c=relaxed/simple;
	bh=R3lZPq8jE1TfODDLc9DGRZGgvVALUs6gab1xXc8C0LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=in1SX2Bjc4A2ebTWxkcabb91psevjmmqCiEp8NEiMDj6SNFypmfChH0M25TzQaPxzVb9IyUlBf08X1gyBhFrKKtidtviVXngL9qXlA3+ASXkJFTUsz5zSa5k5fD3OZl1GZnS1I+xYBajkjlQrVTcVS6227aJEfeIJ3YIlEbSmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aybba2EK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746678646; x=1778214646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R3lZPq8jE1TfODDLc9DGRZGgvVALUs6gab1xXc8C0LY=;
  b=Aybba2EKnty+KLPABO17ThiLSv2/QgJ+gfv7RVWum8GXqDgGM5YOe3yn
   T2ymu4NA0MIjs+Ru5tnuLDZS4tjlQ9gUPXHcpH2Mx9MLDdUvl1lTBI2mZ
   96YvEQ+UdAorn6W0OUvwmngzAk5XLupBC4KAPXglbDFnHtpcrYSWYie68
   i+o4WkkcZNTVAMZufF215lvJzJkT6sLDJ9d//27nxWTIoGplm04BTYaP6
   ccMfieEkZFD4jbCpaCqbucN2rtJNAR444UCIpKBkE8l4HDQzNjE5xHrXf
   aiOf9hXafgGYkoW9QS/y5ASdPMfpYEHgN6dMlNnpZbdN0G+WjNPDQaBG/
   g==;
X-CSE-ConnectionGUID: FUqSlr9AQJmp4p77LM7VZA==
X-CSE-MsgGUID: uZaE8ZnHTlaBGsggryripg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48550265"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48550265"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 21:30:45 -0700
X-CSE-ConnectionGUID: Va7iEmHhSoCglHAPudVm/g==
X-CSE-MsgGUID: Kkd+uZjLRWCCCIPj+DQSDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="136105721"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 May 2025 21:30:43 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCsu8-000A3j-1d;
	Thu, 08 May 2025 04:30:40 +0000
Date: Thu, 8 May 2025 12:30:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] fanotify: Avoid a couple of
 -Wflex-array-member-not-at-end warnings
Message-ID: <202505081249.CUDWsu7Z-lkp@intel.com>
References: <aBqdlxlBtb9s7ydc@kspp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBqdlxlBtb9s7ydc@kspp>

Hi Gustavo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jack-fs/fsnotify]
[also build test WARNING on linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-A-R-Silva/fanotify-Avoid-a-couple-of-Wflex-array-member-not-at-end-warnings/20250507-074110
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/aBqdlxlBtb9s7ydc%40kspp
patch subject: [PATCH][next] fanotify: Avoid a couple of -Wflex-array-member-not-at-end warnings
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20250508/202505081249.CUDWsu7Z-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081249.CUDWsu7Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081249.CUDWsu7Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/notify/fdinfo.c:17:
>> fs/notify/fanotify/fanotify.h:280:16: warning: alignment 1 of 'union <anonymous>' is less than 4 [-Wpacked-not-aligned]
     280 |         struct fanotify_fh name;                                                      \
         |                ^~~~~~~~~~~
   fs/notify/fanotify/fanotify.h:287:9: note: in expansion of macro 'FANOTIFY_INLINE_FH'
     287 |         FANOTIFY_INLINE_FH(object_fh, FANOTIFY_INLINE_FH_LEN);
         |         ^~~~~~~~~~~~~~~~~~
>> fs/notify/fanotify/fanotify.h:280:16: warning: alignment 1 of 'union <anonymous>' is less than 4 [-Wpacked-not-aligned]
     280 |         struct fanotify_fh name;                                                      \
         |                ^~~~~~~~~~~
   fs/notify/fanotify/fanotify.h:315:9: note: in expansion of macro 'FANOTIFY_INLINE_FH'
     315 |         FANOTIFY_INLINE_FH(object_fh, MAX_HANDLE_SZ);
         |         ^~~~~~~~~~~~~~~~~~


vim +280 fs/notify/fanotify/fanotify.h

b8a6c3a2f0ae4d Amir Goldstein          2020-07-08  275  
2c5069433a3adc Gabriel Krisman Bertazi 2021-10-25  276  #define FANOTIFY_INLINE_FH(name, size)						      \
e3725b8a2ecdf6 Gustavo A. R. Silva     2025-05-06  277  union {										      \
e3725b8a2ecdf6 Gustavo A. R. Silva     2025-05-06  278  	/* Space for object_fh and object_fh.buf[] - access with fanotify_fh_buf() */ \
e3725b8a2ecdf6 Gustavo A. R. Silva     2025-05-06  279  	unsigned char _inline_fh_buf[struct_size_t(struct fanotify_fh, buf, size)];   \
1758cd2e95d31b Alexey Dobriyan         2023-10-10 @280  	struct fanotify_fh name;						      \
e3725b8a2ecdf6 Gustavo A. R. Silva     2025-05-06  281  } __packed
2c5069433a3adc Gabriel Krisman Bertazi 2021-10-25  282  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

