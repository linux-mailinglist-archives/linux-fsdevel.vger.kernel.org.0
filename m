Return-Path: <linux-fsdevel+bounces-77593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF3oCGbolWlWWQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:27:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0D1157B8A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83D9B301828F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C233F397;
	Wed, 18 Feb 2026 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KcSR4dWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7430C600;
	Wed, 18 Feb 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432023; cv=none; b=divgwbM+WZImMvwh0JtWKRyx7MnA9mvvFuCYE6jm80EVGbndwhLCWscIMnBJY6tlA7uHt4mRe++ze/R78kHfN14dfuAiMzD+ZRed/dGpmvRLQ2mSXQUapYMhdwFND594rYiCz6GSr90zA/LIRmCpdvTcH+KSAPrTT+9E7QzvyMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432023; c=relaxed/simple;
	bh=FQ+bcs3bK4e9gaHifYX43jw8A6vSLpxCj1gMAKLCEDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txEt3bUWY4bmLGVpN/MOMxtet6FbUJfECorkYxEg5VXpkE1QJMzN9ZXjZEoYPkN/PQs9A8xY0d68UaV1ClI7WFKcmtowE8IkaVA6miNEKw0jTHXe3W668rg+dXkIuqzMtOpsOTPVSjCnEPWONZu1WJ8Ets6zdzw1brr06+hm0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KcSR4dWy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771432020; x=1802968020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FQ+bcs3bK4e9gaHifYX43jw8A6vSLpxCj1gMAKLCEDI=;
  b=KcSR4dWyyPkQy4/Q8P7ZHt3jndnRZrntWMzi03hKdzM792fmlAxAhDEv
   8IkT4yMBxq1QAQehzrg45Xqb6Zqzq9TFhC7UUrGOMS7sSQntzThjkfBAS
   MOrD0Qm8iPaFYulz2s9JVjZ1ZnZDojKEyhAawt9hgLu5fNmDvOAckCOX8
   oqyJt+56/4c5H7xejau/DXcobpbs1h1mIOXWoCWrf8QikbD46x7m8Pu79
   Q8+sKwbaw/jhYJsFK3fqc09GToQu1f05AiS10/s05VF0NRcyZlPvvWHvl
   wJjqbm3PvsK4o3nkcLsxVTj4sgu91+CxhmReYuRDihH3D/6TIEhMIjpja
   w==;
X-CSE-ConnectionGUID: r5aGd+FESGyIh5GgH4ko/A==
X-CSE-MsgGUID: crepqNw4QpGYXWsqkRzTuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83229164"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="83229164"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 08:26:59 -0800
X-CSE-ConnectionGUID: 95zWeISxRJWVGM/MwGIexQ==
X-CSE-MsgGUID: LKRNdluuTeqzEAuWAu1QLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="218767893"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Feb 2026 08:26:59 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vskO9-000000012Wu-0Q7g;
	Wed, 18 Feb 2026 16:26:57 +0000
Date: Thu, 19 Feb 2026 00:26:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Ferguson <ethan.ferguson@zetier.com>, hirofumi@mail.parknet.co.jp
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: Re: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
Message-ID: <202602190010.tPRKu8kq-lkp@intel.com>
References: <20260217230628.719475-3-ethan.ferguson@zetier.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217230628.719475-3-ethan.ferguson@zetier.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77593-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,de.date:url,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 5B0D1157B8A
X-Rspamd-Action: no action

Hi Ethan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9f2693489ef8558240d9e80bfad103650daed0af]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Ferguson/fat-Add-FS_IOC_GETFSLABEL-ioctl/20260218-071019
base:   9f2693489ef8558240d9e80bfad103650daed0af
patch link:    https://lore.kernel.org/r/20260217230628.719475-3-ethan.ferguson%40zetier.com
patch subject: [PATCH v2 2/2] fat: Add FS_IOC_SETFSLABEL ioctl
config: hexagon-randconfig-r121-20260218 (https://download.01.org/0day-ci/archive/20260219/202602190010.tPRKu8kq-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e86750b29fa0ff207cd43213d66dabe565417638)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260219/202602190010.tPRKu8kq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602190010.tPRKu8kq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/fat/dir.c:1439:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [addressable] [assigned] [usertype] size @@     got unsigned char [addressable] [assigned] [usertype] lcase @@
   fs/fat/dir.c:1439:41: sparse:     expected restricted __le32 [addressable] [assigned] [usertype] size
   fs/fat/dir.c:1439:41: sparse:     got unsigned char [addressable] [assigned] [usertype] lcase
>> fs/fat/dir.c:1449:48: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [addressable] [assigned] [usertype] ctime @@     got unsigned char [addressable] [assigned] [usertype] ctime_cs @@
   fs/fat/dir.c:1449:48: sparse:     expected restricted __le16 [addressable] [assigned] [usertype] ctime
   fs/fat/dir.c:1449:48: sparse:     got unsigned char [addressable] [assigned] [usertype] ctime_cs

vim +1439 fs/fat/dir.c

  1426	
  1427	static int fat_create_volume_label_dentry(struct super_block *sb, char *vol_label)
  1428	{
  1429		struct msdos_sb_info *sbi = MSDOS_SB(sb);
  1430		struct inode *root_inode = sb->s_root->d_inode;
  1431		struct msdos_dir_entry de;
  1432		struct fat_slot_info sinfo;
  1433		struct timespec64 ts = current_time(root_inode);
  1434		__le16 date, time;
  1435		u8 time_cs;
  1436	
  1437		memcpy(de.name, vol_label, MSDOS_NAME);
  1438		de.attr = ATTR_VOLUME;
> 1439		de.starthi = de.start = de.size = de.lcase = 0;
  1440	
  1441		fat_time_unix2fat(sbi, &ts, &time, &date, &time_cs);
  1442		de.time = time;
  1443		de.date = date;
  1444		if (sbi->options.isvfat) {
  1445			de.cdate = de.adate = date;
  1446			de.ctime = time;
  1447			de.ctime_cs = time_cs;
  1448		} else
> 1449			de.cdate = de.adate = de.ctime = de.ctime_cs = 0;
  1450	
  1451		return fat_add_entries(root_inode, &de, 1, &sinfo);
  1452	}
  1453	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

