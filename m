Return-Path: <linux-fsdevel+bounces-41771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9854A36C53
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 07:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592D71895FAC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 06:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0241922DE;
	Sat, 15 Feb 2025 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjrZ/oIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BADC2ED;
	Sat, 15 Feb 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739601432; cv=none; b=QE2WtjBmzw4a2yeobGWX4E3Qm0AndlwUqtHjApqjlcFXbHTUKknf9ytwANEXQbdraBKsyEOsM+CRUc0SDmXjwyMs6m6cDRh6ZpkrT0fD4Xb749Q5Z+tKw1grFbdk71yRGr7EHdRlLOkB8pbyR3De99459B0YXWN9N07i+EYKlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739601432; c=relaxed/simple;
	bh=xNoorQKTVK0QWI0cD/BSlH3mfl4SWfNf/loP2EWe6lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTdgK7AKGBaxN/srJAMVb1CELHJwGBCs5S5GvjyQzQgrTUuHto/TAt66RckosrG/RFYyA6nf6l+1IE5Ina5INd/tOH8Au5g/VfzFl8mmgFJdqvoOlIpyjYwp2zOgGt4FPy2zUtOGsIeSklZ18Ik4dWqYPFKm3oDF7a6T9M2So/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjrZ/oIG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739601432; x=1771137432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xNoorQKTVK0QWI0cD/BSlH3mfl4SWfNf/loP2EWe6lM=;
  b=UjrZ/oIGCGPy8Qj1aTCNwLLVnMVLoihmfR94CN65jCiqW+Nu6+GMwVgJ
   jPX6XnfUKsr8+MtiPXu9ZOXvietQ4sXX7Ure4mc0d/MdwTafzYDkbsunQ
   9djIgt0eWsLaXl6Al3JpK02qBpTyfqQobCHxVcIMLeS8iTfkHeMFRDklG
   wd9kccZn4rmc8qzyg6SDQML71EIY0L9oN0jR572m4Nr7R+i9u+cs2DzM5
   fpXeHivwz8EC0Q5YqGdhFfrd/fOoDkC9Xa99Lt/Scf73xXgLFH35ExMkU
   +R24mL3z3owhGVSPzXD0imRVLltZZflMpJoKsELTG+azbRUdtwd4DU53o
   Q==;
X-CSE-ConnectionGUID: ehf8eOQjT1Wrv0Bnrn5WHw==
X-CSE-MsgGUID: YRD2V9sbSG2LijKQB9ct9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40480991"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="40480991"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 22:37:11 -0800
X-CSE-ConnectionGUID: QIvQ+UdoRPCdWZQq5yO+/A==
X-CSE-MsgGUID: zOxWroNvQnGTMiUQUDoTnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118566029"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Feb 2025 22:37:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjBnV-001AZB-0e;
	Sat, 15 Feb 2025 06:37:05 +0000
Date: Sat, 15 Feb 2025 14:36:20 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.
Message-ID: <202502151435.jfkY8wb2-lkp@intel.com>
References: <20250214052204.3105610-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214052204.3105610-4-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on trondmy-nfs/linux-next driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus cifs/for-next xfs-linux/for-next linus/master v6.14-rc2 next-20250214]
[cannot apply to ericvh-v9fs/for-next tyhicks-ecryptfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfs-change-mkdir-inode_operation-to-return-alternate-dentry-if-needed/20250214-141741
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250214052204.3105610-4-neilb%40suse.de
patch subject: [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.
config: riscv-randconfig-001-20250215 (https://download.01.org/0day-ci/archive/20250215/202502151435.jfkY8wb2-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502151435.jfkY8wb2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502151435.jfkY8wb2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:812:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     812 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from fs/smb/server/vfs.c:11:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:820:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     820 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from fs/smb/server/vfs.c:11:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:829:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     829 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from fs/smb/server/vfs.c:11:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:838:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     838 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from fs/smb/server/vfs.c:11:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:847:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     847 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from fs/smb/server/vfs.c:11:
   In file included from include/linux/backing-dev.h:16:
   In file included from include/linux/writeback.h:13:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> fs/smb/server/vfs.c:226:2: error: use of undeclared identifier 'entry'; did you mean 'dentry'?
     226 |         entry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
         |         ^~~~~
         |         dentry
   fs/smb/server/vfs.c:209:17: note: 'dentry' declared here
     209 |         struct dentry *dentry, *d;
         |                        ^
   7 warnings and 1 error generated.


vim +226 fs/smb/server/vfs.c

   196	
   197	/**
   198	 * ksmbd_vfs_mkdir() - vfs helper for smb create directory
   199	 * @work:	work
   200	 * @name:	directory name that is relative to share
   201	 * @mode:	directory create mode
   202	 *
   203	 * Return:	0 on success, otherwise error
   204	 */
   205	int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
   206	{
   207		struct mnt_idmap *idmap;
   208		struct path path;
   209		struct dentry *dentry, *d;
   210		int err;
   211	
   212		dentry = ksmbd_vfs_kern_path_create(work, name,
   213						    LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
   214						    &path);
   215		if (IS_ERR(dentry)) {
   216			err = PTR_ERR(dentry);
   217			if (err != -EEXIST)
   218				ksmbd_debug(VFS, "path create failed for %s, err %d\n",
   219					    name, err);
   220			return err;
   221		}
   222	
   223		idmap = mnt_idmap(path.mnt);
   224		mode |= S_IFDIR;
   225		d = dentry;
 > 226		entry = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
   227		err = PTR_ERR_OR_ZERO(dentry);
   228		if (!err && dentry != d)
   229			ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
   230	
   231		done_path_create(&path, dentry);
   232		if (err)
   233			pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
   234		return err;
   235	}
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

