Return-Path: <linux-fsdevel+bounces-54766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2DAB02CF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AC54A5093
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 20:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB1226D14;
	Sat, 12 Jul 2025 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVeS4Pdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C9226533
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Jul 2025 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353547; cv=none; b=fSZ/Yp7xUq14KFIQ0gAlrcq4YdiIqDsbkb/AHWolS+m3Snnwtdaf7RbJmzDHb5kS3XUUM/PPOKakkil6q2qzem6BQsHKxxujAANIStFxT9vhwsIKnH6YwkpK4xX8K3mRPrf6LXCunVb+8cG3VIM+TLsqxQ7ctN/UySWsItZv4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353547; c=relaxed/simple;
	bh=el3QB5FzgTGqMoLQ2O4Y0t2EM+WD4U0n+5F7KR57zzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trKnreJX5O1YNYdx2NEb+3NmlyJd5kDv+qxO0HZWWwl4wl7F+YsN0lA2jmKcxSOvyeZfwmd+ZZ3PgNseW3noUBwQiPZuZ3MMdMdePBM6SYtea182CLPLz0yzylZjLbPPNHtjMp9OZvkQX/jKb7BL9vt3w2VCZHHYRu29IXs1GZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVeS4Pdo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752353545; x=1783889545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=el3QB5FzgTGqMoLQ2O4Y0t2EM+WD4U0n+5F7KR57zzo=;
  b=EVeS4PdoNOHXYVfFoL+fIwMThH9lf9wOK+DGmdhNO6umDW+lDUfCXwxg
   gjFkhpvN/GJpLqUpH4uNXCcu2lq5IMiNlNzupIjmWeB0AdAv+G3oaMIn+
   uF3CeF2WXGZI+OBsov1yXSeF7J6Nw2g2jeWz+KvkMygY3espKsM1k8sdl
   H2U6N935bJ+BhPgpz8J3xKX6dgw1iu/GWw0OnkgcFTMp0nr6n5Vjmfypw
   ktFnWA8zqaG3HQGlFtlrcKNqMwsCEqKnORnF+qoL9vGOXz7ukf6xUZLSv
   VJQadP7QTmZljcV8k4gGHbsYSclg2+1BqwCHyvzDECxaZCX0jRQ9xxygb
   Q==;
X-CSE-ConnectionGUID: u6n9WbnLQ22inMHT2tIcaA==
X-CSE-MsgGUID: FXpLLQWyS4eRSLVZPJFgzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77146230"
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="77146230"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2025 13:52:25 -0700
X-CSE-ConnectionGUID: vfJ3frt3QBKZa7aN3nZkDQ==
X-CSE-MsgGUID: /IL16pcTTPe0heuf+KGUqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,307,1744095600"; 
   d="scan'208";a="156425241"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 12 Jul 2025 13:52:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uahCm-0007gB-18;
	Sat, 12 Jul 2025 20:52:20 +0000
Date: Sun, 13 Jul 2025 04:51:40 +0800
From: kernel test robot <lkp@intel.com>
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jack@suse.cz,
	amir73il@gmail.com, josef@toxicpanda.com, lesha@meta.com,
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v4 3/3] fanotify: introduce event response identifier
Message-ID: <202507130418.Prp26RtQ-lkp@intel.com>
References: <20250711183101.4074140-4-ibrahimjirdeh@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711183101.4074140-4-ibrahimjirdeh@meta.com>

Hi Ibrahim,

kernel test robot noticed the following build errors:

[auto build test ERROR on jack-fs/fsnotify]
[also build test ERROR on linus/master v6.16-rc5 next-20250711]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ibrahim-Jirdeh/fanotify-add-support-for-a-variable-length-permission-event/20250712-023425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
patch link:    https://lore.kernel.org/r/20250711183101.4074140-4-ibrahimjirdeh%40meta.com
patch subject: [PATCH v4 3/3] fanotify: introduce event response identifier
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20250713/202507130418.Prp26RtQ-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250713/202507130418.Prp26RtQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507130418.Prp26RtQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/notify/fdinfo.c:17:
>> fs/notify/fanotify/fanotify.h:566:6: error: no member named 'fanotify_data' in 'struct fsnotify_group'
     566 |         if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fanotify.h:9:12: note: expanded from macro 'FAN_GROUP_FLAG'
       9 |         ((group)->fanotify_data.flags & (flag))
         |          ~~~~~~~  ^
   1 error generated.


vim +566 fs/notify/fanotify/fanotify.h

   562	
   563	static inline bool fanotify_is_valid_response_id(struct fsnotify_group *group,
   564							 int id)
   565	{
 > 566		if (FAN_GROUP_FLAG(group, FAN_REPORT_RESPONSE_ID))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

