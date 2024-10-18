Return-Path: <linux-fsdevel+bounces-32308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC59A35AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8841C23B5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F618C327;
	Fri, 18 Oct 2024 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzOdIjbK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E795188710;
	Fri, 18 Oct 2024 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233624; cv=none; b=ZuJlNZrFc0ox7nkG5N1LoM2Vp95g65jI0L10fEVqkdEMN8c8/Es2MIyQ91sk6GCjAYUGjRcHTY5kiBMkYK+bOh5AS0hQxTRDri9+aehxXtZXgq4ssMN0VGY0YHBcGv1oi/xY7dPNO2x+pLpgU8BbijI1ueRTh8Q+0g3keL/DquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233624; c=relaxed/simple;
	bh=sTTimGF41mmcxrU8POHrpec/eDCJ4YLM8zH+e/I4X5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpHm+5gVkNhKnctzUMDOROW5TgUC7UKP2v9VJjtH4asClXXXzv887fxfG2y3Y4HIA3th3VTpfJbZ6xBt+jLCiVnf0RiFIc2SiGZtJ/9Zn1ClMZ9B4EcVFD2edT040ggQ5jxCvhVMSVptzt6NvwxE1/DmrFWwwlTxrKbIZrbYklE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzOdIjbK; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233622; x=1760769622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sTTimGF41mmcxrU8POHrpec/eDCJ4YLM8zH+e/I4X5Y=;
  b=TzOdIjbKWiMZcyrhQps3rvexGNW6ctZuI84+f3HhhRH2SqTdQ51WtRce
   cuZ+mT3WawPLXjijg4/vze6O99PQkyKblNT0h9NNjIbgOD8T77tRL65dL
   h9L3mgVATWWhkeXsM2SOjRz+OPD0lNun1DdHgHzRqJSvrexYrvtijOggm
   C4bQfzQDxTaS6s6Lx6G0mCB5uMLtYNlquHuVuihwWzaPpQd9hXp7wUciE
   aQiX7N9XxljhdHxwlpv45MLBLPeQqNckpG3im9B4i8dEk1UAsj8Lr1X6Q
   zkczKnyEdmTfcuNZPx4d0FMsuKe+la8cnF9XW1nWkELeKl3t769LhaYYB
   g==;
X-CSE-ConnectionGUID: GbBMgkjSTj2II5p4nUz8tA==
X-CSE-MsgGUID: 7RC250lGR9q9AIQcgvqY1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="31619025"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="31619025"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:40:13 -0700
X-CSE-ConnectionGUID: oSqqf0BWR7m9ddyr+j4XcA==
X-CSE-MsgGUID: OWmxwxchSEO8g50vOvRfOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="79196748"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Oct 2024 23:40:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1gee-000NNI-2c;
	Fri, 18 Oct 2024 06:40:08 +0000
Date: Fri, 18 Oct 2024 14:39:22 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tyler Hicks <code@tyhicks.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/10] ecryptfs: Convert ecryptfs_decrypt_page() to take
 a folio
Message-ID: <202410181420.B8LE1KXl-lkp@intel.com>
References: <20241017151709.2713048-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-9-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12-rc3]
[also build test WARNING on linus/master next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/ecryptfs-Convert-ecryptfs_writepage-to-ecryptfs_writepages/20241017-232033
base:   v6.12-rc3
patch link:    https://lore.kernel.org/r/20241017151709.2713048-9-willy%40infradead.org
patch subject: [PATCH 08/10] ecryptfs: Convert ecryptfs_decrypt_page() to take a folio
config: x86_64-buildonly-randconfig-002-20241018 (https://download.01.org/0day-ci/archive/20241018/202410181420.B8LE1KXl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181420.B8LE1KXl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181420.B8LE1KXl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ecryptfs/crypto.c:410: warning: Function parameter or struct member 'folio' not described in 'ecryptfs_encrypt_page'
   fs/ecryptfs/crypto.c:410: warning: Excess function parameter 'page' description in 'ecryptfs_encrypt_page'
>> fs/ecryptfs/crypto.c:479: warning: Function parameter or struct member 'folio' not described in 'ecryptfs_decrypt_page'
>> fs/ecryptfs/crypto.c:479: warning: Excess function parameter 'page' description in 'ecryptfs_decrypt_page'


vim +479 fs/ecryptfs/crypto.c

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
0216f7f7921759 Michael Halcrow         2007-10-16  462  /**
0216f7f7921759 Michael Halcrow         2007-10-16  463   * ecryptfs_decrypt_page
0216f7f7921759 Michael Halcrow         2007-10-16  464   * @page: Page mapped from the eCryptfs inode for the file; data read
0216f7f7921759 Michael Halcrow         2007-10-16  465   *        and decrypted from the lower file will be written into this
0216f7f7921759 Michael Halcrow         2007-10-16  466   *        page
0216f7f7921759 Michael Halcrow         2007-10-16  467   *
0216f7f7921759 Michael Halcrow         2007-10-16  468   * Decrypt an eCryptfs page. This is done on a per-extent basis. Note
0216f7f7921759 Michael Halcrow         2007-10-16  469   * that eCryptfs pages may straddle the lower pages -- for instance,
0216f7f7921759 Michael Halcrow         2007-10-16  470   * if the file was created on a machine with an 8K page size
0216f7f7921759 Michael Halcrow         2007-10-16  471   * (resulting in an 8K header), and then the file is copied onto a
0216f7f7921759 Michael Halcrow         2007-10-16  472   * host with a 32K page size, then when reading page 0 of the eCryptfs
0216f7f7921759 Michael Halcrow         2007-10-16  473   * file, 24K of page 0 of the lower file will be read and decrypted,
0216f7f7921759 Michael Halcrow         2007-10-16  474   * and then 8K of page 1 of the lower file will be read and decrypted.
0216f7f7921759 Michael Halcrow         2007-10-16  475   *
0216f7f7921759 Michael Halcrow         2007-10-16  476   * Returns zero on success; negative on error
0216f7f7921759 Michael Halcrow         2007-10-16  477   */
9f117fd1efdb64 Matthew Wilcox (Oracle  2024-10-17  478) int ecryptfs_decrypt_page(struct folio *folio)
0216f7f7921759 Michael Halcrow         2007-10-16 @479  {
0216f7f7921759 Michael Halcrow         2007-10-16  480  	struct inode *ecryptfs_inode;
0216f7f7921759 Michael Halcrow         2007-10-16  481  	struct ecryptfs_crypt_stat *crypt_stat;
9c6043f41222b4 Tyler Hicks             2013-04-06  482  	char *page_virt;
0216f7f7921759 Michael Halcrow         2007-10-16  483  	unsigned long extent_offset;
0f89617623fed9 Tyler Hicks             2013-04-15  484  	loff_t lower_offset;
0216f7f7921759 Michael Halcrow         2007-10-16  485  	int rc = 0;
0216f7f7921759 Michael Halcrow         2007-10-16  486  
9f117fd1efdb64 Matthew Wilcox (Oracle  2024-10-17  487) 	ecryptfs_inode = folio->mapping->host;
0216f7f7921759 Michael Halcrow         2007-10-16  488  	crypt_stat =
0216f7f7921759 Michael Halcrow         2007-10-16  489  		&(ecryptfs_inode_to_private(ecryptfs_inode)->crypt_stat);
13a791b4e63eb0 Tyler Hicks             2009-04-13  490  	BUG_ON(!(crypt_stat->flags & ECRYPTFS_ENCRYPTED));
0f89617623fed9 Tyler Hicks             2013-04-15  491  
9f117fd1efdb64 Matthew Wilcox (Oracle  2024-10-17  492) 	lower_offset = lower_offset_for_page(crypt_stat, &folio->page);
9f117fd1efdb64 Matthew Wilcox (Oracle  2024-10-17  493) 	page_virt = kmap_local_folio(folio, 0);
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  494  	rc = ecryptfs_read_lower(page_virt, lower_offset, PAGE_SIZE,
0216f7f7921759 Michael Halcrow         2007-10-16  495  				 ecryptfs_inode);
8b70deb8ca901d Fabio M. De Francesco   2023-04-26  496  	kunmap_local(page_virt);
96a7b9c2f5df89 Tyler Hicks             2009-09-16  497  	if (rc < 0) {
0f89617623fed9 Tyler Hicks             2013-04-15  498  		ecryptfs_printk(KERN_ERR,
0f89617623fed9 Tyler Hicks             2013-04-15  499  			"Error attempting to read lower page; rc = [%d]\n",
0f89617623fed9 Tyler Hicks             2013-04-15  500  			rc);
16a72c455a67bb Michael Halcrow         2007-10-16  501  		goto out;
0216f7f7921759 Michael Halcrow         2007-10-16  502  	}
0f89617623fed9 Tyler Hicks             2013-04-15  503  
0216f7f7921759 Michael Halcrow         2007-10-16  504  	for (extent_offset = 0;
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  505  	     extent_offset < (PAGE_SIZE / crypt_stat->extent_size);
0216f7f7921759 Michael Halcrow         2007-10-16  506  	     extent_offset++) {
9f117fd1efdb64 Matthew Wilcox (Oracle  2024-10-17  507) 		struct page *page = folio_page(folio, 0);
0df5ed65c14e2c Tyler Hicks             2013-05-23  508  		rc = crypt_extent(crypt_stat, page, page,
d78de618962d1e Tyler Hicks             2013-04-06  509  				  extent_offset, DECRYPT);
0216f7f7921759 Michael Halcrow         2007-10-16  510  		if (rc) {
1abbe1106d48ab Sascha Hauer            2021-02-24  511  			printk(KERN_ERR "%s: Error decrypting extent; "
18d1dbf1d401e8 Harvey Harrison         2008-04-29  512  			       "rc = [%d]\n", __func__, rc);
16a72c455a67bb Michael Halcrow         2007-10-16  513  			goto out;
237fead619984c Michael Halcrow         2006-10-04  514  		}
237fead619984c Michael Halcrow         2006-10-04  515  	}
237fead619984c Michael Halcrow         2006-10-04  516  out:
237fead619984c Michael Halcrow         2006-10-04  517  	return rc;
237fead619984c Michael Halcrow         2006-10-04  518  }
237fead619984c Michael Halcrow         2006-10-04  519  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

