Return-Path: <linux-fsdevel+bounces-76005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2gKrF1Yof2kMlAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 11:17:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C1C5695
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 222383012CD3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091992E22AB;
	Sun,  1 Feb 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPh+tuod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D77B178372
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941072; cv=none; b=RiN2OnwlVqF7qRlpUFPrRjrPqH1n3uZ20g2MQGtRMc7LYV9g7Sw6oMB/Vqc+pzVouozE4OrbgEWJ53UWuHFyuGnqEhQcbSxKeUVWBLlkC8U4cfz6DMHylaWqJh+n75JXBjU/CiVkL7I+EpCuQnrfUtMtAJbBLW2WuFuHlQa2e+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941072; c=relaxed/simple;
	bh=FJNXyL8PUz/xeGfImMPq/+s+MRxuE/dYerDeJdRNWGQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fTPU2QKczZC3PUErIGbstq77P/bgJK/fDzGK5WMr7Eo8w4QjgzSSGKUEruxXbZGLzmMnA1Y6wYXLHHs2k+ISGjbw3hKHh75XA61w4LFy0v3mT/ylN9uJ9iA3BjwwLGJIbBHp83HVmaSODmPeZn37Q7eSRqM5+EDJzOzSoSW8wxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPh+tuod; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769941070; x=1801477070;
  h=date:from:to:cc:subject:message-id;
  bh=FJNXyL8PUz/xeGfImMPq/+s+MRxuE/dYerDeJdRNWGQ=;
  b=XPh+tuodndq+FpZY3Z17ncXdMoVnDtsYgyB6eulkJFJEk3ibOIUJ6kcB
   JaK6MJtb7iNSqz2Oby5hDJhdhxyYkzPpMj61bQjXyXuJ9smv9Z/sC3uom
   CAz1g1eIMspYFa4ksSoQd4BMLGPk44J8D0PbuvLbp1/chpJmIjUziQ2T5
   X+OrVeN/Rs9U4DEmKSbfXbfAOKinDyrY7bV2RwEQUMnXx52ndHy8QCaRG
   +WzrbO0rIW6UABqFy2sf4dZUYnJnxJhTgLYzJOUPVRPk7nSP7kEKruvZv
   F2GfCA57SRI9xEQHkTCDHG7RE6QZN8exc9rj+YHLBU1CW9+ZdqYPIVgas
   Q==;
X-CSE-ConnectionGUID: JEjQHVvjQU+rDxgLS8+7Fw==
X-CSE-MsgGUID: TgrF3WYhRmmRE/mhtWok3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="82236765"
X-IronPort-AV: E=Sophos;i="6.21,266,1763452800"; 
   d="scan'208";a="82236765"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 02:17:50 -0800
X-CSE-ConnectionGUID: LID5LypTQXS5NGu1ByPBeQ==
X-CSE-MsgGUID: ETIzVcd6SVKFUISgrjuUqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,266,1763452800"; 
   d="scan'208";a="214135137"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 01 Feb 2026 02:17:48 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmUWX-00000000eiG-3n4w;
	Sun, 01 Feb 2026 10:17:45 +0000
Date: Sun, 01 Feb 2026 18:16:47 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:for-wsamuel2 40/40]
 drivers/usb/gadget/function/f_fs.c:660:3: error: call to undeclared function
 'ffs_data_reset'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202602011830.yKVSsQTY-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76005-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: AB2C1C5695
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-wsamuel2
head:   9a8dd89bd5c65c4189f2bf6291f0f9a3d0df31c5
commit: 9a8dd89bd5c65c4189f2bf6291f0f9a3d0df31c5 [40/40] serialize ffs_ep0_open() on ffs->mutex, this time without ffs_data_reset() under ->mutex
config: x86_64-randconfig-013-20260201 (https://download.01.org/0day-ci/archive/20260201/202602011830.yKVSsQTY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260201/202602011830.yKVSsQTY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602011830.yKVSsQTY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/gadget/function/f_fs.c:660:3: error: call to undeclared function 'ffs_data_reset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     660 |                 ffs_data_reset(ffs);
         |                 ^
   drivers/usb/gadget/function/f_fs.c:660:3: note: did you mean 'ffs_data_get'?
   drivers/usb/gadget/function/f_fs.c:55:13: note: 'ffs_data_get' declared here
      55 | static void ffs_data_get(struct ffs_data *ffs);
         |             ^
   drivers/usb/gadget/function/f_fs.c:2089:13: error: static declaration of 'ffs_data_reset' follows non-static declaration
    2089 | static void ffs_data_reset(struct ffs_data *ffs);
         |             ^
   drivers/usb/gadget/function/f_fs.c:660:3: note: previous implicit declaration is here
     660 |                 ffs_data_reset(ffs);
         |                 ^
   2 errors generated.


vim +/ffs_data_reset +660 drivers/usb/gadget/function/f_fs.c

   640	
   641	static int ffs_ep0_open(struct inode *inode, struct file *file)
   642	{
   643		struct ffs_data *ffs = inode->i_sb->s_fs_info;
   644		int ret;
   645	
   646		/* Acquire mutex */
   647		ret = ffs_mutex_lock(&ffs->mutex, file->f_flags & O_NONBLOCK);
   648		if (ret < 0)
   649			return ret;
   650	
   651		if (ffs->state == FFS_CLOSING) {
   652			mutex_unlock(&ffs->mutex);
   653			return -EBUSY;
   654		}
   655	
   656		if (atomic_add_return(1, &ffs->opened) == 1 &&
   657				ffs->state == FFS_DEACTIVATED) {
   658			ffs->state = FFS_CLOSING;
   659			mutex_unlock(&ffs->mutex);
 > 660			ffs_data_reset(ffs);
   661		} else {
   662			mutex_unlock(&ffs->mutex);
   663		}
   664		file->private_data = ffs;
   665	
   666		return stream_open(inode, file);
   667	}
   668	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

