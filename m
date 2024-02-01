Return-Path: <linux-fsdevel+bounces-9785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5D844DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 01:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933781C26687
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8943B20EB;
	Thu,  1 Feb 2024 00:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF2n9Q1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FDE210D;
	Thu,  1 Feb 2024 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747928; cv=none; b=MPcx9yulRfX0PGfZBIUbfvihTbpgcPwNOjofQ3vR0XOTqlcNvXHE1XLI20WzGAmEB/575zG1+PP9NKO+4GmuerqF6EOY2M/LZRh1K+SL32R5S57VZXoB0T8hEWar07c1w+NOfSEvZKJAYWPz+vKuepOndHTHrUkZpWitiUJfH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747928; c=relaxed/simple;
	bh=cD8xO3RrSExwk755OnTUoazVyYMJjvg2q3VAD5y/F/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+RtHsX02TOZ43c/xfE/v6WvxRyUqFLWqc2vgzXqybEDMweZCagQqwZRuZsRV86bW3B59LYI9jz1a4mSRrmMry/KodleE/87Qc3xtrXAHUsY+3+V1w2QJSWzFm0k1C/rDNY5beRFMUns5T2ETcfOPEKTww59Ai89dO6KTgtv+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF2n9Q1N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706747926; x=1738283926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cD8xO3RrSExwk755OnTUoazVyYMJjvg2q3VAD5y/F/Y=;
  b=UF2n9Q1NhrnD8WVds7/IyZ9ddFDlbjQhPSZ3M4Sg6H1matJak2MH5wI+
   Tc5eDKrivJc3W9kwW7r/C5WpnlejY5q3LDUAe1ugrEaoevNbDMtU0vHY+
   8RmHqBztyy2iwF42Qs9WiJ0XMw/fnBE3Zp9vrmOnR9ggXZ3C2loWBlXsW
   n1KIj8fyfZO2k+tx9KSTZxO4yhx3Hs+Lt3Un8Yx682T3x/yMr8KuOmrcH
   ZshJ9V4LPhFLp3dpXNz0qnOA5NX8UqezV+aTTOuBgQ+wMGnloF+Qsl7ZH
   sUhl6PkxIESbtKlZ3ta3BVYg7ECEcOyoClBbOpvoVdYyWUka+S0mPZ3lY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3631150"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3631150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="30697452"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2024 16:38:42 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVL5v-0002C4-2c;
	Thu, 01 Feb 2024 00:38:27 +0000
Date: Thu, 1 Feb 2024 08:37:28 +0800
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
Subject: Re: [PATCH DRAFT 1/4] : tracefs: port to kernfs
Message-ID: <202402010834.J85Qu3eN-lkp@intel.com>
References: <20240131-tracefs-kernfs-v1-1-f20e2e9a8d61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-tracefs-kernfs-v1-1-f20e2e9a8d61@kernel.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 41bccc98fb7931d63d03f326a746ac4d429c1dd3]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/tracefs-port-to-kernfs/20240131-214120
base:   41bccc98fb7931d63d03f326a746ac4d429c1dd3
patch link:    https://lore.kernel.org/r/20240131-tracefs-kernfs-v1-1-f20e2e9a8d61%40kernel.org
patch subject: [PATCH DRAFT 1/4] : tracefs: port to kernfs
config: arc-randconfig-001-20240201 (https://download.01.org/0day-ci/archive/20240201/202402010834.J85Qu3eN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010834.J85Qu3eN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010834.J85Qu3eN-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/trace/trace_hwlat.c: In function 'init_tracefs':
   kernel/trace/trace_hwlat.c:778:17: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
     778 |         top_dir = tracefs_create_dir("hwlat_detector", NULL);
         |                 ^
>> kernel/trace/trace_hwlat.c:783:51: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     783 |                                                   top_dir,
         |                                                   ^~~~~~~
         |                                                   |
         |                                                   struct dentry *
   In file included from kernel/trace/trace_hwlat.c:41:
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_hwlat.c:785:51: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     785 |                                                   &trace_min_max_fops);
         |                                                   ^~~~~~~~~~~~~~~~~~~
         |                                                   |
         |                                                   const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_hwlat.c:782:29: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
     782 |         hwlat_sample_window = tracefs_create_file("window", TRACE_MODE_WRITE,
         |                             ^
   kernel/trace/trace_hwlat.c:790:50: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     790 |                                                  top_dir,
         |                                                  ^~~~~~~
         |                                                  |
         |                                                  struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_hwlat.c:792:50: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     792 |                                                  &trace_min_max_fops);
         |                                                  ^~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_hwlat.c:789:28: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
     789 |         hwlat_sample_width = tracefs_create_file("width", TRACE_MODE_WRITE,
         |                            ^
   kernel/trace/trace_hwlat.c:806:24: error: passing argument 1 of 'tracefs_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
     806 |         tracefs_remove(top_dir);
         |                        ^~~~~~~
         |                        |
         |                        struct dentry *
   include/linux/tracefs.h:99:41: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      99 | void tracefs_remove(struct kernfs_node *kn);
         |                     ~~~~~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors
--
   kernel/trace/trace_osnoise.c: In function 'init_timerlat_stack_tracefs':
   kernel/trace/trace_osnoise.c:2695:68: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2695 |         tmp = tracefs_create_file("print_stack", TRACE_MODE_WRITE, top_dir,
         |                                                                    ^~~~~~~
         |                                                                    |
         |                                                                    struct dentry *
   In file included from kernel/trace/trace_osnoise.c:20:
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2696:57: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2696 |                                   &osnoise_print_stack, &trace_min_max_fops);
         |                                                         ^~~~~~~~~~~~~~~~~~~
         |                                                         |
         |                                                         const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_osnoise.c:2695:13: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2695 |         tmp = tracefs_create_file("print_stack", TRACE_MODE_WRITE, top_dir,
         |             ^
   kernel/trace/trace_osnoise.c: In function 'osnoise_create_cpu_timerlat_fd':
>> kernel/trace/trace_osnoise.c:2723:49: error: passing argument 2 of 'tracefs_create_dir' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2723 |         per_cpu = tracefs_create_dir("per_cpu", top_dir);
         |                                                 ^~~~~~~
         |                                                 |
         |                                                 struct dentry *
   include/linux/tracefs.h:97:60: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      97 |                                        struct kernfs_node *parent);
         |                                        ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2723:17: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2723 |         per_cpu = tracefs_create_dir("per_cpu", top_dir);
         |                 ^
   kernel/trace/trace_osnoise.c:2729:55: error: passing argument 2 of 'tracefs_create_dir' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2729 |                 cpu_dir = tracefs_create_dir(cpu_str, per_cpu);
         |                                                       ^~~~~~~
         |                                                       |
         |                                                       struct dentry *
   include/linux/tracefs.h:97:60: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      97 |                                        struct kernfs_node *parent);
         |                                        ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2729:25: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2729 |                 cpu_dir = tracefs_create_dir(cpu_str, per_cpu);
         |                         ^
   kernel/trace/trace_osnoise.c:2745:24: error: passing argument 1 of 'tracefs_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2745 |         tracefs_remove(per_cpu);
         |                        ^~~~~~~
         |                        |
         |                        struct dentry *
   include/linux/tracefs.h:99:41: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      99 | void tracefs_remove(struct kernfs_node *kn);
         |                     ~~~~~~~~~~~~~~~~~~~~^~
   kernel/trace/trace_osnoise.c: In function 'init_timerlat_tracefs':
   kernel/trace/trace_osnoise.c:2757:75: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2757 |         tmp = tracefs_create_file("timerlat_period_us", TRACE_MODE_WRITE, top_dir,
         |                                                                           ^~~~~~~
         |                                                                           |
         |                                                                           struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2758:53: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2758 |                                   &timerlat_period, &trace_min_max_fops);
         |                                                     ^~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_osnoise.c:2757:13: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2757 |         tmp = tracefs_create_file("timerlat_period_us", TRACE_MODE_WRITE, top_dir,
         |             ^
   kernel/trace/trace_osnoise.c: In function 'init_tracefs':
   kernel/trace/trace_osnoise.c:2792:17: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2792 |         top_dir = tracefs_create_dir("osnoise", NULL);
         |                 ^
   kernel/trace/trace_osnoise.c:2796:66: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2796 |         tmp = tracefs_create_file("period_us", TRACE_MODE_WRITE, top_dir,
         |                                                                  ^~~~~~~
         |                                                                  |
         |                                                                  struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2797:52: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2797 |                                   &osnoise_period, &trace_min_max_fops);
         |                                                    ^~~~~~~~~~~~~~~~~~~
         |                                                    |
         |                                                    const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_osnoise.c:2796:13: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2796 |         tmp = tracefs_create_file("period_us", TRACE_MODE_WRITE, top_dir,
         |             ^
   kernel/trace/trace_osnoise.c:2801:67: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2801 |         tmp = tracefs_create_file("runtime_us", TRACE_MODE_WRITE, top_dir,
         |                                                                   ^~~~~~~
         |                                                                   |
         |                                                                   struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2802:53: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2802 |                                   &osnoise_runtime, &trace_min_max_fops);
         |                                                     ^~~~~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_osnoise.c:2801:13: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2801 |         tmp = tracefs_create_file("runtime_us", TRACE_MODE_WRITE, top_dir,
         |             ^
   kernel/trace/trace_osnoise.c:2806:72: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2806 |         tmp = tracefs_create_file("stop_tracing_us", TRACE_MODE_WRITE, top_dir,
         |                                                                        ^~~~~~~
         |                                                                        |
         |                                                                        struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_osnoise.c:2807:61: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]


vim +/tracefs_create_file +783 kernel/trace/trace_hwlat.c

e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  753) 
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  754  static const struct file_operations thread_mode_fops = {
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  755  	.open		= hwlat_mode_open,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  756  	.read		= seq_read,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  757  	.llseek		= seq_lseek,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  758  	.release	= seq_release,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  759  	.write		= hwlat_mode_write
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  760  };
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  761) /**
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  762)  * init_tracefs - A function to initialize the tracefs interface files
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  763)  *
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  764)  * This function creates entries in tracefs for "hwlat_detector".
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  765)  * It creates the hwlat_detector directory in the tracing directory,
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  766)  * and within that directory is the count, width and window files to
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  767)  * change and view those values.
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  768)  */
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  769) static int init_tracefs(void)
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  770) {
22c36b18263426 Wei Yang                   2020-07-12  771  	int ret;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  772) 	struct dentry *top_dir;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  773) 
22c36b18263426 Wei Yang                   2020-07-12  774  	ret = tracing_init_dentry();
22c36b18263426 Wei Yang                   2020-07-12  775  	if (ret)
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  776) 		return -ENOMEM;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  777) 
22c36b18263426 Wei Yang                   2020-07-12  778  	top_dir = tracefs_create_dir("hwlat_detector", NULL);
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  779) 	if (!top_dir)
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  780) 		return -ENOMEM;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  781) 
21ccc9cd721162 Steven Rostedt (VMware     2021-08-18  782) 	hwlat_sample_window = tracefs_create_file("window", TRACE_MODE_WRITE,
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23 @783) 						  top_dir,
f27a1c9e1ba1e4 Daniel Bristot de Oliveira 2021-06-22  784  						  &hwlat_window,
f27a1c9e1ba1e4 Daniel Bristot de Oliveira 2021-06-22  785  						  &trace_min_max_fops);
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  786) 	if (!hwlat_sample_window)
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  787) 		goto err;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  788) 
21ccc9cd721162 Steven Rostedt (VMware     2021-08-18  789) 	hwlat_sample_width = tracefs_create_file("width", TRACE_MODE_WRITE,
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  790) 						 top_dir,
f27a1c9e1ba1e4 Daniel Bristot de Oliveira 2021-06-22  791  						 &hwlat_width,
f27a1c9e1ba1e4 Daniel Bristot de Oliveira 2021-06-22  792  						 &trace_min_max_fops);
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  793) 	if (!hwlat_sample_width)
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  794) 		goto err;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  795) 
21ccc9cd721162 Steven Rostedt (VMware     2021-08-18  796) 	hwlat_thread_mode = trace_create_file("mode", TRACE_MODE_WRITE,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  797  					      top_dir,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  798  					      NULL,
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  799  					      &thread_mode_fops);
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  800  	if (!hwlat_thread_mode)
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  801  		goto err;
8fa826b7344d67 Daniel Bristot de Oliveira 2021-06-22  802  
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  803) 	return 0;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  804) 
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  805)  err:
a3d1e7eb5abe3a Al Viro                    2019-11-18  806  	tracefs_remove(top_dir);
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  807) 	return -ENOMEM;
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  808) }
e7c15cd8a11333 Steven Rostedt (Red Hat    2016-06-23  809) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

