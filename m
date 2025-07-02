Return-Path: <linux-fsdevel+bounces-53615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2FAF1028
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 11:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1F717B860
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 09:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D324EAB2;
	Wed,  2 Jul 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfMSTnt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645AE24DD1F;
	Wed,  2 Jul 2025 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449126; cv=none; b=jSO5UIm6jI+agfAXCYwDPaRsPeVaFjKymOXhjDZaKpCkbG73qh6sErRVelW6LPgdE1d1NCv+dou6yqHjd7sKR3I1jFPq86Ktj6ngnVi9Kv0vw2x+A5sEYxcIXcTTeoUrU/aEpfmoxLF4yjqnL85+daC+BQVtpvUtu+9szXceSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449126; c=relaxed/simple;
	bh=8h5yhlQZTlCH63EhsQeoliFKG47GizkjYq0xiXyjzPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDPFpTWPkIYrJ/cSHchWgJ+2pnCSlrt4RpxtJfU4jkinYIWqFCn62xW9eAUjt9tcYjeHxmR6jfb/gLQrIWcrdL+sCOtNRXow+dzTNlcJNf6sx+woZrmp/x2rrYNkkeIYFnjB8fuZ3X34UdAFfVmjpMQIOqEUBCU1RqurOTG+ypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfMSTnt2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449123; x=1782985123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8h5yhlQZTlCH63EhsQeoliFKG47GizkjYq0xiXyjzPM=;
  b=bfMSTnt2YQh1/fVftgTJLnjuCAEzChCQ2nlszKXPnj+DzseIn89vuO+r
   q2LU4LCs/Hwo6i7Q5ZSJ90xf5MuWXrBJ/iWXzWdGmCaz2SrHjTtytHrIH
   FxloYUglG73fApsXfIrWraC/xTCLnecTZKqNh4kTAj5FsSNMCVBb8LdBO
   xDcFAdbnvK/m10/DM4/MrEwEBCASznnbFkrmhQR/cdgJIq/D6LZtkgLDC
   cSXMayBT+Vp2Vwy9+pCE2ToZkwMvpcc0kSZFeCxR8w4aEtSt79bScruzR
   VrPQBtNiJebJ++RtuU7leHff33g6ozk5nMhczTX5ofOpVkM11NW76Kz2z
   Q==;
X-CSE-ConnectionGUID: lZx9KtuBQMW262QlFMgvvg==
X-CSE-MsgGUID: yM5onriqQBufBe7zEkVN5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53828334"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53828334"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:38:42 -0700
X-CSE-ConnectionGUID: JFcumAsbRv6XdQqBqByDSA==
X-CSE-MsgGUID: W7t/IrywQD2y/DuJ3PuGKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159733190"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Jul 2025 02:38:40 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWtvJ-0000T1-2j;
	Wed, 02 Jul 2025 09:38:37 +0000
Date: Wed, 2 Jul 2025 17:38:16 +0800
From: kernel test robot <lkp@intel.com>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 5/6] btrfs: implement shutdown ioctl
Message-ID: <202507021710.jq2jhLL2-lkp@intel.com>
References: <7572ae432f4caebf074e0b9db8a88a502aed3217.1751347436.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7572ae432f4caebf074e0b9db8a88a502aed3217.1751347436.git.wqu@suse.com>

Hi Qu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on brauner-vfs/vfs.all tytso-ext4/dev jaegeuk-f2fs/dev xfs-linux/for-next linus/master v6.16-rc4 next-20250701]
[cannot apply to jaegeuk-f2fs/dev-test]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qu-Wenruo/fs-enhance-and-rename-shutdown-callback-to-remove_bdev/20250701-133555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/7572ae432f4caebf074e0b9db8a88a502aed3217.1751347436.git.wqu%40suse.com
patch subject: [PATCH v2 5/6] btrfs: implement shutdown ioctl
config: arm-randconfig-001-20250702 (https://download.01.org/0day-ci/archive/20250702/202507021710.jq2jhLL2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250702/202507021710.jq2jhLL2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507021710.jq2jhLL2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/btrfs/ioctl.c:5250:16: warning: unused variable 'flags' [-Wunused-variable]
    5250 |         unsigned long flags;
         |                       ^~~~~
   1 warning generated.


vim +/flags +5250 fs/btrfs/ioctl.c

  5241	
  5242	long btrfs_ioctl(struct file *file, unsigned int
  5243			cmd, unsigned long arg)
  5244	{
  5245		struct inode *inode = file_inode(file);
  5246		struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
  5247		struct btrfs_root *root = BTRFS_I(inode)->root;
  5248		void __user *argp = (void __user *)arg;
  5249		/* If @arg is just an unsigned long value. */
> 5250		unsigned long flags;
  5251	
  5252		switch (cmd) {
  5253		case FS_IOC_GETVERSION:
  5254			return btrfs_ioctl_getversion(inode, argp);
  5255		case FS_IOC_GETFSLABEL:
  5256			return btrfs_ioctl_get_fslabel(fs_info, argp);
  5257		case FS_IOC_SETFSLABEL:
  5258			return btrfs_ioctl_set_fslabel(file, argp);
  5259		case FITRIM:
  5260			return btrfs_ioctl_fitrim(fs_info, argp);
  5261		case BTRFS_IOC_SNAP_CREATE:
  5262			return btrfs_ioctl_snap_create(file, argp, 0);
  5263		case BTRFS_IOC_SNAP_CREATE_V2:
  5264			return btrfs_ioctl_snap_create_v2(file, argp, 0);
  5265		case BTRFS_IOC_SUBVOL_CREATE:
  5266			return btrfs_ioctl_snap_create(file, argp, 1);
  5267		case BTRFS_IOC_SUBVOL_CREATE_V2:
  5268			return btrfs_ioctl_snap_create_v2(file, argp, 1);
  5269		case BTRFS_IOC_SNAP_DESTROY:
  5270			return btrfs_ioctl_snap_destroy(file, argp, false);
  5271		case BTRFS_IOC_SNAP_DESTROY_V2:
  5272			return btrfs_ioctl_snap_destroy(file, argp, true);
  5273		case BTRFS_IOC_SUBVOL_GETFLAGS:
  5274			return btrfs_ioctl_subvol_getflags(BTRFS_I(inode), argp);
  5275		case BTRFS_IOC_SUBVOL_SETFLAGS:
  5276			return btrfs_ioctl_subvol_setflags(file, argp);
  5277		case BTRFS_IOC_DEFAULT_SUBVOL:
  5278			return btrfs_ioctl_default_subvol(file, argp);
  5279		case BTRFS_IOC_DEFRAG:
  5280			return btrfs_ioctl_defrag(file, NULL);
  5281		case BTRFS_IOC_DEFRAG_RANGE:
  5282			return btrfs_ioctl_defrag(file, argp);
  5283		case BTRFS_IOC_RESIZE:
  5284			return btrfs_ioctl_resize(file, argp);
  5285		case BTRFS_IOC_ADD_DEV:
  5286			return btrfs_ioctl_add_dev(fs_info, argp);
  5287		case BTRFS_IOC_RM_DEV:
  5288			return btrfs_ioctl_rm_dev(file, argp);
  5289		case BTRFS_IOC_RM_DEV_V2:
  5290			return btrfs_ioctl_rm_dev_v2(file, argp);
  5291		case BTRFS_IOC_FS_INFO:
  5292			return btrfs_ioctl_fs_info(fs_info, argp);
  5293		case BTRFS_IOC_DEV_INFO:
  5294			return btrfs_ioctl_dev_info(fs_info, argp);
  5295		case BTRFS_IOC_TREE_SEARCH:
  5296			return btrfs_ioctl_tree_search(root, argp);
  5297		case BTRFS_IOC_TREE_SEARCH_V2:
  5298			return btrfs_ioctl_tree_search_v2(root, argp);
  5299		case BTRFS_IOC_INO_LOOKUP:
  5300			return btrfs_ioctl_ino_lookup(root, argp);
  5301		case BTRFS_IOC_INO_PATHS:
  5302			return btrfs_ioctl_ino_to_path(root, argp);
  5303		case BTRFS_IOC_LOGICAL_INO:
  5304			return btrfs_ioctl_logical_to_ino(fs_info, argp, 1);
  5305		case BTRFS_IOC_LOGICAL_INO_V2:
  5306			return btrfs_ioctl_logical_to_ino(fs_info, argp, 2);
  5307		case BTRFS_IOC_SPACE_INFO:
  5308			return btrfs_ioctl_space_info(fs_info, argp);
  5309		case BTRFS_IOC_SYNC: {
  5310			int ret;
  5311	
  5312			ret = btrfs_start_delalloc_roots(fs_info, LONG_MAX, false);
  5313			if (ret)
  5314				return ret;
  5315			ret = btrfs_sync_fs(inode->i_sb, 1);
  5316			/*
  5317			 * There may be work for the cleaner kthread to do (subvolume
  5318			 * deletion, delayed iputs, defrag inodes, etc), so wake it up.
  5319			 */
  5320			wake_up_process(fs_info->cleaner_kthread);
  5321			return ret;
  5322		}
  5323		case BTRFS_IOC_START_SYNC:
  5324			return btrfs_ioctl_start_sync(root, argp);
  5325		case BTRFS_IOC_WAIT_SYNC:
  5326			return btrfs_ioctl_wait_sync(fs_info, argp);
  5327		case BTRFS_IOC_SCRUB:
  5328			return btrfs_ioctl_scrub(file, argp);
  5329		case BTRFS_IOC_SCRUB_CANCEL:
  5330			return btrfs_ioctl_scrub_cancel(fs_info);
  5331		case BTRFS_IOC_SCRUB_PROGRESS:
  5332			return btrfs_ioctl_scrub_progress(fs_info, argp);
  5333		case BTRFS_IOC_BALANCE_V2:
  5334			return btrfs_ioctl_balance(file, argp);
  5335		case BTRFS_IOC_BALANCE_CTL:
  5336			return btrfs_ioctl_balance_ctl(fs_info, arg);
  5337		case BTRFS_IOC_BALANCE_PROGRESS:
  5338			return btrfs_ioctl_balance_progress(fs_info, argp);
  5339		case BTRFS_IOC_SET_RECEIVED_SUBVOL:
  5340			return btrfs_ioctl_set_received_subvol(file, argp);
  5341	#ifdef CONFIG_64BIT
  5342		case BTRFS_IOC_SET_RECEIVED_SUBVOL_32:
  5343			return btrfs_ioctl_set_received_subvol_32(file, argp);
  5344	#endif
  5345		case BTRFS_IOC_SEND:
  5346			return _btrfs_ioctl_send(root, argp, false);
  5347	#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
  5348		case BTRFS_IOC_SEND_32:
  5349			return _btrfs_ioctl_send(root, argp, true);
  5350	#endif
  5351		case BTRFS_IOC_GET_DEV_STATS:
  5352			return btrfs_ioctl_get_dev_stats(fs_info, argp);
  5353		case BTRFS_IOC_QUOTA_CTL:
  5354			return btrfs_ioctl_quota_ctl(file, argp);
  5355		case BTRFS_IOC_QGROUP_ASSIGN:
  5356			return btrfs_ioctl_qgroup_assign(file, argp);
  5357		case BTRFS_IOC_QGROUP_CREATE:
  5358			return btrfs_ioctl_qgroup_create(file, argp);
  5359		case BTRFS_IOC_QGROUP_LIMIT:
  5360			return btrfs_ioctl_qgroup_limit(file, argp);
  5361		case BTRFS_IOC_QUOTA_RESCAN:
  5362			return btrfs_ioctl_quota_rescan(file, argp);
  5363		case BTRFS_IOC_QUOTA_RESCAN_STATUS:
  5364			return btrfs_ioctl_quota_rescan_status(fs_info, argp);
  5365		case BTRFS_IOC_QUOTA_RESCAN_WAIT:
  5366			return btrfs_ioctl_quota_rescan_wait(fs_info);
  5367		case BTRFS_IOC_DEV_REPLACE:
  5368			return btrfs_ioctl_dev_replace(fs_info, argp);
  5369		case BTRFS_IOC_GET_SUPPORTED_FEATURES:
  5370			return btrfs_ioctl_get_supported_features(argp);
  5371		case BTRFS_IOC_GET_FEATURES:
  5372			return btrfs_ioctl_get_features(fs_info, argp);
  5373		case BTRFS_IOC_SET_FEATURES:
  5374			return btrfs_ioctl_set_features(file, argp);
  5375		case BTRFS_IOC_GET_SUBVOL_INFO:
  5376			return btrfs_ioctl_get_subvol_info(inode, argp);
  5377		case BTRFS_IOC_GET_SUBVOL_ROOTREF:
  5378			return btrfs_ioctl_get_subvol_rootref(root, argp);
  5379		case BTRFS_IOC_INO_LOOKUP_USER:
  5380			return btrfs_ioctl_ino_lookup_user(file, argp);
  5381		case FS_IOC_ENABLE_VERITY:
  5382			return fsverity_ioctl_enable(file, (const void __user *)argp);
  5383		case FS_IOC_MEASURE_VERITY:
  5384			return fsverity_ioctl_measure(file, argp);
  5385		case FS_IOC_READ_VERITY_METADATA:
  5386			return fsverity_ioctl_read_metadata(file, argp);
  5387		case BTRFS_IOC_ENCODED_READ:
  5388			return btrfs_ioctl_encoded_read(file, argp, false);
  5389		case BTRFS_IOC_ENCODED_WRITE:
  5390			return btrfs_ioctl_encoded_write(file, argp, false);
  5391	#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
  5392		case BTRFS_IOC_ENCODED_READ_32:
  5393			return btrfs_ioctl_encoded_read(file, argp, true);
  5394		case BTRFS_IOC_ENCODED_WRITE_32:
  5395			return btrfs_ioctl_encoded_write(file, argp, true);
  5396	#endif
  5397		case BTRFS_IOC_SUBVOL_SYNC_WAIT:
  5398			return btrfs_ioctl_subvol_sync(fs_info, argp);
  5399	#ifdef CONFIG_BTRFS_EXPERIMENTAL
  5400		case BTRFS_IOC_SHUTDOWN:
  5401			if (!capable(CAP_SYS_ADMIN))
  5402				return -EPERM;
  5403			if (get_user(flags, (__u32 __user *)arg))
  5404				return -EFAULT;
  5405			return btrfs_emergency_shutdown(fs_info, flags);
  5406	#endif
  5407		}
  5408	
  5409		return -ENOTTY;
  5410	}
  5411	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

