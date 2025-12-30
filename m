Return-Path: <linux-fsdevel+bounces-72244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2C8CE9A37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 13:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97DD03021E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8062EBB90;
	Tue, 30 Dec 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKRZA9my"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE082EB878;
	Tue, 30 Dec 2025 12:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767097277; cv=none; b=rDmlyxJcw2iO8dnAywqlhdAryVe252mHHrd+WglzeSmfmZSSnYJACyPTzzTOYxVHSsFTbOdvN2oyfxYIKpmwkfD5MA/OyLGKa3zkApT+4yUmUBvIHmJnblk8zr2eScEOXvP4CkP5/pqIZUYZ+/NEtk/IrKQBTP8hxfcXYnKsrfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767097277; c=relaxed/simple;
	bh=mstXLffsJ1oHsqOvr7iJnraIqZ3vkCFNBne5tuhUZg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtN0sBAb26dNx2NlUrRa/HDGjoioAGFaXUQuGgfD/hgU41oAvDHLf/e2gUBMRBei/gbTrXYaOiGUN6eOU/MZj1809BI8qrTWwJOlPqx8gBTolqa45ba2dl89nDeZY+V40QO2Kiq62UQn0eDMIdmX6q2CQkRTuQi5JtLZisDa6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKRZA9my; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767097275; x=1798633275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mstXLffsJ1oHsqOvr7iJnraIqZ3vkCFNBne5tuhUZg4=;
  b=VKRZA9myszepEEiLL36S6JteyyYWPF9j4V2AL/fqCIUJAv0oHA4i1xlf
   4LmsnxK6GTa3BsP42bpmchzLn9T6fV10rHCCGctlx9dxRsFvJbzTRL1A/
   SzKkmlBzHde5VFBFXYMCgjjlPoCcgCMWRaY4/evgbbY+kXdRg0XFQEKvG
   7a1u83V/8b44OqkUUGYt4zwFLKMLUE5QeLTJt7aEQbrofDW0xUY6mjv+O
   RjyKtrNXysw5qNiDP41p8I46jdOj6oTtTcIF8JvYHmpOM5SHMTyAie70X
   smcASvibZhBhg1ofeG/xcqHxwH2yc2La+AD8kYQ+Uv6L2CWctSFq2aOFr
   g==;
X-CSE-ConnectionGUID: EVQYldJsR8mTIxBqxS+jLg==
X-CSE-MsgGUID: IV02PskXSSqUaBV6Z5PQGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="80057185"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="80057185"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 04:21:14 -0800
X-CSE-ConnectionGUID: quN0PFyiTv2tTZNMejTz6Q==
X-CSE-MsgGUID: FFdZ94HRR3K7lHw4iR8taA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="201463271"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 30 Dec 2025 04:21:13 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vaYis-000000007wa-3KfD;
	Tue, 30 Dec 2025 12:21:10 +0000
Date: Tue, 30 Dec 2025 13:20:51 +0100
From: kernel test robot <lkp@intel.com>
To: Yuto Ohnuki <ytohnuki@amazon.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH] fs: remove stale and duplicate forward declarations
Message-ID: <202512301303.s7YWTZHA-lkp@intel.com>
References: <20251229071401.98146-1-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229071401.98146-1-ytohnuki@amazon.com>

Hi Yuto,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.19-rc3 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuto-Ohnuki/fs-remove-stale-and-duplicate-forward-declarations/20251229-151612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251229071401.98146-1-ytohnuki%40amazon.com
patch subject: [PATCH] fs: remove stale and duplicate forward declarations
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20251230/202512301303.s7YWTZHA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251230/202512301303.s7YWTZHA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512301303.s7YWTZHA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> clang diag: include/linux/blkdev.h:1656:41: warning: declaration of 'struct hd_geometry' will not be visible outside of this function [-Wvisibility]
--
   In file included from rust/helpers/helpers.c:16:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
>> include/linux/blkdev.h:1656:41: warning: declaration of 'struct hd_geometry' will not be visible outside of this function [-Wvisibility]
    1656 |         int (*getgeo)(struct gendisk *, struct hd_geometry *);
         |                                                ^
   1 warning generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

