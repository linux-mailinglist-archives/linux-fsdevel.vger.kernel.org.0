Return-Path: <linux-fsdevel+bounces-75376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHMvGAJ8dWlVFgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 03:12:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF87F81E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 03:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAEA6300D96F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2361DEFE9;
	Sun, 25 Jan 2026 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ni5gWez3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0A3EBF09;
	Sun, 25 Jan 2026 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769307127; cv=none; b=bajzkyiNU1oFVMGkGrFeDeRjMRRHI3cIGP1sgcnazB16T2ae0biamcT0ccfw8r6iyIpImGeO2PjyXbmCHBn2Ml4l8eXmSb0dkNhFc67G7kCWf4kf1fclGjO8HmNz+RmlDU9biVCJKiUKH2jg/2QXEwiVKRVw4cLjr2kvu08u844=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769307127; c=relaxed/simple;
	bh=5+zaJOnluGsQr64By2Xu6kmcCVfHx3PGxNHewb0+KIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXOGgKcIialKKIDZ5kMPmJeWQL9Zf5I42wvGiT3ceqfxBWX7UXoB3sU/GFyLo5oqIHLN3Dd0F8bofbY2Qpx434GyFr64+Z+PzWU5g9H03mYN/v2sNpP8usD3xD1dYf+0XbMjmsS9ah8Kwx3LnncpSsR5j2h6RgTBOZ2J6rGiU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ni5gWez3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769307125; x=1800843125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5+zaJOnluGsQr64By2Xu6kmcCVfHx3PGxNHewb0+KIk=;
  b=Ni5gWez3O55h8A/bl7zSGfXlrUuQiUxkM+TQaF5xMmxiyZfnbz+f1RvR
   RUgy7OxvbOZ2fkjXOH3ZhcRntQsukEHp0CDGIAKu3Glg+VgmD8sCklHIy
   frCJO8PbAKXigGeeu6SBOZqWTsvcImg3SLF83h7Lq5wXc8DrnL4lCNph2
   6wX/E84SE+/6msT4BYJ6rdvKXfHrb07h7v7Nnq0WG/Emdl+kCUtknngAQ
   ZC+/6eEllu6Udl4IFrrFguL8N/m5hMHPt5s+WsVFkOAotDiX4ZRH60emf
   CN/X1n3PGLXVTZPe4Gjq2kwvmPC89oXpCE8pI4Qd3lReqaWbwSSBXS6kf
   w==;
X-CSE-ConnectionGUID: acGFkQ1ASQ214K600nHmRQ==
X-CSE-MsgGUID: 7YVK+THTRoebHwVWf5Lgng==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="73102026"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="73102026"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 18:12:05 -0800
X-CSE-ConnectionGUID: DzTP11UrRoqGq31nY1ykdA==
X-CSE-MsgGUID: U3yjqrfpSEi8+ofbZGGi0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="207783717"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 24 Jan 2026 18:11:45 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjpbJ-00000000VgM-01xJ;
	Sun, 25 Jan 2026 02:11:41 +0000
Date: Sun, 25 Jan 2026 10:11:16 +0800
From: kernel test robot <lkp@intel.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>, slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com,
	janak@mpiricsoftware.com, shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH] hfsplus: validate btree bitmap during mount and handle
 corruption gracefully
Message-ID: <202601251011.kJUhBF3P-lkp@intel.com>
References: <20260124192501.748071-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124192501.748071-1-shardul.b@mpiricsoftware.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.linux.dev,syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-75376-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 65BF87F81E
X-Rspamd-Action: no action

Hi Shardul,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.19-rc6 next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shardul-Bankar/hfsplus-validate-btree-bitmap-during-mount-and-handle-corruption-gracefully/20260125-032702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260124192501.748071-1-shardul.b%40mpiricsoftware.com
patch subject: [PATCH] hfsplus: validate btree bitmap during mount and handle corruption gracefully
config: hexagon-randconfig-001-20260125 (https://download.01.org/0day-ci/archive/20260125/202601251011.kJUhBF3P-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260125/202601251011.kJUhBF3P-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/hfsplus/btree.c:180:17: warning: result of comparison of constant 262144 with expression of type 'u16' (aka 'unsigned short') is always false [-Wtautological-constant-out-of-range-compare]
     180 |             bitmap_off >= PAGE_SIZE)
         |             ~~~~~~~~~~ ^  ~~~~~~~~~
   1 warning generated.


vim +180 fs/hfsplus/btree.c

   131	
   132	/*
   133	 * Validate that node 0 (header node) is marked allocated in the bitmap.
   134	 * This is a fundamental invariant - node 0 must always be allocated.
   135	 * Returns true if corruption is detected (node 0 bit is unset).
   136	 * Note: head must be from kmap_local_page(page) that is still mapped.
   137	 * This function accesses the page through head pointer, so it must be
   138	 * called before kunmap_local(head).
   139	 */
   140	static bool hfsplus_validate_btree_bitmap(struct hfs_btree *tree,
   141						  struct hfs_btree_header_rec *head)
   142	{
   143		u8 *page_base;
   144		u16 rec_off_tbl_off;
   145		__be16 rec_data[2];
   146		u16 bitmap_off, bitmap_len;
   147		u8 *bitmap_ptr;
   148		u8 first_byte;
   149		unsigned int node_size = tree->node_size;
   150	
   151		/*
   152		 * Get base page pointer. head points to:
   153		 * kmap_local_page(page) + sizeof(struct hfs_bnode_desc)
   154		 */
   155		page_base = (u8 *)head - sizeof(struct hfs_bnode_desc);
   156	
   157		/*
   158		 * Calculate offset to record 2 entry in record offset table.
   159		 * Record offsets are at end of node: node_size - (rec_num + 2) * 2
   160		 * Record 2: (2+2)*2 = 8 bytes from end
   161		 */
   162		rec_off_tbl_off = node_size - (2 + 2) * 2;
   163	
   164		/* Only validate if record offset table is on the first page */
   165		if (rec_off_tbl_off + 4 > node_size || rec_off_tbl_off + 4 > PAGE_SIZE)
   166			return false; /* Skip validation if offset table not on first page */
   167	
   168		/* Read record 2 offset table entry (length and offset, both u16) */
   169		memcpy(rec_data, page_base + rec_off_tbl_off, 4);
   170		bitmap_off = be16_to_cpu(rec_data[1]);
   171		bitmap_len = be16_to_cpu(rec_data[0]) - bitmap_off;
   172	
   173		/*
   174		 * Validate bitmap offset is within node and after bnode_desc.
   175		 * Also ensure bitmap is on the first page.
   176		 */
   177		if (bitmap_len == 0 ||
   178		    bitmap_off < sizeof(struct hfs_bnode_desc) ||
   179		    bitmap_off >= node_size ||
 > 180		    bitmap_off >= PAGE_SIZE)
   181			return false; /* Skip validation if bitmap not accessible */
   182	
   183		/* Read first byte of bitmap */
   184		bitmap_ptr = page_base + bitmap_off;
   185		first_byte = bitmap_ptr[0];
   186	
   187		/* Check if node 0's bit (bit 7, MSB) is set */
   188		if (!(first_byte & 0x80))
   189			return true; /* Corruption detected */
   190	
   191		return false;
   192	}
   193	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

