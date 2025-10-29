Return-Path: <linux-fsdevel+bounces-66318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17540C1B841
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56CBD34AF72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF32F7465;
	Wed, 29 Oct 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0/xvo5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19712DC331;
	Wed, 29 Oct 2025 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750062; cv=none; b=JIlJfd85jrILdl3rFezh0NeuMQoczWq4NK11qFBLGBRhdTsQZwm6cObyWxt35ejikUB9/JfHp93+KxBGj/1hWko84CMXj/I/z3HllFcE7z4qejIMtKHrNffovLTVfpFq6jbk8GlA4eGfPpMpOvv4SHz1puRyGaAM7Gb7uQ8a9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750062; c=relaxed/simple;
	bh=F5n5z0KyfWMmHsQHJAWC2zWOC4RT8iQtcP2+/uIr83Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y85Ih+CUV7XQlGJWxmocFYDiECWZikkNNW8Dx9jl/f565gBtBRmAURJvfgJ+vnO5eG4XyiHdQPbauMd00zlgs+224vk1cEkVbToWJVisbS29NGX+U7qBUhfU/A+6LQQ6PcXSMYo03XCIWIwlDG9TtvSP+jucxGFlnXUMmMJXbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0/xvo5Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761750060; x=1793286060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5n5z0KyfWMmHsQHJAWC2zWOC4RT8iQtcP2+/uIr83Y=;
  b=g0/xvo5YoFNAqu15sBK6xVp6sh1rvNY5zaJ/6J7mEFaIrqJKDqFbJysB
   DO+oiYtIJYRULL+pl31L8sWgYHUTlXvz1J1POMWpIAKKQeJ5oNn8oxsTl
   3VbsvcPeFHOSa+UPLiHRuJdqn5ttUKusriqQGfHVNVJ94OFhICjGN03ud
   Z6aHGooELvEIczdHOL3dy1bYQmnkyoOWIVy8zw0nTD5bBHVuG6Hr9idDA
   PkbpkueX5gJOnKDy6IYWurMU2Nmz5k17FRDj7zFFgVV1M9B+k7gwKWfoU
   Sjo7CmdlavHzlPY/jeouUlSt7/+pSRVGNYCbdu9zVQbocvqVDNRO0k8kW
   A==;
X-CSE-ConnectionGUID: DgXMmgJQREeuu8ZkhRqsCw==
X-CSE-MsgGUID: W4HhHCbLSnqxiYdmqwN44g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="74992007"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="74992007"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 08:00:59 -0700
X-CSE-ConnectionGUID: pK2T9YRIRm6PeQVebwJAJA==
X-CSE-MsgGUID: jevWLkN2QvCOWGSZVzvg2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="190862784"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 29 Oct 2025 08:00:53 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE7b8-000Khx-2A;
	Wed, 29 Oct 2025 14:57:12 +0000
Date: Wed, 29 Oct 2025 22:55:54 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Jann Horn <jannh@google.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 13/72] nstree: introduce a unified tree
Message-ID: <202510292238.OTyD5CXw-lkp@intel.com>
References: <20251029-work-namespace-nstree-listns-v4-13-2e6f823ebdc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-13-2e6f823ebdc0@kernel.org>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3a8660878839faadb4f1a6dd72c3179c1df56787]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Brauner/libfs-allow-to-specify-s_d_flags/20251029-205841
base:   3a8660878839faadb4f1a6dd72c3179c1df56787
patch link:    https://lore.kernel.org/r/20251029-work-namespace-nstree-listns-v4-13-2e6f823ebdc0%40kernel.org
patch subject: [PATCH v4 13/72] nstree: introduce a unified tree
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20251029/202510292238.OTyD5CXw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292238.OTyD5CXw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292238.OTyD5CXw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:18,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/refcount.h:104,
                    from include/linux/ns_common.h:5,
                    from include/linux/nstree.h:5,
                    from kernel/nstree.c:3:
   kernel/nstree.c: In function '__ns_tree_remove':
>> kernel/nstree.c:170:48: error: 'struct ns_tree' has no member named 'type'
     170 |         VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
         |                                                ^~
   include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
      30 | #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
         |                                                               ^
   kernel/nstree.c:170:9: note: in expansion of macro 'VFS_WARN_ON_ONCE'
     170 |         VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
         |         ^~~~~~~~~~~~~~~~
   kernel/nstree.c: In function '__ns_tree_adjoined_rcu':
   kernel/nstree.c:297:98: error: 'struct ns_tree' has no member named 'type'
     297 |         VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ns_type != ns_tree->type);
         |                                                                                                  ^~
   include/linux/build_bug.h:30:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
      30 | #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
         |                                                               ^
   kernel/nstree.c:297:9: note: in expansion of macro 'VFS_WARN_ON_ONCE'
     297 |         VFS_WARN_ON_ONCE(list_entry_rcu(list, struct ns_common, ns_list_node)->ns_type != ns_tree->type);
         |         ^~~~~~~~~~~~~~~~


vim +170 kernel/nstree.c

885fc8ac0a4dc7 Christian Brauner 2025-09-12    2  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   @3  #include <linux/nstree.h>
885fc8ac0a4dc7 Christian Brauner 2025-09-12    4  #include <linux/proc_ns.h>
885fc8ac0a4dc7 Christian Brauner 2025-09-12    5  #include <linux/vfsdebug.h>
885fc8ac0a4dc7 Christian Brauner 2025-09-12    6  
01da9c6ec4269b Christian Brauner 2025-10-29    7  __cacheline_aligned_in_smp DEFINE_SEQLOCK(ns_tree_lock);
01da9c6ec4269b Christian Brauner 2025-10-29    8  static struct rb_root ns_unified_tree = RB_ROOT; /* protected by ns_tree_lock */
01da9c6ec4269b Christian Brauner 2025-10-29    9  
10cdfcd37ade7c Christian Brauner 2025-09-24   10  /**
10cdfcd37ade7c Christian Brauner 2025-09-24   11   * struct ns_tree - Namespace tree
10cdfcd37ade7c Christian Brauner 2025-09-24   12   * @ns_tree: Rbtree of namespaces of a particular type
10cdfcd37ade7c Christian Brauner 2025-09-24   13   * @ns_list: Sequentially walkable list of all namespaces of this type
10cdfcd37ade7c Christian Brauner 2025-09-24   14   * @type: type of namespaces in this tree
10cdfcd37ade7c Christian Brauner 2025-09-24   15   */
10cdfcd37ade7c Christian Brauner 2025-09-24   16  struct ns_tree {
10cdfcd37ade7c Christian Brauner 2025-09-24   17  	struct rb_root ns_tree;
10cdfcd37ade7c Christian Brauner 2025-09-24   18  	struct list_head ns_list;
01da9c6ec4269b Christian Brauner 2025-10-29   19  #ifdef CONFIG_DEBUG_VFS
10cdfcd37ade7c Christian Brauner 2025-09-24   20  	int type;
01da9c6ec4269b Christian Brauner 2025-10-29   21  #endif
10cdfcd37ade7c Christian Brauner 2025-09-24   22  };
10cdfcd37ade7c Christian Brauner 2025-09-24   23  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   24  struct ns_tree mnt_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   25  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   26  	.ns_list = LIST_HEAD_INIT(mnt_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   27  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   28  	.type = CLONE_NEWNS,
01da9c6ec4269b Christian Brauner 2025-10-29   29  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   30  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   31  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   32  struct ns_tree net_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   33  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   34  	.ns_list = LIST_HEAD_INIT(net_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   35  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   36  	.type = CLONE_NEWNET,
01da9c6ec4269b Christian Brauner 2025-10-29   37  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   38  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   39  EXPORT_SYMBOL_GPL(net_ns_tree);
885fc8ac0a4dc7 Christian Brauner 2025-09-12   40  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   41  struct ns_tree uts_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   42  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   43  	.ns_list = LIST_HEAD_INIT(uts_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   44  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   45  	.type = CLONE_NEWUTS,
01da9c6ec4269b Christian Brauner 2025-10-29   46  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   47  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   48  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   49  struct ns_tree user_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   50  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   51  	.ns_list = LIST_HEAD_INIT(user_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   52  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   53  	.type = CLONE_NEWUSER,
01da9c6ec4269b Christian Brauner 2025-10-29   54  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   55  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   56  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   57  struct ns_tree ipc_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   58  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   59  	.ns_list = LIST_HEAD_INIT(ipc_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   60  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   61  	.type = CLONE_NEWIPC,
01da9c6ec4269b Christian Brauner 2025-10-29   62  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   63  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   64  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   65  struct ns_tree pid_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   66  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   67  	.ns_list = LIST_HEAD_INIT(pid_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   68  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   69  	.type = CLONE_NEWPID,
01da9c6ec4269b Christian Brauner 2025-10-29   70  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   71  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   72  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   73  struct ns_tree cgroup_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   74  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   75  	.ns_list = LIST_HEAD_INIT(cgroup_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   76  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   77  	.type = CLONE_NEWCGROUP,
01da9c6ec4269b Christian Brauner 2025-10-29   78  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   79  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   80  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   81  struct ns_tree time_ns_tree = {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   82  	.ns_tree = RB_ROOT,
885fc8ac0a4dc7 Christian Brauner 2025-09-12   83  	.ns_list = LIST_HEAD_INIT(time_ns_tree.ns_list),
01da9c6ec4269b Christian Brauner 2025-10-29   84  #ifdef CONFIG_DEBUG_VFS
885fc8ac0a4dc7 Christian Brauner 2025-09-12   85  	.type = CLONE_NEWTIME,
01da9c6ec4269b Christian Brauner 2025-10-29   86  #endif
885fc8ac0a4dc7 Christian Brauner 2025-09-12   87  };
885fc8ac0a4dc7 Christian Brauner 2025-09-12   88  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   89  DEFINE_COOKIE(namespace_cookie);
885fc8ac0a4dc7 Christian Brauner 2025-09-12   90  
885fc8ac0a4dc7 Christian Brauner 2025-09-12   91  static inline struct ns_common *node_to_ns(const struct rb_node *node)
885fc8ac0a4dc7 Christian Brauner 2025-09-12   92  {
885fc8ac0a4dc7 Christian Brauner 2025-09-12   93  	if (!node)
885fc8ac0a4dc7 Christian Brauner 2025-09-12   94  		return NULL;
885fc8ac0a4dc7 Christian Brauner 2025-09-12   95  	return rb_entry(node, struct ns_common, ns_tree_node);
885fc8ac0a4dc7 Christian Brauner 2025-09-12   96  }
885fc8ac0a4dc7 Christian Brauner 2025-09-12   97  
01da9c6ec4269b Christian Brauner 2025-10-29   98  static inline struct ns_common *node_to_ns_unified(const struct rb_node *node)
01da9c6ec4269b Christian Brauner 2025-10-29   99  {
01da9c6ec4269b Christian Brauner 2025-10-29  100  	if (!node)
01da9c6ec4269b Christian Brauner 2025-10-29  101  		return NULL;
01da9c6ec4269b Christian Brauner 2025-10-29  102  	return rb_entry(node, struct ns_common, ns_unified_tree_node);
01da9c6ec4269b Christian Brauner 2025-10-29  103  }
01da9c6ec4269b Christian Brauner 2025-10-29  104  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  105  static inline int ns_cmp(struct rb_node *a, const struct rb_node *b)
885fc8ac0a4dc7 Christian Brauner 2025-09-12  106  {
885fc8ac0a4dc7 Christian Brauner 2025-09-12  107  	struct ns_common *ns_a = node_to_ns(a);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  108  	struct ns_common *ns_b = node_to_ns(b);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  109  	u64 ns_id_a = ns_a->ns_id;
885fc8ac0a4dc7 Christian Brauner 2025-09-12  110  	u64 ns_id_b = ns_b->ns_id;
885fc8ac0a4dc7 Christian Brauner 2025-09-12  111  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  112  	if (ns_id_a < ns_id_b)
885fc8ac0a4dc7 Christian Brauner 2025-09-12  113  		return -1;
885fc8ac0a4dc7 Christian Brauner 2025-09-12  114  	if (ns_id_a > ns_id_b)
885fc8ac0a4dc7 Christian Brauner 2025-09-12  115  		return 1;
885fc8ac0a4dc7 Christian Brauner 2025-09-12  116  	return 0;
885fc8ac0a4dc7 Christian Brauner 2025-09-12  117  }
885fc8ac0a4dc7 Christian Brauner 2025-09-12  118  
01da9c6ec4269b Christian Brauner 2025-10-29  119  static inline int ns_cmp_unified(struct rb_node *a, const struct rb_node *b)
01da9c6ec4269b Christian Brauner 2025-10-29  120  {
01da9c6ec4269b Christian Brauner 2025-10-29  121  	struct ns_common *ns_a = node_to_ns_unified(a);
01da9c6ec4269b Christian Brauner 2025-10-29  122  	struct ns_common *ns_b = node_to_ns_unified(b);
01da9c6ec4269b Christian Brauner 2025-10-29  123  	u64 ns_id_a = ns_a->ns_id;
01da9c6ec4269b Christian Brauner 2025-10-29  124  	u64 ns_id_b = ns_b->ns_id;
01da9c6ec4269b Christian Brauner 2025-10-29  125  
01da9c6ec4269b Christian Brauner 2025-10-29  126  	if (ns_id_a < ns_id_b)
01da9c6ec4269b Christian Brauner 2025-10-29  127  		return -1;
01da9c6ec4269b Christian Brauner 2025-10-29  128  	if (ns_id_a > ns_id_b)
01da9c6ec4269b Christian Brauner 2025-10-29  129  		return 1;
01da9c6ec4269b Christian Brauner 2025-10-29  130  	return 0;
01da9c6ec4269b Christian Brauner 2025-10-29  131  }
01da9c6ec4269b Christian Brauner 2025-10-29  132  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  133  void __ns_tree_add_raw(struct ns_common *ns, struct ns_tree *ns_tree)
885fc8ac0a4dc7 Christian Brauner 2025-09-12  134  {
885fc8ac0a4dc7 Christian Brauner 2025-09-12  135  	struct rb_node *node, *prev;
885fc8ac0a4dc7 Christian Brauner 2025-09-12  136  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  137  	VFS_WARN_ON_ONCE(!ns->ns_id);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  138  
01da9c6ec4269b Christian Brauner 2025-10-29  139  	write_seqlock(&ns_tree_lock);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  140  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  141  	node = rb_find_add_rcu(&ns->ns_tree_node, &ns_tree->ns_tree, ns_cmp);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  142  	/*
885fc8ac0a4dc7 Christian Brauner 2025-09-12  143  	 * If there's no previous entry simply add it after the
885fc8ac0a4dc7 Christian Brauner 2025-09-12  144  	 * head and if there is add it after the previous entry.
885fc8ac0a4dc7 Christian Brauner 2025-09-12  145  	 */
885fc8ac0a4dc7 Christian Brauner 2025-09-12  146  	prev = rb_prev(&ns->ns_tree_node);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  147  	if (!prev)
885fc8ac0a4dc7 Christian Brauner 2025-09-12  148  		list_add_rcu(&ns->ns_list_node, &ns_tree->ns_list);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  149  	else
885fc8ac0a4dc7 Christian Brauner 2025-09-12  150  		list_add_rcu(&ns->ns_list_node, &node_to_ns(prev)->ns_list_node);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  151  
01da9c6ec4269b Christian Brauner 2025-10-29  152  	rb_find_add_rcu(&ns->ns_unified_tree_node, &ns_unified_tree, ns_cmp_unified);
01da9c6ec4269b Christian Brauner 2025-10-29  153  	write_sequnlock(&ns_tree_lock);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  154  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  155  	VFS_WARN_ON_ONCE(node);
cb9044bf715ece Christian Brauner 2025-10-29  156  
cb9044bf715ece Christian Brauner 2025-10-29  157  	/*
cb9044bf715ece Christian Brauner 2025-10-29  158  	 * Take an active reference on the owner namespace. This ensures
cb9044bf715ece Christian Brauner 2025-10-29  159  	 * that the owner remains visible while any of its child namespaces
cb9044bf715ece Christian Brauner 2025-10-29  160  	 * are active. For init namespaces this is a no-op as ns_owner()
cb9044bf715ece Christian Brauner 2025-10-29  161  	 * returns NULL for namespaces owned by init_user_ns.
cb9044bf715ece Christian Brauner 2025-10-29  162  	 */
cb9044bf715ece Christian Brauner 2025-10-29  163  	__ns_ref_active_get_owner(ns);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  164  }
885fc8ac0a4dc7 Christian Brauner 2025-09-12  165  
885fc8ac0a4dc7 Christian Brauner 2025-09-12  166  void __ns_tree_remove(struct ns_common *ns, struct ns_tree *ns_tree)
885fc8ac0a4dc7 Christian Brauner 2025-09-12  167  {
885fc8ac0a4dc7 Christian Brauner 2025-09-12  168  	VFS_WARN_ON_ONCE(RB_EMPTY_NODE(&ns->ns_tree_node));
885fc8ac0a4dc7 Christian Brauner 2025-09-12  169  	VFS_WARN_ON_ONCE(list_empty(&ns->ns_list_node));
4055526d35746c Christian Brauner 2025-09-24 @170  	VFS_WARN_ON_ONCE(ns->ns_type != ns_tree->type);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  171  
01da9c6ec4269b Christian Brauner 2025-10-29  172  	write_seqlock(&ns_tree_lock);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  173  	rb_erase(&ns->ns_tree_node, &ns_tree->ns_tree);
01da9c6ec4269b Christian Brauner 2025-10-29  174  	rb_erase(&ns->ns_unified_tree_node, &ns_unified_tree);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  175  	list_bidir_del_rcu(&ns->ns_list_node);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  176  	RB_CLEAR_NODE(&ns->ns_tree_node);
01da9c6ec4269b Christian Brauner 2025-10-29  177  	write_sequnlock(&ns_tree_lock);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  178  }
885fc8ac0a4dc7 Christian Brauner 2025-09-12  179  EXPORT_SYMBOL_GPL(__ns_tree_remove);
885fc8ac0a4dc7 Christian Brauner 2025-09-12  180  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

