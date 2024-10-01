Return-Path: <linux-fsdevel+bounces-30433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD7798B405
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 08:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CEC1F242E6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063C1BCA16;
	Tue,  1 Oct 2024 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak4If4dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F91BBBE8
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762461; cv=none; b=hu9meXsQ51EbaSddsClw1gSenVb5HgS+qzVPuTjfa34opE0TMjcLn+PXdfwiFYKtXfExIKG0B7WApy8aD6Vn2thbS6mn1r6g4h8AdcTWur+ZRBIfqmCLqQ0Ltu2S6fHBwOZXIlrB8Wn4iigcOe2Xwom7kfVy5vzhtcEPrYkpi6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762461; c=relaxed/simple;
	bh=e0ucNSqZyVSG9GxzOeQRnWshI/L8IYO+stZaHultQZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H8V1bPejsz8eSdntqp2P6aDv+rrMXScjS+5DKYueFWRnyhH9sHW/1iMLvfh0Pnzj/R8YT4wLxxRAy20d3qthMJAeiRGNtLREHw5xh50IKWkV6p/T/+PWA+9/ukhQepNXyqWruqAx7m2lRaUdX5AyhBK+qmvmhjfKFmaX0MRM9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak4If4dd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727762458; x=1759298458;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e0ucNSqZyVSG9GxzOeQRnWshI/L8IYO+stZaHultQZA=;
  b=ak4If4ddV9zwIutLj9Fdu4QmtcV49dOQgDxTg43xS1fVvpQE20+T4/i1
   LhYtr2nz+GyYnz0Ukm6VHT8gxDo/ZNczhi33rDF0mQ3G6WNVjKMKD7X05
   FhW7v2BahCQhVhboTvNBUxS6KwE2swsnCbvBI2HgcTOE5PBCsVHQ0qMBS
   IGCnkeN+4Asob6rijAkHhMCMOmImzixgZVV+wdueUZpd35CSH+yllX4V/
   aYZYHLNLenIBVgjBKe/UZ8En4ecMaHtssOY/kCm5eJ3kMkfNFWljWrM78
   QLgb0PNZfvhd7oGbiQUSsEn19BXqfoAi5E2ibuLeqLge7J4WYk5ztCv1i
   w==;
X-CSE-ConnectionGUID: /DB2BzsCTnSIKPdi+bnwYg==
X-CSE-MsgGUID: vVIJzdRjT9So79lUzQK6cw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26333428"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="26333428"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 23:00:58 -0700
X-CSE-ConnectionGUID: sswBxU7ASl20MNY9RwGpvg==
X-CSE-MsgGUID: K0DR1l5ZTBi6O1P5XPargA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="74316564"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 30 Sep 2024 23:00:56 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svVwL-000QJB-1b;
	Tue, 01 Oct 2024 06:00:53 +0000
Date: Tue, 1 Oct 2024 14:00:34 +0800
From: kernel test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>
Subject: [viro-vfs:work.xattr 9/9] fs/xattr.c:971:28: error: use of
 undeclared identifier 'pathname'; did you mean 'putname'?
Message-ID: <202410011312.c884e7lp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.xattr
head:   242dce7f3a28f84e733f16d29368cedf91feccf3
commit: 242dce7f3a28f84e733f16d29368cedf91feccf3 [9/9] fs/xattr: add *at family syscalls
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20241001/202410011312.c884e7lp-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011312.c884e7lp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011312.c884e7lp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/xattr.c:15:
   In file included from include/linux/xattr.h:18:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/xattr.c:971:28: error: use of undeclared identifier 'pathname'; did you mean 'putname'?
     971 |         error = user_path_at(dfd, pathname, lookup_flags, &path);
         |                                   ^~~~~~~~
         |                                   putname
   include/linux/fs.h:2769:13: note: 'putname' declared here
    2769 | extern void putname(struct filename *name);
         |             ^
   fs/xattr.c:990:10: warning: unused variable 'error' [-Wunused-variable]
     990 |         ssize_t error;
         |                 ^~~~~
>> fs/xattr.c:1092:37: error: incompatible pointer types passing 'struct xattr_name *' to parameter of type 'const char *' [-Werror,-Wincompatible-pointer-types]
    1092 |                                             fd_file(f)->f_path.dentry, &kname);
         |                                                                        ^~~~~~
   fs/xattr.c:1037:68: note: passing argument to parameter 'name' here
    1037 | removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
         |                                                                    ^
>> fs/xattr.c:1097:2: error: use of undeclared identifier 'lookup_flags'
    1097 |         lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
         |         ^
   fs/xattr.c:1098:45: error: use of undeclared identifier 'lookup_flags'
    1098 |         return filename_removexattr(dfd, filename, lookup_flags, &kname);
         |                                                    ^
   2 warnings and 4 errors generated.


vim +971 fs/xattr.c

   962	
   963	static
   964	ssize_t filename_listxattrat(int dfd, struct filename *filename,
   965				     unsigned int lookup_flags,
   966				     char __user *list, size_t size)
   967	{
   968		struct path path;
   969		ssize_t error;
   970	retry:
 > 971		error = user_path_at(dfd, pathname, lookup_flags, &path);
   972		if (error)
   973			goto out;
   974		error = listxattr(path.dentry, list, size);
   975		path_put(&path);
   976		if (retry_estale(error, lookup_flags)) {
   977			lookup_flags |= LOOKUP_REVAL;
   978			goto retry;
   979		}
   980	out:
   981		putname(filename);
   982		return error;
   983	}
   984	
   985	static ssize_t path_listxattrat(int dfd, const char __user *pathname,
   986					unsigned int at_flags, char __user *list,
   987					size_t size)
   988	{
   989		struct filename *filename;
   990		ssize_t error;
   991		int lookup_flags;
   992	
   993		if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
   994			return -EINVAL;
   995	
   996		filename = getname_xattr(pathname, at_flags);
   997		if (!filename) {
   998			CLASS(fd, f)(dfd);
   999			if (fd_empty(f))
  1000				return -EBADF;
  1001			audit_file(fd_file(f));
  1002			return listxattr(file_dentry(fd_file(f)), list, size);
  1003		}
  1004	
  1005		lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
  1006		return filename_listxattrat(dfd, filename, lookup_flags, list, size);
  1007	}
  1008	
  1009	SYSCALL_DEFINE5(listxattrat, int, dfd, const char __user *, pathname,
  1010			unsigned int, at_flags,
  1011			char __user *, list, size_t, size)
  1012	{
  1013		return path_listxattrat(dfd, pathname, at_flags, list, size);
  1014	}
  1015	
  1016	SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *, list,
  1017			size_t, size)
  1018	{
  1019		return path_listxattrat(AT_FDCWD, pathname, 0, list, size);
  1020	}
  1021	
  1022	SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
  1023			size_t, size)
  1024	{
  1025		return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, list, size);
  1026	}
  1027	
  1028	SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
  1029	{
  1030		return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
  1031	}
  1032	
  1033	/*
  1034	 * Extended attribute REMOVE operations
  1035	 */
  1036	static long
  1037	removexattr(struct mnt_idmap *idmap, struct dentry *d, const char *name)
  1038	{
  1039		if (is_posix_acl_xattr(name))
  1040			return vfs_remove_acl(idmap, d, name);
  1041		return vfs_removexattr(idmap, d, name);
  1042	}
  1043	
  1044	static int filename_removexattr(int dfd, struct filename *filename,
  1045					unsigned int lookup_flags, struct xattr_name *kname)
  1046	{
  1047		struct path path;
  1048		int error;
  1049	
  1050	retry:
  1051		error = filename_lookup(dfd, filename, lookup_flags, &path, NULL);
  1052		if (error)
  1053			goto out;
  1054		error = mnt_want_write(path.mnt);
  1055		if (!error) {
  1056			error = removexattr(mnt_idmap(path.mnt), path.dentry, kname->name);
  1057			mnt_drop_write(path.mnt);
  1058		}
  1059		path_put(&path);
  1060		if (retry_estale(error, lookup_flags)) {
  1061			lookup_flags |= LOOKUP_REVAL;
  1062			goto retry;
  1063		}
  1064	out:
  1065		putname(filename);
  1066		return error;
  1067	}
  1068	
  1069	static int path_removexattrat(int dfd, const char __user *pathname,
  1070				      unsigned int at_flags, const char __user *name)
  1071	{
  1072		struct xattr_name kname;
  1073		struct filename *filename;
  1074		int error;
  1075	
  1076		if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
  1077			return -EINVAL;
  1078	
  1079		error = import_xattr_name(&kname, name);
  1080		if (error)
  1081			return error;
  1082	
  1083		filename = getname_xattr(pathname, at_flags);
  1084		if (!filename) {
  1085			CLASS(fd, f)(dfd);
  1086			if (fd_empty(f))
  1087				return -EBADF;
  1088			audit_file(fd_file(f));
  1089			error = mnt_want_write_file(fd_file(f));
  1090			if (!error) {
  1091				error = removexattr(file_mnt_idmap(fd_file(f)),
> 1092						    fd_file(f)->f_path.dentry, &kname);
  1093				mnt_drop_write_file(fd_file(f));
  1094			}
  1095			return error;
  1096		}
> 1097		lookup_flags = (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
  1098		return filename_removexattr(dfd, filename, lookup_flags, &kname);
  1099	}
  1100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

