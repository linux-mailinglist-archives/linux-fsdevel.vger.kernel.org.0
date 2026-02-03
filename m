Return-Path: <linux-fsdevel+bounces-76161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKzoGh+ggWkoIAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:13:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54ED598F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8088B3017FE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98898392810;
	Tue,  3 Feb 2026 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ+sz8Cz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396423921F9;
	Tue,  3 Feb 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770102711; cv=none; b=kI3flw9usneL+8vzKZNXBXfdMJa4YxNCEHL4sFKUNOo5d+oxO4pd9ZsggNf5eN/Ku9eg102X41siNE68igAQwwamWueCmZ2VSGmsgscyV8c8SFWsqk+d7x9Us2+6foNIQxPGDAlP3qnLwN3Qm4T4QOsTdsg2r9HHBhei2wIvaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770102711; c=relaxed/simple;
	bh=Tg20fcLNMaoCzT6bisqT/GU9JY66d1uJBrhI2VyXOUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISf+nER1CFv+i75wrds4+RxsH6tbdjVA7v6ziu/ui1JE6yCNYNBjecweCKW64oz+4CblT5+cMzuwRDvcHFvjAsH7kFCMHTzBPOrcGfUK9Daopmv85HUAzheyK6xeLuyX6tjubKppgJ1886QVHhWpNgwm1nbbSLGw8RSDbFvYEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ+sz8Cz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770102710; x=1801638710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tg20fcLNMaoCzT6bisqT/GU9JY66d1uJBrhI2VyXOUg=;
  b=dZ+sz8CzpjR5abLdgUswDaYT7b99Pkeghl7dbQjgS27ZNoj19giJINac
   wkjNIdgNlvu1Pibq2iMvKQKJVOCkbAVFgeqfxTfZnQMwbF2h7flmADLzG
   wxs6ZfRse44ug1v3CRqxnxJ79jTNxMtLdvtvazjiW6zXUENsROtL+ziQe
   TjelLysz8Er1xJpVwDSH3VusLcNc8u7BkTUa8cDvFGjiJsL1Kw3sSPLu2
   NeNkfx6ivQQzX+TpiUwQmn5cs2mPg8GaQyF/ikgIUtHux1JiRunshj4Zz
   3vxb66vSh8AGQMEnglnjIHkhkWIWJahfxmhrw+LMZ9xRVEOS/YPhp+882
   w==;
X-CSE-ConnectionGUID: SEZEDzM0SCuAnyuyTIWk2A==
X-CSE-MsgGUID: YTO3cywHQYWZesUrgsGgRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70991639"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="70991639"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 23:11:49 -0800
X-CSE-ConnectionGUID: 3YTZ7BrnRSW1lPu5CbhUaw==
X-CSE-MsgGUID: 6PERgo2rQkeGrLgSaXIB0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="213883170"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by orviesa003.jf.intel.com with ESMTP; 02 Feb 2026 23:11:46 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnAZc-000000003KX-061T;
	Tue, 03 Feb 2026 07:11:44 +0000
Date: Tue, 3 Feb 2026 08:11:17 +0100
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 3/3] NFSD: Sign filehandles
Message-ID: <202602030854.mD7cfzBx-lkp@intel.com>
References: <11253ead28024160aaf8abf5c234de6605cc93b5.1770046529.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11253ead28024160aaf8abf5c234de6605cc93b5.1770046529.git.bcodding@hammerspace.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76161-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A54ED598F
X-Rspamd-Action: no action

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dabff11003f9aaf293bd8f907a62f3366bd5e65f]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFSD-Add-a-key-for-signing-filehandles/20260203-002703
base:   dabff11003f9aaf293bd8f907a62f3366bd5e65f
patch link:    https://lore.kernel.org/r/11253ead28024160aaf8abf5c234de6605cc93b5.1770046529.git.bcodding%40hammerspace.com
patch subject: [PATCH v3 3/3] NFSD: Sign filehandles
reproduce: (https://download.01.org/0day-ci/archive/20260203/202602030854.mD7cfzBx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030854.mD7cfzBx-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ERROR: Cannot find file ./include/linux/jbd2.h
   ERROR: Cannot find file ./include/linux/jbd2.h
   WARNING: No kernel-doc for file ./include/linux/jbd2.h
   ERROR: Cannot find file ./include/linux/netfs.h
   WARNING: No kernel-doc for file ./include/linux/netfs.h
>> Documentation/filesystems/nfs/exporting.rst:264: WARNING: Title underline too short.


vim +264 Documentation/filesystems/nfs/exporting.rst

   262	
   263	Configuration
 > 264	~~~~~~~~~~~~
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

