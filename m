Return-Path: <linux-fsdevel+bounces-19343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 131D98C36B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 15:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E4DB215B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1425569;
	Sun, 12 May 2024 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WR1O31Ot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E6224DC
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715520419; cv=none; b=qcTwXOqpnrskhXkP36ne2ONC17GYB3Ib6b/vsZMGRZpIh7gIir/ziEoiqLI2XC6MyoWep7GwqX2PtUQ1wINOcCZ+oVLEnvn0nteyTVnSwpgLC5vAmPURKGevNgDecGRIqMH/V+DEl615Rpn7SG0w6fLubRV5x+ovWFNNiuViVdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715520419; c=relaxed/simple;
	bh=6lhFPYt8/zeTGIjtkNtvqZubNUwsxR6OTOZhPP86aUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdTwuPffVtb8Dw3tsxVRFbdOzH4Wee6klZ8jE1rDkmUNxHNtsxt5kwz5qSLWczf1RjpPzb1u2mX5QvwDiuhmJmLJYSRl23mYWLXruNDA78fDDGnztEjQXByPY4UVFhhBKwWYKTAKWuR3GZxC905q0PZkcFqN1UBzPsXDUQY/OQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WR1O31Ot; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715520418; x=1747056418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6lhFPYt8/zeTGIjtkNtvqZubNUwsxR6OTOZhPP86aUs=;
  b=WR1O31OtUEpuNeh9sLy7MX4zLnxfKa9FJyrUAGrzE4+PC3zfypXhBBiF
   62fl6Mvx+Cm6OcrmPWX6S2nGPnY7znGeokBjdWGNTUjjOHsaysZr0EGaf
   bqkK/zDmlDpe9TBrPaT3HgloDEOXMLtKObfT+GuUcp/NDxXHa39EI1Jqc
   qmOt+gzzkoyOSe5iarhklIwGqBBCWPqlpv1KJIL6XLE/53+pXWx+s/MAl
   v+HahcBXptRy68uNihC5BBRJi9bBroiUgc2wt3JhBgMNHI8hC2w3CXf2P
   y1/A5FgQZoD9DuiJD6jFiKnLqD93SgGEg7jkEmTRoEQDhoRrR0cRIFQ9m
   A==;
X-CSE-ConnectionGUID: ai7S2aSzQnCHDwioMvgT2g==
X-CSE-MsgGUID: FEzjI6DYStCrAUhFQEAzMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11324796"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11324796"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 06:26:57 -0700
X-CSE-ConnectionGUID: LYFt+jBvQZGKqGgJetw7Gw==
X-CSE-MsgGUID: bnhAmxYsSvCkfo++hOkO0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="30106389"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 May 2024 06:26:55 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s69E5-0008cf-0Y;
	Sun, 12 May 2024 13:26:53 +0000
Date: Sun, 12 May 2024 21:25:54 +0800
From: kernel test robot <lkp@intel.com>
To: Hongbo Li <lihongbo22@huawei.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	lihongbo22@huawei.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] fsconfig: intercept for non-new mount API in
 advance for FSCONFIG_CMD_CREATE_EXCL
Message-ID: <202405122155.PQ2zWM25-lkp@intel.com>
References: <20240511040249.2141380-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511040249.2141380-1-lihongbo22@huawei.com>

Hi Hongbo,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240510]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongbo-Li/fsconfig-intercept-for-non-new-mount-API-in-advance-for-FSCONFIG_CMD_CREATE_EXCL/20240511-120353
base:   next-20240510
patch link:    https://lore.kernel.org/r/20240511040249.2141380-1-lihongbo22%40huawei.com
patch subject: [PATCH -next] fsconfig: intercept for non-new mount API in advance for FSCONFIG_CMD_CREATE_EXCL
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240512/202405122155.PQ2zWM25-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project b910bebc300dafb30569cecc3017b446ea8eafa0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240512/202405122155.PQ2zWM25-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405122155.PQ2zWM25-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/fsopen.c:8:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/fsopen.c:410:8: error: use of undeclared identifier 'FSCONFIG_CMD_CREATE_EXEC'; did you mean 'FSCONFIG_CMD_CREATE_EXCL'?
     410 |                 case FSCONFIG_CMD_CREATE_EXEC:
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~
         |                      FSCONFIG_CMD_CREATE_EXCL
   include/uapi/linux/mount.h:105:2: note: 'FSCONFIG_CMD_CREATE_EXCL' declared here
     105 |         FSCONFIG_CMD_CREATE_EXCL = 8,   /* Create new superblock, fail if reusing existing superblock */
         |         ^
   1 warning and 1 error generated.


vim +410 fs/fsopen.c

   301	
   302	/**
   303	 * sys_fsconfig - Set parameters and trigger actions on a context
   304	 * @fd: The filesystem context to act upon
   305	 * @cmd: The action to take
   306	 * @_key: Where appropriate, the parameter key to set
   307	 * @_value: Where appropriate, the parameter value to set
   308	 * @aux: Additional information for the value
   309	 *
   310	 * This system call is used to set parameters on a context, including
   311	 * superblock settings, data source and security labelling.
   312	 *
   313	 * Actions include triggering the creation of a superblock and the
   314	 * reconfiguration of the superblock attached to the specified context.
   315	 *
   316	 * When setting a parameter, @cmd indicates the type of value being proposed
   317	 * and @_key indicates the parameter to be altered.
   318	 *
   319	 * @_value and @aux are used to specify the value, should a value be required:
   320	 *
   321	 * (*) fsconfig_set_flag: No value is specified.  The parameter must be boolean
   322	 *     in nature.  The key may be prefixed with "no" to invert the
   323	 *     setting. @_value must be NULL and @aux must be 0.
   324	 *
   325	 * (*) fsconfig_set_string: A string value is specified.  The parameter can be
   326	 *     expecting boolean, integer, string or take a path.  A conversion to an
   327	 *     appropriate type will be attempted (which may include looking up as a
   328	 *     path).  @_value points to a NUL-terminated string and @aux must be 0.
   329	 *
   330	 * (*) fsconfig_set_binary: A binary blob is specified.  @_value points to the
   331	 *     blob and @aux indicates its size.  The parameter must be expecting a
   332	 *     blob.
   333	 *
   334	 * (*) fsconfig_set_path: A non-empty path is specified.  The parameter must be
   335	 *     expecting a path object.  @_value points to a NUL-terminated string that
   336	 *     is the path and @aux is a file descriptor at which to start a relative
   337	 *     lookup or AT_FDCWD.
   338	 *
   339	 * (*) fsconfig_set_path_empty: As fsconfig_set_path, but with AT_EMPTY_PATH
   340	 *     implied.
   341	 *
   342	 * (*) fsconfig_set_fd: An open file descriptor is specified.  @_value must be
   343	 *     NULL and @aux indicates the file descriptor.
   344	 */
   345	SYSCALL_DEFINE5(fsconfig,
   346			int, fd,
   347			unsigned int, cmd,
   348			const char __user *, _key,
   349			const void __user *, _value,
   350			int, aux)
   351	{
   352		struct fs_context *fc;
   353		struct fd f;
   354		int ret;
   355		int lookup_flags = 0;
   356	
   357		struct fs_parameter param = {
   358			.type	= fs_value_is_undefined,
   359		};
   360	
   361		if (fd < 0)
   362			return -EINVAL;
   363	
   364		switch (cmd) {
   365		case FSCONFIG_SET_FLAG:
   366			if (!_key || _value || aux)
   367				return -EINVAL;
   368			break;
   369		case FSCONFIG_SET_STRING:
   370			if (!_key || !_value || aux)
   371				return -EINVAL;
   372			break;
   373		case FSCONFIG_SET_BINARY:
   374			if (!_key || !_value || aux <= 0 || aux > 1024 * 1024)
   375				return -EINVAL;
   376			break;
   377		case FSCONFIG_SET_PATH:
   378		case FSCONFIG_SET_PATH_EMPTY:
   379			if (!_key || !_value || (aux != AT_FDCWD && aux < 0))
   380				return -EINVAL;
   381			break;
   382		case FSCONFIG_SET_FD:
   383			if (!_key || _value || aux < 0)
   384				return -EINVAL;
   385			break;
   386		case FSCONFIG_CMD_CREATE:
   387		case FSCONFIG_CMD_CREATE_EXCL:
   388		case FSCONFIG_CMD_RECONFIGURE:
   389			if (_key || _value || aux)
   390				return -EINVAL;
   391			break;
   392		default:
   393			return -EOPNOTSUPP;
   394		}
   395	
   396		f = fdget(fd);
   397		if (!f.file)
   398			return -EBADF;
   399		ret = -EINVAL;
   400		if (f.file->f_op != &fscontext_fops)
   401			goto out_f;
   402	
   403		fc = f.file->private_data;
   404		if (fc->ops == &legacy_fs_context_ops) {
   405			switch (cmd) {
   406			case FSCONFIG_SET_BINARY:
   407			case FSCONFIG_SET_PATH:
   408			case FSCONFIG_SET_PATH_EMPTY:
   409			case FSCONFIG_SET_FD:
 > 410			case FSCONFIG_CMD_CREATE_EXEC:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

