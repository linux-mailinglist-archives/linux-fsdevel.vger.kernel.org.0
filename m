Return-Path: <linux-fsdevel+bounces-24454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395E93F921
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC7DB210C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837E915624C;
	Mon, 29 Jul 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnFP4Jpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB46156227
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265775; cv=none; b=C+mwanG5SeYnzQ+qz8yCi0nX12RVuzgCiiiry0RIcuAXKEU+jqI2zhalRkdEEZcQlgXi6E7O2/u/wbZrg1wU3/ap8A/waAcwArJ/4sWiI8b8x1ohBocWePiB9XX3PWPSKidDBU3AUg7KhgOmVwbcDdJHZfeqYbG61Ltscrj0oGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265775; c=relaxed/simple;
	bh=Fd/8876iNMwA1KNeyr4kgQJanlEe8Ga/ww9gdUaiPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a8DgEzdZtfocx/oRldYnmheltP//LJ4lBKq0H1y2DRQeqFN13upx7E/MGs+wjOVRGm5t0cq2yBM1L4fdtwFP01zXARPsJIpQ8cBkwf1xvk3C+nZpUxyjVRk4KbYOaC59yE0EkokP9jus7tuUJt5dF6pIawdpUlV73AXB7HvUXRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnFP4Jpc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722265773; x=1753801773;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fd/8876iNMwA1KNeyr4kgQJanlEe8Ga/ww9gdUaiPPM=;
  b=NnFP4Jpc+FIi8tBHhrYfOh07OCggqe92v4L37zLMJ9/Z+CpbFpgaafHR
   zo7e2QlQ/MqNMjmKh9eCjwfaKZaGC2eid/Yl/8H0G7G5HAnMZbTB3eq3E
   e3KA2ZQR0BvPS3TDI0nbq/j6qtIuFPyY06AJGP/bGRYFzObwO7m5Apw9M
   DGAT6N4tL37fwNlVUxoghh7O2Xrht7dy6av/vGw2xXv7RqXn0323uuWAv
   nHLs09mciKuIL4kSVY9+N/nruQeO90smnRG8XtCaeoStrGzDuPdQ2biHv
   UMe8WdQFtGVTTEgEQ/zoju019ItxWDEmeIumxxlt5CwsjPFgemsZdGl9w
   A==;
X-CSE-ConnectionGUID: kWYGKtZuSxusHCNzIMutOQ==
X-CSE-MsgGUID: YASMMFyaQwKX0yntTjEiVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="30647986"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="30647986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:07:52 -0700
X-CSE-ConnectionGUID: E6CneNDhTiKSdrvWTH/ZBw==
X-CSE-MsgGUID: Hi9bt3wRSy+heb9gdzoCWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="53972091"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2024 08:07:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYRyW-000rn2-2b;
	Mon, 29 Jul 2024 15:07:48 +0000
Date: Mon, 29 Jul 2024 23:07:02 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.fd 28/39] include/linux/cleanup.h:111:21: error:
 function declaration isn't a prototype
Message-ID: <202407292309.QXlzRsZS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.fd
head:   154eb19a802fdf8629273d414dbeb31eccb61587
commit: a5027b86a79716e98fe0b8e1247743dfb5a5c080 [28/39] switch spufs_calls_{get,put}() to CLASS() use
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240729/202407292309.QXlzRsZS-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407292309.QXlzRsZS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407292309.QXlzRsZS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/file.h:14,
                    from arch/powerpc/platforms/cell/spu_syscalls.c:10:
>> include/linux/cleanup.h:111:21: error: function declaration isn't a prototype [-Werror=strict-prototypes]
     111 | static inline _type class_##_name##_constructor(_init_args)             \
         |                     ^~~~~~
   arch/powerpc/platforms/cell/spu_syscalls.c:59:1: note: in expansion of macro 'DEFINE_CLASS'
      59 | DEFINE_CLASS(spufs_calls, struct spufs_calls *, spufs_calls_put(_T), spufs_calls_get())
         | ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +111 include/linux/cleanup.h

54da6a0924311c Peter Zijlstra 2023-05-26   82  
54da6a0924311c Peter Zijlstra 2023-05-26   83  
54da6a0924311c Peter Zijlstra 2023-05-26   84  /*
54da6a0924311c Peter Zijlstra 2023-05-26   85   * DEFINE_CLASS(name, type, exit, init, init_args...):
54da6a0924311c Peter Zijlstra 2023-05-26   86   *	helper to define the destructor and constructor for a type.
54da6a0924311c Peter Zijlstra 2023-05-26   87   *	@exit is an expression using '_T' -- similar to FREE above.
54da6a0924311c Peter Zijlstra 2023-05-26   88   *	@init is an expression in @init_args resulting in @type
54da6a0924311c Peter Zijlstra 2023-05-26   89   *
54da6a0924311c Peter Zijlstra 2023-05-26   90   * EXTEND_CLASS(name, ext, init, init_args...):
54da6a0924311c Peter Zijlstra 2023-05-26   91   *	extends class @name to @name@ext with the new constructor
54da6a0924311c Peter Zijlstra 2023-05-26   92   *
54da6a0924311c Peter Zijlstra 2023-05-26   93   * CLASS(name, var)(args...):
54da6a0924311c Peter Zijlstra 2023-05-26   94   *	declare the variable @var as an instance of the named class
54da6a0924311c Peter Zijlstra 2023-05-26   95   *
54da6a0924311c Peter Zijlstra 2023-05-26   96   * Ex.
54da6a0924311c Peter Zijlstra 2023-05-26   97   *
54da6a0924311c Peter Zijlstra 2023-05-26   98   * DEFINE_CLASS(fdget, struct fd, fdput(_T), fdget(fd), int fd)
54da6a0924311c Peter Zijlstra 2023-05-26   99   *
54da6a0924311c Peter Zijlstra 2023-05-26  100   *	CLASS(fdget, f)(fd);
a825760957e3aa Al Viro        2024-05-31  101   *	if (!fd_file(f))
54da6a0924311c Peter Zijlstra 2023-05-26  102   *		return -EBADF;
54da6a0924311c Peter Zijlstra 2023-05-26  103   *
54da6a0924311c Peter Zijlstra 2023-05-26  104   *	// use 'f' without concern
54da6a0924311c Peter Zijlstra 2023-05-26  105   */
54da6a0924311c Peter Zijlstra 2023-05-26  106  
54da6a0924311c Peter Zijlstra 2023-05-26  107  #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
54da6a0924311c Peter Zijlstra 2023-05-26  108  typedef _type class_##_name##_t;					\
54da6a0924311c Peter Zijlstra 2023-05-26  109  static inline void class_##_name##_destructor(_type *p)			\
54da6a0924311c Peter Zijlstra 2023-05-26  110  { _type _T = *p; _exit; }						\
54da6a0924311c Peter Zijlstra 2023-05-26 @111  static inline _type class_##_name##_constructor(_init_args)		\
54da6a0924311c Peter Zijlstra 2023-05-26  112  { _type t = _init; return t; }
54da6a0924311c Peter Zijlstra 2023-05-26  113  

:::::: The code at line 111 was first introduced by commit
:::::: 54da6a0924311c7cf5015533991e44fb8eb12773 locking: Introduce __cleanup() based infrastructure

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

