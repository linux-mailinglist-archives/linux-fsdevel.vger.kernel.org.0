Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44B1153CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 02:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBFBkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 20:40:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:12848 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBFBkM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 20:40:12 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 17:40:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="gz'50?scan'50,208,50";a="432067642"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 05 Feb 2020 17:40:10 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izW9J-0000ZI-Tu; Thu, 06 Feb 2020 09:40:09 +0800
Date:   Thu, 6 Feb 2020 09:39:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     kbuild-all@lists.01.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-fsdevel@vger.kernel.org,
        ap420073@gmail.com
Subject: Re: [PATCH] debugfs: Check module state before warning in
 {full/open}_proxy_open()
Message-ID: <202002060953.7V3nl6kD%lkp@intel.com>
References: <20200205122724.1307-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3apeganmmvrbutxr"
Content-Disposition: inline
In-Reply-To: <20200205122724.1307-1-ap420073@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3apeganmmvrbutxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Taehee,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on v5.5 next-20200204]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Taehee-Yoo/debugfs-Check-module-state-before-warning-in-full-open-_proxy_open/20200206-045726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 6992ca0dd017ebaa2bf8e9dcc49f1c3b7033b082
config: arm-mps2_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/debugfs/file.c: In function 'open_proxy_open':
>> fs/debugfs/file.c:180:23: error: dereferencing pointer to incomplete type 'struct module'
          real_fops->owner->state == MODULE_STATE_GOING)
                          ^~
>> fs/debugfs/file.c:180:34: error: 'MODULE_STATE_GOING' undeclared (first use in this function); did you mean 'DL_STATE_NONE'?
          real_fops->owner->state == MODULE_STATE_GOING)
                                     ^~~~~~~~~~~~~~~~~~
                                     DL_STATE_NONE
   fs/debugfs/file.c:180:34: note: each undeclared identifier is reported only once for each function it appears in
   fs/debugfs/file.c: In function 'full_proxy_open':
   fs/debugfs/file.c:313:34: error: 'MODULE_STATE_GOING' undeclared (first use in this function); did you mean 'DL_STATE_NONE'?
          real_fops->owner->state == MODULE_STATE_GOING)
                                     ^~~~~~~~~~~~~~~~~~
                                     DL_STATE_NONE

vim +180 fs/debugfs/file.c

   161	
   162	static int open_proxy_open(struct inode *inode, struct file *filp)
   163	{
   164		struct dentry *dentry = F_DENTRY(filp);
   165		const struct file_operations *real_fops = NULL;
   166		int r;
   167	
   168		r = debugfs_file_get(dentry);
   169		if (r)
   170			return r == -EIO ? -ENOENT : r;
   171	
   172		real_fops = debugfs_real_fops(filp);
   173	
   174		r = debugfs_locked_down(inode, filp, real_fops);
   175		if (r)
   176			goto out;
   177	
   178		if (!fops_get(real_fops)) {
   179			if (real_fops->owner &&
 > 180			    real_fops->owner->state == MODULE_STATE_GOING)
   181				goto out;
   182	
   183			/* Huh? Module did not clean up after itself at exit? */
   184			WARN(1, "debugfs file owner did not clean up at exit: %pd",
   185				dentry);
   186			r = -ENXIO;
   187			goto out;
   188		}
   189		replace_fops(filp, real_fops);
   190	
   191		if (real_fops->open)
   192			r = real_fops->open(inode, filp);
   193	
   194	out:
   195		debugfs_file_put(dentry);
   196		return r;
   197	}
   198	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--3apeganmmvrbutxr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sFcmqv8B/WxQFceNAAA=

--3apeganmmvrbutxr--
