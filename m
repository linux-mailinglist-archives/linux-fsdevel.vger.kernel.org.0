Return-Path: <linux-fsdevel+bounces-50797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E703EACFB0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 04:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DEC18938C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 02:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027E31D5165;
	Fri,  6 Jun 2025 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KWoPxnoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A91ADFE4;
	Fri,  6 Jun 2025 02:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175378; cv=none; b=n8lorGTd6bBuboYO6xuYGeJsf5vTThE3w37XrAHkwpJqjYWyzxhoJ/ws1a2y8i6pRsOfnr+HghiVG84nwggwyaVc/bYCkw1JesBQArIXm1CL+OPW1TSVNoqJGkHwWF+g7OZ3uznGkXJiNeJdaawK4wn+zvXdMFvFtqh62U8jqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175378; c=relaxed/simple;
	bh=PkDDIOWwgNduFmqOPNWTzwTKKdUTNlQ9NPXFA7KAFoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXPAd5rrLRj7UvqyI1QCnknA9kBzzzL/tOnbKQdPFA17NsiVE10/P/0FZnL9pedUk1Ybl+VIJNl5A03pxssTjFa7esb7SYy9Fu9EVWAWKWUzEdL2VmmeAKj/dKujSKgcFd+KmChJ+PDVTDi+1RuYzWn5mbkMX9yjmsKd69gK+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KWoPxnoq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749175375; x=1780711375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PkDDIOWwgNduFmqOPNWTzwTKKdUTNlQ9NPXFA7KAFoE=;
  b=KWoPxnoqh1w6sC7WkvrUtKNUmB6zCz35vm7QdPU0pOcUMtWvOac/QFp3
   JpPXAw3dqfX0cXSUlpzqlUtFL5GuDel1/nLBYOSqx++MVFAtwm90Vstny
   Kx4V1W/ENx63hlxvnGynEeBynCPGpo9HQA5xbha6Ju81v6iPJqHPFvK1A
   urINRpN9fgc3m0nQX8F7W2yt9uFv5SXQkcBr34OvZYmcw+oUPLPLFemga
   VZEfG+0qP6jvRpbMEoyqJiVkSJBoR7jgGAM/Ie8ZEKnolKRzfFq4JpAJl
   7PiOEXKPiLr3oamsn1a/g2Oa342hFpEm980RDR2VHYhs1NJhPwatoyqTX
   A==;
X-CSE-ConnectionGUID: BiThrAuRSO2cWaHGWG7hoQ==
X-CSE-MsgGUID: mvSB0PoUQ3WVuX1Q0ecL/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51414033"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51414033"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 19:02:54 -0700
X-CSE-ConnectionGUID: 5Bjt7ioxTOGf/fkOptiJOQ==
X-CSE-MsgGUID: ho+Nu/m4SY+HmnZFZ3OnXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="150518150"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 05 Jun 2025 19:02:52 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNMPy-0004eD-0U;
	Fri, 06 Jun 2025 02:02:50 +0000
Date: Fri, 6 Jun 2025 10:02:34 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 5/7] xfs: fill dirty folios on zero range of unwritten
 mappings
Message-ID: <202506060903.vM8I4O0S-lkp@intel.com>
References: <20250605173357.579720-6-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605173357.579720-6-bfoster@redhat.com>

Hi Brian,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on akpm-mm/mm-everything linus/master next-20250605]
[cannot apply to xfs-linux/for-next v6.15]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Foster/iomap-move-pos-len-BUG_ON-to-after-folio-lookup/20250606-013227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250605173357.579720-6-bfoster%40redhat.com
patch subject: [PATCH 5/7] xfs: fill dirty folios on zero range of unwritten mappings
config: i386-buildonly-randconfig-003-20250606 (https://download.01.org/0day-ci/archive/20250606/202506060903.vM8I4O0S-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250606/202506060903.vM8I4O0S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506060903.vM8I4O0S-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/xfs/xfs_iomap.c: In function 'xfs_buffered_write_iomap_begin':
>> fs/xfs/xfs_iomap.c:1602:55: error: 'iter' undeclared (first use in this function)
    1602 |                         end = iomap_fill_dirty_folios(iter, offset, len);
         |                                                       ^~~~
   fs/xfs/xfs_iomap.c:1602:55: note: each undeclared identifier is reported only once for each function it appears in
   fs/xfs/xfs_iomap.c: In function 'xfs_seek_iomap_begin':
>> fs/xfs/xfs_iomap.c:1893:34: warning: unused variable 'iter' [-Wunused-variable]
    1893 |         struct iomap_iter       *iter = container_of(iomap, struct iomap_iter,
         |                                  ^~~~


vim +/iter +1602 fs/xfs/xfs_iomap.c

  1498	
  1499	static int
  1500	xfs_buffered_write_iomap_begin(
  1501		struct inode		*inode,
  1502		loff_t			offset,
  1503		loff_t			count,
  1504		unsigned		flags,
  1505		struct iomap		*iomap,
  1506		struct iomap		*srcmap)
  1507	{
  1508		struct xfs_inode	*ip = XFS_I(inode);
  1509		struct xfs_mount	*mp = ip->i_mount;
  1510		xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
  1511		xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, count);
  1512		struct xfs_bmbt_irec	imap, cmap;
  1513		struct xfs_iext_cursor	icur, ccur;
  1514		xfs_fsblock_t		prealloc_blocks = 0;
  1515		bool			eof = false, cow_eof = false, shared = false;
  1516		int			allocfork = XFS_DATA_FORK;
  1517		int			error = 0;
  1518		unsigned int		lockmode = XFS_ILOCK_EXCL;
  1519		unsigned int		iomap_flags = 0;
  1520		u64			seq;
  1521	
  1522		if (xfs_is_shutdown(mp))
  1523			return -EIO;
  1524	
  1525		if (xfs_is_zoned_inode(ip))
  1526			return xfs_zoned_buffered_write_iomap_begin(inode, offset,
  1527					count, flags, iomap, srcmap);
  1528	
  1529		/* we can't use delayed allocations when using extent size hints */
  1530		if (xfs_get_extsz_hint(ip))
  1531			return xfs_direct_write_iomap_begin(inode, offset, count,
  1532					flags, iomap, srcmap);
  1533	
  1534		error = xfs_qm_dqattach(ip);
  1535		if (error)
  1536			return error;
  1537	
  1538		error = xfs_ilock_for_iomap(ip, flags, &lockmode);
  1539		if (error)
  1540			return error;
  1541	
  1542		if (XFS_IS_CORRUPT(mp, !xfs_ifork_has_extents(&ip->i_df)) ||
  1543		    XFS_TEST_ERROR(false, mp, XFS_ERRTAG_BMAPIFORMAT)) {
  1544			xfs_bmap_mark_sick(ip, XFS_DATA_FORK);
  1545			error = -EFSCORRUPTED;
  1546			goto out_unlock;
  1547		}
  1548	
  1549		XFS_STATS_INC(mp, xs_blk_mapw);
  1550	
  1551		error = xfs_iread_extents(NULL, ip, XFS_DATA_FORK);
  1552		if (error)
  1553			goto out_unlock;
  1554	
  1555		/*
  1556		 * Search the data fork first to look up our source mapping.  We
  1557		 * always need the data fork map, as we have to return it to the
  1558		 * iomap code so that the higher level write code can read data in to
  1559		 * perform read-modify-write cycles for unaligned writes.
  1560		 */
  1561		eof = !xfs_iext_lookup_extent(ip, &ip->i_df, offset_fsb, &icur, &imap);
  1562		if (eof)
  1563			imap.br_startoff = end_fsb; /* fake hole until the end */
  1564	
  1565		/* We never need to allocate blocks for zeroing or unsharing a hole. */
  1566		if ((flags & (IOMAP_UNSHARE | IOMAP_ZERO)) &&
  1567		    imap.br_startoff > offset_fsb) {
  1568			xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
  1569			goto out_unlock;
  1570		}
  1571	
  1572		/*
  1573		 * For zeroing, trim extents that extend beyond the EOF block. If a
  1574		 * delalloc extent starts beyond the EOF block, convert it to an
  1575		 * unwritten extent.
  1576		 */
  1577		if (flags & IOMAP_ZERO) {
  1578			xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
  1579			u64 end;
  1580	
  1581			if (isnullstartblock(imap.br_startblock) &&
  1582			    offset_fsb >= eof_fsb)
  1583				goto convert_delay;
  1584			if (offset_fsb < eof_fsb && end_fsb > eof_fsb)
  1585				end_fsb = eof_fsb;
  1586	
  1587			/*
  1588			 * Look up dirty folios for unwritten mappings within EOF.
  1589			 * Providing this bypasses the flush iomap uses to trigger
  1590			 * extent conversion when unwritten mappings have dirty
  1591			 * pagecache in need of zeroing.
  1592			 *
  1593			 * Trim the mapping to the end pos of the lookup, which in turn
  1594			 * was trimmed to the end of the batch if it became full before
  1595			 * the end of the mapping.
  1596			 */
  1597			if (imap.br_state == XFS_EXT_UNWRITTEN &&
  1598			    offset_fsb < eof_fsb) {
  1599				loff_t len = min(count,
  1600						 XFS_FSB_TO_B(mp, imap.br_blockcount));
  1601	
> 1602				end = iomap_fill_dirty_folios(iter, offset, len);
  1603				end_fsb = min_t(xfs_fileoff_t, end_fsb,
  1604						XFS_B_TO_FSB(mp, end));
  1605			}
  1606	
  1607			xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
  1608		}
  1609	
  1610		/*
  1611		 * Search the COW fork extent list even if we did not find a data fork
  1612		 * extent.  This serves two purposes: first this implements the
  1613		 * speculative preallocation using cowextsize, so that we also unshare
  1614		 * block adjacent to shared blocks instead of just the shared blocks
  1615		 * themselves.  Second the lookup in the extent list is generally faster
  1616		 * than going out to the shared extent tree.
  1617		 */
  1618		if (xfs_is_cow_inode(ip)) {
  1619			if (!ip->i_cowfp) {
  1620				ASSERT(!xfs_is_reflink_inode(ip));
  1621				xfs_ifork_init_cow(ip);
  1622			}
  1623			cow_eof = !xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb,
  1624					&ccur, &cmap);
  1625			if (!cow_eof && cmap.br_startoff <= offset_fsb) {
  1626				trace_xfs_reflink_cow_found(ip, &cmap);
  1627				goto found_cow;
  1628			}
  1629		}
  1630	
  1631		if (imap.br_startoff <= offset_fsb) {
  1632			/*
  1633			 * For reflink files we may need a delalloc reservation when
  1634			 * overwriting shared extents.   This includes zeroing of
  1635			 * existing extents that contain data.
  1636			 */
  1637			if (!xfs_is_cow_inode(ip) ||
  1638			    ((flags & IOMAP_ZERO) && imap.br_state != XFS_EXT_NORM)) {
  1639				trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
  1640						&imap);
  1641				goto found_imap;
  1642			}
  1643	
  1644			xfs_trim_extent(&imap, offset_fsb, end_fsb - offset_fsb);
  1645	
  1646			/* Trim the mapping to the nearest shared extent boundary. */
  1647			error = xfs_bmap_trim_cow(ip, &imap, &shared);
  1648			if (error)
  1649				goto out_unlock;
  1650	
  1651			/* Not shared?  Just report the (potentially capped) extent. */
  1652			if (!shared) {
  1653				trace_xfs_iomap_found(ip, offset, count, XFS_DATA_FORK,
  1654						&imap);
  1655				goto found_imap;
  1656			}
  1657	
  1658			/*
  1659			 * Fork all the shared blocks from our write offset until the
  1660			 * end of the extent.
  1661			 */
  1662			allocfork = XFS_COW_FORK;
  1663			end_fsb = imap.br_startoff + imap.br_blockcount;
  1664		} else {
  1665			/*
  1666			 * We cap the maximum length we map here to MAX_WRITEBACK_PAGES
  1667			 * pages to keep the chunks of work done where somewhat
  1668			 * symmetric with the work writeback does.  This is a completely
  1669			 * arbitrary number pulled out of thin air.
  1670			 *
  1671			 * Note that the values needs to be less than 32-bits wide until
  1672			 * the lower level functions are updated.
  1673			 */
  1674			count = min_t(loff_t, count, 1024 * PAGE_SIZE);
  1675			end_fsb = xfs_iomap_end_fsb(mp, offset, count);
  1676	
  1677			if (xfs_is_always_cow_inode(ip))
  1678				allocfork = XFS_COW_FORK;
  1679		}
  1680	
  1681		if (eof && offset + count > XFS_ISIZE(ip)) {
  1682			/*
  1683			 * Determine the initial size of the preallocation.
  1684			 * We clean up any extra preallocation when the file is closed.
  1685			 */
  1686			if (xfs_has_allocsize(mp))
  1687				prealloc_blocks = mp->m_allocsize_blocks;
  1688			else if (allocfork == XFS_DATA_FORK)
  1689				prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
  1690							offset, count, &icur);
  1691			else
  1692				prealloc_blocks = xfs_iomap_prealloc_size(ip, allocfork,
  1693							offset, count, &ccur);
  1694			if (prealloc_blocks) {
  1695				xfs_extlen_t	align;
  1696				xfs_off_t	end_offset;
  1697				xfs_fileoff_t	p_end_fsb;
  1698	
  1699				end_offset = XFS_ALLOC_ALIGN(mp, offset + count - 1);
  1700				p_end_fsb = XFS_B_TO_FSBT(mp, end_offset) +
  1701						prealloc_blocks;
  1702	
  1703				align = xfs_eof_alignment(ip);
  1704				if (align)
  1705					p_end_fsb = roundup_64(p_end_fsb, align);
  1706	
  1707				p_end_fsb = min(p_end_fsb,
  1708					XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes));
  1709				ASSERT(p_end_fsb > offset_fsb);
  1710				prealloc_blocks = p_end_fsb - end_fsb;
  1711			}
  1712		}
  1713	
  1714		/*
  1715		 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
  1716		 * them out if the write happens to fail.
  1717		 */
  1718		iomap_flags |= IOMAP_F_NEW;
  1719		if (allocfork == XFS_COW_FORK) {
  1720			error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
  1721					end_fsb - offset_fsb, prealloc_blocks, &cmap,
  1722					&ccur, cow_eof);
  1723			if (error)
  1724				goto out_unlock;
  1725	
  1726			trace_xfs_iomap_alloc(ip, offset, count, allocfork, &cmap);
  1727			goto found_cow;
  1728		}
  1729	
  1730		error = xfs_bmapi_reserve_delalloc(ip, allocfork, offset_fsb,
  1731				end_fsb - offset_fsb, prealloc_blocks, &imap, &icur,
  1732				eof);
  1733		if (error)
  1734			goto out_unlock;
  1735	
  1736		trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
  1737	found_imap:
  1738		seq = xfs_iomap_inode_sequence(ip, iomap_flags);
  1739		xfs_iunlock(ip, lockmode);
  1740		return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, iomap_flags, seq);
  1741	
  1742	convert_delay:
  1743		xfs_iunlock(ip, lockmode);
  1744		truncate_pagecache(inode, offset);
  1745		error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
  1746						   iomap, NULL);
  1747		if (error)
  1748			return error;
  1749	
  1750		trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
  1751		return 0;
  1752	
  1753	found_cow:
  1754		if (imap.br_startoff <= offset_fsb) {
  1755			error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0,
  1756					xfs_iomap_inode_sequence(ip, 0));
  1757			if (error)
  1758				goto out_unlock;
  1759		} else {
  1760			xfs_trim_extent(&cmap, offset_fsb,
  1761					imap.br_startoff - offset_fsb);
  1762		}
  1763	
  1764		iomap_flags |= IOMAP_F_SHARED;
  1765		seq = xfs_iomap_inode_sequence(ip, iomap_flags);
  1766		xfs_iunlock(ip, lockmode);
  1767		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
  1768	
  1769	out_unlock:
  1770		xfs_iunlock(ip, lockmode);
  1771		return error;
  1772	}
  1773	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

