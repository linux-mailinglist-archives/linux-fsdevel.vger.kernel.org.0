Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AB21411C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEEQe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 12:34:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:15544 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfEEQe3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 12:34:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 May 2019 09:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,434,1549958400"; 
   d="gz'50?scan'50,208,50";a="148493044"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 May 2019 09:34:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hNK5o-0004Cu-TB; Mon, 06 May 2019 00:34:24 +0800
Date:   Mon, 6 May 2019 00:33:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@01.org, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [PATCH] fsnotify: fix unlink performance regression
Message-ID: <201905060021.I3fgRl4C%lkp@intel.com>
References: <20190505091549.1934-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20190505091549.1934-1-amir73il@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Amir,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.1-rc7 next-20190503]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/fsnotify-fix-unlink-performance-regression/20190505-233115
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs///attr.c:15:
   include/linux/fsnotify.h: In function 'fsnotify_nameremove':
>> include/linux/fsnotify.h:179:23: error: 'struct inode' has no member named 'i_fsnotify_mask'
     if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
                          ^~
>> include/linux/fsnotify.h:180:20: error: 'struct super_block' has no member named 's_fsnotify_mask'
         !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
                       ^~

vim +179 include/linux/fsnotify.h

   153	
   154	/*
   155	 * fsnotify_nameremove - a filename was removed from a directory
   156	 *
   157	 * This is mostly called under parent vfs inode lock so name and
   158	 * dentry->d_parent should be stable. However there are some corner cases where
   159	 * inode lock is not held. So to be on the safe side and be reselient to future
   160	 * callers and out of tree users of d_delete(), we do not assume that d_parent
   161	 * and d_name are stable and we use dget_parent() and
   162	 * take_dentry_name_snapshot() to grab stable references.
   163	 */
   164	static inline void fsnotify_nameremove(struct dentry *dentry, int isdir)
   165	{
   166		struct dentry *parent;
   167		struct name_snapshot name;
   168		__u32 mask = FS_DELETE;
   169	
   170		/* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
   171		if (IS_ROOT(dentry))
   172			return;
   173	
   174		if (isdir)
   175			mask |= FS_ISDIR;
   176	
   177		parent = dget_parent(dentry);
   178		/* Avoid unneeded take_dentry_name_snapshot() */
 > 179		if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
 > 180		    !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
   181			goto out_dput;
   182	
   183		take_dentry_name_snapshot(&name, dentry);
   184	
   185		fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
   186			 name.name, 0);
   187	
   188		release_dentry_name_snapshot(&name);
   189	
   190	out_dput:
   191		dput(parent);
   192	}
   193	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lrZ03NoBR/3+SXJZ--
