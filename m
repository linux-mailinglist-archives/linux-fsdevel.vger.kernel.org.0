Return-Path: <linux-fsdevel+bounces-19529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD29E8C672E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601952853EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AAE12DDB2;
	Wed, 15 May 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbkPu31u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33612A152;
	Wed, 15 May 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715779009; cv=none; b=M90qNKCY2Z+D4bfJAuZ3SR/IGdLp2FRYjHsAqt6E5sfAzOPeqMl75Bf4BAlRYDVVrGb4lgpC1r4DptrQ/fEYOVr6AcgN1dF6uP+8VtB9XOXdYiPOUjUwUOHxMNIQb4TO9esY0dF6YzvmRq1gcC+7mgR6Qrmm37MNZbH584I62ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715779009; c=relaxed/simple;
	bh=jMhlWzNhuWJKy8fzidVruX5LiboG9ljLfiOfmMGNW9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjdq3oVLVO0khZS5d2wD+BhgDEzlWDYIpepTUIIazwy77ssgWPmR1PihUA7Os2qpzDV9uI2q1McwmlWWj8jeHupAWnhAysqvvqu85c6dJxdxvlLUsI+qLbmtOcOAu2cJPDQ8g0mpCCJGeayRRrPKAsom0n68zihYq0mqRsHdjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbkPu31u; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715779008; x=1747315008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jMhlWzNhuWJKy8fzidVruX5LiboG9ljLfiOfmMGNW9o=;
  b=PbkPu31up8LYd8fSPkEEToRlvvApe+5NuF62husn7ioR+PQtr3rqPg5M
   b5WqOA4kOhBFzLu3EhfrB5wkHyHvjNv4UoTS6PscghDUH2qxIBtVPqDnY
   JgGRzO29CWEd77+UeyaxO1qwCIzgf00DFLj27nAveITL9lqqeClBKfHzC
   UKtgZR9uicR3RBg1YLdauxgSpe6e7rjQ7CqH2bOMbkeu1NWwAxJcW0pev
   /307pFpfEbocK6e8mJ+WgS1uwoHDTohWMbpQTHvN9Xh4BRcEpz3kUUjAz
   yZ8YvoCYzNmjU5hjALQLntdi5nEBfYqPOiW6GQpemRV3det4fb/eQFr+h
   A==;
X-CSE-ConnectionGUID: zCJxf0T4T9yteD5Yxkj6Sw==
X-CSE-MsgGUID: 226AZxL6R/m+jP5czk7+xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29347548"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="29347548"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 06:16:47 -0700
X-CSE-ConnectionGUID: rLT/UV/nSlqClPWcxeTibw==
X-CSE-MsgGUID: 5LUJzXDmS1u/aG4xBIPx2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31179418"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 15 May 2024 06:16:44 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7EUq-000Cqm-2e;
	Wed, 15 May 2024 13:16:40 +0000
Date: Wed, 15 May 2024 21:16:23 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 1/3] iomap: pass blocksize to iomap_truncate_page()
Message-ID: <202405152010.jZ3OhPim-lkp@intel.com>
References: <20240515022829.2455554-2-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515022829.2455554-2-yi.zhang@huaweicloud.com>

Hi Zhang,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v6.9 next-20240515]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/iomap-pass-blocksize-to-iomap_truncate_page/20240515-104121
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20240515022829.2455554-2-yi.zhang%40huaweicloud.com
patch subject: [PATCH 1/3] iomap: pass blocksize to iomap_truncate_page()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20240515/202405152010.jZ3OhPim-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405152010.jZ3OhPim-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405152010.jZ3OhPim-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: fs/iomap/buffered-io.o: in function `iomap_truncate_page':
>> buffered-io.c:(.text+0x4398): undefined reference to `__moddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

