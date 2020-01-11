Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B12913835E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2020 20:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbgAKT7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jan 2020 14:59:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:20426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730985AbgAKT7C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jan 2020 14:59:02 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2020 11:59:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,422,1571727600"; 
   d="scan'208";a="396756654"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 11 Jan 2020 11:59:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iqMuR-0009Sd-Gp; Sun, 12 Jan 2020 03:58:59 +0800
Date:   Sun, 12 Jan 2020 03:58:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 4/6] fs: implement fsconfig via configfd
Message-ID: <202001120308.0Y6AXzgU%lkp@intel.com>
References: <20200104201432.27320-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-5-James.Bottomley@HansenPartnership.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on s390/features]
[also build test WARNING on linus/master v5.5-rc5]
[cannot apply to arm64/for-next/core tip/x86/asm arm/for-next ia64/next m68k/for-next hp-parisc/for-next powerpc/next sparc-next/master next-20200110]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/James-Bottomley/introduce-configfd-as-generalisation-of-fsconfig/20200105-080415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-129-g341daf20-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> fs/fsopen.c:116:31: sparse: sparse: incorrect type in argument 1 (different address spaces)
>> fs/fsopen.c:116:31: sparse:    expected char const *
>> fs/fsopen.c:116:31: sparse:    got char const [noderef] <asn:1> *path

vim +116 fs/fsopen.c

    78	
    79	/*
    80	 * Pick a superblock into a context for reconfiguration.
    81	 */
    82	SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags)
    83	{
    84		struct path *target;
    85		unsigned int lookup_flags;
    86		int ret;
    87		int fd;
    88		struct configfd_param cp;
    89		struct open_flags of;
    90		struct filename *name;
    91		struct file *file;
    92	
    93		if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
    94			return -EPERM;
    95	
    96		if ((flags & ~(FSPICK_CLOEXEC |
    97			       FSPICK_SYMLINK_NOFOLLOW |
    98			       FSPICK_NO_AUTOMOUNT |
    99			       FSPICK_EMPTY_PATH)) != 0)
   100			return -EINVAL;
   101	
   102		lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
   103		if (flags & FSPICK_SYMLINK_NOFOLLOW)
   104			lookup_flags &= ~LOOKUP_FOLLOW;
   105		if (flags & FSPICK_NO_AUTOMOUNT)
   106			lookup_flags &= ~LOOKUP_AUTOMOUNT;
   107		if (flags & FSPICK_EMPTY_PATH)
   108			lookup_flags |= LOOKUP_EMPTY;
   109	
   110		of.lookup_flags = lookup_flags;
   111		of.intent = LOOKUP_OPEN;
   112		of.acc_mode = 0;
   113		of.mode = 0;
   114		of.open_flag = O_PATH;
   115	
 > 116		name = getname_kernel(path);
   117		if (IS_ERR(name))
   118			return PTR_ERR(name);
   119	
   120		file = do_filp_open(dfd, name, &of);
   121		putname(name);
   122		if (IS_ERR(file))
   123			return PTR_ERR(file);
   124	
   125		target = &file->f_path;
   126		ret = -EINVAL;
   127		if (target->mnt->mnt_root != target->dentry)
   128			goto err_file;
   129	
   130		ret = fd = kern_configfd_open("mount",
   131					      flags & FSPICK_CLOEXEC ? O_CLOEXEC : 0,
   132					      CONFIGFD_CMD_RECONFIGURE);
   133		if (ret < 0)
   134			goto err_file;
   135		cp = (struct configfd_param) {
   136			.key = "pathfd",
   137			.file = file,
   138			.cmd = CONFIGFD_SET_FD,
   139		};
   140		ret = kern_configfd_action(fd, &cp);
   141		/* file gets NULL'd if successfully installed otherwise we put */
   142		if (cp.file)
   143			fput(file);
   144		if (ret < 0)
   145			goto err_close;
   146		return fd;
   147	
   148	 err_close:
   149		ksys_close(fd);
   150	 err_file:
   151		fput(file);
   152		return ret;
   153	}
   154	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
