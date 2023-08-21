Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC7783675
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjHUXoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 19:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjHUXoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:44:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534A13E;
        Mon, 21 Aug 2023 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692661456; x=1724197456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=STFTRhm3lru3nDEhHPEOCOUbJYOYoNTJoOH2Kvs0Kok=;
  b=YJVjG5Tf7oQc43ot25lEhxDzZry7ZdLSHsBcilLZr4vorl3B0CGGHiKM
   DnRvm1o3NSavlyf/z0sverVyOxZP8wki0VW5VgIY3cuCDCXsXfbdwTn7u
   gECe/xcd2q0n29s4sF0fh9AoNw0fhxI+dK3J2utbc2cjWd+1nLelKHXaL
   KSQ3fObTA2YOmWU4OuWdTSwQWLz8lR5go1jwtPj3APuUxIeTAb4qT+6Gf
   ElxPDaHzQcdkoFobDMgYvLv6jYMg21whLjn23KQ4ARyZSZfbvTYQVo1yG
   kMQxyZwwve4e7fZ3I/Fgfc/vfR+oK8u9NIrOBzxQpHsdKAkqT0sJfatHA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437651983"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="437651983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859673727"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="859673727"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2023 16:44:11 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYEZ8-00014S-2K;
        Mon, 21 Aug 2023 23:44:10 +0000
Date:   Tue, 22 Aug 2023 07:43:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] procfs: Fix /proc/self/maps output for 32-bit kernel and
 compat tasks
Message-ID: <202308220747.XMKc32Kz-lkp@intel.com>
References: <ZOCJltW/eufPUc+T@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOCJltW/eufPUc+T@p100>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Helge,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc7 next-20230821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Helge-Deller/procfs-Fix-proc-self-maps-output-for-32-bit-kernel-and-compat-tasks/20230821-100823
base:   linus/master
patch link:    https://lore.kernel.org/r/ZOCJltW%2FeufPUc%2BT%40p100
patch subject: [PATCH] procfs: Fix /proc/self/maps output for 32-bit kernel and compat tasks
config: x86_64-buildonly-randconfig-006-20230822 (https://download.01.org/0day-ci/archive/20230822/202308220747.XMKc32Kz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220747.XMKc32Kz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220747.XMKc32Kz-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/seq_file.c: In function 'seq_put_hex_ll':
>> fs/seq_file.c:765:23: error: implicit declaration of function 'is_compat_task' [-Werror=implicit-function-declaration]
     765 |         if (v == 0 || is_compat_task())
         |                       ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/is_compat_task +765 fs/seq_file.c

   737	
   738	/**
   739	 * seq_put_hex_ll - put a number in hexadecimal notation
   740	 * @m: seq_file identifying the buffer to which data should be written
   741	 * @delimiter: a string which is printed before the number
   742	 * @v: the number
   743	 * @width: a minimum field width
   744	 *
   745	 * seq_put_hex_ll(m, "", v, 8) is equal to seq_printf(m, "%08llx", v)
   746	 *
   747	 * This routine is very quick when you show lots of numbers.
   748	 * In usual cases, it will be better to use seq_printf(). It's easier to read.
   749	 */
   750	void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
   751					unsigned long long v, unsigned int width)
   752	{
   753		unsigned int len;
   754		int i;
   755	
   756		if (delimiter && delimiter[0]) {
   757			if (delimiter[1] == 0)
   758				seq_putc(m, delimiter[0]);
   759			else
   760				seq_puts(m, delimiter);
   761		}
   762	
   763	#ifdef CONFIG_64BIT
   764		/* If x is 0, the result of __builtin_clzll is undefined */
 > 765		if (v == 0 || is_compat_task())
   766			len = 1;
   767		else
   768			len = (sizeof(v) * 8 - __builtin_clzll(v) + 3) / 4;
   769	#else
   770		/* On 32-bit kernel always use provided width */
   771		len = 1;
   772	#endif
   773	
   774		if (len < width)
   775			len = width;
   776	
   777		if (m->count + len > m->size) {
   778			seq_set_overflow(m);
   779			return;
   780		}
   781	
   782		for (i = len - 1; i >= 0; i--) {
   783			m->buf[m->count + i] = hex_asc[0xf & v];
   784			v = v >> 4;
   785		}
   786		m->count += len;
   787	}
   788	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
