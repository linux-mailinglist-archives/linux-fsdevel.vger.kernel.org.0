Return-Path: <linux-fsdevel+bounces-32685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AAD9AD5D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 22:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7141F237C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 20:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3B13AA2B;
	Wed, 23 Oct 2024 20:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AbGaLtG+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6851E2306
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729716859; cv=none; b=rD1VXnSE2i8FOTTZ3y8dinkgcNfTBx5/KC+/ZMbPkGWm01SjtDG0/dRFb4taawDU9d21l3rN7futNwlaruoowxv3L72sSY9jSqurdzmGTavFcSQX3WSCtJKFLnYDzPRrC4Z5ovhJERjxmT4xVaKp/XRIIn7IZAgndLv24dSXFD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729716859; c=relaxed/simple;
	bh=m3UnnUKdf6fzNFecSL2p2T2iug/KLF3j1BmUffXIouE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybhyz+Hym2wjf8drv7ynUrU0A+Kl/3/8VA1sDSxHvI3TwIc2f9BrP3bzhivu5DjvKmAdD+ydmQ2l2q4XQYdIWUUKCqckdnD6RxSp2znIi9YMp4DjivZxSUd/xGIqPyorJuWTrhBLJnh5h40vvbvCKo49JnrkJ31qNpFDpL+RRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AbGaLtG+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729716856; x=1761252856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m3UnnUKdf6fzNFecSL2p2T2iug/KLF3j1BmUffXIouE=;
  b=AbGaLtG+smGJnauvn4knEBUPEB2C11QJaPI/rItZR4MKvDWxwWY1AeBz
   t8oEXZzQRnbhqXLt6hr7rvDmPwElqEesjDDEDwxVLyWw7ACt8srLMr76F
   2E4dTas9nV8e2LGcQ1aGUfP2s2cXnNs8hdVtR1uAZf7/D8+jA3ZkiykPY
   ekHgD/sDP6ypGo9JNCoZrT2RkjHW6shDhgr1ajLEEUDULz3k9Fs011hTt
   bP1vnQaRAB3DCIe1GGvtnryqTi/66cnYXGx5nynV5uZBRkvwE0zf2YPii
   qoFQ1ThH36pUMzRUvZuAnWtEP6mqmx4Z7L2ounFQixOEXUXK6Nf0MlGup
   Q==;
X-CSE-ConnectionGUID: neRS5n09TFORmRsUi8cz+g==
X-CSE-MsgGUID: vpIyEJbhTiOR0nTtktYJYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51869566"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51869566"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 13:54:16 -0700
X-CSE-ConnectionGUID: d6eaIDuAQx+zv2U03GF8fg==
X-CSE-MsgGUID: wp2tU81vQAOTbbl4faEqSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80038288"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Oct 2024 13:54:13 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3iMs-000VYS-35;
	Wed, 23 Oct 2024 20:54:10 +0000
Date: Thu, 24 Oct 2024 04:53:16 +0800
From: kernel test robot <lkp@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	josef@toxicpanda.com, bernd.schubert@fastmail.fm,
	willy@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH v2 09/13] fuse: convert retrieves to use folios
Message-ID: <202410240414.YVec3s6S-lkp@intel.com>
References: <20241022185443.1891563-10-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022185443.1891563-10-joannelkoong@gmail.com>

Hi Joanne,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-fuse/for-next]
[also build test WARNING on next-20241023]
[cannot apply to akpm-mm/mm-everything linus/master v6.12-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/fuse-support-folios-in-struct-fuse_args_pages-and-fuse_copy_pages/20241023-025923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git for-next
patch link:    https://lore.kernel.org/r/20241022185443.1891563-10-joannelkoong%40gmail.com
patch subject: [PATCH v2 09/13] fuse: convert retrieves to use folios
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241024/202410240414.YVec3s6S-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410240414.YVec3s6S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410240414.YVec3s6S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/fuse/dev.c:1773:43: warning: variable 'num_folios' is uninitialized when used here [-Wuninitialized]
    1773 |         ap->folio_descs = (void *) (ap->folios + num_folios);
         |                                                  ^~~~~~~~~~
   fs/fuse/dev.c:1745:25: note: initialize the variable 'num_folios' to silence this warning
    1745 |         unsigned int num_folios;
         |                                ^
         |                                 = 0
   1 warning generated.


vim +/num_folios +1773 fs/fuse/dev.c

  1734	
  1735	static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
  1736				 struct fuse_notify_retrieve_out *outarg)
  1737	{
  1738		int err;
  1739		struct address_space *mapping = inode->i_mapping;
  1740		pgoff_t index;
  1741		loff_t file_size;
  1742		unsigned int num;
  1743		unsigned int offset;
  1744		size_t total_len = 0;
  1745		unsigned int num_folios;
  1746		unsigned int num_pages, cur_pages = 0;
  1747		struct fuse_conn *fc = fm->fc;
  1748		struct fuse_retrieve_args *ra;
  1749		size_t args_size = sizeof(*ra);
  1750		struct fuse_args_pages *ap;
  1751		struct fuse_args *args;
  1752	
  1753		offset = outarg->offset & ~PAGE_MASK;
  1754		file_size = i_size_read(inode);
  1755	
  1756		num = min(outarg->size, fc->max_write);
  1757		if (outarg->offset > file_size)
  1758			num = 0;
  1759		else if (outarg->offset + num > file_size)
  1760			num = file_size - outarg->offset;
  1761	
  1762		num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
  1763		num_pages = min(num_pages, fc->max_pages);
  1764	
  1765		args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->folio_descs[0]));
  1766	
  1767		ra = kzalloc(args_size, GFP_KERNEL);
  1768		if (!ra)
  1769			return -ENOMEM;
  1770	
  1771		ap = &ra->ap;
  1772		ap->folios = (void *) (ra + 1);
> 1773		ap->folio_descs = (void *) (ap->folios + num_folios);
  1774		ap->uses_folios = true;
  1775	
  1776		args = &ap->args;
  1777		args->nodeid = outarg->nodeid;
  1778		args->opcode = FUSE_NOTIFY_REPLY;
  1779		args->in_numargs = 2;
  1780		args->in_pages = true;
  1781		args->end = fuse_retrieve_end;
  1782	
  1783		index = outarg->offset >> PAGE_SHIFT;
  1784	
  1785		while (num && cur_pages < num_pages) {
  1786			struct folio *folio;
  1787			unsigned int this_num;
  1788	
  1789			folio = filemap_get_folio(mapping, index);
  1790			if (IS_ERR(folio))
  1791				break;
  1792	
  1793			this_num = min_t(unsigned, num, PAGE_SIZE - offset);
  1794			ap->folios[ap->num_folios] = folio;
  1795			ap->folio_descs[ap->num_folios].offset = offset;
  1796			ap->folio_descs[ap->num_folios].length = this_num;
  1797			ap->num_folios++;
  1798			cur_pages++;
  1799	
  1800			offset = 0;
  1801			num -= this_num;
  1802			total_len += this_num;
  1803			index++;
  1804		}
  1805		ra->inarg.offset = outarg->offset;
  1806		ra->inarg.size = total_len;
  1807		args->in_args[0].size = sizeof(ra->inarg);
  1808		args->in_args[0].value = &ra->inarg;
  1809		args->in_args[1].size = total_len;
  1810	
  1811		err = fuse_simple_notify_reply(fm, args, outarg->notify_unique);
  1812		if (err)
  1813			fuse_retrieve_end(fm, args, err);
  1814	
  1815		return err;
  1816	}
  1817	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

