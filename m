Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAE12C82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfECLgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 07:36:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:61073 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfECLgs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 07:36:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 May 2019 04:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,425,1549958400"; 
   d="scan'208";a="140951290"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 May 2019 04:36:47 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hMWUg-000H0F-UG; Fri, 03 May 2019 19:36:46 +0800
Date:   Fri, 3 May 2019 19:35:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [vfs:work.mount-syscalls 1/10] fs/namespace.c:2386:35: sparse:
 sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <201905031942.C09dfO2c%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount-syscalls
head:   f1b5618e013af28b3c78daf424436a79674423c0
commit: a07b20004793d8926f78d63eb5980559f7813404 [1/10] vfs: syscall: Add open_tree(2) to reference or clone a mount
reproduce:
        # apt-get install sparse
        git checkout a07b20004793d8926f78d63eb5980559f7813404
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/namespace.c:1736:22: sparse: sparse: symbol 'to_mnt_ns' was not declared. Should it be static?
>> fs/namespace.c:2386:35: sparse: sparse: incorrect type in argument 2 (different address spaces) @@    expected char const [noderef] <asn:1> *name @@    got f] <asn:1> *name @@
>> fs/namespace.c:2386:35: sparse:    expected char const [noderef] <asn:1> *name
>> fs/namespace.c:2386:35: sparse:    got char const *filename

vim +2386 fs/namespace.c

  2352	
  2353	SYSCALL_DEFINE3(open_tree, int, dfd, const char *, filename, unsigned, flags)
  2354	{
  2355		struct file *file;
  2356		struct path path;
  2357		int lookup_flags = LOOKUP_AUTOMOUNT | LOOKUP_FOLLOW;
  2358		bool detached = flags & OPEN_TREE_CLONE;
  2359		int error;
  2360		int fd;
  2361	
  2362		BUILD_BUG_ON(OPEN_TREE_CLOEXEC != O_CLOEXEC);
  2363	
  2364		if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
  2365			      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
  2366			      OPEN_TREE_CLOEXEC))
  2367			return -EINVAL;
  2368	
  2369		if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE)) == AT_RECURSIVE)
  2370			return -EINVAL;
  2371	
  2372		if (flags & AT_NO_AUTOMOUNT)
  2373			lookup_flags &= ~LOOKUP_AUTOMOUNT;
  2374		if (flags & AT_SYMLINK_NOFOLLOW)
  2375			lookup_flags &= ~LOOKUP_FOLLOW;
  2376		if (flags & AT_EMPTY_PATH)
  2377			lookup_flags |= LOOKUP_EMPTY;
  2378	
  2379		if (detached && !may_mount())
  2380			return -EPERM;
  2381	
  2382		fd = get_unused_fd_flags(flags & O_CLOEXEC);
  2383		if (fd < 0)
  2384			return fd;
  2385	
> 2386		error = user_path_at(dfd, filename, lookup_flags, &path);
  2387		if (unlikely(error)) {
  2388			file = ERR_PTR(error);
  2389		} else {
  2390			if (detached)
  2391				file = open_detached_copy(&path, flags & AT_RECURSIVE);
  2392			else
  2393				file = dentry_open(&path, O_PATH, current_cred());
  2394			path_put(&path);
  2395		}
  2396		if (IS_ERR(file)) {
  2397			put_unused_fd(fd);
  2398			return PTR_ERR(file);
  2399		}
  2400		fd_install(fd, file);
  2401		return fd;
  2402	}
  2403	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
