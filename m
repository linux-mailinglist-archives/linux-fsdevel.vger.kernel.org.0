Return-Path: <linux-fsdevel+bounces-36725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEFB9E8A86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 05:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BB1161E4A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048517625C;
	Mon,  9 Dec 2024 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auzin26n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34E15E5BB
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733719846; cv=none; b=PwlIVv4XLBuLUBeckGsUYsqWlgxPiQdfM1z0qC5jbBavFyYwYWIlpyLNZPkxaMdAZJQnxpcTBsvh3aOcJPhb+luN/aHeWNO/HgSQAx7f0JoIIzpdL50ej7Ug1+UJyX0L0y2sQKnqk1M83C/+qNZzApaQbxBQisDXulIt///wzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733719846; c=relaxed/simple;
	bh=pdZUuy+VQK3+RfMAXBxTAUcrk/2OaiHOXTNwWnIPXzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq/e79LRamDx11dz8hVNn2Fp0GO6Rfz3BqAFfHL+MFRclIjs2qmbhHVnewF6VgVKMIyyhK7rpYc5JwfruXI2JTBojCYzdS9kB7QNbLNfEq7TBqhItDOyj7B7642iRYFYT24sngmiqLIYK/GFOXqXegYWgcXZkn3zMg7etmwVsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auzin26n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733719843; x=1765255843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pdZUuy+VQK3+RfMAXBxTAUcrk/2OaiHOXTNwWnIPXzA=;
  b=auzin26npWZZCqeJFKhGv5I34MsIT0PBzVbqozBtOYs5tAxBCMpZ+f0E
   cr6BIRopGAXi+xN2WqX0ZQdhIyJixsa7bvqELPzpvpP0es0sKxeIB1viL
   h/6sfVcqplsKAv8ojjOeD+v/1xaC+nG40ifoPWtIf3GZwnXFTwYmZnCTB
   5YMTgzCAfikqFAhztNk+6lRbJgyu++Z0U8pzm0uDr4Ce+613Bdcep3C9C
   qDT5+DGPb/BFO8HqyYwi7tOtPxLxURMzUEN1V7jfKRjK1I99/7DDCcVOe
   UMWCFVhYl7DPpyQfG3mh029trOYOfTaQ2063Z9lnDXddgOlFElwmrCpSM
   A==;
X-CSE-ConnectionGUID: fVZhfZOyTR2KNJU0SGWuCA==
X-CSE-MsgGUID: DCprBO2jRwKOBIVv/UVWTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34124016"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34124016"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:50:42 -0800
X-CSE-ConnectionGUID: WbUiA7NKRoGQJXWsJjZ3kQ==
X-CSE-MsgGUID: 63dDSnGfSUKpJGynIB+Qug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95305040"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Dec 2024 20:50:40 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVjB-0003vp-1Y;
	Mon, 09 Dec 2024 04:50:37 +0000
Date: Mon, 9 Dec 2024 12:49:45 +0800
From: kernel test robot <lkp@intel.com>
To: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] fanotify: notify on mount attach and detach
Message-ID: <202412082311.YLRqFsNq-lkp@intel.com>
References: <20241206151154.60538-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206151154.60538-1-mszeredi@redhat.com>

Hi Miklos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.13-rc1]
[cannot apply to jack-fs/fsnotify pcmoore-selinux/next next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miklos-Szeredi/fanotify-notify-on-mount-attach-and-detach/20241206-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20241206151154.60538-1-mszeredi%40redhat.com
patch subject: [PATCH v2] fanotify: notify on mount attach and detach
config: csky-randconfig-r122-20241208 (https://download.01.org/0day-ci/archive/20241208/202412082311.YLRqFsNq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241208/202412082311.YLRqFsNq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412082311.YLRqFsNq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   fs/notify/fsnotify.c:415:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:415:16: sparse:    struct fsnotify_mark_connector [noderef] __rcu *
   fs/notify/fsnotify.c:415:16: sparse:    struct fsnotify_mark_connector *
   fs/notify/fsnotify.c:417:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:417:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/notify/fsnotify.c:417:24: sparse:    struct hlist_node *
   fs/notify/fsnotify.c:427:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/notify/fsnotify.c:427:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/notify/fsnotify.c:427:24: sparse:    struct hlist_node *
>> fs/notify/fsnotify.c:598:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *const *connp @@     got struct fsnotify_mark_connector [noderef] __rcu ** @@
   fs/notify/fsnotify.c:598:46: sparse:     expected struct fsnotify_mark_connector *const *connp
   fs/notify/fsnotify.c:598:46: sparse:     got struct fsnotify_mark_connector [noderef] __rcu **
   fs/notify/fsnotify.c:602:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *const *connp @@     got struct fsnotify_mark_connector [noderef] __rcu ** @@
   fs/notify/fsnotify.c:602:46: sparse:     expected struct fsnotify_mark_connector *const *connp
   fs/notify/fsnotify.c:602:46: sparse:     got struct fsnotify_mark_connector [noderef] __rcu **
   fs/notify/fsnotify.c:606:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *const *connp @@     got struct fsnotify_mark_connector [noderef] __rcu ** @@
   fs/notify/fsnotify.c:606:46: sparse:     expected struct fsnotify_mark_connector *const *connp
   fs/notify/fsnotify.c:606:46: sparse:     got struct fsnotify_mark_connector [noderef] __rcu **
   fs/notify/fsnotify.c:610:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *const *connp @@     got struct fsnotify_mark_connector [noderef] __rcu ** @@
   fs/notify/fsnotify.c:610:46: sparse:     expected struct fsnotify_mark_connector *const *connp
   fs/notify/fsnotify.c:610:46: sparse:     got struct fsnotify_mark_connector [noderef] __rcu **
>> fs/notify/fsnotify.c:614:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct fsnotify_mark_connector *const *connp @@     got struct fsnotify_mark_connector [noderef] __rcu *const * @@
   fs/notify/fsnotify.c:614:54: sparse:     expected struct fsnotify_mark_connector *const *connp
   fs/notify/fsnotify.c:614:54: sparse:     got struct fsnotify_mark_connector [noderef] __rcu *const *

vim +598 fs/notify/fsnotify.c

d9a6f30bb89309a Amir Goldstein          2018-04-20  502  
90586523eb4b349 Eric Paris              2009-05-21  503  /*
40a100d3adc1ad7 Amir Goldstein          2020-07-22  504   * fsnotify - This is the main call to fsnotify.
40a100d3adc1ad7 Amir Goldstein          2020-07-22  505   *
40a100d3adc1ad7 Amir Goldstein          2020-07-22  506   * The VFS calls into hook specific functions in linux/fsnotify.h.
40a100d3adc1ad7 Amir Goldstein          2020-07-22  507   * Those functions then in turn call here.  Here will call out to all of the
40a100d3adc1ad7 Amir Goldstein          2020-07-22  508   * registered fsnotify_group.  Those groups can then use the notification event
40a100d3adc1ad7 Amir Goldstein          2020-07-22  509   * in whatever means they feel necessary.
40a100d3adc1ad7 Amir Goldstein          2020-07-22  510   *
40a100d3adc1ad7 Amir Goldstein          2020-07-22  511   * @mask:	event type and flags
40a100d3adc1ad7 Amir Goldstein          2020-07-22  512   * @data:	object that event happened on
40a100d3adc1ad7 Amir Goldstein          2020-07-22  513   * @data_type:	type of object for fanotify_data_XXX() accessors
40a100d3adc1ad7 Amir Goldstein          2020-07-22  514   * @dir:	optional directory associated with event -
40a100d3adc1ad7 Amir Goldstein          2020-07-22  515   *		if @file_name is not NULL, this is the directory that
40a100d3adc1ad7 Amir Goldstein          2020-07-22  516   *		@file_name is relative to
40a100d3adc1ad7 Amir Goldstein          2020-07-22  517   * @file_name:	optional file name associated with event
40a100d3adc1ad7 Amir Goldstein          2020-07-22  518   * @inode:	optional inode associated with event -
29335033c574a15 Gabriel Krisman Bertazi 2021-10-25  519   *		If @dir and @inode are both non-NULL, event may be
29335033c574a15 Gabriel Krisman Bertazi 2021-10-25  520   *		reported to both.
40a100d3adc1ad7 Amir Goldstein          2020-07-22  521   * @cookie:	inotify rename cookie
90586523eb4b349 Eric Paris              2009-05-21  522   */
40a100d3adc1ad7 Amir Goldstein          2020-07-22  523  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
40a100d3adc1ad7 Amir Goldstein          2020-07-22  524  	     const struct qstr *file_name, struct inode *inode, u32 cookie)
90586523eb4b349 Eric Paris              2009-05-21  525  {
b54cecf5e2293d1 Amir Goldstein          2020-06-07  526  	const struct path *path = fsnotify_data_path(data, data_type);
29335033c574a15 Gabriel Krisman Bertazi 2021-10-25  527  	struct super_block *sb = fsnotify_data_sb(data, data_type);
fab7dcc061e159e Miklos Szeredi          2024-12-06  528  	const struct fsnotify_mnt *mnt_data = fsnotify_data_mnt(data, data_type);
fab7dcc061e159e Miklos Szeredi          2024-12-06  529  	struct fsnotify_sb_info *sbinfo = sb ? fsnotify_sb_info(sb) : NULL;
3427ce715541234 Miklos Szeredi          2017-10-30  530  	struct fsnotify_iter_info iter_info = {};
60f7ed8c7c4d06a Amir Goldstein          2018-09-01  531  	struct mount *mnt = NULL;
e54183fa7047c15 Amir Goldstein          2021-11-29  532  	struct inode *inode2 = NULL;
e54183fa7047c15 Amir Goldstein          2021-11-29  533  	struct dentry *moved;
e54183fa7047c15 Amir Goldstein          2021-11-29  534  	int inode2_type;
9385a84d7e1f658 Jan Kara                2016-11-10  535  	int ret = 0;
fab7dcc061e159e Miklos Szeredi          2024-12-06  536  	__u32 test_mask, marks_mask = 0;
90586523eb4b349 Eric Paris              2009-05-21  537  
71d734103edfa2b Mel Gorman              2020-07-08  538  	if (path)
aa93bdc5500cc93 Amir Goldstein          2020-03-19  539  		mnt = real_mount(path->mnt);
3a9fb89f4cd04c2 Eric Paris              2009-12-17  540  
40a100d3adc1ad7 Amir Goldstein          2020-07-22  541  	if (!inode) {
40a100d3adc1ad7 Amir Goldstein          2020-07-22  542  		/* Dirent event - report on TYPE_INODE to dir */
40a100d3adc1ad7 Amir Goldstein          2020-07-22  543  		inode = dir;
e54183fa7047c15 Amir Goldstein          2021-11-29  544  		/* For FS_RENAME, inode is old_dir and inode2 is new_dir */
e54183fa7047c15 Amir Goldstein          2021-11-29  545  		if (mask & FS_RENAME) {
e54183fa7047c15 Amir Goldstein          2021-11-29  546  			moved = fsnotify_data_dentry(data, data_type);
e54183fa7047c15 Amir Goldstein          2021-11-29  547  			inode2 = moved->d_parent->d_inode;
e54183fa7047c15 Amir Goldstein          2021-11-29  548  			inode2_type = FSNOTIFY_ITER_TYPE_INODE2;
e54183fa7047c15 Amir Goldstein          2021-11-29  549  		}
40a100d3adc1ad7 Amir Goldstein          2020-07-22  550  	} else if (mask & FS_EVENT_ON_CHILD) {
40a100d3adc1ad7 Amir Goldstein          2020-07-22  551  		/*
fecc4559780d52d Amir Goldstein          2020-12-02  552  		 * Event on child - report on TYPE_PARENT to dir if it is
fecc4559780d52d Amir Goldstein          2020-12-02  553  		 * watching children and on TYPE_INODE to child.
40a100d3adc1ad7 Amir Goldstein          2020-07-22  554  		 */
e54183fa7047c15 Amir Goldstein          2021-11-29  555  		inode2 = dir;
e54183fa7047c15 Amir Goldstein          2021-11-29  556  		inode2_type = FSNOTIFY_ITER_TYPE_PARENT;
40a100d3adc1ad7 Amir Goldstein          2020-07-22  557  	}
497b0c5a7c0688c Amir Goldstein          2020-07-16  558  
7c49b8616460ebb Dave Hansen             2015-09-04  559  	/*
7c49b8616460ebb Dave Hansen             2015-09-04  560  	 * Optimization: srcu_read_lock() has a memory barrier which can
7c49b8616460ebb Dave Hansen             2015-09-04  561  	 * be expensive.  It protects walking the *_fsnotify_marks lists.
7c49b8616460ebb Dave Hansen             2015-09-04  562  	 * However, if we do not walk the lists, we do not have to do
7c49b8616460ebb Dave Hansen             2015-09-04  563  	 * SRCU because we have no references to any objects and do not
7c49b8616460ebb Dave Hansen             2015-09-04  564  	 * need SRCU to keep them "alive".
7c49b8616460ebb Dave Hansen             2015-09-04  565  	 */
07a3b8d0bf726a1 Amir Goldstein          2024-03-17  566  	if ((!sbinfo || !sbinfo->sb_marks) &&
497b0c5a7c0688c Amir Goldstein          2020-07-16  567  	    (!mnt || !mnt->mnt_fsnotify_marks) &&
9b93f33105f5f9b Amir Goldstein          2020-07-16  568  	    (!inode || !inode->i_fsnotify_marks) &&
fab7dcc061e159e Miklos Szeredi          2024-12-06  569  	    (!inode2 || !inode2->i_fsnotify_marks) &&
fab7dcc061e159e Miklos Szeredi          2024-12-06  570  	    (!mnt_data || !mnt_data->ns->n_fsnotify_marks))
7c49b8616460ebb Dave Hansen             2015-09-04  571  		return 0;
71d734103edfa2b Mel Gorman              2020-07-08  572  
fab7dcc061e159e Miklos Szeredi          2024-12-06  573  	if (sb)
fab7dcc061e159e Miklos Szeredi          2024-12-06  574  		marks_mask |= READ_ONCE(sb->s_fsnotify_mask);
71d734103edfa2b Mel Gorman              2020-07-08  575  	if (mnt)
35ceae44742e110 Jan Kara                2024-07-17  576  		marks_mask |= READ_ONCE(mnt->mnt_fsnotify_mask);
9b93f33105f5f9b Amir Goldstein          2020-07-16  577  	if (inode)
35ceae44742e110 Jan Kara                2024-07-17  578  		marks_mask |= READ_ONCE(inode->i_fsnotify_mask);
e54183fa7047c15 Amir Goldstein          2021-11-29  579  	if (inode2)
35ceae44742e110 Jan Kara                2024-07-17  580  		marks_mask |= READ_ONCE(inode2->i_fsnotify_mask);
fab7dcc061e159e Miklos Szeredi          2024-12-06  581  	if (mnt_data)
fab7dcc061e159e Miklos Szeredi          2024-12-06  582  		marks_mask |= READ_ONCE(mnt_data->ns->n_fsnotify_mask);
71d734103edfa2b Mel Gorman              2020-07-08  583  
613a807fe7c793c Eric Paris              2010-07-28  584  	/*
31a371e419c885e Amir Goldstein          2022-06-29  585  	 * If this is a modify event we may need to clear some ignore masks.
31a371e419c885e Amir Goldstein          2022-06-29  586  	 * In that case, the object with ignore masks will have the FS_MODIFY
04e317ba72d0790 Amir Goldstein          2022-02-23  587  	 * event in its mask.
04e317ba72d0790 Amir Goldstein          2022-02-23  588  	 * Otherwise, return if none of the marks care about this type of event.
613a807fe7c793c Eric Paris              2010-07-28  589  	 */
71d734103edfa2b Mel Gorman              2020-07-08  590  	test_mask = (mask & ALL_FSNOTIFY_EVENTS);
04e317ba72d0790 Amir Goldstein          2022-02-23  591  	if (!(test_mask & marks_mask))
613a807fe7c793c Eric Paris              2010-07-28  592  		return 0;
75c1be487a690db Eric Paris              2010-07-28  593  
9385a84d7e1f658 Jan Kara                2016-11-10  594  	iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
75c1be487a690db Eric Paris              2010-07-28  595  
07a3b8d0bf726a1 Amir Goldstein          2024-03-17  596  	if (sbinfo) {
1c9007d62bea6fd Amir Goldstein          2021-11-29  597  		iter_info.marks[FSNOTIFY_ITER_TYPE_SB] =
07a3b8d0bf726a1 Amir Goldstein          2024-03-17 @598  			fsnotify_first_mark(&sbinfo->sb_marks);
07a3b8d0bf726a1 Amir Goldstein          2024-03-17  599  	}
9bdda4e9cf2dcec Amir Goldstein          2018-09-01  600  	if (mnt) {
1c9007d62bea6fd Amir Goldstein          2021-11-29  601  		iter_info.marks[FSNOTIFY_ITER_TYPE_VFSMOUNT] =
3427ce715541234 Miklos Szeredi          2017-10-30  602  			fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
7131485a93679ff Eric Paris              2009-12-17  603  	}
9b93f33105f5f9b Amir Goldstein          2020-07-16  604  	if (inode) {
1c9007d62bea6fd Amir Goldstein          2021-11-29  605  		iter_info.marks[FSNOTIFY_ITER_TYPE_INODE] =
9b93f33105f5f9b Amir Goldstein          2020-07-16  606  			fsnotify_first_mark(&inode->i_fsnotify_marks);
9b93f33105f5f9b Amir Goldstein          2020-07-16  607  	}
e54183fa7047c15 Amir Goldstein          2021-11-29  608  	if (inode2) {
e54183fa7047c15 Amir Goldstein          2021-11-29  609  		iter_info.marks[inode2_type] =
e54183fa7047c15 Amir Goldstein          2021-11-29  610  			fsnotify_first_mark(&inode2->i_fsnotify_marks);
497b0c5a7c0688c Amir Goldstein          2020-07-16  611  	}
fab7dcc061e159e Miklos Szeredi          2024-12-06  612  	if (mnt_data) {
fab7dcc061e159e Miklos Szeredi          2024-12-06  613  		iter_info.marks[FSNOTIFY_ITER_TYPE_MNTNS] =
fab7dcc061e159e Miklos Szeredi          2024-12-06 @614  			fsnotify_first_mark(&mnt_data->ns->n_fsnotify_marks);
fab7dcc061e159e Miklos Szeredi          2024-12-06  615  	}
75c1be487a690db Eric Paris              2010-07-28  616  
8edc6e1688fc8f0 Jan Kara                2014-11-13  617  	/*
60f7ed8c7c4d06a Amir Goldstein          2018-09-01  618  	 * We need to merge inode/vfsmount/sb mark lists so that e.g. inode mark
60f7ed8c7c4d06a Amir Goldstein          2018-09-01  619  	 * ignore masks are properly reflected for mount/sb mark notifications.
8edc6e1688fc8f0 Jan Kara                2014-11-13  620  	 * That's why this traversal is so complicated...
8edc6e1688fc8f0 Jan Kara                2014-11-13  621  	 */
d9a6f30bb89309a Amir Goldstein          2018-04-20  622  	while (fsnotify_iter_select_report_types(&iter_info)) {
b54cecf5e2293d1 Amir Goldstein          2020-06-07  623  		ret = send_to_group(mask, data, data_type, dir, file_name,
b54cecf5e2293d1 Amir Goldstein          2020-06-07  624  				    cookie, &iter_info);
613a807fe7c793c Eric Paris              2010-07-28  625  
ff8bcbd03da881b Eric Paris              2010-10-28  626  		if (ret && (mask & ALL_FSNOTIFY_PERM_EVENTS))
ff8bcbd03da881b Eric Paris              2010-10-28  627  			goto out;
ff8bcbd03da881b Eric Paris              2010-10-28  628  
d9a6f30bb89309a Amir Goldstein          2018-04-20  629  		fsnotify_iter_next(&iter_info);
90586523eb4b349 Eric Paris              2009-05-21  630  	}
ff8bcbd03da881b Eric Paris              2010-10-28  631  	ret = 0;
ff8bcbd03da881b Eric Paris              2010-10-28  632  out:
9385a84d7e1f658 Jan Kara                2016-11-10  633  	srcu_read_unlock(&fsnotify_mark_srcu, iter_info.srcu_idx);
c4ec54b40d33f80 Eric Paris              2009-12-17  634  
98b5c10d320adfa Jean-Christophe Dubois  2010-03-23  635  	return ret;
90586523eb4b349 Eric Paris              2009-05-21  636  }
90586523eb4b349 Eric Paris              2009-05-21  637  EXPORT_SYMBOL_GPL(fsnotify);
90586523eb4b349 Eric Paris              2009-05-21  638  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

