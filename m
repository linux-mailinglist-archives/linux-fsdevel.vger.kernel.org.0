Return-Path: <linux-fsdevel+bounces-76112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJtOLIcogWnsEQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:43:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC09D25D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 23:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A8C313C5E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1E378D94;
	Mon,  2 Feb 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wwo3Yrxf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D26B652;
	Mon,  2 Feb 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071554; cv=none; b=aJwbFihdVhqLoCGO/TLaYimihEyovLias9B4KmkN1Xvnm+Mo5lQW7jH2RXlO7KXg5kBiw+KmoUl8pSJ5UjOF03L6OA/OJRAeHpLzM0JjMjxe3mVldRCqAf9S8l+SlqtT+/edpKFzOM5JQGm6Q9/mDPMundXF1+G8zdZKqzkaKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071554; c=relaxed/simple;
	bh=RkwvJ/eaG/ubSf4GeTmV9ctxLTvA9ARikKcdQA5n5PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8fOeegz4d3fGo7NpUJAWXN3PxdAt5GIBnFkWpJ4eLfoXTLhkWQn06iEsDdwkupLcrfkdz0L351kbor3dKvkc+J6hw2BsxO0SNj5pIumwtw7NH//wrzfixl/RKEdKTIs0eLhch3lRBW7cP4Do9xql9oNGV+WyM3wPRhk0vUDdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wwo3Yrxf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770071551; x=1801607551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RkwvJ/eaG/ubSf4GeTmV9ctxLTvA9ARikKcdQA5n5PA=;
  b=Wwo3Yrxf+7RnT7YVLqPmFJVkmyK5vM4YmLhWMgJgimZAbXV4bElJDHO5
   unZ5JSV8/MUx4N3bT4Lw4TC9sXg3d7aFkKf/vLq1CBk1Hn4sSkS1hm3kO
   E6s9/SCiuFfLlcQzsZ8LmU57j/VQUMlXN2o6o40R36VscHJOlcqKlY/a1
   7F0fyQ+ClJE6ExZcNfOdcY8fnhs3NyHelQ73uiT93pghAUQZk6PO3uFUS
   kQDo+d41opkJ6qGUNDhPUBsJifIgj+fiUBglvUGwxqVvyYO6njlqGEcsU
   zx0QYg1pS1cVwErVhLS8V5dsx40JNr/OUcDqhE1vSXF3EqFT3ykq6iDVN
   A==;
X-CSE-ConnectionGUID: l0VF0J8gRPufzvYr2QI2kQ==
X-CSE-MsgGUID: JILgaMbASCin1EUGr4lZlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71276589"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="71276589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 14:32:31 -0800
X-CSE-ConnectionGUID: Hbxrtp+LSiCoLVQlQdZWyA==
X-CSE-MsgGUID: Ek3RB598Quy6MtEbEFKVDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="208938576"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 02 Feb 2026 14:32:28 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn2T3-00000000g1O-13HM;
	Mon, 02 Feb 2026 22:32:25 +0000
Date: Tue, 3 Feb 2026 06:31:41 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Rick Macklem <rick.macklem@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 1/3] NFSD: Add a key for signing filehandles
Message-ID: <202602030619.d8NUY35L-lkp@intel.com>
References: <e3806f53c351c03725ecb12fb7ad100786df04f6.1770046529.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3806f53c351c03725ecb12fb7ad100786df04f6.1770046529.git.bcodding@hammerspace.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76112-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[hammerspace.com,oracle.com,kernel.org,brown.name,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CC09D25D3
X-Rspamd-Action: no action

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dabff11003f9aaf293bd8f907a62f3366bd5e65f]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFSD-Add-a-key-for-signing-filehandles/20260203-002703
base:   dabff11003f9aaf293bd8f907a62f3366bd5e65f
patch link:    https://lore.kernel.org/r/e3806f53c351c03725ecb12fb7ad100786df04f6.1770046529.git.bcodding%40hammerspace.com
patch subject: [PATCH v3 1/3] NFSD: Add a key for signing filehandles
config: x86_64-buildonly-randconfig-003-20260203 (https://download.01.org/0day-ci/archive/20260203/202602030619.d8NUY35L-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260203/202602030619.d8NUY35L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602030619.d8NUY35L-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfsctl.c:1588:6: warning: variable 'fh_key' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1588 |         if (!nn->fh_key) {
         |             ^~~~~~~~~~~
   fs/nfsd/nfsctl.c:1594:9: note: uninitialized use occurs here
    1594 |         memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
         |                ^~~~~~
   fs/nfsd/nfsctl.c:1588:2: note: remove the 'if' if its condition is always true
    1588 |         if (!nn->fh_key) {
         |         ^~~~~~~~~~~~~~~~
   fs/nfsd/nfsctl.c:1583:23: note: initialize the variable 'fh_key' to silence this warning
    1583 |         siphash_key_t *fh_key;
         |                              ^
         |                               = NULL
   1 warning generated.


vim +1588 fs/nfsd/nfsctl.c

  1573	
  1574	/**
  1575	 * nfsd_nl_fh_key_set - helper to copy fh_key from userspace
  1576	 * @attr: nlattr NFSD_A_SERVER_FH_KEY
  1577	 * @nn: nfsd_net
  1578	 *
  1579	 * Callers should hold nfsd_mutex, returns 0 on success or negative errno.
  1580	 */
  1581	static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
  1582	{
  1583		siphash_key_t *fh_key;
  1584	
  1585		if (nla_len(attr) != sizeof(siphash_key_t))
  1586			return -EINVAL;
  1587	
> 1588		if (!nn->fh_key) {
  1589			fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
  1590			if (!fh_key)
  1591				return -ENOMEM;
  1592		}
  1593	
  1594		memcpy(fh_key, nla_data(attr), sizeof(siphash_key_t));
  1595		nn->fh_key = fh_key;
  1596		return 0;
  1597	}
  1598	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

