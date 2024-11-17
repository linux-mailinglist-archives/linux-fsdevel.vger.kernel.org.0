Return-Path: <linux-fsdevel+bounces-35030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED09D01BC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 01:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F380E28220A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F2E1392;
	Sun, 17 Nov 2024 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mi7/ysLN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8D15C0;
	Sun, 17 Nov 2024 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803734; cv=none; b=eNwNJC5nhHKg5U4MZYS+53DsaGU3OT9DIvhuqvYmkG5FcJ8mycgX8fV4QpECm0fyGfZU67xrVJMO1o62FGIqQ8os/QVNaPCyY106Q5Amk14WKEUrJ/YzparO/JqLLTnKAAC55//1clnbD5i5O2oYA7+PW+XQSXlIl0nRdQoGVlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803734; c=relaxed/simple;
	bh=+LHhRpz2lexERE+0uND5ClfhDGYT/5XBFC6AkXESgWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLJVV8yYLbLuKtsq9eeAgyk5hgcmqPHqVQw1/Nu1GpDMhtm+XPeJNuOFma/cB+OQX4v8FLjpH9bdYpJ4Foat4HPP74TgN2zuPDxHlYPOF9Tf6Mx6aZefC03xZYQqeTlzIc5mhbg/p53g+Ii6qBZKaDIYUHikn6JFgdTI6Hjhuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mi7/ysLN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731803733; x=1763339733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LHhRpz2lexERE+0uND5ClfhDGYT/5XBFC6AkXESgWk=;
  b=Mi7/ysLNxR3X82c7pje2eRKMd+iobH052f/85Yb8WOpv8TEDpLhr/4hB
   quCLPGZLUzQ5EKaLQf8gFjW66ygFdjbvFQps9eO1vwGC95QwfhMT2+j5p
   oX+PeLP5tWrcSwuugrI+03UTsaG+LBBRnYjQ3bVzJzlU0W8e78mtbshes
   4q128XbkxEue2d7ryBNOHyzkFlunNpKnxscT0X7hAyE8QTBzMVyAHHbBG
   smHPwXJzRLLF7h2krVQed895CNMtwCSz55KP19ZXTzN7Km+22U4IwJZ41
   JZNuUdwh1QlGlKLMPSnPtI+uQXduXIeAHfoQZGuuVKOvx3FdN2AxSsQdo
   A==;
X-CSE-ConnectionGUID: EZe1b9/bSSqcJWKGtIGtSg==
X-CSE-MsgGUID: aAR+CbcCTZKw2KZ5ZgD+RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11258"; a="42858735"
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="42858735"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 16:35:33 -0800
X-CSE-ConnectionGUID: MOXCFN+ARQaMP9B+Psbo8w==
X-CSE-MsgGUID: tF+cqJTCTQSQlObjK1NfcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,160,1728975600"; 
   d="scan'208";a="88996188"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Nov 2024 16:35:24 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCTG5-0001Bl-1o;
	Sun, 17 Nov 2024 00:35:21 +0000
Date: Sun, 17 Nov 2024 08:34:23 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Tianci <zhangtianci.1997@bytedance.com>, miklos@szeredi.hu
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	xieyongji@bytedance.com,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: Re: [PATCH] fuse: check attributes staleness on fuse_iget()
Message-ID: <202411170856.SfrPdEy1-lkp@intel.com>
References: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114070905.48901-1-zhangtianci.1997@bytedance.com>

Hi Zhang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12-rc7]
[also build test WARNING on linus/master]
[cannot apply to mszeredi-fuse/for-next next-20241115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhang-Tianci/fuse-check-attributes-staleness-on-fuse_iget/20241114-151838
base:   v6.12-rc7
patch link:    https://lore.kernel.org/r/20241114070905.48901-1-zhangtianci.1997%40bytedance.com
patch subject: [PATCH] fuse: check attributes staleness on fuse_iget()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241117/202411170856.SfrPdEy1-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411170856.SfrPdEy1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411170856.SfrPdEy1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/fuse/inode.c:9:
   In file included from fs/fuse/fuse_i.h:22:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> fs/fuse/inode.c:456:7: warning: variable 'fi' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     456 |                 if (!fi->submount_lookup) {
         |                     ^~~~~~~~~~~~~~~~~~~~
   fs/fuse/inode.c:493:13: note: uninitialized use occurs here
     493 |         spin_lock(&fi->lock);
         |                    ^~
   fs/fuse/inode.c:456:3: note: remove the 'if' if its condition is always true
     456 |                 if (!fi->submount_lookup) {
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/fuse/inode.c:434:23: note: initialize the variable 'fi' to silence this warning
     434 |         struct fuse_inode *fi;
         |                              ^
         |                               = NULL
   5 warnings generated.


vim +456 fs/fuse/inode.c

d8a5ba45457e4a Miklos Szeredi    2005-09-09  427  
b48badf013018e Miklos Szeredi    2008-04-30  428  struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
1fb69e7817296d Miklos Szeredi    2007-10-18  429  			int generation, struct fuse_attr *attr,
243f2d46af8e04 Zhang Tianci      2024-11-14  430  			u64 attr_valid, u64 attr_version,
243f2d46af8e04 Zhang Tianci      2024-11-14  431  			u64 evict_ctr)
d8a5ba45457e4a Miklos Szeredi    2005-09-09  432  {
d8a5ba45457e4a Miklos Szeredi    2005-09-09  433  	struct inode *inode;
9e6268db496a25 Miklos Szeredi    2005-09-09  434  	struct fuse_inode *fi;
d8a5ba45457e4a Miklos Szeredi    2005-09-09  435  	struct fuse_conn *fc = get_fuse_conn_super(sb);
d8a5ba45457e4a Miklos Szeredi    2005-09-09  436  
bf109c64040f5b Max Reitz         2020-04-21  437  	/*
bf109c64040f5b Max Reitz         2020-04-21  438  	 * Auto mount points get their node id from the submount root, which is
bf109c64040f5b Max Reitz         2020-04-21  439  	 * not a unique identifier within this filesystem.
bf109c64040f5b Max Reitz         2020-04-21  440  	 *
bf109c64040f5b Max Reitz         2020-04-21  441  	 * To avoid conflicts, do not place submount points into the inode hash
bf109c64040f5b Max Reitz         2020-04-21  442  	 * table.
bf109c64040f5b Max Reitz         2020-04-21  443  	 */
bf109c64040f5b Max Reitz         2020-04-21  444  	if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
bf109c64040f5b Max Reitz         2020-04-21  445  	    S_ISDIR(attr->mode)) {
c4d361f66ac91d Krister Johansen  2023-11-03  446  		struct fuse_inode *fi;
c4d361f66ac91d Krister Johansen  2023-11-03  447  
bf109c64040f5b Max Reitz         2020-04-21  448  		inode = new_inode(sb);
bf109c64040f5b Max Reitz         2020-04-21  449  		if (!inode)
bf109c64040f5b Max Reitz         2020-04-21  450  			return NULL;
bf109c64040f5b Max Reitz         2020-04-21  451  
facd61053cff10 Christian Brauner 2023-01-20  452  		fuse_init_inode(inode, attr, fc);
c4d361f66ac91d Krister Johansen  2023-11-03  453  		fi = get_fuse_inode(inode);
c4d361f66ac91d Krister Johansen  2023-11-03  454  		fi->nodeid = nodeid;
c4d361f66ac91d Krister Johansen  2023-11-03  455  		fi->submount_lookup = fuse_alloc_submount_lookup();
c4d361f66ac91d Krister Johansen  2023-11-03 @456  		if (!fi->submount_lookup) {
c4d361f66ac91d Krister Johansen  2023-11-03  457  			iput(inode);
c4d361f66ac91d Krister Johansen  2023-11-03  458  			return NULL;
c4d361f66ac91d Krister Johansen  2023-11-03  459  		}
c4d361f66ac91d Krister Johansen  2023-11-03  460  		/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
c4d361f66ac91d Krister Johansen  2023-11-03  461  		fuse_init_submount_lookup(fi->submount_lookup, nodeid);
bf109c64040f5b Max Reitz         2020-04-21  462  		inode->i_flags |= S_AUTOMOUNT;
bf109c64040f5b Max Reitz         2020-04-21  463  		goto done;
bf109c64040f5b Max Reitz         2020-04-21  464  	}
bf109c64040f5b Max Reitz         2020-04-21  465  
d8a5ba45457e4a Miklos Szeredi    2005-09-09  466  retry:
d8a5ba45457e4a Miklos Szeredi    2005-09-09  467  	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
d8a5ba45457e4a Miklos Szeredi    2005-09-09  468  	if (!inode)
d8a5ba45457e4a Miklos Szeredi    2005-09-09  469  		return NULL;
d8a5ba45457e4a Miklos Szeredi    2005-09-09  470  
d8a5ba45457e4a Miklos Szeredi    2005-09-09  471  	if ((inode->i_state & I_NEW)) {
b0aa7606521790 Maxim Patlasov    2013-12-26  472  		inode->i_flags |= S_NOATIME;
d31433c8b06d44 Maxim Patlasov    2014-04-28  473  		if (!fc->writeback_cache || !S_ISREG(attr->mode))
b0aa7606521790 Maxim Patlasov    2013-12-26  474  			inode->i_flags |= S_NOCMTIME;
d8a5ba45457e4a Miklos Szeredi    2005-09-09  475  		inode->i_generation = generation;
facd61053cff10 Christian Brauner 2023-01-20  476  		fuse_init_inode(inode, attr, fc);
d8a5ba45457e4a Miklos Szeredi    2005-09-09  477  		unlock_new_inode(inode);
15db16837a35d8 Amir Goldstein    2021-06-21  478  	} else if (fuse_stale_inode(inode, generation, attr)) {
15db16837a35d8 Amir Goldstein    2021-06-21  479  		/* nodeid was reused, any I/O on the old inode should fail */
5d069dbe8aaf2a Miklos Szeredi    2020-12-10  480  		fuse_make_bad(inode);
b1fe686a765e6c Miklos Szeredi    2024-02-28  481  		if (inode != d_inode(sb->s_root)) {
b1fe686a765e6c Miklos Szeredi    2024-02-28  482  			remove_inode_hash(inode);
d8a5ba45457e4a Miklos Szeredi    2005-09-09  483  			iput(inode);
d8a5ba45457e4a Miklos Szeredi    2005-09-09  484  			goto retry;
d8a5ba45457e4a Miklos Szeredi    2005-09-09  485  		}
b1fe686a765e6c Miklos Szeredi    2024-02-28  486  	}
9e6268db496a25 Miklos Szeredi    2005-09-09  487  	fi = get_fuse_inode(inode);
c9d8f5f0692d59 Kirill Tkhai      2018-11-09  488  	spin_lock(&fi->lock);
9e6268db496a25 Miklos Szeredi    2005-09-09  489  	fi->nlookup++;
c9d8f5f0692d59 Kirill Tkhai      2018-11-09  490  	spin_unlock(&fi->lock);
c4d361f66ac91d Krister Johansen  2023-11-03  491  done:
972f4c46d0a1bb Miklos Szeredi    2023-08-10  492  	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
243f2d46af8e04 Zhang Tianci      2024-11-14  493  	spin_lock(&fi->lock);
243f2d46af8e04 Zhang Tianci      2024-11-14  494  	if (evict_ctr < fuse_get_evict_ctr(fc))
243f2d46af8e04 Zhang Tianci      2024-11-14  495  		fuse_invalidate_attr(inode);
243f2d46af8e04 Zhang Tianci      2024-11-14  496  	spin_unlock(&fi->lock);
1fb69e7817296d Miklos Szeredi    2007-10-18  497  
d8a5ba45457e4a Miklos Szeredi    2005-09-09  498  	return inode;
d8a5ba45457e4a Miklos Szeredi    2005-09-09  499  }
d8a5ba45457e4a Miklos Szeredi    2005-09-09  500  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

