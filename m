Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D85151543
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 06:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBDFSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 00:18:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:34851 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgBDFSA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:18:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 21:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="gz'50?scan'50,208,50";a="224503039"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Feb 2020 21:17:58 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iyqaz-00047V-CL; Tue, 04 Feb 2020 13:17:57 +0800
Date:   Tue, 4 Feb 2020 13:17:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        hch@infradead.org, vgoyal@redhat.com, vishal.l.verma@intel.com,
        dm-devel@redhat.com
Subject: Re: [PATCH 5/5] dax,iomap: Add helper dax_iomap_zero() to zero a
 range
Message-ID: <202002041335.cKPlPSLq%lkp@intel.com>
References: <20200203200029.4592-6-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zbbktzy5yafptgl5"
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-6-vgoyal@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zbbktzy5yafptgl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vivek,

I love your patch! Yet something to improve:

[auto build test ERROR on dm/for-next]
[also build test ERROR on s390/features xfs-linux/for-next linus/master linux-nvdimm/libnvdimm-for-next v5.5 next-20200203]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Vivek-Goyal/dax-pmem-Provide-a-dax-operation-to-zero-range-of-memory/20200204-082750
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
config: s390-alldefconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/s390/block/dcssblk.c:65:21: error: 'dcssblk_dax_zero_page_range' undeclared here (not in a function); did you mean 'generic_dax_zero_page_range'?
     .zero_page_range = dcssblk_dax_zero_page_range,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
                        generic_dax_zero_page_range
   drivers/s390/block/dcssblk.c:945:12: warning: 'dcssblk_dax_zero_page_range' defined but not used [-Wunused-function]
    static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +65 drivers/s390/block/dcssblk.c

b3a9a0c36e1f7b Dan Williams   2018-05-02  59  
7a2765f6e82063 Dan Williams   2017-01-26  60  static const struct dax_operations dcssblk_dax_ops = {
7a2765f6e82063 Dan Williams   2017-01-26  61  	.direct_access = dcssblk_dax_direct_access,
7bf7eac8d64805 Dan Williams   2019-05-16  62  	.dax_supported = generic_fsdax_supported,
5d61e43b3975c0 Dan Williams   2017-06-27  63  	.copy_from_iter = dcssblk_dax_copy_from_iter,
b3a9a0c36e1f7b Dan Williams   2018-05-02  64  	.copy_to_iter = dcssblk_dax_copy_to_iter,
c5cb636194a0d8 Vivek Goyal    2020-02-03 @65  	.zero_page_range = dcssblk_dax_zero_page_range,
^1da177e4c3f41 Linus Torvalds 2005-04-16  66  };
^1da177e4c3f41 Linus Torvalds 2005-04-16  67  

:::::: The code at line 65 was first introduced by commit
:::::: c5cb636194a0d8d33d549903c92189385db48406 s390,dax: Add dax zero_page_range operation to dcssblk driver

:::::: TO: Vivek Goyal <vgoyal@redhat.com>
:::::: CC: 0day robot <lkp@intel.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--zbbktzy5yafptgl5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
dAAA

--zbbktzy5yafptgl5--
