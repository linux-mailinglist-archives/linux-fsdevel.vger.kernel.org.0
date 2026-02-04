Return-Path: <linux-fsdevel+bounces-76234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCBRIj+RgmmCWQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 01:22:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D86DFFC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 01:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A6C30DAB14
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEDA1C84D0;
	Wed,  4 Feb 2026 00:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIByiWK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F51A5B9D;
	Wed,  4 Feb 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164525; cv=none; b=TIHIbdzV2zghlzLhkvaLXxu8NCRpHYw3TiwDplBrHDR2mGvkLBxfaigbR04WtkII6wh4d+SPchdPekbsAMjAHqWcYAjexW1/gMq4UaNAkz2wMbF/wtnAzf3DVrMSiGDSjrsyyU+l2hF27tJ7JgVmxFClB/hmBnmiAYkPKooVBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164525; c=relaxed/simple;
	bh=vJqaIkkGQQvB0y2jKpAyCZtx6W0Oi8NhwX7gnDSzPQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqDrfimoRKGKUGeULy1BkTvw0fZQYBJLG8OnJ0GgI9y5tlhv1uRQ/GW98ZaxZTraTop6dlFoHN4piLcFalyageagxiaqSRu1e8Vo0fSuvJ0ZKYrWSabim8cCo5SjudIpZicSELp1z0gCt8vsyRrVyGheZBTEpXDILLn6DXZcqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIByiWK8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770164522; x=1801700522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJqaIkkGQQvB0y2jKpAyCZtx6W0Oi8NhwX7gnDSzPQM=;
  b=MIByiWK8s3SilpcI5zPKPEthr/Fz9Jag5F/IVkB/fXs5QkocwIO2cz79
   K34XRuV2T8e1RUVNweAvqeOCWO2UwI5bnU/VytXj2z4ZnMLAQtQ4kUEH4
   tfoe16yZStRMFLisJjwpBSprTbDRylPuJxycmS4u09Cf4DaLjSdlU+P6b
   nDYzfdW1xOMHqmUwAq8kMTSc3mfyHZmpyo4jE0nW9mvyRGzWogT0y7k3g
   hE4lAPPEJQcw3MpTzvNSVT0oD0JVQtp8kM9+/iOR0enc2Rh38IL2c/dN+
   0hglGzRCXMKSicjPu8/C/xYPn6VtEqSLe8bwLWKX+tsp9k3gUu1fojBIp
   w==;
X-CSE-ConnectionGUID: xvjwZ/4LRYCDSf6sOn0YFw==
X-CSE-MsgGUID: pTsO5uXARoSDosk7cnFqEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71428556"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71428556"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 16:22:01 -0800
X-CSE-ConnectionGUID: t5rIKQ7vT8mNAM1G04i7VQ==
X-CSE-MsgGUID: gWaNtIfiRWSd5iEDpjxA8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="214548021"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Feb 2026 16:22:00 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnQea-00000000hK0-2QDh;
	Wed, 04 Feb 2026 00:21:56 +0000
Date: Wed, 4 Feb 2026 08:21:56 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
	yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yizhang089@gmail.com,
	libaokun1@huawei.com, yangerkun@huawei.com, yukuai@fnnas.com
Subject: Re: [PATCH -next v2 17/22] ext4: implement partial block zero range
 iomap path
Message-ID: <202602040854.1tmFmFGB-lkp@intel.com>
References: <20260203062523.3869120-18-yi.zhang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203062523.3869120-18-yi.zhang@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,mit.edu,dilger.ca,suse.cz,linux.ibm.com,gmail.com,infradead.org,kernel.org,huawei.com,huaweicloud.com,fnnas.com];
	TAGGED_FROM(0.00)[bounces-76234-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8D86DFFC1
X-Rspamd-Action: no action

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260202]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Yi/ext4-make-ext4_block_zero_page_range-pass-out-did_zero/20260203-144244
base:   next-20260202
patch link:    https://lore.kernel.org/r/20260203062523.3869120-18-yi.zhang%40huawei.com
patch subject: [PATCH -next v2 17/22] ext4: implement partial block zero range iomap path
config: m68k-randconfig-r123-20260204 (https://download.01.org/0day-ci/archive/20260204/202602040854.1tmFmFGB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602040854.1tmFmFGB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602040854.1tmFmFGB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ext4/inode.c:4151:24: sparse: sparse: symbol 'ext4_iomap_zero_ops' was not declared. Should it be static?
   fs/ext4/inode.c:4164:24: sparse: sparse: symbol 'ext4_iomap_buffered_read_ops' was not declared. Should it be static?
   fs/ext4/inode.c:5135:32: sparse: sparse: unsigned value that used to be signed checked against zero?
   fs/ext4/inode.c:5134:52: sparse: signed value source

vim +/ext4_iomap_zero_ops +4151 fs/ext4/inode.c

  4150	
> 4151	const struct iomap_ops ext4_iomap_zero_ops = {
  4152		.iomap_begin = ext4_iomap_zero_begin,
  4153	};
  4154	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

