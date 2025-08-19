Return-Path: <linux-fsdevel+bounces-58338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46404B2CDB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E2B3AF7EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 20:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FE322A3D;
	Tue, 19 Aug 2025 20:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqrZjmh3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491E20B81B;
	Tue, 19 Aug 2025 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634776; cv=none; b=FSDTE/xK5ybC37+OhwjGtKdzxs62SUEHgG9g6LKdJeWBZXNzmpIkIxtlpUIa8x1UyxbGJ5qGihBwq/BALAGgeTquXRQ07mco0JNWXTwTThh7bFx/076bL98H83eY98gdP8W0e7Fcd0GRpUnOaWyt+24onD85BgnA3YmnN48nUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634776; c=relaxed/simple;
	bh=lk8OxgimYrAlq8IpJR6TNtSAapP2lwMnm8oZxDFjXeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIl4gM4l+3NLmYqF9PF//5H37as1/XCLPNrgKeW0BxpgQWJ6nwWaT3Jp4OFwG9mOz78eWvU9PZR/qdWciE/BuooBzXLNYF94KksYbfP7ZkTHYJsgLJYMQIi4Ls0kivRSOnJ0+bgOPzSj6NfbTj3zoeCifCsVdsTc7PHBAQq9hwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqrZjmh3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755634774; x=1787170774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lk8OxgimYrAlq8IpJR6TNtSAapP2lwMnm8oZxDFjXeA=;
  b=JqrZjmh392sq5/HywBJHQaStIrnuIGDYXYNY+LMlam15spq+0C9sy7Vj
   M2bopGInLHZyiSxIQRgOEG2vigmT2iqS9BjH/blN5a4klKQrquMGe1KMc
   UtYnHlGdUz2zEeW+LSEI6aEfDGzN4xNVchiQhvt3qRCjDTjhGhGUGK8XJ
   5XvbhXC8yTzxnvswgTfNnJv8EVkwoq117R/YbWHX53tgs9pCxNai4oNDz
   +Mu836+BhP7Bq5HSp+I+owr+ewrdMw36P8jQu9gyrnSo0lpFAvK/KJFoc
   emsi0a54AldR+CH1gqLL51me+TnsW9WXI6Axg4JgOnSnESEr38lx41jTi
   Q==;
X-CSE-ConnectionGUID: 7yrFEJRoRfiP1KqEv809gA==
X-CSE-MsgGUID: 9UXq5iHXTI+66SClRHZ1QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="69272484"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="69272484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 13:19:33 -0700
X-CSE-ConnectionGUID: GmxLShhgTGmsm1z6tueXOQ==
X-CSE-MsgGUID: vTc0bphQQb6aDFc1SqHbYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="167854855"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 19 Aug 2025 13:19:32 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoSmv-000HPv-1w;
	Tue, 19 Aug 2025 20:18:52 +0000
Date: Wed, 20 Aug 2025 04:16:48 +0800
From: kernel test robot <lkp@intel.com>
To: David Disseldorp <ddiss@suse.de>, linux-kbuild@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-next@vger.kernel.org,
	ddiss@suse.de, nsc@kernel.org
Subject: Re: [PATCH v3 8/8] initramfs_test: add filename padding test case
Message-ID: <202508200304.wF1u78il-lkp@intel.com>
References: <20250819032607.28727-9-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819032607.28727-9-ddiss@suse.de>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.17-rc2 next-20250819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Disseldorp/gen_init_cpio-write-to-fd-instead-of-stdout-stream/20250819-115406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250819032607.28727-9-ddiss%40suse.de
patch subject: [PATCH v3 8/8] initramfs_test: add filename padding test case
config: sparc64-randconfig-r121-20250819 (https://download.01.org/0day-ci/archive/20250820/202508200304.wF1u78il-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce: (https://download.01.org/0day-ci/archive/20250820/202508200304.wF1u78il-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508200304.wF1u78il-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> init/initramfs_test.c:415:18: sparse: sparse: Initializer entry defined twice
   init/initramfs_test.c:425:18: sparse:   also defined here

vim +415 init/initramfs_test.c

   388	
   389	/*
   390	 * An initramfs filename is namesize in length, including the zero-terminator.
   391	 * A filename can be zero-terminated prior to namesize, with the remainder used
   392	 * as padding. This can be useful for e.g. alignment of file data segments with
   393	 * a 4KB filesystem block, allowing for extent sharing (reflinks) between cpio
   394	 * source and destination. This hack works with both GNU cpio and initramfs, as
   395	 * long as PATH_MAX isn't exceeded.
   396	 */
   397	static void __init initramfs_test_fname_pad(struct kunit *test)
   398	{
   399		char *err;
   400		size_t len;
   401		struct file *file;
   402		char fdata[] = "this file data is aligned at 4K in the archive";
   403		struct test_fname_pad {
   404			char padded_fname[4096 - CPIO_HDRLEN];
   405			char cpio_srcbuf[CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)];
   406		} *tbufs = kzalloc(sizeof(struct test_fname_pad), GFP_KERNEL);
   407		struct initramfs_test_cpio c[] = { {
   408			.magic = "070701",
   409			.ino = 1,
   410			.mode = S_IFREG | 0777,
   411			.uid = 0,
   412			.gid = 0,
   413			.nlink = 1,
   414			.mtime = 1,
 > 415			.filesize = 0,
   416			.devmajor = 0,
   417			.devminor = 1,
   418			.rdevmajor = 0,
   419			.rdevminor = 0,
   420			/* align file data at 4K archive offset via padded fname */
   421			.namesize = 4096 - CPIO_HDRLEN,
   422			.csum = 0,
   423			.fname = tbufs->padded_fname,
   424			.data = fdata,
   425			.filesize = sizeof(fdata),
   426		} };
   427	
   428		memcpy(tbufs->padded_fname, "padded_fname", sizeof("padded_fname"));
   429		len = fill_cpio(c, ARRAY_SIZE(c), tbufs->cpio_srcbuf);
   430	
   431		err = unpack_to_rootfs(tbufs->cpio_srcbuf, len);
   432		KUNIT_EXPECT_NULL(test, err);
   433	
   434		file = filp_open(c[0].fname, O_RDONLY, 0);
   435		if (IS_ERR(file)) {
   436			KUNIT_FAIL(test, "open failed");
   437			goto out;
   438		}
   439	
   440		/* read back file contents into @cpio_srcbuf and confirm match */
   441		len = kernel_read(file, tbufs->cpio_srcbuf, c[0].filesize, NULL);
   442		KUNIT_EXPECT_EQ(test, len, c[0].filesize);
   443		KUNIT_EXPECT_MEMEQ(test, tbufs->cpio_srcbuf, c[0].data, len);
   444	
   445		fput(file);
   446		KUNIT_EXPECT_EQ(test, init_unlink(c[0].fname), 0);
   447	out:
   448		kfree(tbufs);
   449	}
   450	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

