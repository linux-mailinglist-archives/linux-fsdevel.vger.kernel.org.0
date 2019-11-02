Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C9ECE29
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2019 11:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfKBK4W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Nov 2019 06:56:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:30296 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfKBK4W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:56:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2019 03:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="gz'50?scan'50,208,50";a="194945749"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Nov 2019 03:56:18 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iQr4r-000Dlx-UW; Sat, 02 Nov 2019 18:56:17 +0800
Date:   Sat, 2 Nov 2019 18:55:38 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     kbuild-all@lists.01.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/28] mm: factor shrinker work calculations
Message-ID: <201911021802.sUaVwfzZ%lkp@intel.com>
References: <20191031234618.15403-12-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mr6w245ucx5z7zfn"
Content-Disposition: inline
In-Reply-To: <20191031234618.15403-12-david@fromorbit.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mr6w245ucx5z7zfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on xfs-linux/for-next]
[also build test WARNING on v5.4-rc5 next-20191031]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Dave-Chinner/xfs-Lower-CIL-flush-limit-for-large-logs/20191102-153137
base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from ./arch/parisc/include/generated/asm/div64.h:1:0,
                    from include/linux/kernel.h:18,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from mm/vmscan.c:17:
   mm/vmscan.c: In function 'shrink_scan_count':
   include/asm-generic/div64.h:226:28: warning: comparison of distinct pointer types lacks a cast
     (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                               ^
>> mm/vmscan.c:502:3: note: in expansion of macro 'do_div'
      do_div(delta, shrinker->seeks);
      ^~~~~~

vim +/do_div +502 mm/vmscan.c

   460	
   461	/*
   462	 * Calculate the number of new objects to scan this time around. Return
   463	 * the work to be done. If there are freeable objects, return that number in
   464	 * @freeable_objects.
   465	 */
   466	static int64_t shrink_scan_count(struct shrink_control *shrinkctl,
   467				    struct shrinker *shrinker, int priority,
   468				    int64_t *freeable_objects)
   469	{
   470		int64_t delta;
   471		int64_t freeable;
   472	
   473		freeable = shrinker->count_objects(shrinker, shrinkctl);
   474		if (freeable == 0 || freeable == SHRINK_EMPTY)
   475			return freeable;
   476	
   477		if (shrinker->seeks) {
   478			/*
   479			 * shrinker->seeks is a measure of how much IO is required to
   480			 * reinstantiate the object in memory. The default value is 2
   481			 * which is typical for a cold inode requiring a directory read
   482			 * and an inode read to re-instantiate.
   483			 *
   484			 * The scan batch size is defined by the shrinker priority, but
   485			 * to be able to bias the reclaim we increase the default batch
   486			 * size by 4. Hence we end up with a scan batch multipler that
   487			 * scales like so:
   488			 *
   489			 * ->seeks	scan batch multiplier
   490			 *    1		      4.00x
   491			 *    2               2.00x
   492			 *    3               1.33x
   493			 *    4               1.00x
   494			 *    8               0.50x
   495			 *
   496			 * IOWs, the more seeks it takes to pull the item into cache,
   497			 * the smaller the reclaim scan batch. Hence we put more reclaim
   498			 * pressure on caches that are fast to repopulate and to keep a
   499			 * rough balance between caches that have different costs.
   500			 */
   501			delta = freeable >> (priority - 2);
 > 502			do_div(delta, shrinker->seeks);
   503		} else {
   504			/*
   505			 * These objects don't require any IO to create. Trim them
   506			 * aggressively under memory pressure to keep them from causing
   507			 * refetches in the IO caches.
   508			 */
   509			delta = freeable / 2;
   510		}
   511	
   512		*freeable_objects = freeable;
   513		return delta > 0 ? delta : 0;
   514	}
   515	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--mr6w245ucx5z7zfn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
N8DpR4k3Lg0TsO0wKa2p/wObCAihkfwAAA==

--mr6w245ucx5z7zfn--
