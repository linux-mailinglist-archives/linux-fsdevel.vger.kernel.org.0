Return-Path: <linux-fsdevel+bounces-53919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1959AF8EA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 11:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFB74851F4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F472EAD11;
	Fri,  4 Jul 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnE5nOp7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAB2EAB93
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 09:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621258; cv=none; b=VLpi+vQpG48u8aVoQQDNigUXadthGwhzVLQtTmNirLNhEgkqrK8Wo2h+HBO466f4XmPcW5766nuyCFHj/hV6plsiaAnVVW0SduogSXsvIikkxzH02/+9HqYyXQtnXhmJiZ7wO55PhLb1H0+aL3e4xQElBkfVfH8upiF6B+zkaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621258; c=relaxed/simple;
	bh=GzWBd2BNV5zpl/3jWxQE1YZg+qE7WuSJ8JDvYgF3nqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7UOWFef6hWU1zqC2J/2hdI/G4ZkNm394S5Vu3+L1qCdSfg4lXhKLYxJi2l+1KXe9PUO19BpmzOr+I/xUg0PmJrKACBIdajKyvPwkxG4/XRYEvVSnmB2dxy1QAIPYSkRgQ3Jix6MkxzBBNPwiQz8VsGBkfTXHjE/5FkWF+SnE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnE5nOp7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751621255; x=1783157255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GzWBd2BNV5zpl/3jWxQE1YZg+qE7WuSJ8JDvYgF3nqk=;
  b=AnE5nOp7oqg1vl9KDAMuGoQEp3ZX+RU8uUKigrHzVacLsOhgP5rd6BNu
   sTSzeSBlf3mHiwd+7CGjOBkR/Ee5EDLatF/dn/MT6cKZ8mqElHkQatu4d
   Bk9Q17rRicF8/yIOd506nIFdR/fqx3JgyKbw640nMC/AFoO9lWFGcmC8H
   BAG6N4NoL3Rfb2jl9KFInQX9C6pdKSFL5AriCXTvb/rTVFzb3VWwg5nWZ
   y7JNvlgL8iOyKci9VEfQUhXe6eo4rc7M4sm6kXDDWcBmgOrHTmjOnit0J
   08miBzjvqctaTad9CJwU3ZRVV6xH9sOan8Te5kOfRztuA1JjQNqIBG+Ub
   g==;
X-CSE-ConnectionGUID: DLeoRt1NT9Kzyeuq0v+V5A==
X-CSE-MsgGUID: ZMCpDDe+T22SZP99Rk0Tlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65406770"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="65406770"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 02:27:34 -0700
X-CSE-ConnectionGUID: PGtlyWg7TtCUuLUTosBL9g==
X-CSE-MsgGUID: E8oWGKIbT72wf+/FdnNg+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="154013039"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 04 Jul 2025 02:27:33 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uXche-0003Y7-1S;
	Fri, 04 Jul 2025 09:27:30 +0000
Date: Fri, 4 Jul 2025 17:27:26 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: oe-kbuild-all@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] fuse: Use filemap_invalidate_pages()
Message-ID: <202507041729.OkMQMi8u-lkp@intel.com>
References: <20250703192459.3381327-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703192459.3381327-2-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on linus/master v6.16-rc4 next-20250703]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fuse-Use-filemap_invalidate_pages/20250704-032629
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20250703192459.3381327-2-willy%40infradead.org
patch subject: [PATCH 1/1] fuse: Use filemap_invalidate_pages()
config: microblaze-randconfig-r073-20250704 (https://download.01.org/0day-ci/archive/20250704/202507041729.OkMQMi8u-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250704/202507041729.OkMQMi8u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507041729.OkMQMi8u-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/fuse/file.c: In function 'fuse_direct_io':
>> fs/fuse/file.c:1557:10: warning: unused variable 'idx_to' [-Wunused-variable]
     pgoff_t idx_to = (pos + count - 1) >> PAGE_SHIFT;
             ^~~~~~
>> fs/fuse/file.c:1556:10: warning: unused variable 'idx_from' [-Wunused-variable]
     pgoff_t idx_from = pos >> PAGE_SHIFT;
             ^~~~~~~~


vim +/idx_to +1557 fs/fuse/file.c

413ef8cb302511 Miklos Szeredi          2005-09-09  1542  
d22a943f44c79c Al Viro                 2014-03-16  1543  ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
d22a943f44c79c Al Viro                 2014-03-16  1544  		       loff_t *ppos, int flags)
413ef8cb302511 Miklos Szeredi          2005-09-09  1545  {
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1546  	int write = flags & FUSE_DIO_WRITE;
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1547  	int cuse = flags & FUSE_DIO_CUSE;
e1c0eecba1a415 Miklos Szeredi          2017-09-12  1548  	struct file *file = io->iocb->ki_filp;
80e4f25262f9f1 Hao Xu                  2023-08-01  1549  	struct address_space *mapping = file->f_mapping;
80e4f25262f9f1 Hao Xu                  2023-08-01  1550  	struct inode *inode = mapping->host;
2106cb18930312 Miklos Szeredi          2009-04-28  1551  	struct fuse_file *ff = file->private_data;
fcee216beb9c15 Max Reitz               2020-05-06  1552  	struct fuse_conn *fc = ff->fm->fc;
413ef8cb302511 Miklos Szeredi          2005-09-09  1553  	size_t nmax = write ? fc->max_write : fc->max_read;
413ef8cb302511 Miklos Szeredi          2005-09-09  1554  	loff_t pos = *ppos;
d22a943f44c79c Al Viro                 2014-03-16  1555  	size_t count = iov_iter_count(iter);
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01 @1556  	pgoff_t idx_from = pos >> PAGE_SHIFT;
09cbfeaf1a5a67 Kirill A. Shutemov      2016-04-01 @1557  	pgoff_t idx_to = (pos + count - 1) >> PAGE_SHIFT;
413ef8cb302511 Miklos Szeredi          2005-09-09  1558  	ssize_t res = 0;
742f992708dff0 Ashish Samant           2016-03-14  1559  	int err = 0;
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1560  	struct fuse_io_args *ia;
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1561  	unsigned int max_pages;
80e4f25262f9f1 Hao Xu                  2023-08-01  1562  	bool fopen_direct_io = ff->open_flags & FOPEN_DIRECT_IO;
248d86e87d12da Miklos Szeredi          2006-01-06  1563  
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1564  	max_pages = iov_iter_npages(iter, fc->max_pages);
68bfb7eb7f7de3 Joanne Koong            2024-10-24  1565  	ia = fuse_io_alloc(io, max_pages);
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1566  	if (!ia)
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1567  		return -ENOMEM;
413ef8cb302511 Miklos Szeredi          2005-09-09  1568  
c55e0a55b16520 Tyler Fanelli           2023-09-19  1569  	if (fopen_direct_io && fc->direct_io_allow_mmap) {
147c1229fcb032 Matthew Wilcox (Oracle  2025-07-03  1570) 		res = filemap_invalidate_pages(mapping, pos, (pos + count - 1),
147c1229fcb032 Matthew Wilcox (Oracle  2025-07-03  1571) 				false);
b5a2a3a0b77668 Hao Xu                  2023-08-01  1572  		if (res) {
68bfb7eb7f7de3 Joanne Koong            2024-10-24  1573  			fuse_io_free(ia);
b5a2a3a0b77668 Hao Xu                  2023-08-01  1574  			return res;
b5a2a3a0b77668 Hao Xu                  2023-08-01  1575  		}
b5a2a3a0b77668 Hao Xu                  2023-08-01  1576  	}
0c58a97f919c24 Joanne Koong            2025-04-14  1577  	if (!cuse && filemap_range_has_writeback(mapping, pos, (pos + count - 1))) {
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1578  		if (!write)
5955102c9984fa Al Viro                 2016-01-22  1579  			inode_lock(inode);
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1580  		fuse_sync_writes(inode);
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1581  		if (!write)
5955102c9984fa Al Viro                 2016-01-22  1582  			inode_unlock(inode);
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1583  	}
ea8cd33390fafc Pavel Emelyanov         2013-10-10  1584  
fcb14cb1bdacec Al Viro                 2022-05-22  1585  	io->should_dirty = !write && user_backed_iter(iter);
413ef8cb302511 Miklos Szeredi          2005-09-09  1586  	while (count) {
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1587  		ssize_t nres;
2106cb18930312 Miklos Szeredi          2009-04-28  1588  		fl_owner_t owner = current->files;
f4975c67dd9ad8 Miklos Szeredi          2009-04-02  1589  		size_t nbytes = min(count, nmax);
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1590  
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1591  		err = fuse_get_user_pages(&ia->ap, iter, &nbytes, write,
41748675c0bf25 Hou Tao                 2024-08-31  1592  					  max_pages, fc->use_pages_for_kvec_io);
742f992708dff0 Ashish Samant           2016-03-14  1593  		if (err && !nbytes)
413ef8cb302511 Miklos Szeredi          2005-09-09  1594  			break;
f4975c67dd9ad8 Miklos Szeredi          2009-04-02  1595  
4a2abf99f9c287 Miklos Szeredi          2019-05-27  1596  		if (write) {
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1597  			if (!capable(CAP_FSETID))
10c52c84e3f487 Miklos Szeredi          2020-11-11  1598  				ia->write.in.write_flags |= FUSE_WRITE_KILL_SUIDGID;
4a2abf99f9c287 Miklos Szeredi          2019-05-27  1599  
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1600  			nres = fuse_send_write(ia, pos, nbytes, owner);
4a2abf99f9c287 Miklos Szeredi          2019-05-27  1601  		} else {
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1602  			nres = fuse_send_read(ia, pos, nbytes, owner);
4a2abf99f9c287 Miklos Szeredi          2019-05-27  1603  		}
2106cb18930312 Miklos Szeredi          2009-04-28  1604  
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1605  		if (!io->async || nres < 0) {
41748675c0bf25 Hou Tao                 2024-08-31  1606  			fuse_release_user_pages(&ia->ap, nres, io->should_dirty);
68bfb7eb7f7de3 Joanne Koong            2024-10-24  1607  			fuse_io_free(ia);
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1608  		}
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1609  		ia = NULL;
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1610  		if (nres < 0) {
f658adeea45e43 Miklos Szeredi          2020-02-06  1611  			iov_iter_revert(iter, nbytes);
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1612  			err = nres;
413ef8cb302511 Miklos Szeredi          2005-09-09  1613  			break;
413ef8cb302511 Miklos Szeredi          2005-09-09  1614  		}
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1615  		WARN_ON(nres > nbytes);
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1616  
413ef8cb302511 Miklos Szeredi          2005-09-09  1617  		count -= nres;
413ef8cb302511 Miklos Szeredi          2005-09-09  1618  		res += nres;
413ef8cb302511 Miklos Szeredi          2005-09-09  1619  		pos += nres;
f658adeea45e43 Miklos Szeredi          2020-02-06  1620  		if (nres != nbytes) {
f658adeea45e43 Miklos Szeredi          2020-02-06  1621  			iov_iter_revert(iter, nbytes - nres);
413ef8cb302511 Miklos Szeredi          2005-09-09  1622  			break;
f658adeea45e43 Miklos Szeredi          2020-02-06  1623  		}
56cf34ff079569 Miklos Szeredi          2006-04-11  1624  		if (count) {
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1625  			max_pages = iov_iter_npages(iter, fc->max_pages);
68bfb7eb7f7de3 Joanne Koong            2024-10-24  1626  			ia = fuse_io_alloc(io, max_pages);
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1627  			if (!ia)
56cf34ff079569 Miklos Szeredi          2006-04-11  1628  				break;
56cf34ff079569 Miklos Szeredi          2006-04-11  1629  		}
413ef8cb302511 Miklos Szeredi          2005-09-09  1630  	}
45ac96ed7c3691 Miklos Szeredi          2019-09-10  1631  	if (ia)
68bfb7eb7f7de3 Joanne Koong            2024-10-24  1632  		fuse_io_free(ia);
d09cb9d7f6e4cb Miklos Szeredi          2009-04-28  1633  	if (res > 0)
413ef8cb302511 Miklos Szeredi          2005-09-09  1634  		*ppos = pos;
413ef8cb302511 Miklos Szeredi          2005-09-09  1635  
742f992708dff0 Ashish Samant           2016-03-14  1636  	return res > 0 ? res : err;
413ef8cb302511 Miklos Szeredi          2005-09-09  1637  }
08cbf542bf24fb Tejun Heo               2009-04-14  1638  EXPORT_SYMBOL_GPL(fuse_direct_io);
413ef8cb302511 Miklos Szeredi          2005-09-09  1639  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

