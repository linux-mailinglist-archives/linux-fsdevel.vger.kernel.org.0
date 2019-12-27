Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AEC12BB2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 22:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfL0VRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 16:17:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:57668 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfL0VRm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 16:17:42 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Dec 2019 13:17:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,364,1571727600"; 
   d="gz'50?scan'50,208,50";a="212740555"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Dec 2019 13:17:39 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ikwzL-000D0W-6M; Sat, 28 Dec 2019 05:17:39 +0800
Date:   Sat, 28 Dec 2019 05:16:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     kbuild-all@lists.01.org,
        Linux Filesystem Development List 
        <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] memcg: fix a crash in wb_workfn when a device disappears
Message-ID: <201912280556.y1lprcKe%lkp@intel.com>
References: <20191227194829.150110-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="twifquq4hvw62oip"
Content-Disposition: inline
In-Reply-To: <20191227194829.150110-1-tytso@mit.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--twifquq4hvw62oip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Theodore,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on linus/master v5.5-rc3 next-20191220]
[cannot apply to tytso-fscrypt/master]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Theodore-Ts-o/memcg-fix-a-crash-in-wb_workfn-when-a-device-disappears/20191228-035221
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 1f676247f36a4bdea134de5e8bc5041db9678c4e
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from mm/fadvise.c:16:0:
   include/linux/backing-dev.h: In function 'bdi_dev_name':
>> include/linux/backing-dev.h:513:9: error: implicit declaration of function 'dev_name'; did you mean 'getname'? [-Werror=implicit-function-declaration]
     return dev_name(bdi->dev);
            ^~~~~~~~
            getname
>> include/linux/backing-dev.h:513:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
     return dev_name(bdi->dev);
            ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/node.h:18:0,
                    from include/linux/cpu.h:17,
                    from include/linux/perf_event.h:50,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:85,
                    from mm/fadvise.c:20:
   include/linux/device.h: At top level:
>> include/linux/device.h:1370:27: error: conflicting types for 'dev_name'
    static inline const char *dev_name(const struct device *dev)
                              ^~~~~~~~
   In file included from mm/fadvise.c:16:0:
   include/linux/backing-dev.h:513:9: note: previous implicit declaration of 'dev_name' was here
     return dev_name(bdi->dev);
            ^~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from fs/super.c:32:0:
   include/linux/backing-dev.h: In function 'bdi_dev_name':
>> include/linux/backing-dev.h:513:9: error: implicit declaration of function 'dev_name'; did you mean 'getname'? [-Werror=implicit-function-declaration]
     return dev_name(bdi->dev);
            ^~~~~~~~
            getname
>> include/linux/backing-dev.h:513:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
     return dev_name(bdi->dev);
            ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +513 include/linux/backing-dev.h

   508	
   509	static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
   510	{
   511		if (!bdi || !bdi->dev)
   512			return bdi_unknown_name;
 > 513		return dev_name(bdi->dev);
   514	}
   515	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--twifquq4hvw62oip
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--twifquq4hvw62oip--
