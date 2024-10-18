Return-Path: <linux-fsdevel+bounces-32291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A89A340C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 07:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3561B2217C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 05:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F317A5A4;
	Fri, 18 Oct 2024 05:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMAQOE/S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB2168C3F;
	Fri, 18 Oct 2024 05:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228029; cv=none; b=rQ3d6XJ8j9C5rIZqyVzmMx6NyTBKafw4EWVTNFK4b93Q01wZPf6qaIKtsB+ZR5Q6OJKdmPtUtILftunbxhovJwO1d4QaVr2I8kwTksgEbTGicR+PdSIudScgxCFTtEmmIjpGIlItXJ4J2p4Ax+Te41QKgI32Qr8NUbzWm3ryJuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228029; c=relaxed/simple;
	bh=TU4eptu1H+ycDeBEuj72rE6jilhJFoFqXwZUycBmwRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXO4LQWFC82B1x8jhx62K6MTd6UTdJpLgCSzvFHY/373GRjgHectxa4my8BuXSHo9WbSi9IQ+l86gNlMEBxpQ3zWkwtmNOGQMDj3NE4A0xCX4m7Lq41uymbQz6jNb1Gr0s1olMZ/UlvdwNWoBe5u7mdbdQWnqzIdbY1MFSstYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMAQOE/S; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729228028; x=1760764028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TU4eptu1H+ycDeBEuj72rE6jilhJFoFqXwZUycBmwRE=;
  b=YMAQOE/SGGhTZcket2A5EG3DtJfDC926MfUYKdCb6MR2rhvmwTNlcxbd
   wfRcxo7rvFhnPtLh2DXa7j7o1LtjqP3ExSl6zqHfskB2t0cnxK4qYy5kk
   CS/pqnfFJ8dpVPw2mN0IAFnfrnZr6spA9c7XUeI2pfDEhh9U0QHtXfIDP
   sXB7vm9LRp8yvXz8t6RA2stl5BnWTR6Mhv4gXpP2RHOWo4n4TDLah46fj
   WiA4nI/q5+aoBoNLg/6RQnrrGrTnV63eNLOLcXw0IZCbya3P2CD/Vi5tq
   ce2Sn5ayF6s208RaGsALpYg8MXRNt8FvWJaCIjO7KgQT9C9qFTjiDAMiC
   w==;
X-CSE-ConnectionGUID: H9rEhudJRgmuHJBgqObXTg==
X-CSE-MsgGUID: Tz04HDsVSGiLY9gb20sPAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="16363475"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="16363475"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:07:07 -0700
X-CSE-ConnectionGUID: Cmxh7h7WSumk4uTdMxh7GQ==
X-CSE-MsgGUID: ttWua6SxTWeP67JpmOi3iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78369879"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Oct 2024 22:07:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1fCZ-000NI7-0G;
	Fri, 18 Oct 2024 05:07:03 +0000
Date: Fri, 18 Oct 2024 13:06:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tyler Hicks <code@tyhicks.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/10] ecryptfs: Convert ecryptfs_encrypt_page() to take
 a folio
Message-ID: <202410181219.HUGM3U13-lkp@intel.com>
References: <20241017151709.2713048-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-8-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12-rc3]
[also build test WARNING on linus/master next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/ecryptfs-Convert-ecryptfs_writepage-to-ecryptfs_writepages/20241017-232033
base:   v6.12-rc3
patch link:    https://lore.kernel.org/r/20241017151709.2713048-8-willy%40infradead.org
patch subject: [PATCH 07/10] ecryptfs: Convert ecryptfs_encrypt_page() to take a folio
config: x86_64-buildonly-randconfig-002-20241018 (https://download.01.org/0day-ci/archive/20241018/202410181219.HUGM3U13-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181219.HUGM3U13-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181219.HUGM3U13-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ecryptfs/crypto.c:410: warning: Function parameter or struct member 'folio' not described in 'ecryptfs_encrypt_page'
>> fs/ecryptfs/crypto.c:410: warning: Excess function parameter 'page' description in 'ecryptfs_encrypt_page'


vim +410 fs/ecryptfs/crypto.c

237fead619984c Michael Halcrow         2006-10-04  392  
237fead619984c Michael Halcrow         2006-10-04  393  /**
0216f7f7921759 Michael Halcrow         2007-10-16  394   * ecryptfs_encrypt_page
0216f7f7921759 Michael Halcrow         2007-10-16  395   * @page: Page mapped from the eCryptfs inode for the file; contains
0216f7f7921759 Michael Halcrow         2007-10-16  396   *        decrypted content that needs to be encrypted (to a temporary
0216f7f7921759 Michael Halcrow         2007-10-16  397   *        page; not in place) and written out to the lower file
237fead619984c Michael Halcrow         2006-10-04  398   *
0216f7f7921759 Michael Halcrow         2007-10-16  399   * Encrypt an eCryptfs page. This is done on a per-extent basis. Note
237fead619984c Michael Halcrow         2006-10-04  400   * that eCryptfs pages may straddle the lower pages -- for instance,
237fead619984c Michael Halcrow         2006-10-04  401   * if the file was created on a machine with an 8K page size
237fead619984c Michael Halcrow         2006-10-04  402   * (resulting in an 8K header), and then the file is copied onto a
237fead619984c Michael Halcrow         2006-10-04  403   * host with a 32K page size, then when reading page 0 of the eCryptfs
237fead619984c Michael Halcrow         2006-10-04  404   * file, 24K of page 0 of the lower file will be read and decrypted,
237fead619984c Michael Halcrow         2006-10-04  405   * and then 8K of page 1 of the lower file will be read and decrypted.
237fead619984c Michael Halcrow         2006-10-04  406   *
237fead619984c Michael Halcrow         2006-10-04  407   * Returns zero on success; negative on error
237fead619984c Michael Halcrow         2006-10-04  408   */
722a8483fde078 Matthew Wilcox (Oracle  2024-10-17  409) int ecryptfs_encrypt_page(struct folio *folio)
237fead619984c Michael Halcrow         2006-10-04 @410  {
0216f7f7921759 Michael Halcrow         2007-10-16  411  	struct inode *ecryptfs_inode;
237fead619984c Michael Halcrow         2006-10-04  412  	struct ecryptfs_crypt_stat *crypt_stat;
7fcba054373d5d Eric Sandeen            2008-07-28  413  	char *enc_extent_virt;
7fcba054373d5d Eric Sandeen            2008-07-28  414  	struct page *enc_extent_page = NULL;
0216f7f7921759 Michael Halcrow         2007-10-16  415  	loff_t extent_offset;
0f89617623fed9 Tyler Hicks             2013-04-15  416  	loff_t lower_offset;
237fead619984c Michael Halcrow         2006-10-04  417  	int rc = 0;
237fead619984c Michael Halcrow         2006-10-04  418  
722a8483fde078 Matthew Wilcox (Oracle  2024-10-17  419) 	ecryptfs_inode = folio->mapping->host;
0216f7f7921759 Michael Halcrow         2007-10-16  420  	crypt_stat =
0216f7f7921759 Michael Halcrow         2007-10-16  421  		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
13a791b4e63eb0 Tyler Hicks             2009-04-13  422  	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
7fcba054373d5d Eric Sandeen            2008-07-28  423  	enc_extent_page = alloc_page(GFP_USER);
7fcba054373d5d Eric Sandeen            2008-07-28  424  	if (!enc_extent_page) {
237fead619984c Michael Halcrow         2006-10-04  425  		rc = -ENOMEM;
0216f7f7921759 Michael Halcrow         2007-10-16  426  		ecryptfs_printk(KERN_ERR, "Error allocating memory for "
0216f7f7921759 Michael Halcrow         2007-10-16  427  				"encrypted extent\n");
237fead619984c Michael Halcrow         2006-10-04  428  		goto out;
237fead619984c Michael Halcrow         2006-10-04  429  	}
0f89617623fed9 Tyler Hicks             2013-04-15  430  
0216f7f7921759 Michael Halcrow         2007-10-16  431  	for (extent_offset = 0;
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  432  	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
0216f7f7921759 Michael Halcrow         2007-10-16  433  	     extent_offset++) {
722a8483fde078 Matthew Wilcox (Oracle  2024-10-17  434) 		rc = crypt_extent(crypt_stat, enc_extent_page,
722a8483fde078 Matthew Wilcox (Oracle  2024-10-17  435) 				folio_page(folio, 0), extent_offset, ENCRYPT);
237fead619984c Michael Halcrow         2006-10-04  436  		if (rc) {
0216f7f7921759 Michael Halcrow         2007-10-16  437  			printk(KERN_ERR "%s: Error encrypting extent; "
18d1dbf1d401e8 Harvey Harrison         2008-04-29  438  			       "rc = [%d]\n", __func__, rc);
237fead619984c Michael Halcrow         2006-10-04  439  			goto out;
237fead619984c Michael Halcrow         2006-10-04  440  		}
237fead619984c Michael Halcrow         2006-10-04  441  	}
0216f7f7921759 Michael Halcrow         2007-10-16  442  
722a8483fde078 Matthew Wilcox (Oracle  2024-10-17  443) 	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
8b70deb8ca901d Fabio M. De Francesco   2023-04-26  444  	enc_extent_virt = kmap_local_page(enc_extent_page);
0f89617623fed9 Tyler Hicks             2013-04-15  445  	rc = ecryptfs_write_lower(ecryptfs_inode, enc_extent_virt, lower_offset,
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  446  				  PAGE_SIZE);
8b70deb8ca901d Fabio M. De Francesco   2023-04-26  447  	kunmap_local(enc_extent_virt);
0216f7f7921759 Michael Halcrow         2007-10-16  448  	if (rc < 0) {
0f89617623fed9 Tyler Hicks             2013-04-15  449  		ecryptfs_printk(KERN_ERR,
0f89617623fed9 Tyler Hicks             2013-04-15  450  			"Error attempting to write lower page; rc = [%d]\n",
0216f7f7921759 Michael Halcrow         2007-10-16  451  			rc);
237fead619984c Michael Halcrow         2006-10-04  452  		goto out;
237fead619984c Michael Halcrow         2006-10-04  453  	}
237fead619984c Michael Halcrow         2006-10-04  454  	rc = 0;
0216f7f7921759 Michael Halcrow         2007-10-16  455  out:
7fcba054373d5d Eric Sandeen            2008-07-28  456  	if (enc_extent_page) {
7fcba054373d5d Eric Sandeen            2008-07-28  457  		__free_page(enc_extent_page);
7fcba054373d5d Eric Sandeen            2008-07-28  458  	}
0216f7f7921759 Michael Halcrow         2007-10-16  459  	return rc;
0216f7f7921759 Michael Halcrow         2007-10-16  460  }
0216f7f7921759 Michael Halcrow         2007-10-16  461  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

