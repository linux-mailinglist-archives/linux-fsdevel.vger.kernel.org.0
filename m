Return-Path: <linux-fsdevel+bounces-9799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2A844FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 04:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F272AB2C583
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 03:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581A3AC08;
	Thu,  1 Feb 2024 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnUrcKvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8373A8E3;
	Thu,  1 Feb 2024 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706758285; cv=none; b=Cx1ZpRF3h3lmKdD8IZCSWGXFFohKgFy5N7ASkZ25+FSEeh0Hg1kr0Cx3/2EzUZQD1820C+ehP1u6oPMaPz3plOYb/7aDU/zjsde+dv86KPWJTbSAByi9hdfadaWr5szaSp0vtxToM0WMwU0lHVkGEeDDFIkBcC6yJ1Igffpi+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706758285; c=relaxed/simple;
	bh=F+jUlRtNHrP0LewC79ckokmwI/v54HAeYJWfQyggfA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpRE7ak7mCt7qifRPTMV5e9jAL++vBZi+97Jddr2xhSBYnvXLHhHK6IGjjZlj8mjfdr8u5nnDZObuJV+DlBfAxLOXAonHB7fhRR5sm4sjqghHU2R9Qq4XALWNHMKBQeXBuqFt5vE8ZYE71ap4wq2tRv6ueVnsrDjpBpLRqfVTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnUrcKvy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706758283; x=1738294283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F+jUlRtNHrP0LewC79ckokmwI/v54HAeYJWfQyggfA8=;
  b=QnUrcKvyLC+MjC01CDYA5TvDbl/YyqpprbsfNKiywVKU9WNt/63oq074
   Ji3gnoqUuh5VTjQxza1kroUPT3lsXGyqhYmJeIeDyfYAgbA5D+32ALYQb
   6Hp9Xdfy+Xw9f8MU1lxZl8oP9spbvjn9gVW6/SyRb7KfhePWd9FddTh+w
   SmOag7B6Vhy2cLi195LMmI9OREg/KrRgb0GKci68kYXqGVLyw5BOzszz0
   cFRkavgj+/qtxVenGIVSnruQOmr5RyOYEE2U/ff8IHRa0EPErd2755lW8
   tnvGV6kfFXUM7uBY/UWepLdZxd3BGIbmQpZi+Ofjo6rfqY5ar2nFShrA2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10897727"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10897727"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 19:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788824084"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788824084"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 19:31:19 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVNnI-0002KK-2D;
	Thu, 01 Feb 2024 03:31:16 +0000
Date: Thu, 1 Feb 2024 11:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH DRAFT 3/4] : hwlat: port struct file_operations
 thread_mode_fops to struct kernfs_ops
Message-ID: <202402011108.V2Y9QaTk-lkp@intel.com>
References: <20240131-tracefs-kernfs-v1-3-f20e2e9a8d61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-tracefs-kernfs-v1-3-f20e2e9a8d61@kernel.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 41bccc98fb7931d63d03f326a746ac4d429c1dd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/tracefs-port-to-kernfs/20240131-214120
base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
patch link:    https://lore.kernel.org/r/20240131-tracefs-kernfs-v1-3-f20e2e9a8d61%40kernel.org
patch subject: [PATCH DRAFT 3/4] : hwlat: port struct file_operations thread_mode_fops to struct kernfs_ops
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240201/202402011108.V2Y9QaTk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402011108.V2Y9QaTk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402011108.V2Y9QaTk-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_hwlat.c: In function 'hwlat_mode_write':
   kernel/trace/trace_hwlat.c:672:14: error: 'buf' redeclared as different kind of symbol
     672 |         char buf[64];
         |              ^~~
   kernel/trace/trace_hwlat.c:667:68: note: previous definition of 'buf' with type 'char *'
     667 | static ssize_t hwlat_mode_write(struct kernfs_open_file *of, char *buf,
         |                                                              ~~~~~~^~~
   kernel/trace/trace_hwlat.c:672:14: warning: unused variable 'buf' [-Wunused-variable]
     672 |         char buf[64];
         |              ^~~
   kernel/trace/trace_hwlat.c: At top level:
   kernel/trace/trace_hwlat.c:736:10: error: 'const struct kernfs_ops' has no member named 'start'
     736 |         .start                  = s_mode_start,
         |          ^~~~~
   kernel/trace/trace_hwlat.c:736:9: warning: the address of 's_mode_start' will always evaluate as 'true' [-Waddress]
     736 |         .start                  = s_mode_start,
         |         ^
   kernel/trace/trace_hwlat.c:737:10: error: 'const struct kernfs_ops' has no member named 'next'
     737 |         .next                   = s_mode_next,
         |          ^~~~
>> kernel/trace/trace_hwlat.c:737:35: error: initialization of 'ssize_t (*)(struct kernfs_open_file *, char *, size_t,  loff_t)' {aka 'long int (*)(struct kernfs_open_file *, char *, long unsigned int,  long long int)'} from incompatible pointer type 'void * (*)(struct seq_file *, void *, loff_t *)' {aka 'void * (*)(struct seq_file *, void *, long long int *)'} [-Werror=incompatible-pointer-types]
     737 |         .next                   = s_mode_next,
         |                                   ^~~~~~~~~~~
   kernel/trace/trace_hwlat.c:737:35: note: (near initialization for 'thread_mode_fops.write')
   kernel/trace/trace_hwlat.c:738:10: error: 'const struct kernfs_ops' has no member named 'show'
     738 |         .show                   = s_mode_show,
         |          ^~~~
   kernel/trace/trace_hwlat.c:738:35: error: initialization of '__poll_t (*)(struct kernfs_open_file *, struct poll_table_struct *)' {aka 'unsigned int (*)(struct kernfs_open_file *, struct poll_table_struct *)'} from incompatible pointer type 'int (*)(struct seq_file *, void *)' [-Werror=incompatible-pointer-types]
     738 |         .show                   = s_mode_show,
         |                                   ^~~~~~~~~~~
   kernel/trace/trace_hwlat.c:738:35: note: (near initialization for 'thread_mode_fops.poll')
   kernel/trace/trace_hwlat.c:739:10: error: 'const struct kernfs_ops' has no member named 'stop'
     739 |         .stop                   = s_mode_stop,
         |          ^~~~
   kernel/trace/trace_hwlat.c:739:35: error: initialization of 'int (*)(struct kernfs_open_file *, struct vm_area_struct *)' from incompatible pointer type 'void (*)(struct seq_file *, void *)' [-Werror=incompatible-pointer-types]
     739 |         .stop                   = s_mode_stop,
         |                                   ^~~~~~~~~~~
   kernel/trace/trace_hwlat.c:739:35: note: (near initialization for 'thread_mode_fops.mmap')
   kernel/trace/trace_hwlat.c:740:35: warning: initialized field overwritten [-Woverride-init]
     740 |         .write                  = hwlat_mode_write,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/trace/trace_hwlat.c:740:35: note: (near initialization for 'thread_mode_fops.write')
   kernel/trace/trace_hwlat.c: In function 'init_tracefs':
   kernel/trace/trace_hwlat.c:766:51: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     766 |                                                   &trace_min_max_fops);
         |                                                   ^~~~~~~~~~~~~~~~~~~
         |                                                   |
         |                                                   const struct file_operations *
   In file included from kernel/trace/trace_hwlat.c:41:
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_hwlat.c:773:50: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     773 |                                                  &trace_min_max_fops);
         |                                                  ^~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_hwlat.c:778:47: error: passing argument 3 of 'trace_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     778 |                                               top_dir,
         |                                               ^~~~~~~
         |                                               |
         |                                               struct kernfs_node *
   In file included from kernel/trace/trace_hwlat.c:46:
   kernel/trace/trace.h:629:49: note: expected 'struct dentry *' but argument is of type 'struct kernfs_node *'
     629 |                                  struct dentry *parent,
         |                                  ~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_hwlat.c:780:47: error: passing argument 5 of 'trace_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     780 |                                               &thread_mode_fops);
         |                                               ^~~~~~~~~~~~~~~~~
         |                                               |
         |                                               const struct kernfs_ops *
   kernel/trace/trace.h:631:64: note: expected 'const struct file_operations *' but argument is of type 'const struct kernfs_ops *'
     631 |                                  const struct file_operations *fops);
         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   kernel/trace/trace_hwlat.c:777:27: error: assignment to 'struct kernfs_node *' from incompatible pointer type 'struct dentry *' [-Werror=incompatible-pointer-types]
     777 |         hwlat_thread_mode = trace_create_file("mode", TRACE_MODE_WRITE,
         |                           ^
   cc1: some warnings being treated as errors


vim +737 kernel/trace/trace_hwlat.c

   733	
   734	static const struct kernfs_ops thread_mode_fops = {
   735		.atomic_write_len	= PAGE_SIZE,
   736		.start			= s_mode_start,
 > 737		.next			= s_mode_next,
   738		.show			= s_mode_show,
   739		.stop			= s_mode_stop,
   740		.write			= hwlat_mode_write,
   741	};
   742	/**
   743	 * init_tracefs - A function to initialize the tracefs interface files
   744	 *
   745	 * This function creates entries in tracefs for "hwlat_detector".
   746	 * It creates the hwlat_detector directory in the tracing directory,
   747	 * and within that directory is the count, width and window files to
   748	 * change and view those values.
   749	 */
   750	static int init_tracefs(void)
   751	{
   752		int ret;
   753		struct kernfs_node *top_dir;
   754	
   755		ret = tracing_init_dentry();
   756		if (ret)
   757			return -ENOMEM;
   758	
   759		top_dir = tracefs_create_dir("hwlat_detector", NULL);
   760		if (!top_dir)
   761			return -ENOMEM;
   762	
   763		hwlat_sample_window = tracefs_create_file("window", TRACE_MODE_WRITE,
   764							  top_dir,
   765							  &hwlat_window,
   766							  &trace_min_max_fops);
   767		if (!hwlat_sample_window)
   768			goto err;
   769	
   770		hwlat_sample_width = tracefs_create_file("width", TRACE_MODE_WRITE,
   771							 top_dir,
   772							 &hwlat_width,
   773							 &trace_min_max_fops);
   774		if (!hwlat_sample_width)
   775			goto err;
   776	
   777		hwlat_thread_mode = trace_create_file("mode", TRACE_MODE_WRITE,
   778						      top_dir,
   779						      NULL,
   780						      &thread_mode_fops);
   781		if (!hwlat_thread_mode)
   782			goto err;
   783	
   784		return 0;
   785	
   786	 err:
   787		tracefs_remove(top_dir);
   788		return -ENOMEM;
   789	}
   790	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

