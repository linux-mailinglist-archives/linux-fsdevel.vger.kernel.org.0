Return-Path: <linux-fsdevel+bounces-58810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28651B31AAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668C9B01B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693130AADC;
	Fri, 22 Aug 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWqk4RJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46F3074BE;
	Fri, 22 Aug 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871062; cv=none; b=ZpJ7odk9odCnT/wmEVEuE8Leq1dxb+nUbEguoF9dIvg/azyTJVfpzL9iuu0Vurv1WlGgQod4HrqvcBisi09a/xiGAHyqYn0GbwTQDp4MjZg8zpiKvRO2hk9AC0qbKnatde41pjedrTwt3UfLNzDvnX8ucCOOGiqfZJgpVIsXt3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871062; c=relaxed/simple;
	bh=4Ym9yF5fTrA4dks5oCV9NLu3Hj2LMaWfEQG4rZ8T+N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRchxLfXh4MyXu0DT9Eu/xn32GunoXN0hrnqwv1kSQYoQtG3Lufx+lP+QdTfRmasiA0B0fLB9Ne62dRlYYVTMEYCtJNLUSGU8FgUyYspopnQDv7K0pt/cmBhKeHl0Oxrk88n6klmc7T2bFWvNCzme+KBo2XEC482uy5bPTBvaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UWqk4RJe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755871060; x=1787407060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Ym9yF5fTrA4dks5oCV9NLu3Hj2LMaWfEQG4rZ8T+N0=;
  b=UWqk4RJerQyjG4/QSLpROsDfOtokjZySE+74aMAsxG96f4lUiW+BIBOC
   xf51aOIMIBiOK98Dez0Zs0yFDsQJ/fc3OqYGEZlnCWyIcj96wSWxRT2CU
   Z85jGdYBX0JJvdovrtikIh4aGZXtt+X7YE0srdvCWG7kPiOcQFx3aAMRr
   gIdYqFmff0gHzwaxupt87sfvSAxech8OSMHYIZLgsA8dJqFjU6cuJwSuk
   8OQuMc01UauQUq0WrFUz9QKD4bNxltmmvSTAEmMQK70uBNROFrVTnhD4j
   y+AWSWUD73Vb/REYisyvBUd9zuqbNp5guhBvD0faYQFtdiYu5WH0H0GOd
   w==;
X-CSE-ConnectionGUID: U0g1/v51QWqY6lQkmnrlmg==
X-CSE-MsgGUID: ILTcE0iHTPmzl69IQksCpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61821050"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61821050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 06:57:36 -0700
X-CSE-ConnectionGUID: TtaRggd4R2KFb29mZ5ryGQ==
X-CSE-MsgGUID: x3SYgpxDRKm+Ctkwy9TM9g==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 22 Aug 2025 06:57:33 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upSGf-000LMx-1C;
	Fri, 22 Aug 2025 13:57:24 +0000
Date: Fri, 22 Aug 2025 21:56:59 +0800
From: kernel test robot <lkp@intel.com>
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 20/50] fs: convert i_count to refcount_t
Message-ID: <202508222128.KZDs9G7n-lkp@intel.com>
References: <6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef@toxicpanda.com>

Hi Josef,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on kdave/for-next trace/for-next xfs-linux/for-next linus/master v6.17-rc2 next-20250822]
[cannot apply to tytso-ext4/dev]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josef-Bacik/fs-add-an-i_obj_count-refcount-to-the-inode/20250822-045428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/6a12e35a078d765b50bc7ced7030d6cd98065528.1755806649.git.josef%40toxicpanda.com
patch subject: [PATCH 20/50] fs: convert i_count to refcount_t
config: x86_64-randconfig-003-20250822 (https://download.01.org/0day-ci/archive/20250822/202508222128.KZDs9G7n-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508222128.KZDs9G7n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508222128.KZDs9G7n-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/smb/client/inode.c:2782:37: error: no member named 'counter' in 'struct refcount_struct'
    2782 |                  full_path, inode, inode->i_count.counter,
         |                                    ~~~~~~~~~~~~~~ ^
   fs/smb/client/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                                                  ^~~~~~~~~~~
   fs/smb/client/cifs_debug.h:66:23: note: expanded from macro 'cifs_dbg_func'
      66 |                                       __FILE__, ##__VA_ARGS__);         \
         |                                                   ^~~~~~~~~~~
   include/linux/printk.h:693:38: note: expanded from macro 'pr_debug_once'
     693 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                             ^~~~~~~~~~~
   include/linux/printk.h:135:18: note: expanded from macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
>> fs/smb/client/inode.c:2782:37: error: no member named 'counter' in 'struct refcount_struct'
    2782 |                  full_path, inode, inode->i_count.counter,
         |                                    ~~~~~~~~~~~~~~ ^
   fs/smb/client/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                                                  ^~~~~~~~~~~
   fs/smb/client/cifs_debug.h:68:38: note: expanded from macro 'cifs_dbg_func'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                                                    ^~~~~~~~~~~
   include/linux/printk.h:670:38: note: expanded from macro 'pr_err_once'
     670 |         printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                             ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/once_lite.h:31:9: note: expanded from macro 'DO_ONCE_LITE_IF'
      31 |                         func(__VA_ARGS__);                              \
         |                              ^~~~~~~~~~~
   include/linux/printk.h:514:60: note: expanded from macro 'printk'
     514 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:486:19: note: expanded from macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
>> fs/smb/client/inode.c:2782:37: error: no member named 'counter' in 'struct refcount_struct'
    2782 |                  full_path, inode, inode->i_count.counter,
         |                                    ~~~~~~~~~~~~~~ ^
   fs/smb/client/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                                                  ^~~~~~~~~~~
   fs/smb/client/cifs_debug.h:70:32: note: expanded from macro 'cifs_dbg_func'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                                              ^~~~~~~~~~~
   include/linux/printk.h:693:38: note: expanded from macro 'pr_debug_once'
     693 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                             ^~~~~~~~~~~
   include/linux/printk.h:135:18: note: expanded from macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
>> fs/smb/client/inode.c:2782:37: error: no member named 'counter' in 'struct refcount_struct'
    2782 |                  full_path, inode, inode->i_count.counter,
         |                                    ~~~~~~~~~~~~~~ ^
   fs/smb/client/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                                                         ^~~~~~~~~~~
   fs/smb/client/cifs_debug.h:66:23: note: expanded from macro 'cifs_dbg_func'
      66 |                                       __FILE__, ##__VA_ARGS__);         \
         |                                                   ^~~~~~~~~~~
   include/linux/printk.h:758:38: note: expanded from macro 'pr_debug_ratelimited'
     758 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                             ^~~~~~~~~~~
   include/linux/printk.h:135:18: note: expanded from macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
>> fs/smb/client/inode.c:2782:37: error: no member named 'counter' in 'struct refcount_struct'
    2782 |                  full_path, inode, inode->i_count.counter,
         |                                    ~~~~~~~~~~~~~~ ^
   fs/smb/client/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                                                         ^~~~~~~~~~~
   fs/smb/client/cifs_debug.h:68:38: note: expanded from macro 'cifs_dbg_func'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                                                    ^~~~~~~~~~~
   include/linux/printk.h:722:45: note: expanded from macro 'pr_err_ratelimited'
     722 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                                                    ^~~~~~~~~~~
   include/linux/printk.h:708:17: note: expanded from macro 'printk_ratelimited'
     708 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                               ^~~~~~~~~~~
   include/linux/printk.h:514:60: note: expanded from macro 'printk'
     514 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                                                            ^~~~~~~~~~~
   include/linux/printk.h:486:19: note: expanded from macro 'printk_index_wrap'
     486 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
>> fs/smb/client/inode.c:2782:37: error: no member named 'counter' in 'struct refcount_struct'
    2782 |                  full_path, inode, inode->i_count.counter,
         |                                    ~~~~~~~~~~~~~~ ^
   fs/smb/client/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                                                         ^~~~~~~~~~~
   fs/smb/client/cifs_debug.h:70:32: note: expanded from macro 'cifs_dbg_func'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                                              ^~~~~~~~~~~
   include/linux/printk.h:758:38: note: expanded from macro 'pr_debug_ratelimited'
     758 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |                                             ^~~~~~~~~~~
   include/linux/printk.h:135:18: note: expanded from macro 'no_printk'
     135 |                 _printk(fmt, ##__VA_ARGS__);            \
         |                                ^~~~~~~~~~~
   6 errors generated.


vim +2782 fs/smb/client/inode.c

abab095d1fd259 fs/cifs/inode.c       Jeff Layton     2010-02-12  2755  
6feb9891da4f8b fs/cifs/inode.c       Pavel Shilovsky 2011-04-07  2756  int cifs_revalidate_dentry_attr(struct dentry *dentry)
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2757  {
6d5786a34d98bf fs/cifs/inode.c       Pavel Shilovsky 2012-06-20  2758  	unsigned int xid;
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2759  	int rc = 0;
2b0143b5c986be fs/cifs/inode.c       David Howells   2015-03-17  2760  	struct inode *inode = d_inode(dentry);
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2761  	struct super_block *sb = dentry->d_sb;
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2762  	const char *full_path;
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2763  	void *page;
fc513fac56e1b6 fs/cifs/inode.c       Ronnie Sahlberg 2020-02-19  2764  	int count = 0;
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2765  
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2766  	if (inode == NULL)
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2767  		return -ENOENT;
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2768  
ed8561fa1d12b4 fs/cifs/inode.c       Ronnie Sahlberg 2021-03-09  2769  	if (!cifs_dentry_needs_reval(dentry))
6feb9891da4f8b fs/cifs/inode.c       Pavel Shilovsky 2011-04-07  2770  		return rc;
6feb9891da4f8b fs/cifs/inode.c       Pavel Shilovsky 2011-04-07  2771  
6d5786a34d98bf fs/cifs/inode.c       Pavel Shilovsky 2012-06-20  2772  	xid = get_xid();
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2773  
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2774  	page = alloc_dentry_path();
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2775  	full_path = build_path_from_dentry(dentry, page);
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2776  	if (IS_ERR(full_path)) {
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2777  		rc = PTR_ERR(full_path);
6feb9891da4f8b fs/cifs/inode.c       Pavel Shilovsky 2011-04-07  2778  		goto out;
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2779  	}
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2780  
f96637be081141 fs/cifs/inode.c       Joe Perches     2013-05-04  2781  	cifs_dbg(FYI, "Update attributes: %s inode 0x%p count %d dentry: 0x%p d_time %ld jiffies %ld\n",
f96637be081141 fs/cifs/inode.c       Joe Perches     2013-05-04 @2782  		 full_path, inode, inode->i_count.counter,
a00be0e31f8df4 fs/cifs/inode.c       Miklos Szeredi  2016-09-16  2783  		 dentry, cifs_get_time(dentry), jiffies);
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2784  
fc513fac56e1b6 fs/cifs/inode.c       Ronnie Sahlberg 2020-02-19  2785  again:
102466f303ffcd fs/smb/client/inode.c Paulo Alcantara 2023-11-25  2786  	if (cifs_sb_master_tcon(CIFS_SB(sb))->posix_extensions) {
102466f303ffcd fs/smb/client/inode.c Paulo Alcantara 2023-11-25  2787  		rc = smb311_posix_get_inode_info(&inode, full_path,
102466f303ffcd fs/smb/client/inode.c Paulo Alcantara 2023-11-25  2788  						 NULL, sb, xid);
102466f303ffcd fs/smb/client/inode.c Paulo Alcantara 2023-11-25  2789  	} else if (cifs_sb_master_tcon(CIFS_SB(sb))->unix_ext) {
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2790  		rc = cifs_get_inode_info_unix(&inode, full_path, sb, xid);
102466f303ffcd fs/smb/client/inode.c Paulo Alcantara 2023-11-25  2791  	} else {
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2792  		rc = cifs_get_inode_info(&inode, full_path, NULL, sb,
df2cf170c823ba fs/cifs/inode.c       Jeff Layton     2010-02-12  2793  					 xid, NULL);
102466f303ffcd fs/smb/client/inode.c Paulo Alcantara 2023-11-25  2794  	}
fc513fac56e1b6 fs/cifs/inode.c       Ronnie Sahlberg 2020-02-19  2795  	if (rc == -EAGAIN && count++ < 10)
fc513fac56e1b6 fs/cifs/inode.c       Ronnie Sahlberg 2020-02-19  2796  		goto again;
6feb9891da4f8b fs/cifs/inode.c       Pavel Shilovsky 2011-04-07  2797  out:
f6a9bc336b600e fs/cifs/inode.c       Al Viro         2021-03-05  2798  	free_dentry_path(page);
6d5786a34d98bf fs/cifs/inode.c       Pavel Shilovsky 2012-06-20  2799  	free_xid(xid);
fc513fac56e1b6 fs/cifs/inode.c       Ronnie Sahlberg 2020-02-19  2800  
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2801  	return rc;
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2802  }
^1da177e4c3f41 fs/cifs/inode.c       Linus Torvalds  2005-04-16  2803  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

