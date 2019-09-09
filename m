Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE83AD7C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbfIILQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 07:16:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:54373 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731115AbfIILQP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:16:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 04:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="gz'50?scan'50,208,50";a="208934464"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Sep 2019 04:16:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1i7HeS-000CZQ-KH; Mon, 09 Sep 2019 19:16:08 +0800
Date:   Mon, 9 Sep 2019 19:15:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/9] select: Extract common code into do_sys_ppoll()
Message-ID: <201909091925.qr6GtRNP%lkp@intel.com>
References: <20190909102340.8592-7-dima@arista.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eqtiy7mutpax2qy2"
Content-Disposition: inline
In-Reply-To: <20190909102340.8592-7-dima@arista.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eqtiy7mutpax2qy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dmitry,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[cannot apply to v5.3-rc8 next-20190904]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/restart_block-Prepare-the-ground-for-dumping-timeout/20190909-182945
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-11) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/select.c: In function 'do_sys_ppoll':
>> fs/select.c:1089:9: error: implicit declaration of function 'set_compat_user_sigmask'; did you mean 'set_user_sigmask'? [-Werror=implicit-function-declaration]
      ret = set_compat_user_sigmask(sigmask, sigsetsize);
            ^~~~~~~~~~~~~~~~~~~~~~~
            set_user_sigmask
   cc1: some warnings being treated as errors

vim +1089 fs/select.c

  1058	
  1059	static int do_sys_ppoll(struct pollfd __user *ufds, unsigned int nfds,
  1060				void __user *tsp, const void __user *sigmask,
  1061				size_t sigsetsize, enum poll_time_type pt_type)
  1062	{
  1063		struct timespec64 ts, end_time, *to = NULL;
  1064		int ret;
  1065	
  1066		if (tsp) {
  1067			switch (pt_type) {
  1068			case PT_TIMESPEC:
  1069				if (get_timespec64(&ts, tsp))
  1070					return -EFAULT;
  1071				break;
  1072			case PT_OLD_TIMESPEC:
  1073				if (get_old_timespec32(&ts, tsp))
  1074					return -EFAULT;
  1075				break;
  1076			default:
  1077				WARN_ON_ONCE(1);
  1078				return -ENOSYS;
  1079			}
  1080	
  1081			to = &end_time;
  1082			if (poll_select_set_timeout(to, ts.tv_sec, ts.tv_nsec))
  1083				return -EINVAL;
  1084		}
  1085	
  1086		if (!in_compat_syscall())
  1087			ret = set_user_sigmask(sigmask, sigsetsize);
  1088		else
> 1089			ret = set_compat_user_sigmask(sigmask, sigsetsize);
  1090	
  1091		if (ret)
  1092			return ret;
  1093	
  1094		ret = do_sys_poll(ufds, nfds, to);
  1095		return poll_select_finish(&end_time, tsp, pt_type, ret);
  1096	}
  1097	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--eqtiy7mutpax2qy2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AAA=

--eqtiy7mutpax2qy2--
