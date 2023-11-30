Return-Path: <linux-fsdevel+bounces-4458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC537FF9C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E151C20CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC953801
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtFDEWtR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683910D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 09:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701364267; x=1732900267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T2ohSyGygnVmFJU7qsTvN07gwTnTpebl88jUrSzTp2s=;
  b=RtFDEWtRZhD20zCelbwO+nsvO0gmeKqaY4dfsMYrB5fgWozc6fbBe6tq
   l3A98AdieQYj9gfy9+dP+ekTmwnkuWg92BDbjxk1phRmb60SAe3ad6Wrx
   ngqJ1QKyQxItVQ7fN7uuPoQPdfjfqDc5pZdSvNhfUvAJDFkJYTG9PHwR4
   JfYhFAm2KpFcBb7rvOe8R4jhdPPuSF4uol5Fm4QMPU5SLm6uXTIVkFLyB
   zbA/UqrZXh6UX6CCAUBj5WfITh7PZ07/qfKXDKzF4z9vOpH2tcV5KLvxe
   t7QvwTsG7pGbFVUrSDA08oov/TvixgAH7qdVLkaG1Aym0vUffqXpsVjvX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="347282"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="347282"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 09:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="798371518"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="798371518"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2023 09:11:04 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8kZ3-0002R8-2C;
	Thu, 30 Nov 2023 17:11:01 +0000
Date: Fri, 1 Dec 2023 01:10:10 +0800
From: kernel test robot <lkp@intel.com>
To: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"Andy.Wu@sony.com" <Andy.Wu@sony.com>,
	"Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
	"cpgs@samsung.com" <cpgs@samsung.com>
Subject: Re: [PATCH v5 1/2] exfat: change to get file size from DataLength
Message-ID: <202312010044.6CIJOsWq-lkp@intel.com>
References: <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PUZPR04MB6316F0640983B00CC55D903F8182A@PUZPR04MB6316.apcprd04.prod.outlook.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc3 next-20231130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuezhang-Mo-sony-com/exfat-do-not-zero-the-extended-part/20231130-164222
base:   linus/master
patch link:    https://lore.kernel.org/r/PUZPR04MB6316F0640983B00CC55D903F8182A%40PUZPR04MB6316.apcprd04.prod.outlook.com
patch subject: [PATCH v5 1/2] exfat: change to get file size from DataLength
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231201/202312010044.6CIJOsWq-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231201/202312010044.6CIJOsWq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312010044.6CIJOsWq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/exfat/file.c:543:22: warning: format specifies type 'long' but the argument has type 'ssize_t' (aka 'int') [-Wformat]
                                   valid_size, pos, ret);
                                                    ^~~
   fs/exfat/exfat_fs.h:545:51: note: expanded from macro 'exfat_err'
           pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
                                    ~~~                     ^~~~~~~~~~~
   include/linux/printk.h:498:33: note: expanded from macro 'pr_err'
           printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
                                  ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +543 fs/exfat/file.c

   520	
   521	static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
   522	{
   523		ssize_t ret;
   524		struct file *file = iocb->ki_filp;
   525		struct inode *inode = file_inode(file);
   526		struct exfat_inode_info *ei = EXFAT_I(inode);
   527		loff_t pos = iocb->ki_pos;
   528		loff_t valid_size;
   529	
   530		inode_lock(inode);
   531	
   532		valid_size = ei->valid_size;
   533	
   534		ret = generic_write_checks(iocb, iter);
   535		if (ret < 0)
   536			goto unlock;
   537	
   538		if (pos > valid_size) {
   539			ret = exfat_file_zeroed_range(file, valid_size, pos);
   540			if (ret < 0 && ret != -ENOSPC) {
   541				exfat_err(inode->i_sb,
   542					"write: fail to zero from %llu to %llu(%ld)",
 > 543					valid_size, pos, ret);
   544			}
   545			if (ret < 0)
   546				goto unlock;
   547		}
   548	
   549		ret = __generic_file_write_iter(iocb, iter);
   550		if (ret < 0)
   551			goto unlock;
   552	
   553		inode_unlock(inode);
   554	
   555		if (pos > valid_size)
   556			pos = valid_size;
   557	
   558		if (iocb_is_dsync(iocb) && iocb->ki_pos > pos) {
   559			ssize_t err = vfs_fsync_range(file, pos, iocb->ki_pos - 1,
   560					iocb->ki_flags & IOCB_SYNC);
   561			if (err < 0)
   562				return err;
   563		}
   564	
   565		return ret;
   566	
   567	unlock:
   568		inode_unlock(inode);
   569	
   570		return ret;
   571	}
   572	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

