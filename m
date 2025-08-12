Return-Path: <linux-fsdevel+bounces-57452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F511B21BCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 05:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A149B4609F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D85A2DC337;
	Tue, 12 Aug 2025 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMeq6zRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38511DF27F;
	Tue, 12 Aug 2025 03:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970485; cv=none; b=c+suPs1velOy6JT1KhPraljT3m1oNvgty5xpYD3854U3PQG67oS1LaT4IY5/EjyM6CZZsL/hmh2gB4tYbaDZR/uYEH9KtvQ06yJx7JMimY3Z30iNl8w84+UGnLARGyrL5OSoWuIqVj7juO+gPwcZDcl4uQ2NegkS+K0OJnjFES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970485; c=relaxed/simple;
	bh=ll3cdP8d//vor5VuPJwHFE7JYGIjaL7Gs2uj46+wuYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfSA3iFRHALtVPsMLx07YlWyY9WMQvJBHF/U5CXv+H+0yDycaA1xi7zYhgUve49LY/3RdHZJGIV16yeciusBWHXSY3j/YrRmopE7BLUQj8ZjbWUx0kN6G1aqEBVyflD5Kw8lBcc/SYJHlE3BlI52fwgMa6dtGJjyI+IKBZGw1es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMeq6zRp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754970484; x=1786506484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ll3cdP8d//vor5VuPJwHFE7JYGIjaL7Gs2uj46+wuYE=;
  b=ZMeq6zRp/lSTblTSdCzL01f0mzZ9jvq+ongMoPB7jIiCB0Ergvm1+4cm
   0/PLmnqr0MrRILoIlEKVYlzyEYN+1U7YbmgBfGNLSSTAEOhaAq1r+mfIK
   PxAHw4sdMnPXtpJHSouQqJCAJzXLsDy9aHWi4wkGoafMNnmwfHRfqgPsm
   nHvjd+01G2IEh16dOuEZSusi5wBKF5VqN7KibUq+9YoGNhHkt9gLgvPX4
   JcE+rQS2lZU2cU35Qql5dAsOTuGSRiXqbhchZPXhW4CjCeYwEfNfQfAvr
   tc4gmp6+zHtqPYRTjVaVTXlfzSl5Lppd13sDt7GHVwGPKJ0rSKNwf7zgR
   A==;
X-CSE-ConnectionGUID: 6RmkGcaBTeGPbPrTY3SyUQ==
X-CSE-MsgGUID: +nInCpVSTRiokzY5ws740g==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="79805659"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="79805659"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 20:48:03 -0700
X-CSE-ConnectionGUID: rBXqWIpGTrGEXfd288J8uw==
X-CSE-MsgGUID: h6B2w0GfRnCeW4xa5h7SyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="196928492"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 11 Aug 2025 20:47:56 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ulfzN-0006Oa-0z;
	Tue, 12 Aug 2025 03:47:53 +0000
Date: Tue, 12 Aug 2025 11:47:52 +0800
From: kernel test robot <lkp@intel.com>
To: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, bhupesh@igalia.com,
	kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	oliver.sang@intel.com, lkp@intel.com, laoar.shao@gmail.com,
	pmladek@suse.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de
Subject: Re: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with
 'strscpy_pad()'
Message-ID: <202508121145.d07aFegg-lkp@intel.com>
References: <20250811064609.918593-4-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811064609.918593-4-bhupesh@igalia.com>

Hi Bhupesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250808]
[cannot apply to trace/for-next tip/sched/core brauner-vfs/vfs.all linus/master v6.17-rc1 v6.16 v6.16-rc7 v6.17-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhupesh/exec-Remove-obsolete-comments/20250811-144920
base:   next-20250808
patch link:    https://lore.kernel.org/r/20250811064609.918593-4-bhupesh%40igalia.com
patch subject: [PATCH v7 3/4] treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
config: arc-randconfig-002-20250812 (https://download.01.org/0day-ci/archive/20250812/202508121145.d07aFegg-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250812/202508121145.d07aFegg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508121145.d07aFegg-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from net/netfilter/nf_tables_api.c:8:
   net/netfilter/nf_tables_api.c: In function 'nf_tables_fill_gen_info':
>> include/linux/string.h:116:50: warning: passing argument 3 of 'nla_put_string' makes pointer from integer without a cast [-Wint-conversion]
     116 | #define sized_strscpy_pad(dest, src, count)     ({                      \
         |                                                 ~^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  ssize_t {aka int}
     117 |         char *__dst = (dest);                                           \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     118 |         const char *__src = (src);                                      \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     119 |         const size_t __count = (count);                                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     120 |         ssize_t __wrote;                                                \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     121 |                                                                         \
         |                                                                         ~
     122 |         __wrote = sized_strscpy(__dst, __src, __count);                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     123 |         if (__wrote >= 0 && __wrote < __count)                          \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     124 |                 memset(__dst + __wrote + 1, 0, __count - __wrote - 1);  \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     125 |         __wrote;                                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     126 | })
         | ~~                                                
   include/linux/compiler.h:57:52: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   net/netfilter/nf_tables_api.c:9659:9: note: in expansion of macro 'if'
    9659 |         if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
         |         ^~
   include/linux/string.h:86:9: note: in expansion of macro 'sized_strscpy_pad'
      86 |         sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +        \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy_pad0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:149:9: note: in expansion of macro 'CONCATENATE'
     149 |         CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |         ^~~~~~~~~~~
   net/netfilter/nf_tables_api.c:9661:53: note: in expansion of macro 'strscpy_pad'
    9661 |             nla_put_string(skb, NFTA_GEN_PROC_NAME, strscpy_pad(buf, current->comm)))
         |                                                     ^~~~~~~~~~~
   In file included from include/linux/netfilter/nfnetlink.h:7,
                    from net/netfilter/nf_tables_api.c:17:
   include/net/netlink.h:1655:46: note: expected 'const char *' but argument is of type 'ssize_t' {aka 'int'}
    1655 |                                  const char *str)
         |                                  ~~~~~~~~~~~~^~~
>> include/linux/string.h:116:50: warning: passing argument 3 of 'nla_put_string' makes pointer from integer without a cast [-Wint-conversion]
     116 | #define sized_strscpy_pad(dest, src, count)     ({                      \
         |                                                 ~^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  ssize_t {aka int}
     117 |         char *__dst = (dest);                                           \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     118 |         const char *__src = (src);                                      \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     119 |         const size_t __count = (count);                                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     120 |         ssize_t __wrote;                                                \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     121 |                                                                         \
         |                                                                         ~
     122 |         __wrote = sized_strscpy(__dst, __src, __count);                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     123 |         if (__wrote >= 0 && __wrote < __count)                          \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     124 |                 memset(__dst + __wrote + 1, 0, __count - __wrote - 1);  \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     125 |         __wrote;                                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     126 | })
         | ~~                                                
   include/linux/compiler.h:57:61: note: in definition of macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   net/netfilter/nf_tables_api.c:9659:9: note: in expansion of macro 'if'
    9659 |         if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
         |         ^~
   include/linux/string.h:86:9: note: in expansion of macro 'sized_strscpy_pad'
      86 |         sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +        \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy_pad0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:149:9: note: in expansion of macro 'CONCATENATE'
     149 |         CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |         ^~~~~~~~~~~
   net/netfilter/nf_tables_api.c:9661:53: note: in expansion of macro 'strscpy_pad'
    9661 |             nla_put_string(skb, NFTA_GEN_PROC_NAME, strscpy_pad(buf, current->comm)))
         |                                                     ^~~~~~~~~~~
   include/net/netlink.h:1655:46: note: expected 'const char *' but argument is of type 'ssize_t' {aka 'int'}
    1655 |                                  const char *str)
         |                                  ~~~~~~~~~~~~^~~
>> include/linux/string.h:116:50: warning: passing argument 3 of 'nla_put_string' makes pointer from integer without a cast [-Wint-conversion]
     116 | #define sized_strscpy_pad(dest, src, count)     ({                      \
         |                                                 ~^~~~~~~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  ssize_t {aka int}
     117 |         char *__dst = (dest);                                           \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     118 |         const char *__src = (src);                                      \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     119 |         const size_t __count = (count);                                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     120 |         ssize_t __wrote;                                                \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     121 |                                                                         \
         |                                                                         ~
     122 |         __wrote = sized_strscpy(__dst, __src, __count);                 \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     123 |         if (__wrote >= 0 && __wrote < __count)                          \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     124 |                 memset(__dst + __wrote + 1, 0, __count - __wrote - 1);  \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     125 |         __wrote;                                                        \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     126 | })
         | ~~                                                
   include/linux/compiler.h:68:10: note: in definition of macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   include/linux/compiler.h:55:28: note: in expansion of macro '__trace_if_var'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ^~~~~~~~~~~~~~
   net/netfilter/nf_tables_api.c:9659:9: note: in expansion of macro 'if'
    9659 |         if (nla_put_be32(skb, NFTA_GEN_ID, htonl(nft_net->base_seq)) ||
         |         ^~
   include/linux/string.h:86:9: note: in expansion of macro 'sized_strscpy_pad'
      86 |         sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +        \
         |         ^~~~~~~~~~~~~~~~~
   include/linux/args.h:25:24: note: in expansion of macro '__strscpy_pad0'
      25 | #define __CONCAT(a, b) a ## b
         |                        ^
   include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
      26 | #define CONCATENATE(a, b) __CONCAT(a, b)
         |                           ^~~~~~~~
   include/linux/string.h:149:9: note: in expansion of macro 'CONCATENATE'
     149 |         CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
         |         ^~~~~~~~~~~
   net/netfilter/nf_tables_api.c:9661:53: note: in expansion of macro 'strscpy_pad'
    9661 |             nla_put_string(skb, NFTA_GEN_PROC_NAME, strscpy_pad(buf, current->comm)))
         |                                                     ^~~~~~~~~~~
   include/net/netlink.h:1655:46: note: expected 'const char *' but argument is of type 'ssize_t' {aka 'int'}
    1655 |                                  const char *str)
         |                                  ~~~~~~~~~~~~^~~


vim +/nla_put_string +116 include/linux/string.h

e6584c3964f2ff Kees Cook        2023-09-20   74  
e6584c3964f2ff Kees Cook        2023-09-20   75  /*
e6584c3964f2ff Kees Cook        2023-09-20   76   * The 2 argument style can only be used when dst is an array with a
e6584c3964f2ff Kees Cook        2023-09-20   77   * known size.
e6584c3964f2ff Kees Cook        2023-09-20   78   */
e6584c3964f2ff Kees Cook        2023-09-20   79  #define __strscpy0(dst, src, ...)	\
559048d156ff33 Kees Cook        2024-08-05   80  	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) +	\
559048d156ff33 Kees Cook        2024-08-05   81  				__must_be_cstr(dst) + __must_be_cstr(src))
559048d156ff33 Kees Cook        2024-08-05   82  #define __strscpy1(dst, src, size)	\
559048d156ff33 Kees Cook        2024-08-05   83  	sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
e6584c3964f2ff Kees Cook        2023-09-20   84  
8366d124ec937c Kees Cook        2024-02-02   85  #define __strscpy_pad0(dst, src, ...)	\
559048d156ff33 Kees Cook        2024-08-05   86  	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst) +	\
559048d156ff33 Kees Cook        2024-08-05   87  				    __must_be_cstr(dst) + __must_be_cstr(src))
559048d156ff33 Kees Cook        2024-08-05   88  #define __strscpy_pad1(dst, src, size)	\
559048d156ff33 Kees Cook        2024-08-05   89  	sized_strscpy_pad(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
458a3bf82df4fe Tobin C. Harding 2019-04-05   90  
e6584c3964f2ff Kees Cook        2023-09-20   91  /**
e6584c3964f2ff Kees Cook        2023-09-20   92   * strscpy - Copy a C-string into a sized buffer
e6584c3964f2ff Kees Cook        2023-09-20   93   * @dst: Where to copy the string to
e6584c3964f2ff Kees Cook        2023-09-20   94   * @src: Where to copy the string from
e6584c3964f2ff Kees Cook        2023-09-20   95   * @...: Size of destination buffer (optional)
e6584c3964f2ff Kees Cook        2023-09-20   96   *
e6584c3964f2ff Kees Cook        2023-09-20   97   * Copy the source string @src, or as much of it as fits, into the
e6584c3964f2ff Kees Cook        2023-09-20   98   * destination @dst buffer. The behavior is undefined if the string
e6584c3964f2ff Kees Cook        2023-09-20   99   * buffers overlap. The destination @dst buffer is always NUL terminated,
e6584c3964f2ff Kees Cook        2023-09-20  100   * unless it's zero-sized.
e6584c3964f2ff Kees Cook        2023-09-20  101   *
e6584c3964f2ff Kees Cook        2023-09-20  102   * The size argument @... is only required when @dst is not an array, or
e6584c3964f2ff Kees Cook        2023-09-20  103   * when the copy needs to be smaller than sizeof(@dst).
e6584c3964f2ff Kees Cook        2023-09-20  104   *
e6584c3964f2ff Kees Cook        2023-09-20  105   * Preferred to strncpy() since it always returns a valid string, and
e6584c3964f2ff Kees Cook        2023-09-20  106   * doesn't unnecessarily force the tail of the destination buffer to be
e6584c3964f2ff Kees Cook        2023-09-20  107   * zero padded. If padding is desired please use strscpy_pad().
e6584c3964f2ff Kees Cook        2023-09-20  108   *
e6584c3964f2ff Kees Cook        2023-09-20  109   * Returns the number of characters copied in @dst (not including the
e6584c3964f2ff Kees Cook        2023-09-20  110   * trailing %NUL) or -E2BIG if @size is 0 or the copy from @src was
e6584c3964f2ff Kees Cook        2023-09-20  111   * truncated.
e6584c3964f2ff Kees Cook        2023-09-20  112   */
e6584c3964f2ff Kees Cook        2023-09-20  113  #define strscpy(dst, src, ...)	\
e6584c3964f2ff Kees Cook        2023-09-20  114  	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
458a3bf82df4fe Tobin C. Harding 2019-04-05  115  
8366d124ec937c Kees Cook        2024-02-02 @116  #define sized_strscpy_pad(dest, src, count)	({			\
8366d124ec937c Kees Cook        2024-02-02  117  	char *__dst = (dest);						\
8366d124ec937c Kees Cook        2024-02-02  118  	const char *__src = (src);					\
8366d124ec937c Kees Cook        2024-02-02  119  	const size_t __count = (count);					\
8366d124ec937c Kees Cook        2024-02-02  120  	ssize_t __wrote;						\
8366d124ec937c Kees Cook        2024-02-02  121  									\
8366d124ec937c Kees Cook        2024-02-02  122  	__wrote = sized_strscpy(__dst, __src, __count);			\
8366d124ec937c Kees Cook        2024-02-02  123  	if (__wrote >= 0 && __wrote < __count)				\
8366d124ec937c Kees Cook        2024-02-02  124  		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
8366d124ec937c Kees Cook        2024-02-02  125  	__wrote;							\
8366d124ec937c Kees Cook        2024-02-02  126  })
8366d124ec937c Kees Cook        2024-02-02  127  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

