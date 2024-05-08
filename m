Return-Path: <linux-fsdevel+bounces-18976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFF18BF360
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 02:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425A81F254DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22C7F9;
	Wed,  8 May 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/XH1+Tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EF6380;
	Wed,  8 May 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715127240; cv=none; b=aleL/vL6RFxBQAXrnxyJwEa+o5AxWTs3UL9u26XgaV/dy/Y1jeozKy6T80BTV5R/KfdlJDEB5MHGc9LBFbZIRNRQ2HpVsM+10kE2iSklrJR1H7TQLDqJAvyNcaTDhcSmgcdZTQU+AZzAVrcnTSe53ExB2JU5GGdbWfPYeJUvWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715127240; c=relaxed/simple;
	bh=GlCEeAEgLZ6eSEO6V4RcNN3Nxo+5dphEQf9rK5qTLIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovZjz6rByjt7vzAaBECCIFpj+p/9XKWXBo5qRjvTG7LJ0PLQMorI9a9FOC3TPoodqc7MF5/bRihVoSUpGMfTp/JCQNuogampanba5M/MqjBv2XKY70Y3MY2CkpUJjW8FZj4ZD+cn9CJ63SJ9wJxzvtctyboV/4Lsmv29Egtbdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/XH1+Tl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715127239; x=1746663239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GlCEeAEgLZ6eSEO6V4RcNN3Nxo+5dphEQf9rK5qTLIo=;
  b=e/XH1+Tlh3wBPhWFZQbT3NMkhld9bJkdKhl1YwPGsBTE6XSU6ncAUfEq
   dX9vgKsxn4aJO28Aj5GdJmEphe5RFRnV6mBeD6skA19zXL12gf9yP9DD/
   ztHeWP+PN3BRnjXMx5tzPb0ZOsbSO4DeIMs2tqzQipJo/nRwHL9LKy0OW
   gPtlMDqYbN5SvTfoSOmWeece3Le5Wz0CbNRh/LmV4wyMR4cnwgpEFRAk5
   rh9WfPP/dao+SsEyFw/2GHIULwimamr1iVyuVCulkLFBwA+omliPtOCqW
   e2L4yRi4eHWJySL0KGvQzrRvHFIsqeTkiMy5nrd0iRl9rwdXxG6YK6Ulr
   Q==;
X-CSE-ConnectionGUID: LoSEYMXmQ7y5Kx2P55Lpdg==
X-CSE-MsgGUID: Ev6x+5WESRuH9/Db7dXu2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10899145"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="10899145"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 17:13:58 -0700
X-CSE-ConnectionGUID: QbTrsSMLROeDSb1g+9WU6Q==
X-CSE-MsgGUID: 5PFvarIJSgWHv72qUsT3xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="33392980"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2024 17:13:57 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4UwT-0002ly-35;
	Wed, 08 May 2024 00:13:53 +0000
Date: Wed, 8 May 2024 08:13:11 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Cc: oe-kbuild-all@lists.linux.dev, bfoster@redhat.com,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Message-ID: <202405080720.SuCCdwWG-lkp@intel.com>
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
config: i386-buildonly-randconfig-004-20240508 (https://download.01.org/0day-ci/archive/20240508/202405080720.SuCCdwWG-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080720.SuCCdwWG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080720.SuCCdwWG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/bcachefs/sb-clean.c: In function 'bch2_sb_clean_to_text':
>> fs/bcachefs/sb-clean.c:296:20: warning: comparison of distinct pointer types lacks a cast
     296 |              entry < vstruct_end(&clean->field);
         |                    ^


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

