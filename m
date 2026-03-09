Return-Path: <linux-fsdevel+bounces-79772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L8vEYjCrmmRIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:52:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D761C23931F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D745630B195A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBACE3BD645;
	Mon,  9 Mar 2026 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBdAwq6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9D378805;
	Mon,  9 Mar 2026 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060377; cv=none; b=Z+KxXsJftY2bMWrkrTTRohw9OfIufHuyVtYXHvqljTg9TYfNH/6DhnrDT/qEZ3Wjwhsq6FBgPclrw8qYku2R7KOwDcZ24xR7qPtLE4axLM1Q/i58EoZqF/eF99eOS3pWQvyLDX5VXDNh/fT2n8dU+GSCbmjbrWATRSjOlA1SO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060377; c=relaxed/simple;
	bh=TB1rR85ROaSy6UBoxYmOUEsYJutQqwBBn4S6y5af2eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLWGjv++VoJEPzm4ip8hjUqHsMvsAOgA5DRub14VigQ2OBbNcJZRyMyi5gJSCtUU+9mcGRwaMD6VKopQqHnnX5Dwklr8GB0Nzr6drGNlQs4jR3swQadtRylwgS8g8+DPZLN/lcRqEk1Pq8G8OHoB3lDpBdueDtccdFARbqzyscc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBdAwq6l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773060375; x=1804596375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TB1rR85ROaSy6UBoxYmOUEsYJutQqwBBn4S6y5af2eE=;
  b=VBdAwq6lbTDdPnK7DvU5XmCD6ux/aomOSNaOQnsvxmc5FExdUKoEVlAt
   BSJzH6ZoB9lfRB/lo32zy/TweAHCswWZcn2/nXAUTnCgH6QKhuFerybut
   zaB7QfaMxlxzILjwowWAsdieOT+iecu2JcfNrGQj0/nyjto9UAgVeN1QY
   bkZjdSGa+gdsSScqI7Waq4hcOe1NAUhFqzj6j1oKTm73nZEv6PRLUBVqC
   YwBpvIIlID6ABbF0ETfW++iMJ2TzwWMaVq+I3LHIILvLSzJyY8lTfFjCl
   5r280B6VUlZjuGpBZ2spiouU9zCsRzX7GzS3ehQyroEqGtH5QTxAtGKqc
   A==;
X-CSE-ConnectionGUID: Dae5XyKmSyKuOpuuCi//+g==
X-CSE-MsgGUID: 4D32fEneQlmIA2JlzrabFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73981357"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73981357"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 05:46:15 -0700
X-CSE-ConnectionGUID: D7HOj06LTjyN+lE05ENfzQ==
X-CSE-MsgGUID: xp+qGuzkR1qnAvKVB+FQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218886495"
Received: from lkp-server01.sh.intel.com (HELO 434e41ea3c86) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 05:46:12 -0700
Received: from kbuild by 434e41ea3c86 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vzZzs-000000000EO-3e2R;
	Mon, 09 Mar 2026 12:46:08 +0000
Date: Mon, 9 Mar 2026 20:45:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, brauner@kernel.org, hch@lst.de,
	djwong@kernel.org, jack@suse.cz, cem@kernel.org, kbusch@kernel.org,
	axboe@kernel.dk
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 4/5] xfs: steer allocation using write stream
Message-ID: <202603092015.hrOdrSYV-lkp@intel.com>
References: <20260309052944.156054-5-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309052944.156054-5-joshi.k@samsung.com>
X-Rspamd-Queue-Id: D761C23931F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79772-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.950];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Kanchan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/fs-add-generic-write-stream-management-ioctl/20260309-133736
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260309052944.156054-5-joshi.k%40samsung.com
patch subject: [PATCH v2 4/5] xfs: steer allocation using write stream
config: i386-randconfig-011-20260309 (https://download.01.org/0day-ci/archive/20260309/202603092015.hrOdrSYV-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260309/202603092015.hrOdrSYV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603092015.hrOdrSYV-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/xfs/xfs_inode.o: in function `xfs_inode_write_stream_to_ag':
>> fs/xfs/xfs_inode.c:126:(.text+0x9ed): undefined reference to `__umoddi3'


vim +126 fs/xfs/xfs_inode.c

    95	
    96	xfs_agnumber_t
    97	xfs_inode_write_stream_to_ag(
    98		struct xfs_inode	*ip)
    99	{
   100		struct xfs_mount	*mp = ip->i_mount;
   101		uint8_t			stream_id = ip->i_write_stream;
   102		uint32_t		max_streams = xfs_inode_max_write_streams(ip);
   103		uint32_t		nr_ags;
   104		xfs_agnumber_t		start_ag, ags_per_stream;
   105	
   106		if (XFS_IS_REALTIME_INODE(ip) || !max_streams)
   107			return NULLAGNUMBER;
   108	
   109		stream_id -= 1; /* for 0-based math, stream-ids are 1-based */
   110	
   111		nr_ags = mp->m_sb.sb_agcount;
   112		ags_per_stream = nr_ags / max_streams;
   113	
   114		/* for the case when we have fewer AGs than streams */
   115		if (ags_per_stream == 0) {
   116			start_ag = stream_id % nr_ags;
   117			ags_per_stream = 1;
   118		} else {
   119			/* otherwise AGs are partitioned into N streams */
   120			start_ag = stream_id * ags_per_stream;
   121			/* uneven distribution case: last stream may contain extra */
   122			if (stream_id == max_streams-1)
   123				ags_per_stream = nr_ags - start_ag;
   124		}
   125		/* intra-stream concurrency: hash inode to choose AG within partition */
 > 126		return start_ag + (ip->i_ino % ags_per_stream);
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

