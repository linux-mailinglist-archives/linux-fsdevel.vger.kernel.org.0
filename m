Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 135BC137B1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jan 2020 03:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgAKCZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 21:25:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:65282 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgAKCZ1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 21:25:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 18:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,419,1571727600"; 
   d="gz'50?scan'50,208,50";a="239566639"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Jan 2020 18:25:25 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iq6Sq-000IBW-Rq; Sat, 11 Jan 2020 10:25:24 +0800
Date:   Sat, 11 Jan 2020 10:25:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [vfs:work.misc 4/5] fs/inode.c:1615:5: error: redefinition of 'bmap'
Message-ID: <202001110912.6NpYdskM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7sbylolptsmu7kod"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7sbylolptsmu7kod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
head:   caf4444df50ce746faf8eef422f4044d66353925
commit: 65a805fdd75f81aa90eb407585592b8463a8570e [4/5] fibmap: Use bmap instead of ->bmap method in ioctl_fibmap
config: nds32-allnoconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 65a805fdd75f81aa90eb407585592b8463a8570e
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/inode.c:1615:5: error: redefinition of 'bmap'
    1615 | int bmap(struct inode *inode, sector_t *block)
         |     ^~~~
   In file included from fs/inode.c:7:
   include/linux/fs.h:2872:19: note: previous definition of 'bmap' was here
    2872 | static inline int bmap(struct inode *inode,  sector_t *block)
         |                   ^~~~

vim +/bmap +1615 fs/inode.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  1600  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1601  /**
^1da177e4c3f41 Linus Torvalds  2005-04-16  1602   *	bmap	- find a block number in a file
79decc2b6ea454 Carlos Maiolino 2020-01-09  1603   *	@inode:  inode owning the block number being requested
79decc2b6ea454 Carlos Maiolino 2020-01-09  1604   *	@block: pointer containing the block to find
^1da177e4c3f41 Linus Torvalds  2005-04-16  1605   *
79decc2b6ea454 Carlos Maiolino 2020-01-09  1606   *	Replaces the value in *block with the block number on the device holding
79decc2b6ea454 Carlos Maiolino 2020-01-09  1607   *	corresponding to the requested block number in the file.
79decc2b6ea454 Carlos Maiolino 2020-01-09  1608   *	That is, asked for block 4 of inode 1 the function will replace the
79decc2b6ea454 Carlos Maiolino 2020-01-09  1609   *	4 in *block, with disk block relative to the disk start that holds that
79decc2b6ea454 Carlos Maiolino 2020-01-09  1610   *	block of the file.
79decc2b6ea454 Carlos Maiolino 2020-01-09  1611   *
79decc2b6ea454 Carlos Maiolino 2020-01-09  1612   *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
79decc2b6ea454 Carlos Maiolino 2020-01-09  1613   *	hole, returns 0 and *block is also set to 0.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1614   */
79decc2b6ea454 Carlos Maiolino 2020-01-09 @1615  int bmap(struct inode *inode, sector_t *block)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1616  {
79decc2b6ea454 Carlos Maiolino 2020-01-09  1617  	if (!inode->i_mapping->a_ops->bmap)
79decc2b6ea454 Carlos Maiolino 2020-01-09  1618  		return -EINVAL;
79decc2b6ea454 Carlos Maiolino 2020-01-09  1619  
79decc2b6ea454 Carlos Maiolino 2020-01-09  1620  	*block = inode->i_mapping->a_ops->bmap(inode->i_mapping, *block);
79decc2b6ea454 Carlos Maiolino 2020-01-09  1621  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1622  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  1623  EXPORT_SYMBOL(bmap);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1624  

:::::: The code at line 1615 was first introduced by commit
:::::: 79decc2b6ea4542a85d5b352c208a0467bf71477 fs: Enable bmap() function to properly return errors

:::::: TO: Carlos Maiolino <cmaiolino@redhat.com>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--7sbylolptsmu7kod
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--7sbylolptsmu7kod--
