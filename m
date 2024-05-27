Return-Path: <linux-fsdevel+bounces-20203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154398CF80C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 05:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE501C21188
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141B523D;
	Mon, 27 May 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD7j0/i0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89422107;
	Mon, 27 May 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716780186; cv=none; b=QNdI2aSPOMc0Zc6BcbvnajPOQKBHcsCdUpD+iPRPZRIJLlaeg00j1UAh+4P+04gM1Fo2PWikLiJwH4W12RtLrhggy0FeT+we9t5gKjkIjUdier2wOu3r2CZDBk+WPIz47DA6l7FlbiBkw+LH9jx6F+uiWBmnM+bk+tLnGrSy3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716780186; c=relaxed/simple;
	bh=PlNvD5cU7Dxn2/QW0wAmLIuchmztNAAA6PkqIALlQgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/pcc066HgUPABb+WhKZdPJCV5v9j6f3TtVN9ZLsVVf1WtEBt5nxtJ2+Wh7wPtWzspmUdtwMMuJ1farIk54DebVCaDaI8vlhpswth62QukJNXae2P+trw0qqL562V0dkdjno2SNPRR9MTXTuYDg5/JbnrErH+43y2gz8MdqRE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD7j0/i0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716780185; x=1748316185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PlNvD5cU7Dxn2/QW0wAmLIuchmztNAAA6PkqIALlQgU=;
  b=BD7j0/i0pcf8HIuHO5DcuIeWQZJtalWgY4KKG8CfSD33hFtOxeYtFHP4
   j2tXyEVd0UzbgUVha8HxJvmp+5jB7M5S5wz93DT+mezrmPmFZU+rOXjcM
   hqoXeYPefJrW+IF3BTefyzBiJTwp31CbkFHrlHoczFvua1NgbhAGoFCc6
   XfxkJjPUjkB5TKmxvbJr12l9C/ofAE6iVOdgBRc9f9LRIZHlA/UqDX0uo
   JJA84LDG5ZIZeLqJ2aRCqNo3+kLEIJBxEBSe6dIyOKtIaksaBtBvF25kH
   ktndCibhhkPtKvu/mI0EGvauoW0nHKgGMtOikLl5CqOYoedelxRFdqcSe
   Q==;
X-CSE-ConnectionGUID: h99yO95SRbCkPKbg8Sg3Bw==
X-CSE-MsgGUID: 9vBLLeumRwuvdFwJ29JoiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="30591046"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="30591046"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 20:23:05 -0700
X-CSE-ConnectionGUID: KexBgeAnS1qAgcbMpHGXIA==
X-CSE-MsgGUID: K2Z94t8oRZeJbwe3B8qoCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="35093802"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 May 2024 20:23:00 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBQwr-0009IF-2b;
	Mon, 27 May 2024 03:22:57 +0000
Date: Mon, 27 May 2024 11:22:38 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lczerner@redhat.com, cmaiolino@redhat.com,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	yi.zhang@huawei.com, lihongbo22@huawei.com
Subject: Re: [PATCH 1/4] fs: add blockdev parser for filesystem mount option.
Message-ID: <202405271100.aGNNnrKK-lkp@intel.com>
References: <20240527014717.690140-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527014717.690140-2-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tytso-ext4/dev]
[also build test WARNING on brauner-vfs/vfs.all linus/master v6.10-rc1 next-20240523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/fs-add-blockdev-parser-for-filesystem-mount-option/20240527-094930
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
patch link:    https://lore.kernel.org/r/20240527014717.690140-2-lihongbo22%40huawei.com
patch subject: [PATCH 1/4] fs: add blockdev parser for filesystem mount option.
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240527/202405271100.aGNNnrKK-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240527/202405271100.aGNNnrKK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405271100.aGNNnrKK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/fs_parser.c:324:8: warning: variable 'f' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     324 |                         if (p->flags & fs_param_can_be_empty)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fs_parser.c:343:29: note: uninitialized use occurs here
     343 |         ret = filename_lookup(dfd, f, LOOKUP_FOLLOW, &path, NULL);
         |                                    ^
   fs/fs_parser.c:324:4: note: remove the 'if' if its condition is always true
     324 |                         if (p->flags & fs_param_can_be_empty)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     325 |                                 return 0;
   fs/fs_parser.c:316:20: note: initialize the variable 'f' to silence this warning
     316 |         struct filename *f;
         |                           ^
         |                            = NULL
>> fs/fs_parser.c:324:8: warning: variable 'put_f' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     324 |                         if (p->flags & fs_param_can_be_empty)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fs_parser.c:360:6: note: uninitialized use occurs here
     360 |         if (put_f)
         |             ^~~~~
   fs/fs_parser.c:324:4: note: remove the 'if' if its condition is always true
     324 |                         if (p->flags & fs_param_can_be_empty)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     325 |                                 return 0;
   fs/fs_parser.c:319:12: note: initialize the variable 'put_f' to silence this warning
     319 |         bool put_f;
         |                   ^
         |                    = 0
>> fs/fs_parser.c:324:8: warning: variable 'dfd' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     324 |                         if (p->flags & fs_param_can_be_empty)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fs_parser.c:343:24: note: uninitialized use occurs here
     343 |         ret = filename_lookup(dfd, f, LOOKUP_FOLLOW, &path, NULL);
         |                               ^~~
   fs/fs_parser.c:324:4: note: remove the 'if' if its condition is always true
     324 |                         if (p->flags & fs_param_can_be_empty)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     325 |                                 return 0;
   fs/fs_parser.c:315:9: note: initialize the variable 'dfd' to silence this warning
     315 |         int dfd;
         |                ^
         |                 = 0
   3 warnings generated.


vim +324 fs/fs_parser.c

   310	
   311	int fs_param_is_blockdev(struct p_log *log, const struct fs_parameter_spec *p,
   312			  struct fs_parameter *param, struct fs_parse_result *result)
   313	{
   314		int ret;
   315		int dfd;
   316		struct filename *f;
   317		struct inode *dev_inode;
   318		struct path path;
   319		bool put_f;
   320	
   321		switch (param->type) {
   322		case fs_value_is_string:
   323			if (!*param->string) {
 > 324				if (p->flags & fs_param_can_be_empty)
   325					return 0;
   326				break;
   327			}
   328			f = getname_kernel(param->string);
   329			if (IS_ERR(f))
   330				return fs_param_bad_value(log, param);
   331			dfd = AT_FDCWD;
   332			put_f = true;
   333			break;
   334		case fs_value_is_filename:
   335			f = param->name;
   336			dfd = param->dirfd;
   337			put_f = false;
   338			break;
   339		default:
   340			return fs_param_bad_value(log, param);
   341		}
   342	
   343		ret = filename_lookup(dfd, f, LOOKUP_FOLLOW, &path, NULL);
   344		if (ret < 0) {
   345			error_plog(log, "%s: Lookup failure for '%s'", param->key, f->name);
   346			goto out_putname;
   347		}
   348	
   349		dev_inode = d_backing_inode(path.dentry);
   350		if (!S_ISBLK(dev_inode->i_mode)) {
   351			error_plog(log, "%s: Non-blockdev passed as '%s'", param->key, f->name);
   352			ret = -1;
   353			goto out_putpath;
   354		}
   355		result->uint_32 = new_encode_dev(dev_inode->i_rdev);
   356	
   357	out_putpath:
   358		path_put(&path);
   359	out_putname:
   360		if (put_f)
   361			putname(f);
   362	
   363		return (ret < 0) ? fs_param_bad_value(log, param) : 0;
   364	}
   365	EXPORT_SYMBOL(fs_param_is_blockdev);
   366	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

