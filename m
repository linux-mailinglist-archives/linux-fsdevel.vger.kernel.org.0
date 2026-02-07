Return-Path: <linux-fsdevel+bounces-76669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDrAE6YXh2nBTQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 11:44:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A21CF1059A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Feb 2026 11:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C4D7F3007229
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Feb 2026 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EF933E362;
	Sat,  7 Feb 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOfDjLp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C072D33E34C;
	Sat,  7 Feb 2026 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770461084; cv=none; b=CkleBHxLqmxWoGcWQP0Lc1N0Vdku/2Fqyw06JdNQHJuT5DVxxGChh50ZW7AN/qQkZpnX8X1hThNTROZMYY6ks/9bkffbp38ZpJZlt/7CpN05Lmoq2VRN0G20XHW2OJJaS/zPUkI5V3Kwi/2zQRnsq4cEmzKNVTK3HwcyvY08jfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770461084; c=relaxed/simple;
	bh=Gk1b1szSKFtgjZ1DQKUhyp77v69EzsrYNnADb+xDK+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGR9C02JezrfA+CauyQAAgJ8xKWVxPPdn0I0MJxm0tkVeKH28H85AKeY3AmHufF5XObbx740DEx8hpAhgxpdX5ku2uM8d2RdgmSGME/V0pzmO9ij8uBiVyj8n7khGcQl43dR3TYYckdApK7ik7OMvz7XrqA38E40mlAosly3A1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOfDjLp0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770461083; x=1801997083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gk1b1szSKFtgjZ1DQKUhyp77v69EzsrYNnADb+xDK+c=;
  b=jOfDjLp0v0QE+rc6LRr6Ml++4Mo7JaehAK1gc4moyRJhPBw5roIZJkah
   p5LRbvINwcKH+V5+LJzGYQ4659aDVvJykIbCkStdOPm4d1Ds0g1Eemwof
   0deH8Om+jg/qZw5p0oKVoql/9xXfNuMytRgPCdMtvv6abYgE8vGN5G4Y8
   toLBGmUnaVY56y30HTe+SFL5Tqoy1X2v+O1FUl1dKrRZi+Gt2QJlUZ1XI
   vjuu9NzCUGjxPHtHopgQO0mj4+Z+oR13o2wf6uM+lSiYQxfHNAOOD4/7N
   nLWX32x8uSu7dBcxfx2HlkBYNm5/cd43fiFMYrDoCirpwBUIj6RqhVVrN
   g==;
X-CSE-ConnectionGUID: 452gl6fvQuCC80sddsxEww==
X-CSE-MsgGUID: HiTu1PgWSqyjjkNZrgfjhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="97109629"
X-IronPort-AV: E=Sophos;i="6.21,278,1763452800"; 
   d="scan'208";a="97109629"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2026 02:44:43 -0800
X-CSE-ConnectionGUID: XaIAzb1RTseln8MDTP5P8g==
X-CSE-MsgGUID: su1AKVbVQBSEZSzAGvWb0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,278,1763452800"; 
   d="scan'208";a="210848523"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 07 Feb 2026 02:44:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vofnq-00000000laa-0Pv3;
	Sat, 07 Feb 2026 10:44:38 +0000
Date: Sat, 7 Feb 2026 18:43:45 +0800
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
Subject: Re: [PATCH v4 3/3] NFSD: Sign filehandles
Message-ID: <202602071819.UF8h2gl7-lkp@intel.com>
References: <d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding@hammerspace.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76669-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.951];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A21CF1059A7
X-Rspamd-Action: no action

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e3934bbd57c73b3835a77562ca47b5fbc6f34287]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFSD-Add-a-key-for-signing-filehandles/20260206-231407
base:   e3934bbd57c73b3835a77562ca47b5fbc6f34287
patch link:    https://lore.kernel.org/r/d34d4f79a7d4c6b77ad260f925cb51c34fd53ce5.1770390036.git.bcodding%40hammerspace.com
patch subject: [PATCH v4 3/3] NFSD: Sign filehandles
config: x86_64-randconfig-121-20260207 (https://download.01.org/0day-ci/archive/20260207/202602071819.UF8h2gl7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260207/202602071819.UF8h2gl7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602071819.UF8h2gl7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfsd/nfsfh.c:168:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] hash @@     got restricted __le64 [usertype] @@
   fs/nfsd/nfsfh.c:168:14: sparse:     expected unsigned long long [usertype] hash
   fs/nfsd/nfsfh.c:168:14: sparse:     got restricted __le64 [usertype]
   fs/nfsd/nfsfh.c:191:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] hash @@     got restricted __le64 [usertype] @@
   fs/nfsd/nfsfh.c:191:14: sparse:     expected unsigned long long [usertype] hash
   fs/nfsd/nfsfh.c:191:14: sparse:     got restricted __le64 [usertype]

vim +168 fs/nfsd/nfsfh.c

   143	
   144	/*
   145	 * Append an 8-byte MAC to the filehandle hashed from the server's fh_key:
   146	 */
   147	static int fh_append_mac(struct svc_fh *fhp, struct net *net)
   148	{
   149		struct nfsd_net *nn = net_generic(net, nfsd_net_id);
   150		struct knfsd_fh *fh = &fhp->fh_handle;
   151		siphash_key_t *fh_key = nn->fh_key;
   152		u64 hash;
   153	
   154		if (!(fhp->fh_export->ex_flags & NFSEXP_SIGN_FH))
   155			return 0;
   156	
   157		if (!fh_key) {
   158			pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_key not set.\n");
   159			return -EINVAL;
   160		}
   161	
   162		if (fh->fh_size + sizeof(hash) > fhp->fh_maxsize) {
   163			pr_warn_ratelimited("NFSD: unable to sign filehandles, fh_size %d would be greater"
   164				" than fh_maxsize %d.\n", (int)(fh->fh_size + sizeof(hash)), fhp->fh_maxsize);
   165			return -EINVAL;
   166		}
   167	
 > 168		hash = cpu_to_le64(siphash(&fh->fh_raw, fh->fh_size, fh_key));
   169		memcpy(&fh->fh_raw[fh->fh_size], &hash, sizeof(hash));
   170		fh->fh_size += sizeof(hash);
   171	
   172		return 0;
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

