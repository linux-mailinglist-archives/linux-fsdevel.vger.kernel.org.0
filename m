Return-Path: <linux-fsdevel+bounces-49466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B3ABCB4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 01:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64490189CF09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDB21E092;
	Mon, 19 May 2025 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnRX2VW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0B01F12FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696326; cv=none; b=uKyDyj1717ivTdwaN8HI7h+tEPuNJtMaOtxJUMgf1QVGltM+Yliio8+A21nBgCdJ8NoTZf61f8ifZLVU5TTn2qLTiF5u/lAEQb1Q7O/yu4y4m8KjbcnJLfylgaaZ6sg721ZRt5qBgxA0ZsQ0i+GIl7NJGRwx638F7CyqVU/TbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696326; c=relaxed/simple;
	bh=Qo2K1cSF2dRWSk8ikcK81WpzrQ/FitrnvbaY88Qhh/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vFOgYbAOileDXx2kAOGluPWZg0tTk9+vRYkNqAtbwfguRkhvmPCCtDPv170XsoXl2HpxfJ6bL2VkrGWVXcr5Gf1P7KhLHb0eAAOrCiqqpWNBHHbZu/C0vrIjeknU4vPUlprSJiEDeaO8D4gd0CDsh/LRSC2mm8oYopsJMBAkfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnRX2VW3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747696325; x=1779232325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Qo2K1cSF2dRWSk8ikcK81WpzrQ/FitrnvbaY88Qhh/I=;
  b=ZnRX2VW30tS8UCugX9UMUMdf7kvROCIuVn1tXWaSsmlrfqxcSMD56ZJL
   jswLSm7R2jiIvLnRikHDiphcKX1hn6cJtGv2DTVR38lvRpO83JoZGWujT
   t8d6ckKXBXn/aE0iOROUmtamT8r234e6VdFTUGJAjIx+Jx5SIRerLrGdn
   eHiqWIKf7HBIJJD/I6qzemOqAocCrnwRBSEKT5GKeujJXKwYOassprxaB
   4z1Aev6QDVvBxrYNK9BtXVuta0adz5N7htD+H8liy9bfbSyAbpAxWaW3R
   TqqKB4zjn+sMtEYRJXwa204oPTHaE+G8i9EZtnK6dFjEV6vxKuhmD7gJY
   A==;
X-CSE-ConnectionGUID: rzo8wY4qR0uPOlsboAcV7w==
X-CSE-MsgGUID: sq18oznERnuiEiURLHcJFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="60248360"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60248360"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:12:04 -0700
X-CSE-ConnectionGUID: AXCilnyOSziU7KYQ89GCDA==
X-CSE-MsgGUID: C6rdrW6LTcyX0Lt6GMXCXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144633166"
Received: from igk-lkp-server01.igk.intel.com (HELO a1decbf9c5f9) ([10.211.3.150])
  by orviesa005.jf.intel.com with ESMTP; 19 May 2025 16:12:02 -0700
Received: from kbuild by a1decbf9c5f9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uH9eJ-0000uJ-3A;
	Mon, 19 May 2025 23:11:59 +0000
Date: Tue, 20 May 2025 07:11:18 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.mount 22/26] fs/namespace.c:2783: warning: Function
 parameter or struct member 'pinned' not described in 'do_lock_mount'
Message-ID: <202505200739.z53oJYow-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount
head:   7b8fbaece84a97a71be2ccc60792f9be958d8e4a
commit: f41dac8858499e0cb813a96e63195d46138a005a [22/26] [experimental] get rid of ->m_count
config: um-randconfig-2004-20250520 (https://download.01.org/0day-ci/archive/20250520/202505200739.z53oJYow-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505200739.z53oJYow-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505200739.z53oJYow-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/namespace.c:2783: warning: Function parameter or struct member 'pinned' not described in 'do_lock_mount'


vim +2783 fs/namespace.c

b90fa9ae8f51f0 Ram Pai           2005-11-07  2747  
6ac392815628f3 Christian Brauner 2023-05-03  2748  /**
6ac392815628f3 Christian Brauner 2023-05-03  2749   * do_lock_mount - lock mount and mountpoint
6ac392815628f3 Christian Brauner 2023-05-03  2750   * @path:    target path
6ac392815628f3 Christian Brauner 2023-05-03  2751   * @beneath: whether the intention is to mount beneath @path
6ac392815628f3 Christian Brauner 2023-05-03  2752   *
6ac392815628f3 Christian Brauner 2023-05-03  2753   * Follow the mount stack on @path until the top mount @mnt is found. If
6ac392815628f3 Christian Brauner 2023-05-03  2754   * the initial @path->{mnt,dentry} is a mountpoint lookup the first
6ac392815628f3 Christian Brauner 2023-05-03  2755   * mount stacked on top of it. Then simply follow @{mnt,mnt->mnt_root}
6ac392815628f3 Christian Brauner 2023-05-03  2756   * until nothing is stacked on top of it anymore.
6ac392815628f3 Christian Brauner 2023-05-03  2757   *
6ac392815628f3 Christian Brauner 2023-05-03  2758   * Acquire the inode_lock() on the top mount's ->mnt_root to protect
6ac392815628f3 Christian Brauner 2023-05-03  2759   * against concurrent removal of the new mountpoint from another mount
6ac392815628f3 Christian Brauner 2023-05-03  2760   * namespace.
6ac392815628f3 Christian Brauner 2023-05-03  2761   *
6ac392815628f3 Christian Brauner 2023-05-03  2762   * If @beneath is requested, acquire inode_lock() on @mnt's mountpoint
6ac392815628f3 Christian Brauner 2023-05-03  2763   * @mp on @mnt->mnt_parent must be acquired. This protects against a
6ac392815628f3 Christian Brauner 2023-05-03  2764   * concurrent unlink of @mp->mnt_dentry from another mount namespace
6ac392815628f3 Christian Brauner 2023-05-03  2765   * where @mnt doesn't have a child mount mounted @mp. A concurrent
6ac392815628f3 Christian Brauner 2023-05-03  2766   * removal of @mnt->mnt_root doesn't matter as nothing will be mounted
6ac392815628f3 Christian Brauner 2023-05-03  2767   * on top of it for @beneath.
6ac392815628f3 Christian Brauner 2023-05-03  2768   *
6ac392815628f3 Christian Brauner 2023-05-03  2769   * In addition, @beneath needs to make sure that @mnt hasn't been
6ac392815628f3 Christian Brauner 2023-05-03  2770   * unmounted or moved from its current mountpoint in between dropping
6ac392815628f3 Christian Brauner 2023-05-03  2771   * @mount_lock and acquiring @namespace_sem. For the !@beneath case @mnt
6ac392815628f3 Christian Brauner 2023-05-03  2772   * being unmounted would be detected later by e.g., calling
6ac392815628f3 Christian Brauner 2023-05-03  2773   * check_mnt(mnt) in the function it's called from. For the @beneath
6ac392815628f3 Christian Brauner 2023-05-03  2774   * case however, it's useful to detect it directly in do_lock_mount().
6ac392815628f3 Christian Brauner 2023-05-03  2775   * If @mnt hasn't been unmounted then @mnt->mnt_mountpoint still points
6ac392815628f3 Christian Brauner 2023-05-03  2776   * to @mnt->mnt_mp->m_dentry. But if @mnt has been unmounted it will
6ac392815628f3 Christian Brauner 2023-05-03  2777   * point to @mnt->mnt_root and @mnt->mnt_mp will be NULL.
6ac392815628f3 Christian Brauner 2023-05-03  2778   *
6ac392815628f3 Christian Brauner 2023-05-03  2779   * Return: Either the target mountpoint on the top mount or the top
6ac392815628f3 Christian Brauner 2023-05-03  2780   *         mount's mountpoint.
6ac392815628f3 Christian Brauner 2023-05-03  2781   */
f41dac8858499e Al Viro           2025-04-25  2782  static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bool beneath)
b12cea9198fa99 Al Viro           2011-03-18 @2783  {
6ac392815628f3 Christian Brauner 2023-05-03  2784  	struct vfsmount *mnt = path->mnt;
64f44b27ae9184 Christian Brauner 2023-05-03  2785  	struct dentry *dentry;
0d039eac6e5950 Al Viro           2025-04-23  2786  	struct path under = {};
f41dac8858499e Al Viro           2025-04-25  2787  	int err = -ENOENT;
64f44b27ae9184 Christian Brauner 2023-05-03  2788  
64f44b27ae9184 Christian Brauner 2023-05-03  2789  	for (;;) {
0d039eac6e5950 Al Viro           2025-04-23  2790  		struct mount *m = real_mount(mnt);
6ac392815628f3 Christian Brauner 2023-05-03  2791  
6ac392815628f3 Christian Brauner 2023-05-03  2792  		if (beneath) {
0d039eac6e5950 Al Viro           2025-04-23  2793  			path_put(&under);
6ac392815628f3 Christian Brauner 2023-05-03  2794  			read_seqlock_excl(&mount_lock);
0d039eac6e5950 Al Viro           2025-04-23  2795  			under.mnt = mntget(&m->mnt_parent->mnt);
0d039eac6e5950 Al Viro           2025-04-23  2796  			under.dentry = dget(m->mnt_mountpoint);
6ac392815628f3 Christian Brauner 2023-05-03  2797  			read_sequnlock_excl(&mount_lock);
0d039eac6e5950 Al Viro           2025-04-23  2798  			dentry = under.dentry;
6ac392815628f3 Christian Brauner 2023-05-03  2799  		} else {
64f44b27ae9184 Christian Brauner 2023-05-03  2800  			dentry = path->dentry;
6ac392815628f3 Christian Brauner 2023-05-03  2801  		}
6ac392815628f3 Christian Brauner 2023-05-03  2802  
5955102c9984fa Al Viro           2016-01-22  2803  		inode_lock(dentry->d_inode);
97216be09efd41 Al Viro           2013-03-16  2804  		namespace_lock();
64f44b27ae9184 Christian Brauner 2023-05-03  2805  
0d039eac6e5950 Al Viro           2025-04-23  2806  		if (unlikely(cant_mount(dentry) || !is_mounted(mnt)))
0d039eac6e5950 Al Viro           2025-04-23  2807  			break;		// not to be mounted on
0d039eac6e5950 Al Viro           2025-04-23  2808  
0d039eac6e5950 Al Viro           2025-04-23  2809  		if (beneath && unlikely(m->mnt_mountpoint != dentry ||
0d039eac6e5950 Al Viro           2025-04-23  2810  				        &m->mnt_parent->mnt != under.mnt)) {
6ac392815628f3 Christian Brauner 2023-05-03  2811  			namespace_unlock();
6ac392815628f3 Christian Brauner 2023-05-03  2812  			inode_unlock(dentry->d_inode);
0d039eac6e5950 Al Viro           2025-04-23  2813  			continue;	// got moved
6ac392815628f3 Christian Brauner 2023-05-03  2814  		}
6ac392815628f3 Christian Brauner 2023-05-03  2815  
b12cea9198fa99 Al Viro           2011-03-18  2816  		mnt = lookup_mnt(path);
0d039eac6e5950 Al Viro           2025-04-23  2817  		if (unlikely(mnt)) {
64f44b27ae9184 Christian Brauner 2023-05-03  2818  			namespace_unlock();
64f44b27ae9184 Christian Brauner 2023-05-03  2819  			inode_unlock(dentry->d_inode);
64f44b27ae9184 Christian Brauner 2023-05-03  2820  			path_put(path);
64f44b27ae9184 Christian Brauner 2023-05-03  2821  			path->mnt = mnt;
64f44b27ae9184 Christian Brauner 2023-05-03  2822  			path->dentry = dget(mnt->mnt_root);
0d039eac6e5950 Al Viro           2025-04-23  2823  			continue;	// got overmounted
64f44b27ae9184 Christian Brauner 2023-05-03  2824  		}
f41dac8858499e Al Viro           2025-04-25  2825  		err = get_mountpoint(dentry, pinned);
f41dac8858499e Al Viro           2025-04-25  2826  		if (err)
0d039eac6e5950 Al Viro           2025-04-23  2827  			break;
0d039eac6e5950 Al Viro           2025-04-23  2828  		if (beneath) {
0d039eac6e5950 Al Viro           2025-04-23  2829  			/*
0d039eac6e5950 Al Viro           2025-04-23  2830  			 * @under duplicates the references that will stay
0d039eac6e5950 Al Viro           2025-04-23  2831  			 * at least until namespace_unlock(), so the path_put()
0d039eac6e5950 Al Viro           2025-04-23  2832  			 * below is safe (and OK to do under namespace_lock -
0d039eac6e5950 Al Viro           2025-04-23  2833  			 * we are not dropping the final references here).
0d039eac6e5950 Al Viro           2025-04-23  2834  			 */
0d039eac6e5950 Al Viro           2025-04-23  2835  			path_put(&under);
0d039eac6e5950 Al Viro           2025-04-23  2836  		}
f41dac8858499e Al Viro           2025-04-25  2837  		return 0;
0d039eac6e5950 Al Viro           2025-04-23  2838  	}
97216be09efd41 Al Viro           2013-03-16  2839  	namespace_unlock();
5955102c9984fa Al Viro           2016-01-22  2840  	inode_unlock(dentry->d_inode);
6ac392815628f3 Christian Brauner 2023-05-03  2841  	if (beneath)
0d039eac6e5950 Al Viro           2025-04-23  2842  		path_put(&under);
f41dac8858499e Al Viro           2025-04-25  2843  	return err;
84d17192d2afd5 Al Viro           2013-03-15  2844  }
b12cea9198fa99 Al Viro           2011-03-18  2845  

:::::: The code at line 2783 was first introduced by commit
:::::: b12cea9198fa99ffd3de1776c323bc7464d26b44 change the locking order for namespace_sem

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

