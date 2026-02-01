Return-Path: <linux-fsdevel+bounces-76004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBL5EhQSf2lcjQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 09:43:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D2C5448
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 09:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D56193015452
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B53090D9;
	Sun,  1 Feb 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfn6veDk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D62E2EF9
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769935370; cv=none; b=VsgSmX1aJv1uaKc40lqhW1sT/ZCjWNOO71ZCUsukA+sXQVAc7VzGnUZZtE9pbtbJsAWsXeGURW+6sTiS8L45lQs35Qxi+yYYZTLm1QPSaqJAhD74iC+KZ2XG8EqGSKxjhYQyfI3jpbdg2gv/P+Bdgo2hHRDUrrxAMPpFjw1jcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769935370; c=relaxed/simple;
	bh=HgiWnJM+mf3rUNLbH9B7OKoJ1DgLBVAhG3C+fgLUnUA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fTAVXHfrcvu/L7IW8KHfXcZ1SUgQRLP+c+TaukltOGz0eneTVKl/3PoJekZY3Uvdv7eLJWmh5+dScvZXB0KV7nlsyBiQw9nYf23C4UtFww0c0K+6nO1ubtm49qA4sv3f1NxhNJFJci8aUAyUmdXKdxYoIWh1x4X88X7JI3iDfSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfn6veDk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769935368; x=1801471368;
  h=date:from:to:cc:subject:message-id;
  bh=HgiWnJM+mf3rUNLbH9B7OKoJ1DgLBVAhG3C+fgLUnUA=;
  b=Vfn6veDkp1o6lpDP492Sqd4WoVzGFhleVYJr1vhxPN+bO9qVo/FmogW5
   3Q3R0outeJPKnN2BuhIn5a0U1QgDc63q9svBU2oD7rgSDatMZGfp6ObfF
   VJ7Yg9yvpqowUq73VxySoWGyV96FbxQZD3/UwFmVJIOhAtRDuFaONksSE
   NKdLk4LXtgAHtgiTcnGcLLiWg3tRSw4cbG2ZMGCfcSj0MWYFqxZ0pEEgV
   kGGyhx9RErN2imFvxBQulPa7fR9eKgPWy8o7fVDOy91ppHdiEovJ2GtFJ
   pglYhNDShXsLEiAmJ0G0yi37vU4DrppLLj/v+3HOxJ1mhYN6MOIyRaIYm
   Q==;
X-CSE-ConnectionGUID: szxi1qpeTUGOihM8RYtg2g==
X-CSE-MsgGUID: x8olAdO1SW+J+3K7jBCF0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="82548854"
X-IronPort-AV: E=Sophos;i="6.21,266,1763452800"; 
   d="scan'208";a="82548854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 00:42:48 -0800
X-CSE-ConnectionGUID: bU+ffI72Q2+glm+NA4Arig==
X-CSE-MsgGUID: Q7QH/fMxTwyba/LttpSn7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,266,1763452800"; 
   d="scan'208";a="209617697"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Feb 2026 00:42:46 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmT2Z-00000000efq-342X;
	Sun, 01 Feb 2026 08:42:43 +0000
Date: Sun, 01 Feb 2026 16:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:for-wsamuel2 40/40]
 drivers/usb/gadget/function/f_fs.c:660:17: error: implicit declaration of
 function 'ffs_data_reset'; did you mean 'ffs_data_get'?
Message-ID: <202602011622.nYyDo3kh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76004-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 893D2C5448
X-Rspamd-Action: no action

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git for-wsamuel2
head:   9a8dd89bd5c65c4189f2bf6291f0f9a3d0df31c5
commit: 9a8dd89bd5c65c4189f2bf6291f0f9a3d0df31c5 [40/40] serialize ffs_ep0_open() on ffs->mutex, this time without ffs_data_reset() under ->mutex
config: s390-randconfig-001-20260201 (https://download.01.org/0day-ci/archive/20260201/202602011622.nYyDo3kh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260201/202602011622.nYyDo3kh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602011622.nYyDo3kh-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/usb/gadget/function/f_fs.c: In function 'ffs_ep0_open':
>> drivers/usb/gadget/function/f_fs.c:660:17: error: implicit declaration of function 'ffs_data_reset'; did you mean 'ffs_data_get'? [-Werror=implicit-function-declaration]
     660 |                 ffs_data_reset(ffs);
         |                 ^~~~~~~~~~~~~~
         |                 ffs_data_get
   drivers/usb/gadget/function/f_fs.c: At top level:
>> drivers/usb/gadget/function/f_fs.c:2089:13: warning: conflicting types for 'ffs_data_reset'; have 'void(struct ffs_data *)'
    2089 | static void ffs_data_reset(struct ffs_data *ffs);
         |             ^~~~~~~~~~~~~~
>> drivers/usb/gadget/function/f_fs.c:2089:13: error: static declaration of 'ffs_data_reset' follows non-static declaration
   drivers/usb/gadget/function/f_fs.c:660:17: note: previous implicit declaration of 'ffs_data_reset' with type 'void(struct ffs_data *)'
     660 |                 ffs_data_reset(ffs);
         |                 ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +660 drivers/usb/gadget/function/f_fs.c

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

