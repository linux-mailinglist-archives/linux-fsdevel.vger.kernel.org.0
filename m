Return-Path: <linux-fsdevel+bounces-66678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA05C28434
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 18:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06C4F4E1BE9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D1D277C9B;
	Sat,  1 Nov 2025 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGHSl59l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13752701D8;
	Sat,  1 Nov 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762019379; cv=none; b=R0fGg0Ear8RQ6bLwaHVavEQnXKjlrlV7epbJd9XzReMGfGALMSVyzVyCmryOpXoeTrjFFtjf3j/8JaEAHetDaK1w4soQ2/s1PFJ+owCze1U2LobPxVFf1N70slEPJfESWPBFosoN+S22WNvRjNMbNYcF3M89zPpVbZ6L9NiSVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762019379; c=relaxed/simple;
	bh=ij1XrhRwLm7shGtODy/du1WAYcGn3j6QGULbLxSBhh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oADz4o0T1GwJWbABM0AYTK7UoS6OnHDXR1aVS7pRdtg3yF7JAuhS4BYSCIG9LCym4qiaXOvCstew+fnAtzaLGBmojtTlIEL316fshKPt4QCy8pIUixRGftxkNIbU9goKNUHZAuCLI7O/bU71BmC5IThT3KUYtp6DcmbF0qGRPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGHSl59l; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762019378; x=1793555378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ij1XrhRwLm7shGtODy/du1WAYcGn3j6QGULbLxSBhh4=;
  b=IGHSl59lzym8cxNWkwHd+Noll82xG1txm9NC56/f5BDbJ1poD57iAJjK
   82gFy9x/7oY0odRI2HW41D/0Xpqlx0u1jYDK+Td6URBuGFNA+m3nZcTjc
   EVjFESqPxQH2aC0gVXLS08VPLufn+NcqjqVo4TnS58QKAZMKe/xZK30Pb
   FRqmn0q47Zbg3QvDW1sfZVLcifDpGp/t8ebUT3LeK/pLnUsm9Wkrj+bNS
   yg8sm5m2rZdEa7CsN8MLdF2pO3vckk3kD6A1AgazS/a5WFAfxlEX2kPVO
   anOXUILLfGTuxmsRJz/7LRYTrEwjxoF07s0BO/Y5WotIDuTAqsAly8cgE
   Q==;
X-CSE-ConnectionGUID: Ms92yDeuQx2Sub3vBTQfjg==
X-CSE-MsgGUID: iB6u2aNHSm+/E0OvoXWHOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="63176875"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="63176875"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 10:49:37 -0700
X-CSE-ConnectionGUID: X6ptYErhTnmJ70iMbDKTVg==
X-CSE-MsgGUID: 2ob+0bbGSV62bpZuymtMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="185776408"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 01 Nov 2025 10:49:35 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFFjI-000OXU-12;
	Sat, 01 Nov 2025 17:49:32 +0000
Date: Sun, 2 Nov 2025 01:49:19 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, torvalds@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
Message-ID: <202511020147.47PufBIR-lkp@intel.com>
References: <20251031174220.43458-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031174220.43458-4-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arnd-asm-generic/master]
[also build test WARNING on linus/master brauner-vfs/vfs.all v6.18-rc3 next-20251031]
[cannot apply to linux/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/x86-fix-access_ok-and-valid_user_address-using-wrong-USER_PTR_MAX-in-modules/20251101-054539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20251031174220.43458-4-mjguzik%40gmail.com
patch subject: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
config: i386-randconfig-061-20251101 (https://download.01.org/0day-ci/archive/20251102/202511020147.47PufBIR-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251102/202511020147.47PufBIR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511020147.47PufBIR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/smb/client/link.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/dir.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/misc.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/cifsfs.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/ioctl.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/inode.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/file.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/readdir.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/namespace.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
--
   fs/smb/client/smb2ops.c: note: in included file:
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
>> fs/smb/client/cifsproto.h:71:16: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)
   fs/smb/client/cifsproto.h:77:17: sparse: sparse: cast truncates bits from constant value (123456789abcdef becomes 89abcdef)

vim +71 fs/smb/client/cifsproto.h

b6b38f704a8193 fs/cifs/cifsproto.h Joe Perches        2010-04-21  48  
6d5786a34d98bf fs/cifs/cifsproto.h Pavel Shilovsky    2012-06-20  49  #define free_xid(curr_xid)						\
b6b38f704a8193 fs/cifs/cifsproto.h Joe Perches        2010-04-21  50  do {									\
6d5786a34d98bf fs/cifs/cifsproto.h Pavel Shilovsky    2012-06-20  51  	_free_xid(curr_xid);						\
a0a3036b81f1f6 fs/cifs/cifsproto.h Joe Perches        2020-04-14  52  	cifs_dbg(FYI, "VFS: leaving %s (xid = %u) rc = %d\n",		\
b6b38f704a8193 fs/cifs/cifsproto.h Joe Perches        2010-04-21  53  		 __func__, curr_xid, (int)rc);				\
d683bcd3e5d157 fs/cifs/cifsproto.h Steve French       2018-05-19  54  	if (rc)								\
d683bcd3e5d157 fs/cifs/cifsproto.h Steve French       2018-05-19  55  		trace_smb3_exit_err(curr_xid, __func__, (int)rc);	\
d683bcd3e5d157 fs/cifs/cifsproto.h Steve French       2018-05-19  56  	else								\
d683bcd3e5d157 fs/cifs/cifsproto.h Steve French       2018-05-19  57  		trace_smb3_exit_done(curr_xid, __func__);		\
b6b38f704a8193 fs/cifs/cifsproto.h Joe Perches        2010-04-21  58  } while (0)
4d79dba0e00749 fs/cifs/cifsproto.h Shirish Pargaonkar 2011-04-27  59  extern int init_cifs_idmap(void);
4d79dba0e00749 fs/cifs/cifsproto.h Shirish Pargaonkar 2011-04-27  60  extern void exit_cifs_idmap(void);
b74cb9a80268be fs/cifs/cifsproto.h Sachin Prabhu      2016-05-17  61  extern int init_cifs_spnego(void);
b74cb9a80268be fs/cifs/cifsproto.h Sachin Prabhu      2016-05-17  62  extern void exit_cifs_spnego(void);
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05  63  extern const char *build_path_from_dentry(struct dentry *, void *);
7ad54b98fc1f14 fs/cifs/cifsproto.h Paulo Alcantara    2022-12-18  64  char *__build_path_from_dentry_optional_prefix(struct dentry *direntry, void *page,
7ad54b98fc1f14 fs/cifs/cifsproto.h Paulo Alcantara    2022-12-18  65  					       const char *tree, int tree_len,
7ad54b98fc1f14 fs/cifs/cifsproto.h Paulo Alcantara    2022-12-18  66  					       bool prefix);
268a635d414df4 fs/cifs/cifsproto.h Aurelien Aptel     2017-02-13  67  extern char *build_path_from_dentry_optional_prefix(struct dentry *direntry,
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05  68  						    void *page, bool prefix);
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05  69  static inline void *alloc_dentry_path(void)
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05  70  {
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05 @71  	return __getname();
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05  72  }
f6a9bc336b600e fs/cifs/cifsproto.h Al Viro            2021-03-05  73  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

