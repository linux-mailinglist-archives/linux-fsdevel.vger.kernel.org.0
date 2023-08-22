Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B97078391B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 07:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjHVFME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 01:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHVFMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:12:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70747DB;
        Mon, 21 Aug 2023 22:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692681121; x=1724217121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aXAGANQWUdOju3qwQ0k64Gy9Mkc9JcoibWROSruwz9Q=;
  b=T0WDv4zx91NVG/hOPRm6gWsSCCkvqXnndgsAjGxsAWWvBiVQgnvzyCSe
   knVsbkez81URiwlGby2kHkxjMWjMUEWY++cGVDhwycUE1HtLCiauaeUBV
   E06c3NLQ7xzr2XFBD1RG+WqxpzJbOjn4fYZRWgMRfFlf/T9B74iiLF31q
   L30g4WO+d8IVl5fB+MwRsaMd1tL2aFu7NQAOaq93+YpEi6OFYZGeUJQwe
   soZJ7kIzc2gf2ZIM0f8jtFC5o1kOHgGW9oQkRc8XT7oE5wU+0cM8ylucp
   sUyxBbHYlZHK/+Y1XYJxcUuBweAPAXOuPj3MWH4RiJOrrz+EXfnH//9Te
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="460147096"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="460147096"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 22:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="685912356"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="685912356"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2023 22:11:57 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYJgK-0001OM-1s;
        Tue, 22 Aug 2023 05:11:56 +0000
Date:   Tue, 22 Aug 2023 13:11:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] procfs: Fix /proc/self/maps output for 32-bit kernel and
 compat tasks
Message-ID: <202308221231.B7yBmSQV-lkp@intel.com>
References: <ZOCJltW/eufPUc+T@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOCJltW/eufPUc+T@p100>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
config: x86_64-randconfig-013-20230821 (https://download.01.org/0day-ci/archive/20230822/202308221231.B7yBmSQV-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221231.B7yBmSQV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221231.B7yBmSQV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/seq_file.c:765:16: error: call to undeclared function 'is_compat_task'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (v == 0 || is_compat_task())
                         ^
   1 error generated.


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
