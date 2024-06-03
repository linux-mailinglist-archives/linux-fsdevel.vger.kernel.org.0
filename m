Return-Path: <linux-fsdevel+bounces-20777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCE08D7AB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 06:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7825E1C2142C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694CE18E02;
	Mon,  3 Jun 2024 04:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MectnGOu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E9410F1;
	Mon,  3 Jun 2024 04:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388227; cv=none; b=thHL6FB88YXmbhfOYaa0eIMIj5GjFHjnhOjQ68qs3jnYrAQ4Fi1/uwlPhC6IGXMO2N0n2M8fwTfpGPkUwc6qw9xUWzScacYw87jW1NV3GX1u+S+931XGZDA/ENlUCmLhtmDM7bkvV1JGnvA0xJE1n5xRXqFISrtscAjkoFhUcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388227; c=relaxed/simple;
	bh=O/4sSGwgaQocie1Gnbe9oYv7EOtmCu7aDVA49dj2VnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ikkpkz72CYpbgDpwDnpIpp/yEdsCCKYmxrCntsCK/1Vnz1odSpxXRt1cxXwElpkgwhTTPl51wfgg1HON8xihwZJM6ylWfJ9H1omVfyHvvHIDupT4BOiOZrurNsOjblPOJL9l0KnNK1ybwBZPwQyM2JkIM4MTouSveCrHRBFjhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MectnGOu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717388226; x=1748924226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O/4sSGwgaQocie1Gnbe9oYv7EOtmCu7aDVA49dj2VnY=;
  b=MectnGOuOuP43Nudt9Y410Ktn389jI8Bk5IvrLWDQ1iitAGlN9lS40xN
   bA6PHs4yQEiFDHyg3rZESvcfPCLDIBrJkUmHhF1w/Qbs5JqFZdVv50eyl
   fM2rcfQI4Cah5T2FHhoiFeIAUz5Uj+mIUDk5GEzIZk6YkZtazoWXMp5Lx
   QgarzouDSQiwU8gjvq3aVIjzbAmg/lJ0l3ZoliIrnseK6RwcMeM6otPk3
   Pqdx/++Vc4pYypMW73W4l2fuI722AyF87nS3N0COIiw4gNVMEyHZVZrum
   m6n8DFQTUaQ92Z/O2zdMfeuutG0oa8/KJopdHPbGOLuOFVlvdew4nWjka
   Q==;
X-CSE-ConnectionGUID: ICMM4HzzST+vDyXkiK0e4Q==
X-CSE-MsgGUID: KkTh86vFR++LeUZ8fdqKaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="39269412"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="39269412"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 21:17:05 -0700
X-CSE-ConnectionGUID: 6f6rtPN+RLOh83WH3GdKzA==
X-CSE-MsgGUID: Cjbm2nWZT6KdWLY6C9xA1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="41839561"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 02 Jun 2024 21:17:02 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDz7z-000L0z-21;
	Mon, 03 Jun 2024 04:16:59 +0000
Date: Mon, 3 Jun 2024 12:16:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Kent Overstreet <kent.overstreet@linux.dev>, brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/5] fs: sys_ringbuffer
Message-ID: <202406031142.Xw5hn2Ks-lkp@intel.com>
References: <20240603003306.2030491-4-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603003306.2030491-4-kent.overstreet@linux.dev>

Hi Kent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on linus/master v6.10-rc2]
[cannot apply to akpm-mm/mm-nonmm-unstable tip/x86/asm akpm-mm/mm-everything next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kent-Overstreet/darray-lift-from-bcachefs/20240603-083536
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240603003306.2030491-4-kent.overstreet%40linux.dev
patch subject: [PATCH 3/5] fs: sys_ringbuffer
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240603/202406031142.Xw5hn2Ks-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406031142.Xw5hn2Ks-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406031142.Xw5hn2Ks-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> <stdin>:1603:2: warning: syscall ringbuffer not implemented [-W#warnings]
    1603 | #warning syscall ringbuffer not implemented
         |  ^
>> <stdin>:1606:2: warning: syscall ringbuffer_wait not implemented [-W#warnings]
    1606 | #warning syscall ringbuffer_wait not implemented
         |  ^
>> <stdin>:1609:2: warning: syscall ringbuffer_wakeup not implemented [-W#warnings]
    1609 | #warning syscall ringbuffer_wakeup not implemented
         |  ^
   3 warnings generated.
--
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
>> <stdin>:1603:2: warning: syscall ringbuffer not implemented [-W#warnings]
    1603 | #warning syscall ringbuffer not implemented
         |  ^
>> <stdin>:1606:2: warning: syscall ringbuffer_wait not implemented [-W#warnings]
    1606 | #warning syscall ringbuffer_wait not implemented
         |  ^
>> <stdin>:1609:2: warning: syscall ringbuffer_wakeup not implemented [-W#warnings]
    1609 | #warning syscall ringbuffer_wakeup not implemented
         |  ^
   3 warnings generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

