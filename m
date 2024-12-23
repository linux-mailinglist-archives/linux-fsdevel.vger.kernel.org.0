Return-Path: <linux-fsdevel+bounces-38021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB59FAD5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 11:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615CF1885DE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35E195B37;
	Mon, 23 Dec 2024 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y+jl4FPj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E718FC79
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734951405; cv=none; b=ca5MTjYLrqPOH+a86GVRK4T8DJn8MySm7HYBnn/YSqSXhi9sJbKD/VrREHTYEH4obuyh++wZT6j3e+QBKJlt6Ve0WSy8ZN0hu46JmcfubFg7inW3GkDIva0MksfDEWw/WQdQQHakgJ11UYqh/D99vhCrXIpUcLGHf8BIzzTsO8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734951405; c=relaxed/simple;
	bh=uW8AHJTpl6aGBYegqIfRSUEnuQceTykaxN21iG+GZec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yg/1T/zuG0sRGKtsMwbfiLaNPCVPICrBtpNjXofdznE6uav+JhLNHcswRhn4DVuvhj7TuElKc2YPtjhJlgbBCWn+xKZWzfPaORFbiEBee1Yhlb6wr8vOYfnVErto+vDoefQNoB3IQafVmMPlJfstdGSQyNbESUt/cb/tLOrBZBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y+jl4FPj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734951403; x=1766487403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uW8AHJTpl6aGBYegqIfRSUEnuQceTykaxN21iG+GZec=;
  b=Y+jl4FPjIForW/Ms0pM/G5uaR2Ei8Yi/YczWCG+8xL9n7Fc8zyH9lh+v
   sHcwnKNMofMWBu8QSgwsrW1d0NDDcaltJvhxEpsV3S0UtwAkwS9P26XfR
   xKlmHlnxzBBf4YEkpR4BgXtLTNMWCsVcr/Yi8lARfCXn50NIHvg/EuAzI
   rCZBOHh3yFw22fGeYZpnFg10C/1pJS9JNsgZuHSzmRDfpOh0FDNejj5S1
   6ttr4kmXZrb5CV2TN3GYdNFieXfVPN3tMzcmHhnGrl2v78gpcFTXa4CnR
   XIsiLFN+vUdPHC2P/aet6VicWQ+r3ruKHxN911rw2m1ZyCZpGOXHouyAK
   A==;
X-CSE-ConnectionGUID: HPrfAbl9SCS3jvmsX+j1Pw==
X-CSE-MsgGUID: bxf1dgcORTGCCKiOULnyaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="46419660"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="46419660"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 02:56:43 -0800
X-CSE-ConnectionGUID: bEBRLp16T8SbnLloiaiTmQ==
X-CSE-MsgGUID: wGA3wLi7T6qYc3BSOuRjEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99641594"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Dec 2024 02:56:42 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPg75-0003YJ-24;
	Mon, 23 Dec 2024 10:56:39 +0000
Date: Mon, 23 Dec 2024 18:55:39 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.dcache 6/6] fs/libfs.c:1819:10: warning: comparison
 of distinct pointer types ('const char *' and 'const unsigned char *')
Message-ID: <202412231828.bq5nr63U-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
head:   08141fdc186755910b5bffc21a4325e2b673629f
commit: 7cd7d43774879a6d7fc35662fb788ed8210dd09a [6/6] generic_ci_d_compare(): use shortname_storage
config: arm-randconfig-002-20241223 (https://download.01.org/0day-ci/archive/20241223/202412231828.bq5nr63U-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241223/202412231828.bq5nr63U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412231828.bq5nr63U-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/libfs.c:1819:10: warning: comparison of distinct pointer types ('const char *' and 'const unsigned char *') [-Wcompare-distinct-pointer-types]
           if (str == dentry->d_shortname.string) {
               ~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1819 fs/libfs.c

  1776	
  1777	#if IS_ENABLED(CONFIG_UNICODE)
  1778	/**
  1779	 * generic_ci_d_compare - generic d_compare implementation for casefolding filesystems
  1780	 * @dentry:	dentry whose name we are checking against
  1781	 * @len:	len of name of dentry
  1782	 * @str:	str pointer to name of dentry
  1783	 * @name:	Name to compare against
  1784	 *
  1785	 * Return: 0 if names match, 1 if mismatch, or -ERRNO
  1786	 */
  1787	int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
  1788				 const char *str, const struct qstr *name)
  1789	{
  1790		const struct dentry *parent;
  1791		const struct inode *dir;
  1792		union shortname_store strbuf;
  1793		struct qstr qstr;
  1794	
  1795		/*
  1796		 * Attempt a case-sensitive match first. It is cheaper and
  1797		 * should cover most lookups, including all the sane
  1798		 * applications that expect a case-sensitive filesystem.
  1799		 *
  1800		 * This comparison is safe under RCU because the caller
  1801		 * guarantees the consistency between str and len. See
  1802		 * __d_lookup_rcu_op_compare() for details.
  1803		 */
  1804		if (len == name->len && !memcmp(str, name->name, len))
  1805			return 0;
  1806	
  1807		parent = READ_ONCE(dentry->d_parent);
  1808		dir = READ_ONCE(parent->d_inode);
  1809		if (!dir || !IS_CASEFOLDED(dir))
  1810			return 1;
  1811	
  1812		/*
  1813		 * If the dentry name is stored in-line, then it may be concurrently
  1814		 * modified by a rename.  If this happens, the VFS will eventually retry
  1815		 * the lookup, so it doesn't matter what ->d_compare() returns.
  1816		 * However, it's unsafe to call utf8_strncasecmp() with an unstable
  1817		 * string.  Therefore, we have to copy the name into a temporary buffer.
  1818		 */
> 1819		if (str == dentry->d_shortname.string) {
  1820			strbuf = dentry->d_shortname;
  1821			strbuf.string[len] = 0;
  1822			str = strbuf.string;
  1823			/* prevent compiler from optimizing out the temporary buffer */
  1824			barrier();
  1825		}
  1826		qstr.len = len;
  1827		qstr.name = str;
  1828	
  1829		return utf8_strncasecmp(dentry->d_sb->s_encoding, name, &qstr);
  1830	}
  1831	EXPORT_SYMBOL(generic_ci_d_compare);
  1832	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

