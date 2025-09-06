Return-Path: <linux-fsdevel+bounces-60454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3E3B477AA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 23:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 484361894CB2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE7E28C2D2;
	Sat,  6 Sep 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCu1Tdt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DE27815F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757194713; cv=none; b=OjHZE2mfCNUm/+nf8SJW8X0sZg4bsHQ702NxJXOQxXuglesHNk+EJS4z+4ozUZsCK7fcj5/xPRfbdk0pO+WlPuhswn8G/g+O7acJKX9f/R1eBQw0YEwfEhAf4FJoLDaK22TPa5l8oBesGDqWl7QqbUBBgD3fEzmsz8ItV8gCHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757194713; c=relaxed/simple;
	bh=dGhjPaZfa2DgzzUvL2/jQeH/WwIqI9J3yANZC6vRovQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKQzxTIVIbsHC1dYINIFRdZMqlF2l4jHAu57KqjdirwyqaVs/w6TNHTq6GoItM+dFGN5Moxt9bJWPdZ7U8ZlLekoUwDgzwMtn7OLqueajK5PfxHFQyOL5bvq1bnDxD5EevxneGr9rrGYNu4VWWmCQC2teLu5cJTTryh3/trSXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCu1Tdt7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757194712; x=1788730712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGhjPaZfa2DgzzUvL2/jQeH/WwIqI9J3yANZC6vRovQ=;
  b=KCu1Tdt7wNmnBOU3xj/ov+Jfuqh08iirEFbj48pK0Ke1Kfrp49ZyjGX6
   fc8ccHEnn4L0tImjY0Jhhb5zW3RGeD013h4kC7NWD1Wey7if7catY7Vlv
   DNnMoA+2tVSQMgJvQHIKOwKLBMfCyO1fDE6yuZOUBqvToPvxJMuEwMVXe
   1LKvMLqqLoFmPtttrR776oYJP0/wNeWzKNHUNf5hQdMLvLg3EcL2t0kXc
   v+x0uh9f6izaa2GuSCg9ab4ULDvv/lVyUKiFOoj3KzUoQSAOFi3V9X/c3
   H1akh0pRTWsKdvgOIMUhecrwi/qU1tqvBe9cB51N9T5GDYNwJjzwTWhTT
   w==;
X-CSE-ConnectionGUID: 6PJjvJH6S6qZUu2YMXW14Q==
X-CSE-MsgGUID: Bs+N6bzrR9WdRLOvCthlsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="70932743"
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="70932743"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2025 14:38:31 -0700
X-CSE-ConnectionGUID: U33iNxBARHm6WOThMSCnoQ==
X-CSE-MsgGUID: zsK9EpVER+CzESTt71uJtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,245,1751266800"; 
   d="scan'208";a="176792663"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2025 14:38:28 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uv0c6-0001oT-1a;
	Sat, 06 Sep 2025 21:38:26 +0000
Date: Sun, 7 Sep 2025 05:37:51 +0800
From: kernel test robot <lkp@intel.com>
To: "k.chen" <k.chen@smail.nju.edu.cn>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, slava@dubeyko.com,
	frank.li@vivo.com, linux-fsdevel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de, wenzhi.wang@uwaterloo.ca,
	liushixin2@huawei.com, "k.chen" <k.chen@smail.nju.edu.cn>
Subject: Re: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
Message-ID: <202509070516.2i61Okso-lkp@intel.com>
References: <20250906100923.444243-1-k.chen@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906100923.444243-1-k.chen@smail.nju.edu.cn>

Hi k.chen,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc4 next-20250905]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/k-chen/hfsplus-fix-slab-out-of-bounds-read-in-hfsplus_uni2asc/20250906-181212
base:   linus/master
patch link:    https://lore.kernel.org/r/20250906100923.444243-1-k.chen%40smail.nju.edu.cn
patch subject: [PATCH] hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
config: arm-randconfig-002-20250907 (https://download.01.org/0day-ci/archive/20250907/202509070516.2i61Okso-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 7fb1dc08d2f025aad5777bb779dfac1197e9ef87)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250907/202509070516.2i61Okso-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509070516.2i61Okso-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/hfsplus/xattr.c:739:9: error: incompatible pointer types passing 'const struct hfsplus_attr_unistr *' to parameter of type 'const struct hfsplus_unistr *' [-Werror,-Wincompatible-pointer-types]
     739 |                                     (const struct hfsplus_attr_unistr *)&fd.key
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     740 |                                             ->attr.key_name,
         |                                             ~~~~~~~~~~~~~~~
   fs/hfsplus/hfsplus_fs.h:524:74: note: passing argument to parameter 'ustr' here
     524 | int hfsplus_uni2asc(struct super_block *sb, const struct hfsplus_unistr *ustr,
         |                                                                          ^
   1 error generated.


vim +739 fs/hfsplus/xattr.c

   675	
   676	ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
   677	{
   678		ssize_t err;
   679		ssize_t res;
   680		struct inode *inode = d_inode(dentry);
   681		struct hfs_find_data fd;
   682		struct hfsplus_attr_key attr_key;
   683		char *strbuf;
   684		int xattr_name_len;
   685	
   686		if ((!S_ISREG(inode->i_mode) &&
   687				!S_ISDIR(inode->i_mode)) ||
   688					HFSPLUS_IS_RSRC(inode))
   689			return -EOPNOTSUPP;
   690	
   691		res = hfsplus_listxattr_finder_info(dentry, buffer, size);
   692		if (res < 0)
   693			return res;
   694		else if (!HFSPLUS_SB(inode->i_sb)->attr_tree)
   695			return (res == 0) ? -EOPNOTSUPP : res;
   696	
   697		err = hfs_find_init(HFSPLUS_SB(inode->i_sb)->attr_tree, &fd);
   698		if (err) {
   699			pr_err("can't init xattr find struct\n");
   700			return err;
   701		}
   702	
   703		strbuf = kzalloc(NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN +
   704				XATTR_MAC_OSX_PREFIX_LEN + 1, GFP_KERNEL);
   705		if (!strbuf) {
   706			res = -ENOMEM;
   707			goto out;
   708		}
   709	
   710		err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
   711		if (err) {
   712			if (err == -ENOENT) {
   713				if (res == 0)
   714					res = -ENODATA;
   715				goto end_listxattr;
   716			} else {
   717				res = err;
   718				goto end_listxattr;
   719			}
   720		}
   721	
   722		for (;;) {
   723			u16 key_len = hfs_bnode_read_u16(fd.bnode, fd.keyoffset);
   724	
   725			if (key_len == 0 || key_len > fd.tree->max_key_len) {
   726				pr_err("invalid xattr key length: %d\n", key_len);
   727				res = -EIO;
   728				goto end_listxattr;
   729			}
   730	
   731			hfs_bnode_read(fd.bnode, &attr_key,
   732					fd.keyoffset, key_len + sizeof(key_len));
   733	
   734			if (be32_to_cpu(attr_key.cnid) != inode->i_ino)
   735				goto end_listxattr;
   736	
   737			xattr_name_len = NLS_MAX_CHARSET_SIZE * HFSPLUS_ATTR_MAX_STRLEN;
   738			if (hfsplus_uni2asc(inode->i_sb,
 > 739					    (const struct hfsplus_attr_unistr *)&fd.key
   740						    ->attr.key_name,
   741					    HFSPLUS_ATTR_MAX_STRLEN, strbuf,
   742					    &xattr_name_len)) {
   743				pr_err("unicode conversion failed\n");
   744				res = -EIO;
   745				goto end_listxattr;
   746			}
   747	
   748			if (!buffer || !size) {
   749				if (can_list(strbuf))
   750					res += name_len(strbuf, xattr_name_len);
   751			} else if (can_list(strbuf)) {
   752				if (size < (res + name_len(strbuf, xattr_name_len))) {
   753					res = -ERANGE;
   754					goto end_listxattr;
   755				} else
   756					res += copy_name(buffer + res,
   757							strbuf, xattr_name_len);
   758			}
   759	
   760			if (hfs_brec_goto(&fd, 1))
   761				goto end_listxattr;
   762		}
   763	
   764	end_listxattr:
   765		kfree(strbuf);
   766	out:
   767		hfs_find_exit(&fd);
   768		return res;
   769	}
   770	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

