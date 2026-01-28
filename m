Return-Path: <linux-fsdevel+bounces-75719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBIdH+z+eWm71QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:19:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7059A1204
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72483302D5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7ED34E771;
	Wed, 28 Jan 2026 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TGlHRR6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFA20125F;
	Wed, 28 Jan 2026 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602724; cv=none; b=AhChG77u/DmFJSDKJKuQ2HiTalYHiXVVhOY6rcPv49DJYhwSrsqinyB0niJWvxSDPGnqcVrL11SvvZchL2B/KA+R/haxcmOUyNnwOItyNTSPBhTdElGne16CzA56k/VRodK4nlA7+rrNy1jhyvZ+Tbqpo+NfPyBmJIu2SawgtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602724; c=relaxed/simple;
	bh=irHF387VhKHjsOnpsnW9NUk3sxxbxWzln/uy9xgtwqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awkHM1aP4xodEhPeiEM8aN85iNxQ3jt2azKUTCmW2qnmc8HjM6PWRiB43xi2VEpHkb/MQ73nskNgWNAagvetip7B/aQYPU2knFMXvAJfUeQHZRA+h3bcL7MQrSTa0Lq2uWI+WtQMIaSJpmH9/06TJ9jFYeMMlkH5mmuZyHxxZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TGlHRR6F; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769602723; x=1801138723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=irHF387VhKHjsOnpsnW9NUk3sxxbxWzln/uy9xgtwqM=;
  b=TGlHRR6F94rKBRysVGoeJUVVWNt0zxHcxUUHuGMVDEqG6cxjzZLmjTVh
   zigjLlb+2U1wBFRVoTfL3919JzOQG/KyWzA3jTIUOyz58xeQBP0FdLJ+z
   spzvXvY2wrp4kTwZD+hxyWWnzz6JXZWYzzqjcZAe2oGIZPXJspe6r+RvC
   BJbktKaB0UGBZtPrNs2Z3M5R+ROzLzeE0qXwcvh3yz9xw4S+kCAnAPVlM
   nVNfUL7B3UrEtVrHcp902Qq2ykB+vNPTTbEvSVuNxGVpxPlLTkb/OWSQ8
   sivcrokU6gFz9flZablWyus71nF16DvcXnceFNs9VIDfN1LwwbItjmn74
   Q==;
X-CSE-ConnectionGUID: BeKq8/W3QImhw2GFekEqtA==
X-CSE-MsgGUID: yBW1TNNqRJGfBg1J7jsj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93469830"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="93469830"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 04:18:43 -0800
X-CSE-ConnectionGUID: Q7Z5V0R1RjCKaaK9/1JSxA==
X-CSE-MsgGUID: tIAdhHReTWOiiIA7g/WWbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212353797"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 28 Jan 2026 04:18:35 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vl4VE-00000000ZeC-2fMW;
	Wed, 28 Jan 2026 12:18:32 +0000
Date: Wed, 28 Jan 2026 20:18:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"maz@kernel.org" <maz@kernel.org>,
	"oupton@kernel.org" <oupton@kernel.org>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH v10 01/15] set_memory: set_direct_map_* to take address
Message-ID: <202601282023.vzRHJBfU-lkp@intel.com>
References: <20260126164445.11867-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126164445.11867-2-kalyazin@amazon.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75719-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7059A1204
X-Rspamd-Action: no action

Hi Nikita,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0499add8efd72456514c6218c062911ccc922a99]

url:    https://github.com/intel-lab-lkp/linux/commits/Kalyazin-Nikita/set_memory-set_direct_map_-to-take-address/20260127-005641
base:   0499add8efd72456514c6218c062911ccc922a99
patch link:    https://lore.kernel.org/r/20260126164445.11867-2-kalyazin%40amazon.com
patch subject: [PATCH v10 01/15] set_memory: set_direct_map_* to take address
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260128/202601282023.vzRHJBfU-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601282023.vzRHJBfU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601282023.vzRHJBfU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/loongarch/mm/pageattr.c:211:16: error: redefinition of 'addr' with a different type: 'unsigned long' vs 'const void *'
     211 |         unsigned long addr = (unsigned long)addr;
         |                       ^
   arch/loongarch/mm/pageattr.c:209:48: note: previous definition is here
     209 | int set_direct_map_invalid_noflush(const void *addr)
         |                                                ^
   1 error generated.


vim +211 arch/loongarch/mm/pageattr.c

   208	
   209	int set_direct_map_invalid_noflush(const void *addr)
   210	{
 > 211		unsigned long addr = (unsigned long)addr;
   212	
   213		if ((unsigned long)addr < vm_map_base)
   214			return 0;
   215	
   216		return __set_memory((unsigned long)addr, 1, __pgprot(0),
   217				    __pgprot(_PAGE_PRESENT | _PAGE_VALID));
   218	}
   219	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

