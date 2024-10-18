Return-Path: <linux-fsdevel+bounces-32290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92EB9A3377
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 05:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF531C23465
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 03:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8F16B3B7;
	Fri, 18 Oct 2024 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZVy7N1R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823355464B;
	Fri, 18 Oct 2024 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729223047; cv=none; b=ok/QmHBp6LT5YUrip0eCFCUM+o7hcjOs/zAhvBRDYVID+OIaridhk/BDYAHB1nvllvz1Ef+WUN7JYbGuuVePZjiu6LA+40RiP3+lgcZnD28+JG0qbr7d7P3iwnC6Mo1V7sMmZi+O4VjabziOxLtP5ob81jXS03XJgdLo+OXeRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729223047; c=relaxed/simple;
	bh=VwKhGAtKSwLcZjVsc1hqQ8giRVlrZ4y8yEFAgPj3UvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=staYsqrO88Q51ASYZZ+r+x2XrC2L57Ufuk33WMb31+sAylKs8JVCPdq9QcbmR7GqiPXae2Ccy8skHn18hlDiXWH/0yXxz+1dAtRBqG0HVg5lOzjsaJIjWKnBxNbFHboxhHVnKWVr+j5mC5FLXGNmCmR61uoQ6Ew4UTlvmWZ1Mvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZVy7N1R; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729223046; x=1760759046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwKhGAtKSwLcZjVsc1hqQ8giRVlrZ4y8yEFAgPj3UvQ=;
  b=nZVy7N1RNAXfGq5i5vZD0Jq7zyitle4MtTbprRJzi8yxudnfZ/MxfDGE
   sT+2JvYV9+FU0/MAadrUlYs/M260f+x5JkjGy7Ol6UiaCPrZuyiv+WrAc
   VUjT9EzXYsAjhrZYcYfwWv18WzkK3P7e6PJSe+JYq8yJYuyzfIZMVzrkA
   pu+ycxkO6FdSR3lv8BG7bSFlfqMq2T9WecRHszF7UEsdNuTx2xGd6wMQ6
   KTgYWmX6LM/BazC/xBqT4qLHJlzJ7MUmuuXR/TiklYhNL3cTfn1Nbx0C8
   /oNEXlp6X9eOag10tWNyiYs7Uu/7OC3Wp7Z8ws2Hn0PT/pnlJxndIcJve
   g==;
X-CSE-ConnectionGUID: NTWPhbGcRKazYIaTiM7qyA==
X-CSE-MsgGUID: iPzMGJIsSzeKRVWoq1hEDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32539997"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="32539997"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:44:05 -0700
X-CSE-ConnectionGUID: VKu74AkRSDqbnAETSeEpfQ==
X-CSE-MsgGUID: QwrFji2wRGm057dQVFqjlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83574643"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 20:44:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1duC-000NEN-2c;
	Fri, 18 Oct 2024 03:44:00 +0000
Date: Fri, 18 Oct 2024 11:43:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tyler Hicks <code@tyhicks.com>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ecryptfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] ecryptfs: Convert
 ecryptfs_copy_up_encrypted_with_header() to take a folio
Message-ID: <202410181111.XVnnYVNa-lkp@intel.com>
References: <20241017151709.2713048-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-4-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12-rc3]
[also build test WARNING on linus/master next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/ecryptfs-Convert-ecryptfs_writepage-to-ecryptfs_writepages/20241017-232033
base:   v6.12-rc3
patch link:    https://lore.kernel.org/r/20241017151709.2713048-4-willy%40infradead.org
patch subject: [PATCH 03/10] ecryptfs: Convert ecryptfs_copy_up_encrypted_with_header() to take a folio
config: x86_64-buildonly-randconfig-002-20241018 (https://download.01.org/0day-ci/archive/20241018/202410181111.XVnnYVNa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410181111.XVnnYVNa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181111.XVnnYVNa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ecryptfs/mmap.c:109: warning: Function parameter or struct member 'folio' not described in 'ecryptfs_copy_up_encrypted_with_header'
>> fs/ecryptfs/mmap.c:109: warning: Excess function parameter 'page' description in 'ecryptfs_copy_up_encrypted_with_header'


vim +109 fs/ecryptfs/mmap.c

f4e60e6b303bc4 Tyler Hicks             2010-02-11   79  
688a9f7cd824e7 Lee Jones               2021-03-30   80  /*
e77a56ddceeec8 Michael Halcrow         2007-02-12   81   *   Header Extent:
e77a56ddceeec8 Michael Halcrow         2007-02-12   82   *     Octets 0-7:        Unencrypted file size (big-endian)
e77a56ddceeec8 Michael Halcrow         2007-02-12   83   *     Octets 8-15:       eCryptfs special marker
e77a56ddceeec8 Michael Halcrow         2007-02-12   84   *     Octets 16-19:      Flags
e77a56ddceeec8 Michael Halcrow         2007-02-12   85   *      Octet 16:         File format version number (between 0 and 255)
e77a56ddceeec8 Michael Halcrow         2007-02-12   86   *      Octets 17-18:     Reserved
e77a56ddceeec8 Michael Halcrow         2007-02-12   87   *      Octet 19:         Bit 1 (lsb): Reserved
e77a56ddceeec8 Michael Halcrow         2007-02-12   88   *                        Bit 2: Encrypted?
e77a56ddceeec8 Michael Halcrow         2007-02-12   89   *                        Bits 3-8: Reserved
e77a56ddceeec8 Michael Halcrow         2007-02-12   90   *     Octets 20-23:      Header extent size (big-endian)
e77a56ddceeec8 Michael Halcrow         2007-02-12   91   *     Octets 24-25:      Number of header extents at front of file
e77a56ddceeec8 Michael Halcrow         2007-02-12   92   *                        (big-endian)
e77a56ddceeec8 Michael Halcrow         2007-02-12   93   *     Octet  26:         Begin RFC 2440 authentication token packet set
e77a56ddceeec8 Michael Halcrow         2007-02-12   94   */
237fead619984c Michael Halcrow         2006-10-04   95  
237fead619984c Michael Halcrow         2006-10-04   96  /**
bf12be1cc851cf Michael Halcrow         2007-10-16   97   * ecryptfs_copy_up_encrypted_with_header
bf12be1cc851cf Michael Halcrow         2007-10-16   98   * @page: Sort of a ``virtual'' representation of the encrypted lower
bf12be1cc851cf Michael Halcrow         2007-10-16   99   *        file. The actual lower file does not have the metadata in
bf12be1cc851cf Michael Halcrow         2007-10-16  100   *        the header. This is locked.
bf12be1cc851cf Michael Halcrow         2007-10-16  101   * @crypt_stat: The eCryptfs inode's cryptographic context
237fead619984c Michael Halcrow         2006-10-04  102   *
bf12be1cc851cf Michael Halcrow         2007-10-16  103   * The ``view'' is the version of the file that userspace winds up
bf12be1cc851cf Michael Halcrow         2007-10-16  104   * seeing, with the header information inserted.
237fead619984c Michael Halcrow         2006-10-04  105   */
bf12be1cc851cf Michael Halcrow         2007-10-16  106  static int
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  107) ecryptfs_copy_up_encrypted_with_header(struct folio *folio,
bf12be1cc851cf Michael Halcrow         2007-10-16  108  				       struct ecryptfs_crypt_stat *crypt_stat)
237fead619984c Michael Halcrow         2006-10-04 @109  {
bf12be1cc851cf Michael Halcrow         2007-10-16  110  	loff_t extent_num_in_page = 0;
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  111  	loff_t num_extents_per_page = (PAGE_SIZE
bf12be1cc851cf Michael Halcrow         2007-10-16  112  				       / crypt_stat->extent_size);
237fead619984c Michael Halcrow         2006-10-04  113  	int rc = 0;
237fead619984c Michael Halcrow         2006-10-04  114  
bf12be1cc851cf Michael Halcrow         2007-10-16  115  	while (extent_num_in_page < num_extents_per_page) {
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  116) 		loff_t view_extent_num = ((loff_t)folio->index
d6a13c17164fcc Michael Halcrow         2007-10-16  117  					   * num_extents_per_page)
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  118) 					  + extent_num_in_page;
cc11beffdf80ca Michael Halcrow         2008-02-06  119  		size_t num_header_extents_at_front =
fa3ef1cb4e6e99 Tyler Hicks             2010-02-11  120  			(crypt_stat->metadata_size / crypt_stat->extent_size);
e77a56ddceeec8 Michael Halcrow         2007-02-12  121  
cc11beffdf80ca Michael Halcrow         2008-02-06  122  		if (view_extent_num < num_header_extents_at_front) {
bf12be1cc851cf Michael Halcrow         2007-10-16  123  			/* This is a header extent */
e77a56ddceeec8 Michael Halcrow         2007-02-12  124  			char *page_virt;
e77a56ddceeec8 Michael Halcrow         2007-02-12  125  
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  126) 			page_virt = kmap_local_folio(folio, 0);
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  127  			memset(page_virt, 0, PAGE_SIZE);
bf12be1cc851cf Michael Halcrow         2007-10-16  128  			/* TODO: Support more than one header extent */
bf12be1cc851cf Michael Halcrow         2007-10-16  129  			if (view_extent_num == 0) {
157f1071354db1 Tyler Hicks             2010-02-11  130  				size_t written;
157f1071354db1 Tyler Hicks             2010-02-11  131  
e77a56ddceeec8 Michael Halcrow         2007-02-12  132  				rc = ecryptfs_read_xattr_region(
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  133) 					page_virt, folio->mapping->host);
f4e60e6b303bc4 Tyler Hicks             2010-02-11  134  				strip_xattr_flag(page_virt + 16, crypt_stat);
157f1071354db1 Tyler Hicks             2010-02-11  135  				ecryptfs_write_header_metadata(page_virt + 20,
157f1071354db1 Tyler Hicks             2010-02-11  136  							       crypt_stat,
157f1071354db1 Tyler Hicks             2010-02-11  137  							       &written);
e77a56ddceeec8 Michael Halcrow         2007-02-12  138  			}
e2393b8f3987c5 Fabio M. De Francesco   2023-04-26  139  			kunmap_local(page_virt);
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  140) 			flush_dcache_folio(folio);
e77a56ddceeec8 Michael Halcrow         2007-02-12  141  			if (rc) {
bf12be1cc851cf Michael Halcrow         2007-10-16  142  				printk(KERN_ERR "%s: Error reading xattr "
18d1dbf1d401e8 Harvey Harrison         2008-04-29  143  				       "region; rc = [%d]\n", __func__, rc);
e77a56ddceeec8 Michael Halcrow         2007-02-12  144  				goto out;
e77a56ddceeec8 Michael Halcrow         2007-02-12  145  			}
e77a56ddceeec8 Michael Halcrow         2007-02-12  146  		} else {
bf12be1cc851cf Michael Halcrow         2007-10-16  147  			/* This is an encrypted data extent */
bf12be1cc851cf Michael Halcrow         2007-10-16  148  			loff_t lower_offset =
cc11beffdf80ca Michael Halcrow         2008-02-06  149  				((view_extent_num * crypt_stat->extent_size)
fa3ef1cb4e6e99 Tyler Hicks             2010-02-11  150  				 - crypt_stat->metadata_size);
bf12be1cc851cf Michael Halcrow         2007-10-16  151  
bf12be1cc851cf Michael Halcrow         2007-10-16  152  			rc = ecryptfs_read_lower_page_segment(
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  153) 				&folio->page, (lower_offset >> PAGE_SHIFT),
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01  154  				(lower_offset & ~PAGE_MASK),
f02b13c08673c2 Matthew Wilcox (Oracle  2024-10-17  155) 				crypt_stat->extent_size, folio->mapping->host);
e77a56ddceeec8 Michael Halcrow         2007-02-12  156  			if (rc) {
bf12be1cc851cf Michael Halcrow         2007-10-16  157  				printk(KERN_ERR "%s: Error attempting to read "
bf12be1cc851cf Michael Halcrow         2007-10-16  158  				       "extent at offset [%lld] in the lower "
18d1dbf1d401e8 Harvey Harrison         2008-04-29  159  				       "file; rc = [%d]\n", __func__,
bf12be1cc851cf Michael Halcrow         2007-10-16  160  				       lower_offset, rc);
e77a56ddceeec8 Michael Halcrow         2007-02-12  161  				goto out;
e77a56ddceeec8 Michael Halcrow         2007-02-12  162  			}
e77a56ddceeec8 Michael Halcrow         2007-02-12  163  		}
bf12be1cc851cf Michael Halcrow         2007-10-16  164  		extent_num_in_page++;
bf12be1cc851cf Michael Halcrow         2007-10-16  165  	}
bf12be1cc851cf Michael Halcrow         2007-10-16  166  out:
bf12be1cc851cf Michael Halcrow         2007-10-16  167  	return rc;
bf12be1cc851cf Michael Halcrow         2007-10-16  168  }
bf12be1cc851cf Michael Halcrow         2007-10-16  169  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

