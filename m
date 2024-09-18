Return-Path: <linux-fsdevel+bounces-29672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E35797C0BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 22:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E08D1F21FB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 20:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CD1CA6B9;
	Wed, 18 Sep 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOFxpgC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5E1C9DFF;
	Wed, 18 Sep 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726691458; cv=none; b=ffqlPfgqKH/aKNeKRg4xpV/JoVyR6fgmJlQm4+XGkjl7AdpkEOePwkYZaZEgqtlupwRmcpmyIOPn4QPg/eso2oZUYQ9j2GsLN+/e9b3gSkgmoMRv04V8DICZDSSzuMBnwrKugb1BiRdO6Cs05Kxqk1pVaM/EQNEvnxOot3ZhXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726691458; c=relaxed/simple;
	bh=v8crAcUcgAosNzF9JtGxdHujIVkHQ2sPvfBZI7YKIEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3v5igz+rwJs4/v8POXCxrQY72SYVZ1fI/egGm63e62HAMG5dZEwS3EmLOyGLOsyGQ0FVRK5X4B83z+68lYGBee0kyDikgyGzmHqAq02znS4Dz2Wrfup0bdFQVJtP/vLkxCL7T2skw8u2w11RAvSRnLZnoF64Tp1UVOuE3dptSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOFxpgC/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726691456; x=1758227456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8crAcUcgAosNzF9JtGxdHujIVkHQ2sPvfBZI7YKIEI=;
  b=nOFxpgC/jgbzYFsWzmRaZsAK9M/1PV5oKFUwY+0gmpNAM0JzNSy6jqoX
   V5GBpdjrN6Q1t6x1xC1lG/cAzDBMU3KbhZlbzLhvQkZ7mkz7iDHGABWNW
   BO88xqGZQbX0nexNRCecH7MBGyO9X0Gq7EEXOf4dXt44M/OUtMHs/uwfX
   x6rad9t2LKFdKznSBFxvZuyb7QMfyCZwS0WP0KRC1JKnSV2p4K4b0aswk
   8CHF2uZ4/Zs9J0ItSaifYevPhZT1xmbb91W2csYkMogXW4LqXnoVMh1F2
   2VWZwLLfTNri0Rtrr1JEC8fq0zwox8Lo2EkQCO8LRDAO0o9su8Unw93zJ
   A==;
X-CSE-ConnectionGUID: im6dFYMrRWSHW0naS1OMVA==
X-CSE-MsgGUID: Rittb3gxQpGIDSh7CJqJlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36211522"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="36211522"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 13:30:55 -0700
X-CSE-ConnectionGUID: G03l2KzpRg6lUZ1ybq6Pkw==
X-CSE-MsgGUID: KgXze0/ERmmsxsK33VvTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="107154632"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 18 Sep 2024 13:30:48 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sr1K1-000Cc6-1d;
	Wed, 18 Sep 2024 20:30:45 +0000
Date: Thu, 19 Sep 2024 04:30:20 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Message-ID: <202409190310.ViHBRe12-lkp@intel.com>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917073117.1531207-8-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus brauner-vfs/vfs.all dennis-percpu/for-next linus/master v6.11]
[cannot apply to akpm-mm/mm-everything next-20240918]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/m68k-mm-Change-pmd_val/20240917-153331
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240917073117.1531207-8-anshuman.khandual%40arm.com
patch subject: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
config: arm-footbridge_defconfig (https://download.01.org/0day-ci/archive/20240919/202409190310.ViHBRe12-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240919/202409190310.ViHBRe12-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409190310.ViHBRe12-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:30:
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:18: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |                         ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/pgtable.h:1243:48: note: 'pgd' declared here
    1243 | static inline int pgd_none_or_clear_bad(pgd_t *pgd)
         |                                                ^
>> include/linux/pgtable.h:1245:8: error: array initializer must be an initializer list or wide string literal
    1245 |         pgd_t old_pgd = pgdp_get(pgd);
         |               ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:21: warning: array index 2 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     115 |                         (set1->sig[2] == set2->sig[2]) &&
         |                                          ^         ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:157:1: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     157 | _SIG_SET_BINOP(sigorsets, _sig_or)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:138:8: note: expanded from macro '_SIG_SET_BINOP'
     138 |                 a3 = a->sig[3]; a2 = a->sig[2];                         \
         |                      ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
--
     163 | _SIG_SET_BINOP(sigandnsets, _sig_andn)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:140:3: note: expanded from macro '_SIG_SET_BINOP'
     140 |                 r->sig[3] = op(a3, b3);                                 \
         |                 ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:163:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     163 | _SIG_SET_BINOP(sigandnsets, _sig_andn)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:141:3: note: expanded from macro '_SIG_SET_BINOP'
     141 |                 r->sig[2] = op(a2, b2);                                 \
         |                 ^      ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:27: note: expanded from macro '_SIG_SET_OP'
     174 |         case 4: set->sig[3] = op(set->sig[3]);                          \
         |                                  ^        ~
   include/linux/signal.h:186:24: note: expanded from macro '_sig_not'
     186 | #define _sig_not(x)     (~(x))
         |                            ^
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:10: note: expanded from macro '_SIG_SET_OP'
     174 |         case 4: set->sig[3] = op(set->sig[3]);                          \
         |                 ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:175:20: note: expanded from macro '_SIG_SET_OP'
     175 |                 set->sig[2] = op(set->sig[2]);                          \
         |                                  ^        ~
   include/linux/signal.h:186:24: note: expanded from macro '_sig_not'
     186 | #define _sig_not(x)     (~(x))
         |                            ^
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:1131:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:175:3: note: expanded from macro '_SIG_SET_OP'
     175 |                 set->sig[2] = op(set->sig[2]);                          \
         |                 ^        ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
      17 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/arm/kernel/asm-offsets.c:12:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from arch/arm/kernel/asm-offsets.c:12:
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: use of undeclared identifier 'pgdp'; did you mean 'pgd'?
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                                   ^
   arch/arm/include/asm/pgtable.h:154:36: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                            ^
   include/linux/mm.h:2819:61: note: 'pgd' declared here
    2819 | static inline p4d_t *p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
         |                                                             ^
>> include/linux/mm.h:2822:28: error: passing 'const volatile pmdval_t *' (aka 'const volatile unsigned int *') to parameter of type 'pmdval_t *' (aka 'unsigned int *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
    2822 |         return (unlikely(pgd_none(pgdp_get(pgd))) && __p4d_alloc(mm, pgd, address)) ?
         |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
   arch/arm/include/asm/pgtable.h:154:25: note: expanded from macro 'pgdp_get'
     154 | #define pgdp_get(pgpd)          READ_ONCE(*pgdp)
         |                                 ^
   include/asm-generic/rwonce.h:47:28: note: expanded from macro 'READ_ONCE'
      47 | #define READ_ONCE(x)                                                    \
         |                                                                         ^
   include/linux/compiler.h:77:42: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/pgtable-nop4d.h:21:34: note: passing argument to parameter 'pgd' here
      21 | static inline int pgd_none(pgd_t pgd)           { return 0; }
         |                                  ^
   29 warnings and 18 errors generated.
   make[3]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1194: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +1245 include/linux/pgtable.h

  1242	
  1243	static inline int pgd_none_or_clear_bad(pgd_t *pgd)
  1244	{
> 1245		pgd_t old_pgd = pgdp_get(pgd);
  1246	
  1247		if (pgd_none(old_pgd))
  1248			return 1;
  1249		if (unlikely(pgd_bad(old_pgd))) {
  1250			pgd_clear_bad(pgd);
  1251			return 1;
  1252		}
  1253		return 0;
  1254	}
  1255	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

