Return-Path: <linux-fsdevel+bounces-54639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D9B01C5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF131C2823A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AF12C3255;
	Fri, 11 Jul 2025 12:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuphRwMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE32C1594
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 12:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238113; cv=none; b=pOjuuNLZgDHgH5hZHZJW/q8WgEZ5K/cowW3Ohvp7QOsuudeHBlpF4qWL2U1rvVtwg9UyoSh8Zy6tTWZznZLmRzCEbURlgdfv+yK7OPv6KzwjTjS7bcMP+yEHllmxUF6Qc7C6bkVo+F3niECGNDJaOORHcb4bkZUgVaZF8l+TY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238113; c=relaxed/simple;
	bh=S7S78l4v222Q4IGIJjEUnEsZH89aUnWzpOVZ4kXzKvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+vCTr+e1VGykJeCwETjdn17GcRRFdCjQ6+mB1QJIMRm/gebuLyVugZuz/taNOhcJSD2CgeSAT4NcgYveOL3UcD2pNnOntSS3zfK7luYhdjbmJ9vzaIGsfndH1NVTbnyWJgVabxL79ao/TWDusl1heKvZ9gZBvzsMN52K30+mhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuphRwMD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752238111; x=1783774111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S7S78l4v222Q4IGIJjEUnEsZH89aUnWzpOVZ4kXzKvs=;
  b=cuphRwMD4Jx3TA0HuxCVHAkEKJzv9PfBlkx3nUVAsDkbx4Qkqi+K7yzW
   pmtZ4GHsjfolcEy5Ocbf1Y3feEoFkh86DYNWCawEN8xKJLVsdelDbeXjZ
   oXtVsD/P0P/pV5kFRB1ILxsc7ul2raWGb9fIvuMm4sCxXa7+3oBxiuFLh
   Vr4nFa0yEhERtSaavdJgXY1fdcM+frZYTYKBFC4NsavbM3D+DMXN8hyhJ
   dkMYQE3jkOv0zXTwgko4s9HL2aET1ntlPpX7b/O2Y3aNjiQjiVB9I+9eI
   RleJDnfMFh0ou6/zxeYq0Kb2g6zG0+xhrXUr/O5AlB4By31wQRgnIuoa8
   A==;
X-CSE-ConnectionGUID: XaBJvX/QSwSdguTNKi95wg==
X-CSE-MsgGUID: vI4037NwSECT+N+S6iIPVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54664526"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="54664526"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 05:48:30 -0700
X-CSE-ConnectionGUID: u+4H4nOUQ2uflIFrEbnxjQ==
X-CSE-MsgGUID: 95GDk8pzTUSSAk2fohjHkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156922090"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jul 2025 05:48:28 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uaDAw-0006MB-2L;
	Fri, 11 Jul 2025 12:48:26 +0000
Date: Fri, 11 Jul 2025 20:47:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: oe-kbuild-all@lists.linux.dev, jack@suse.cz, amir73il@gmail.com,
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org,
	sargun@meta.com
Subject: Re: [PATCH v3 3/3] fanotify: introduce event response identifier
Message-ID: <202507112012.xU84okDN-lkp@intel.com>
References: <20250711023604.593885-4-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711023604.593885-4-ibrahimjirdeh@meta.com>

Hi Ibrahim,

kernel test robot noticed the following build errors:

[auto build test ERROR on jack-fs/fsnotify]
[also build test ERROR on linus/master v6.16-rc5 next-20250711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ibrahim-Jirdeh/fanotify-add-support-for-a-variable-length-permission-event/20250711-103820
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/20250711023604.593885-4-ibrahimjirdeh%40meta.com
patch subject: [PATCH v3 3/3] fanotify: introduce event response identifier
config: csky-randconfig-002-20250711 (https://download.01.org/0day-ci/archive/20250711/202507112012.xU84okDN-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250711/202507112012.xU84okDN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507112012.xU84okDN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/notify/fdinfo.c:8:
   fs/notify/fanotify/fanotify.h: In function 'fanotify_is_valid_response_id':
>> include/linux/fanotify.h:9:19: error: 'struct fsnotify_group' has no member named 'fanotify_data'; did you mean 'inotify_data'?
       9 |         ((group)->fanotify_data.flags & (flag))
         |                   ^~~~~~~~~~~~~
   fs/notify/fanotify/fanotify.h:566:13: note: in expansion of macro 'FAN_GROUP_FLAG'
     566 |         if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
         |             ^~~~~~~~~~~~~~


vim +9 include/linux/fanotify.h

ff0b16a9850e8a Eric Paris     2009-12-17   7  
96a71f21ef1fcc Amir Goldstein 2018-09-21   8  #define FAN_GROUP_FLAG(group, flag) \
96a71f21ef1fcc Amir Goldstein 2018-09-21  @9  	((group)->fanotify_data.flags & (flag))
96a71f21ef1fcc Amir Goldstein 2018-09-21  10  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

