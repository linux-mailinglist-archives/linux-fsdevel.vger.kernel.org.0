Return-Path: <linux-fsdevel+bounces-18982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D88BF3EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 03:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7558285DA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C95ECC;
	Wed,  8 May 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4iNpoPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BE633;
	Wed,  8 May 2024 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715130425; cv=none; b=UGzW6P5wqFnw0slufOd3AoOmeMZpqz0hls6Hv8pWXLiPImnsLweslXFneHpGVU7yFv+/+4VoWV3ZadhYfBikzv5vcRg4ZguXGCM953W6P4kFRymVGJsSd6vE/vkFULHxvedZwFOB9Dotbv4iwySyOej3Cf9o7csC6uP6NWnaNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715130425; c=relaxed/simple;
	bh=p5WCLuKt+jPVh7GPjljN8xrAfP7mBESc4n8DNvE7TsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjMc92ZCAFKhB6Q2+TSnouVaF3JHwJGmaIXpK/ifmN+5aadpYafl3eRLSff7or2YmEAXBmCrxbfZebiWaW27eNI8ZAlLA3r+UMMVN0YFMpr+8It9Yw/F04q3ESGv5FSP50hnDpLZUDmcu815c4oh0t+5i4HyVbr9aMm2hQrucaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4iNpoPA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715130424; x=1746666424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5WCLuKt+jPVh7GPjljN8xrAfP7mBESc4n8DNvE7TsE=;
  b=m4iNpoPAaalKd7tYmAcFwwshLwlgo7luEGV0xvBFHvTbDHe14WWHg1lN
   giNKH8J10J9d8Wl63Y/lZydvmlQFHYG1Xj28ty+MKXL/YY7SBAdt5Hhz4
   lqVIIMBIyqpU9hju49QyY6u5OzBzOrTIahT3lqmlUkxFQrxj5/eidKpkZ
   REPWnSVCoGgA2fr2rp3xekM1CY4IDJ7XMuhR6kZ45EaqTzLeiZgMcHaQZ
   55GAS4WEKDOjDNkrbyNQmDy1ANsoQjQGHX1oM5H+FT2a+PwrmmbDaOrgs
   xuq34Qps+iD3EFsdF+HyulMy/ZSDVQjscCbr1UGbS7tHSqkM9CtDnQs5h
   A==;
X-CSE-ConnectionGUID: 5KWel6vPQOCJF8VZKeA5Jg==
X-CSE-MsgGUID: 9FQXmNVmR3iU1bH8GmM25Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21523941"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="21523941"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 18:07:04 -0700
X-CSE-ConnectionGUID: 4YELYJD7TpSSD3sntn6oOw==
X-CSE-MsgGUID: Ynp4SyJyRGmdjsXeKRFF/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28579669"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 May 2024 18:06:58 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4Vlm-0002nk-3C;
	Wed, 08 May 2024 01:06:55 +0000
Date: Wed, 8 May 2024 09:06:24 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, bfoster@redhat.com,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Message-ID: <202405080823.um76blCH-lkp@intel.com>
References: <tencent_816D842DE96C309554E8E2ED9ACC6078120A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_816D842DE96C309554E8E2ED9ACC6078120A@qq.com>

Hi Edward,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9-rc7 next-20240507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Edward-Adam-Davis/bcachefs-fix-oob-in-bch2_sb_clean_to_text/20240507-172635
base:   linus/master
patch link:    https://lore.kernel.org/r/tencent_816D842DE96C309554E8E2ED9ACC6078120A%40qq.com
patch subject: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
config: x86_64-randconfig-121-20240508 (https://download.01.org/0day-ci/archive/20240508/202405080823.um76blCH-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080823.um76blCH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080823.um76blCH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/bcachefs/sb-clean.c: note: in included file:
   fs/bcachefs/bcachefs.h:1027:9: sparse: sparse: array of flexible structures
   fs/bcachefs/sb-clean.c: note: in included file (through fs/bcachefs/bcachefs.h):
   fs/bcachefs/bcachefs_format.h:794:38: sparse: sparse: array of flexible structures
   fs/bcachefs/bcachefs_format.h:1453:38: sparse: sparse: array of flexible structures
>> fs/bcachefs/sb-clean.c:296:20: sparse: sparse: incompatible types in comparison expression (different base types):
   fs/bcachefs/sb-clean.c:296:20: sparse:    struct jset_entry *
   fs/bcachefs/sb-clean.c:296:20: sparse:    void *

vim +296 fs/bcachefs/sb-clean.c

   283	
   284	static void bch2_sb_clean_to_text(struct printbuf *out, struct bch_sb *sb,
   285					  struct bch_sb_field *f)
   286	{
   287		struct bch_sb_field_clean *clean = field_to_type(f, clean);
   288		struct jset_entry *entry;
   289	
   290		prt_printf(out, "flags:          %x",	le32_to_cpu(clean->flags));
   291		prt_newline(out);
   292		prt_printf(out, "journal_seq:    %llu",	le64_to_cpu(clean->journal_seq));
   293		prt_newline(out);
   294	
   295		for (entry = clean->start;
 > 296		     entry < vstruct_end(&clean->field);
   297		     entry = vstruct_next(entry)) {
   298			if (entry->type == BCH_JSET_ENTRY_btree_keys &&
   299			    !entry->u64s)
   300				continue;
   301	
   302			bch2_journal_entry_to_text(out, NULL, entry);
   303			prt_newline(out);
   304		}
   305	}
   306	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

