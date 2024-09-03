Return-Path: <linux-fsdevel+bounces-28339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8A969840
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D351C234E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B951AD265;
	Tue,  3 Sep 2024 09:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buYP8JzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549761A4E7C;
	Tue,  3 Sep 2024 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354300; cv=none; b=D3N1B/9bNqiERNOSwGFlRZMVvTq/zO1XgOQ8MoBJoH0E80gCTghSp94hnwG6S8LpRRU2uaeaPOsEVUMlmhqFeOKMq/nj+k5+Qw0zn/IqCXgRkBqW81QK9cUUMrMoVk1rSFRczD4Qoy222UOjEXVOHojrMjXXEJ01aacZ9Is1bTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354300; c=relaxed/simple;
	bh=FJkaE2OKNSgpe2GmROalby7d6nY73pSlHd34LXN9PKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJR4BulzPutlVTiOp5UMOzviaPCqYl4ftV4TOAan9dCGN6TlyYtqQzgvlHqqWqZLz9+r6DDPrI9OAlR812qqryg5RWYG9deIetinDpyYywVVNJNx9T8u+K2D/KLeBpdkRC0jEYPivg6BJXuOP1SeUrUWYLHuLNoHErq7udUnfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buYP8JzN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725354298; x=1756890298;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FJkaE2OKNSgpe2GmROalby7d6nY73pSlHd34LXN9PKQ=;
  b=buYP8JzNtiGbDA46ClsN/ynsRqc6aGH42/sS7TbLQ+rixHJLxAMlkjl5
   lETjTxJzKePOMvRyVnPHiezvG3bBz9ZBtM16unEzGNF1RjtzdbaW0VM40
   OmbtJVD/WhJiW31KwmxlQGXA1t63aaUwOeXMJX8sCWjwZGwI6BoNKSeGs
   qhB+DvDM6sizvJF7zKqxOeQYySKD6IYXzKKlwy77E68PgpeQilbr4zLd1
   ixw5YFcXdcyprL+TpfGjHkdXbSD6HE+jGD7RxSqcdfI8F/YKnC47y5w++
   8S7V2NG5h+0KCO1z5wdZSN2fPsC/H12w16+1NtbH+sDdAC1RDfA5KH8Na
   Q==;
X-CSE-ConnectionGUID: MadiW0E3THmwestzF/Ds4g==
X-CSE-MsgGUID: PVy9Af0hSJqEwLqs/XX+ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="24092547"
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="24092547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 02:04:55 -0700
X-CSE-ConnectionGUID: S4YadueWTFejJLEKeWpafA==
X-CSE-MsgGUID: ppte8awaQ/ilpx/yT91mbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="102279345"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 03 Sep 2024 02:04:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slPSz-0006R0-1t;
	Tue, 03 Sep 2024 09:04:49 +0000
Date: Tue, 3 Sep 2024 17:04:28 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com, Christoph Hellwig <hch@lst.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: Re: [PATCH v2 2/8] unicode: Create utf8_check_strict_name
Message-ID: <202409031655.gO1eC1AL-lkp@intel.com>
References: <20240902225511.757831-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902225511.757831-3-andrealmeid@igalia.com>

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on tytso-ext4/dev brauner-vfs/vfs.all linus/master v6.11-rc6 next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/unicode-Fix-utf8_load-error-path/20240903-070149
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240902225511.757831-3-andrealmeid%40igalia.com
patch subject: [PATCH v2 2/8] unicode: Create utf8_check_strict_name
config: powerpc64-randconfig-r073-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031655.gO1eC1AL-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project dc19b59ea2502193c0e7bc16bb7d711c8053edcf)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409031655.gO1eC1AL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409031655.gO1eC1AL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/unicode/utf8-core.c:238:11: error: call to undeclared function 'IS_CASEFOLDED'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     238 |         return !(IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
         |                  ^
>> fs/unicode/utf8-core.c:238:36: error: incomplete definition of type 'struct inode'
     238 |         return !(IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
         |                                        ~~~^
   include/linux/uprobes.h:21:8: note: forward declaration of 'struct inode'
      21 | struct inode;
         |        ^
>> fs/unicode/utf8-core.c:239:9: error: call to undeclared function 'sb_has_strict_encoding'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     239 |                sb_has_strict_encoding(dir->i_sb) &&
         |                ^
   fs/unicode/utf8-core.c:239:35: error: incomplete definition of type 'struct inode'
     239 |                sb_has_strict_encoding(dir->i_sb) &&
         |                                       ~~~^
   include/linux/uprobes.h:21:8: note: forward declaration of 'struct inode'
      21 | struct inode;
         |        ^
   fs/unicode/utf8-core.c:240:26: error: incomplete definition of type 'struct inode'
     240 |                utf8_validate(dir->i_sb->s_encoding, d_name));
         |                              ~~~^
   include/linux/uprobes.h:21:8: note: forward declaration of 'struct inode'
      21 | struct inode;
         |        ^
   5 errors generated.


vim +/IS_CASEFOLDED +238 fs/unicode/utf8-core.c

   216	
   217	/**
   218	 * utf8_check_strict_name - Check if a given name is suitable for a directory
   219	 *
   220	 * This functions checks if the proposed filename is suitable for the parent
   221	 * directory. That means that only valid UTF-8 filenames will be accepted for
   222	 * casefold directories from filesystems created with the strict enconding flags.
   223	 * That also means that any name will be accepted for directories that doesn't
   224	 * have casefold enabled, or aren't being strict with the enconding.
   225	 *
   226	 * @inode: inode of the directory where the new file will be created
   227	 * @d_name: name of the new file
   228	 *
   229	 * Returns:
   230	 *  * True if the filename is suitable for this directory. It can be true if a
   231	 *  given name is not suitable for a strict enconding directory, but the
   232	 *  directory being used isn't strict
   233	 *  * False if the filename isn't suitable for this directory. This only happens
   234	 *  when a directory is casefolded and is strict about its encoding.
   235	 */
   236	bool utf8_check_strict_name(struct inode *dir, struct qstr *d_name)
   237	{
 > 238		return !(IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
 > 239		       sb_has_strict_encoding(dir->i_sb) &&

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

