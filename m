Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9548386BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 22:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfHHUj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 16:39:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:64801 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfHHUj2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:39:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 13:39:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="gz'50?scan'50,208,50";a="374980731"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2019 13:39:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hvpC0-0000Yg-UB; Fri, 09 Aug 2019 04:39:24 +0800
Date:   Fri, 9 Aug 2019 04:38:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     kbuild-all@01.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <201908090430.yoyXYjeY%lkp@intel.com>
References: <20190808082744.31405-5-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v2tdnh53b23d664i"
Content-Disposition: inline
In-Reply-To: <20190808082744.31405-5-cmaiolino@redhat.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--v2tdnh53b23d664i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Carlos,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc3 next-20190808]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Carlos-Maiolino/New-fiemap-infrastructure-and-bmap-removal/20190808-221354
config: sh-allnoconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=sh 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/ioctl.c: In function 'ioctl_fibmap':
>> fs/ioctl.c:68:10: error: implicit declaration of function 'bmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]
     error = bmap(inode, &block);
             ^~~~
             kmap
   cc1: some warnings being treated as errors

vim +68 fs/ioctl.c

    53	
    54	static int ioctl_fibmap(struct file *filp, int __user *p)
    55	{
    56		struct inode *inode = file_inode(filp);
    57		int error, ur_block;
    58		sector_t block;
    59	
    60		if (!capable(CAP_SYS_RAWIO))
    61			return -EPERM;
    62	
    63		error = get_user(ur_block, p);
    64		if (error)
    65			return error;
    66	
    67		block = ur_block;
  > 68		error = bmap(inode, &block);
    69	
    70		if (error)
    71			ur_block = 0;
    72		else
    73			ur_block = block;
    74	
    75		error = put_user(ur_block, p);
    76	
    77		return error;
    78	}
    79	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--v2tdnh53b23d664i
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
cQVDBFQAAA==

--v2tdnh53b23d664i--
