Return-Path: <linux-fsdevel+bounces-18972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18988BF2CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 01:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579AF1F21C88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED02712AADE;
	Tue,  7 May 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2FCgb7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D21A2C07;
	Tue,  7 May 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123999; cv=none; b=AamDgmrvgXQQbW10ixN+gh+Ftb4hhEnIm9ACBJ55HWGy8To9OtlpM05jerRD0MdfUAmbV5p97fzgpja60BAtQnaAqyldMhA8Px7Cjwdws7h6K5Il6ROvT/+jq5VYJDCHH/AF2A+VxxLocPGaiPdQGfKxqJIDZR+IVbVRQUKotf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123999; c=relaxed/simple;
	bh=sEP4iPDmsyjWyHJeI1603Nv4qXSA4IMf9J0xJfpEL7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib1MTDZF6IrVEewrFPqYjZOWA2t8Akij8LBAcx12f9q2XMFMW5aY5hXutkLq9kQOVJO5wBgKDjbXZiWlwEHM+ydVW7E4rmX6tVFP/nLKbz4WKRr20QwbG8fPp3S/9qTSlcvp1KG98/gQggPwYbl/kFwhKLUZU4SdQwZuKWfEelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2FCgb7a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715123998; x=1746659998;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sEP4iPDmsyjWyHJeI1603Nv4qXSA4IMf9J0xJfpEL7k=;
  b=V2FCgb7afdzL8lX1CIcx+WfsecRePo6gHYmdVqr3YEwe8p8ujSrMlLyq
   CG9su5K61m5ohzoyhlQkHs8hJ0xZEKpHcUBMDF0Q+OfwemV/VsFZMOp2+
   ie332dnCN2RTxr1H3FmT0P4MoZp+J9oNrSLViLyH86gGBohYLDHOQZmaK
   yRAh9nHoTuFx3DAYgMaJoMvVndqRiq6zJSRw4lFf4XcYCLLB9iwtiG95T
   7unccrIsgK6g0uGUnLBeieAqpJVUlyijHBbPKpWWeMUThCKpLUptqGmEe
   vhkyr8aHhdS1K0GLRNp3N0lMbTi9Nd+tqpbkd2fDyquKw1rZw5yFVYGX5
   w==;
X-CSE-ConnectionGUID: bKrLbyhzRiSArKinGzKxHA==
X-CSE-MsgGUID: EhWtermERoK/1zSikXy1ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14744903"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="14744903"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 16:19:57 -0700
X-CSE-ConnectionGUID: RWIp3qdYRNKzT7LA61w6Rw==
X-CSE-MsgGUID: tLv2w/CVRwqH9LW0lz7DaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="51886530"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 May 2024 16:19:54 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4U6C-0002jk-1t;
	Tue, 07 May 2024 23:19:52 +0000
Date: Wed, 8 May 2024 07:18:58 +0800
From: kernel test robot <lkp@intel.com>
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+c48865e11e7e893ec4ab@syzkaller.appspotmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bfoster@redhat.com,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] bcachefs: fix oob in bch2_sb_clean_to_text
Message-ID: <202405080718.ZRZVFchD-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20240508 (https://download.01.org/0day-ci/archive/20240508/202405080718.ZRZVFchD-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240508/202405080718.ZRZVFchD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405080718.ZRZVFchD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/bcachefs/sb-clean.c:296:13: warning: comparison of distinct pointer types ('struct jset_entry *' and 'void *') [-Wcompare-distinct-pointer-types]
     296 |              entry < vstruct_end(&clean->field);
         |              ~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


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

