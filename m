Return-Path: <linux-fsdevel+bounces-9784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3127D844DF2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 01:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B51F23F39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B6210D;
	Thu,  1 Feb 2024 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjXiUOzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F61FB5;
	Thu,  1 Feb 2024 00:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747909; cv=none; b=p57/H3MgR0Wqkzsr1GpOwdidep6ASNmPW74b1Na2/+/PomWFLj5U7lz6pmbmd2rY6V83BHEfQQyFxCthwhl8JfpKuIb53s+9qrxNE9FEg+70wV9xPG4KwBD0bauSv/J/gl+6U+qZbwy/onmwM2WJP9IUgZfhHpC4IClCZ08D/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747909; c=relaxed/simple;
	bh=S91/mZIEPwH65JVrzQ7FSYbft5tkvwWzo3ssEZf3DFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ1Cli3RtOVgpLpJrLIPJMziZJsnjqNGjNgRjXl4g7yV5Mx+iW0NXyKD902BXK/3Q2YOOW8M8zTlCJV5OU/FvDrtfo8qkJa3Swnp2nu9lAM0ABu6Nav+S+P5+MSVhSHxXJANghX6sqKL1W/o7COev1rbMAudo/hlvLIXN/eKtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjXiUOzm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706747907; x=1738283907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S91/mZIEPwH65JVrzQ7FSYbft5tkvwWzo3ssEZf3DFw=;
  b=SjXiUOzmDKGqJJGBzMA77iZBe5A+LMVm0iK3XAaJRJ6T6/HyUYpC65ul
   KHDuDb/+kjF7HSklh9OY1OxboNeJono+j2iLSd3zvVtBlC3Ky9NrWwDQQ
   M3zw8th0AFyHq19hRPM+vWnVSelM4dq9s7KKfDBAgc1TQ58nawpmp/up9
   mOQIZ7dgGH6mOQoBkOBp84krff3KphOohkqQSi1+55K++s/+W5sq1Y1n/
   Kij6gPmGVCR03TbAJIxZzqLcNwkaL7vw5G5s7L5cRgJr0V3tKh0wd8uAu
   qIIde/KBq5a8IPTuPQG40jE37TK0NyYrxdbMzwwCzHoekQ8p8cZzy6zpX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3631122"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="3631122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:38:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="30697433"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2024 16:38:22 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVL5S-0002C2-0s;
	Thu, 01 Feb 2024 00:38:04 +0000
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
Message-ID: <202402010828.cl2RunjG-lkp@intel.com>
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20240201/202402010828.cl2RunjG-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010828.cl2RunjG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010828.cl2RunjG-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/kernfs/mount.c: In function 'kernfs_node_owner':
>> fs/kernfs/mount.c:248:20: error: 'struct kernfs_node' has no member named 'iattrs'; did you mean 'iattr'?
     248 |         return kn->iattrs->ia_uid;
         |                    ^~~~~~
         |                    iattr
   fs/kernfs/mount.c: At top level:
>> fs/kernfs/mount.c:251:8: error: conflicting types for 'kernfs_node_group'; have 'kuid_t(struct kernfs_node *)'
     251 | kuid_t kernfs_node_group(struct kernfs_node *kn)
         |        ^~~~~~~~~~~~~~~~~
   In file included from fs/kernfs/kernfs-internal.h:19,
                    from fs/kernfs/mount.c:22:
   include/linux/kernfs.h:248:8: note: previous declaration of 'kernfs_node_group' with type 'kgid_t(struct kernfs_node *)'
     248 | kgid_t kernfs_node_group(struct kernfs_node *kn);
         |        ^~~~~~~~~~~~~~~~~
   fs/kernfs/mount.c: In function 'kernfs_node_group':
   fs/kernfs/mount.c:253:20: error: 'struct kernfs_node' has no member named 'iattrs'; did you mean 'iattr'?
     253 |         return kn->iattrs->ia_gid;
         |                    ^~~~~~
         |                    iattr
   fs/kernfs/mount.c: In function 'kernfs_node_owner':
   fs/kernfs/mount.c:249:1: warning: control reaches end of non-void function [-Wreturn-type]
     249 | }
         | ^
   fs/kernfs/mount.c: In function 'kernfs_node_group':
   fs/kernfs/mount.c:254:1: warning: control reaches end of non-void function [-Wreturn-type]
     254 | }
         | ^
--
   kernel/trace/trace.c: In function 'tracing_dentry_percpu':
>> kernel/trace/trace.c:8916:56: error: passing argument 2 of 'tracefs_create_dir' from incompatible pointer type [-Werror=incompatible-pointer-types]
    8916 |         tr->percpu_dir = tracefs_create_dir("per_cpu", d_tracer);
         |                                                        ^~~~~~~~
         |                                                        |
         |                                                        struct dentry *
   In file included from kernel/trace/trace.c:24:
   include/linux/tracefs.h:97:60: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      97 |                                        struct kernfs_node *parent);
         |                                        ~~~~~~~~~~~~~~~~~~~~^~~~~~
>> kernel/trace/trace.c:8916:24: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    8916 |         tr->percpu_dir = tracefs_create_dir("per_cpu", d_tracer);
         |                        ^
   kernel/trace/trace.c: In function 'tracing_init_tracefs_percpu':
   kernel/trace/trace.c:8946:45: error: passing argument 2 of 'tracefs_create_dir' from incompatible pointer type [-Werror=incompatible-pointer-types]
    8946 |         d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
         |                                             ^~~~~~~~
         |                                             |
         |                                             struct dentry *
   include/linux/tracefs.h:97:60: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      97 |                                        struct kernfs_node *parent);
         |                                        ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace.c:8946:15: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    8946 |         d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
         |               ^
   kernel/trace/trace.c: In function 'trace_create_file':
>> kernel/trace/trace.c:9156:47: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9156 |         ret = tracefs_create_file(name, mode, parent, data, fops);
         |                                               ^~~~~~
         |                                               |
         |                                               struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace.c:9156:61: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9156 |         ret = tracefs_create_file(name, mode, parent, data, fops);
         |                                                             ^~~~
         |                                                             |
         |                                                             const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace.c:9156:13: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    9156 |         ret = tracefs_create_file(name, mode, parent, data, fops);
         |             ^
   kernel/trace/trace.c: In function 'trace_options_init_dentry':
   kernel/trace/trace.c:9175:53: error: passing argument 2 of 'tracefs_create_dir' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9175 |         tr->options = tracefs_create_dir("options", d_tracer);
         |                                                     ^~~~~~~~
         |                                                     |
         |                                                     struct dentry *
   include/linux/tracefs.h:97:60: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      97 |                                        struct kernfs_node *parent);
         |                                        ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace.c:9175:21: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    9175 |         tr->options = tracefs_create_dir("options", d_tracer);
         |                     ^
   kernel/trace/trace.c: In function 'trace_array_create_dir':
   kernel/trace/trace.c:9631:17: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    9631 |         tr->dir = tracefs_create_dir(tr->name, trace_instance_dir);
         |                 ^
>> kernel/trace/trace.c:9637:34: error: passing argument 1 of 'tracefs_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9637 |                 tracefs_remove(tr->dir);
         |                                ~~^~~~~
         |                                  |
         |                                  struct dentry *
   include/linux/tracefs.h:99:41: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      99 | void tracefs_remove(struct kernfs_node *kn);
         |                     ~~~~~~~~~~~~~~~~~~~~^~
   kernel/trace/trace.c: In function '__remove_instance':
   kernel/trace/trace.c:9818:26: error: passing argument 1 of 'tracefs_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9818 |         tracefs_remove(tr->dir);
         |                        ~~^~~~~
         |                          |
         |                          struct dentry *
   include/linux/tracefs.h:99:41: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      99 | void tracefs_remove(struct kernfs_node *kn);
         |                     ~~~~~~~~~~~~~~~~~~~~^~
   cc1: some warnings being treated as errors
--
   kernel/trace/trace_stat.c: In function 'destroy_session':
>> kernel/trace/trace_stat.c:69:31: error: passing argument 1 of 'tracefs_remove' from incompatible pointer type [-Werror=incompatible-pointer-types]
      69 |         tracefs_remove(session->file);
         |                        ~~~~~~~^~~~~~
         |                               |
         |                               struct dentry *
   In file included from kernel/trace/trace_stat.c:16:
   include/linux/tracefs.h:99:41: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      99 | void tracefs_remove(struct kernfs_node *kn);
         |                     ~~~~~~~~~~~~~~~~~~~~^~
   kernel/trace/trace_stat.c: In function 'tracing_stat_init':
>> kernel/trace/trace_stat.c:285:18: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
     285 |         stat_dir = tracefs_create_dir("trace_stat", NULL);
         |                  ^
   kernel/trace/trace_stat.c: In function 'init_stat_file':
>> kernel/trace/trace_stat.c:301:45: error: passing argument 3 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     301 |                                             stat_dir, session,
         |                                             ^~~~~~~~
         |                                             |
         |                                             struct dentry *
   include/linux/tracefs.h:93:61: note: expected 'struct kernfs_node *' but argument is of type 'struct dentry *'
      93 |                                         struct kernfs_node *parent, void *data,
         |                                         ~~~~~~~~~~~~~~~~~~~~^~~~~~
   kernel/trace/trace_stat.c:302:45: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
     302 |                                             &tracing_stat_fops);
         |                                             ^~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             const struct file_operations *
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_stat.c:300:23: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
     300 |         session->file = tracefs_create_file(session->ts->name, TRACE_MODE_WRITE,
         |                       ^
   cc1: some warnings being treated as errors
--
   kernel/trace/trace_events_synth.c: In function 'trace_events_synth_init':
>> kernel/trace/trace_events_synth.c:2322:49: error: passing argument 5 of 'tracefs_create_file' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2322 |                                     NULL, NULL, &synth_events_fops);
         |                                                 ^~~~~~~~~~~~~~~~~~
         |                                                 |
         |                                                 const struct file_operations *
   In file included from kernel/trace/trace_events_synth.c:15:
   include/linux/tracefs.h:94:66: note: expected 'const struct kernfs_ops *' but argument is of type 'const struct file_operations *'
      94 |                                         const struct kernfs_ops *ops);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   kernel/trace/trace_events_synth.c:2321:15: error: assignment to 'struct dentry *' from incompatible pointer type 'struct kernfs_node *' [-Werror=incompatible-pointer-types]
    2321 |         entry = tracefs_create_file("synthetic_events", TRACE_MODE_WRITE,
         |               ^
   cc1: some warnings being treated as errors


vim +248 fs/kernfs/mount.c

   245	
   246	kuid_t kernfs_node_owner(struct kernfs_node *kn)
   247	{
 > 248		return kn->iattrs->ia_uid;
   249	}
   250	
 > 251	kuid_t kernfs_node_group(struct kernfs_node *kn)
   252	{
   253		return kn->iattrs->ia_gid;
   254	}
   255	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

