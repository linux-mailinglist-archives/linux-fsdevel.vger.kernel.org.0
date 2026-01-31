Return-Path: <linux-fsdevel+bounces-75976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALlCHT5PfWm+RQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:39:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C943BFA94
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D683025D16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 00:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2DF3016E3;
	Sat, 31 Jan 2026 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Top7DyDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7C2D3EE5;
	Sat, 31 Jan 2026 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769819956; cv=none; b=QuWvO09Y56C9OcjuaIAggTCwolgFCHZNK6Ml9MdJZB+cqM5MDcRAsrMAh2IifrdYHmVLoq2KuCB9RkaAqjiVPbjqzk1UXwtdWH9AkMcFoDj4UlhkRZoz1tHLCsYTKmuKHtjCzgqi2LxW1Q9SpJyQSryi14Y2UMCITFz8Lw5JhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769819956; c=relaxed/simple;
	bh=8cXBQNCdQxCaRXIFna2676wPV2abi47edMOp/wOXg2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8Dme7qy28vMqKT8a+KyEiz90s5RHREu5sYS3zP6UjHaqyqdqMDmYskGruHI0hutyZGSUnXjaa8JJ9mnoO3wITxiAtKnoHfSckzhLsuXbVy7jPQhnmFbwmRJboaMOCq1KRNo0InFsjSu73b/v/iZaw+lORPfRR8En4l8nUO08QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Top7DyDo; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769819953; x=1801355953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8cXBQNCdQxCaRXIFna2676wPV2abi47edMOp/wOXg2M=;
  b=Top7DyDol+tVGFcOEKfyZdEM+VygqSq0hpNxrKdcR1S1BNQJVUamsw0m
   VuM+x/Hu37I6jJBsz2FkwTzBL+zoomV2/bcFUG+LKQvnwm17c4udlqTeQ
   WlGv+WRpgRkDA62r+G6yVmnhMbHm884RT2kGUCi3jtwBD245MepJ2a+8k
   q91okJQFceX/oj51EQDSZzGWzmXGC/ZySxws9yMkfYrO0mjAaoEokecxg
   aeKu4uuJGGN/oxdZ/kU6VkdjvdbSsj6j6q+SjnzPDYVkf/+ALYLanUeCl
   SYmBdp/ON5Dm2lfCAQnse2yqIbykYBGF1IOhqCqgmKqsH73kRknDNN3xY
   w==;
X-CSE-ConnectionGUID: Ina9h9mZT5ua+vw7PujZQQ==
X-CSE-MsgGUID: lSCduzbcSzW+Siz1FhIs/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="82443497"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="82443497"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 16:39:12 -0800
X-CSE-ConnectionGUID: g3rJi/AKTPmZP30c67YFtw==
X-CSE-MsgGUID: D2q0tBQuSz2sKtT48A7x0g==
X-ExtLoop1: 1
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa003.fm.intel.com with ESMTP; 30 Jan 2026 16:39:11 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlz12-000000002bZ-3lTR;
	Sat, 31 Jan 2026 00:39:08 +0000
Date: Sat, 31 Jan 2026 01:38:15 +0100
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?B=F6hler?= <witcher@wiredspace.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	Thomas =?iso-8859-1?Q?B=F6hler?= <witcher@wiredspace.de>
Subject: Re: [PATCH] docs: filesystems: ensure proc pid substitutable is
 complete
Message-ID: <202601310140.l1CiA2nu-lkp@intel.com>
References: <20260130-ksm_stat-v1-1-a6aa0da78de6@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130-ksm_stat-v1-1-a6aa0da78de6@wiredspace.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-75976-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C943BFA94
X-Rspamd-Action: no action

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6b8edfcd661b569f077cc1ea1f7463ec38547779]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-B-hler/docs-filesystems-ensure-proc-pid-substitutable-is-complete/20260130-232903
base:   6b8edfcd661b569f077cc1ea1f7463ec38547779
patch link:    https://lore.kernel.org/r/20260130-ksm_stat-v1-1-a6aa0da78de6%40wiredspace.de
patch subject: [PATCH] docs: filesystems: ensure proc pid substitutable is complete
reproduce: (https://download.01.org/0day-ci/archive/20260131/202601310140.l1CiA2nu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601310140.l1CiA2nu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   ERROR: Cannot find file ./include/linux/jbd2.h
   ERROR: Cannot find file ./include/linux/jbd2.h
   WARNING: No kernel-doc for file ./include/linux/jbd2.h
   ERROR: Cannot find file ./include/linux/netfs.h
   WARNING: No kernel-doc for file ./include/linux/netfs.h
>> Documentation/filesystems/proc.rst:2293: WARNING: Title underline too short.
--
   3.14 /proc/<pid>/ksm_stat - Information about the process's ksm status
   --------------------------------------------------------------------- [docutils]
>> Documentation/filesystems/proc.rst:2293: WARNING: Title underline too short.


vim +2293 Documentation/filesystems/proc.rst

f1f1f2569901ec Ivan Babrou   2022-09-22  2291  
d5424c31b9e465 Thomas Böhler 2026-01-30  2292  3.14 /proc/<pid>/ksm_stat - Information about the process's ksm status
91fe0e4d044044 Andrew Morton 2025-01-10 @2293  ---------------------------------------------------------------------
3ab76c767bc783 xu xin        2025-01-10  2294  When CONFIG_KSM is enabled, each process has this file which displays
3ab76c767bc783 xu xin        2025-01-10  2295  the information of ksm merging status.
3ab76c767bc783 xu xin        2025-01-10  2296  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

