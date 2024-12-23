Return-Path: <linux-fsdevel+bounces-38023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA49FAEC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 14:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C2E1612B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2024 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7349B1A8F7A;
	Mon, 23 Dec 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0MWwMXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60819CC0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Dec 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734959030; cv=none; b=laTRJTA4u2eOgLk2KBi+3qFOz9Xl+EZabkn8hH2+4Vo5WbDs7Ips/ivnDc6P4d1EhJ5xF4cS6upcuu66eFPnwkQyZKO2Qgbqxuiay2hze2mIhflcdt52clLDQSMyE/IXDyCPNY3eB5p+7MXlJzCYvd3GoRVRv/77bKVb1PwWL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734959030; c=relaxed/simple;
	bh=7ofghjsmGN1rPOxM6a8mV/o+3l+2/+69oKAXNuluaDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RIamLT77YRfPCxncAEfw1EcLb7XcJ99ugR5pCKdqSEhlIPERy4dgGnd1cxJk+F6eILIE8Y3L6jySXRk5ejjy95aOBuxbnq1scOPsdDDgvO+TNJX8KIuI93tCX56bcrsRtwtJMQWLCMt6B4WswYq1iI/GSNIWb2SFkUeDCSwaGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0MWwMXt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734959030; x=1766495030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7ofghjsmGN1rPOxM6a8mV/o+3l+2/+69oKAXNuluaDQ=;
  b=h0MWwMXtegaFdczxuTh0eyKVZYwn/hbdQJIomWqeaXk6ARofKgSAABHy
   0ZsKj8dq+eVdgAeBWTZVIa9Pp3rQ2ushxBGTFlLyWTZ6Ft8ukpn4LS4jX
   iMNTKFCgOqIutTtA56dXUJ5LbTyJ2EWfX/sGzWyRuGVz/IotrMVSNRg7p
   0w39ILMAeHXxXMEne1Tum4xonOBhIBxUT9Rh4zE+qmmnbigz2WDWYw2xj
   tZ5ZYYE8ZynzzqvQs5p0RitXE92zeD4vpq8AKX5UA3QhPJaoYnqBhF4KK
   nfTqicsJFBypoBMGTWkTJ5UBO0H0OV3cLqboWgUoABd8GV4jQuVAzdFRG
   A==;
X-CSE-ConnectionGUID: hHfd6ABFR4OdB89sxPLQhQ==
X-CSE-MsgGUID: /9G1DN9QRVuceKYGnm04PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11295"; a="35451239"
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="35451239"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2024 05:03:49 -0800
X-CSE-ConnectionGUID: qf520nabTS2xJoifRnOf5w==
X-CSE-MsgGUID: LMWRrNFAR5CwBx1HiPB24A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,257,1728975600"; 
   d="scan'208";a="99033688"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Dec 2024 05:03:47 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tPi65-0003bY-0Y;
	Mon, 23 Dec 2024 13:03:45 +0000
Date: Mon, 23 Dec 2024 21:02:58 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [viro-vfs:work.dcache 6/6] fs/libfs.c:1819:17: warning: comparison
 of distinct pointer types lacks a cast
Message-ID: <202412232059.54ry0khI-lkp@intel.com>
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
config: csky-randconfig-002-20241223 (https://download.01.org/0day-ci/archive/20241223/202412232059.54ry0khI-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241223/202412232059.54ry0khI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412232059.54ry0khI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/libfs.c: In function 'generic_ci_d_compare':
>> fs/libfs.c:1819:17: warning: comparison of distinct pointer types lacks a cast [-Wcompare-distinct-pointer-types]
    1819 |         if (str == dentry->d_shortname.string) {
         |                 ^~


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

